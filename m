Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70FF213E57
	for <lists+linux-pm@lfdr.de>; Sun,  5 May 2019 10:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfEEICx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 May 2019 04:02:53 -0400
Received: from mail-eopbgr150077.outbound.protection.outlook.com ([40.107.15.77]:47117
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726310AbfEEICx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 5 May 2019 04:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjuzFV7a9sIgcJgmTqibTtxLFuGtK/9z7b50oy4mXXo=;
 b=x6htGMd+xvsJjUby2r1zUbUHjC3jaP5JAmly2Jz5QAhhrUrrlGeyxUBkQ6UqeR91kXh4VcTXDhbg2pgAKODveikBmva2KG9L7PTIce8F8J377m+X38a+oD5fA9BixPL58zMaq6MDniEL06OoU4eYMvGPBocW2eXpBKo5axfpu5I=
Received: from VI1PR0402MB3519.eurprd04.prod.outlook.com (52.134.4.24) by
 VI1PR0402MB3584.eurprd04.prod.outlook.com (52.134.5.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Sun, 5 May 2019 08:02:48 +0000
Received: from VI1PR0402MB3519.eurprd04.prod.outlook.com
 ([fe80::f830:3f53:72c1:b14f]) by VI1PR0402MB3519.eurprd04.prod.outlook.com
 ([fe80::f830:3f53:72c1:b14f%3]) with mapi id 15.20.1856.012; Sun, 5 May 2019
 08:02:48 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     "festevam@gmail.com" <festevam@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: [PATCH v2] cpufreq: imx6q: Fix the resource leak caused by incorrect
 error return
Thread-Topic: [PATCH v2] cpufreq: imx6q: Fix the resource leak caused by
 incorrect error return
Thread-Index: AQHVAxjtnjxGnDga/EKgfP3NYCr4Xg==
Date:   Sun, 5 May 2019 08:02:48 +0000
Message-ID: <20190505080736.27970-1-ping.bai@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: HK2PR03CA0062.apcprd03.prod.outlook.com
 (2603:1096:202:17::32) To VI1PR0402MB3519.eurprd04.prod.outlook.com
 (2603:10a6:803:8::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ping.bai@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 175fe945-3197-48cc-5101-08d6d130100b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3584;
x-ms-traffictypediagnostic: VI1PR0402MB3584:
x-microsoft-antispam-prvs: <VI1PR0402MB3584787147E22385280F39A387370@VI1PR0402MB3584.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 00286C0CA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(376002)(39860400002)(346002)(189003)(199004)(4326008)(102836004)(86362001)(71200400001)(316002)(110136005)(54906003)(71190400001)(2201001)(53936002)(66446008)(1076003)(50226002)(68736007)(66066001)(386003)(6506007)(8676002)(2501003)(476003)(7736002)(2616005)(8936002)(305945005)(486006)(81166006)(81156014)(6486002)(52116002)(478600001)(186003)(256004)(26005)(3846002)(6116002)(66946007)(66476007)(64756008)(25786009)(66556008)(36756003)(6436002)(14454004)(6512007)(5660300002)(73956011)(99286004)(2906002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3584;H:VI1PR0402MB3519.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XFm9RWRAIDesOSvgVlRA+mA/p1GKSrdBBn6L7oa/LEx+IbfOdFHwuWZMjuUs9LMWI2KhhJEzWpYNUt4LjnnHuSWcjz0o2mgP0+wI/7/q6533ZpI3KtDm5xoz1izgzOT7Dw+0Q2PxN+bO0fGs5y8FdvtmoyEICg9e7W5M8H8nU9u3k8gN+stpRpNuDv+HXki1JtUOhTXN5PD/edpbLnPkiK9uAz8ybSpaeyijIzFSU3dNEUXCGjGfg3cvx3Jr/KI7tUeXlXXr6Z6uY12pnG7Jd4+5thb6BL6FLBn+aX16wT8f3Ca4FmYl7M5rNDitHcnr0llICDnfKKmCwG0Ps0Xaqlzn6AtA3Nib9lU/CaOoRTorks0l6Fi1EPavW2CrrlJpbaAiqeKkHbEN7lGYTSLIg3pokqt+gRMCL0R+ge5jrsQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 175fe945-3197-48cc-5101-08d6d130100b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2019 08:02:48.0578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3584
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

UHJldmlvdXMgZ290byBvbmx5IGhhbmRsZWQgdGhlIG5vZGUgcmVmZXJlbmNlLCB0aGUgb3BwIHRh
YmxlLA0KcmVndWxhdG9yICYgY2xrIHJlc291cmNlIGFsc28gbmVlZCB0byBiZSBmcmVlIGJlZm9y
ZSBlcnJvciByZXR1cm4uDQoNCkZpeGVzOiBkZGI2NGM1ZGIzYyAoY3B1ZnJlcTogaW14NnE6IGZp
eCBwb3NzaWJsZSBvYmplY3QgcmVmZXJlbmNlIGxlYWspLg0KU2lnbmVkLW9mZi1ieTogSmFja3kg
QmFpIDxwaW5nLmJhaUBueHAuY29tPg0KUmV2aWV3ZWQtYnk6IERvbmcgQWlzaGVuZyA8YWlzaGVu
Zy5kb25nQG54cC5jb20+DQotLS0NCiBkcml2ZXJzL2NwdWZyZXEvaW14NnEtY3B1ZnJlcS5jIHwg
MTUgKysrKysrKy0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgOCBk
ZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1ZnJlcS9pbXg2cS1jcHVmcmVx
LmMgYi9kcml2ZXJzL2NwdWZyZXEvaW14NnEtY3B1ZnJlcS5jDQppbmRleCAzZTE3NTYwYjFlZmUu
LjFkNGVjZWZhYWJjNiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9pbXg2cS1jcHVmcmVx
LmMNCisrKyBiL2RyaXZlcnMvY3B1ZnJlcS9pbXg2cS1jcHVmcmVxLmMNCkBAIC0zODMsMjMgKzM4
MywyMiBAQCBzdGF0aWMgaW50IGlteDZxX2NwdWZyZXFfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikNCiAJCWdvdG8gcHV0X3JlZzsNCiAJfQ0KIA0KKwkvKiBCZWNhdXNlIHdlIGhh
dmUgYWRkZWQgdGhlIE9QUHMgaGVyZSwgd2UgbXVzdCBmcmVlIHRoZW0gKi8NCisJZnJlZV9vcHAg
PSB0cnVlOw0KKw0KIAlpZiAob2ZfbWFjaGluZV9pc19jb21wYXRpYmxlKCJmc2wsaW14NnVsIikg
fHwNCiAJICAgIG9mX21hY2hpbmVfaXNfY29tcGF0aWJsZSgiZnNsLGlteDZ1bGwiKSkgew0KIAkJ
cmV0ID0gaW14NnVsX29wcF9jaGVja19zcGVlZF9ncmFkaW5nKGNwdV9kZXYpOw0KIAkJaWYgKHJl
dCkgew0KLQkJCWlmIChyZXQgPT0gLUVQUk9CRV9ERUZFUikNCi0JCQkJZ290byBwdXRfbm9kZTsN
Ci0NCi0JCQlkZXZfZXJyKGNwdV9kZXYsICJmYWlsZWQgdG8gcmVhZCBvY290cDogJWRcbiIsDQot
CQkJCXJldCk7DQotCQkJZ290byBwdXRfbm9kZTsNCisJCQlpZiAocmV0ICE9IC1FUFJPQkVfREVG
RVIpDQorCQkJCWRldl9lcnIoY3B1X2RldiwgImZhaWxlZCB0byByZWFkIG9jb3RwOiAlZFxuIiwN
CisJCQkJCXJldCk7DQorCQkJZ290byBvdXRfZnJlZV9vcHA7DQogCQl9DQogCX0gZWxzZSB7DQog
CQlpbXg2cV9vcHBfY2hlY2tfc3BlZWRfZ3JhZGluZyhjcHVfZGV2KTsNCiAJfQ0KIA0KLQkvKiBC
ZWNhdXNlIHdlIGhhdmUgYWRkZWQgdGhlIE9QUHMgaGVyZSwgd2UgbXVzdCBmcmVlIHRoZW0gKi8N
Ci0JZnJlZV9vcHAgPSB0cnVlOw0KIAludW0gPSBkZXZfcG1fb3BwX2dldF9vcHBfY291bnQoY3B1
X2Rldik7DQogCWlmIChudW0gPCAwKSB7DQogCQlyZXQgPSBudW07DQotLSANCjIuMjEuMA0KDQo=
