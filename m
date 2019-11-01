Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06301EC4F1
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 15:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfKAOqI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 10:46:08 -0400
Received: from mail-eopbgr10057.outbound.protection.outlook.com ([40.107.1.57]:36004
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727027AbfKAOqH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 1 Nov 2019 10:46:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgCY4VSxiBfe0nxoyK7gM8J+q8jpH1x9dEA7K9FNigmA25FgriYCDsfiFpG7QQL2z3hG1FKhOkSniuVygZHpXZSl/t1WzHyjPkRlzt6Dul+kNsAHEEjKaHFj+FTUijIN4g3Xkz2XZjCexTXY1pGO1NFmnTGTeqNH/HV/sacmUAkHQZXgnrm55B6sF7o5G7WMhhjX08TeU11+uSWE0EPhjdbsPjqOC1nNW8U5nHnRkzhTl7h6lk7bn0/nd4wwtnYBh6w6wqtxXUTFU8uXcpHyDy3walGtsOXgr8lVDZF6oMpj8a3awWrkD4dH44z/DnTpxJlYjDJFxYdfniATmMdRXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCg7+RHvDbqZuE4lw/Vml7wqgNz1jT4SNPyynf44TnY=;
 b=ki6u8kg9wFGT7owvxQCe81TQp2Pe3c29JB7s/9H3e9GCDxD8/X/FGDlhBAFfoa9fN9hGY91X95X2ci8asMZxDmRADd+Q8xSjpxFXyzPSfGwq5ui/pGAg0ydQsRT6vVLwXWknUMWpedJaqKuXQQLvCS81iebr3BizrNuJjkgSIlyBxyDU7LMnLkWDeBVELu8OvMIomtfvuT3zmeb28pW8ckQXJmKFca5l9DN6ltRjTaxpXbisqnWkezXIXVieJMYBWSp4ke5CynscsCWa5y9XUq68cipKqX4Lfmp8a1wmEqYI4KD0uTJI2week+Nb17pWiKmNgt+6yCaZxHpzEWE32Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCg7+RHvDbqZuE4lw/Vml7wqgNz1jT4SNPyynf44TnY=;
 b=ZvOvABecboO/Xc1/Me10mQ+eaYv5OmHaQ7lDCyy3lSivqufryT1vYEdavpoKQo7/ZGRQmZ863O1JXzMbDaSNDzlhtHghuF6uUiUvBRgqnw/OSiYAso3rzcRMVFuSLvW6HOlvchJcBWhIxzNkjWbKIKaYUdIrMDMaiCDyiTrxzIk=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5999.eurprd04.prod.outlook.com (20.178.123.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Fri, 1 Nov 2019 14:45:46 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2387.028; Fri, 1 Nov 2019
 14:45:46 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        =?utf-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v10 06/11] PM / QoS: Reorder pm_qos/freq_qos/dev_pm_qos
 structs
Thread-Topic: [PATCH v10 06/11] PM / QoS: Reorder pm_qos/freq_qos/dev_pm_qos
 structs
Thread-Index: AQHVkDL/wczWHixmPUi+OkzKva0yaQ==
Date:   Fri, 1 Nov 2019 14:45:45 +0000
Message-ID: <VI1PR04MB7023B0E36FF4C9180F6B7A6AEE620@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1572556786.git.leonard.crestez@nxp.com>
 <CGME20191031213442epcas1p41dc9214e98c05c634647ef06cdd0a7f3@epcas1p4.samsung.com>
 <254e9ed653c7d9d866a860673629d02351c1afd8.1572556786.git.leonard.crestez@nxp.com>
 <072ef916-1753-ddc9-0fe8-7704b85def7a@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f0508c1f-7cd9-4b87-d373-08d75eda2dc7
x-ms-traffictypediagnostic: VI1PR04MB5999:|VI1PR04MB5999:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5999D2BA8311B446135BB862EE620@VI1PR04MB5999.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(189003)(199004)(55674003)(229853002)(81166006)(66946007)(7696005)(256004)(14444005)(8676002)(7416002)(81156014)(71200400001)(76116006)(74316002)(71190400001)(66446008)(64756008)(33656002)(8936002)(7736002)(305945005)(99286004)(186003)(66556008)(55016002)(2906002)(66066001)(476003)(54906003)(91956017)(110136005)(5660300002)(53546011)(102836004)(316002)(6436002)(486006)(966005)(14454004)(6306002)(44832011)(26005)(9686003)(3846002)(6506007)(66476007)(76176011)(6246003)(446003)(478600001)(4326008)(52536014)(86362001)(6116002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5999;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ngovaIm5Ci209SAs7MuJ4rwWoT1cBw/tMK2QERR6mtsO+lEjXdWyCqitOO6Y4wK3TaUi56OyXojROtBEESTFgDIKaE8k5aLuRNdQHwQEUw7ru0P6Ea7mfNDLSaa39nOIvch9dU3WvAEB7gxs5/r2mgbeGiJp7jlNtnuMHPkwDf8QZCatTXRZJQ3GsuqnqLF8hIyBCt5EK9Ofp4eX0LrYsqYW9hn55FVESs/vP1swlclTqxQYGz7UMHJovyh5TqgjXM903UbNh57WoAWDt9G0mukJMaN7Ud+jk4yTnPa8PXrlWwUobIs1ZJzxd1Uz2xRCYp70ljAN/hPlFLMAbZ8U900Ey7lAlUnBQ7nglIrLeSka6HYvvQjEJyy31uRmA+pX/gMuWii5A+dofHNJO7HiiGtiiP9cyga/9YoHwDs3YXKqv1LH+iod/TPTQqbsoUT7i8c3EZj8zaXts3zYoNO6jobOWIbCnD8nFs391T6KV6s=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0508c1f-7cd9-4b87-d373-08d75eda2dc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 14:45:45.8434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ai+uIQqEjn4N9AjhgtPKlmQ14J14UjZWJQYynLj1IL2M+KQvTAyhdz3WWlEs6VJBURQpVmVfoly6RIDeKTJNyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5999
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gMDEuMTEuMjAxOSAwNDowNywgQ2hhbndvbyBDaG9pIHdyb3RlOgo+IEhpIExlb25hcmQsCj4g
Cj4gV2h5IGRvIHlvdSBhZGQgdGhlIG5ldyBwYXRjaGVzIG9uIHYxMCAocGF0Y2g2LzcvOCkKPiBp
biB0aGlzIHNlcmllcz8gSWYgeW91IHRoaW5rIHRoYXQgbmVlZCB0byB1cGRhdGUKPiB0aGUgcG1f
cW9zIGNvcmUsIHlvdSBoYXZlIHRvIHNlbmQgdGhlIG5ldyBwYXRjaHNldAo+IG9uIHNlcGFyYXRl
IG1haWwgdGhyZWFkLiBJdCBtYWtlIHRoZSBkaWZmaWN1bHQKPiB0byBtZXJnZSB0aGUgUE1fUW9T
IHN1cHBvcnQgb2YgZGV2ZnJlcS4KPiAKPiBQbGVhc2Ugc3BsaXQgb3V0IHRoZSBwYXRjaDYvNy84
IGZyb20gdGhpcyBzZXJpZXMuCgpVbmZvcnR1bmF0ZWx5IERFVl9QTV9RT1NfTUlOL01BWF9GUkVR
VUVOQ1kgd2FzIHJlbW92ZWQgd2hlbiBjcHVmcmVxIApzd2l0Y2hlZCBhd2F5OgoKICAgICBodHRw
czovL3BhdGNod29yay5rZXJuZWwub3JnL2NvdmVyLzExMTkzMDIxLwoKU3VwcG9ydCBmb3IgZnJl
cSBsaW1pdHMgaW4gUE0gUW9TIG5lZWRzIHRvIGJlIHJlc3RvcmVkLCBvdGhlcndpc2UgUE0gUW9T
IApmb3IgZGV2ZnJlcSBkb2Vzbid0IGV2ZW4gY29tcGlsZS4gSSBwb3N0ZWQgdGhlIHJlc3RvcmF0
aW9uIHNlcGFyYXRlbHk6CgogICAgIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvY292ZXIv
MTEyMTI4ODcvCgpJIGd1ZXNzIHdlIGNhbiB3YWl0IGZvciBSYWZhZWwgdG8gcmV2aWV3IHRoYXQ/
CgpXZSBjb3VsZCBhbHNvIGNvbnNpZGVyIG90aGVyIGFsdGVybmF0aXZlcyBzdWNoIGFzIHVzaW5n
ICJyYXciIFBNIFFvUyAKYWdncmVnYXRpb24gaW5zaWRlIGRldmZyZXEgYW5kIGFza2luZyBhbGwg
Y29uc3VtZXJzIHRvIGNhbGwgCmRldmZyZXEtc3BlY2lmaWMgQVBJcyBmb3IgZnJlcXVlbmN5IGNv
bnN0cmFpbnRzPwoKSW4gdGhlIG1lYW50aW1lIEkgY2FuIHBvc3QgdGhlIGRldmZyZXEgY2xlYW51
cHMgaW4gc2VwYXJhdGVseS4gd291bGQgCnRoYXQgaGVscD8KCj4gT24gMTkuIDExLiAxLiDsmKTs
oIQgNjozNCwgTGVvbmFyZCBDcmVzdGV6IHdyb3RlOgo+PiBUaGlzIGFsbG93cyBkZXZfcG1fcW9z
IHRvIGVtYmVkIGZyZXFfcW9zIHN0cnVjdHMsIHdoaWNoIGlzIGRvbmUgaW4gdGhlCj4+IG5leHQg
cGF0Y2guIFNlcGFyYXRlIGNvbW1pdCB0byBtYWtlIGl0IGVhc2llciB0byByZXZpZXcuCj4+Cj4+
IFNpZ25lZC1vZmYtYnk6IExlb25hcmQgQ3Jlc3RleiA8bGVvbmFyZC5jcmVzdGV6QG54cC5jb20+
Cj4+IC0tLQo+PiAgIGluY2x1ZGUvbGludXgvcG1fcW9zLmggfCA3NCArKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMzggaW5zZXJ0
aW9ucygrKSwgMzYgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L3BtX3Fvcy5oIGIvaW5jbHVkZS9saW51eC9wbV9xb3MuaAo+PiBpbmRleCBjMzVmZjIxZThhNDAu
LmE4ZTE0ODZlMzIwMCAxMDA2NDQKPj4gLS0tIGEvaW5jbHVkZS9saW51eC9wbV9xb3MuaAo+PiAr
KysgYi9pbmNsdWRlL2xpbnV4L3BtX3Fvcy5oCj4+IEBAIC00NywyNSArNDcsMTAgQEAgc3RydWN0
IHBtX3Fvc19yZXF1ZXN0IHsKPj4gICBzdHJ1Y3QgcG1fcW9zX2ZsYWdzX3JlcXVlc3Qgewo+PiAg
IAlzdHJ1Y3QgbGlzdF9oZWFkIG5vZGU7Cj4+ICAgCXMzMiBmbGFnczsJLyogRG8gbm90IGNoYW5n
ZSB0byA2NCBiaXQgKi8KPj4gICB9Owo+PiAgIAo+PiAtZW51bSBkZXZfcG1fcW9zX3JlcV90eXBl
IHsKPj4gLQlERVZfUE1fUU9TX1JFU1VNRV9MQVRFTkNZID0gMSwKPj4gLQlERVZfUE1fUU9TX0xB
VEVOQ1lfVE9MRVJBTkNFLAo+PiAtCURFVl9QTV9RT1NfRkxBR1MsCj4+IC19Owo+PiAtCj4+IC1z
dHJ1Y3QgZGV2X3BtX3Fvc19yZXF1ZXN0IHsKPj4gLQllbnVtIGRldl9wbV9xb3NfcmVxX3R5cGUg
dHlwZTsKPj4gLQl1bmlvbiB7Cj4+IC0JCXN0cnVjdCBwbGlzdF9ub2RlIHBub2RlOwo+PiAtCQlz
dHJ1Y3QgcG1fcW9zX2ZsYWdzX3JlcXVlc3QgZmxyOwo+PiAtCX0gZGF0YTsKPj4gLQlzdHJ1Y3Qg
ZGV2aWNlICpkZXY7Cj4+IC19Owo+PiAtCj4+ICAgZW51bSBwbV9xb3NfdHlwZSB7Cj4+ICAgCVBN
X1FPU19VTklUSUFMSVpFRCwKPj4gICAJUE1fUU9TX01BWCwJCS8qIHJldHVybiB0aGUgbGFyZ2Vz
dCB2YWx1ZSAqLwo+PiAgIAlQTV9RT1NfTUlOLAkJLyogcmV0dXJuIHRoZSBzbWFsbGVzdCB2YWx1
ZSAqLwo+PiAgIAlQTV9RT1NfU1VNCQkvKiByZXR1cm4gdGhlIHN1bSAqLwo+PiBAQCAtODgsMTAg
KzczLDQ4IEBAIHN0cnVjdCBwbV9xb3NfY29uc3RyYWludHMgewo+PiAgIHN0cnVjdCBwbV9xb3Nf
ZmxhZ3Mgewo+PiAgIAlzdHJ1Y3QgbGlzdF9oZWFkIGxpc3Q7Cj4+ICAgCXMzMiBlZmZlY3RpdmVf
ZmxhZ3M7CS8qIERvIG5vdCBjaGFuZ2UgdG8gNjQgYml0ICovCj4+ICAgfTsKPj4gICAKPj4gKwo+
PiArI2RlZmluZSBGUkVRX1FPU19NSU5fREVGQVVMVF9WQUxVRQkwCj4+ICsjZGVmaW5lIEZSRVFf
UU9TX01BWF9ERUZBVUxUX1ZBTFVFCSgtMSkKPj4gKwo+PiArZW51bSBmcmVxX3Fvc19yZXFfdHlw
ZSB7Cj4+ICsJRlJFUV9RT1NfTUlOID0gMSwKPj4gKwlGUkVRX1FPU19NQVgsCj4+ICt9Owo+PiAr
Cj4+ICtzdHJ1Y3QgZnJlcV9jb25zdHJhaW50cyB7Cj4+ICsJc3RydWN0IHBtX3Fvc19jb25zdHJh
aW50cyBtaW5fZnJlcTsKPj4gKwlzdHJ1Y3QgYmxvY2tpbmdfbm90aWZpZXJfaGVhZCBtaW5fZnJl
cV9ub3RpZmllcnM7Cj4+ICsJc3RydWN0IHBtX3Fvc19jb25zdHJhaW50cyBtYXhfZnJlcTsKPj4g
KwlzdHJ1Y3QgYmxvY2tpbmdfbm90aWZpZXJfaGVhZCBtYXhfZnJlcV9ub3RpZmllcnM7Cj4+ICt9
Owo+PiArCj4+ICtzdHJ1Y3QgZnJlcV9xb3NfcmVxdWVzdCB7Cj4+ICsJZW51bSBmcmVxX3Fvc19y
ZXFfdHlwZSB0eXBlOwo+PiArCXN0cnVjdCBwbGlzdF9ub2RlIHBub2RlOwo+PiArCXN0cnVjdCBm
cmVxX2NvbnN0cmFpbnRzICpxb3M7Cj4+ICt9Owo+PiArCj4+ICsKPj4gK2VudW0gZGV2X3BtX3Fv
c19yZXFfdHlwZSB7Cj4+ICsJREVWX1BNX1FPU19SRVNVTUVfTEFURU5DWSA9IDEsCj4+ICsJREVW
X1BNX1FPU19MQVRFTkNZX1RPTEVSQU5DRSwKPj4gKwlERVZfUE1fUU9TX0ZMQUdTLAo+PiArfTsK
Pj4gKwo+PiArc3RydWN0IGRldl9wbV9xb3NfcmVxdWVzdCB7Cj4+ICsJZW51bSBkZXZfcG1fcW9z
X3JlcV90eXBlIHR5cGU7Cj4+ICsJdW5pb24gewo+PiArCQlzdHJ1Y3QgcGxpc3Rfbm9kZSBwbm9k
ZTsKPj4gKwkJc3RydWN0IHBtX3Fvc19mbGFnc19yZXF1ZXN0IGZscjsKPj4gKwl9IGRhdGE7Cj4+
ICsJc3RydWN0IGRldmljZSAqZGV2Owo+PiArfTsKPj4gKwo+PiAgIHN0cnVjdCBkZXZfcG1fcW9z
IHsKPj4gICAJc3RydWN0IHBtX3Fvc19jb25zdHJhaW50cyByZXN1bWVfbGF0ZW5jeTsKPj4gICAJ
c3RydWN0IHBtX3Fvc19jb25zdHJhaW50cyBsYXRlbmN5X3RvbGVyYW5jZTsKPj4gICAJc3RydWN0
IHBtX3Fvc19mbGFncyBmbGFnczsKPj4gICAJc3RydWN0IGRldl9wbV9xb3NfcmVxdWVzdCAqcmVz
dW1lX2xhdGVuY3lfcmVxOwo+PiBAQCAtMjUzLDMxICsyNzYsMTAgQEAgc3RhdGljIGlubGluZSBz
MzIgZGV2X3BtX3Fvc19yYXdfcmVzdW1lX2xhdGVuY3koc3RydWN0IGRldmljZSAqZGV2KQo+PiAg
IHsKPj4gICAJcmV0dXJuIFBNX1FPU19SRVNVTUVfTEFURU5DWV9OT19DT05TVFJBSU5UOwo+PiAg
IH0KPj4gICAjZW5kaWYKPj4gICAKPj4gLSNkZWZpbmUgRlJFUV9RT1NfTUlOX0RFRkFVTFRfVkFM
VUUJMAo+PiAtI2RlZmluZSBGUkVRX1FPU19NQVhfREVGQVVMVF9WQUxVRQkoLTEpCj4+IC0KPj4g
LWVudW0gZnJlcV9xb3NfcmVxX3R5cGUgewo+PiAtCUZSRVFfUU9TX01JTiA9IDEsCj4+IC0JRlJF
UV9RT1NfTUFYLAo+PiAtfTsKPj4gLQo+PiAtc3RydWN0IGZyZXFfY29uc3RyYWludHMgewo+PiAt
CXN0cnVjdCBwbV9xb3NfY29uc3RyYWludHMgbWluX2ZyZXE7Cj4+IC0Jc3RydWN0IGJsb2NraW5n
X25vdGlmaWVyX2hlYWQgbWluX2ZyZXFfbm90aWZpZXJzOwo+PiAtCXN0cnVjdCBwbV9xb3NfY29u
c3RyYWludHMgbWF4X2ZyZXE7Cj4+IC0Jc3RydWN0IGJsb2NraW5nX25vdGlmaWVyX2hlYWQgbWF4
X2ZyZXFfbm90aWZpZXJzOwo+PiAtfTsKPj4gLQo+PiAtc3RydWN0IGZyZXFfcW9zX3JlcXVlc3Qg
ewo+PiAtCWVudW0gZnJlcV9xb3NfcmVxX3R5cGUgdHlwZTsKPj4gLQlzdHJ1Y3QgcGxpc3Rfbm9k
ZSBwbm9kZTsKPj4gLQlzdHJ1Y3QgZnJlcV9jb25zdHJhaW50cyAqcW9zOwo+PiAtfTsKPj4gLQo+
PiAgIHN0YXRpYyBpbmxpbmUgaW50IGZyZXFfcW9zX3JlcXVlc3RfYWN0aXZlKHN0cnVjdCBmcmVx
X3Fvc19yZXF1ZXN0ICpyZXEpCj4+ICAgewo+PiAgIAlyZXR1cm4gIUlTX0VSUl9PUl9OVUxMKHJl
cS0+cW9zKTsKPj4gICB9Cj4+ICAgCj4+Cj4gCj4gCgo=
