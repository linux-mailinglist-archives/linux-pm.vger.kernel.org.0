Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A08312DC60
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 14:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbfE2MDt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 08:03:49 -0400
Received: from mail-eopbgr130075.outbound.protection.outlook.com ([40.107.13.75]:13709
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726547AbfE2MDt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 May 2019 08:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uHAcUN+j6VtLPSbaJigjReOyt8r/3SfkyoasffYUZI=;
 b=I668Dbf27x2tpVdRKSZw8KNZ0X0EjzPxx989tK5/hr9nTT9JSL9MDAzYEMr/AU3DI7358YJSUxr1F4sicLDf9+BYrMlzEbJQEqlpHwy79XPv40oZ6ccpfsFZR5yQ1rG6Wh526GEOMFepEyUPDZVTyd6r4Sx6zpUxIyHHlzjlSSo=
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com (20.177.50.140) by
 VI1PR04MB5998.eurprd04.prod.outlook.com (20.178.123.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.18; Wed, 29 May 2019 12:03:43 +0000
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::9577:379c:2078:19a1]) by VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::9577:379c:2078:19a1%7]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 12:03:43 +0000
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
Subject: [PATCH 3/3] cpufreq: Switch imx7d to imx-cpufreq-dt for speed grading
Thread-Topic: [PATCH 3/3] cpufreq: Switch imx7d to imx-cpufreq-dt for speed
 grading
Thread-Index: AQHVFhaPrvUUJ34dakS8wduWS4Ia3Q==
Date:   Wed, 29 May 2019 12:03:42 +0000
Message-ID: <8787934ff35e7e55837f2caabc0d5bf65828d971.1559131365.git.leonard.crestez@nxp.com>
References: <b6a9b9f80534af5c12db30a0bb699ec850f85be7.1559131365.git.leonard.crestez@nxp.com>
In-Reply-To: <b6a9b9f80534af5c12db30a0bb699ec850f85be7.1559131365.git.leonard.crestez@nxp.com>
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
x-ms-office365-filtering-correlation-id: ce5c93f0-2854-4e35-65bb-08d6e42db1ca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5998;
x-ms-traffictypediagnostic: VI1PR04MB5998:
x-microsoft-antispam-prvs: <VI1PR04MB599804DA4944B2E82224DACCEE1F0@VI1PR04MB5998.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:159;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(366004)(376002)(136003)(199004)(189003)(6436002)(6512007)(73956011)(478600001)(66446008)(5660300002)(6116002)(6486002)(386003)(6506007)(102836004)(110136005)(25786009)(81156014)(305945005)(54906003)(3846002)(50226002)(6636002)(99286004)(7736002)(8936002)(68736007)(86362001)(76176011)(53936002)(8676002)(52116002)(316002)(4326008)(81166006)(14454004)(66476007)(64756008)(66946007)(66556008)(118296001)(2906002)(26005)(186003)(11346002)(256004)(486006)(476003)(446003)(2616005)(44832011)(14444005)(71200400001)(71190400001)(36756003)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5998;H:VI1PR04MB5055.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: q3BHYONav0EJpuXd7GSuf6W6UPJF+K0ItGG9Me3NChGa/H0IpOHM2FFbuMGmgmI8JfVS6tIAirLzgNnmIO3wyq4NVvMfm+txqLcEH3E3k79iqi9Cd8J+v5fg2y95YurHLM2YQseat7vt0jqMi0ZAU+Oz639zT3lnmXo6hBsUsaJWaIMbiGJK0a+mE41eylGyMdiT2k0q90GWs/fpwS4mXWFPrhpGN4yLWVOENO13L2acbpk6pKHZZJU7RPDip965musd8WUSQPULxhEeIVky12hT7lVwOVyWkIZYvf/QSnuym393L/bSL0GOCgme5ANjA9m/TRuqI2PQfPYCl7iWABSk19gzCVMm0EVKyDgFdqk03LFRfdUvp+RsVW/p/xYVrD94ungAJpo6JkozXLgauaLbtUCr2X/6idrHt/uzJVM=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <E28AEEB54DAE8F458BCD2A518473E48E@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5c93f0-2854-4e35-65bb-08d6e42db1ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 12:03:43.0044
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

This driver can handle speed grading bits on imx7d just like on imx8mq
and imx8mm.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/mach-imx/mach-imx7d.c       | 7 +++++++
 drivers/cpufreq/cpufreq-dt-platdev.c | 2 +-
 drivers/cpufreq/imx-cpufreq-dt.c     | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mach-imx7d.c b/arch/arm/mach-imx/mach-imx7d.=
c
index 26ca744d3e2b..0b77412795c9 100644
--- a/arch/arm/mach-imx/mach-imx7d.c
+++ b/arch/arm/mach-imx/mach-imx7d.c
@@ -95,10 +95,16 @@ static void __init imx7d_init_machine(void)
=20
 	imx_anatop_init();
 	imx7d_enet_init();
 }
=20
+static void __init imx7d_init_late(void)
+{
+	if (IS_ENABLED(CONFIG_ARM_IMX_CPUFREQ_DT))
+		platform_device_register_simple("imx-cpufreq-dt", -1, NULL, 0);
+}
+
 static void __init imx7d_init_irq(void)
 {
 	imx_init_revision_from_anatop();
 	imx_src_init();
 	irqchip_init();
@@ -111,7 +117,8 @@ static const char *const imx7d_dt_compat[] __initconst =
=3D {
 };
=20
 DT_MACHINE_START(IMX7D, "Freescale i.MX7 Dual (Device Tree)")
 	.init_irq	=3D imx7d_init_irq,
 	.init_machine	=3D imx7d_init_machine,
+	.init_late      =3D imx7d_init_late,
 	.dt_compat	=3D imx7d_dt_compat,
 MACHINE_END
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq=
-dt-platdev.c
index 19c1aad57e26..eb282dff9f2c 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -38,11 +38,10 @@ static const struct of_device_id whitelist[] __initcons=
t =3D {
 	{ .compatible =3D "hisilicon,hi3660", },
=20
 	{ .compatible =3D "fsl,imx27", },
 	{ .compatible =3D "fsl,imx51", },
 	{ .compatible =3D "fsl,imx53", },
-	{ .compatible =3D "fsl,imx7d", },
=20
 	{ .compatible =3D "marvell,berlin", },
 	{ .compatible =3D "marvell,pxa250", },
 	{ .compatible =3D "marvell,pxa270", },
=20
@@ -106,10 +105,11 @@ static const struct of_device_id whitelist[] __initco=
nst =3D {
  */
 static const struct of_device_id blacklist[] __initconst =3D {
 	{ .compatible =3D "calxeda,highbank", },
 	{ .compatible =3D "calxeda,ecx-2000", },
=20
+	{ .compatible =3D "fsl,imx7d", },
 	{ .compatible =3D "fsl,imx8mq", },
 	{ .compatible =3D "fsl,imx8mm", },
=20
 	{ .compatible =3D "marvell,armadaxp", },
=20
diff --git a/drivers/cpufreq/imx-cpufreq-dt.c b/drivers/cpufreq/imx-cpufreq=
-dt.c
index 5061503cb0a1..ce26ffc18ce6 100644
--- a/drivers/cpufreq/imx-cpufreq-dt.c
+++ b/drivers/cpufreq/imx-cpufreq-dt.c
@@ -18,10 +18,11 @@
 #define OCOTP_CFG3_SPEED_GRADE_MASK	(0x3 << 8)
 #define OCOTP_CFG3_MKT_SEGMENT_SHIFT    6
 #define OCOTP_CFG3_MKT_SEGMENT_MASK     (0x3 << 6)
=20
 static const struct of_device_id imx_cpufreq_dt_match_list[] =3D {
+	{ .compatible =3D "fsl,imx7d" },
 	{ .compatible =3D "fsl,imx8mm" },
 	{ .compatible =3D "fsl,imx8mq" },
 	{}
 };
=20
--=20
2.17.1

