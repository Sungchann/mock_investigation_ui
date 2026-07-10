import 'package:flutter/material.dart';
import 'package:mock_investigation_case/core/data_discovery_lab_core/logger.dart';
import 'package:mock_investigation_case/core/data_discovery_lab_core/theme.dart';
class AddSourceDialog extends StatefulWidget {
  final String tribeName;

  const AddSourceDialog({
    super.key,
    required this.tribeName,
  });

  @override
  State<AddSourceDialog> createState() => _AddSourceDialog();

}

  class _AddSourceDialog extends State<AddSourceDialog>{
  
  String _tribeName = "";
  List<Map<String, dynamic>> _dropdownItems = [];
  Map<String, dynamic>? _selectedProvider;

  @override
  void initState(){
    super.initState();
    _tribeName = widget.tribeName;
    _dropdownItems = getProviders(_tribeName);

    if(_dropdownItems.isNotEmpty) {
      _selectedProvider = _dropdownItems.first;
    }
  }

  List<Map<String, dynamic>> getProviders(String name){
    if(name == "Enterprise"){
      return [
        {"providerKey": "M365", "name": "Microsoft 365", "logo" : "samplelogo"},
        {"providerKey": "GWS", "name": "Google Workspace"}
      ];
    } else if(name == "Personal"){
      return [
        {"providerKey": "M365", "name": "Microsoft 365"},
        {"providerKey": "GML", "name": "Gmail Personal"},
        {"providerKey": "none", "name": "One.com", "logo" : "assets/icons/collection_logo/isp/one_com.png"},
        {"providerKey": "none", "name": "Simply.com", "logo" : "assets/icons/collection_logo/isp/simply_com.png"},
        {"providerKey": "none", "name": "TDC Mail",  "logo" : "assets/icons/collection_logo/isp/TDC_logo.png"},
        {"providerKey": "none", "name": "Hetzner Mail",  "logo" : "assets/icons/collection_logo/isp/hezner.png"},
        {"providerKey": "IMAP", "name": "Custom IMAP"},
      ];
    } else if(name == "Drive"){
      return [
        {"providerKey": "none", "name": "Dropbox",  "logo" : "assets/icons/collection_logo/drives/dropbox.png"},
        {"providerKey": "none", "name": "Box",  "logo" : "assets/icons/collection_logo/drives/box.jpg"},
        {"providerKey": "none", "name": "iCloud Drive", "logo" : "assets/icons/collection_logo/drives/icloud-drive-2017-06-19.webp"},
      ];
    } else if(name == "Finance"){
      return [
        {"providerKey": "none", "name": "e-conomic", "logo" : "assets/icons/collection_logo/finance_logo/images.png"},
        {"providerKey": "none", "name": "Dinero", "logo" : "assets/icons/collection_logo/finance_logo/dinero.jpg"},
        {"providerKey": "none", "name": "Billy", "logo" : "assets/icons/collection_logo/finance_logo/billy.png"},
        {"providerKey": "BC", "name": "Business Central"},
      ];
    } else if(name == "Dump / Upload"){
      return [
        {"providerKey": "PST", "name": "Email archive (PST/MBOX)"},
        {"providerKey": "ZIP", "name": "File archive (ZIP/TAR)"},
        {"providerKey": "ADF", "name": "Mobile Forensic Image (ADF)"},
        {"providerKey": "BC", "name": "IMazing backup"},
      ];
    }
    return[{}];
  }

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    logger.i("tribe name  = $_tribeName");
    return Dialog(
          shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            width: 400,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column (
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:CrossAxisAlignment.start,
              children: [
                Text(
                  'Add source — $_tribeName',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  )
                ),
                SizedBox(height: 15),
                _customTextField(text: 'Provider'),
                SizedBox(height: 5),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 7,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: AppColor.grey,
                    )
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<Map<String, dynamic>>(
                      dropdownColor: Colors.white, 
                      isExpanded: true,
                      value: _selectedProvider,
                      icon: const Icon(Icons.arrow_drop_down),
                      items:_dropdownItems.map((Map<String, dynamic> item){
                        return DropdownMenuItem<Map<String, dynamic>>(
                          value: item,
                          child: Row(
                            children: [
                              if(item["providerKey"] != "none")...[
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: AppColor.greyLight,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                    child:  Text(
                                    item["providerKey"],
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: AppColor.greyDark,
                                      ),
                                  ),
                                )
                              ]else if(item["providerKey"] == "none")...[
                                Image.asset(
                                  item["logo"],
                                  width: 25,
                                  height: 25,
                                  fit: BoxFit.contain,
                                )
                              ],
                              SizedBox(width: 10),
                              Text(
                                item["name"],
                                style: const TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (Map<String, dynamic>? newValue) {
                        setState(() {
                          _selectedProvider = newValue;
                        });
                      },
                    ),
                  ),
                ),
                if(_tribeName == "Enterprise")...[
                SizedBox(height: 15),
                  _customTextField(text: 'Tenant Guid, doman, or admin email'),
                  SizedBox(height: 5),
                  _customField(
                    controller: controller, 
                    text: 'ddl@bbhs.dk or bbhs.dk or f485a193-...'
                    ),
                ],
                if(_tribeName == "Personal")...[
                SizedBox(height: 15),
                _customTextField(text: 'Email'),
                SizedBox(height: 5),
                _customField(
                    controller: controller, 
                    text: 'user@outlook.dk'
                    ),
                SizedBox(height: 2),
                Text(
                  'Sends consent request - collection starts when approved',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  )
                )
                ],
                if(_tribeName == "Finance")...[
                SizedBox(height: 15),
                  _customTextField(text: 'App secret token'),
                  SizedBox(height: 5),
                  _customField(
                    controller: controller, 
                    text: 'e-conomic app secret'
                    ),
                SizedBox(height: 15),
                  _customTextField(text: 'Agreement grant token'),
                  SizedBox(height: 5),
                  _customField(
                    controller: controller, 
                    text: 'Agreement grant token'
                    ),
                SizedBox(height: 15),
                  _customTextField(text: 'CVR (optional)'),
                  SizedBox(height: 5),
                  _customField(
                    controller: controller, 
                    text: '12345678'
                    ),
                ],
                if(_tribeName == "Enterprise" || _tribeName == "Drive" || _tribeName == "Finance" || _tribeName == "Dump / Upload")...[
                SizedBox(height: 15),
                  _customTextField(text: 'Subject / Label'),
                  SizedBox(height: 5),
                  _customField(
                      controller: controller, 
                      text: 'Optional display label'
                      ),
                  ],
                if(_tribeName == "Finance")...[
                SizedBox(height: 15),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _customTextField(text: 'From'),
                        SizedBox(height: 5),  
                        customDatePicker(controller: controller, text: '01/01/2024'),
                      ],
                    ),
                    SizedBox(width: 10),  
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _customTextField(text: 'To'),
                        SizedBox(height: 5),  
                        customDatePicker(controller: controller, text: '12/31/2025'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15),
                _customTextField(text: 'Test Connection'),
                ],
                SizedBox(height: 20),
                if(_tribeName != "Personal")...[
                  _customButtons(text: "Add Source"),
                ]else...[
                  _customButtons(text: "Send Consent"),
                ]
              ]
            )
          )
        );
  }

  Widget _customField ({required TextEditingController controller, required String text}) {
    return SizedBox(
      height: 44.0,
      child: TextField(
        controller: controller,
        style: TextStyle(color: AppColor.darkBlue, fontSize: 14.5),
        decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(color: AppColor.placeholder, fontWeight: FontWeight.w400),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide:  BorderSide(color: AppColor.borderGray, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide:  BorderSide(color: AppColor.primaryBlue, width: 1.5),
          ),
        ),
      ),
    );
  }

  Widget _customTextField ({required String text}){
    return Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 10,
          )
        );
  }

  Widget _customButtons ({required String text}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children : [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(
            foregroundColor: AppColor.labelGray,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            textStyle: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
          ),
          child: const Text('Cancel'),
        ),
        const SizedBox(width: 4.0),
        ElevatedButton(
          onPressed: () {
            // Action executions
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primaryBlue,
            foregroundColor: Colors.white,
            elevation: 0.0,
            shadowColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
            textStyle: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
          ),
          child: Text(text),
        ),
      ]
    );
  }
  Widget customDatePicker ({required TextEditingController controller, required text}) {
    return SizedBox(
      height: 44,
      width: 175,
      child: TextField(
      readOnly: true,
      decoration: InputDecoration(
        hintText: text,
      
        filled: true,
        fillColor: Color(0xFFF5F7FA),
      
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      
        suffixIcon: Icon(Icons.calendar_today, size: 18),
      
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
      
      onTap: () async {
        await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
      },
      ),
    );
  }
}