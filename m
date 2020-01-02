Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D93A12E4ED
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2020 11:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgABKXo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jan 2020 05:23:44 -0500
Received: from mail-eopbgr70077.outbound.protection.outlook.com ([40.107.7.77]:28966
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727990AbgABKXo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Jan 2020 05:23:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V107taH25QObswGx/2Ow5Pn9HcnUVtIxPqykG0mqC0y/gIsXGvlaJgqtt0TArSCIWl4zYI7EhYiD2H2te+ABbbcj/k5N0Hrn9v8JPPTb2Smuye5Qjl70rpGLdTSdQacp0VqDYw0m1Ve0exG44bhbZ8kfABwkvj3nwo0C+tBAaMO9VFa6igzkUT/6yiBmTTQXwOuITgocDd632Y+grIfnpUd1nfO9rqze8JV1M9XHfkWGFplhvjuXByMLQzF0xVz39Gx/xePFGPqc8RG3UYUPuWVXmM2QGAa01GInO7B6fUApFoZcY4x0Bj2s+HqGDGN9p7h53mXkbl/OyP+S2f/sBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LU3U1xETo+OP5xT654bKHXZNEAr0GKVUOFWt7dvc/E=;
 b=eE7IZb1B8na1vo17lIPB945zu8z71bgjCVVDIVCZnOPNhgNDs7qAMTk2zV+dHf5Q52qBxLfPvPXiw//P7iedor68NXBvoJLHHSu9cW1R23W9Vcb7IJxVR2x/YKlEbNCfRkXehv96QRjNbHw2prctrzGgG7JNJVhknB36hG8AoEMWhwpH4r1kxAdJ8GgLaGc1+389NB+OuFipYgM2akDGNG3J4DURhMPnQPd9e7Zq3vlAabwa/uUOWV3xNoW0GVc6FLc6MG0V/TcVJc3HuW3hnfO4I659FX/I6BIU0nevgkkSez/R/uoj56WqH1hixlFnFj4clJJimQhhctMBrdylHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LU3U1xETo+OP5xT654bKHXZNEAr0GKVUOFWt7dvc/E=;
 b=dgypYoL3G8AmOJSaqucioJQ4SNzgzX0wbLl0s1Xvf8SnO+06Yinm9fHcu63LEjnx0UHZcebVjSsced/mlncUPfIT58VHKv3V9orRvjU5vCxgYg5l4fCuww+5tDjE0DlfwlZMVe5zrnjABlIqvrDkQ3XuoA/sWXGzhQ/gEzgKZik=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.3.146) by
 VI1PR0402MB3391.eurprd04.prod.outlook.com (52.134.1.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11; Thu, 2 Jan 2020 10:23:37 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::18c:4d15:c3ab:afa6]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::18c:4d15:c3ab:afa6%7]) with mapi id 15.20.2602.012; Thu, 2 Jan 2020
 10:23:37 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Dong Aisheng <dongas86@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
CC:     Aisheng Dong <aisheng.dong@nxp.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Subject: RE: [EXT] Re: [PATCH 1/1] firmware: imx: scu-pd: do not power off
 console domain
Thread-Topic: [EXT] Re: [PATCH 1/1] firmware: imx: scu-pd: do not power off
 console domain
Thread-Index: AQHVwVVvimHeKrn5bUqdRj0rwVqzOKfXKM+g
Date:   Thu, 2 Jan 2020 10:23:37 +0000
Message-ID: <VI1PR0402MB3600F2E6D24F8D0D522415D9FF200@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <1573995924-14752-1-git-send-email-aisheng.dong@nxp.com>
 <CAPDyKFrkRPuJ5+1sdLevY9tqO6CoKQu6eGDKGpbYoqOUaghnPA@mail.gmail.com>
 <CAA+hA=Rsje8mW6sqfiiYKQzwz_3F88+AdJZoN5ZHShqnOqkUQw@mail.gmail.com>
In-Reply-To: <CAA+hA=Rsje8mW6sqfiiYKQzwz_3F88+AdJZoN5ZHShqnOqkUQw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a3270c9c-1d15-4aa4-cc4c-08d78f6dd49a
x-ms-traffictypediagnostic: VI1PR0402MB3391:|VI1PR0402MB3391:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB339178A145768C3917E8981DFF200@VI1PR0402MB3391.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-forefront-prvs: 0270ED2845
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(366004)(376002)(39850400004)(346002)(189003)(199004)(71200400001)(110136005)(54906003)(33656002)(4326008)(52536014)(26005)(5660300002)(186003)(2906002)(478600001)(8676002)(86362001)(64756008)(66556008)(66476007)(6636002)(7696005)(8936002)(55016002)(81156014)(66946007)(81166006)(53546011)(316002)(76116006)(66446008)(9686003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3391;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LIoqoThC/A9YMorWtEutfOdwL6KzjwwS0SslUG18fzLDGE1dnIrsCH4+ZxCgsWfjwKcwf4WA98yTtpvQRkzS673TSUk1szX8khW3RcfyBtMiV2GHVCuiohhacTPd15ixL4UBs9SvidF/p4y6oN8xQVEjkEigLdwG7ARO6S+Ik0MLFD3RZWSVm/0oBCVNKrNZ88NkYA9bPZsatO/vL2OKGOuWEpA7fmBIxhyZXySaPj9nFnl/AznS8JBPJ/a6qD2t239rpvlJ1DoP7+GampSNxLwpFEyuETjT4IPtdb+SNdirCUD+XPjNMMZ2I9qJfpqvx/2NoDj/qROm0zPVmiLNY8uy38ONwQYIz/FcEjsZhN7X7jKsrnegVe/ihHj23EIHnAMrH+ypqfuwhicKyo3oCs3rl15PLjK+4AgxQl0tvTlzFyNFIzv5nLMdb2W9/on8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3270c9c-1d15-4aa4-cc4c-08d78f6dd49a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2020 10:23:37.5607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RMroYmjrgzBYiuOtZ18dKP4U8gYKWVbxSg797mVaV3pDyz+zJNug534Gu1k6mvTvnSHdvPF9BSOzWoPEqR73Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3391
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RnJvbTogRG9uZyBBaXNoZW5nIDxkb25nYXM4NkBnbWFpbC5jb20+IFNlbnQ6IFRodXJzZGF5LCBK
YW51YXJ5IDIsIDIwMjAgNjowMyBQTQ0KPiBPbiBUdWUsIE5vdiAxOSwgMjAxOSBhdCAxMjoxMyBB
TSBVbGYgSGFuc3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz4NCj4gd3JvdGU6DQo+ID4NCj4g
PiBPbiBTdW4sIDE3IE5vdiAyMDE5IGF0IDE0OjA3LCBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9u
Z0BueHAuY29tPg0KPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBEbyBub3QgcG93ZXIgb2ZmIGNvbnNv
bGUgZG9tYWluIGluIHJ1bnRpbWUgcG0uDQo+ID4NCj4gPiBXb3VsZCBpdCBiZSBwb3NzaWJsZSB0
byBjb25maWd1cmUgYSByZW1vdGUgd2FrZXVwIGZvciB0aGUgY29uc29sZQ0KPiA+IHdoaWxlIHRo
ZSBkZXZpY2UgYmVjb21lcyBydW50aW1lIHN1c3BlbmRlZCwgcmF0aGVyIHRoYW4gcHJldmVudGlu
ZyB0aGUNCj4gPiBwb3dlciBvZmYgYWx0b2dldGhlcj8NCg0KRnJvbSBIVyB2aWV3LCB0aGUgd2Fr
ZXVwIGZlYXR1cmVzIHJlcXVpcmVzIHBvd2VyIG9uLCBidXQgY2xvY2tzIGNhbiBiZSBvZmYuDQoN
CkluIGZhY3QsIHRoZSBzdGFuZGFyZCBmbG93IGlzIHBvd2VyIGRvbWFpbiBkcml2ZXIgc2hvdWxk
IG5vdCBwb3dlciBvZmYgdGhlIGRldmljZXMNCnRoYXQgZW5hYmxlIHRoZSB3YWtldXAgZmVhdHVy
ZS4NCg0KTlhQIGludGVybmFsIHRyZWUgYWxyZWFkeSBzdXBwb3J0ZWQgcnVudGltZSBwbS4gSSB3
aWxsIHVwc3RyZWFtIHRoZSBwYXRjaC4NCg0KQW5keQ0KPiA+DQo+IA0KPiBSZW1vdGUgd2FrZXVw
IHVzdWFsbHkgcmVxdWlyZXMgY2xvY2sgYW5kIHBvd2VyLg0KPiBOb3Qgc3VyZSBpZiB0aGlzIGRl
dmljZSBjYW4gc3VwcG9ydCBpdC4gQ29weSBtb2R1bGUgb3duZXIgKEZ1Z2FuZw0KPiBEdWFuKSB0
byBjb25maXJtLg0KPiANCj4gVGhlIGN1cnJlbnQgbHB1YXJ0IGRyaXZlciBzZWVtcyBub3Qgc3Vw
cG9ydC4NCj4gDQo+IFJlZ2FyZHMNCj4gQWlzaGVuZw0KPiANCj4gPiBLaW5kIHJlZ2FyZHMNCj4g
PiBVZmZlDQo+ID4NCj4gPiA+DQo+ID4gPiBDYzogU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwu
b3JnPg0KPiA+ID4gQ2M6IFBlbmd1dHJvbml4IEtlcm5lbCBUZWFtIDxrZXJuZWxAcGVuZ3V0cm9u
aXguZGU+DQo+ID4gPiBDYzogVWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+DQo+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0K
PiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9maXJtd2FyZS9pbXgvc2N1LXBkLmMgfCAyOCArKysr
KysrKysrKysrKysrKysrKysrKysrKystDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDI3IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9maXJtd2FyZS9pbXgvc2N1LXBkLmMNCj4gPiA+IGIvZHJpdmVycy9maXJtd2FyZS9pbXgvc2N1
LXBkLmMgaW5kZXggYjU1NjYxMjIwN2U1Li43NzBlMzY4MWJiYmYNCj4gPiA+IDEwMDY0NA0KPiA+
ID4gLS0tIGEvZHJpdmVycy9maXJtd2FyZS9pbXgvc2N1LXBkLmMNCj4gPiA+ICsrKyBiL2RyaXZl
cnMvZmlybXdhcmUvaW14L3NjdS1wZC5jDQo+ID4gPiBAQCAtODUsNiArODUsOCBAQCBzdHJ1Y3Qg
aW14X3NjX3BkX3NvYyB7DQo+ID4gPiAgICAgICAgIHU4IG51bV9yYW5nZXM7DQo+ID4gPiAgfTsN
Cj4gPiA+DQo+ID4gPiAraW50IGlteF9jb25fcnNyYzsNCj4gPiA+ICsNCj4gPiA+ICBzdGF0aWMg
Y29uc3Qgc3RydWN0IGlteF9zY19wZF9yYW5nZSBpbXg4cXhwX3NjdV9wZF9yYW5nZXNbXSA9IHsN
Cj4gPiA+ICAgICAgICAgLyogTFNJTyBTUyAqLw0KPiA+ID4gICAgICAgICB7ICJwd20iLCBJTVhf
U0NfUl9QV01fMCwgOCwgdHJ1ZSwgMCB9LCBAQCAtMTczLDYgKzE3NSwyMw0KPiBAQA0KPiA+ID4g
dG9faW14X3NjX3BkKHN0cnVjdCBnZW5lcmljX3BtX2RvbWFpbiAqZ2VucGQpDQo+ID4gPiAgICAg
ICAgIHJldHVybiBjb250YWluZXJfb2YoZ2VucGQsIHN0cnVjdCBpbXhfc2NfcG1fZG9tYWluLCBw
ZCk7ICB9DQo+ID4gPg0KPiA+ID4gK3N0YXRpYyB2b2lkIGlteF9zY19wZF9nZXRfY29uc29sZV9y
c3JjKHZvaWQpIHsNCj4gPiA+ICsgICAgICAgc3RydWN0IG9mX3BoYW5kbGVfYXJncyBzcGVjczsN
Cj4gPiA+ICsgICAgICAgaW50IHJldDsNCj4gPiA+ICsNCj4gPiA+ICsgICAgICAgaWYgKCFvZl9z
dGRvdXQpDQo+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuOw0KPiA+ID4gKw0KPiA+ID4gKyAg
ICAgICByZXQgPSBvZl9wYXJzZV9waGFuZGxlX3dpdGhfYXJncyhvZl9zdGRvdXQsICJwb3dlci1k
b21haW5zIiwNCj4gPiA+ICsNCj4gIiNwb3dlci1kb21haW4tY2VsbHMiLA0KPiA+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwLCAmc3BlY3MpOw0KPiA+ID4gKyAg
ICAgICBpZiAocmV0KQ0KPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVybjsNCj4gPiA+ICsNCj4g
PiA+ICsgICAgICAgaW14X2Nvbl9yc3JjID0gc3BlY3MuYXJnc1swXTsgfQ0KPiA+ID4gKw0KPiA+
ID4gIHN0YXRpYyBpbnQgaW14X3NjX3BkX3Bvd2VyKHN0cnVjdCBnZW5lcmljX3BtX2RvbWFpbiAq
ZG9tYWluLCBib29sDQo+ID4gPiBwb3dlcl9vbikgIHsNCj4gPiA+ICAgICAgICAgc3RydWN0IGlt
eF9zY19tc2dfcmVxX3NldF9yZXNvdXJjZV9wb3dlcl9tb2RlIG1zZzsgQEANCj4gLTIzMyw2DQo+
ID4gPiArMjUyLDcgQEAgaW14X3NjdV9hZGRfcG1fZG9tYWluKHN0cnVjdCBkZXZpY2UgKmRldiwg
aW50IGlkeCwNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3QgaW14X3Nj
X3BkX3JhbmdlICpwZF9yYW5nZXMpICB7DQo+ID4gPiAgICAgICAgIHN0cnVjdCBpbXhfc2NfcG1f
ZG9tYWluICpzY19wZDsNCj4gPiA+ICsgICAgICAgYm9vbCBpc19vZmYgPSB0cnVlOw0KPiA+ID4g
ICAgICAgICBpbnQgcmV0Ow0KPiA+ID4NCj4gPiA+ICAgICAgICAgc2NfcGQgPSBkZXZtX2t6YWxs
b2MoZGV2LCBzaXplb2YoKnNjX3BkKSwgR0ZQX0tFUk5FTCk7IEBADQo+ID4gPiAtMjUxLDYgKzI3
MSwxMCBAQCBpbXhfc2N1X2FkZF9wbV9kb21haW4oc3RydWN0IGRldmljZSAqZGV2LCBpbnQgaWR4
LA0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICIlcyIsIHBkX3Jhbmdlcy0+bmFtZSk7
DQo+ID4gPg0KPiA+ID4gICAgICAgICBzY19wZC0+cGQubmFtZSA9IHNjX3BkLT5uYW1lOw0KPiA+
ID4gKyAgICAgICBpZiAoaW14X2Nvbl9yc3JjID09IHNjX3BkLT5yc3JjKSB7DQo+ID4gPiArICAg
ICAgICAgICAgICAgc2NfcGQtPnBkLmZsYWdzID0gR0VOUERfRkxBR19SUE1fQUxXQVlTX09OOw0K
PiA+ID4gKyAgICAgICAgICAgICAgIGlzX29mZiA9IGZhbHNlOw0KPiA+ID4gKyAgICAgICB9DQo+
ID4gPg0KPiA+ID4gICAgICAgICBpZiAoc2NfcGQtPnJzcmMgPj0gSU1YX1NDX1JfTEFTVCkgew0K
PiA+ID4gICAgICAgICAgICAgICAgIGRldl93YXJuKGRldiwgImludmFsaWQgcGQgJXMgcnNyYyBp
ZCAlZCBmb3VuZCIsIEBADQo+ID4gPiAtMjYwLDcgKzI4NCw3IEBAIGlteF9zY3VfYWRkX3BtX2Rv
bWFpbihzdHJ1Y3QgZGV2aWNlICpkZXYsIGludCBpZHgsDQo+ID4gPiAgICAgICAgICAgICAgICAg
cmV0dXJuIE5VTEw7DQo+ID4gPiAgICAgICAgIH0NCj4gPiA+DQo+ID4gPiAtICAgICAgIHJldCA9
IHBtX2dlbnBkX2luaXQoJnNjX3BkLT5wZCwgTlVMTCwgdHJ1ZSk7DQo+ID4gPiArICAgICAgIHJl
dCA9IHBtX2dlbnBkX2luaXQoJnNjX3BkLT5wZCwgTlVMTCwgaXNfb2ZmKTsNCj4gPiA+ICAgICAg
ICAgaWYgKHJldCkgew0KPiA+ID4gICAgICAgICAgICAgICAgIGRldl93YXJuKGRldiwgImZhaWxl
ZCB0byBpbml0IHBkICVzIHJzcmMgaWQgJWQiLA0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgIHNjX3BkLT5uYW1lLCBzY19wZC0+cnNyYyk7IEBAIC0zMjYsNg0KPiArMzUwLDgNCj4gPiA+
IEBAIHN0YXRpYyBpbnQgaW14X3NjX3BkX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpDQo+ID4gPiAgICAgICAgIGlmICghcGRfc29jKQ0KPiA+ID4gICAgICAgICAgICAgICAgIHJl
dHVybiAtRU5PREVWOw0KPiA+ID4NCj4gPiA+ICsgICAgICAgaW14X3NjX3BkX2dldF9jb25zb2xl
X3JzcmMoKTsNCj4gPiA+ICsNCj4gPiA+ICAgICAgICAgcmV0dXJuIGlteF9zY3VfaW5pdF9wbV9k
b21haW5zKCZwZGV2LT5kZXYsIHBkX3NvYyk7ICB9DQo+ID4gPg0KPiA+ID4gLS0NCj4gPiA+IDIu
MjMuMA0KPiA+ID4NCg==
