Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBD01B470
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 13:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbfEMLBr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 07:01:47 -0400
Received: from mail-eopbgr50048.outbound.protection.outlook.com ([40.107.5.48]:59894
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729211AbfEMLBr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 May 2019 07:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwGiXwZDDXKSjDRx44dZ1zaKphiqTKHEKLJriV5tj8o=;
 b=WxJ3Ck+akrD987/Sxv9cXEIIi7CFSBBGhAR+ppFlhF4gG7zfTUXZ/MD3ixRfwMegY+j9G+2jPiVa24/m1RzR1ISgkQmI/fYp7AgZsDEGX7DycpzvKjQJzEgjue9TdNGAg4+O9NTNIjKGs9FF/mXKB4POmhSeUjLHmJe70k0dRiA=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB5138.eurprd04.prod.outlook.com (52.134.89.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.24; Mon, 13 May 2019 11:01:41 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec%7]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 11:01:41 +0000
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
Subject: [PATCH v4 3/5] arm64: dts: imx8mm: Add cpu speed grading and all OPPs
Thread-Topic: [PATCH v4 3/5] arm64: dts: imx8mm: Add cpu speed grading and all
 OPPs
Thread-Index: AQHVCXs+BYd/Ihr7KE6+oCaAQdQmXQ==
Date:   Mon, 13 May 2019 11:01:41 +0000
Message-ID: <0c7b08ee090ef1a91dc4d1072482b1ff0d4665fb.1557742902.git.leonard.crestez@nxp.com>
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
x-ms-office365-filtering-correlation-id: 226fbc60-d911-4d18-f002-08d6d792612b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5138;
x-ms-traffictypediagnostic: AM0PR04MB5138:
x-microsoft-antispam-prvs: <AM0PR04MB51382D181E3C25E876D37D1AEE0F0@AM0PR04MB5138.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(366004)(136003)(189003)(199004)(7736002)(2906002)(44832011)(99286004)(36756003)(6512007)(53936002)(54906003)(110136005)(476003)(2616005)(4326008)(52116002)(446003)(256004)(486006)(6116002)(3846002)(14444005)(76176011)(11346002)(66066001)(8676002)(81156014)(81166006)(478600001)(118296001)(102836004)(7416002)(14454004)(68736007)(5660300002)(50226002)(8936002)(6486002)(25786009)(66446008)(64756008)(66556008)(66476007)(71190400001)(71200400001)(86362001)(6436002)(6506007)(386003)(66946007)(73956011)(316002)(26005)(305945005)(186003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5138;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RfmUucYC4C+8uKaFhgWdaJHAzLK+XL+Tvn5qIgIYkHsFxi3JogrbYP8h8ISKrnwYaq2l/R2FT+d7TGNsWxNrKnGNPL/Lkn3IIWmhfem7pSwhUiZ4zDZXJnzWAqSQWaknfIpoux2jMGDgLnDAlYC98jG6b4+px0nr8yENHMNVqZF239veoVDowo39sG0YqIlj2rokgpXjfgqc2ewgFgqL5Mp4X8fqqfGibRyd3CvRorFM0cJUI9z+abBbRVOhu1vEg2cHtOKvE0cB68Gt3eIHr9DiGeK45OGJamGAMovTdslCtRuKSExXRphe9CfJN/6VIcjBex/1xlkuB/Au0FTJ3O70J3XNWgDRQNb7mVI+0w8r6+dtjv8gPig4JtbmLv2loLAj+eeg82BFcgAzFJfct5DKxIL6LQTFveeAMLauRK8=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <9FF5C265307477418130459C114A3217@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 226fbc60-d911-4d18-f002-08d6d792612b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 11:01:41.8038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5138
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a nvmem cell on cpu node referencing speed grade and the 1.8 Ghz
cpufreq opp.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mm.dtsi
index 6b407a94c06e..7e458dbbd017 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -51,10 +51,12 @@
 			clock-latency =3D <61036>; /* two CLK32 periods */
 			clocks =3D <&clk IMX8MM_CLK_ARM>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A53_L2>;
 			operating-points-v2 =3D <&a53_opp_table>;
+			nvmem-cells =3D <&cpu_speed_grade>;
+			nvmem-cell-names =3D "speed_grade";
 		};
=20
 		A53_1: cpu@1 {
 			device_type =3D "cpu";
 			compatible =3D "arm,cortex-a53";
@@ -98,18 +100,27 @@
 		opp-shared;
=20
 		opp-1200000000 {
 			opp-hz =3D /bits/ 64 <1200000000>;
 			opp-microvolt =3D <850000>;
+			opp-supported-hw =3D <0xe>, <0x7>;
 			clock-latency-ns =3D <150000>;
 		};
=20
 		opp-1600000000 {
 			opp-hz =3D /bits/ 64 <1600000000>;
 			opp-microvolt =3D <900000>;
+			opp-supported-hw =3D <0xc>, <0x7>;
+			clock-latency-ns =3D <150000>;
+		};
+
+		opp-1800000000 {
+			opp-hz =3D /bits/ 64 <1800000000>;
+			opp-microvolt =3D <1000000>;
+			/* Consumer only but rely on speed grading */
+			opp-supported-hw =3D <0x8>, <0x7>;
 			clock-latency-ns =3D <150000>;
-			opp-suspend;
 		};
 	};
=20
 	memory@40000000 {
 		device_type =3D "memory";
@@ -317,10 +328,14 @@
 				reg =3D <0x30350000 0x10000>;
 				clocks =3D <&clk IMX8MM_CLK_OCOTP_ROOT>;
 				/* For nvmem subnodes */
 				#address-cells =3D <1>;
 				#size-cells =3D <1>;
+
+				cpu_speed_grade: speed-grade@10 {
+					reg =3D <0x10 4>;
+				};
 			};
=20
 			anatop: anatop@30360000 {
 				compatible =3D "fsl,imx8mm-anatop", "syscon", "simple-bus";
 				reg =3D <0x30360000 0x10000>;
--=20
2.17.1

