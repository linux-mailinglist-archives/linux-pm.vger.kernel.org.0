Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7A518775B
	for <lists+linux-pm@lfdr.de>; Tue, 17 Mar 2020 02:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733102AbgCQBOs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Mar 2020 21:14:48 -0400
Received: from mail-eopbgr00072.outbound.protection.outlook.com ([40.107.0.72]:33427
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733017AbgCQBOs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Mar 2020 21:14:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzwhYGXVYUaP4w8B8nkBrbff1WXfsX1OHwoZJYLHgyjHK7GJyhKYopZ5Fi6n05nW0z0/vRwznZmeLaUXMDMB96xcVIsuidOXH9VDyy4M3YgE8A4p3RmvXCN4LtUN0wq166+U/gzY7yIPxbWfJF6jNVqjDnzUlQA8geL6XERvqQtynO4Z4pGD6w99pyvB9l0mvgIp9LKgwxnMClC7pPDXD0SG1Cv6WrWp8xPY438zq2v1jfq9TXYqFGcbk0UnCmWVltF0xki7R/FbAl3aJbLA4dDuPkWUp7s6ypp3SmmE0WVCPgkGuSEQriFPplcUL1tT2v5xr5kmYKl9CguAY7E8uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/q+fJV89rN1njfDgec1dD91WxSoS/tpmSsT7tqirwfg=;
 b=SGm83XmLGNUvW3HVd0zJ6SXWig2Mwp+pyIlQWsz/Rde/uRra1rqogp1w9ljTjgQpF6qWkEhDUtX+CRP2rtkYJkmnoQmew6JLrpQ9jh0oZlvoR7tjImeY2RTZIsZ2ZOpejcW6lrqiM0mdkbFSjSr3Fub1eV4mFFckCMb8WWsRdzLKVu+eDnTDRQTLXKmAbkAdrdGzKl8idXHbheGx4ii1/MN/1ZH5z3z6NuF8lZtpYljJyyDJxzIEjtq7akAkzobuK0wO94ZWEQncUc6nNLdknWNWT57+KLCML2k4gqQ2SIhRAbGbTjRVNeDLG2J+OEvSGGNcYTT8Cnt2zdynR4FM8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/q+fJV89rN1njfDgec1dD91WxSoS/tpmSsT7tqirwfg=;
 b=cIBGvHgULrzAqMYl/JHgVyiN6J3VZV+Ppgm5APBiOtpt8qKbtvsj2E1sL/JEAIG2E1lWZJRMt8j+P0PhXgZxGAnMhEzDyDY24UjTzVQid9ZoUM82KjMBHVEmsl0NJn6qT9YmbHACvK4H5PHVkjaSaCCrHpkbimGZPoSOnrEUGpw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3899.eurprd04.prod.outlook.com (52.134.71.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.18; Tue, 17 Mar 2020 01:14:44 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b%7]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 01:14:44 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] thermal: qoriq: Use devm_add_action_or_reset() to
 handle all cleanups
Thread-Topic: [PATCH 1/2] thermal: qoriq: Use devm_add_action_or_reset() to
 handle all cleanups
Thread-Index: AQHV92PgUEO+4yjn2k6lxrr+i2btw6hE0roAgAAGWwCAAAK2gIAABPxQgAcjGBA=
Date:   Tue, 17 Mar 2020 01:14:44 +0000
Message-ID: <DB3PR0402MB39168E9B3397BB0E7339802EF5F60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1583903252-2058-1-git-send-email-Anson.Huang@nxp.com>
 <c4c2d976-4fe6-bdf3-e110-90d1600566a3@linaro.org>
 <DB3PR0402MB3916BF7EF180809EC374CC7CF5FD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <831cd71d-04dc-834f-fa28-6091a186dce3@linaro.org>
 <DB3PR0402MB39169041ED7CDA2C4DBD4833F5FD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39169041ED7CDA2C4DBD4833F5FD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 79a77632-54e2-4c55-d0d0-08d7ca1093e3
x-ms-traffictypediagnostic: DB3PR0402MB3899:|DB3PR0402MB3899:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB38995831194B7913EF334528F5F60@DB3PR0402MB3899.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 0345CFD558
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(199004)(7696005)(8936002)(52536014)(8676002)(33656002)(478600001)(26005)(6506007)(5660300002)(186003)(316002)(66556008)(2906002)(66476007)(64756008)(66446008)(53546011)(76116006)(66946007)(110136005)(9686003)(81166006)(55016002)(71200400001)(81156014)(44832011)(4326008)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3899;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mbbW9KlMCCB60Zf63susB7kAjcuXdzvCCYrsQAirCwK1P3N9Btl+x0B9Lh1IYJeoGuR4ego7Du+6Q/k5XRHUHqccMykAD9SZbK+5oXw3sbZnoEXJG0ESJX9WKuyrrFvQn0aDh4LQvvM9C/ZH0GoVyY9HPzMvpq9waXgg+WuBXVOH2SjVtvC9G2xzM9n/A129ZTRzEkWHbwyaNad/tzV7/PaLZr0QXlZaPngQRYMZGiAJl3xB9WlRuD4xBD/CCvqIWmgFS7KZAjAzKCL2O3ytZOt0W9uiY0IwOIHPHI2gn7IE1cfjiCTYM6FeZIWb4cIrlEU/jBU1alxe/WBZlC05uqvgcCNAaBqZc9aopvPSnvem90v0YnxAM3lkdL9HVpn8FUx0LopOwFQDNibUnFDCuFNVeBto/BMbskpDfDPcJIde9+4CRlkeFo8yYWmMLfim
x-ms-exchange-antispam-messagedata: /CUoYbyzxJW9S0l8/XzWeif6nn/x/fG1cO3Ot/XCYzriqt/5I/E3uWUdpztRO+67a07uUDQ4sKRsMEtdXRBY+zv+RjNeAR3QzOaTVQodHx2Nuw3rqoJLTlBIMCSxIXMmnprR3GAIr1MSby7GOHklaw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a77632-54e2-4c55-d0d0-08d7ca1093e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2020 01:14:44.4363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wwgQBDUH7iYGki5e5gzSO9LtxTXnN3l1pRMERuxYrRJ3m+YjizCxMIMX42Sl6sEL0xretXoUBpyGZdGKqN4fWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3899
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIERhbmllbA0KDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggMS8yXSB0aGVybWFsOiBxb3JpcTog
VXNlIGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldCgpIHRvDQo+IGhhbmRsZSBhbGwgY2xlYW51cHMN
Cj4gDQo+IEhpLCBEYW5pZWwNCj4gDQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIHRoZXJt
YWw6IHFvcmlxOiBVc2UNCj4gPiBkZXZtX2FkZF9hY3Rpb25fb3JfcmVzZXQoKSB0byBoYW5kbGUg
YWxsIGNsZWFudXBzDQo+ID4NCj4gPiBPbiAxMi8wMy8yMDIwIDEyOjQ3LCBBbnNvbiBIdWFuZyB3
cm90ZToNCj4gPiA+IEhpLCBEYW5pZWwNCj4gPiA+DQo+ID4gPj4gU3ViamVjdDogUmU6IFtQQVRD
SCAxLzJdIHRoZXJtYWw6IHFvcmlxOiBVc2UNCj4gPiA+PiBkZXZtX2FkZF9hY3Rpb25fb3JfcmVz
ZXQoKSB0byBoYW5kbGUgYWxsIGNsZWFudXBzDQo+ID4gPj4NCj4gPiA+PiBPbiAxMS8wMy8yMDIw
IDA2OjA3LCBBbnNvbiBIdWFuZyB3cm90ZToNCj4gPiA+Pj4gVXNlIGRldm1fYWRkX2FjdGlvbl9v
cl9yZXNldCgpIHRvIGhhbmRsZSBhbGwgY2xlYW51cHMgb2YgZmFpbHVyZQ0KPiA+ID4+PiBpbiAu
cHJvYmUgYW5kIC5yZW1vdmUsIHRoZW4gLnJlbW92ZSBjYWxsYmFjayBjYW4gYmUgZHJvcHBlZC4N
Cj4gPiA+Pg0KPiA+ID4+IElzIHRoaXMgY2hhbmdlIGNvbXBhdGlibGUgd2l0aCB0aGUgdHJpc3Rh
dGU/DQo+ID4gPg0KPiA+ID4gSSB0aGluayBzbywgYW55IGNvbmNlcm4gbmVlZCBtZSB0byBkb3Vi
bGUgY29uZmlybT8NCj4gPg0KPiA+IFRCSCwgSSBkaXNjb3ZlcmVkIHRoZSBmdW5jdGlvbiB3aXRo
IHlvdXIgcGF0Y2guIE15IGNvbmNlcm4gaXMgaWYgdGhlDQo+ID4gY2FsbGJhY2sgaXMgY2FsbGVk
IHdoZW4gdW5sb2FkaW5nIHRoZSBtb2R1bGUuDQo+IA0KPiBJIHRoaW5rIHNvIGFzIHBlciBteSBt
ZW1vcnksIHNlZSBzaW1pbGFyIHBhdGNoZXMgYXMgYmVsb3c6DQo+IA0KPiANCj4gY29tbWl0IDE5
ZWMxMWEyMjMzZDI0YTc4MTE4MzZmYTczNTIwM2FhY2NmOTVhMjMNCj4gQXV0aG9yOiBCYXJ0b3N6
IEdvbGFzemV3c2tpIDxiZ29sYXN6ZXdza2lAYmF5bGlicmUuY29tPg0KPiBEYXRlOiAgIFRodSBK
dWwgMTEgMTA6Mjk6MzUgMjAxOSArMDIwMA0KPiANCj4gICAgIGdwaW86IGVtOiByZW1vdmUgdGhl
IGdwaW9jaGlwIGJlZm9yZSByZW1vdmluZyB0aGUgaXJxIGRvbWFpbg0KPiANCj4gICAgIEluIGNv
bW1pdCA4NzY0YzRjYTUwNDkgKCJncGlvOiBlbTogdXNlIHRoZSBtYW5hZ2VkIHZlcnNpb24gb2YN
Cj4gICAgIGdwaW9jaGlwX2FkZF9kYXRhKCkiKSB3ZSBpbXBsaWNpdGx5IGFsdGVyZWQgdGhlIG9y
ZGVyaW5nIG9mIHJlc291cmNlDQo+ICAgICBmcmVlaW5nOiBzaW5jZSBncGlvY2hpcF9yZW1vdmUo
KSBjYWxscyBncGlvY2hpcF9pcnFjaGlwX3JlbW92ZSgpDQo+ICAgICBpbnRlcm5hbGx5LCB3ZSBu
b3cgY2FuIHBvdGVudGlhbGx5IHVzZSB0aGUgaXJxX2RvbWFpbiBhZnRlciBpdCB3YXMNCj4gICAg
IGRlc3Ryb3llZCBpbiB0aGUgcmVtb3ZlKCkgY2FsbGJhY2sgKGFzIGRldm0gcmVzb3VyY2VzIGFy
ZSBmcmVlZCBhZnRlcg0KPiAgICAgcmVtb3ZlKCkgaGFzIHJldHVybmVkKS4NCj4gDQo+ICAgICBV
c2UgZGV2bV9hZGRfYWN0aW9uX29yX3Jlc2V0KCkgdG8ga2VlcCB0aGUgb3JkZXJpbmcgcmlnaHQg
YW5kIGVudGlyZWx5DQo+ICAgICBraWxsIHRoZSByZW1vdmUoKSBjYWxsYmFjayBpbiB0aGUgZHJp
dmVyLg0KPiANCj4gDQo+IGNvbW1pdCBkOWFhNWNhNDI5YWQzMGRkZTk2ZTU5NjYxNzNkMTgwMDRm
MTZmMzEyDQo+IEF1dGhvcjogQWxleGFuZHJlIEJlbGxvbmkgPGFsZXhhbmRyZS5iZWxsb25pQGJv
b3RsaW4uY29tPg0KPiBEYXRlOiAgIEZyaSBBcHIgMTkgMTA6MjU6MDEgMjAxOSArMDIwMA0KPiAN
Cj4gICAgIHJ0YzogZHMyNDA0OiBzaW1wbGlmeSAucHJvYmUgYW5kIHJlbW92ZSAucmVtb3ZlDQo+
IA0KPiAgICAgVXNlIGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldCB0byBzaW1wbGlmeSAucHJvYmUg
YW5kIHJlbW92ZSAucmVtb3ZlDQo+IA0KPiAgICAgU2lnbmVkLW9mZi1ieTogQWxleGFuZHJlIEJl
bGxvbmkgPGFsZXhhbmRyZS5iZWxsb25pQGJvb3RsaW4uY29tPg0KPiANCj4gZHJpdmVycy9ydGMv
cnRjLWRzMjQwNC5jDQoNCkFueSBmdXJ0aGVyIGNvbmNlcm4/DQoNClRoYW5rcywNCkFuc29uDQo=
