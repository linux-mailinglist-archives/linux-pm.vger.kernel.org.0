Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 996F7182F8F
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 12:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgCLLri (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Mar 2020 07:47:38 -0400
Received: from mail-eopbgr70075.outbound.protection.outlook.com ([40.107.7.75]:51662
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726558AbgCLLri (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 12 Mar 2020 07:47:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrtmlZ9PCmdpnTWV6KVJQnybiLNMbgYi4jFJkx2g83tgN96Djnqhx0ZWL4wCI8833CKUuNS56QnHdvQnqDk4DDJMAo3FZBZm6o5jg+57iF4mNToJIhnISIrUlYiCKJpp3gf3g9m3AsxVTijNkyZm2Jehpg+qv7jbz51fLGJ1SV54qJloiefBpWEOdMLTtXtsWzdUXFVxD6m653Yc3RxXyjldBGCbiAvPpUqWxnKfe2ty7MM093GI4Qsf96fY4EKudBkaJt0sQjGE4+neF7heC8T+g0ypWJ04cIdrAqnMZK+izeMLloGwBQmcoxpkzKu+CoYQjRU1Xehkz4ounL0SXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptw2WnV+F+55CXSNa8f0E0GvSndIFoHLkN5rydAAfB8=;
 b=HJ98OqXn609isoFX7CgefmdGU57bawTtYeKL8sHUOkrnTZoffyd0OZsfU6KIHEeszYQqRrDqNXN0eYM0QMVvXUbfvDkXmPFLS0ajY1TtzK1tirVqMe0f/fw6QavUX5fLYy480mrvlXj4TYaW9u1ML8hsyq8RkSKO6IjWVRy59fBIe4qy138yw4+rY8HUWDZ0gCDl44x9KI10THqft50LT1GqErM89YbDLiWNvKFbisn9k/yRJwKVO6mDpijdEaxmHxMtlywIw1LNvLLjqLYFj+t7gIF3UmzGrzjFiPmprttoDjFL8N4pWOoTioAgCqVmtipL0lthimyUz+b68hWjlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptw2WnV+F+55CXSNa8f0E0GvSndIFoHLkN5rydAAfB8=;
 b=QO2WJ7Ro35uMC6uxNLQDX84/H3bOVKCHPjp8ioM0CqtPw0xd54vcWrcfwPSybz1cEmg1dUwX+gX+CD8gSUfjI41mjuO7meWYJzRCIp0QNdJhExNYufj4wGQQ7nHlOJQ4sYVIuSGjVbxwJd+cIUfccnPAN91+SQfOssGZF9sdyEU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3642.eurprd04.prod.outlook.com (52.134.65.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Thu, 12 Mar 2020 11:47:34 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b%7]) with mapi id 15.20.2814.007; Thu, 12 Mar 2020
 11:47:33 +0000
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
Thread-Index: AQHV92PgUEO+4yjn2k6lxrr+i2btw6hE0roAgAAGWwA=
Date:   Thu, 12 Mar 2020 11:47:33 +0000
Message-ID: <DB3PR0402MB3916BF7EF180809EC374CC7CF5FD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1583903252-2058-1-git-send-email-Anson.Huang@nxp.com>
 <c4c2d976-4fe6-bdf3-e110-90d1600566a3@linaro.org>
In-Reply-To: <c4c2d976-4fe6-bdf3-e110-90d1600566a3@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fa7e22a9-de24-433d-805c-08d7c67b2752
x-ms-traffictypediagnostic: DB3PR0402MB3642:|DB3PR0402MB3642:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB364210574AFC5092B2DD1126F5FD0@DB3PR0402MB3642.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(199004)(26005)(6506007)(110136005)(52536014)(7696005)(5660300002)(2906002)(8936002)(44832011)(53546011)(33656002)(9686003)(55016002)(478600001)(4326008)(316002)(8676002)(81156014)(186003)(71200400001)(86362001)(66446008)(76116006)(66476007)(66946007)(66556008)(64756008)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3642;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zSkxLwUrLtPyyeb4pyWjzs7uJ2aGUXLmJtF98escHiT7tOIsGQwcSEKEDt/YmuuEtgB3zjLyPi9r+RQ2lblkc9D8xJK9zsHKoBq/+1tTTBlUOvB4loNEhWl30uy0aXi6Ivn9drTxafItycnv51tU0l4OHy+RvXs0f0QxqPx61lVQ4+lQ3QBjyeqOrwAiGzeLlMcWt6qeqv1z0rxfgWW42OwNdO2h94NRtReamrH+N421ohrjJhsig+zhj7A7MdxwJpwmkFaCwm5fU7lEfJjdhv02gbUjeB1ebq3fSTq2gZzqbWqDuUAQoXQ8S4lQkV6wzKFYGwVrsDcp8wsIbSFo0TUXh2Xy1bOtnsr9kJxVojZnrFtls5MvlqPLgIyS5V6rQDx8Jz3YT4wEqAJXLALvRbKbtalYj+vrtDuBKBSCegWv9X9l2/f6F4QDx2fsBO2RVqAdfhJ5cCyQxImpTl6BJjMGKt8Z3QRNB4ufEtrz2u3hVJNgSVSNEkg4Sw3e6tdV7+dkKzUKVnbJjlJ8MBaTwimKevH2lT5SGzzA4U5x5lHFJKMT7i2odPAshPpT8JcyoT6FotSPQICW1O/LlRmLD6ewxoI8p1K3/jg4pqTzq6VAbdVGNEOYfVt39zksHjto
x-ms-exchange-antispam-messagedata: 4sy/nF9ZAMQ5Ydvt4DvWLZdNUCAeNkP2/91AgPCkdDgqm3/zQlpT5jCFg/yRRkvQqdYLpo3XVfGPCMdhvAywHCeQCvGZdkjxYUj7Nes2NlJpcCD9gZcT0eeFZ129ukGfgtQWrTGodiWuDKjHyM3d2w==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7e22a9-de24-433d-805c-08d7c67b2752
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 11:47:33.7910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MbUqMNli62++JtQ6VEeZKA+6yCL2scaxQdb5EWw2ZgBMGO/1N9VtjzwG7rmvWypIVLpG6zg1aE2Ghfp+EKtrbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3642
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIERhbmllbA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSB0aGVybWFsOiBxb3JpcTog
VXNlIGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldCgpIHRvDQo+IGhhbmRsZSBhbGwgY2xlYW51cHMN
Cj4gDQo+IE9uIDExLzAzLzIwMjAgMDY6MDcsIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+IFVzZSBk
ZXZtX2FkZF9hY3Rpb25fb3JfcmVzZXQoKSB0byBoYW5kbGUgYWxsIGNsZWFudXBzIG9mIGZhaWx1
cmUgaW4NCj4gPiAucHJvYmUgYW5kIC5yZW1vdmUsIHRoZW4gLnJlbW92ZSBjYWxsYmFjayBjYW4g
YmUgZHJvcHBlZC4NCj4gDQo+IElzIHRoaXMgY2hhbmdlIGNvbXBhdGlibGUgd2l0aCB0aGUgdHJp
c3RhdGU/DQoNCkkgdGhpbmsgc28sIGFueSBjb25jZXJuIG5lZWQgbWUgdG8gZG91YmxlIGNvbmZp
cm0/DQoNClRoYW5rcywNCkFuc29uDQoNCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVh
bmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvdGhlcm1hbC9x
b3JpcV90aGVybWFsLmMgfCAzNQ0KPiA+ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAyMSBkZWxldGlvbnMo
LSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwvcW9yaXFfdGhlcm1hbC5j
DQo+ID4gYi9kcml2ZXJzL3RoZXJtYWwvcW9yaXFfdGhlcm1hbC5jIGluZGV4IDg3NGJjNDYuLjY3
YThkODQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy90aGVybWFsL3FvcmlxX3RoZXJtYWwuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvdGhlcm1hbC9xb3JpcV90aGVybWFsLmMNCj4gPiBAQCAtMjI4LDYg
KzIyOCwxNCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHJlZ21hcF9hY2Nlc3NfdGFibGUNCj4gcW9y
aXFfcmRfdGFibGUgPSB7DQo+ID4gIAkubl95ZXNfcmFuZ2VzCT0gQVJSQVlfU0laRShxb3JpcV95
ZXNfcmFuZ2VzKSwNCj4gPiAgfTsNCj4gPg0KPiA+ICtzdGF0aWMgdm9pZCBxb3JpcV90bXVfYWN0
aW9uKHZvaWQgKnApIHsNCj4gPiArCXN0cnVjdCBxb3JpcV90bXVfZGF0YSAqZGF0YSA9IHA7DQo+
ID4gKw0KPiA+ICsJcmVnbWFwX3dyaXRlKGRhdGEtPnJlZ21hcCwgUkVHU19UTVIsIFRNUl9ESVNB
QkxFKTsNCj4gPiArCWNsa19kaXNhYmxlX3VucHJlcGFyZShkYXRhLT5jbGspOw0KPiA+ICt9DQo+
ID4gKw0KPiA+ICBzdGF0aWMgaW50IHFvcmlxX3RtdV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KSAgew0KPiA+ICAJaW50IHJldDsNCj4gPiBAQCAtMjc4LDYgKzI4NiwxMCBAQCBz
dGF0aWMgaW50IHFvcmlxX3RtdV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2
KQ0KPiA+ICAJCXJldHVybiByZXQ7DQo+ID4gIAl9DQo+ID4NCj4gPiArCXJldCA9IGRldm1fYWRk
X2FjdGlvbl9vcl9yZXNldChkZXYsIHFvcmlxX3RtdV9hY3Rpb24sIGRhdGEpOw0KPiA+ICsJaWYg
KHJldCkNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsNCj4gPiAgCS8qIHZlcnNpb24gcmVnaXN0
ZXIgb2Zmc2V0IGF0OiAweGJmOCBvbiBib3RoIHYxIGFuZCB2MiAqLw0KPiA+ICAJcmV0ID0gcmVn
bWFwX3JlYWQoZGF0YS0+cmVnbWFwLCBSRUdTX0lQQlJSKDApLCAmdmVyKTsNCj4gPiAgCWlmIChy
ZXQpIHsNCj4gPiBAQCAtMjkwLDM1ICszMDIsMTcgQEAgc3RhdGljIGludCBxb3JpcV90bXVfcHJv
YmUoc3RydWN0DQo+ID4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+DQo+ID4gIAlyZXQgPSBx
b3JpcV90bXVfY2FsaWJyYXRpb24oZGV2LCBkYXRhKTsJLyogVE1VIGNhbGlicmF0aW9uICovDQo+
ID4gIAlpZiAocmV0IDwgMCkNCj4gPiAtCQlnb3RvIGVycjsNCj4gPiArCQlyZXR1cm4gcmV0Ow0K
PiA+DQo+ID4gIAlyZXQgPSBxb3JpcV90bXVfcmVnaXN0ZXJfdG11X3pvbmUoZGV2LCBkYXRhKTsN
Cj4gPiAgCWlmIChyZXQgPCAwKSB7DQo+ID4gIAkJZGV2X2VycihkZXYsICJGYWlsZWQgdG8gcmVn
aXN0ZXIgc2Vuc29yc1xuIik7DQo+ID4gLQkJcmV0ID0gLUVOT0RFVjsNCj4gPiAtCQlnb3RvIGVy
cjsNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICAJfQ0KPiA+DQo+ID4gIAlwbGF0Zm9ybV9zZXRf
ZHJ2ZGF0YShwZGV2LCBkYXRhKTsNCj4gPg0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gLQ0KPiA+IC1l
cnI6DQo+ID4gLQljbGtfZGlzYWJsZV91bnByZXBhcmUoZGF0YS0+Y2xrKTsNCj4gPiAtDQo+ID4g
LQlyZXR1cm4gcmV0Ow0KPiA+IC19DQo+ID4gLQ0KPiA+IC1zdGF0aWMgaW50IHFvcmlxX3RtdV9y
ZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikgLXsNCj4gPiAtCXN0cnVjdCBxb3Jp
cV90bXVfZGF0YSAqZGF0YSA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOw0KPiA+IC0NCj4g
PiAtCS8qIERpc2FibGUgbW9uaXRvcmluZyAqLw0KPiA+IC0JcmVnbWFwX3dyaXRlKGRhdGEtPnJl
Z21hcCwgUkVHU19UTVIsIFRNUl9ESVNBQkxFKTsNCj4gPiAtDQo+ID4gLQljbGtfZGlzYWJsZV91
bnByZXBhcmUoZGF0YS0+Y2xrKTsNCj4gPiAtDQo+ID4gLQlyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+
DQo+ID4gIHN0YXRpYyBpbnQgX19tYXliZV91bnVzZWQgcW9yaXFfdG11X3N1c3BlbmQoc3RydWN0
IGRldmljZSAqZGV2KSBAQA0KPiA+IC0zNjUsNyArMzU5LDYgQEAgc3RhdGljIHN0cnVjdCBwbGF0
Zm9ybV9kcml2ZXIgcW9yaXFfdG11ID0gew0KPiA+ICAJCS5vZl9tYXRjaF90YWJsZQk9IHFvcmlx
X3RtdV9tYXRjaCwNCj4gPiAgCX0sDQo+ID4gIAkucHJvYmUJPSBxb3JpcV90bXVfcHJvYmUsDQo+
ID4gLQkucmVtb3ZlCT0gcW9yaXFfdG11X3JlbW92ZSwNCj4gPiAgfTsNCj4gPiAgbW9kdWxlX3Bs
YXRmb3JtX2RyaXZlcihxb3JpcV90bXUpOw0KPiA+DQo+ID4NCj4gDQo+IA0KPiAtLQ0KPiANCj4g
PGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRw
JTNBJTJGJTJGd3d3Lg0KPiBsaW5hcm8ub3JnJTJGJmFtcDtkYXRhPTAyJTdDMDElN0NBbnNvbi5I
dWFuZyU0MG54cC5jb20lN0MzN2VhMw0KPiAxNDU2NDJiNDdiNGRmNzIwOGQ3YzY3N2U1N2QlN0M2
ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3DQo+IEMwJTdDMCU3QzYzNzE5NjA5MDU1
ODQ0ODgxMyZhbXA7c2RhdGE9JTJGQ2ZIOEdQeGQ1N0NEbGF1MXBNY3ENCj4gTEg3R2pHSWglMkZ1
JTJCZnE3dGVHc1M4S00lM0QmYW1wO3Jlc2VydmVkPTA+IExpbmFyby5vcmcg4pSCIE9wZW4NCj4g
c291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29Dcw0KPiANCj4gRm9sbG93IExpbmFybzoNCj4gPGh0
dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNB
JTJGJTJGd3d3Lg0KPiBmYWNlYm9vay5jb20lMkZwYWdlcyUyRkxpbmFybyZhbXA7ZGF0YT0wMiU3
QzAxJTdDQW5zb24uSHVhbmclNA0KPiAwbnhwLmNvbSU3QzM3ZWEzMTQ1NjQyYjQ3YjRkZjcyMDhk
N2M2NzdlNTdkJTdDNjg2ZWExZDNiYzJiNGM2ZmENCj4gOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAl
N0M2MzcxOTYwOTA1NTg0NDg4MTMmYW1wO3NkYXRhPUtCVVdwVA0KPiA0cXVxbzA4cjhZaGJNVmsl
MkZ5ZjJqSVQxQ0tnYzVpM2pJOWdDd28lM0QmYW1wO3Jlc2VydmVkPTA+DQo+IEZhY2Vib29rIHwN
Cj4gPGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1o
dHRwJTNBJTJGJTJGdHdpdHRlDQo+IHIuY29tJTJGJTIzISUyRmxpbmFyb29yZyZhbXA7ZGF0YT0w
MiU3QzAxJTdDQW5zb24uSHVhbmclNDBueHAuYw0KPiBvbSU3QzM3ZWEzMTQ1NjQyYjQ3YjRkZjcy
MDhkN2M2NzdlNTdkJTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOQ0KPiA5YzVjMzAxNjM1JTdDMCU3
QzAlN0M2MzcxOTYwOTA1NTg0NDg4MTMmYW1wO3NkYXRhPSUyRkVnZVJNV2QNCj4gcWJiYU9NbDJU
ZmIlMkJ0TG1mdHRxTjFXY0ZibDklMkI1dFh0T2ljJTNEJmFtcDtyZXNlcnZlZD0wPg0KPiBUd2l0
dGVyIHwNCj4gPGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20v
P3VybD1odHRwJTNBJTJGJTJGd3d3Lg0KPiBsaW5hcm8ub3JnJTJGbGluYXJvLQ0KPiBibG9nJTJG
JmFtcDtkYXRhPTAyJTdDMDElN0NBbnNvbi5IdWFuZyU0MG54cC5jb20lN0MzN2VhMzE0NTY0DQo+
IDJiNDdiNGRmNzIwOGQ3YzY3N2U1N2QlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYz
NSU3QzAlNw0KPiBDMCU3QzYzNzE5NjA5MDU1ODQ0ODgxMyZhbXA7c2RhdGE9U1hab3clMkYwQiUy
QklncGZPZkFVSUcxTnNSDQo+IG1jSHA4Njh2ZSUyRmZrZWpnM1pEdkUlM0QmYW1wO3Jlc2VydmVk
PTA+IEJsb2cNCg0K
