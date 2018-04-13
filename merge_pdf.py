# Written because manipulating PDFs was turning out to be harder than expected
from PyPDF2 import PdfFileWriter, PdfFileReader
 
def join_pdf(input,output):
    [output.addPage(input.getPage(page_num)) for page_num in range(input.numPages)]
    return(None);

output = PdfFileWriter()

# Grab pages from different documents
join_pdf(PdfFileReader(open("Patent.PDF","rb")),output)
join_pdf(PdfFileReader(open("Sign.pdf","rb")),output)
 
# add them to a new document.
output.write(open("CombinedPages.pdf","wb"))
