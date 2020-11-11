Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F832AF5B5
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 17:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgKKQDm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Nov 2020 11:03:42 -0500
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:37856 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726204AbgKKQDl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Nov 2020 11:03:41 -0500
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ABG1hlB028255;
        Wed, 11 Nov 2020 11:03:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=GnCb6aw6IYi3z43+NaWnlRB6Sp49QWSwyOmj4/e76PA=;
 b=O2p4TTOhLRcakcF7/EB4qMMuWRehinysJEDPC83DVJ7MLBKHEICvonay35bR3m38Bp7L
 eNMGOVbfIXzHTywvSDZN7gUzpcCgXNh7N85U5gUeYz6RwFMQJUqkJiux8BUOZl+iCREc
 tYzgbBGmLg8mhYgqPrpT3zwwgdEg6L55zfrC6tfQn6ts58Zuznoii2O366QJdJqBlr4J
 HPqygdR4F3PkFQWMTyWHKLKxQZZb7PnOtau49ukMv5toJMxSa+W5q+QKOWsp6UaKAju2
 FZ21mu5yQyy7kWw/rHt8aUSb6oVeCJ7b0RJbZVpnWrjC3p8OOjTA7xLfNgKh2DCn/K9+ Bg== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 34nqh751mn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Nov 2020 11:03:32 -0500
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ABG0uoI085488;
        Wed, 11 Nov 2020 11:03:32 -0500
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by mx0a-00154901.pphosted.com with ESMTP id 34qvdadkvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Nov 2020 11:03:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLJHyWd/ozQy1+Fe0z19k+49EOxZUX/O2bjWvQrtUW9BnlrpCOf+/Y1Pabu9pgB2qLvn06H0QYc6ftevqVhXrYRVW8rY2Owtu3qu5VB6qWJXep9l4wwbggunJU3lzNS8ZrpGvnp23ohv7QfqBaRM+2hN8PDq3oSnZIitCwPefHOZF5IIDFh4bp7TwplQJN4xI3eANNqYlU6hkDNO3feFT6saeOHRbxuNFXRKbbCDgUeM/bHS5IkhBdFyQQLArIdkDOkCi/j/k1Sbn6Me3209+haFSdvr+/RAk2sU+3dgRvjkGZn78UhQ/G+u6aLZn9DWDaBjY+reWj0CVfGP9nsMHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnCb6aw6IYi3z43+NaWnlRB6Sp49QWSwyOmj4/e76PA=;
 b=RFHEdUBPhIROfknbM+b9Szve17v1OVmkifba2C2iQSyV7SDyFDfpqOrKt8jQ9M3JaCSyu04q/FGz+ohMUybG0f8cRhiwvcpFjD1ed/IKhUY8K1cSqZyWIZVgkoIr4uplmrS0ApLjFhVNMsGcpBu8gqtQDgKFwMfmupRQJnOUuY4T442xrW2BrE9MDbq4LDXs6PhdXUdJw6ppp4oj6FfOxuiru02iCPezw0cNPRrEWHQgFIr6/z0z1Ibz16Eb7TPJ2Z0d3P1kE8uvtusy7RhRTDiMp/CRm7qqXxOAEX/WgfKzJt1FtKOm1hwbOas/jxYfRvvDqGjDAfMp4l2fahZI7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnCb6aw6IYi3z43+NaWnlRB6Sp49QWSwyOmj4/e76PA=;
 b=Xeow7651TFTm4LQmiNZMYL6fj2BQl//3MacLvR5EpL0XKZwjfASm4i6kLc+ULVVx6b7DCLKBxWFSvs+S47bd3/aPxhrv/yLQNff+2ad8mgCHUCe9tF9+AiqLUJ25klktdIjOR4vDnD1o0e2FHBZ8V6B5xc67P1YdzeoZKHVm3GQ=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM6PR19MB2331.namprd19.prod.outlook.com (2603:10b6:5:c0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Wed, 11 Nov
 2020 16:03:30 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a8ff:e803:ee80:e59a]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a8ff:e803:ee80:e59a%3]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 16:03:30 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Bastien Nocera <hadess@hadess.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: RE: How to enable auto-suspend by default
Thread-Topic: How to enable auto-suspend by default
Thread-Index: AQHWt1BE6l+LjsERUU+/FRV4X0h3ganBPDeAgABA9KCAACEegIABLmAAgABL7nA=
Date:   Wed, 11 Nov 2020 16:03:30 +0000
Message-ID: <DM6PR19MB26366008D59FC94D384A1E3BFAE80@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <fe8ab4cab3740afd261fa902f14ecae002a1122d.camel@hadess.net>
 <X6p6ubTOoMPUPPXi@kroah.com>
 <DM6PR19MB2636C94B56D5FBC0BD98A1B0FAE90@DM6PR19MB2636.namprd19.prod.outlook.com>
 <20201110172517.GC2495@lahna.fi.intel.com>
 <30957f1a-1fe5-5d9a-101b-25f12fb93907@redhat.com>
In-Reply-To: <30957f1a-1fe5-5d9a-101b-25f12fb93907@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-11-11T16:03:17.9999739Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=c6e39ea5-ff39-497e-bb04-96d171951d2b;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0343d4c1-c3dd-40f2-8f55-08d8865b5573
x-ms-traffictypediagnostic: DM6PR19MB2331:
x-microsoft-antispam-prvs: <DM6PR19MB2331FE521AC8A592CFBEEF82FAE80@DM6PR19MB2331.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BLfUbzms7DHXNVZVAXFVd6RjRF1uXAW5cjcVlYhmLQ2yYOy8NuQxVTw0wTm7sDD/7f3lGSA/BVic9cQs/7vc876AdQ0hA7aJKRCJ/PlyFwsTuwpBG3AG/lGnRX5zIVrjv31+RiM5AmXej6H2E4ubg0/zsVgB6QJqasrTlSB4yAW4DbXnkD+d5xwT5RA/16MZHzgQZ2JCSSjWVaZJXNED4DV305H1nBNEvGp1Gv/vx5MPaFC7jfizR8cVVk4CvHb5bIQvhmoxkNDCGa5os3t5DNg05kAYB6ch1YDpG1yPNSoorVlK/Ib49twSKnxG2+3TroTLhS2T+451OUYVycwXCHi+Dvxj6Lsds6SLyiliBjyL+QnfEOPpNux9WHBKLXFMB8dJC2c0edACBkcSEYe6og==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(55016002)(33656002)(64756008)(66476007)(478600001)(4326008)(8676002)(76116006)(7696005)(66446008)(8936002)(66946007)(6506007)(186003)(9686003)(316002)(2906002)(66556008)(26005)(5660300002)(54906003)(83380400001)(71200400001)(52536014)(86362001)(966005)(786003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: lk3mthtRb+Hqj1wVLX7qr7/+tlNCYw2JnUa4KQM6LainhO26tbfO7m1D+8esTX9Dg//K47RReKLWe7HGiDFqRcyfcaj6S0JJSEJidtnEef5ljf0/caXvcx907Mg9agj0oMIYi6d0CCsp0ZqNKqEU+kWy1dswZmJtynW4PpgmBrB/LSpHKNF1x0zvN+hMg3TFVhjAf7nh4IWi6vOQqEIDzQVX3YrR8CGZSe4LEdHwvxcXX0Vk1k4VHJ+zcF0/6h6FmVZlmM753RKRaaA28SnIK8aIvO7efWRJU9Q+eFCQi5PxTq1ljVq20eUZzO2bf6LkM2ePCjIrAB1GrHvHQr8U02H6EWH4k6+BUbvH/GWHJHjnnJrHYDQ1lhvkCAWDxsVxeFHksEiRFtD18aHKFClEMdq94c2fU7evIrjRwSwkB1nbamLStg8MsFJ31K/swWP8hCnDZZu7tmOyw19IUWjlpB0CsAGMw+i9WPSjlL6262n6xUkJ3Jn8QMiHAZ1muPxz5J/n7L8AEvsLAQsMiH4ZDZWlvU+KaUktgiImZbnkM4k+7qXt/+VlnRp3zDC235GZEEMzIkja+KnEPhkIwWn9yq9yivi/7KleyYy2IDe3VjzFfyl60EuS533wL7/m4i3VIS9Zk4jBWoY/vOtUVV0Q4A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0343d4c1-c3dd-40f2-8f55-08d8865b5573
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 16:03:30.5458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v2Bti5Lu/hETpIRJaMvb77afca33UPglhcAUPux52Xm2o+Zu8KfGoaxd6Dpsc3GvYtwMDbFyQhWaEA3iX3F0BJEL9cDWwTaO1WS+wBkbAm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB2331
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-11_07:2020-11-10,2020-11-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011110094
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011110094
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiA+PiBHaXZlbiB3ZSdyZSBlZmZlY3RpdmVseSBlbmRpbmcgdXAgd2l0aCB0aGUgY29tYmluYXRp
b24gb2YgcnVudGltZSBQTSB0dXJuZWQNCj4gPj4gb24gYnkgdWRldiBydWxlcywgZG8gd2UgbmVl
ZCBzb21ldGhpbmcgbGlrZSB0aGlzIGZvciB0aGF0IElEOg0KPiA+Pg0KPiA+Pg0KPiBodHRwczov
L2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvY29tbWl0LzZhN2M1MzNkNGExODU0ZjU0OTAxYTA2
NWQ4YzY3MmU4OTA0MDANCj4gZDhhDQo+ID4+DQo+ID4+IEBNaWthIFdlc3RlcmJlcmcgc2hvdWxk
IDgwODY6YTBlZCBiZSBxdWlya2VkIGxpa2UgdGhlIFRDU1MgeEhDSSB0b28/DQo+ID4NCj4gPiBJ
IHRoaW5rIHRoaXMgb25lIGlzIHRoZSBUR0wgUENIIHhIQ0kuIFRoZSBxdWlyayBjdXJyZW50bHkg
Zm9yIHhIQ0kNCj4gPiBjb250cm9sbGVycyB0aGF0IGFyZSBwYXJ0IG9mIHRoZSBUQ1NTIChUeXBl
LUMgU3ViU3lzdGVtKSB3aGVyZSBpdCBpcw0KPiA+IGltcG9ydGFudCB0byBwdXQgYWxsIGRldmlj
ZXMgaW50byBsb3cgcG93ZXIgbW9kZSB3aGVuZXZlciBwb3NzaWJsZSwNCj4gPiBvdGhlcndpc2Ug
aXQga2VlcHMgdGhlIHdob2xlIGJsb2NrIG9uLg0KPiANCj4gTm90ZSB0aGF0IHRoZXJlIGFyZSBj
dXJyZW50bHkgc29tZSBJRHMgbWlzc2luZyBmcm9tIHRoZSB4SENJcyB3aGljaA0KPiBhcmUgcGFy
dCBvZiB0aGUgVENTUyB0b28uIEF0IGxlYXN0IHRoZSBpZCBmb3IgdGhlIHhIQ0kgaW4gdGhlIHRo
dW5kZXJib2x0DQo+IGNvbnRyb2xsZXIgb24gdGhlIExlbm92byBUMTQgZ2VuIDEgaXMgbWlzc2lu
Zy4gSSBzdGFydGVkIGEgZGlzY3Vzc2lvbg0KPiBhYm91dCBleHRlbmRpbmcgdGhlIGtlcm5lbCBx
dWlyayBsaXN0IGZvciB0aGlzIHZzIHN3aXRjaGluZyB0byBod2RiDQo+IGEgd2hpbGUgYSBnbzoN
Cj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXVzYi9iOGIyMWJhMy0wYThhLWZm
NTQtNWUxMi0NCj4gY2Y4OTYwNjUxMDg2QHJlZGhhdC5jb20vDQo+IA0KPiBUaGUgY29uY2x1c2lv
biBiYWNrIHRoZW4gd2FzIHRvIHN3aXRjaCB0byBod2RiLCBidXQgSSBuZXZlciBnb3QgYXJvdW5k
IHRvDQo+IHRoaXMuDQoNCkkgZ3Vlc3MgdGhlIHByb2JsZW0gSSBzZWUgd2l0aCBzd2l0Y2hpbmcg
dG8gYSBod2RiIGZvciB0aGlzIHR5cGUgb2YgdGhpbmcgaXMNCnRoYXQgaWYgdGhlcmUgaXMgYSAi
YnVnIiBpbiB5b3VyIGtlcm5lbCBkcml2ZXIgYXJvdW5kIGF1dG9zdXNwZW5kIHlvdSB3aWxsDQp0
aGVuIGJlIHBvdGVudGlhbGx5IGNhdXNpbmcgaXQgdG8gb2NjdXIgbW9yZSByZWd1bGFybHkgb24g
YSBrZXJuZWwgdGhhdCBkaWRuJ3QNCm5lY2Vzc2FyaWx5IHBpY2sgdXAgdGhlIGZpeCBidXQgZG9l
cyBoYXZlIHRoZSBuZXdlciBod2RiLg0KDQpJIGRvbid0IGtub3cgaG93IGNvbW1vbiB0aGF0IHdp
bGwgcmVhbGx5IGJlIHRob3VnaC4NCg0KU2luY2UgTWlrYSBtZW50aW9uZWQgdGhlIHJlYWxseSBs
aWdodCB1c2Vyc3BhY2Ugc2NlbmFyaW8sIHdoYXQgYWJvdXQgc2hpcHBpbmcNCnRoZSBod2RiICJ3
aXRoIiB0aGUga2VybmVsIGluIHRyZWU/ICBUaGlzIGNvdWxkIGFsbG93IGV2aWN0aW5nIGFsbCB0
aGVzZSBxdWlyaw0Kc2NlbmFyaW9zIGZyb20gdGhlIGtlcm5lbCBhdCB0aGUgc2FtZSB0aW1lIGFz
IHN3aXRjaGluZyB0byBhIGh3ZGIgYW5kIGFsc28gY292ZXINCnRoZSBwcm9ibGVtIEkgc3VnZ2Vz
dGVkIG1pZ2h0IGhhcHBlbiB3aXRoIGEgYnVnIGluIG9sZGVyIGtlcm5lbCBhbmQgbmV3ZXIgdXNl
cnNwYWNlLg0KDQo+IA0KPiA+IFR5cGljYWxseSB3ZSBoYXZlbid0IGRvbmUgdGhhdCBmb3IgUENI
IHNpZGUgeEhDSSBjb250cm9sbGVycyB0aG91Z2gsIGJ1dA0KPiA+IEkgZG9uJ3Qgc2VlIHdoeSBu
b3QgaWYgaXQgd29ya3MgdGhhdCBpcy4gQWRkaW5nIE1hdGhpYXMgdG8gY29tbWVudCBtb3JlDQo+
ID4gb24gdGhhdCBzaW5jZSBoZSBpcyB0aGUgeEhDSSBtYWludGFpbmVyLg0KPiANCj4gSWYgd2Ug
YXJlIGFsc28gZ29pbmcgdG8gZW5hYmxlIHRoaXMgZm9yIHRoZSBub24gVENTUyBJbnRlbCBYSENJ
IGNvbnRyb2xsZXJzLA0KPiBtYXliZSBqdXN0IHVuY29uZHRpb25hbGx5IGVuYWJsZSBpdCBmb3Ig
YWxsIEludGVsIFhIQ0kgY29udHJvbGxlcnMsIG9yDQo+IGlmIG5lY2Vzc2FyeSBkbyBhIGRlbnkt
bGlzdCBmb3Igc29tZSBvbGRlciBtb2RlbHMgYW5kIGVuYWJsZSBpdCBmb3IgYW55dGhpbmcNCj4g
bm90IG9uIHRoZSBkZW55LWxpc3QgKHNvIGFsbCBuZXdlciBtb2RlbHMpLiBUaGF0IHNob3VsZCBh
dm9pZCB0aGUgZ2FtZSBvZg0KPiB3aGFjay1hLW1vbGUgd2hpY2ggd2Ugd2lsbCBoYXZlIHdpdGgg
dGhpcyBvdGhlcndpc2UuDQo+IA0KPiBOb3RlIHRoZSBkZW55LWxpc3QgKyBlbmFibGUgYW55dGhp
bmcgbm90IG9uIGl0IGFwcHJvYWNoIGNvdWxkIGJlIGRvbmUNCj4gZWl0aGVyIGluIHRoZSBrZXJu
ZWwgb3IgaW4gYSB1ZGV2LXJ1bGUgKyBod2RiIGNvbWJvLg0KPiANCj4gUmVnYXJkcywNCj4gDQo+
IEhhbnMNCg0K
