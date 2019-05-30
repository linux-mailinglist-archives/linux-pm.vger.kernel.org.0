Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A98F2F7CA
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2019 09:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfE3HOC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 May 2019 03:14:02 -0400
Received: from mail-eopbgr60081.outbound.protection.outlook.com ([40.107.6.81]:2786
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726512AbfE3HOC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 May 2019 03:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIVg2C99l8a4weHFaFO+iplmx2JAVjWAAx7OToJ54O0=;
 b=JuvBlmEnhlhGpeTu7TktNbluLA6LhzJYEXtFXcsPB6jzAVT+jWZD8Py3rmwMW7swWHZcQBpx3rFuIkFLgzMZHevvi1EuXfamYQXO/NajhQNeYRftnvFNva3llTtRCzD/YwjC8Emee4QtkFU7wiwCmM8O30JWOvfdgEMKxSAw9yQ=
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com (20.177.50.140) by
 VI1PR04MB6047.eurprd04.prod.outlook.com (20.179.24.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.18; Thu, 30 May 2019 07:13:51 +0000
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::9577:379c:2078:19a1]) by VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::9577:379c:2078:19a1%7]) with mapi id 15.20.1922.021; Thu, 30 May 2019
 07:13:51 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Alexandre Bailon <abailon@baylibre.com>
CC:     Viresh Kumar <viresh.kumar@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Cedric Neveux <cedric.neveux@nxp.com>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        Nitin Garg <nitin.garg@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [RFC] clk: imx8mm: Add dram freq switch support
Thread-Topic: [RFC] clk: imx8mm: Add dram freq switch support
Thread-Index: AQHVFrc7ODGIzaJAMkqnt2iUWhij6w==
Date:   Thu, 30 May 2019 07:13:51 +0000
Message-ID: <475e0250b1e77a660c095749e78427fde318d5f6.1559200405.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [89.37.124.34]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: VI1PR0501CA0015.eurprd05.prod.outlook.com
 (2603:10a6:800:92::25) To VI1PR04MB5055.eurprd04.prod.outlook.com
 (2603:10a6:803:5a::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45172222-fb3a-4009-e5af-08d6e4ce5dfb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB6047;
x-ms-traffictypediagnostic: VI1PR04MB6047:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR04MB6047CE5232FBF7D970174DD0EE180@VI1PR04MB6047.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(366004)(136003)(199004)(189003)(256004)(66476007)(14444005)(64756008)(7736002)(30864003)(6116002)(7416002)(66946007)(118296001)(73956011)(3846002)(54906003)(71200400001)(71190400001)(66446008)(66556008)(305945005)(4326008)(478600001)(186003)(5660300002)(50226002)(486006)(53936002)(6486002)(316002)(8676002)(25786009)(966005)(8936002)(36756003)(81156014)(6436002)(52116002)(6306002)(476003)(68736007)(6512007)(110136005)(66066001)(99286004)(26005)(44832011)(14454004)(2616005)(86362001)(6506007)(81166006)(102836004)(386003)(2906002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6047;H:VI1PR04MB5055.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RCFz6+T4Up/miurlNAD80Mu5Wt8ioL3C+fbpyNvd5MFnqNKodVnzrJOBh7ea9maoqB3ML0aVPuDOspwAj7/IvJK+3KWS1ooRaEbwJNt1gtHJnqryxywH73H6t7XQ5SqizR9/Sre45uitvBbiyWL//BXQvfHBfkLB74e9CbNOa4qKl+g6MmGCdur5PY1KugvRxiFE3EBDi1uAfqPHAKn7wLVSdrw3ILLi4PyhuSrJHDg+PZr93EfLiubVrJmDwoKv32yVJworZn5NeLU6cwJXUKFl3N3tlnb01qS4z6t8f1QnJ/1d/DH7hGMIwQ0BvdX5sKEQaLeQ/wu7HEjajjb0CY1CDqFOazohaaRslTtY9nGtjOy06iv9e3+KEWD5oYYwIACTyMBy42IsN/QMpUjW3WAELBvfJyyWFtscCVekgMM=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <F84BE17CA53E23499156904360E6603F@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45172222-fb3a-4009-e5af-08d6e4ce5dfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 07:13:51.4966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonard.crestez@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6047
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a wrapper clock encapsulating dram frequency switch support for
imx8m chips. This allows higher-level DVFS code to manipulate dram
frequency using standard clock framework APIs.

Linux-side implementation is similar in principle to imx_clk_cpu or a
composite clock. Only some preparation is done inside the kernel, the
actual freq switch is performed from TF-A code which runs from an SRAM
area. Cores other than the one performing the switch are also made to
spin inside TF-A by sending each an IRQ.

This is an early proof-of-concept which only support low/high mode on
imx8mm but NXP has secure-world dram freq switching implementations for
multiple other chips and this approach can be extended.

This was tested using a large pile of NXP out-of-tree patches. Code for
the "busfreq core" from last release can be seen here:
https://source.codeaurora.org/external/imx/linux-imx/tree/drivers/soc/imx/b=
usfreq-imx8mq.c?h=3Dimx_4.14.98_2.0.0_ga

It can be likely made to work with interconnect RFC:
https://patchwork.kernel.org/cover/10851705/

This RFC effectively refactors a common part between them.

Among the possible cleanups:
 * Handle errors in low/high busfreq code and back off
 * Move irq to secure world
 * Try to use fewer clk parameters
 * More chips and frequencies

Many platforms handle this kind of stuff externally but cpufreq is quite
insistent that actual rates are set by clk code and that new platforms
use cpufreq-dt.

Let me know if there are objections to handling dram freq via clk.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/clk/imx/Makefile                 |   2 +-
 drivers/clk/imx/clk-imx8m-dram.c         | 256 +++++++++++++++++++++++
 drivers/clk/imx/clk-imx8mm.c             |  12 ++
 drivers/clk/imx/clk.h                    |  13 ++
 include/dt-bindings/clock/imx8mm-clock.h |   4 +-
 5 files changed, 285 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/imx/clk-imx8m-dram.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 05641c64b317..0588070a9a1f 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -23,11 +23,11 @@ obj-$(CONFIG_MXC_CLK) +=3D \
=20
 obj-$(CONFIG_MXC_CLK_SCU) +=3D \
 	clk-scu.o \
 	clk-lpcg-scu.o
=20
-obj-$(CONFIG_CLK_IMX8MM) +=3D clk-imx8mm.o
+obj-$(CONFIG_CLK_IMX8MM) +=3D clk-imx8mm.o clk-imx8m-dram.o
 obj-$(CONFIG_CLK_IMX8MQ) +=3D clk-imx8mq.o
 obj-$(CONFIG_CLK_IMX8QXP) +=3D clk-imx8qxp.o clk-imx8qxp-lpcg.o
=20
 obj-$(CONFIG_SOC_IMX1)   +=3D clk-imx1.o
 obj-$(CONFIG_SOC_IMX21)  +=3D clk-imx21.o
diff --git a/drivers/clk/imx/clk-imx8m-dram.c b/drivers/clk/imx/clk-imx8m-d=
ram.c
new file mode 100644
index 000000000000..18a1411d154e
--- /dev/null
+++ b/drivers/clk/imx/clk-imx8m-dram.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 NXP
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+#include <linux/of_irq.h>
+#include "clk.h"
+
+#define FSL_SIP_DDR_DVFS                0xc2000004
+
+#define FSL_SIP_DDR_FREQ_SET_HIGH	0x0
+#define FSL_SIP_DDR_FREQ_SET_100MTS	0x2
+#define FSL_SIP_DDR_FREQ_WAIT_DONE	0xf
+
+struct dram_clk {
+	struct clk_hw	hw;
+	struct clk	*dram_core;
+	struct clk	*dram_apb;
+	struct clk	*dram_pll;
+	struct clk	*dram_alt;
+	struct clk	*dram_alt_root;
+	struct clk	*sys1_pll_40m;
+	struct clk	*sys1_pll_100m;
+	struct clk	*sys1_pll_800m;
+	int		irqs[CONFIG_NR_CPUS];
+};
+
+static inline struct dram_clk *to_dram_clk(struct clk_hw *hw)
+{
+	return container_of(hw, struct dram_clk, hw);
+}
+
+static irqreturn_t wait_in_wfe_irq(int irq, void *dev_id)
+{
+	struct arm_smccc_res res;
+
+	/* call smc trap to ATF */
+	arm_smccc_smc(FSL_SIP_DDR_DVFS, FSL_SIP_DDR_FREQ_WAIT_DONE, 0,
+		0, 0, 0, 0, 0, &res);
+
+	return IRQ_HANDLED;
+}
+
+static void update_bus_freq(int target_freq)
+{
+	struct arm_smccc_res res;
+	u32 online_cpus =3D 0;
+	int cpu =3D 0;
+
+	local_irq_disable();
+
+	for_each_online_cpu(cpu)
+		online_cpus |=3D (1 << (cpu * 8));
+
+	/* change the ddr freqency */
+	arm_smccc_smc(FSL_SIP_DDR_DVFS, target_freq, online_cpus,
+		0, 0, 0, 0, 0, &res);
+
+	local_irq_enable();
+}
+
+static int dram_clk_ensure_irq_affinity(struct dram_clk* priv)
+{
+	int err, cpu;
+
+	for_each_online_cpu(cpu) {
+		err =3D irq_set_affinity(priv->irqs[cpu], cpumask_of(cpu));
+		if (err) {
+			pr_err("imx8m_dram_clk set irqs[%d] affinity failed: %d\n",
+				cpu, err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int dram_clk_set_low(struct dram_clk *priv)
+{
+	// FIXME: error handling
+	clk_prepare_enable(priv->sys1_pll_40m);
+	clk_prepare_enable(priv->dram_alt_root);
+	clk_prepare_enable(priv->sys1_pll_100m);
+
+	/* switch the DDR freqeuncy */
+	update_bus_freq(FSL_SIP_DDR_FREQ_SET_100MTS);
+
+	/* correct the clock tree info */
+	clk_set_parent(priv->dram_alt, priv->sys1_pll_100m);
+	clk_set_parent(priv->dram_core, priv->dram_alt_root);
+	clk_set_parent(priv->dram_apb, priv->sys1_pll_40m);
+	clk_set_rate(priv->dram_apb, 20000000);
+	clk_disable_unprepare(priv->sys1_pll_100m);
+	clk_disable_unprepare(priv->sys1_pll_40m);
+	clk_disable_unprepare(priv->dram_alt_root);
+	return 0;
+}
+
+static int dram_clk_set_high(struct dram_clk *priv)
+{
+	// FIXME: error handling
+	clk_prepare_enable(priv->sys1_pll_800m);
+	clk_prepare_enable(priv->dram_pll);
+
+	/* switch the DDR freqeuncy */
+	update_bus_freq(FSL_SIP_DDR_FREQ_SET_HIGH);
+
+	/* correct the clock tree info */
+	clk_set_parent(priv->dram_apb, priv->sys1_pll_800m);
+	clk_set_rate(priv->dram_apb, 160000000);
+	clk_set_parent(priv->dram_core, priv->dram_pll);
+	clk_disable_unprepare(priv->sys1_pll_800m);
+	clk_disable_unprepare(priv->dram_pll);
+
+	return 0;
+}
+
+static long dram_clk_round_rate(struct clk_hw *hw,
+		unsigned long rate,
+		unsigned long *parent_rate)
+{
+	// FIXME: table?
+	if (rate < 387500000)
+		return 250000000;
+	else
+		return 75000000000;
+}
+
+static int dram_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	struct dram_clk *priv =3D to_dram_clk(hw);
+	int ret;
+
+	ret =3D dram_clk_ensure_irq_affinity(priv);
+	if (ret)
+		return ret;
+
+	if (rate =3D=3D 250000000) {
+		return dram_clk_set_low(priv);
+	} else if (rate =3D=3D 75000000000) {
+		return dram_clk_set_high(priv);
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static unsigned long dram_clk_recalc_rate(struct clk_hw *hw, unsigned long=
 parent_rate)
+{
+	struct dram_clk *priv =3D to_dram_clk(hw);
+
+	return clk_get_rate(priv->dram_core);
+}
+
+static const struct clk_ops dram_clk_ops =3D {
+	.recalc_rate	=3D dram_clk_recalc_rate,
+	.round_rate	=3D dram_clk_round_rate,
+	.set_rate	=3D dram_clk_set_rate,
+};
+
+static int dram_clk_init_irqs(struct dram_clk* priv, struct device_node *n=
p)
+{
+	int err, irq, cpu;
+
+	for_each_possible_cpu(cpu) {
+		irq =3D of_irq_get(np, cpu);
+		if (irq < 0) {
+			pr_err("imx8m_dram_clk fail of_irq_get %d\n", irq);
+			return irq;
+		}
+
+		err =3D request_irq(irq, wait_in_wfe_irq,
+				IRQF_PERCPU, "ddrc", NULL);
+		if (err) {
+			pr_err("imx8m_dram_clk request irq %d failed: %d\n",
+				irq, err);
+			return err;
+		}
+		priv->irqs[cpu] =3D irq;
+	}
+
+	return 0;
+}
+
+static void dram_clk_free_irqs(struct dram_clk* priv)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		free_irq(priv->irqs[cpu], NULL);
+		priv->irqs[cpu] =3D 0;
+	}
+}
+
+struct clk* imx8m_dram_clk(
+		struct device_node* np,
+		const char *name, const char* parent_name,
+		struct clk* dram_core,
+		struct clk* dram_apb,
+		struct clk* dram_pll,
+		struct clk* dram_alt,
+		struct clk* dram_alt_root,
+		struct clk* sys1_pll_40m,
+		struct clk* sys1_pll_100m,
+		struct clk* sys1_pll_800m)
+{
+	struct dram_clk *priv;
+	struct clk *clk;
+	struct clk_init_data init;
+	int err;
+
+	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return ERR_PTR(-ENOMEM);
+
+	priv->dram_apb =3D dram_apb;
+	priv->dram_core =3D dram_core;
+	priv->dram_pll =3D dram_pll;
+	priv->dram_alt =3D dram_alt;
+	priv->dram_alt_root =3D dram_alt_root;
+	priv->sys1_pll_40m =3D sys1_pll_40m;
+	priv->sys1_pll_100m =3D sys1_pll_100m;
+	priv->sys1_pll_800m =3D sys1_pll_800m;
+
+	init.name =3D name;
+	init.ops =3D &dram_clk_ops;
+	init.flags =3D CLK_IS_CRITICAL;
+	init.parent_names =3D &parent_name;
+	init.num_parents =3D 1;
+
+	err =3D dram_clk_init_irqs(priv, np);
+	if (err)
+		goto err_free_priv;
+
+	priv->hw.init =3D &init;
+	clk =3D clk_register(NULL, &priv->hw);
+	if (IS_ERR(clk)) {
+		err =3D PTR_ERR(clk);
+		goto err_free_irqs;
+	}
+	return clk;
+
+err_free_irqs:
+	dram_clk_free_irqs(priv);
+err_free_priv:
+	kfree(priv);
+	return ERR_PTR(err);
+}
diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index eb9fcf0df0b2..2edb62b10572 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -660,10 +660,22 @@ static int __init imx8mm_clocks_init(struct device_no=
de *ccm_node)
 	clks[IMX8MM_CLK_GPT_3M] =3D imx_clk_fixed_factor("gpt_3m", "osc_24m", 1, =
8);
=20
 	clks[IMX8MM_CLK_DRAM_ALT_ROOT] =3D imx_clk_fixed_factor("dram_alt_root", =
"dram_alt", 1, 4);
 	clks[IMX8MM_CLK_DRAM_CORE] =3D imx_clk_mux2_flags("dram_core_clk", base +=
 0x9800, 24, 1, imx8mm_dram_core_sels, ARRAY_SIZE(imx8mm_dram_core_sels), C=
LK_IS_CRITICAL);
=20
+	clks[IMX8MM_CLK_DRAM] =3D imx8m_dram_clk(
+			ccm_node,
+			"dram", "dram_core_clk",
+			clks[IMX8MM_CLK_DRAM_CORE],
+			clks[IMX8MM_CLK_DRAM_APB],
+			clks[IMX8MM_DRAM_PLL_OUT],
+			clks[IMX8MM_CLK_DRAM_ALT],
+			clks[IMX8MM_CLK_DRAM_ALT_ROOT],
+			clks[IMX8MM_SYS_PLL1_40M],
+			clks[IMX8MM_SYS_PLL1_100M],
+			clks[IMX8MM_SYS_PLL1_800M]);
+
 	clks[IMX8MM_CLK_ARM] =3D imx_clk_cpu("arm", "arm_a53_div",
 					   clks[IMX8MM_CLK_A53_DIV],
 					   clks[IMX8MM_CLK_A53_SRC],
 					   clks[IMX8MM_ARM_PLL_OUT],
 					   clks[IMX8MM_CLK_24M]);
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 6dcdc91cbba8..f41e27d3132c 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -396,6 +396,19 @@ struct clk *imx8m_clk_composite_flags(const char *name=
,
=20
 struct clk_hw *imx_clk_divider_gate(const char *name, const char *parent_n=
ame,
 		unsigned long flags, void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags, const struct clk_div_table *table,
 		spinlock_t *lock);
+
+struct clk* imx8m_dram_clk(
+		struct device_node *np,
+		const char *name, const char* parent_name,
+		struct clk* dram_core,
+		struct clk* dram_apb,
+		struct clk* dram_pll,
+		struct clk* dram_alt,
+		struct clk* dram_alt_root,
+		struct clk* sys1_pll_40m,
+		struct clk* sys1_pll_100m,
+		struct clk* sys1_pll_800m);
+
 #endif
diff --git a/include/dt-bindings/clock/imx8mm-clock.h b/include/dt-bindings=
/clock/imx8mm-clock.h
index 07e6c686f3ef..dde146b923a8 100644
--- a/include/dt-bindings/clock/imx8mm-clock.h
+++ b/include/dt-bindings/clock/imx8mm-clock.h
@@ -246,8 +246,10 @@
 #define IMX8MM_CLK_GPIO5_ROOT			227
=20
 #define IMX8MM_CLK_SNVS_ROOT			228
 #define IMX8MM_CLK_GIC				229
=20
-#define IMX8MM_CLK_END				230
+#define IMX8MM_CLK_DRAM				230
+
+#define IMX8MM_CLK_END				231
=20
 #endif
--=20
2.17.1

