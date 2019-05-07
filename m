Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1082916513
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2019 15:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfEGNwi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 May 2019 09:52:38 -0400
Received: from mail-eopbgr140087.outbound.protection.outlook.com ([40.107.14.87]:51872
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726767AbfEGNwh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 May 2019 09:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1ZATx2rfyXoAxTMOa/JCwAno/iDG00deWA95V5nP9Q=;
 b=pi0pnQxmnDJcCMyhd2jftYdVAHhZDdH9jM1yuCwf8GF+L0hGCLlUuXdj6vhIiMpwYVbhjhyRHiRePAwMwXs5zFStcmgD6dW7gXvz3af+jB7+L7gIbCik860Qo3a3864DGlXEiQH9Fz5OZqnI/JBWgwMPggoTAQVcrT3qd5op06U=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB6548.eurprd04.prod.outlook.com (20.179.254.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Tue, 7 May 2019 13:52:26 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec%7]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 13:52:26 +0000
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
Subject: [PATCH v3 4/4] arm64: dts: imx8mq: Add cpu speed grading and all OPPs
Thread-Topic: [PATCH v3 4/4] arm64: dts: imx8mq: Add cpu speed grading and all
 OPPs
Thread-Index: AQHVBNwadKvxDTstDUy8AWrggXxVJA==
Date:   Tue, 7 May 2019 13:52:26 +0000
Message-ID: <7effdee3820aa0408ba0c8a5267b5b9b4cee2fe7.1557236799.git.leonard.crestez@nxp.com>
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
x-ms-office365-filtering-correlation-id: b89cb783-e50c-43f3-aeb7-08d6d2f33ced
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6548;
x-ms-traffictypediagnostic: AM0PR04MB6548:
x-microsoft-antispam-prvs: <AM0PR04MB65488CF11BA25ED3D0F09658EE310@AM0PR04MB6548.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(346002)(376002)(39860400002)(189003)(199004)(8676002)(81156014)(81166006)(486006)(11346002)(86362001)(68736007)(6512007)(110136005)(53936002)(54906003)(71190400001)(4326008)(118296001)(102836004)(66066001)(76176011)(8936002)(36756003)(52116002)(6506007)(50226002)(386003)(446003)(14444005)(256004)(14454004)(476003)(478600001)(25786009)(6116002)(5660300002)(2616005)(3846002)(44832011)(305945005)(66946007)(6486002)(73956011)(66476007)(71200400001)(2906002)(99286004)(6436002)(26005)(186003)(316002)(64756008)(66556008)(66446008)(7736002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6548;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: euNCGm9NpTZeFCt5BohzFRQKKKJg3kcXkGyszfDgbnRjaOFDCzlbYKkuYcRjFoTwR9uka7MDpb2XzEPotH3sM12mo08vWwfXBEDHgkJhZYbqX/tkTkEIbuYralrMOfsV2mgWOdaoVCtHJsBWy0kV4INEVqUEQ+MnOaQVWdV1Vr+3KHFjgsAgz7Dn67Dg1ziau2JdUchO64tnfzCSHi/keOEVkivKpTTJ8O0Yr3C3sCKFDEKs8swA5lNEuCwiO3X3qlRuFFrOkM6yozvBerapqj5zuB/0MQBdTNIBjJCvGKFgz2RndoRQv4TEWfGviAadT4QFn7pWe1Lzc7+bHfwWsFwrg3SuiWT4R6qfEhOSxcZixfraqBlCbUGrtoSXavZRoivCMjm1fjXiw2IHEoGUm/P0NEcJEq9NeB1CCGhaqT4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b89cb783-e50c-43f3-aeb7-08d6d2f33ced
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 13:52:26.7405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6548
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

QWRkIG52bWVtLWNlbGxzIHJlZmVyZW5jZSB0byBjcHUgYW5kIGZpbGwgdGhlIE9QUCB0YWJsZSB3
aXRoIGFsbCBrbm93bg0KT1BQcy4NCg0KU2lnbmVkLW9mZi1ieTogTGVvbmFyZCBDcmVzdGV6IDxs
ZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT4NCkFja2VkLWJ5OiBWaXJlc2ggS3VtYXIgPHZpcmVzaC5r
dW1hckBsaW5hcm8ub3JnPg0KLS0tDQogYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14
OG1xLmR0c2kgfCAyNiArKysrKysrKysrKysrKysrKysrKysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAy
NSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2lteDhtcS5kdHNpDQppbmRleCA2ZDYzNWJhMDkwNGMuLjcyOTM3NjkxOWQwOCAxMDA2
NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpDQorKysg
Yi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzaQ0KQEAgLTkzLDEwICs5
MywxMiBAQA0KIAkJCWNsb2NrcyA9IDwmY2xrIElNWDhNUV9DTEtfQVJNPjsNCiAJCQllbmFibGUt
bWV0aG9kID0gInBzY2kiOw0KIAkJCW5leHQtbGV2ZWwtY2FjaGUgPSA8JkE1M19MMj47DQogCQkJ
b3BlcmF0aW5nLXBvaW50cy12MiA9IDwmYTUzX29wcF90YWJsZT47DQogCQkJI2Nvb2xpbmctY2Vs
bHMgPSA8Mj47DQorCQkJbnZtZW0tY2VsbHMgPSA8JmNwdV9zcGVlZF9ncmFkZT47DQorCQkJbnZt
ZW0tY2VsbC1uYW1lcyA9ICJzcGVlZF9ncmFkZSI7DQogCQl9Ow0KIA0KIAkJQTUzXzE6IGNwdUAx
IHsNCiAJCQlkZXZpY2VfdHlwZSA9ICJjcHUiOw0KIAkJCWNvbXBhdGlibGUgPSAiYXJtLGNvcnRl
eC1hNTMiOw0KQEAgLTE0MywxOCArMTQ1LDM2IEBADQogCQlvcHAtc2hhcmVkOw0KIA0KIAkJb3Bw
LTgwMDAwMDAwMCB7DQogCQkJb3BwLWh6ID0gL2JpdHMvIDY0IDw4MDAwMDAwMDA+Ow0KIAkJCW9w
cC1taWNyb3ZvbHQgPSA8OTAwMDAwPjsNCisJCQkvKiBJbmR1c3RyaWFsIG9ubHkgKi8NCisJCQlv
cHAtc3VwcG9ydGVkLWh3ID0gPDB4Zj4sIDwweDQ+Ow0KKwkJCWNsb2NrLWxhdGVuY3ktbnMgPSA8
MTUwMDAwPjsNCisJCX07DQorDQorCQlvcHAtMTAwMDAwMDAwMCB7DQorCQkJb3BwLWh6ID0gL2Jp
dHMvIDY0IDwxMDAwMDAwMDAwPjsNCisJCQlvcHAtbWljcm92b2x0ID0gPDkwMDAwMD47DQorCQkJ
LyogQ29uc3VtZXIgb25seSAqLw0KKwkJCW9wcC1zdXBwb3J0ZWQtaHcgPSA8MHhlPiwgPDB4Mz47
DQogCQkJY2xvY2stbGF0ZW5jeS1ucyA9IDwxNTAwMDA+Ow0KIAkJfTsNCiANCiAJCW9wcC0xMzAw
MDAwMDAwIHsNCiAJCQlvcHAtaHogPSAvYml0cy8gNjQgPDEzMDAwMDAwMDA+Ow0KIAkJCW9wcC1t
aWNyb3ZvbHQgPSA8MTAwMDAwMD47DQorCQkJb3BwLXN1cHBvcnRlZC1odyA9IDwweGM+LCA8MHg3
PjsNCisJCQljbG9jay1sYXRlbmN5LW5zID0gPDE1MDAwMD47DQorCQl9Ow0KKw0KKwkJb3BwLTE1
MDAwMDAwMDAgew0KKwkJCW9wcC1oeiA9IC9iaXRzLyA2NCA8MTUwMDAwMDAwMD47DQorCQkJb3Bw
LW1pY3Jvdm9sdCA9IDwxMDAwMDAwPjsNCisJCQkvKiBDb25zdW1lciBvbmx5IGJ1dCByZWx5IG9u
IHNwZWVkIGdyYWRpbmcgKi8NCisJCQlvcHAtc3VwcG9ydGVkLWh3ID0gPDB4OD4sIDwweDc+Ow0K
IAkJCWNsb2NrLWxhdGVuY3ktbnMgPSA8MTUwMDAwPjsNCi0JCQlvcHAtc3VzcGVuZDsNCiAJCX07
DQogCX07DQogDQogCXBtdSB7DQogCQljb21wYXRpYmxlID0gImFybSxjb3J0ZXgtYTUzLXBtdSI7
DQpAQCAtNDEzLDEwICs0MzMsMTQgQEANCiAJCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OG1xLW9j
b3RwIiwgInN5c2NvbiI7DQogCQkJCXJlZyA9IDwweDMwMzUwMDAwIDB4MTAwMDA+Ow0KIAkJCQlj
bG9ja3MgPSA8JmNsayBJTVg4TVFfQ0xLX09DT1RQX1JPT1Q+Ow0KIAkJCQkjYWRkcmVzcy1jZWxs
cyA9IDwxPjsNCiAJCQkJI3NpemUtY2VsbHMgPSA8MT47DQorDQorCQkJCWNwdV9zcGVlZF9ncmFk
ZTogc3BlZWQtZ3JhZGVAMTAgew0KKwkJCQkJcmVnID0gPDB4MTAgND47DQorCQkJCX07DQogCQkJ
fTsNCiANCiAJCQlhbmF0b3A6IHN5c2NvbkAzMDM2MDAwMCB7DQogCQkJCWNvbXBhdGlibGUgPSAi
ZnNsLGlteDhtcS1hbmF0b3AiLCAic3lzY29uIjsNCiAJCQkJcmVnID0gPDB4MzAzNjAwMDAgMHgx
MDAwMD47DQotLSANCjIuMTcuMQ0KDQo=
