Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9797B1C826B
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 08:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgEGGUn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 02:20:43 -0400
Received: from mail-eopbgr40070.outbound.protection.outlook.com ([40.107.4.70]:45398
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725763AbgEGGUm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 7 May 2020 02:20:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHjXJKxVFgdqNn50SuUaTxcd82sNXxbG3mx3KQgxNOFuNvY/Xt8gaYmqLJCzO0IqWrg+fcUte+YFdqlXP3P8NgEnG44d5xz/v3psIKyCtwm28q6Wv8CEOLEEh3GxGouY97V1eYdrlAnEhxMEyAEwIpYdjdkhpREGw2EqzPUR8NxfTScwP77Jdo7eOV0miLWc7txLaSUDA+n1F222whtP7GdKnDLar0SqkV0T925hH14VpxJVDyJ/Zj2U5uJkBiBjFkQfIFyhEEDgDmOkazoYDjhhq64jjNW3cngxvF1AXx8VBTKrq+grgZcUkoKTlNhw30uBwG8fiysmU1+7ODqiow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyO2yXujx74N8FgysyCNeJX8kOSCOAdmsqVABZLKcZA=;
 b=A+Xs/RDCYglNyLtL6PX1DDY9L65qEi03idF+zT60Oy0bcH7uAPb3ZgRIIco9+w/3eZ4FS3nX04jfDnv3nis4fjttK1Fq8jdDhwkB3bqiz1L7stAqI2rSsICKVzPEhJ4QM/iuKCYYDDuEK3UknwYoLKFXvO49CF7k9Ix6wgbkE2afwmETPgMG/INUBLqHBXkTNV/WhMR6tQArOU4b1uMajy89Nqe4PW3oA63URA5z4vjh/e9lZeq7eHBLYJrhPTvAChhmZ24J+eWY0a1bABbj5irtrm9rch3v/FLgcYk3QNQX88J0b5jEsPp/wgww85Mdl0vHVXJvkMjfthrJJ5MRJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyO2yXujx74N8FgysyCNeJX8kOSCOAdmsqVABZLKcZA=;
 b=Bu1qIIMJ5O+WYX2PmxVYPHBMC7ttfvgSTEpSJ1OR+NZeE4tjoUvf4TFkh7E8mhuZWk0JsMBqbRiVxj2mIv20KUh+GY3SjOjcmbNYAI+/UfeN0sZVGhpKhnHnea2G4c0s1srpxKomdAyWzjV5ob/zVN5/Z6WqnDjhwjmodGjlywM=
Received: from DBBPR04MB6090.eurprd04.prod.outlook.com (2603:10a6:10:c4::22)
 by DBBPR04MB6170.eurprd04.prod.outlook.com (2603:10a6:10:c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Thu, 7 May
 2020 06:20:37 +0000
Received: from DBBPR04MB6090.eurprd04.prod.outlook.com
 ([fe80::107d:2130:2140:23ec]) by DBBPR04MB6090.eurprd04.prod.outlook.com
 ([fe80::107d:2130:2140:23ec%5]) with mapi id 15.20.2958.033; Thu, 7 May 2020
 06:20:37 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     Andy Tang <andy.tang@nxp.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] thermal: qoriq: Update the settings for TMUv2
Thread-Topic: [PATCH v2] thermal: qoriq: Update the settings for TMUv2
Thread-Index: AQHWE9T1oBx+6VlpcEKikHBaKEggH6icR4Wg
Date:   Thu, 7 May 2020 06:20:37 +0000
Message-ID: <DBBPR04MB60904584EBDB9E2577C5016CF3A50@DBBPR04MB6090.eurprd04.prod.outlook.com>
References: <20200416093940.34371-1-andy.tang@nxp.com>
In-Reply-To: <20200416093940.34371-1-andy.tang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cffdac0d-8e90-4970-bfb9-08d7f24ec260
x-ms-traffictypediagnostic: DBBPR04MB6170:|DBBPR04MB6170:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBBPR04MB617088C3DAD3DFF0C075DFC0F3A50@DBBPR04MB6170.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 03965EFC76
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hkLggWFWXO8G4gnJDsb//sYJ1YRpfH1sqHWxH9fHku+dlMHpq47PA3PIWvBKkYdu4tvCuMjZPpy4rDbUlQ+NZnLsestduy3iyQHWnYRgLkmgarF4IQ2TkwLq1UiWHQUflZFeknaZgWAktdUepOIH1jCuKwS7XdRKjVAEZd1c2EwNxfornTBkT1StD+cOtgldYAvn+gVVZ5hCS8X7akaMJMWSZnNLJFoFJx7nkk0+MoZ+oxb7lKorWg4+z4CBdIwZz1KUaONEKAgNlz5Byuc+w1YEBXhd2r7dwXQjQdSPusSEDRJh2h+enGGmjkqYI29m/DF1WqgIzKmyRYpVAVlCml8Wpp9hPdvhsM8guNS1sn4KRLkAFc0+Iw1RFLz03XfJdGqCHdMc4j3umTc+y6TLJj7mabktvUH8af8WvuTTkiiYSS/PigsJY7MeiWFVM0WHXsV/zCow8msIcmaG0yo2X3SS1MOP8MjAvf0ZmxK7GjFukurAXizKwSi58H8sITCCDtyiBm+yU3d5PVtr9vh25Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB6090.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(33430700001)(9686003)(15650500001)(33656002)(52536014)(66556008)(53546011)(6506007)(26005)(64756008)(7696005)(186003)(4326008)(66946007)(66446008)(2906002)(66476007)(8676002)(55016002)(76116006)(5660300002)(44832011)(478600001)(8936002)(33440700001)(54906003)(110136005)(71200400001)(86362001)(316002)(83280400001)(83320400001)(83300400001)(83290400001)(83310400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: S0ALT9fVD4XBAhoOJTN7wzVlWgkTK1veQ0tPSWjHQi8kAYiFGyoFrX8hWhNk0wKYnyvKlsywTAL5mjUcXMqs66HYjOC73odlaJAgHlKYMAoPfl5Pkhf9cL1TTS6HdsyyWEFbGguLhlq+1nJMFl3OJtn1AUunTdSiuRLCuMNlEsiNE4a71LxRsIuYenAgaoShzhXpeG4qBdkAl/qnyT3a1jxbs+a9lYknU7wbI461WYYhSuxvsp4AIja3JFIe91pBW+1Hp1GnE7XtDolXrUayas8Cm8l+3XNJbuhqP7hHil9HUYIxZgQneczSX3SJqfTeUgx19G7DwjOcF+Fqykb7cYOyNG/6JCbOqu8LcfODwGzX7DhWEJ+qe3IiG2I+agkp42b6vYDWo30tOS/xNgEpwxBIs4M9xOs1ZYgAjMjKOx08ljfcS2E74QTKguL6En6GGEKYwBHnZ8c6K1s/ooy4QTgsHgNPOLw/dIYAB+5XtUrXAUFcWC5AnygZ+3m+JbXJTIZKQ9nvt9CtHXYZgclYbXIh6bRycDOoCXF2E5qJUbm/APIsCQFsf0ehg5h8oBrEHHfgbeG+Kfyjz0YfZgC3b9P3IGA/sXHMNOgiOkHYw4/cIx4fMHtSYcC0YUFYsOkh8p/PDu80ZDbvptTz4la2xvIZUeZEIk9kkCvBkHsThRrYiFb+rIDVmOAzcz0sRbWLTpkZiBICG83lGwBopkYPuUQ2wS0nUypGUn9BFdot2v+IoPCDLpQSVgleeWfFXEi6Bnd/i40Uqjsw3uunFM84JYSPgZyzhOfEHY+Y+SDYOYs=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cffdac0d-8e90-4970-bfb9-08d7f24ec260
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2020 06:20:37.7946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fIvO0qDCqru1mSJKdGzjUWhZPVpBIHFvaq7xew9W8g+lK1whx/DP61eRNbvYEXHjOZW8cA1stXDmbxjAb+3QCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6170
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

UElORy4NCg0KQlIsDQpBbmR5DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogWXVhbnRpYW4gVGFuZyA8YW5keS50YW5nQG54cC5jb20+DQo+IFNlbnQ6IDIwMjDE6jTUwjE2
yNUgMTc6NDANCj4gVG86IHJ1aS56aGFuZ0BpbnRlbC5jb207IGVkdWJlenZhbEBnbWFpbC5jb207
IGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmcNCj4gQ2M6IGxpbnV4LXBtQHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgQW5keSBUYW5nDQo+IDxhbmR5LnRhbmdA
bnhwLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIHYyXSB0aGVybWFsOiBxb3JpcTogVXBkYXRlIHRo
ZSBzZXR0aW5ncyBmb3IgVE1VdjINCj4gDQo+IEZvciBUTVUgdjIsIFRNU0FSIHJlZ2lzdGVycyBu
ZWVkIHRvIGJlIHNldCBwcm9wZXJseSB0byBnZXQgdGhlIGFjY3VyYXRlDQo+IHRlbXBlcmF0dXJl
IHZhbHVlcy4NCj4gQWxzbyB0ZW1wZXJhdHVyZSByZWFkaW5nIG5lZWRzIHRvIGNvbnZlcnQgdG8g
ZGVncmVlIENlbHNpdXMgc2luY2UgaXQgaXMgaW4NCj4gZGVncmVlcyBLZWx2aW4uDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBZdWFudGlhbiBUYW5nIDxhbmR5LnRhbmdAbnhwLmNvbT4NCj4gLS0tDQo+
IHYyOg0KPiAJLSBjaGFuZ2UgdGhlIHRlbXAgaW4gbWlsbGljZWxzaXVzDQo+IA0KPiAgZHJpdmVy
cy90aGVybWFsL3FvcmlxX3RoZXJtYWwuYyB8IDE1ICsrKysrKysrKysrKysrLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3RoZXJtYWwvcW9yaXFfdGhlcm1hbC5jDQo+IGIvZHJpdmVycy90aGVybWFs
L3FvcmlxX3RoZXJtYWwuYyBpbmRleCAwMjhhNmJiZjc1ZGMuLmY2MzcxMTI3ZjcwNw0KPiAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy90aGVybWFsL3FvcmlxX3RoZXJtYWwuYw0KPiArKysgYi9kcml2
ZXJzL3RoZXJtYWwvcW9yaXFfdGhlcm1hbC5jDQo+IEBAIC0yMyw2ICsyMyw3IEBADQo+ICAjZGVm
aW5lIFRNVE1JUl9ERUZBVUxUCTB4MDAwMDAwMGYNCj4gICNkZWZpbmUgVElFUl9ESVNBQkxFCTB4
MA0KPiAgI2RlZmluZSBURVVNUjBfVjIJCTB4NTEwMDljMDANCj4gKyNkZWZpbmUgVE1TQVJBX1Yy
CQkweGUNCj4gICNkZWZpbmUgVE1VX1ZFUjEJCTB4MQ0KPiAgI2RlZmluZSBUTVVfVkVSMgkJMHgy
DQo+IA0KPiBAQCAtNTAsNiArNTEsOSBAQA0KPiAgCQkJCQkgICAgKiBTaXRlIFJlZ2lzdGVyDQo+
ICAJCQkJCSAgICAqLw0KPiAgI2RlZmluZSBUUklUU1JfVglCSVQoMzEpDQo+ICsjZGVmaW5lIFJF
R1NfVjJfVE1TQVIobikJKDB4MzA0ICsgMTYgKiAobikpCS8qIFRNVSBtb25pdG9yaW5nDQo+ICsJ
CQkJCQkqIHNpdGUgYWRqdXN0bWVudCByZWdpc3Rlcg0KPiArCQkJCQkJKi8NCj4gICNkZWZpbmUg
UkVHU19UVFJuQ1IobikJKDB4ZjEwICsgNCAqIChuKSkgLyogVGVtcGVyYXR1cmUgUmFuZ2Ugbg0K
PiAgCQkJCQkgICAqIENvbnRyb2wgUmVnaXN0ZXINCj4gIAkJCQkJICAgKi8NCj4gQEAgLTEwMCw3
ICsxMDQsMTEgQEAgc3RhdGljIGludCB0bXVfZ2V0X3RlbXAodm9pZCAqcCwgaW50ICp0ZW1wKQ0K
PiAgCQkJCSAgICAgMTAgKiBVU0VDX1BFUl9NU0VDKSkNCj4gIAkJcmV0dXJuIC1FTk9EQVRBOw0K
PiANCj4gLQkqdGVtcCA9ICh2YWwgJiAweGZmKSAqIDEwMDA7DQo+ICsJLyogRm9yIFRNVXYyLCB0
ZW1wZXJhdHVyZSByZWFkaW5nIGluIGRlZ3JlZXMgS2VsdmluICovDQo+ICsJaWYgKHFkYXRhLT52
ZXIgPT0gVE1VX1ZFUjEpDQo+ICsJCSp0ZW1wID0gKHZhbCAmIDB4ZmYpICogMTAwMDsNCj4gKwll
bHNlDQo+ICsJCSp0ZW1wID0gKCh2YWwgJiAweDFmZikgLSAyNzMpICogMTAwMDsNCj4gDQo+ICAJ
cmV0dXJuIDA7DQo+ICB9DQo+IEBAIC0xOTIsNiArMjAwLDggQEAgc3RhdGljIGludCBxb3JpcV90
bXVfY2FsaWJyYXRpb24oc3RydWN0IGRldmljZSAqZGV2LA0KPiANCj4gIHN0YXRpYyB2b2lkIHFv
cmlxX3RtdV9pbml0X2RldmljZShzdHJ1Y3QgcW9yaXFfdG11X2RhdGEgKmRhdGEpICB7DQo+ICsJ
aW50IGk7DQo+ICsNCj4gIAkvKiBEaXNhYmxlIGludGVycnVwdCwgdXNpbmcgcG9sbGluZyBpbnN0
ZWFkICovDQo+ICAJcmVnbWFwX3dyaXRlKGRhdGEtPnJlZ21hcCwgUkVHU19USUVSLCBUSUVSX0RJ
U0FCTEUpOw0KPiANCj4gQEAgLTIwMiw2ICsyMTIsOCBAQCBzdGF0aWMgdm9pZCBxb3JpcV90bXVf
aW5pdF9kZXZpY2Uoc3RydWN0DQo+IHFvcmlxX3RtdV9kYXRhICpkYXRhKQ0KPiAgCX0gZWxzZSB7
DQo+ICAJCXJlZ21hcF93cml0ZShkYXRhLT5yZWdtYXAsIFJFR1NfVjJfVE1UTUlSLA0KPiBUTVRN
SVJfREVGQVVMVCk7DQo+ICAJCXJlZ21hcF93cml0ZShkYXRhLT5yZWdtYXAsIFJFR1NfVjJfVEVV
TVIoMCksIFRFVU1SMF9WMik7DQo+ICsJCWZvciAoaSA9IDA7IGkgPCA3OyBpKyspDQo+ICsJCQly
ZWdtYXBfd3JpdGUoZGF0YS0+cmVnbWFwLCBSRUdTX1YyX1RNU0FSKGkpLA0KPiBUTVNBUkFfVjIp
Ow0KPiAgCX0NCj4gDQo+ICAJLyogRGlzYWJsZSBtb25pdG9yaW5nICovDQo+IEBAIC0yMTIsNiAr
MjI0LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCByZWdtYXBfcmFuZ2UgcW9yaXFfeWVzX3Jhbmdl
c1tdDQo+ID0gew0KPiAgCXJlZ21hcF9yZWdfcmFuZ2UoUkVHU19UTVIsIFJFR1NfVFNDRkdSKSwN
Cj4gIAlyZWdtYXBfcmVnX3JhbmdlKFJFR1NfVFRSbkNSKDApLCBSRUdTX1RUUm5DUigzKSksDQo+
ICAJcmVnbWFwX3JlZ19yYW5nZShSRUdTX1YyX1RFVU1SKDApLCBSRUdTX1YyX1RFVU1SKDIpKSwN
Cj4gKwlyZWdtYXBfcmVnX3JhbmdlKFJFR1NfVjJfVE1TQVIoMCksIFJFR1NfVjJfVE1TQVIoMTUp
KSwNCj4gIAlyZWdtYXBfcmVnX3JhbmdlKFJFR1NfSVBCUlIoMCksIFJFR1NfSVBCUlIoMSkpLA0K
PiAgCS8qIFJlYWQgb25seSByZWdpc3RlcnMgYmVsb3cgKi8NCj4gIAlyZWdtYXBfcmVnX3Jhbmdl
KFJFR1NfVFJJVFNSKDApLCBSRUdTX1RSSVRTUigxNSkpLA0KPiAtLQ0KPiAyLjE3LjENCg0K
