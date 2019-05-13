Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B31FA1B46D
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 13:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbfEMLBr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 07:01:47 -0400
Received: from mail-eopbgr130075.outbound.protection.outlook.com ([40.107.13.75]:52997
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729209AbfEMLBq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 May 2019 07:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1BmecdrXv1MoezlT25LTE5+VLmEkv7wtV5DH2U8rZI=;
 b=YZSQY/2OIv0gntqLY5wY0o1fV3RXFtzFdZhwOEOukE7L1/hjC6wEsUjhfNykCPVNhsSC4tpOts4QhMYaDdd1LrEoXPT5m4Xho1OiFeLUcesjiOannMzjIa+D8VGfTslE3ZGnuQI/fVqs29LxV+PdgK3B5ISReVhI1pmOTFhrWos=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB4706.eurprd04.prod.outlook.com (20.177.40.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Mon, 13 May 2019 11:01:43 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec%7]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 11:01:43 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lucas Stach <l.stach@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v4 4/5] arm64: dts: imx8mq: Add cpu speed grading and all OPPs
Thread-Topic: [PATCH v4 4/5] arm64: dts: imx8mq: Add cpu speed grading and all
 OPPs
Thread-Index: AQHVCXs/Sykf0GkfNUmaD90+g2Ayew==
Date:   Mon, 13 May 2019 11:01:43 +0000
Message-ID: <d88a9088074e521aa0ee57a07e2b99f5c7cb4f06.1557742902.git.leonard.crestez@nxp.com>
References: <cover.1557742902.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1557742902.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [89.37.124.34]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: VI1PR04CA0134.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::32) To AM0PR04MB6434.eurprd04.prod.outlook.com
 (2603:10a6:208:16c::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 894ff19a-35da-4e51-bb2a-08d6d79261f1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4706;
x-ms-traffictypediagnostic: AM0PR04MB4706:
x-microsoft-antispam-prvs: <AM0PR04MB47069EF9E0AF800FD7C824A8EE0F0@AM0PR04MB4706.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(366004)(396003)(376002)(199004)(189003)(2616005)(52116002)(76176011)(476003)(6436002)(446003)(11346002)(25786009)(68736007)(26005)(316002)(71190400001)(71200400001)(386003)(6506007)(4326008)(14444005)(7736002)(256004)(486006)(66476007)(66556008)(6116002)(73956011)(44832011)(66446008)(3846002)(64756008)(86362001)(186003)(102836004)(66946007)(99286004)(118296001)(36756003)(81166006)(81156014)(478600001)(5660300002)(305945005)(53936002)(2906002)(8676002)(66066001)(7416002)(14454004)(54906003)(6512007)(8936002)(50226002)(6486002)(110136005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4706;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LnGvSUdkTOrHSXuScbGUs7KbrCv3Ie3wv04WLFoVQSCdx2l5wvYtiE8jgVZA7uPMWmlE+ZEV/nJFQTs+3kB7fOwZ4e1BAy2pD0RuXY2Xcfi9fjxHF3brb/J2StvQn+wSkYOp7jzdx41Eh+/xSIaHUBrsasB9zKbU+Je8IgYxPc56arv/nZLF2cykdUX0+RFDlIoXueKpszfr1v/G5bv8nvzzMuN9RWrFDAkmjf0azP14ppgrP/rDz0BwazqMHvlBK38f5b7XAGOsv71Cr+aSjMlAti2eNbG8PfpN8n5imzb2k2EFI0FXJXX8r0XibNp9Fw4DkukM+B5f25WrDjbLUDYsYaT0uGYCfb7H4kXNO79hsoFJkPYJpZUPubh1h+6riP/A4mMJtvA4DQ8KNTz6V27WqpPplyALWnJY9I/fVsk=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <5BB1732BC0BBA841A0B5113F9899AF5D@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894ff19a-35da-4e51-bb2a-08d6d79261f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 11:01:43.0801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4706
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add nvmem-cells reference to cpu and fill the OPP table with all known
OPPs.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 26 ++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mq.dtsi
index 6d635ba0904c..729376919d08 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -93,10 +93,12 @@
 			clocks =3D <&clk IMX8MQ_CLK_ARM>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A53_L2>;
 			operating-points-v2 =3D <&a53_opp_table>;
 			#cooling-cells =3D <2>;
+			nvmem-cells =3D <&cpu_speed_grade>;
+			nvmem-cell-names =3D "speed_grade";
 		};
=20
 		A53_1: cpu@1 {
 			device_type =3D "cpu";
 			compatible =3D "arm,cortex-a53";
@@ -143,18 +145,36 @@
 		opp-shared;
=20
 		opp-800000000 {
 			opp-hz =3D /bits/ 64 <800000000>;
 			opp-microvolt =3D <900000>;
+			/* Industrial only */
+			opp-supported-hw =3D <0xf>, <0x4>;
+			clock-latency-ns =3D <150000>;
+		};
+
+		opp-1000000000 {
+			opp-hz =3D /bits/ 64 <1000000000>;
+			opp-microvolt =3D <900000>;
+			/* Consumer only */
+			opp-supported-hw =3D <0xe>, <0x3>;
 			clock-latency-ns =3D <150000>;
 		};
=20
 		opp-1300000000 {
 			opp-hz =3D /bits/ 64 <1300000000>;
 			opp-microvolt =3D <1000000>;
+			opp-supported-hw =3D <0xc>, <0x7>;
+			clock-latency-ns =3D <150000>;
+		};
+
+		opp-1500000000 {
+			opp-hz =3D /bits/ 64 <1500000000>;
+			opp-microvolt =3D <1000000>;
+			/* Consumer only but rely on speed grading */
+			opp-supported-hw =3D <0x8>, <0x7>;
 			clock-latency-ns =3D <150000>;
-			opp-suspend;
 		};
 	};
=20
 	pmu {
 		compatible =3D "arm,cortex-a53-pmu";
@@ -413,10 +433,14 @@
 				compatible =3D "fsl,imx8mq-ocotp", "syscon";
 				reg =3D <0x30350000 0x10000>;
 				clocks =3D <&clk IMX8MQ_CLK_OCOTP_ROOT>;
 				#address-cells =3D <1>;
 				#size-cells =3D <1>;
+
+				cpu_speed_grade: speed-grade@10 {
+					reg =3D <0x10 4>;
+				};
 			};
=20
 			anatop: syscon@30360000 {
 				compatible =3D "fsl,imx8mq-anatop", "syscon";
 				reg =3D <0x30360000 0x10000>;
--=20
2.17.1

