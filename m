Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89836124AB
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2019 00:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfEBWoZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 May 2019 18:44:25 -0400
Received: from mail-eopbgr20058.outbound.protection.outlook.com ([40.107.2.58]:14403
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726128AbfEBWoY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 May 2019 18:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKJJB57BTZnv91xInuELTcEgrqm/4EJ0fXqGXSyIux4=;
 b=XQ+giUdKnF6pxl/9rTXS5MxNOgrmnOU0aEIJxTi+QvGrQXDH/W7DvCP6oR9CVtFuXRWzolHfMchEBoqf/FSSaTTfmQkJRdxUAqua2fnevtNSa0PEzDmKOiXBxPnSiq0hP4QJCtXNBM4Sv7/sBQtOtlwWvyrRYek74N/mwLrdX0o=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB5315.eurprd04.prod.outlook.com (20.176.215.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.15; Thu, 2 May 2019 22:44:15 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec%7]) with mapi id 15.20.1856.008; Thu, 2 May 2019
 22:44:15 +0000
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
Subject: [PATCH v2 2/3] arm64: dts: imx8mm: Add cpu speed grading and all OPPs
Thread-Topic: [PATCH v2 2/3] arm64: dts: imx8mm: Add cpu speed grading and all
 OPPs
Thread-Index: AQHVATiR0oJdbRNhNE+qlYykXiwtOg==
Date:   Thu, 2 May 2019 22:44:15 +0000
Message-ID: <cb0329b83347e551911f3d474cf512f3fe10cde4.1556836868.git.leonard.crestez@nxp.com>
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
x-ms-office365-filtering-correlation-id: cc168471-1d4e-47dc-078e-08d6cf4fb40f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5315;
x-ms-traffictypediagnostic: AM0PR04MB5315:
x-microsoft-antispam-prvs: <AM0PR04MB5315228F1C34F1C4C3DE37A4EE340@AM0PR04MB5315.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(376002)(136003)(346002)(189003)(199004)(86362001)(76176011)(6116002)(66446008)(66476007)(66946007)(6436002)(66556008)(71190400001)(73956011)(71200400001)(64756008)(52116002)(53936002)(14444005)(3846002)(36756003)(256004)(5660300002)(2906002)(8676002)(26005)(11346002)(44832011)(186003)(478600001)(118296001)(4326008)(446003)(6506007)(305945005)(386003)(8936002)(316002)(476003)(6486002)(54906003)(6512007)(50226002)(99286004)(68736007)(81156014)(81166006)(486006)(110136005)(102836004)(14454004)(66066001)(25786009)(7736002)(2616005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5315;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YnQro9Dz66PcO2sB7J+u2wl0SxfYi9JnNd297QuHIFxcvc8d3OFkmvUU8jDTLYJ7bC8zCR5hl5/Hp/kCNYFX70WSENwO3zHIofNfOGF3zdG1woAqRihlcNZNZI/aeF+8KugbgKgN+iBEZdma4XUhQWAmnfNbuzmSrEjF0mU9u579fty95c/yV89hVyEpujpAqg78fDx18eI2Ib8fERhGhJsQi6+dvmOPTpBtw+nX0GhkK9GVn/ocQhuCs86hUL1ba4/nNya7cI4jSbdeqe/z/0btfZ1lIDHglv/kAvccHF88RsWuilrlAPcBn7Tzm5bbVnX1wfbc4UHkSIZwxGxvwFPe85JGSpE4oBzSiXfQgNkTUr3Ku9UENxu7hSTYHfRonaIGLtcNr1HUHQZV5yrK/bT55cINadFManu424tJJ7E=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc168471-1d4e-47dc-078e-08d6cf4fb40f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 22:44:15.2452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5315
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

QWRkIGEgbnZtZW0gY2VsbCBvbiBjcHUgbm9kZSByZWZlcmVuY2luZyBzcGVlZCBncmFkZSBhbmQg
dGhlIDEuOCBHaHoNCmNwdWZyZXEgb3BwLg0KDQpUaGUgaW14LWNwdWZyZXEtZHQgZHJpdmVyIHdp
bGwgcmVhZCBzcGVlZCBncmFkZSBhbmQgZGlzYWJsZSBoaWdoZXIgb3Bwcw0KaWYgdW5zdXBwb3J0
ZWQuDQoNClNpZ25lZC1vZmYtYnk6IExlb25hcmQgQ3Jlc3RleiA8bGVvbmFyZC5jcmVzdGV6QG54
cC5jb20+DQotLS0NCiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0uZHRzaSB8
IDIzICsrKysrKysrKysrKysrKysrKysrKystDQogMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDhtbS5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14
OG1tLmR0c2kNCmluZGV4IDBiMmE1ODVjNTg0NC4uOTE1NGY0OGU4MWY0IDEwMDY0NA0KLS0tIGEv
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kNCisrKyBiL2FyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpDQpAQCAtNTEsMTAgKzUxLDEyIEBADQog
CQkJY2xvY2stbGF0ZW5jeSA9IDw2MTAzNj47IC8qIHR3byBDTEszMiBwZXJpb2RzICovDQogCQkJ
Y2xvY2tzID0gPCZjbGsgSU1YOE1NX0NMS19BUk0+Ow0KIAkJCWVuYWJsZS1tZXRob2QgPSAicHNj
aSI7DQogCQkJbmV4dC1sZXZlbC1jYWNoZSA9IDwmQTUzX0wyPjsNCiAJCQlvcGVyYXRpbmctcG9p
bnRzLXYyID0gPCZhNTNfb3BwX3RhYmxlPjsNCisJCQludm1lbS1jZWxscyA9IDwmY3B1X3NwZWVk
X2dyYWRlPjsNCisJCQludm1lbS1jZWxsLW5hbWVzID0gInNwZWVkX2dyYWRlIjsNCiAJCX07DQog
DQogCQlBNTNfMTogY3B1QDEgew0KIAkJCWRldmljZV90eXBlID0gImNwdSI7DQogCQkJY29tcGF0
aWJsZSA9ICJhcm0sY29ydGV4LWE1MyI7DQpAQCAtOTUsMjEgKzk3LDM2IEBADQogDQogCWE1M19v
cHBfdGFibGU6IG9wcC10YWJsZSB7DQogCQljb21wYXRpYmxlID0gIm9wZXJhdGluZy1wb2ludHMt
djIiOw0KIAkJb3BwLXNoYXJlZDsNCiANCisJCW9wcC04MDAwMDAwMDAgew0KKwkJCW9wcC1oeiA9
IC9iaXRzLyA2NCA8ODAwMDAwMDAwPjsNCisJCQlvcHAtbWljcm92b2x0ID0gPDg1MDAwMD47DQor
CQkJb3BwLXN1cHBvcnRlZC1odyA9IDwweGY+Ow0KKwkJCWNsb2NrLWxhdGVuY3ktbnMgPSA8MTUw
MDAwPjsNCisJCX07DQorDQogCQlvcHAtMTIwMDAwMDAwMCB7DQogCQkJb3BwLWh6ID0gL2JpdHMv
IDY0IDwxMjAwMDAwMDAwPjsNCiAJCQlvcHAtbWljcm92b2x0ID0gPDg1MDAwMD47DQorCQkJb3Bw
LXN1cHBvcnRlZC1odyA9IDwweGU+Ow0KIAkJCWNsb2NrLWxhdGVuY3ktbnMgPSA8MTUwMDAwPjsN
CiAJCX07DQogDQogCQlvcHAtMTYwMDAwMDAwMCB7DQogCQkJb3BwLWh6ID0gL2JpdHMvIDY0IDwx
NjAwMDAwMDAwPjsNCiAJCQlvcHAtbWljcm92b2x0ID0gPDkwMDAwMD47DQorCQkJb3BwLXN1cHBv
cnRlZC1odyA9IDwweGM+Ow0KKwkJCWNsb2NrLWxhdGVuY3ktbnMgPSA8MTUwMDAwPjsNCisJCX07
DQorDQorCQlvcHAtMTgwMDAwMDAwMCB7DQorCQkJb3BwLWh6ID0gL2JpdHMvIDY0IDwxODAwMDAw
MDAwPjsNCisJCQlvcHAtbWljcm92b2x0ID0gPDEwMDAwMDA+Ow0KKwkJCW9wcC1zdXBwb3J0ZWQt
aHcgPSA8MHg4PjsNCiAJCQljbG9jay1sYXRlbmN5LW5zID0gPDE1MDAwMD47DQotCQkJb3BwLXN1
c3BlbmQ7DQogCQl9Ow0KIAl9Ow0KIA0KIAltZW1vcnlANDAwMDAwMDAgew0KIAkJZGV2aWNlX3R5
cGUgPSAibWVtb3J5IjsNCkBAIC0zMTcsMTAgKzMzNCwxNCBAQA0KIAkJCQlyZWcgPSA8MHgzMDM1
MDAwMCAweDEwMDAwPjsNCiAJCQkJY2xvY2tzID0gPCZjbGsgSU1YOE1NX0NMS19PQ09UUF9ST09U
PjsNCiAJCQkJLyogRm9yIG52bWVtIHN1Ym5vZGVzICovDQogCQkJCSNhZGRyZXNzLWNlbGxzID0g
PDE+Ow0KIAkJCQkjc2l6ZS1jZWxscyA9IDwxPjsNCisNCisJCQkJY3B1X3NwZWVkX2dyYWRlOiBz
cGVlZC1ncmFkZUAxMCB7DQorCQkJCQlyZWcgPSA8MHgxMCA0PjsNCisJCQkJfTsNCiAJCQl9Ow0K
IA0KIAkJCWFuYXRvcDogYW5hdG9wQDMwMzYwMDAwIHsNCiAJCQkJY29tcGF0aWJsZSA9ICJmc2ws
aW14OG1tLWFuYXRvcCIsICJzeXNjb24iLCAic2ltcGxlLWJ1cyI7DQogCQkJCXJlZyA9IDwweDMw
MzYwMDAwIDB4MTAwMDA+Ow0KLS0gDQoyLjE3LjENCg0K
