Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B818D124AD
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2019 00:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfEBWo0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 May 2019 18:44:26 -0400
Received: from mail-eopbgr20058.outbound.protection.outlook.com ([40.107.2.58]:14403
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726022AbfEBWo0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 May 2019 18:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0r7/0R2h+pUlCQEcybdD0+INberFDQMdSAkeYM7C+C4=;
 b=DNwwMgCAQSCnPNXdSUYCgNswHj8GiYqc4Hnyj4nHLtuQZTzUAN8wPFVUKxE8JM1ZGOmFnTng3AAKJDvdvbKnhH3JlpWZly0WnMRP0uGuj2+ANuOzu1dl+VLolchmJWx4cCNyupW0CLifJTazh1AuwCkToTnLx3RiUshCJOHuYsE=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB5315.eurprd04.prod.outlook.com (20.176.215.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.15; Thu, 2 May 2019 22:44:16 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec%7]) with mapi id 15.20.1856.008; Thu, 2 May 2019
 22:44:16 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 3/3] arm64: dts: imx8mq: Add cpu speed grading and all OPPs
Thread-Topic: [PATCH v2 3/3] arm64: dts: imx8mq: Add cpu speed grading and all
 OPPs
Thread-Index: AQHVATiS4cTudn+H4ku0rUWjqV8UFQ==
Date:   Thu, 2 May 2019 22:44:16 +0000
Message-ID: <59286bf8fcdca332df4004c3d141727f0188ad6f.1556836868.git.leonard.crestez@nxp.com>
References: <cover.1556836868.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1556836868.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [89.37.124.34]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: LO2P265CA0184.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::28) To AM0PR04MB6434.eurprd04.prod.outlook.com
 (2603:10a6:208:16c::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af202266-35ad-4c88-a4d4-08d6cf4fb4bd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5315;
x-ms-traffictypediagnostic: AM0PR04MB5315:
x-microsoft-antispam-prvs: <AM0PR04MB5315B7D00DF904B2E550E3BBEE340@AM0PR04MB5315.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(376002)(136003)(346002)(189003)(199004)(86362001)(76176011)(6116002)(66446008)(66476007)(66946007)(6436002)(66556008)(71190400001)(73956011)(71200400001)(64756008)(52116002)(53936002)(14444005)(3846002)(36756003)(256004)(5660300002)(2906002)(8676002)(26005)(11346002)(44832011)(186003)(478600001)(118296001)(4326008)(446003)(6506007)(305945005)(386003)(8936002)(316002)(476003)(6486002)(54906003)(6512007)(50226002)(99286004)(68736007)(81156014)(81166006)(486006)(110136005)(102836004)(14454004)(66066001)(25786009)(7736002)(2616005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5315;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8WzZBHwXeEU99wNuuDiQb5weYRkDIzi/xsJF/E88UZs6S3zXDB1+gxs/BY1aS58R8WCR998MYCccex+3tYh2bbROdy+D1cMIAKzJCk6y8jDwoeQDYMSHhq/6oORfAzi/0KycLPEJTtAC8VrudqIAMCPwhlJtsjWtS2KkRJNEgbOkoD8DA6HbQazuC0GyYtiFsFxw4sgzOU7Rmqn6EApkuXLpqlEWheqAVLCEwjDre4udm44PWu+K5bgZ3R5dSwHM21Vgl4gsN/7Sq6caB7QVCIG9WfrnL5vRSCSfX3PGAlToX/S6yhlIQZi9QtWWxo/1iZVwGydG0n+pnjxEp/5fCOwdagi7nrYuBs8UG8aEyFpYp+z1NJOgGtJf6SYu/q/XC9uJIb1r3HlXQIqc1s6/EhSNr/PMs12Ed0mIXCtyP78=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af202266-35ad-4c88-a4d4-08d6cf4fb4bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 22:44:16.4135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5315
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

QWRkIG52bWVtLWNlbGxzIHJlZmVyZW5jZSB0byBjcHUgYW5kIGZpbGwgdGhlIE9QUCB0YWJsZSB3
aXRoIGFsbCBrbm93bg0KT1BQcy4NCg0KU2lnbmVkLW9mZi1ieTogTGVvbmFyZCBDcmVzdGV6IDxs
ZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT4NCi0tLQ0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2lteDhtcS5kdHNpIHwgMjMgKysrKysrKysrKysrKysrKysrKysrKy0NCiAxIGZpbGUgY2hh
bmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzaQ0KaW5kZXggNmQ2MzViYTA5MDRjLi5mMDNmOWJlMjRm
NDQgMTAwNjQ0DQotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRz
aQ0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kNCkBAIC05
MywxMCArOTMsMTIgQEANCiAJCQljbG9ja3MgPSA8JmNsayBJTVg4TVFfQ0xLX0FSTT47DQogCQkJ
ZW5hYmxlLW1ldGhvZCA9ICJwc2NpIjsNCiAJCQluZXh0LWxldmVsLWNhY2hlID0gPCZBNTNfTDI+
Ow0KIAkJCW9wZXJhdGluZy1wb2ludHMtdjIgPSA8JmE1M19vcHBfdGFibGU+Ow0KIAkJCSNjb29s
aW5nLWNlbGxzID0gPDI+Ow0KKwkJCW52bWVtLWNlbGxzID0gPCZjcHVfc3BlZWRfZ3JhZGU+Ow0K
KwkJCW52bWVtLWNlbGwtbmFtZXMgPSAic3BlZWRfZ3JhZGUiOw0KIAkJfTsNCiANCiAJCUE1M18x
OiBjcHVAMSB7DQogCQkJZGV2aWNlX3R5cGUgPSAiY3B1IjsNCiAJCQljb21wYXRpYmxlID0gImFy
bSxjb3J0ZXgtYTUzIjsNCkBAIC0xNDMsMTggKzE0NSwzMyBAQA0KIAkJb3BwLXNoYXJlZDsNCiAN
CiAJCW9wcC04MDAwMDAwMDAgew0KIAkJCW9wcC1oeiA9IC9iaXRzLyA2NCA8ODAwMDAwMDAwPjsN
CiAJCQlvcHAtbWljcm92b2x0ID0gPDkwMDAwMD47DQorCQkJb3BwLXN1cHBvcnRlZC1odyA9IDww
eGY+Ow0KKwkJCWNsb2NrLWxhdGVuY3ktbnMgPSA8MTUwMDAwPjsNCisJCX07DQorDQorCQlvcHAt
MTAwMDAwMDAwMCB7DQorCQkJb3BwLWh6ID0gL2JpdHMvIDY0IDwxMDAwMDAwMDAwPjsNCisJCQlv
cHAtbWljcm92b2x0ID0gPDkwMDAwMD47DQorCQkJb3BwLXN1cHBvcnRlZC1odyA9IDwweGU+Ow0K
IAkJCWNsb2NrLWxhdGVuY3ktbnMgPSA8MTUwMDAwPjsNCiAJCX07DQogDQogCQlvcHAtMTMwMDAw
MDAwMCB7DQogCQkJb3BwLWh6ID0gL2JpdHMvIDY0IDwxMzAwMDAwMDAwPjsNCiAJCQlvcHAtbWlj
cm92b2x0ID0gPDEwMDAwMDA+Ow0KKwkJCW9wcC1zdXBwb3J0ZWQtaHcgPSA8MHhjPjsNCisJCQlj
bG9jay1sYXRlbmN5LW5zID0gPDE1MDAwMD47DQorCQl9Ow0KKw0KKwkJb3BwLTE1MDAwMDAwMDAg
ew0KKwkJCW9wcC1oeiA9IC9iaXRzLyA2NCA8MTUwMDAwMDAwMD47DQorCQkJb3BwLW1pY3Jvdm9s
dCA9IDwxMDAwMDAwPjsNCisJCQlvcHAtc3VwcG9ydGVkLWh3ID0gPDB4OD47DQogCQkJY2xvY2st
bGF0ZW5jeS1ucyA9IDwxNTAwMDA+Ow0KLQkJCW9wcC1zdXNwZW5kOw0KIAkJfTsNCiAJfTsNCiAN
CiAJcG11IHsNCiAJCWNvbXBhdGlibGUgPSAiYXJtLGNvcnRleC1hNTMtcG11IjsNCkBAIC00MTMs
MTAgKzQzMCwxNCBAQA0KIAkJCQljb21wYXRpYmxlID0gImZzbCxpbXg4bXEtb2NvdHAiLCAic3lz
Y29uIjsNCiAJCQkJcmVnID0gPDB4MzAzNTAwMDAgMHgxMDAwMD47DQogCQkJCWNsb2NrcyA9IDwm
Y2xrIElNWDhNUV9DTEtfT0NPVFBfUk9PVD47DQogCQkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0K
IAkJCQkjc2l6ZS1jZWxscyA9IDwxPjsNCisNCisJCQkJY3B1X3NwZWVkX2dyYWRlOiBzcGVlZC1n
cmFkZUAxMCB7DQorCQkJCQlyZWcgPSA8MHgxMCA0PjsNCisJCQkJfTsNCiAJCQl9Ow0KIA0KIAkJ
CWFuYXRvcDogc3lzY29uQDMwMzYwMDAwIHsNCiAJCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OG1x
LWFuYXRvcCIsICJzeXNjb24iOw0KIAkJCQlyZWcgPSA8MHgzMDM2MDAwMCAweDEwMDAwPjsNCi0t
IA0KMi4xNy4xDQoNCg==
