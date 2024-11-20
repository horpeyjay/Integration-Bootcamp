public with sharing class XMLexamples {
    public static void parseXML(){
        StaticResource st = [SELECT Id, Name, Body FROM StaticResource WHERE Name = : 'xmlexample' LIMIT 1];
        
        dom.Document doc = new Dom.Document();
        doc.load(st.Body.toString());

        dom.XmlNode rootNode = doc.getRootElement();
        String rootNodeName = rootNode.getName();
        System.debug('The root node is ' + rootNodeName);

        List<dom.XmlNode> childNodeList = rootNode.getChildElements();
        for (dom.XmlNode childNode : childNodeList) {
            System.debug('The child node is ' + childNode.getName());
            if (childNode.getName() == 'records') {
                List<dom.XmlNode> recordNodes = childNode.getChildElements();
                for (dom.XmlNode recordNode : recordNodes) {
                    System.debug('Record node: ' + recordNode.getName());
                    
                    List<dom.XmlNode> recordChildNodes = recordNode.getChildElements();
                    for (dom.XmlNode recordChild : recordChildNodes) {
                        System.debug('Record field: ' + recordChild.getName() + ' = ' + recordChild.getText());
                    }
                }
            }
        }
    }

    public static void parseXMLAttributes(){
        StaticResource st = [SELECT Id, Name, Body FROM StaticResource WHERE Name = : 'xmlexamplewithattributes' LIMIT 1];

        dom.Document doc = new dom.Document();
        doc.load(st.Body.toString());

        dom.XmlNode rootNode = doc.getRootElement();
        String rootNodeName = rootNode.getName();
        System.debug('The root node is ' + rootNodeName);

        List<dom.XmlNode> childNodes = rootNode.getChildElements();
        for(dom.XmlNode childNode : childNodes){
            if(childNode.getName() == 'records'){
                List<dom.XmlNode> recordNode = childNode.getChildElements();
                for(dom.XmlNode record : recordNode){
                    if(record.getName() == 'record'){
                        List<dom.XmlNode> recordChildNode = record.getChildElements();
                        for(dom.XmlNode recordChild : recordChildNode){
                            if(recordChild.getName() == 'attributes'){
                                Integer attributeCount = recordChild.getAttributeCount();
                                System.debug('The record has ' + attributeCount + ' attributes');
                                String attributeName = recordChild.getAttributeKeyAt(2);
                                system.debug('Attribute Name : ' + attributeName);
                                String attributeNameSpace = recordChild.getAttribute('LoginType', null);
                                System.debug('The value at position 3 is ' + attributeNameSpace);
                                String attributeNameSpace1 = recordChild.getAttributeValue('LoginType', null);
                                System.debug('The value at position 3 is ' + attributeNameSpace1);

                            }
                        }
                    }
                }

            }
        }
    }
}
