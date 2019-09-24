Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57ED6BBFA4
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2019 03:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388305AbfIXBRj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Sep 2019 21:17:39 -0400
Received: from mail-eopbgr80078.outbound.protection.outlook.com ([40.107.8.78]:10374
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728738AbfIXBRj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Sep 2019 21:17:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CW9T/i/OqVl+9MktMNLMB/JCELykq4NjENk7mDsG+FTFKbmDNNZnYEOecD3LVf0xBOzeEdbHhvUUoS+2TS2lfJIncFJ0J4EH/t7INJeGMzo88KJzcAUp9D38wemVfas1+EGWtCgojWLXddXi1htQtPjnZFfTLNNUtGDETKyS7VELL7ZRgGT4sIwdAGaDNZlFC0M5QGfdcJX+oOY3WDJcnFrfGHTu69HGaivqzuICo08rrr8OHwFWurILO+rwwh8F9I/JWgBmQtPOIsPosyqKjuORzGSWX5wm9BLYPMA3HHGovsI3RqP81dr284k8Fygt3bSKVHj72QBux9pGwh1bVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZUCsnbDUTSbUPuKovihMJX57Zs3NdYTpgQVhHoOK4o=;
 b=i4TxuWFa3I93N1pFJbcywMT+/62Y3Ibra4S+72vKBCIhpsK2qD1U95tT1qza8CArtkgbVNLF4VagvgzarhwCigiqlDIZHg8krxAVhS3IitmNH14n7hJZ/Py7+rS6c59wcWCM5hXubDzEauFE6ilavJai6kEQtYsU4jG/paN+MfQY+qk36uHcY8NJrJxI3hI9aT1Rjn1/AYWXvV7n8LsKEirtQaUh5Fy95SZf4aNTzvfTsE6mgPSNJiGPXXV1zT9rakXA0ATXkScOo7pKnoZ8TAFRC2prLJFxbQgDNVyYLXOOsr+BNldR5B+q7q9p1UYXwOqCRrdSrBZA/wLciip9tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZUCsnbDUTSbUPuKovihMJX57Zs3NdYTpgQVhHoOK4o=;
 b=O+2r1JITcgEzO1v1KSx6GNt2Bf1L7inJie3ZQ+nIaL0SVadOXvQvyjIcFu37mm/S2l9smtm5PvWYtvzCt3C/Qm/4MaPNVRtI1b/YMx5ZWRwu40/+OQ2CDzuVpswNQN5z1eGwE5Xm/enoW6Tp/M8tVY+acFs2YHIcMUYzrQlQk+4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3834.eurprd04.prod.outlook.com (52.134.71.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Tue, 24 Sep 2019 01:17:30 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 01:17:30 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Zhang Rui <rui.zhang@intel.com>, Andy Tang <andy.tang@nxp.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>
CC:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] thermal: qoriq: add thermal monitor unit version 2
 support
Thread-Topic: [PATCH] thermal: qoriq: add thermal monitor unit version 2
 support
Thread-Index: AQHVcnC1YawFl+qX0EuVFj4v1o8yBKc5/x4w
Date:   Tue, 24 Sep 2019 01:17:29 +0000
Message-ID: <DB3PR0402MB3916F5DFF6D2C35FEFEA9F4DF5840@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190604025114.46085-1-andy.tang@nxp.com>
         <VI1PR04MB433382A830BE0857134ABF5BF3D50@VI1PR04MB4333.eurprd04.prod.outlook.com>
         <VI1PR04MB4333D4FAA6F25AD30CADF0D4F3A20@VI1PR04MB4333.eurprd04.prod.outlook.com>
         <VI1PR04MB433332B34EF758457365AE91F3850@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <d4c45941ef2ebbc4ac11ce199e3e8ae527a34df9.camel@intel.com>
In-Reply-To: <d4c45941ef2ebbc4ac11ce199e3e8ae527a34df9.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0bdea75-62ff-4d3e-86cd-08d7408cf865
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3834;
x-ms-traffictypediagnostic: DB3PR0402MB3834:|DB3PR0402MB3834:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB38346FD891CEC84A2F660CD7F5840@DB3PR0402MB3834.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(189003)(199004)(13464003)(33656002)(71200400001)(186003)(53546011)(6506007)(446003)(76176011)(6436002)(316002)(7696005)(5660300002)(26005)(54906003)(99286004)(86362001)(25786009)(3846002)(55016002)(6116002)(81166006)(30864003)(229853002)(8936002)(52536014)(102836004)(110136005)(256004)(14444005)(476003)(66066001)(71190400001)(66946007)(81156014)(2501003)(4326008)(9686003)(2906002)(11346002)(76116006)(66476007)(14454004)(66556008)(478600001)(7736002)(486006)(305945005)(6246003)(66446008)(44832011)(64756008)(74316002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3834;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CSvzfiA+r/rErDkgD56CUPMVnD31XkWch16Sd1t7JZ+AJOzcUPx2AlMTZbf5taXAH/pzy8iIiqB43cuEzvjVkqAMKnTq+Dndn9gDC0yfh50ySaAlpDRKimvzLN7hzccpgC/hMMeaYYBaLijUoBaRqVNWbB0merrrDRoRXCoCheb8hnQ66MSfPvztam0oRSz2gVjNP62YCUjECyIwybHrYCGANvyKbdOv7j6jOFB523VxfTXiwlo+SqMV+m4ZrYm7H1KLs/F3ouOJFJ9tmYYDYWKftWvZElHIAKUfOAOvUpCp0u8RfCQ5+bYm+wMY6JC/ElyUpU+xNzWWd0IACnFCOLbiu7sBcsKehgR53wmO/uxe9uVQhPIf3SYsJmvM5/+gFlE91Fds6QBSHtMej4uw/m9EwnU8IBUlf/asaapWOkg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0bdea75-62ff-4d3e-86cd-08d7408cf865
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 01:17:30.0958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7aA9M7tPK9lsQUISZQ7TK2PK2OC0ea6BPHbOU1YKgZoSSMQ31CXvXb4JXiEpdPp/2rHzKBgacfSn4Fn+i8heWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3834
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIEFuZHkNCg0KDQo+IE9uIE1vbiwgMjAxOS0wOS0yMyBhdCAwOToyNCArMDAwMCwgQW5keSBU
YW5nIHdyb3RlOg0KPiA+IEhpIFJ1aSwgRWR1YmV6dmFsLA0KPiA+DQo+ID4gV291bGQgeW91IHBs
ZWFzZSByZXZpZXcgdGhpcyBwYXRjaD8NCj4gPg0KPiBDQyBBbnNvbiBIdWFuZy4NCj4gSSdkIHBy
ZWZlciBhbGwgdGhlIHFvcmlxIHRoZXJtYWwgcGF0Y2hlcyBnbyB0aHJvdWdoIGhpcyByZXZpZXcg
Zmlyc3QuDQo+IA0KPiB0aGFua3MsDQo+IHJ1aQ0KPiANCj4gPiBCUiwNCj4gPiBBbmR5DQo+ID4N
Cj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBBbmR5IFRhbmcN
Cj4gPiA+IFNlbnQ6IDIwMTnlubQ45pyIMjnml6UgMTY6MzgNCj4gPiA+IFRvOiAnZWR1YmV6dmFs
QGdtYWlsLmNvbScgPGVkdWJlenZhbEBnbWFpbC5jb20+Ow0KPiA+ID4gJ3J1aS56aGFuZ0BpbnRl
bC5jb20nDQo+ID4gPiA8cnVpLnpoYW5nQGludGVsLmNvbT4NCj4gPiA+IENjOiAnZGFuaWVsLmxl
emNhbm9AbGluYXJvLm9yZycgPGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+OyBMZW8gTGkNCj4g
PiA+IDxsZW95YW5nLmxpQG54cC5jb20+OyAnbGludXgtcG1Admdlci5rZXJuZWwub3JnJw0KPiA+
ID4gPGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz47ICdsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnJw0KPiA+ID4gPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+ID4gPiBTdWJqZWN0
OiBSRTogW1BBVENIXSB0aGVybWFsOiBxb3JpcTogYWRkIHRoZXJtYWwgbW9uaXRvciB1bml0DQo+
ID4gPiB2ZXJzaW9uIDIgc3VwcG9ydA0KPiA+ID4NCj4gPiA+IEhpIFJ1aSwgRWR1YmV6dmFsLA0K
PiA+ID4NCj4gPiA+IEFsbW9zdCB0aHJlZSBtb250aGVzIHBhc3NlZCwgSSBoYXZlIG5vdCBnb3Qg
eW91ciBjb21tZW50cyBmcm9tIHlvdS4NCj4gPiA+IENvdWxkIHlvdSBwbGVhc2UgdGFrZSBhIGxv
b2sgYXQgdGhpcyBwYXRjaD8NCj4gPiA+DQo+ID4gPiBCUiwNCj4gPiA+IEFuZHkNCj4gPiA+DQo+
ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+IEZyb206IEFuZHkgVGFu
Zw0KPiA+ID4gPiBTZW50OiAyMDE55bm0OOaciDbml6UgMTA6NTcNCj4gPiA+ID4gVG86IGVkdWJl
enZhbEBnbWFpbC5jb207IHJ1aS56aGFuZ0BpbnRlbC5jb20NCj4gPiA+ID4gQ2M6IGRhbmllbC5s
ZXpjYW5vQGxpbmFyby5vcmc7IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsNCj4gPiA+ID4g
bGludXgtcG1Admdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
ID4gPiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIHRoZXJtYWw6IHFvcmlxOiBhZGQgdGhlcm1hbCBt
b25pdG9yIHVuaXQNCj4gPiA+ID4gdmVyc2lvbg0KPiA+ID4gPiAyIHN1cHBvcnQNCj4gPiA+ID4N
Cj4gPiA+ID4gQW55IGNvbW1lbnRzPw0KPiA+ID4gPg0KPiA+ID4gPiBCUiwNCj4gPiA+ID4gQW5k
eQ0KPiA+ID4gPg0KPiA+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+
ID4gRnJvbTogWXVhbnRpYW4gVGFuZyA8YW5keS50YW5nQG54cC5jb20+DQo+ID4gPiA+ID4gU2Vu
dDogMjAxOeW5tDbmnIg05pelIDEwOjUxDQo+ID4gPiA+ID4gVG86IGVkdWJlenZhbEBnbWFpbC5j
b207IHJ1aS56aGFuZ0BpbnRlbC5jb20NCj4gPiA+ID4gPiBDYzogZGFuaWVsLmxlemNhbm9AbGlu
YXJvLm9yZzsgTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+Ow0KPiA+ID4gPiA+IGxpbnV4LXBt
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgQW5keQ0KPiA+
ID4gPiA+IFRhbmcgPGFuZHkudGFuZ0BueHAuY29tPg0KPiA+ID4gPiA+IFN1YmplY3Q6IFtQQVRD
SF0gdGhlcm1hbDogcW9yaXE6IGFkZCB0aGVybWFsIG1vbml0b3IgdW5pdA0KPiA+ID4gPiA+IHZl
cnNpb24gMiBzdXBwb3J0DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGVybWFsIE1vbml0b3IgVW5p
dCB2MiBpcyBpbnRyb2R1Y2VkIG9uIG5ldyBMYXlzY2FwZSBTb0MuDQo+ID4gPiA+ID4gQ29tcGFy
ZWQgdG8gdjEsIFRNVXYyIGhhcyBhIGxpdHRsZSBkaWZmZXJlbnQgcmVnaXN0ZXIgbGF5b3V0IGFu
ZA0KPiA+ID4gPiA+IGRpZ2l0YWwgb3V0cHV0IGlzIGZhaXJseSBsaW5lYXIuDQo+ID4gPiA+ID4N
Cj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBZdWFudGlhbiBUYW5nIDxhbmR5LnRhbmdAbnhwLmNv
bT4NCj4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiAgZHJpdmVycy90aGVybWFsL3FvcmlxX3RoZXJt
YWwuYyB8IDEyMg0KPiA+ID4gPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tDQo+
ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA5OCBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMo
LSkNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwvcW9y
aXFfdGhlcm1hbC5jDQo+ID4gPiA+ID4gYi9kcml2ZXJzL3RoZXJtYWwvcW9yaXFfdGhlcm1hbC5j
IGluZGV4DQo+ID4gPiA+ID4gM2I1ZjViM2ZiMWJjLi4wZGY2ZGZkZGY4MDQNCj4gPiA+ID4gPiAx
MDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3RoZXJtYWwvcW9yaXFfdGhlcm1hbC5jDQo+
ID4gPiA+ID4gKysrIGIvZHJpdmVycy90aGVybWFsL3FvcmlxX3RoZXJtYWwuYw0KPiA+ID4gPiA+
IEBAIC0xMyw2ICsxMywxNSBAQA0KPiA+ID4gPiA+ICAjaW5jbHVkZSAidGhlcm1hbF9jb3JlLmgi
DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAgI2RlZmluZSBTSVRFU19NQVgJMTYNCj4gPiA+ID4gPiAr
I2RlZmluZSBUTVJfRElTQUJMRQkweDANCj4gPiA+ID4gPiArI2RlZmluZSBUTVJfTUUJCTB4ODAw
MDAwMDANCj4gPiA+ID4gPiArI2RlZmluZSBUTVJfQUxQRgkweDBjMDAwMDAwDQo+ID4gPiA+ID4g
KyNkZWZpbmUgVE1SX0FMUEZfVjIJMHgwMzAwMDAwMA0KPiA+ID4gPiA+ICsjZGVmaW5lIFRNVE1J
Ul9ERUZBVUxUCTB4MDAwMDAwMGYNCj4gPiA+ID4gPiArI2RlZmluZSBUSUVSX0RJU0FCTEUJMHgw
DQo+ID4gPiA+ID4gKyNkZWZpbmUgVEVVTVIwX1YyCTB4NTEwMDlDMDANCg0KQmV0dGVyIHRvIHVz
ZSBlaXRoZXIgbG93ZXIgY2FzZSBvciBjYXBpdGFsIGxldHRlciBmb3IgYWxsIG1hY3JvIGRlZmlu
aXRpb25zLA0Kc29tZSBhcmUgbG93ZXIgY2FzZSBhbmQgc29tZSBhcmUgY2FwaXRhbCBsZXR0ZXIg
bG9vayBsaWtlIE5PVCBhbGlnbmVkLg0KDQo+ID4gPiA+ID4gKyNkZWZpbmUgVE1VX1ZFUjEJMHgx
DQo+ID4gPiA+ID4gKyNkZWZpbmUgVE1VX1ZFUjIJMHgyDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAg
LyoNCj4gPiA+ID4gPiAgICogUW9ySVEgVE1VIFJlZ2lzdGVycw0KPiA+ID4gPiA+IEBAIC0yMywx
NyArMzIsNTUgQEAgc3RydWN0IHFvcmlxX3RtdV9zaXRlX3JlZ3Mgew0KPiA+ID4gPiA+ICAJdTgg
cmVzMFsweDhdOw0KPiA+ID4gPiA+ICB9Ow0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gLXN0cnVjdCBx
b3JpcV90bXVfcmVncyB7DQo+ID4gPiA+ID4gK3N0cnVjdCBxb3JpcV90bXVfcmVnc192MiB7DQo+
ID4gPiA+ID4gKwl1MzIgdG1yOwkJLyogTW9kZSBSZWdpc3RlciAqLw0KPiA+ID4gPiA+ICsJdTMy
IHRzcjsJCS8qIFN0YXR1cyBSZWdpc3RlciAqLw0KPiA+ID4gPiA+ICsJdTMyIHRtc3I7CQkvKiBt
b25pdG9yIHNpdGUgcmVnaXN0ZXIgKi8NCj4gPiA+ID4gPiArCXUzMiB0bXRtaXI7CQkvKiBUZW1w
ZXJhdHVyZSBtZWFzdXJlbWVudA0KPiA+ID4gPiA+IGludGVydmFsIFJlZ2lzdGVyDQo+ID4gPg0K
PiA+ID4gKi8NCj4gPiA+ID4gPiArCXU4IHJlczBbMHgxMF07DQo+ID4gPiA+ID4gKwl1MzIgdGll
cjsJCS8qIEludGVycnVwdCBFbmFibGUgUmVnaXN0ZXIgKi8NCj4gPiA+ID4gPiArCXUzMiB0aWRy
OwkJLyogSW50ZXJydXB0IERldGVjdCBSZWdpc3RlciAqLw0KPiA+ID4gPiA+ICsJdTggcmVzMVsw
eDhdOw0KPiA+ID4gPiA+ICsJdTMyIHRpaXNjcjsJCS8qIGludGVycnVwdCBpbW1lZGlhdGUgc2l0
ZQ0KPiA+ID4gPiA+IGNhcHR1cmUgcmVnaXN0ZXIgKi8NCj4gPiA+ID4gPiArCXUzMiB0aWFzY3I7
CQkvKiBpbnRlcnJ1cHQgYXZlcmFnZSBzaXRlDQo+ID4gPiA+ID4gY2FwdHVyZSByZWdpc3RlciAq
Lw0KPiA+ID4gPiA+ICsJdTMyIHRpY3NjcjsJCS8qIEludGVycnVwdCBDcml0aWNhbCBTaXRlDQo+
ID4gPiA+ID4gQ2FwdHVyZSBSZWdpc3RlciAqLw0KPiA+ID4gPiA+ICsJdTMyIHJlczI7DQo+ID4g
PiA+ID4gKwl1MzIgdG1odGNyOwkJLyogbW9uaXRvciBoaWdoIHRlbXBlcmF0dXJlDQo+ID4gPiA+
ID4gY2FwdHVyZSByZWdpc3RlciAqLw0KPiA+ID4gPiA+ICsJdTMyIHRtbHRjcjsJCS8qIG1vbml0
b3IgbG93IHRlbXBlcmF0dXJlDQo+ID4gPiA+ID4gY2FwdHVyZSByZWdpc3RlciAqLw0KPiA+ID4g
PiA+ICsJdTMyIHRtcnRyY3I7CS8qIG1vbml0b3IgcmlzaW5nIHRlbXBlcmF0dXJlIHJhdGUNCj4g
PiA+ID4gPiBjYXB0dXJlIHJlZ2lzdGVyDQo+ID4gPg0KPiA+ID4gKi8NCj4gPiA+ID4gPiArCXUz
MiB0bWZ0cmNyOwkvKiBtb25pdG9yIGZhbGxpbmcgdGVtcGVyYXR1cmUgcmF0ZQ0KPiA+ID4gPiA+
IGNhcHR1cmUgcmVnaXN0ZXINCj4gPiA+DQo+ID4gPiAqLw0KPiA+ID4gPiA+ICsJdTMyIHRtaHRp
dHI7CS8qIEhpZ2ggVGVtcGVyYXR1cmUgSW1tZWRpYXRlIFRocmVzaG9sZA0KPiA+ID4gPiA+ICov
DQo+ID4gPiA+ID4gKwl1MzIgdG1odGF0cjsJLyogSGlnaCBUZW1wZXJhdHVyZSBBdmVyYWdlIFRo
cmVzaG9sZA0KPiA+ID4gPiA+ICovDQo+ID4gPiA+ID4gKwl1MzIgdG1odGFjdHI7CS8qIEhpZ2gg
VGVtcGVyYXR1cmUgQXZlcmFnZSBDcml0DQo+ID4gPiA+ID4gVGhyZXNob2xkICovDQo+ID4gPiA+
ID4gKwl1MzIgcmVzMzsNCj4gPiA+ID4gPiArCXUzMiB0bWx0aXRyOwkvKiBtb25pdG9yIGxvdyB0
ZW1wZXJhdHVyZSBpbW1lZGlhdGUNCj4gPiA+ID4gPiB0aHJlc2hvbGQgKi8NCj4gPiA+ID4gPiAr
CXUzMiB0bWx0YXRyOwkvKiBtb25pdG9yIGxvdyB0ZW1wZXJhdHVyZSBhdmVyYWdlDQo+ID4gPiA+
ID4gdGhyZXNob2xkDQo+ID4gPg0KPiA+ID4gcmVnaXN0ZXIgKi8NCj4gPiA+ID4gPiArCXUzMiB0
bWx0YWN0cjsJLyogbW9uaXRvciBsb3cgdGVtcGVyYXR1cmUgYXZlcmFnZQ0KPiA+ID4gPiA+IGNy
aXRpY2FsDQo+ID4gPg0KPiA+ID4gdGhyZXNob2xkICovDQo+ID4gPiA+ID4gKwl1MzIgcmVzNDsN
Cj4gPiA+ID4gPiArCXUzMiB0bXJ0cmN0cjsJLyogbW9uaXRvciByaXNpbmcgdGVtcGVyYXR1cmUg
cmF0ZQ0KPiA+ID4gPiA+IGNyaXRpY2FsIHRocmVzaG9sZA0KPiA+ID4NCj4gPiA+ICovDQo+ID4g
PiA+ID4gKwl1MzIgdG1mdHJjdHI7CS8qIG1vbml0b3IgZmFsbGluZyB0ZW1wZXJhdHVyZSByYXRl
DQo+ID4gPiA+ID4gY3JpdGljYWwNCj4gPiA+DQo+ID4gPiB0aHJlc2hvbGQqLw0KPiA+ID4gPiA+
ICsJdTggcmVzNVsweDhdOw0KPiA+ID4gPiA+ICsJdTMyIHR0Y2ZncjsJLyogVGVtcGVyYXR1cmUg
Q29uZmlndXJhdGlvbiBSZWdpc3Rlcg0KPiA+ID4gPiA+ICovDQo+ID4gPiA+ID4gKwl1MzIgdHNj
ZmdyOwkvKiBTZW5zb3IgQ29uZmlndXJhdGlvbiBSZWdpc3RlciAqLw0KPiA+ID4gPiA+ICsJdTgg
cmVzNlsweDc4XTsNCj4gPiA+ID4gPiArCXN0cnVjdCBxb3JpcV90bXVfc2l0ZV9yZWdzIHNpdGVb
U0lURVNfTUFYXTsNCj4gPiA+ID4gPiArCXU4IHJlczdbMHg5ZjhdOw0KPiA+ID4gPiA+ICsJdTMy
IGlwYnJyMDsJCS8qIElQIEJsb2NrIFJldmlzaW9uIFJlZ2lzdGVyIDANCj4gPiA+ID4gPiAqLw0K
PiA+ID4gPiA+ICsJdTMyIGlwYnJyMTsJCS8qIElQIEJsb2NrIFJldmlzaW9uIFJlZ2lzdGVyIDEN
Cj4gPiA+ID4gPiAqLw0KPiA+ID4gPiA+ICsJdTggcmVzOFsweDMwMF07DQo+ID4gPiA+ID4gKwl1
MzIgdGV1bXIwOw0KPiA+ID4gPiA+ICsJdTMyIHRldW1yMTsNCj4gPiA+ID4gPiArCXUzMiB0ZXVt
cjI7DQo+ID4gPiA+ID4gKwl1MzIgcmVzOTsNCj4gPiA+ID4gPiArCXUzMiB0dHJjcls0XTsJLyog
VGVtcGVyYXR1cmUgUmFuZ2UgQ29udHJvbCBSZWdpc3Rlcg0KPiA+ID4gPiA+ICovDQo+ID4gPiA+
ID4gK307DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICtzdHJ1Y3QgcW9yaXFfdG11X3JlZ3NfdjEg
ew0KPiA+ID4gPiA+ICAJdTMyIHRtcjsJCS8qIE1vZGUgUmVnaXN0ZXIgKi8NCj4gPiA+ID4gPiAt
I2RlZmluZSBUTVJfRElTQUJMRQkweDANCj4gPiA+ID4gPiAtI2RlZmluZSBUTVJfTUUJCTB4ODAw
MDAwMDANCj4gPiA+ID4gPiAtI2RlZmluZSBUTVJfQUxQRgkweDBjMDAwMDAwDQo+ID4gPiA+ID4g
IAl1MzIgdHNyOwkJLyogU3RhdHVzIFJlZ2lzdGVyICovDQo+ID4gPiA+ID4gIAl1MzIgdG10bWly
OwkJLyogVGVtcGVyYXR1cmUgbWVhc3VyZW1lbnQNCj4gPiA+ID4gPiBpbnRlcnZhbCBSZWdpc3Rl
cg0KPiA+ID4NCj4gPiA+ICovDQo+ID4gPiA+ID4gLSNkZWZpbmUgVE1UTUlSX0RFRkFVTFQJMHgw
MDAwMDAwZg0KPiA+ID4gPiA+ICAJdTggcmVzMFsweDE0XTsNCj4gPiA+ID4gPiAgCXUzMiB0aWVy
OwkJLyogSW50ZXJydXB0IEVuYWJsZSBSZWdpc3RlciAqLw0KPiA+ID4gPiA+IC0jZGVmaW5lIFRJ
RVJfRElTQUJMRQkweDANCj4gPiA+ID4gPiAgCXUzMiB0aWRyOwkJLyogSW50ZXJydXB0IERldGVj
dCBSZWdpc3RlciAqLw0KPiA+ID4gPiA+ICAJdTMyIHRpc2NyOwkJLyogSW50ZXJydXB0IFNpdGUg
Q2FwdHVyZQ0KPiA+ID4gPiA+IFJlZ2lzdGVyICovDQo+ID4gPiA+ID4gIAl1MzIgdGljc2NyOwkJ
LyogSW50ZXJydXB0IENyaXRpY2FsIFNpdGUNCj4gPiA+ID4gPiBDYXB0dXJlIFJlZ2lzdGVyICov
DQo+ID4gPiA+ID4gQEAgLTUzLDEwICsxMDAsNyBAQCBzdHJ1Y3QgcW9yaXFfdG11X3JlZ3Mgew0K
PiA+ID4gPiA+ICAJdTMyIGlwYnJyMDsJCS8qIElQIEJsb2NrIFJldmlzaW9uIFJlZ2lzdGVyIDAN
Cj4gPiA+ID4gPiAqLw0KPiA+ID4gPiA+ICAJdTMyIGlwYnJyMTsJCS8qIElQIEJsb2NrIFJldmlz
aW9uIFJlZ2lzdGVyIDENCj4gPiA+ID4gPiAqLw0KPiA+ID4gPiA+ICAJdTggcmVzNlsweDMxMF07
DQo+ID4gPiA+ID4gLQl1MzIgdHRyMGNyOwkJLyogVGVtcGVyYXR1cmUgUmFuZ2UgMCBDb250cm9s
DQo+ID4gPiA+ID4gUmVnaXN0ZXIgKi8NCj4gPiA+ID4gPiAtCXUzMiB0dHIxY3I7CQkvKiBUZW1w
ZXJhdHVyZSBSYW5nZSAxIENvbnRyb2wNCj4gPiA+ID4gPiBSZWdpc3RlciAqLw0KPiA+ID4gPiA+
IC0JdTMyIHR0cjJjcjsJCS8qIFRlbXBlcmF0dXJlIFJhbmdlIDIgQ29udHJvbA0KPiA+ID4gPiA+
IFJlZ2lzdGVyICovDQo+ID4gPiA+ID4gLQl1MzIgdHRyM2NyOwkJLyogVGVtcGVyYXR1cmUgUmFu
Z2UgMyBDb250cm9sDQo+ID4gPiA+ID4gUmVnaXN0ZXIgKi8NCj4gPiA+ID4gPiArCXUzMiB0dHJj
cls0XTsJCS8qIFRlbXBlcmF0dXJlIFJhbmdlIENvbnRyb2wNCj4gPiA+ID4gPiBSZWdpc3RlciAq
Lw0KPiA+ID4gPiA+ICB9Ow0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gIHN0cnVjdCBxb3JpcV90bXVf
ZGF0YTsNCj4gPiA+ID4gPiBAQCAtNzEsNyArMTE1LDkgQEAgc3RydWN0IHFvcmlxX3NlbnNvciB7
ICB9Ow0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gIHN0cnVjdCBxb3JpcV90bXVfZGF0YSB7DQo+ID4g
PiA+ID4gLQlzdHJ1Y3QgcW9yaXFfdG11X3JlZ3MgX19pb21lbSAqcmVnczsNCj4gPiA+ID4gPiAr
CWludCB2ZXI7DQo+ID4gPiA+ID4gKwlzdHJ1Y3QgcW9yaXFfdG11X3JlZ3NfdjEgX19pb21lbSAq
cmVnczsNCj4gPiA+ID4gPiArCXN0cnVjdCBxb3JpcV90bXVfcmVnc192MiBfX2lvbWVtICpyZWd2
MjsNCg0KcmVndjIgLT4gcmVnc192MiA/DQoNCj4gPiA+ID4gPiAgCWJvb2wgbGl0dGxlX2VuZGlh
bjsNCj4gPiA+ID4gPiAgCXN0cnVjdCBxb3JpcV9zZW5zb3IJKnNlbnNvcltTSVRFU19NQVhdOw0K
PiA+ID4gPiA+ICB9Ow0KPiA+ID4gPiA+IEBAIC0xMTEsNyArMTU3LDcgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdA0KPiA+ID4gPiA+IHRoZXJtYWxfem9uZV9vZl9kZXZpY2Vfb3BzIHRtdV90el9vcHMg
PSB7ICBzdGF0aWMgaW50DQo+ID4gPiA+ID4gcW9yaXFfdG11X3JlZ2lzdGVyX3RtdV96b25lKHN0
cnVjdA0KPiA+ID4gPiA+IHBsYXRmb3JtX2RldmljZSAqcGRldikgIHsNCj4gPiA+ID4gPiAgCXN0
cnVjdCBxb3JpcV90bXVfZGF0YSAqcWRhdGEgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsN
Cj4gPiA+ID4gPiAtCWludCBpZCwgc2l0ZXMgPSAwOw0KPiA+ID4gPiA+ICsJaW50IGlkLCBzaXRl
cyA9IDAsIHN2MiA9IDA7DQoNCkkgZGlkIE5PVCBzZWUgJ3NpdGVzJyBhbmQgJ3N2MicgdXNlZCB0
b2dldGhlciBpbiBiZWxvdyBjb2RlLCB3aHkgTk9UIGp1c3QgdXNlICdzaXRlcycgZm9yIGJvdGgg
VjEgYW5kIFYyPw0KDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAgCWZvciAoaWQgPSAwOyBpZCA8IFNJ
VEVTX01BWDsgaWQrKykgew0KPiA+ID4gPiA+ICAJCXFkYXRhLT5zZW5zb3JbaWRdID0gZGV2bV9r
emFsbG9jKCZwZGV2LT5kZXYsIEBADQo+ID4gPiA+ID4gLTEzMCwxMg0KPiA+ID4gPiA+ICsxNzYs
MjQgQEAgc3RhdGljIGludCBxb3JpcV90bXVfcmVnaXN0ZXJfdG11X3pvbmUoc3RydWN0DQo+ID4g
PiA+ID4gK3BsYXRmb3JtX2RldmljZQ0KPiA+ID4gPiA+ICpwZGV2KQ0KPiA+ID4gPiA+ICAJCQkJ
cmV0dXJuIFBUUl9FUlIocWRhdGEtDQo+ID4gPiA+ID4gPnNlbnNvcltpZF0tPnR6ZCk7DQo+ID4g
PiA+ID4gIAkJfQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gLQkJc2l0ZXMgfD0gMHgxIDw8ICgxNSAt
IGlkKTsNCj4gPiA+ID4gPiArCQlpZiAocWRhdGEtPnZlciA9PSBUTVVfVkVSMSkNCj4gPiA+ID4g
PiArCQkJc2l0ZXMgfD0gMHgxIDw8ICgxNSAtIGlkKTsNCj4gPiA+ID4gPiArCQllbHNlDQo+ID4g
PiA+ID4gKwkJCXN2MiB8PSAweDEgPDwgaWQ7DQo+ID4gPiA+ID4gIAl9DQo+ID4gPiA+ID4NCj4g
PiA+ID4gPiAgCS8qIEVuYWJsZSBtb25pdG9yaW5nICovDQo+ID4gPiA+ID4gLQlpZiAoc2l0ZXMg
IT0gMCkNCj4gPiA+ID4gPiAtCQl0bXVfd3JpdGUocWRhdGEsIHNpdGVzIHwgVE1SX01FIHwgVE1S
X0FMUEYsDQo+ID4gPiA+ID4gJnFkYXRhLT5yZWdzLT50bXIpOw0KPiA+ID4gPiA+ICsJaWYgKHFk
YXRhLT52ZXIgPT0gVE1VX1ZFUjEpIHsNCj4gPiA+ID4gPiArCQlpZiAoc2l0ZXMgIT0gMCkNCj4g
PiA+ID4gPiArCQkJdG11X3dyaXRlKHFkYXRhLCBzaXRlcyB8IFRNUl9NRSB8DQo+ID4gPiA+ID4g
VE1SX0FMUEYsDQo+ID4gPiA+ID4gKwkJCQkJJnFkYXRhLT5yZWdzLT50bXIpOw0KPiA+ID4gPiA+
ICsJfSBlbHNlIHsNCj4gPiA+ID4gPiArCQlpZiAoc3YyICE9IDApIHsNCj4gPiA+ID4gPiArCQkJ
dG11X3dyaXRlKHFkYXRhLCBzdjIsICZxZGF0YS0+cmVndjItDQo+ID4gPiA+ID4gPnRtc3IpOw0K
PiA+ID4gPiA+ICsJCQl0bXVfd3JpdGUocWRhdGEsIFRNUl9NRSB8IFRNUl9BTFBGX1YyLA0KPiA+
ID4gPiA+ICsJCQkJCSZxZGF0YS0+cmVndjItPnRtcik7DQo+ID4gPiA+ID4gKwkJfQ0KPiA+ID4g
PiA+ICsJfQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gIAlyZXR1cm4gMDsNCj4gPiA+ID4gPiAgfQ0K
PiA+ID4gPiA+IEBAIC0xNDgsMTYgKzIwNiwyMCBAQCBzdGF0aWMgaW50IHFvcmlxX3RtdV9jYWxp
YnJhdGlvbihzdHJ1Y3QNCj4gPiA+ID4gPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gPiA+
ID4gIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gcGRldi0+ZGV2Lm9mX25vZGU7DQo+ID4gPiA+
ID4gIAlzdHJ1Y3QgcW9yaXFfdG11X2RhdGEgKmRhdGEgPQ0KPiA+ID4gPiA+IHBsYXRmb3JtX2dl
dF9kcnZkYXRhKHBkZXYpOw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gLQlpZiAob2ZfcHJvcGVydHlf
cmVhZF91MzJfYXJyYXkobnAsICJmc2wsdG11LXJhbmdlIiwNCj4gPiA+ID4gPiByYW5nZSwgNCkp
IHsNCj4gPiA+ID4gPiAtCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJtaXNzaW5nIGNhbGlicmF0aW9u
DQo+ID4gPiA+ID4gcmFuZ2UuXG4iKTsNCj4gPiA+ID4gPiAtCQlyZXR1cm4gLUVOT0RFVjsNCj4g
PiA+ID4gPiArCWxlbiA9IG9mX3Byb3BlcnR5X2NvdW50X3UzMl9lbGVtcyhucCwgImZzbCx0bXUt
cmFuZ2UiKTsNCj4gPiA+ID4gPiArCWlmIChsZW4gPT0gLUVOT0RBVEEgfHwgbGVuID09IC1FSU5W
QUwgfHwgbGVuID4gNCkgew0KDQpDYW4gd2UganVzdCBjaGVjayB0aGUgImxlbiA8IDAgfHwgbGVu
ID4gNCIgPyANCg0KPiA+ID4gPiA+ICsJCWRldl9lcnIoJnBkZXYtPmRldiwgImludmFsaWQgcmFu
Z2UgZGF0YS5cbiIpOw0KPiA+ID4gPiA+ICsJCXJldHVybiBsZW47DQo+ID4gPiA+ID4gIAl9DQo+
ID4gPiA+ID4NCj4gPiA+ID4gPiAtCS8qIEluaXQgdGVtcGVyYXR1cmUgcmFuZ2UgcmVnaXN0ZXJz
ICovDQo+ID4gPiA+ID4gLQl0bXVfd3JpdGUoZGF0YSwgcmFuZ2VbMF0sICZkYXRhLT5yZWdzLT50
dHIwY3IpOw0KPiA+ID4gPiA+IC0JdG11X3dyaXRlKGRhdGEsIHJhbmdlWzFdLCAmZGF0YS0+cmVn
cy0+dHRyMWNyKTsNCj4gPiA+ID4gPiAtCXRtdV93cml0ZShkYXRhLCByYW5nZVsyXSwgJmRhdGEt
PnJlZ3MtPnR0cjJjcik7DQo+ID4gPiA+ID4gLQl0bXVfd3JpdGUoZGF0YSwgcmFuZ2VbM10sICZk
YXRhLT5yZWdzLT50dHIzY3IpOw0KPiA+ID4gPiA+ICsJdmFsID0gb2ZfcHJvcGVydHlfcmVhZF91
MzJfYXJyYXkobnAsICJmc2wsdG11LXJhbmdlIiwNCj4gPiA+ID4gPiByYW5nZSwgbGVuKTsNCj4g
PiA+ID4gPiArCWlmICh2YWwgIT0gMCkgew0KPiA+ID4gPiA+ICsJCWRldl9lcnIoJnBkZXYtPmRl
diwgImludmFsaWQgcmFuZ2UgZGF0YS5cbiIpOw0KDQpUaGUgZXJyb3IgbG9nIGlzIHNhbWUgYXMg
ZmFpbHVyZSBvZiBnZXR0aW5nIHJhbmdlIGRhdGEgY291bnQsIHNvIHdvdWxkIGl0IGJlIGJldHRl
cg0KdG8gY2hhbmdlIHRoZSBsb2cgdG8gImZhaWxlZCB0byByZWFkIHJhbmdlIGRhdGEiIGhlcmU/
DQoNCj4gPiA+ID4gPiArCQlyZXR1cm4gdmFsOw0KPiA+ID4gPiA+ICsJfQ0KPiA+ID4gPiA+ICsN
Cj4gPiA+ID4gPiArCWZvciAoaSA9IDA7IGkgPCBsZW47IGkrKykNCj4gPiA+ID4gPiArCQl0bXVf
d3JpdGUoZGF0YSwgcmFuZ2VbaV0sICZkYXRhLT5yZWdzLQ0KPiA+ID4gPiA+ID50dHJjcltpXSk7
DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAgCWNhbGlicmF0aW9uID0gb2ZfZ2V0X3Byb3BlcnR5KG5w
LCAiZnNsLHRtdS0gY2FsaWJyYXRpb24iLA0KPiA+ID4gPiA+ICZsZW4pOw0KPiA+ID4gPiA+ICAJ
aWYgKGNhbGlicmF0aW9uID09IE5VTEwgfHwgbGVuICUgOCkgeyBAQCAtMTgxLDcgKzI0MywxMiBA
QA0KPiA+ID4gPiA+IHN0YXRpYyB2b2lkIHFvcmlxX3RtdV9pbml0X2RldmljZShzdHJ1Y3QgcW9y
aXFfdG11X2RhdGEgKmRhdGEpDQo+ID4gPiA+ID4gIAl0bXVfd3JpdGUoZGF0YSwgVElFUl9ESVNB
QkxFLCAmZGF0YS0+cmVncy0+dGllcik7DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAgCS8qIFNldCB1
cGRhdGVfaW50ZXJ2YWwgKi8NCj4gPiA+ID4gPiAtCXRtdV93cml0ZShkYXRhLCBUTVRNSVJfREVG
QVVMVCwgJmRhdGEtPnJlZ3MtPnRtdG1pcik7DQo+ID4gPiA+ID4gKwlpZiAoZGF0YS0+dmVyID09
IFRNVV9WRVIxKSB7DQo+ID4gPiA+ID4gKwkJdG11X3dyaXRlKGRhdGEsIFRNVE1JUl9ERUZBVUxU
LCAmZGF0YS0+cmVncy0NCj4gPiA+ID4gPiA+dG10bWlyKTsNCj4gPiA+ID4gPiArCX0gZWxzZSB7
DQo+ID4gPiA+ID4gKwkJdG11X3dyaXRlKGRhdGEsIFRNVE1JUl9ERUZBVUxULCAmZGF0YS0+cmVn
djItDQo+ID4gPiA+ID4gPnRtdG1pcik7DQo+ID4gPiA+ID4gKwkJdG11X3dyaXRlKGRhdGEsIFRF
VU1SMF9WMiwgJmRhdGEtPnJlZ3YyLQ0KPiA+ID4gPiA+ID50ZXVtcjApOw0KPiA+ID4gPiA+ICsJ
fQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gIAkvKiBEaXNhYmxlIG1vbml0b3JpbmcgKi8NCj4gPiA+
ID4gPiAgCXRtdV93cml0ZShkYXRhLCBUTVJfRElTQUJMRSwgJmRhdGEtPnJlZ3MtPnRtcik7IEBA
DQo+ID4gPiA+ID4gLTE5MCw2DQo+ID4gPg0KPiA+ID4gKzI1Nyw3DQo+ID4gPiA+IEBADQo+ID4g
PiA+ID4gc3RhdGljIHZvaWQgcW9yaXFfdG11X2luaXRfZGV2aWNlKHN0cnVjdCBxb3JpcV90bXVf
ZGF0YSAqZGF0YSkNCj4gPiA+ID4gPiBzdGF0aWMgaW50IHFvcmlxX3RtdV9wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KSAgew0KPiA+ID4gPiA+ICAJaW50IHJldDsNCj4gPiA+ID4g
PiArCXUzMiB2ZXI7DQo+ID4gPiA+ID4gIAlzdHJ1Y3QgcW9yaXFfdG11X2RhdGEgKmRhdGE7DQo+
ID4gPiA+ID4gIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gcGRldi0+ZGV2Lm9mX25vZGU7DQo+
ID4gPiA+ID4NCj4gPiA+ID4gPiBAQCAtMjE0LDYgKzI4MiwxMiBAQCBzdGF0aWMgaW50IHFvcmlx
X3RtdV9wcm9iZShzdHJ1Y3QNCj4gPiA+ID4NCj4gPiA+ID4gcGxhdGZvcm1fZGV2aWNlDQo+ID4g
PiA+ID4gKnBkZXYpDQo+ID4gPiA+ID4gIAkJZ290byBlcnJfaW9tYXA7DQo+ID4gPiA+ID4gIAl9
DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiArCS8qIHZlcnNpb24gcmVnaXN0ZXIgb2Zmc2V0IGF0OiAw
eGJmOCBvbiBib3RoIHYxIGFuZCB2Mg0KPiA+ID4gPiA+ICovDQo+ID4gPiA+ID4gKwl2ZXIgPSB0
bXVfcmVhZChkYXRhLCAmZGF0YS0+cmVncy0+aXBicnIwKTsNCj4gPiA+ID4gPiArCWRhdGEtPnZl
ciA9ICh2ZXIgPj4gOCkgJiAweGZmOw0KPiA+ID4gPiA+ICsJaWYgKGRhdGEtPnZlciA9PSBUTVVf
VkVSMikNCj4gPiA+ID4gPiArCQlkYXRhLT5yZWd2MiA9ICh2b2lkIF9faW9tZW0gKilkYXRhLT5y
ZWdzOw0KDQpTbyB0aGUgVjIgaGFzIHNhbWUgcmVnaXN0ZXIgYmFzZSBhZGRyZXNzIGFzIFYxPyBJ
ZiB5ZXMsIHRoZW4gSSB0aGluayBubw0KbmVlZCB0byBjaGVjayB0aGUgdmVyc2lvbiBoZXJlLCBq
dXN0IGFzc2lnbiBWMidzIHJlZyB0byBlcXVhbCB0byBWMSdzIHNob3VsZCBiZSBPSz8gDQoNCkFu
c29uDQoNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gIAlxb3JpcV90bXVfaW5pdF9kZXZpY2UoZGF0
YSk7CS8qIFRNVSBpbml0aWFsaXphdGlvbg0KPiA+ID4gPiA+ICovDQo+ID4gPiA+ID4NCj4gPiA+
ID4gPiAgCXJldCA9IHFvcmlxX3RtdV9jYWxpYnJhdGlvbihwZGV2KTsJLyogVE1VDQo+ID4gPiA+
ID4gY2FsaWJyYXRpb24gKi8NCj4gPiA+ID4gPiAtLQ0KPiA+ID4gPiA+IDIuMTcuMQ0KPiA+DQo+
ID4NCg0K
