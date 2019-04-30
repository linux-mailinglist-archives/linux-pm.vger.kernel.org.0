Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB30BFC29
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 17:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfD3PGT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 11:06:19 -0400
Received: from mail-eopbgr50089.outbound.protection.outlook.com ([40.107.5.89]:30126
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725995AbfD3PGS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 30 Apr 2019 11:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ig1Wrbhoin6EXNLkp5xNBfhV8s78xH9gLtnPEZMutrQ=;
 b=EsAuthXkizoIxqPHR5nj58R417bZ10F6nTSeNHjVU6ypx9iHnwsynoeuQY3kPhowIyb7gYpTQTC0vKAEk0BhVayL53M3RaPxOo2QM8re2cJC/C9KLXtnj5LMEpLxFTPPtST/5eZSQGLyikGaptHq+X7UK0x6y7YGdBJA67VYd1I=
Received: from AM6PR04MB6440.eurprd04.prod.outlook.com (20.179.244.217) by
 AM6PR04MB5895.eurprd04.prod.outlook.com (20.179.3.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Tue, 30 Apr 2019 15:06:11 +0000
Received: from AM6PR04MB6440.eurprd04.prod.outlook.com
 ([fe80::14c2:1e08:524c:6ff4]) by AM6PR04MB6440.eurprd04.prod.outlook.com
 ([fe80::14c2:1e08:524c:6ff4%2]) with mapi id 15.20.1856.008; Tue, 30 Apr 2019
 15:06:11 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
CC:     Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 1/2] PM / Domains: Add GENPD_FLAG_RPM_ALWAYS_ON flag
Thread-Topic: [PATCH v5 1/2] PM / Domains: Add GENPD_FLAG_RPM_ALWAYS_ON flag
Thread-Index: AQHU/2Y/h66odknpyEW0dAeBUTxZEg==
Date:   Tue, 30 Apr 2019 15:06:11 +0000
Message-ID: <30247a52be55c3cb31d16b8ac0710d3ad51eea09.1556636234.git.leonard.crestez@nxp.com>
References: <cover.1556636234.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1556636234.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [89.37.124.34]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: VI1PR0902CA0058.eurprd09.prod.outlook.com
 (2603:10a6:802:1::47) To AM6PR04MB6440.eurprd04.prod.outlook.com
 (2603:10a6:20b:f4::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c57fd939-aadd-4ef0-70ed-08d6cd7d61ac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB5895;
x-ms-traffictypediagnostic: AM6PR04MB5895:
x-microsoft-antispam-prvs: <AM6PR04MB5895E710A9B63C31332F46FCEE3A0@AM6PR04MB5895.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(366004)(346002)(39860400002)(199004)(189003)(8936002)(81156014)(25786009)(81166006)(8676002)(6486002)(36756003)(478600001)(52116002)(6116002)(68736007)(3846002)(4326008)(2906002)(186003)(305945005)(102836004)(53936002)(26005)(386003)(476003)(7736002)(2616005)(486006)(11346002)(44832011)(73956011)(76176011)(6512007)(6436002)(50226002)(6506007)(64756008)(66556008)(66446008)(66476007)(66946007)(71190400001)(14444005)(256004)(446003)(71200400001)(110136005)(54906003)(97736004)(99286004)(5660300002)(118296001)(14454004)(66066001)(316002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5895;H:AM6PR04MB6440.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +KgWLs9wjNSvj3YeU79N8EjI9BcArJgCBSyS/65m/JZ7afHF+OYsWBYXCH0AkseGzq7b64AToMGocxGllIWOSe8djPWX1zogtjrWP7ozmJX6gmNMCTlAeJCdOdjTC2T033hxzkYC4YKMeo8Bu2ADKUGGwzCqgDjBlEPJIxOTxDLbetA7WVs3sZxk6JiPzOD+dgp0WyIAxCAiFPwePk/lCNXnkcuX8FWApFeMbSjQj9oT/uxrIFJCXE/0UqYXyURRBXFP+tbLc1CH7bDmKR9Ea2jG0/q0+lO8XB9Lbm5VNqS4K8aGts7enetn0stfvJRTwfXAV6glZnr0B2nvW4i7/zWO+FUD0qw/FUNuSF3jv7oLhp/R629rGIods1811lco/IvSvFDfxdl4+qqTiE+rYpzQVe3v3zJkLLJy7kOvS50=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c57fd939-aadd-4ef0-70ed-08d6cd7d61ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 15:06:11.5252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5895
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhpcyBpcyBmb3IgcG93ZXIgZG9tYWlucyB3aGljaCBjYW4gb25seSBiZSBwb3dlcmVkIG9mZiBm
b3Igc3VzcGVuZCBidXQNCm5vdCBhcyBwYXJ0IG9mIHJ1bnRpbWUgUE0uDQoNClN1Z2dlc3RlZC1i
eTogVWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+DQpTaWduZWQtb2ZmLWJ5OiBM
ZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPg0KLS0tDQogZHJpdmVycy9i
YXNlL3Bvd2VyL2RvbWFpbi5jIHwgOCArKysrKystLQ0KIGluY2x1ZGUvbGludXgvcG1fZG9tYWlu
LmggICB8IDQgKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmFzZS9wb3dlci9kb21haW4uYyBiL2Ry
aXZlcnMvYmFzZS9wb3dlci9kb21haW4uYw0KaW5kZXggN2E2YWEyMzE4OTE1Li4zM2MzMGMxZTZh
MzAgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Jhc2UvcG93ZXIvZG9tYWluLmMNCisrKyBiL2RyaXZl
cnMvYmFzZS9wb3dlci9kb21haW4uYw0KQEAgLTEyNiwxMCArMTI2LDExIEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgZ2VucGRfbG9ja19vcHMgZ2VucGRfc3Bpbl9vcHMgPSB7DQogI2RlZmluZSBnZW5w
ZF9zdGF0dXNfb24oZ2VucGQpCQkoZ2VucGQtPnN0YXR1cyA9PSBHUERfU1RBVEVfQUNUSVZFKQ0K
ICNkZWZpbmUgZ2VucGRfaXNfaXJxX3NhZmUoZ2VucGQpCShnZW5wZC0+ZmxhZ3MgJiBHRU5QRF9G
TEFHX0lSUV9TQUZFKQ0KICNkZWZpbmUgZ2VucGRfaXNfYWx3YXlzX29uKGdlbnBkKQkoZ2VucGQt
PmZsYWdzICYgR0VOUERfRkxBR19BTFdBWVNfT04pDQogI2RlZmluZSBnZW5wZF9pc19hY3RpdmVf
d2FrZXVwKGdlbnBkKQkoZ2VucGQtPmZsYWdzICYgR0VOUERfRkxBR19BQ1RJVkVfV0FLRVVQKQ0K
ICNkZWZpbmUgZ2VucGRfaXNfY3B1X2RvbWFpbihnZW5wZCkJKGdlbnBkLT5mbGFncyAmIEdFTlBE
X0ZMQUdfQ1BVX0RPTUFJTikNCisjZGVmaW5lIGdlbnBkX2lzX3JwbV9hbHdheXNfb24oZ2VucGQp
CShnZW5wZC0+ZmxhZ3MgJiBHRU5QRF9GTEFHX1JQTV9BTFdBWVNfT04pDQogDQogc3RhdGljIGlu
bGluZSBib29sIGlycV9zYWZlX2Rldl9pbl9ub19zbGVlcF9kb21haW4oc3RydWN0IGRldmljZSAq
ZGV2LA0KIAkJY29uc3Qgc3RydWN0IGdlbmVyaWNfcG1fZG9tYWluICpnZW5wZCkNCiB7DQogCWJv
b2wgcmV0Ow0KQEAgLTUxMywxMSArNTE0LDEzIEBAIHN0YXRpYyBpbnQgZ2VucGRfcG93ZXJfb2Zm
KHN0cnVjdCBnZW5lcmljX3BtX2RvbWFpbiAqZ2VucGQsIGJvb2wgb25lX2Rldl9vbiwNCiAJLyoN
CiAJICogQWJvcnQgcG93ZXIgb2ZmIGZvciB0aGUgUE0gZG9tYWluIGluIHRoZSBmb2xsb3dpbmcg
c2l0dWF0aW9uczoNCiAJICogKDEpIFRoZSBkb21haW4gaXMgY29uZmlndXJlZCBhcyBhbHdheXMg
b24uDQogCSAqICgyKSBXaGVuIHRoZSBkb21haW4gaGFzIGEgc3ViZG9tYWluIGJlaW5nIHBvd2Vy
ZWQgb24uDQogCSAqLw0KLQlpZiAoZ2VucGRfaXNfYWx3YXlzX29uKGdlbnBkKSB8fCBhdG9taWNf
cmVhZCgmZ2VucGQtPnNkX2NvdW50KSA+IDApDQorCWlmIChnZW5wZF9pc19hbHdheXNfb24oZ2Vu
cGQpIHx8DQorCQkJZ2VucGRfaXNfcnBtX2Fsd2F5c19vbihnZW5wZCkgfHwNCisJCQlhdG9taWNf
cmVhZCgmZ2VucGQtPnNkX2NvdW50KSA+IDApDQogCQlyZXR1cm4gLUVCVVNZOw0KIA0KIAlsaXN0
X2Zvcl9lYWNoX2VudHJ5KHBkZCwgJmdlbnBkLT5kZXZfbGlzdCwgbGlzdF9ub2RlKSB7DQogCQll
bnVtIHBtX3Fvc19mbGFnc19zdGF0dXMgc3RhdDsNCiANCkBAIC0xODEwLDExICsxODEzLDEyIEBA
IGludCBwbV9nZW5wZF9pbml0KHN0cnVjdCBnZW5lcmljX3BtX2RvbWFpbiAqZ2VucGQsDQogCQln
ZW5wZC0+ZGV2X29wcy5zdG9wID0gcG1fY2xrX3N1c3BlbmQ7DQogCQlnZW5wZC0+ZGV2X29wcy5z
dGFydCA9IHBtX2Nsa19yZXN1bWU7DQogCX0NCiANCiAJLyogQWx3YXlzLW9uIGRvbWFpbnMgbXVz
dCBiZSBwb3dlcmVkIG9uIGF0IGluaXRpYWxpemF0aW9uLiAqLw0KLQlpZiAoZ2VucGRfaXNfYWx3
YXlzX29uKGdlbnBkKSAmJiAhZ2VucGRfc3RhdHVzX29uKGdlbnBkKSkNCisJaWYgKChnZW5wZF9p
c19hbHdheXNfb24oZ2VucGQpIHx8IGdlbnBkX2lzX3JwbV9hbHdheXNfb24oZ2VucGQpKSAmJg0K
KwkJCSFnZW5wZF9zdGF0dXNfb24oZ2VucGQpKQ0KIAkJcmV0dXJuIC1FSU5WQUw7DQogDQogCWlm
IChnZW5wZF9pc19jcHVfZG9tYWluKGdlbnBkKSAmJg0KIAkgICAgIXphbGxvY19jcHVtYXNrX3Zh
cigmZ2VucGQtPmNwdXMsIEdGUF9LRVJORUwpKQ0KIAkJcmV0dXJuIC1FTk9NRU07DQpkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9saW51eC9wbV9kb21haW4uaCBiL2luY2x1ZGUvbGludXgvcG1fZG9tYWlu
LmgNCmluZGV4IDBlOGUzNTZiZWQ2YS4uYjIxZjM1ZjBlZTJlIDEwMDY0NA0KLS0tIGEvaW5jbHVk
ZS9saW51eC9wbV9kb21haW4uaA0KKysrIGIvaW5jbHVkZS9saW51eC9wbV9kb21haW4uaA0KQEAg
LTUxLDE2ICs1MSwyMCBAQA0KICAqCQkJCWRlcGxveSBpZGxlIHBvd2VyIG1hbmFnZW1lbnQgc3Vw
cG9ydCBmb3IgQ1BVcw0KICAqCQkJCWFuZCBncm91cHMgb2YgQ1BVcy4gTm90ZSB0aGF0LCB0aGUg
YmFja2VuZA0KICAqCQkJCWRyaXZlciBtdXN0IHRoZW4gY29tcGx5IHdpdGggdGhlIHNvIGNhbGxl
ZCwNCiAgKgkJCQlsYXN0LW1hbi1zdGFuZGluZyBhbGdvcml0aG0sIGZvciB0aGUgQ1BVcyBpbiB0
aGUNCiAgKgkJCQlQTSBkb21haW4uDQorICoNCisgKiBHRU5QRF9GTEFHX1JQTV9BTFdBWVNfT046
CUluc3RydWN0cyBnZW5wZCB0byBhbHdheXMga2VlcCB0aGUgUE0gZG9tYWluDQorICoJCQkJcG93
ZXJlZCBvbiBleGNlcHQgZm9yIHN5c3RlbSBzdXNwZW5kLg0KICAqLw0KICNkZWZpbmUgR0VOUERf
RkxBR19QTV9DTEsJICgxVSA8PCAwKQ0KICNkZWZpbmUgR0VOUERfRkxBR19JUlFfU0FGRQkgKDFV
IDw8IDEpDQogI2RlZmluZSBHRU5QRF9GTEFHX0FMV0FZU19PTgkgKDFVIDw8IDIpDQogI2RlZmlu
ZSBHRU5QRF9GTEFHX0FDVElWRV9XQUtFVVAgKDFVIDw8IDMpDQogI2RlZmluZSBHRU5QRF9GTEFH
X0NQVV9ET01BSU4JICgxVSA8PCA0KQ0KKyNkZWZpbmUgR0VOUERfRkxBR19SUE1fQUxXQVlTX09O
ICgxVSA8PCA1KQ0KIA0KIGVudW0gZ3BkX3N0YXR1cyB7DQogCUdQRF9TVEFURV9BQ1RJVkUgPSAw
LAkvKiBQTSBkb21haW4gaXMgYWN0aXZlICovDQogCUdQRF9TVEFURV9QT1dFUl9PRkYsCS8qIFBN
IGRvbWFpbiBpcyBvZmYgKi8NCiB9Ow0KLS0gDQoyLjE3LjENCg0K
