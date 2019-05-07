Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62FAD16510
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2019 15:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfEGNwf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 May 2019 09:52:35 -0400
Received: from mail-eopbgr140087.outbound.protection.outlook.com ([40.107.14.87]:51872
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726767AbfEGNwf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 May 2019 09:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqO+oPMls5BR1/xf+A+ORc1pn+S7OJlzAuFS7YavpWk=;
 b=GJ0cf81q967cM9QiEj9uDk2Rzko6MzYio+hJKckQklY77rKeUQbNYQ0+unyQD89Eu+bUw0cYigyAAU4Ljb45Jg/fMBwQBmxzQwuQiCib24rejtMEzLRtgQKRfCkzQIdsM00vjcjE5ttW2lUCsyCo4gax+L62usRSxEjLDjfx2Tk=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB6548.eurprd04.prod.outlook.com (20.179.254.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Tue, 7 May 2019 13:52:25 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec%7]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 13:52:25 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
CC:     Anson Huang <anson.huang@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 3/4] arm64: dts: imx8mm: Add cpu speed grading and all OPPs
Thread-Topic: [PATCH v3 3/4] arm64: dts: imx8mm: Add cpu speed grading and all
 OPPs
Thread-Index: AQHVBNwZmN/Wu1D6TE2m9LPKkhEzpA==
Date:   Tue, 7 May 2019 13:52:25 +0000
Message-ID: <5f2172c5e676d570b51ba66ff1ea9dd42b3e09fd.1557236799.git.leonard.crestez@nxp.com>
References: <cover.1557236799.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1557236799.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [89.37.124.34]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: VI1PR0202CA0006.eurprd02.prod.outlook.com
 (2603:10a6:803:14::19) To AM0PR04MB6434.eurprd04.prod.outlook.com
 (2603:10a6:208:16c::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d32639c9-d56e-46d3-4ecc-08d6d2f33c0a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6548;
x-ms-traffictypediagnostic: AM0PR04MB6548:
x-microsoft-antispam-prvs: <AM0PR04MB6548F371A720E1FC713E2632EE310@AM0PR04MB6548.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(346002)(376002)(39860400002)(189003)(199004)(8676002)(81156014)(81166006)(486006)(11346002)(86362001)(68736007)(6512007)(110136005)(53936002)(54906003)(71190400001)(4326008)(118296001)(102836004)(66066001)(76176011)(8936002)(36756003)(52116002)(6506007)(50226002)(386003)(446003)(14444005)(256004)(14454004)(476003)(478600001)(25786009)(6116002)(5660300002)(2616005)(3846002)(44832011)(305945005)(66946007)(6486002)(73956011)(66476007)(71200400001)(2906002)(99286004)(6436002)(26005)(186003)(316002)(64756008)(66556008)(66446008)(7736002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6548;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YskFsutOh89dFXSMTvx7/WSpJbPSKaK8BekIamJ5iq07DKkhNpWpxqaZ8PopB+TvIQYshUVm9C2zidJe2vpFS/vUzqahXq7cQrTtupJsj9Gopw2WTTAh6xm/3zlxhKBrk25dv9DwBip1Bn7vdJ8XwddiEQbOkmAjrOxJmsKXzjKzajweFQ6aEAONIWq0MVlggoSohIEuW09I1+8Pa2/mIr3G67rvUjnbB2gMbAatS7WK1dcIoKjFRv9QZVriOL4pC0ViMu8CWx1A5nmlAz9/DlewReizVvJc3+qh7vQyxw66yPNlRBkZbi2D8uvs8QA5P2Rtc0j3C7DgQvoFNqNNUQRmaiZ4IQlmMHPgrNHqU9fsydmt7ED2L751PDwUMOYeXKbN5S+hHRz0xXJRLrXzS7ZFxXD7x/jsLVyXx4Bz1JA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d32639c9-d56e-46d3-4ecc-08d6d2f33c0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 13:52:25.0915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6548
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

QWRkIGEgbnZtZW0gY2VsbCBvbiBjcHUgbm9kZSByZWZlcmVuY2luZyBzcGVlZCBncmFkZSBhbmQg
dGhlIDEuOCBHaHoNCmNwdWZyZXEgb3BwLg0KDQpTaWduZWQtb2ZmLWJ5OiBMZW9uYXJkIENyZXN0
ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPg0KQWNrZWQtYnk6IFZpcmVzaCBLdW1hciA8dmly
ZXNoLmt1bWFyQGxpbmFyby5vcmc+DQotLS0NCiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2Fs
ZS9pbXg4bW0uZHRzaSB8IDE3ICsrKysrKysrKysrKysrKystDQogMSBmaWxlIGNoYW5nZWQsIDE2
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvaW14OG1tLmR0c2kNCmluZGV4IDBiMmE1ODVjNTg0NC4uN2VlYTQ3NTg0ZjMxIDEwMDY0
NA0KLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kNCisrKyBi
L2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpDQpAQCAtNTEsMTAgKzUx
LDEyIEBADQogCQkJY2xvY2stbGF0ZW5jeSA9IDw2MTAzNj47IC8qIHR3byBDTEszMiBwZXJpb2Rz
ICovDQogCQkJY2xvY2tzID0gPCZjbGsgSU1YOE1NX0NMS19BUk0+Ow0KIAkJCWVuYWJsZS1tZXRo
b2QgPSAicHNjaSI7DQogCQkJbmV4dC1sZXZlbC1jYWNoZSA9IDwmQTUzX0wyPjsNCiAJCQlvcGVy
YXRpbmctcG9pbnRzLXYyID0gPCZhNTNfb3BwX3RhYmxlPjsNCisJCQludm1lbS1jZWxscyA9IDwm
Y3B1X3NwZWVkX2dyYWRlPjsNCisJCQludm1lbS1jZWxsLW5hbWVzID0gInNwZWVkX2dyYWRlIjsN
CiAJCX07DQogDQogCQlBNTNfMTogY3B1QDEgew0KIAkJCWRldmljZV90eXBlID0gImNwdSI7DQog
CQkJY29tcGF0aWJsZSA9ICJhcm0sY29ydGV4LWE1MyI7DQpAQCAtOTgsMTggKzEwMCwyNyBAQA0K
IAkJb3BwLXNoYXJlZDsNCiANCiAJCW9wcC0xMjAwMDAwMDAwIHsNCiAJCQlvcHAtaHogPSAvYml0
cy8gNjQgPDEyMDAwMDAwMDA+Ow0KIAkJCW9wcC1taWNyb3ZvbHQgPSA8ODUwMDAwPjsNCisJCQlv
cHAtc3VwcG9ydGVkLWh3ID0gPDB4ZT4sIDwweDc+Ow0KIAkJCWNsb2NrLWxhdGVuY3ktbnMgPSA8
MTUwMDAwPjsNCiAJCX07DQogDQogCQlvcHAtMTYwMDAwMDAwMCB7DQogCQkJb3BwLWh6ID0gL2Jp
dHMvIDY0IDwxNjAwMDAwMDAwPjsNCiAJCQlvcHAtbWljcm92b2x0ID0gPDkwMDAwMD47DQorCQkJ
b3BwLXN1cHBvcnRlZC1odyA9IDwweGM+LCA8MHg3PjsNCisJCQljbG9jay1sYXRlbmN5LW5zID0g
PDE1MDAwMD47DQorCQl9Ow0KKw0KKwkJb3BwLTE4MDAwMDAwMDAgew0KKwkJCW9wcC1oeiA9IC9i
aXRzLyA2NCA8MTgwMDAwMDAwMD47DQorCQkJb3BwLW1pY3Jvdm9sdCA9IDwxMDAwMDAwPjsNCisJ
CQkvKiBDb25zdW1lciBvbmx5IGJ1dCByZWx5IG9uIHNwZWVkIGdyYWRpbmcgKi8NCisJCQlvcHAt
c3VwcG9ydGVkLWh3ID0gPDB4OD4sIDwweDc+Ow0KIAkJCWNsb2NrLWxhdGVuY3ktbnMgPSA8MTUw
MDAwPjsNCi0JCQlvcHAtc3VzcGVuZDsNCiAJCX07DQogCX07DQogDQogCW1lbW9yeUA0MDAwMDAw
MCB7DQogCQlkZXZpY2VfdHlwZSA9ICJtZW1vcnkiOw0KQEAgLTMxNywxMCArMzI4LDE0IEBADQog
CQkJCXJlZyA9IDwweDMwMzUwMDAwIDB4MTAwMDA+Ow0KIAkJCQljbG9ja3MgPSA8JmNsayBJTVg4
TU1fQ0xLX09DT1RQX1JPT1Q+Ow0KIAkJCQkvKiBGb3IgbnZtZW0gc3Vibm9kZXMgKi8NCiAJCQkJ
I2FkZHJlc3MtY2VsbHMgPSA8MT47DQogCQkJCSNzaXplLWNlbGxzID0gPDE+Ow0KKw0KKwkJCQlj
cHVfc3BlZWRfZ3JhZGU6IHNwZWVkLWdyYWRlQDEwIHsNCisJCQkJCXJlZyA9IDwweDEwIDQ+Ow0K
KwkJCQl9Ow0KIAkJCX07DQogDQogCQkJYW5hdG9wOiBhbmF0b3BAMzAzNjAwMDAgew0KIAkJCQlj
b21wYXRpYmxlID0gImZzbCxpbXg4bW0tYW5hdG9wIiwgInN5c2NvbiIsICJzaW1wbGUtYnVzIjsN
CiAJCQkJcmVnID0gPDB4MzAzNjAwMDAgMHgxMDAwMD47DQotLSANCjIuMTcuMQ0KDQo=
