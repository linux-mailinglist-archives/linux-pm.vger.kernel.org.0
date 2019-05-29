Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43F712DC5D
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 14:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfE2MDp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 08:03:45 -0400
Received: from mail-eopbgr130075.outbound.protection.outlook.com ([40.107.13.75]:13709
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725894AbfE2MDp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 May 2019 08:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylrqZaR6G8vxrql8vSfpgIDJEoJE6VA3lgeCtYzr1Hg=;
 b=dBdeNKx599rP487XECVlxNaJAfxW5UIN+Ceasst/q1djnHwQIBCN2M66/AfWuaTPnYxA8UI6WdCLAAJdtaXgtO5MNKx793MpkueLIyKDDr9esGoOFLWKXQLuJEi4pjzzjviMs8/U98+V4LWJvKVwGyM4uZhchqv9hN3q2U2oIjE=
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com (20.177.50.140) by
 VI1PR04MB5998.eurprd04.prod.outlook.com (20.178.123.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.18; Wed, 29 May 2019 12:03:40 +0000
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::9577:379c:2078:19a1]) by VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::9577:379c:2078:19a1%7]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 12:03:40 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/3] ARM: dts: imx7d: Update cpufreq OPP table
Thread-Topic: [PATCH 1/3] ARM: dts: imx7d: Update cpufreq OPP table
Thread-Index: AQHVFhaNwoTPYZ2vJk+vUyTsOMXqbg==
Date:   Wed, 29 May 2019 12:03:40 +0000
Message-ID: <b6a9b9f80534af5c12db30a0bb699ec850f85be7.1559131365.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [89.37.124.34]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: LO2P265CA0432.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::36) To VI1PR04MB5055.eurprd04.prod.outlook.com
 (2603:10a6:803:5a::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfa204dc-6ffb-49a6-ef20-08d6e42db030
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5998;
x-ms-traffictypediagnostic: VI1PR04MB5998:
x-microsoft-antispam-prvs: <VI1PR04MB5998BE5E4463FD4970BF6F58EE1F0@VI1PR04MB5998.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(366004)(376002)(136003)(199004)(189003)(6436002)(6512007)(73956011)(478600001)(66446008)(5660300002)(6116002)(6486002)(386003)(6506007)(102836004)(110136005)(25786009)(81156014)(305945005)(54906003)(3846002)(50226002)(6636002)(99286004)(7736002)(8936002)(68736007)(86362001)(53936002)(8676002)(52116002)(316002)(15650500001)(4326008)(81166006)(14454004)(66476007)(64756008)(66946007)(66556008)(118296001)(2906002)(26005)(186003)(256004)(486006)(476003)(2616005)(44832011)(14444005)(71200400001)(71190400001)(36756003)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5998;H:VI1PR04MB5055.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FjJa4FZQYjX/bD79Ksr72UcjOme+lPNOttdl9oqW/PB8hrTLz8E29yWBHLrZpzIvJCQeAVe6Zoe9wxrS0prkO/Xkg4CyqdUyEJUG+P6T2NhxkAQX3/e+Eo+3lqEiRrLIGnHlfngwpTZjoGG2oXJpPdua831llmNbJe3bwtejoKxJUA3AEDflYvHT+6r+9naHlSPZva7hrNwIix7DPjQQRZYOIw9JcbcxRv+LfrghRLHxyMpNayLy2LYAuoJ/N3BZ7dO3gx6X+Q30YIl4EaS2xiFp3uqNA5ytas5bt9+7U4NfC0+AEv18QTNN9c4Ka1JoYhdacpBaPA2RjaRVtBWcnl2TIIWlZ25Tb8YAkiasfN5vuvPFjS5mDezQwPtFpFQHDpbA7rMvXtb4jBTTgas8DTcMrom74PgouXn90tktAic=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <4BE730BBE7BB2049A18DCE962E1E2DC7@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa204dc-6ffb-49a6-ef20-08d6e42db030
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 12:03:40.3060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonard.crestez@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5998
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

According to latest docs imx7d chips can go from 800 to 1200 mhz.
Maximum frequency is determined from two speed grading bits present in
OCOTP fuses at same location as other imx chips.

Also update to "typical" voltages from latest datasheet, 25mv higher
than current dts.

All imx7s parts are still fixed at 800mhz

Based on:
* IMX7DCEC Rev. 6, 03/2019
* IMX7SCEC Rev. 6, 03/2019
* IMX7DRM Rev. 1, 01/2018 Page 1102

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/boot/dts/imx7d.dtsi | 16 +++++++++++++---
 arch/arm/boot/dts/imx7s.dtsi |  4 ++++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index f33b560821b8..42528d2812a2 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -10,10 +10,12 @@
 	cpus {
 		cpu0: cpu@0 {
 			clock-frequency =3D <996000000>;
 			operating-points-v2 =3D <&cpu0_opp_table>;
 			#cooling-cells =3D <2>;
+			nvmem-cells =3D <&cpu_speed_grade>;
+			nvmem-cell-names =3D "speed_grade";
 		};
=20
 		cpu1: cpu@1 {
 			compatible =3D "arm,cortex-a7";
 			device_type =3D "cpu";
@@ -37,19 +39,27 @@
 		compatible =3D "operating-points-v2";
 		opp-shared;
=20
 		opp-792000000 {
 			opp-hz =3D /bits/ 64 <792000000>;
-			opp-microvolt =3D <975000>;
+			opp-microvolt =3D <1000000>;
 			clock-latency-ns =3D <150000>;
+			opp-supported-hw =3D <0xf>, <0xf>;
 		};
=20
 		opp-996000000 {
 			opp-hz =3D /bits/ 64 <996000000>;
-			opp-microvolt =3D <1075000>;
+			opp-microvolt =3D <1100000>;
 			clock-latency-ns =3D <150000>;
-			opp-suspend;
+			opp-supported-hw =3D <0xc>, <0xf>;
+		};
+
+		opp-1200000000 {
+			opp-hz =3D /bits/ 64 <1200000000>;
+			opp-microvolt =3D <1225000>;
+			clock-latency-ns =3D <150000>;
+			opp-supported-hw =3D <0x8>, <0xf>;
 		};
 	};
=20
 	usbphynop2: usbphynop2 {
 		compatible =3D "usb-nop-xceiv";
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index d8b4eb67146d..5b8292670b4b 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -549,10 +549,14 @@
 				};
=20
 				tempmon_temp_grade: temp-grade@10 {
 					reg =3D <0x10 0x4>;
 				};
+
+				cpu_speed_grade: speed-grade@10 {
+					reg =3D <0x10 0x4>;
+				};
 			};
=20
 			anatop: anatop@30360000 {
 				compatible =3D "fsl,imx7d-anatop", "fsl,imx6q-anatop",
 					"syscon", "simple-bus";
--=20
2.17.1

