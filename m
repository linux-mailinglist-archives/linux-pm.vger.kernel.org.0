Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52A8A1B46A
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 13:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbfEMLBo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 07:01:44 -0400
Received: from mail-eopbgr50048.outbound.protection.outlook.com ([40.107.5.48]:59894
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729206AbfEMLBn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 May 2019 07:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4j1sXLARR5JfcYG8vDNkkPL2BKNAgyYH6vNSs31eWs=;
 b=LtkUcgJHQBTLYPlgTIe6pVaHDcsbOFnzJQXs77Y4Jc+tItqIQ/wX+sKNdQNxp4xGEdO2TK/6UUjitZFHwetyBlzuljbBuXOfc04n0C5oDxUsiEvl3fIN06oqp6x1/WrRF2MXdQZb7Bnz0/UEhKE+lGWEAIyx6k3BbociNTFLPbc=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB5138.eurprd04.prod.outlook.com (52.134.89.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.24; Mon, 13 May 2019 11:01:38 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec%7]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 11:01:38 +0000
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
Subject: [PATCH v4 1/5] cpufreq: Add imx-cpufreq-dt driver
Thread-Topic: [PATCH v4 1/5] cpufreq: Add imx-cpufreq-dt driver
Thread-Index: AQHVCXs9QrWYZ0gPz0ye84T5AOzaPw==
Date:   Mon, 13 May 2019 11:01:38 +0000
Message-ID: <6e0f1b05c6e294ecd448b2cdcf2f8f7bcde2336e.1557742902.git.leonard.crestez@nxp.com>
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
x-ms-office365-filtering-correlation-id: 8feb7173-a4f7-4a4d-9001-08d6d7925f42
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5138;
x-ms-traffictypediagnostic: AM0PR04MB5138:
x-microsoft-antispam-prvs: <AM0PR04MB5138CC53DAF3451FDF8594B7EE0F0@AM0PR04MB5138.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(366004)(136003)(189003)(199004)(7736002)(2906002)(44832011)(99286004)(36756003)(6512007)(53936002)(54906003)(110136005)(476003)(2616005)(4326008)(52116002)(446003)(256004)(486006)(6116002)(3846002)(76176011)(11346002)(66066001)(8676002)(81156014)(81166006)(478600001)(118296001)(102836004)(7416002)(14454004)(68736007)(5660300002)(50226002)(8936002)(6486002)(25786009)(66446008)(64756008)(66556008)(66476007)(71190400001)(71200400001)(86362001)(6436002)(6506007)(386003)(66946007)(73956011)(316002)(26005)(305945005)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5138;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dnXxbDi3Wda5cA0CyQTaRBsDzGAmhu0pm/8+/qgWg7e1B/jr2H3bZ9ZK/mMm68TYfMiu60BFNgv48Puzm/8QaRdWOhuxycWGWLfXNcge4NXKPmpEoqRaNv2oQCjJx51wkIJ1Q4dYLmRqZxHzUfPxJOLPedns2hw2cnIKpOvWa8UgFXJmrNWrJncUJynE08Xz0IquTMBBZ94Oh/5n9P2c2g8BTF+vUgw7wz7Keo819TXY6igh+LNgWWi3UFm1EUupTSq2chr5TKE+WJVtiX07LQTTGaYgXqpyzVDAUcghnPaJhha6g7E0M7wh3lE7qcqUvGytHwzNyMnrBFHbPxXn8FLeRbXv732iWlf13yvb5suK56XGlnu3rmh/6rGdSA+4rIpMyL9YsBuUIEPzSwPUlBAyPfApyPQVlo+7MuLpacQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <13F248F9ABD2714A9970AFF7C2146595@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8feb7173-a4f7-4a4d-9001-08d6d7925f42
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 11:01:38.6846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5138
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Right now in upstream imx8m cpufreq support just lists a common subset
of OPPs because the higher ones should only be attempted after checking
speed grading in fuses.

Add a small driver which checks speed grading from nvmem cells before
registering cpufreq-dt.

This driver allows unlocking all frequencies for imx8mm and imx8mq and
could be applied to other chips like imx7d

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

---
 drivers/cpufreq/Kconfig.arm          |  9 +++
 drivers/cpufreq/Makefile             |  1 +
 drivers/cpufreq/cpufreq-dt-platdev.c |  3 +
 drivers/cpufreq/imx-cpufreq-dt.c     | 96 ++++++++++++++++++++++++++++
 drivers/soc/imx/soc-imx8.c           |  3 +
 5 files changed, 112 insertions(+)
 create mode 100644 drivers/cpufreq/imx-cpufreq-dt.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 179a1d302f48..982efdf9c7e5 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -90,10 +90,19 @@ config ARM_IMX6Q_CPUFREQ
 	help
 	  This adds cpufreq driver support for Freescale i.MX6 series SoCs.
=20
 	  If in doubt, say N.
=20
+config ARM_IMX_CPUFREQ_DT
+	tristate "Freescale i.MX8M cpufreq support"
+	depends on ARCH_MXC && CPUFREQ_DT
+	help
+	  This adds cpufreq driver support for Freescale i.MX8M series SoCs,
+	  based on cpufreq-dt.
+
+	  If in doubt, say N.
+
 config ARM_KIRKWOOD_CPUFREQ
 	def_bool MACH_KIRKWOOD
 	help
 	  This adds the CPUFreq driver for Marvell Kirkwood
 	  SoCs.
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 689b26c6f949..7bcda2273d0c 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -54,10 +54,11 @@ obj-$(CONFIG_ARM_ARMADA_8K_CPUFREQ)	+=3D armada-8k-cpuf=
req.o
 obj-$(CONFIG_ARM_BRCMSTB_AVS_CPUFREQ)	+=3D brcmstb-avs-cpufreq.o
 obj-$(CONFIG_ACPI_CPPC_CPUFREQ)		+=3D cppc_cpufreq.o
 obj-$(CONFIG_ARCH_DAVINCI)		+=3D davinci-cpufreq.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+=3D highbank-cpufreq.o
 obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+=3D imx6q-cpufreq.o
+obj-$(CONFIG_ARM_IMX_CPUFREQ_DT)	+=3D imx-cpufreq-dt.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)	+=3D kirkwood-cpufreq.o
 obj-$(CONFIG_ARM_MEDIATEK_CPUFREQ)	+=3D mediatek-cpufreq.o
 obj-$(CONFIG_MACH_MVEBU_V7)		+=3D mvebu-cpufreq.o
 obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)	+=3D omap-cpufreq.o
 obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)	+=3D pxa2xx-cpufreq.o
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq=
-dt-platdev.c
index 47729a22c159..19c1aad57e26 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -106,10 +106,13 @@ static const struct of_device_id whitelist[] __initco=
nst =3D {
  */
 static const struct of_device_id blacklist[] __initconst =3D {
 	{ .compatible =3D "calxeda,highbank", },
 	{ .compatible =3D "calxeda,ecx-2000", },
=20
+	{ .compatible =3D "fsl,imx8mq", },
+	{ .compatible =3D "fsl,imx8mm", },
+
 	{ .compatible =3D "marvell,armadaxp", },
=20
 	{ .compatible =3D "mediatek,mt2701", },
 	{ .compatible =3D "mediatek,mt2712", },
 	{ .compatible =3D "mediatek,mt7622", },
diff --git a/drivers/cpufreq/imx-cpufreq-dt.c b/drivers/cpufreq/imx-cpufreq=
-dt.c
new file mode 100644
index 000000000000..e1aa346efa10
--- /dev/null
+++ b/drivers/cpufreq/imx-cpufreq-dt.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 NXP
+ */
+
+#include <linux/cpu.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/slab.h>
+
+#define OCOTP_CFG3_SPEED_GRADE_SHIFT	8
+#define OCOTP_CFG3_SPEED_GRADE_MASK	(0x3 << 8)
+#define OCOTP_CFG3_MKT_SEGMENT_SHIFT    6
+#define OCOTP_CFG3_MKT_SEGMENT_MASK     (0x3 << 6)
+
+static const struct of_device_id imx_cpufreq_dt_match_list[] =3D {
+	{ .compatible =3D "fsl,imx8mm" },
+	{ .compatible =3D "fsl,imx8mq" },
+	{}
+};
+
+/* cpufreq-dt device registered by imx-cpufreq-dt */
+static struct platform_device *cpufreq_dt_pdev;
+static struct opp_table *cpufreq_opp_table;
+
+static int imx_cpufreq_dt_probe(struct platform_device *pdev)
+{
+	struct device *cpu_dev =3D get_cpu_device(0);
+	struct device_node *np;
+	const struct of_device_id *match;
+	u32 cell_value, supported_hw[2];
+	int speed_grade, mkt_segment;
+	int ret;
+
+	np =3D of_find_node_by_path("/");
+	match =3D of_match_node(imx_cpufreq_dt_match_list, np);
+	of_node_put(np);
+	if (!match)
+		return -ENODEV;
+
+	ret =3D nvmem_cell_read_u32(cpu_dev, "speed_grade", &cell_value);
+	if (ret)
+		return ret;
+
+	speed_grade =3D (cell_value & OCOTP_CFG3_SPEED_GRADE_MASK) >> OCOTP_CFG3_=
SPEED_GRADE_SHIFT;
+	mkt_segment =3D (cell_value & OCOTP_CFG3_MKT_SEGMENT_MASK) >> OCOTP_CFG3_=
MKT_SEGMENT_SHIFT;
+	supported_hw[0] =3D BIT(speed_grade);
+	supported_hw[1] =3D BIT(mkt_segment);
+	dev_info(&pdev->dev, "cpu speed grade %d mkt segment %d supported-hw %#x =
%#x\n",
+			speed_grade, mkt_segment, supported_hw[0], supported_hw[1]);
+
+	cpufreq_opp_table =3D dev_pm_opp_set_supported_hw(cpu_dev, supported_hw, =
2);
+	if (IS_ERR(cpufreq_opp_table)) {
+		ret =3D PTR_ERR(cpufreq_opp_table);
+		dev_err(&pdev->dev, "Failed to set supported opp: %d\n", ret);
+		return ret;
+	}
+
+	cpufreq_dt_pdev =3D platform_device_register_data(
+			&pdev->dev, "cpufreq-dt", -1, NULL, 0);
+	if (IS_ERR(cpufreq_dt_pdev)) {
+		dev_pm_opp_put_supported_hw(cpufreq_opp_table);
+		ret =3D PTR_ERR(cpufreq_dt_pdev);
+		dev_err(&pdev->dev, "Failed to register cpufreq-dt: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int imx_cpufreq_dt_remove(struct platform_device *pdev)
+{
+	platform_device_unregister(cpufreq_dt_pdev);
+	dev_pm_opp_put_supported_hw(cpufreq_opp_table);
+
+	return 0;
+}
+
+static struct platform_driver imx_cpufreq_dt_driver =3D {
+	.probe =3D imx_cpufreq_dt_probe,
+	.remove =3D imx_cpufreq_dt_remove,
+	.driver =3D {
+		.name =3D "imx-cpufreq-dt",
+	},
+};
+module_platform_driver(imx_cpufreq_dt_driver);
+
+MODULE_ALIAS("platform:imx-cpufreq-dt");
+MODULE_DESCRIPTION("Freescale i.MX cpufreq speed grading driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/soc/imx/soc-imx8.c b/drivers/soc/imx/soc-imx8.c
index cd10726e64e4..02988bdfbb73 100644
--- a/drivers/soc/imx/soc-imx8.c
+++ b/drivers/soc/imx/soc-imx8.c
@@ -130,10 +130,13 @@ static int __init imx8_soc_init(void)
=20
 	soc_dev =3D soc_device_register(soc_dev_attr);
 	if (IS_ERR(soc_dev))
 		goto free_rev;
=20
+	if (IS_ENABLED(CONFIG_ARM_IMX_CPUFREQ_DT))
+		platform_device_register_simple("imx-cpufreq-dt", -1, NULL, 0);
+
 	return 0;
=20
 free_rev:
 	kfree(soc_dev_attr->revision);
 free_soc:
--=20
2.17.1

