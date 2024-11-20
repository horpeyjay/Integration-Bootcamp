public with sharing class NewsXMLParser {
    public static void parsingXMLForNews(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://timesofindia.indiatimes.com/rssfeeds/66949542.cms');
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        String xmlBody = response.getBody();
        Dom.Document doc = new Dom.Document();
        doc.load(xmlBody);

        //get root element
        dom.XmlNode root = doc.getRootElement();
        List<Dom.XmlNode> childrenNodes = root.getChildElements();
        dom.XmlNode channel = childrenNodes.get(0);

        List<dom.XmlNode> newsItemNodes = channel.getChildElements();
        for(dom.XmlNode newsItemNode : newsItemNodes){
            if(newsItemNode.getName() == 'item'){
                List<dom.XmlNode> itemsChildrensList = newsItemNode.getChildElements();
                for(dom.XmlNode itemsChildren : itemsChildrensList){
                    system.debug(itemsChildren.getName() + ' : ' +itemsChildren.getText());
                }
            }
        }
    }
}