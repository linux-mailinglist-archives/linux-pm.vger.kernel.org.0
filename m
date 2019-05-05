Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE94C13D4A
	for <lists+linux-pm@lfdr.de>; Sun,  5 May 2019 06:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbfEEEet (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 May 2019 00:34:49 -0400
Received: from mail-eopbgr150087.outbound.protection.outlook.com ([40.107.15.87]:9796
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725792AbfEEEes (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 5 May 2019 00:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANWUEQ6rBQifMaNgnq7/NTxHfRWd6clsc/NPPBLBXS4=;
 b=RrOWDVO8Do6Z6SZ6E+3YNlkR98l6QqABHfGsvuAMNuYIH7nhuCq2hw0Do7L0yaLk/n4RlbxS6F2hl8Wrj1USRbO5hndIHuPUTENCmx9MIZzztu5Jorm6EWJpfXZyRDQTH0wIhg+92IuqZDo385OtVV5shf4NyJLXEwnyW/reUGo=
Received: from VI1PR0402MB3519.eurprd04.prod.outlook.com (52.134.4.24) by
 VI1PR0402MB3343.eurprd04.prod.outlook.com (52.134.8.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Sun, 5 May 2019 04:34:43 +0000
Received: from VI1PR0402MB3519.eurprd04.prod.outlook.com
 ([fe80::f830:3f53:72c1:b14f]) by VI1PR0402MB3519.eurprd04.prod.outlook.com
 ([fe80::f830:3f53:72c1:b14f%3]) with mapi id 15.20.1856.012; Sun, 5 May 2019
 04:34:43 +0000
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
Subject: [PATCH] cpufreq: imx6q: Fix the resource leak caused by incorrect
 error return
Thread-Topic: [PATCH] cpufreq: imx6q: Fix the resource leak caused by
 incorrect error return
Thread-Index: AQHVAvvcgKY/ghVFik+vqE7MN5XPPQ==
Date:   Sun, 5 May 2019 04:34:43 +0000
Message-ID: <20190505043929.19071-1-ping.bai@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: HK2P15301CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::27) To VI1PR0402MB3519.eurprd04.prod.outlook.com
 (2603:10a6:803:8::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ping.bai@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 492b1a90-ee3c-4408-007b-08d6d112fe68
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3343;
x-ms-traffictypediagnostic: VI1PR0402MB3343:
x-microsoft-antispam-prvs: <VI1PR0402MB334368CE20B9C91948E091CB87370@VI1PR0402MB3343.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 00286C0CA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(366004)(376002)(396003)(199004)(189003)(36756003)(486006)(64756008)(6436002)(66556008)(66446008)(1076003)(316002)(102836004)(186003)(6506007)(3846002)(2501003)(6116002)(386003)(6512007)(68736007)(81156014)(53936002)(2906002)(52116002)(2616005)(6486002)(8676002)(25786009)(66476007)(66946007)(73956011)(71190400001)(71200400001)(110136005)(26005)(305945005)(14454004)(5660300002)(66066001)(86362001)(478600001)(54906003)(50226002)(8936002)(7736002)(81166006)(476003)(99286004)(2201001)(4326008)(256004)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3343;H:VI1PR0402MB3519.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Sa/cgq61mYkfFUB7DXAFp8TcuJysS3Gk056ASLMbTJV95Z7cl8gDM9dyTic9/fWilidM93CBcttDz9k4CvQkN38MFXyXgT1Q0VKnt0xXVwyyGB87h//2xI7sT9grxx+sWnytoz8rA4zCj2LsP3PmBgcI2FByS8fuHGFmj6UUOdL9RPD4tbisUEPdEthibRz9J8uqk2XnvafSsaXW+BCd1Fk77mhL4yKULYgaT4jm0KIPjcuR4WDeyWG5VDhEPvAC7bw6kdDn8Y2f/5SB9/nWqIg4whG3JecJxPGrxerY+SpF9JWkTsgijpr+c31hVR3qIQuZH1e5xwSXlFOrqyN9P9VobPCTXjo2aessY2OORuD9u30vLdbniJtEKKh7Vma9T0xCeJZidkpk9klOe7LpudPR4jMYYEwniLs6JUi9IkY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 492b1a90-ee3c-4408-007b-08d6d112fe68
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2019 04:34:43.3483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3343
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

UHJldmlvdXMgZ290byBvbmx5IGhhbmRsZWQgdGhlIG5vZGUgcmVmZXJlbmNlLCB0aGUgb3BwIHRh
YmxlLA0KcmVndWxhdG9yICYgY2xrIHJlc291cmNlIGFsc28gbmVlZCB0byBiZSBmcmVlIGJlZm9y
ZSBlcnJvciByZXR1cm4uDQoNClNpZ25lZC1vZmYtYnk6IEphY2t5IEJhaSA8cGluZy5iYWlAbnhw
LmNvbT4NCi0tLQ0KIGRyaXZlcnMvY3B1ZnJlcS9pbXg2cS1jcHVmcmVxLmMgfCAxNSArKysrKysr
LS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygt
KQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL2lteDZxLWNwdWZyZXEuYyBiL2RyaXZl
cnMvY3B1ZnJlcS9pbXg2cS1jcHVmcmVxLmMNCmluZGV4IDNlMTc1NjBiMWVmZS4uMWQ0ZWNlZmFh
YmM2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jcHVmcmVxL2lteDZxLWNwdWZyZXEuYw0KKysrIGIv
ZHJpdmVycy9jcHVmcmVxL2lteDZxLWNwdWZyZXEuYw0KQEAgLTM4MywyMyArMzgzLDIyIEBAIHN0
YXRpYyBpbnQgaW14NnFfY3B1ZnJlcV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
KQ0KIAkJZ290byBwdXRfcmVnOw0KIAl9DQogDQorCS8qIEJlY2F1c2Ugd2UgaGF2ZSBhZGRlZCB0
aGUgT1BQcyBoZXJlLCB3ZSBtdXN0IGZyZWUgdGhlbSAqLw0KKwlmcmVlX29wcCA9IHRydWU7DQor
DQogCWlmIChvZl9tYWNoaW5lX2lzX2NvbXBhdGlibGUoImZzbCxpbXg2dWwiKSB8fA0KIAkgICAg
b2ZfbWFjaGluZV9pc19jb21wYXRpYmxlKCJmc2wsaW14NnVsbCIpKSB7DQogCQlyZXQgPSBpbXg2
dWxfb3BwX2NoZWNrX3NwZWVkX2dyYWRpbmcoY3B1X2Rldik7DQogCQlpZiAocmV0KSB7DQotCQkJ
aWYgKHJldCA9PSAtRVBST0JFX0RFRkVSKQ0KLQkJCQlnb3RvIHB1dF9ub2RlOw0KLQ0KLQkJCWRl
dl9lcnIoY3B1X2RldiwgImZhaWxlZCB0byByZWFkIG9jb3RwOiAlZFxuIiwNCi0JCQkJcmV0KTsN
Ci0JCQlnb3RvIHB1dF9ub2RlOw0KKwkJCWlmIChyZXQgIT0gLUVQUk9CRV9ERUZFUikNCisJCQkJ
ZGV2X2VycihjcHVfZGV2LCAiZmFpbGVkIHRvIHJlYWQgb2NvdHA6ICVkXG4iLA0KKwkJCQkJcmV0
KTsNCisJCQlnb3RvIG91dF9mcmVlX29wcDsNCiAJCX0NCiAJfSBlbHNlIHsNCiAJCWlteDZxX29w
cF9jaGVja19zcGVlZF9ncmFkaW5nKGNwdV9kZXYpOw0KIAl9DQogDQotCS8qIEJlY2F1c2Ugd2Ug
aGF2ZSBhZGRlZCB0aGUgT1BQcyBoZXJlLCB3ZSBtdXN0IGZyZWUgdGhlbSAqLw0KLQlmcmVlX29w
cCA9IHRydWU7DQogCW51bSA9IGRldl9wbV9vcHBfZ2V0X29wcF9jb3VudChjcHVfZGV2KTsNCiAJ
aWYgKG51bSA8IDApIHsNCiAJCXJldCA9IG51bTsNCi0tIA0KMi4yMS4wDQoNCg==
