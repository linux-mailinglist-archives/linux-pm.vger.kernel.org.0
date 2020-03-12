Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7C88183015
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 13:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgCLMTp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Mar 2020 08:19:45 -0400
Received: from mail-eopbgr60088.outbound.protection.outlook.com ([40.107.6.88]:4932
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726254AbgCLMTp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 12 Mar 2020 08:19:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKEs0bm/j7wicjl8lZ1gldvEzkHsyPBbU79Q1n0FC7VaU9jZcWFqERv0cSEQUoRxyM0k57tZrYIISDbbmz3KfjYfNWWC0yk0Vaz5VvnwA7ScK9L4l5yVu7XPfyK7PL6NN00katZtyIeagNyUuV1HMlgdWdqukLR7R8qUozGo+gFV7xTef2MomZuMSOGM3Dy8wMB0/4FCDrt7BRPRISzC716Z/MNmPqgxmUQaybXP3I1gvATYVEzY8ZaL7O+hAMTge3qytCW2qAs/x2R+Xr765UNV9BvvgOyED8WPFBmasHQBa09wx4CSvzzkPdlkYG/wOIoyJBY2c53vTjUgWsytYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oo2n9rNyfMGHsafYjJZDtPNGv94PXpgCu4GEZtNBJOQ=;
 b=FxMcJI8wESM+DkOX5tvfcj3xExd51iRkImYoraInMyV8ww9M5PAGqjCKCM/L5QSwa2njk+JMmnDxCkSwXNb5MjQ5FSaYR46VgnOqBfQAT9T7qQSDJShg3Tl/omTXNwUhau5azymA9MXOWlGkg/8wDQTSYpVugVNB9WZgshcZ+G0iWEyvck/H14K6gPBeNi0TIcxoAgzANtuinsOY4EpgbJraDjHOKZzEUKN2+mFgQE8y7/8SGJh30+Or29lMEypSopwpxq6/xxUoQaxhHEcxIYmMpG8ds4XrSqnsbEqlaqUOeulVbuH00dYVOWlynDtRfTbGY5qcCvuD17zLM6S0xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oo2n9rNyfMGHsafYjJZDtPNGv94PXpgCu4GEZtNBJOQ=;
 b=Wa4glBanEUeYvHhm5BQFyV8GrNZvmjmPSvmwT9VkSNIAVAQVetuSEaONMIJF8NEcdDeOYAeX78ijS6aY48qHSmV1k1mzzr1RkteayZxCbBufnre70v5AC3WcrrJCmMWGp0EUymALviIVyllpF8pa7KhelLf1OGNnTdF7djhlpZU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3867.eurprd04.prod.outlook.com (52.134.65.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Thu, 12 Mar 2020 12:19:38 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b%7]) with mapi id 15.20.2814.007; Thu, 12 Mar 2020
 12:19:38 +0000
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
Thread-Index: AQHV92PgUEO+4yjn2k6lxrr+i2btw6hE0roAgAAGWwCAAAK2gIAABPxQ
Date:   Thu, 12 Mar 2020 12:19:37 +0000
Message-ID: <DB3PR0402MB39169041ED7CDA2C4DBD4833F5FD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1583903252-2058-1-git-send-email-Anson.Huang@nxp.com>
 <c4c2d976-4fe6-bdf3-e110-90d1600566a3@linaro.org>
 <DB3PR0402MB3916BF7EF180809EC374CC7CF5FD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <831cd71d-04dc-834f-fa28-6091a186dce3@linaro.org>
In-Reply-To: <831cd71d-04dc-834f-fa28-6091a186dce3@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 13c5a1e5-943b-4c30-3371-08d7c67fa22c
x-ms-traffictypediagnostic: DB3PR0402MB3867:|DB3PR0402MB3867:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB386777D90BE18D06AF6BE345F5FD0@DB3PR0402MB3867.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(199004)(81156014)(76116006)(66946007)(186003)(110136005)(26005)(8936002)(5660300002)(55016002)(316002)(81166006)(33656002)(52536014)(478600001)(66556008)(64756008)(86362001)(66476007)(4326008)(2906002)(9686003)(8676002)(71200400001)(44832011)(66446008)(6506007)(53546011)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3867;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hZUMzrecnmq90GsQjcJSCB5RmsDv3YVe2RHZUDBPv62yIegisVu/OzmV0LQw3gS/qGJm6qqTcqf/1BKWKCM1H0iHRAL/gEtWrezGyMgq315e6WmdZRlIzEhY2pvp1KWW/DmDzTirO8z+mdNbavZyfkEvogireLizKRI47OjB4+dqDMKHHrb+HslVsE+xvOJBUI+gz8hnz9uySeQxv9IWkvCoi29rzi2Wg+xbDofd2Cl56mVYKq6vax3uesNebgdwoW3guallvI7lTPNNiUKJX4ChafNPzJAZOAxx6NfZNUjZzrCyTPijEY0KIkS03ldRixmDoUur/VhNwbX+OgbK5DrP9ZbDbyS9TW6Wrw++LGpHWQuq5wmSthYOQ7Qacu3yjxrftNtMfEdVQXRhh4EF16kH5KekZWFMBLnNCjZyq8EVZfmyX3L+d0uIZEdeag0S
x-ms-exchange-antispam-messagedata: K1NharrjCW3DBD0nmd5gr5O6lMY0y3SgRrj8bN4EY9wSNnzyXPhFDJDd0OvSvDpafm1HQNq7+94xOmT/VoXp1PFeZ42ApqS8Imdl5aw6GWValmLb0hHgA9+IgN58j3nHkkxFutKVAcj8KYUE39IE+A==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c5a1e5-943b-4c30-3371-08d7c67fa22c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 12:19:37.8217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R8RPBytrx7CvnfcGzBd0dICfn5W7JTHjSS/tows7zVEWucx75M0nnDHtBxy2flqYcKgrJYBMRl9j0F+94urCyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3867
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIERhbmllbA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSB0aGVybWFsOiBxb3JpcTog
VXNlIGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldCgpIHRvDQo+IGhhbmRsZSBhbGwgY2xlYW51cHMN
Cj4gDQo+IE9uIDEyLzAzLzIwMjAgMTI6NDcsIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+IEhpLCBE
YW5pZWwNCj4gPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gdGhlcm1hbDogcW9yaXE6
IFVzZQ0KPiA+PiBkZXZtX2FkZF9hY3Rpb25fb3JfcmVzZXQoKSB0byBoYW5kbGUgYWxsIGNsZWFu
dXBzDQo+ID4+DQo+ID4+IE9uIDExLzAzLzIwMjAgMDY6MDcsIEFuc29uIEh1YW5nIHdyb3RlOg0K
PiA+Pj4gVXNlIGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldCgpIHRvIGhhbmRsZSBhbGwgY2xlYW51
cHMgb2YgZmFpbHVyZSBpbg0KPiA+Pj4gLnByb2JlIGFuZCAucmVtb3ZlLCB0aGVuIC5yZW1vdmUg
Y2FsbGJhY2sgY2FuIGJlIGRyb3BwZWQuDQo+ID4+DQo+ID4+IElzIHRoaXMgY2hhbmdlIGNvbXBh
dGlibGUgd2l0aCB0aGUgdHJpc3RhdGU/DQo+ID4NCj4gPiBJIHRoaW5rIHNvLCBhbnkgY29uY2Vy
biBuZWVkIG1lIHRvIGRvdWJsZSBjb25maXJtPw0KPiANCj4gVEJILCBJIGRpc2NvdmVyZWQgdGhl
IGZ1bmN0aW9uIHdpdGggeW91ciBwYXRjaC4gTXkgY29uY2VybiBpcyBpZiB0aGUgY2FsbGJhY2sN
Cj4gaXMgY2FsbGVkIHdoZW4gdW5sb2FkaW5nIHRoZSBtb2R1bGUuDQoNCkkgdGhpbmsgc28gYXMg
cGVyIG15IG1lbW9yeSwgc2VlIHNpbWlsYXIgcGF0Y2hlcyBhcyBiZWxvdzoNCg0KDQpjb21taXQg
MTllYzExYTIyMzNkMjRhNzgxMTgzNmZhNzM1MjAzYWFjY2Y5NWEyMw0KQXV0aG9yOiBCYXJ0b3N6
IEdvbGFzemV3c2tpIDxiZ29sYXN6ZXdza2lAYmF5bGlicmUuY29tPg0KRGF0ZTogICBUaHUgSnVs
IDExIDEwOjI5OjM1IDIwMTkgKzAyMDANCg0KICAgIGdwaW86IGVtOiByZW1vdmUgdGhlIGdwaW9j
aGlwIGJlZm9yZSByZW1vdmluZyB0aGUgaXJxIGRvbWFpbg0KDQogICAgSW4gY29tbWl0IDg3NjRj
NGNhNTA0OSAoImdwaW86IGVtOiB1c2UgdGhlIG1hbmFnZWQgdmVyc2lvbiBvZg0KICAgIGdwaW9j
aGlwX2FkZF9kYXRhKCkiKSB3ZSBpbXBsaWNpdGx5IGFsdGVyZWQgdGhlIG9yZGVyaW5nIG9mIHJl
c291cmNlDQogICAgZnJlZWluZzogc2luY2UgZ3Bpb2NoaXBfcmVtb3ZlKCkgY2FsbHMgZ3Bpb2No
aXBfaXJxY2hpcF9yZW1vdmUoKQ0KICAgIGludGVybmFsbHksIHdlIG5vdyBjYW4gcG90ZW50aWFs
bHkgdXNlIHRoZSBpcnFfZG9tYWluIGFmdGVyIGl0IHdhcw0KICAgIGRlc3Ryb3llZCBpbiB0aGUg
cmVtb3ZlKCkgY2FsbGJhY2sgKGFzIGRldm0gcmVzb3VyY2VzIGFyZSBmcmVlZCBhZnRlcg0KICAg
IHJlbW92ZSgpIGhhcyByZXR1cm5lZCkuDQoNCiAgICBVc2UgZGV2bV9hZGRfYWN0aW9uX29yX3Jl
c2V0KCkgdG8ga2VlcCB0aGUgb3JkZXJpbmcgcmlnaHQgYW5kIGVudGlyZWx5DQogICAga2lsbCB0
aGUgcmVtb3ZlKCkgY2FsbGJhY2sgaW4gdGhlIGRyaXZlci4NCg0KDQpjb21taXQgZDlhYTVjYTQy
OWFkMzBkZGU5NmU1OTY2MTczZDE4MDA0ZjE2ZjMxMg0KQXV0aG9yOiBBbGV4YW5kcmUgQmVsbG9u
aSA8YWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb20+DQpEYXRlOiAgIEZyaSBBcHIgMTkgMTA6
MjU6MDEgMjAxOSArMDIwMA0KDQogICAgcnRjOiBkczI0MDQ6IHNpbXBsaWZ5IC5wcm9iZSBhbmQg
cmVtb3ZlIC5yZW1vdmUNCg0KICAgIFVzZSBkZXZtX2FkZF9hY3Rpb25fb3JfcmVzZXQgdG8gc2lt
cGxpZnkgLnByb2JlIGFuZCByZW1vdmUgLnJlbW92ZQ0KDQogICAgU2lnbmVkLW9mZi1ieTogQWxl
eGFuZHJlIEJlbGxvbmkgPGFsZXhhbmRyZS5iZWxsb25pQGJvb3RsaW4uY29tPg0KDQpkcml2ZXJz
L3J0Yy9ydGMtZHMyNDA0LmMNCg0KDQpUaGFua3MsDQpBbnNvbg0K
