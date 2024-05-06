import { LightningElement, api } from 'lwc';
import getVersionFiles from '@salesforce/apex/CreditFormController.getVersionFiles';

export default class CreditFileDisplay extends LightningElement {
    creditRecord; // Assuming this is passed from parent component
    files = [];

    connectedCallback() {
        let currentUrl = window.location.href;
        console.log('Current URL:', currentUrl);
        if (currentUrl.includes('Id=')) {
            let id = currentUrl.split('=')[1];
            console.log('ID:', id);
            this.creditRecord= id;
            console.log('creditRecord is:', this.creditRecord);
            this.loadFileVersions(); // Call the method only if ID is found
        } else {
            console.log('ID not found in the URL.');
        }
    }
    

    loadFileVersions() {
        console.log('The record id is',this.creditRecord );
        getVersionFiles({recordId:this.creditRecord})
            .then(result => {
                console.log('result',result)
                console.log('result length',result.length)
                if (result && result.length > 0) {
                    this.files = result.map(fileData => ({
                        Id: fileData.Id,
                        Title: fileData.Title,
                        Extension: fileData.FileExtension,
                        ContentDocumentId: fileData.ContentDocumentId,
                        ContentDocument: fileData.ContentDocument,
                        CreatedDate: fileData.CreatedDate,
                        thumbnailFileCard: `/creditapp/sfc/servlet.shepherd/version/renditionDownload?rendition=THUMB720BY480&versionId=${fileData.Id}&operationContext=CHATTER&contentId=${fileData.ContentDocumentId}`,
                        downloadUrl: `/creditapp/sfc/servlet.shepherd/document/download/${fileData.ContentDocumentId}`
                    }));
                } else {
                    // Handle case when no file versions found
                    console.log('No file versions found.');
                }
            })
            .catch(error => {
                // Handle error
                console.error('Error fetching file versions:', error);
            });
    }
}