Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF0D455355
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 04:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242747AbhKRDWH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 22:22:07 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:44269 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239873AbhKRDVs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 22:21:48 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0C3D65808BA;
        Wed, 17 Nov 2021 22:18:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 17 Nov 2021 22:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=qFBdOad+LATh1
        EQyunyx2SN0JGqvh+Ex84Z4hp/BFIQ=; b=TlQUh+ihn02ip15RcM6hTnpkOZ+bm
        o0KHmcaV3VukyuqJImaNpkzL+korxXihexYJsgTYkHT+yQbZDhzLjY8zJBSqLOsz
        3d19/l6/NirhInc7AXPVPNvzOaqpD0LL+syEFOmU1Z7lykJvFlCiE33x2xcKGDrt
        urSCb4nU10Gbf1zF3kcmXu4GMEdm8rBvbZ9qk5T1n42OIjkg2+1n6hJTTpyo1u3Z
        H6aaH68uG/V6KAIqvHlxmdPgKpfD63i2avZ7smauJTWxPLdMTTfYU9HGzR9fK7d6
        J+Wtk41WTDOzwvDvP7YkNpqTXNKSf16XCvEwdE/bE3gtRO8xse0Y0Nktg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=qFBdOad+LATh1EQyunyx2SN0JGqvh+Ex84Z4hp/BFIQ=; b=VpQqze0X
        w6weI/g8lUN7iOX1cDm/UFIN1rfWCYPTPwJIynjRKudbH+NBBYJiEh0qhQh2wqxC
        q3VDGpYj6O5LUo6fNttQX9Ttf3qAk6w+XsIu7PrKjseQ8yiJ/ROUnmK8Vb8H/QbP
        Izdg/rAINAPkK3jVKATJGPY7do6sUSr+xdAFKOk3QVbbV8J8lGPytZwMGTEkSw8g
        pYzzekhJo8camx63g8o4ZkwNZcbu/4Cy4R72DDKQf6UM/2X8bXqz6ctuq/axozNS
        hEJEqCoS/s07gLaCW4Ev2GaqLLqylMiTtRfPybztPQykXKjKtSgGR20qtOH61QST
        y/x+hBMMkV5Yxg==
X-ME-Sender: <xms:GMaVYfG2ftnwFRiJCxPZgqKdg1576jCiIei8K9nloTgpxMydJmexnA>
    <xme:GMaVYcWGcl9zqgNw6stt59kCaAvmaq6PnuE19bvmn0MbfePzD9UNyOYyi2UyIV5ZU
    FfmrbobUQJon8Hb6g>
X-ME-Received: <xmr:GMaVYRK41JOZid1PGmgDM0-8BOLqsEHdrrqAbYKX9RoHDHtsfjZxxLFFLhmgXdLg217ZgzDcgscvlTbXnvpRNJGH3Sc_IB0Wva611xMxIlJ3bE0CUQb6CC_aBho_jW4ZZfMO2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeehgdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:GMaVYdH3baDzmvyXF4cOYHzW7t6U3GFZ48jU3qEs4cc5DFxGBdFkbA>
    <xmx:GMaVYVUOaAqXG_YtbPhl594PQoKLv6JPV8Z1sKFCpOaios1s6VPzLg>
    <xmx:GMaVYYMUcVjy1hg7VLMXCDt_uUkgOmqF4ixnZDAUh2SaLHgGlxvRiw>
    <xmx:GcaVYQNO0QAplukJQ4P0B6X-jAsjZkG5ma6VX0b0ARtG2Zkjw-HtXQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Nov 2021 22:18:48 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 6/6] PM / devfreq: Add a driver for the sun8i/sun50i MBUS
Date:   Wed, 17 Nov 2021 21:18:41 -0600
Message-Id: <20211118031841.42315-7-samuel@sholland.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211118031841.42315-1-samuel@sholland.org>
References: <20211118031841.42315-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This driver works by adjusting the divider on the DRAM controller's
module clock. Thus there is no fixed set of OPPs, only "full speed" down
to "quarter speed" (or whatever the maximum divider is on that variant).

It makes use of the MDFS hardware in the MBUS, in "DFS" mode, which
takes care of updating registers during the critical section while DRAM
is inaccessible.

This driver should support several sunxi SoCs, starting with the A33,
which have a DesignWare DDR3 controller with merged PHY register space
and the matching MBUS register layout (so not A63 or later). However,
the driver has only been tested on the A64/H5, so those are the only
compatibles enabled for now.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/devfreq/Kconfig          |   8 +
 drivers/devfreq/Makefile         |   1 +
 drivers/devfreq/sun8i-a33-mbus.c | 511 +++++++++++++++++++++++++++++++
 3 files changed, 520 insertions(+)
 create mode 100644 drivers/devfreq/sun8i-a33-mbus.c

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index e87d01c0b76a..b94eb04761f6 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -132,6 +132,14 @@ config ARM_RK3399_DMC_DEVFREQ
 	  It sets the frequency for the memory controller and reads the usage counts
 	  from hardware.
 
+config ARM_SUN8I_A33_MBUS_DEVFREQ
+	tristate "sun8i/sun50i MBUS DEVFREQ Driver"
+	depends on ARCH_SUNXI || COMPILE_TEST
+	select DEVFREQ_GOV_SIMPLE_ONDEMAND
+	help
+	  This adds the DEVFREQ driver for the MBUS controller in some
+	  Allwinner sun8i (A33 through H3) and sun50i (A64 and H5) SoCs.
+
 source "drivers/devfreq/event/Kconfig"
 
 endif # PM_DEVFREQ
diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
index a16333ea7034..0b6be92a25d9 100644
--- a/drivers/devfreq/Makefile
+++ b/drivers/devfreq/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
 obj-$(CONFIG_ARM_IMX_BUS_DEVFREQ)	+= imx-bus.o
 obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)	+= imx8m-ddrc.o
 obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
+obj-$(CONFIG_ARM_SUN8I_A33_MBUS_DEVFREQ)	+= sun8i-a33-mbus.o
 obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
 
 # DEVFREQ Event Drivers
diff --git a/drivers/devfreq/sun8i-a33-mbus.c b/drivers/devfreq/sun8i-a33-mbus.c
new file mode 100644
index 000000000000..13d32213139f
--- /dev/null
+++ b/drivers/devfreq/sun8i-a33-mbus.c
@@ -0,0 +1,511 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Copyright (C) 2020-2021 Samuel Holland <samuel@sholland.org>
+//
+
+#include <linux/clk.h>
+#include <linux/devfreq.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+
+#define MBUS_CR				0x0000
+#define MBUS_CR_GET_DRAM_TYPE(x)	(((x) >> 16) & 0x7)
+#define MBUS_CR_DRAM_TYPE_DDR2		2
+#define MBUS_CR_DRAM_TYPE_DDR3		3
+#define MBUS_CR_DRAM_TYPE_DDR4		4
+#define MBUS_CR_DRAM_TYPE_LPDDR2	6
+#define MBUS_CR_DRAM_TYPE_LPDDR3	7
+
+#define MBUS_TMR			0x000c
+#define MBUS_TMR_PERIOD(x)		((x) - 1)
+
+#define MBUS_PMU_CFG			0x009c
+#define MBUS_PMU_CFG_PERIOD(x)		(((x) - 1) << 16)
+#define MBUS_PMU_CFG_UNIT		(0x3 << 1)
+#define MBUS_PMU_CFG_UNIT_B		(0x0 << 1)
+#define MBUS_PMU_CFG_UNIT_KB		(0x1 << 1)
+#define MBUS_PMU_CFG_UNIT_MB		(0x2 << 1)
+#define MBUS_PMU_CFG_ENABLE		(0x1 << 0)
+
+#define MBUS_PMU_BWCR(n)		(0x00a0 + (0x04 * (n)))
+
+#define MBUS_TOTAL_BWCR			MBUS_PMU_BWCR(5)
+#define MBUS_TOTAL_BWCR_H616		MBUS_PMU_BWCR(13)
+
+#define MBUS_MDFSCR			0x0100
+#define MBUS_MDFSCR_BUFFER_TIMING	(0x1 << 15)
+#define MBUS_MDFSCR_PAD_HOLD		(0x1 << 13)
+#define MBUS_MDFSCR_BYPASS		(0x1 << 4)
+#define MBUS_MDFSCR_MODE		(0x1 << 1)
+#define MBUS_MDFSCR_MODE_DFS		(0x0 << 1)
+#define MBUS_MDFSCR_MODE_CFS		(0x1 << 1)
+#define MBUS_MDFSCR_START		(0x1 << 0)
+
+#define MBUS_MDFSMRMR			0x0108
+
+#define DRAM_PWRCTL			0x0004
+#define DRAM_PWRCTL_SELFREF_EN		(0x1 << 0)
+
+#define DRAM_RFSHTMG			0x0090
+#define DRAM_RFSHTMG_TREFI(x)		((x) << 16)
+#define DRAM_RFSHTMG_TRFC(x)		((x) << 0)
+
+#define DRAM_VTFCR			0x00b8
+#define DRAM_VTFCR_VTF_ENABLE		(0x3 << 8)
+
+#define DRAM_ODTMAP			0x0120
+
+#define DRAM_DX_MAX			4
+
+#define DRAM_DXnGCR0(n)			(0x0344 + 0x80 * (n))
+#define DRAM_DXnGCR0_DXODT		(0x3 << 4)
+#define DRAM_DXnGCR0_DXODT_DYNAMIC	(0x0 << 4)
+#define DRAM_DXnGCR0_DXODT_ENABLED	(0x1 << 4)
+#define DRAM_DXnGCR0_DXODT_DISABLED	(0x2 << 4)
+#define DRAM_DXnGCR0_DXEN		(0x1 << 0)
+
+struct sun8i_a33_mbus_variant {
+	u32					min_dram_divider;
+	u32					max_dram_divider;
+	u32					odt_freq_mhz;
+};
+
+struct sun8i_a33_mbus {
+	const struct sun8i_a33_mbus_variant	*variant;
+	void __iomem				*reg_dram;
+	void __iomem				*reg_mbus;
+	struct clk				*clk_bus;
+	struct clk				*clk_dram;
+	struct clk				*clk_mbus;
+	struct devfreq				*devfreq_dram;
+	struct devfreq_simple_ondemand_data	gov_data;
+	struct devfreq_dev_profile		profile;
+	u32					data_width;
+	u32					nominal_bw;
+	u32					odtmap;
+	u32					tREFI_ns;
+	u32					tRFC_ns;
+	unsigned long				freq_table[];
+};
+
+/*
+ * The unit for this value is (MBUS clock cycles / MBUS_TMR_PERIOD). When
+ * MBUS_TMR_PERIOD is programmed to match the MBUS clock frequency in MHz, as
+ * it is during DRAM init and during probe, the resulting unit is microseconds.
+ */
+static int pmu_period = 50000;
+module_param(pmu_period, int, 0644);
+MODULE_PARM_DESC(pmu_period, "Bandwidth measurement period (microseconds)");
+
+static u32 sun8i_a33_mbus_get_peak_bw(struct sun8i_a33_mbus *priv)
+{
+	/* Returns the peak transfer (in KiB) during any single PMU period. */
+	return readl_relaxed(priv->reg_mbus + MBUS_TOTAL_BWCR);
+}
+
+static void sun8i_a33_mbus_restart_pmu_counters(struct sun8i_a33_mbus *priv)
+{
+	u32 pmu_cfg = MBUS_PMU_CFG_PERIOD(pmu_period) | MBUS_PMU_CFG_UNIT_KB;
+
+	/* All PMU counters are cleared on a disable->enable transition. */
+	writel_relaxed(pmu_cfg,
+		       priv->reg_mbus + MBUS_PMU_CFG);
+	writel_relaxed(pmu_cfg | MBUS_PMU_CFG_ENABLE,
+		       priv->reg_mbus + MBUS_PMU_CFG);
+
+}
+
+static void sun8i_a33_mbus_update_nominal_bw(struct sun8i_a33_mbus *priv,
+					     u32 ddr_freq_mhz)
+{
+	/*
+	 * Nominal bandwidth (KiB per PMU period):
+	 *
+	 *   DDR transfers   microseconds     KiB
+	 *   ------------- * ------------ * --------
+	 *    microsecond     PMU period    transfer
+	 */
+	priv->nominal_bw = ddr_freq_mhz * pmu_period * priv->data_width / 1024;
+}
+
+static int sun8i_a33_mbus_set_dram_freq(struct sun8i_a33_mbus *priv,
+					unsigned long freq)
+{
+	u32  ddr_freq_mhz = freq / USEC_PER_SEC; /* DDR */
+	u32 dram_freq_mhz =    ddr_freq_mhz / 2; /* SDR */
+	u32 mctl_freq_mhz =   dram_freq_mhz / 2; /* HDR */
+	u32 dxodt, mdfscr, pwrctl, vtfcr;
+	u32 i, tREFI_32ck, tRFC_ck;
+	int ret;
+
+	/* The rate change is not effective until the MDFS process runs. */
+	ret = clk_set_rate(priv->clk_dram, freq);
+	if (ret)
+		return ret;
+
+	/* Disable automatic self-refesh and VTF before starting MDFS. */
+	pwrctl = readl_relaxed(priv->reg_dram + DRAM_PWRCTL) &
+		 ~DRAM_PWRCTL_SELFREF_EN;
+	writel_relaxed(pwrctl, priv->reg_dram + DRAM_PWRCTL);
+	vtfcr = readl_relaxed(priv->reg_dram + DRAM_VTFCR);
+	writel_relaxed(vtfcr & ~DRAM_VTFCR_VTF_ENABLE,
+		       priv->reg_dram + DRAM_VTFCR);
+
+	/* Set up MDFS and enable double buffering for timing registers. */
+	mdfscr = MBUS_MDFSCR_MODE_DFS |
+		 MBUS_MDFSCR_BYPASS |
+		 MBUS_MDFSCR_PAD_HOLD |
+		 MBUS_MDFSCR_BUFFER_TIMING;
+	writel(mdfscr, priv->reg_mbus + MBUS_MDFSCR);
+
+	/* Update the buffered copy of RFSHTMG. */
+	tREFI_32ck = priv->tREFI_ns * mctl_freq_mhz / 1000 / 32;
+	tRFC_ck = DIV_ROUND_UP(priv->tRFC_ns * mctl_freq_mhz, 1000);
+	writel(DRAM_RFSHTMG_TREFI(tREFI_32ck) | DRAM_RFSHTMG_TRFC(tRFC_ck),
+	       priv->reg_dram + DRAM_RFSHTMG);
+
+	/* Enable ODT if needed, or disable it to save power. */
+	if (priv->odtmap && dram_freq_mhz > priv->variant->odt_freq_mhz) {
+		dxodt = DRAM_DXnGCR0_DXODT_DYNAMIC;
+		writel(priv->odtmap, priv->reg_dram + DRAM_ODTMAP);
+	} else {
+		dxodt = DRAM_DXnGCR0_DXODT_DISABLED;
+		writel(0, priv->reg_dram + DRAM_ODTMAP);
+	}
+	for (i = 0; i < DRAM_DX_MAX; ++i) {
+		void __iomem *reg = priv->reg_dram + DRAM_DXnGCR0(i);
+
+		writel((readl(reg) & ~DRAM_DXnGCR0_DXODT) | dxodt, reg);
+	}
+
+	dev_dbg(priv->devfreq_dram->dev.parent,
+		"Setting DRAM to %u MHz, tREFI=%u, tRFC=%u, ODT=%s\n",
+		dram_freq_mhz, tREFI_32ck, tRFC_ck,
+		dxodt == DRAM_DXnGCR0_DXODT_DYNAMIC ? "dynamic" : "disabled");
+
+	/* Trigger hardware MDFS. */
+	writel(mdfscr | MBUS_MDFSCR_START, priv->reg_mbus + MBUS_MDFSCR);
+	ret = readl_poll_timeout_atomic(priv->reg_mbus + MBUS_MDFSCR, mdfscr,
+					!(mdfscr & MBUS_MDFSCR_START), 10, 1000);
+	if (ret)
+		return ret;
+
+	/* Disable double buffering. */
+	writel(0, priv->reg_mbus + MBUS_MDFSCR);
+
+	/* Restore VTF configuration. */
+	writel_relaxed(vtfcr, priv->reg_dram + DRAM_VTFCR);
+
+	/* Enable automatic self-refresh at the lowest frequency only. */
+	if (freq == priv->freq_table[0])
+		pwrctl |= DRAM_PWRCTL_SELFREF_EN;
+	writel_relaxed(pwrctl, priv->reg_dram + DRAM_PWRCTL);
+
+	sun8i_a33_mbus_restart_pmu_counters(priv);
+	sun8i_a33_mbus_update_nominal_bw(priv, ddr_freq_mhz);
+
+	return 0;
+}
+
+static int sun8i_a33_mbus_set_dram_target(struct device *dev,
+					  unsigned long *freq, u32 flags)
+{
+	struct sun8i_a33_mbus *priv = dev_get_drvdata(dev);
+	struct devfreq *devfreq = priv->devfreq_dram;
+	struct dev_pm_opp *opp;
+	int ret;
+
+	opp = devfreq_recommended_opp(dev, freq, flags);
+	if (IS_ERR(opp))
+		return PTR_ERR(opp);
+
+	dev_pm_opp_put(opp);
+
+	if (*freq == devfreq->previous_freq)
+		return 0;
+
+	ret = sun8i_a33_mbus_set_dram_freq(priv, *freq);
+	if (ret) {
+		dev_warn(dev, "failed to set DRAM frequency: %d\n", ret);
+		*freq = devfreq->previous_freq;
+	}
+
+	return ret;
+}
+
+static int sun8i_a33_mbus_get_dram_status(struct device *dev,
+					  struct devfreq_dev_status *stat)
+{
+	struct sun8i_a33_mbus *priv = dev_get_drvdata(dev);
+
+	stat->busy_time		= sun8i_a33_mbus_get_peak_bw(priv);
+	stat->total_time	= priv->nominal_bw;
+	stat->current_frequency	= priv->devfreq_dram->previous_freq;
+
+	sun8i_a33_mbus_restart_pmu_counters(priv);
+
+	dev_dbg(dev, "Using %lu/%lu (%lu%%) at %lu MHz\n",
+		stat->busy_time, stat->total_time,
+		DIV_ROUND_CLOSEST(stat->busy_time * 100, stat->total_time),
+		stat->current_frequency / USEC_PER_SEC);
+
+	return 0;
+}
+
+static int sun8i_a33_mbus_hw_init(struct device *dev,
+				  struct sun8i_a33_mbus *priv,
+				  unsigned long ddr_freq)
+{
+	u32 i, mbus_cr, mbus_freq_mhz;
+
+	/* Choose tREFI and tRFC to match the configured DRAM type. */
+	mbus_cr = readl_relaxed(priv->reg_mbus + MBUS_CR);
+	switch (MBUS_CR_GET_DRAM_TYPE(mbus_cr)) {
+	case MBUS_CR_DRAM_TYPE_DDR2:
+	case MBUS_CR_DRAM_TYPE_DDR3:
+	case MBUS_CR_DRAM_TYPE_DDR4:
+		priv->tREFI_ns = 7800;
+		priv->tRFC_ns = 350;
+		break;
+	case MBUS_CR_DRAM_TYPE_LPDDR2:
+	case MBUS_CR_DRAM_TYPE_LPDDR3:
+		priv->tREFI_ns = 3900;
+		priv->tRFC_ns = 210;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Save ODTMAP so it can be restored when raising the frequency. */
+	priv->odtmap = readl_relaxed(priv->reg_dram + DRAM_ODTMAP);
+
+	/* Compute the DRAM data bus width by counting enabled DATx8 blocks. */
+	for (i = 0; i < DRAM_DX_MAX; ++i) {
+		void __iomem *reg = priv->reg_dram + DRAM_DXnGCR0(i);
+
+		if (!(readl_relaxed(reg) & DRAM_DXnGCR0_DXEN))
+			break;
+	}
+	priv->data_width = i;
+
+	dev_dbg(dev, "Detected %u-bit %sDDRx with%s ODT\n",
+		priv->data_width * 8,
+		MBUS_CR_GET_DRAM_TYPE(mbus_cr) > 4 ? "LP" : "",
+		priv->odtmap ? "" : "out");
+
+	/* Program MBUS_TMR such that the PMU period unit is microseconds. */
+	mbus_freq_mhz = clk_get_rate(priv->clk_mbus) / USEC_PER_SEC;
+	writel_relaxed(MBUS_TMR_PERIOD(mbus_freq_mhz),
+		       priv->reg_mbus + MBUS_TMR);
+
+	/* "Master Ready Mask Register" bits must be set or MDFS will block. */
+	writel_relaxed(0xffffffff, priv->reg_mbus + MBUS_MDFSMRMR);
+
+	sun8i_a33_mbus_restart_pmu_counters(priv);
+	sun8i_a33_mbus_update_nominal_bw(priv, ddr_freq / USEC_PER_SEC);
+
+	return 0;
+}
+
+static int __maybe_unused sun8i_a33_mbus_suspend(struct device *dev)
+{
+	struct sun8i_a33_mbus *priv = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(priv->clk_bus);
+
+	return 0;
+}
+
+static int __maybe_unused sun8i_a33_mbus_resume(struct device *dev)
+{
+	struct sun8i_a33_mbus *priv = dev_get_drvdata(dev);
+
+	return clk_prepare_enable(priv->clk_bus);
+}
+
+static int sun8i_a33_mbus_probe(struct platform_device *pdev)
+{
+	const struct sun8i_a33_mbus_variant *variant;
+	struct device *dev = &pdev->dev;
+	struct sun8i_a33_mbus *priv;
+	unsigned long base_freq;
+	unsigned int max_state;
+	const char *err;
+	int i, ret;
+
+	variant = device_get_match_data(dev);
+	if (!variant)
+		return -EINVAL;
+
+	max_state = variant->max_dram_divider - variant->min_dram_divider + 1;
+
+	priv = devm_kzalloc(dev, struct_size(priv, freq_table, max_state), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+
+	priv->variant = variant;
+
+	priv->reg_dram = devm_platform_ioremap_resource_byname(pdev, "dram");
+	if (IS_ERR(priv->reg_dram))
+		return PTR_ERR(priv->reg_dram);
+
+	priv->reg_mbus = devm_platform_ioremap_resource_byname(pdev, "mbus");
+	if (IS_ERR(priv->reg_mbus))
+		return PTR_ERR(priv->reg_mbus);
+
+	priv->clk_bus = devm_clk_get(dev, "bus");
+	if (IS_ERR(priv->clk_bus))
+		return dev_err_probe(dev, PTR_ERR(priv->clk_bus),
+				     "failed to get bus clock\n");
+
+	priv->clk_dram = devm_clk_get(dev, "dram");
+	if (IS_ERR(priv->clk_dram))
+		return dev_err_probe(dev, PTR_ERR(priv->clk_dram),
+				     "failed to get dram clock\n");
+
+	priv->clk_mbus = devm_clk_get(dev, "mbus");
+	if (IS_ERR(priv->clk_mbus))
+		return dev_err_probe(dev, PTR_ERR(priv->clk_mbus),
+				     "failed to get mbus clock\n");
+
+	ret = clk_prepare_enable(priv->clk_bus);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to enable bus clock\n");
+
+	/* Lock the DRAM clock rate to keep priv->nominal_bw in sync. */
+	ret = clk_rate_exclusive_get(priv->clk_dram);
+	if (ret) {
+		err = "failed to lock dram clock rate\n";
+		goto err_disable_bus;
+	}
+
+	/* Lock the MBUS clock rate to keep MBUS_TMR_PERIOD in sync. */
+	ret = clk_rate_exclusive_get(priv->clk_mbus);
+	if (ret) {
+		err = "failed to lock mbus clock rate\n";
+		goto err_unlock_dram;
+	}
+
+	priv->gov_data.upthreshold	= 10;
+	priv->gov_data.downdifferential	=  5;
+
+	priv->profile.initial_freq	= clk_get_rate(priv->clk_dram);
+	priv->profile.polling_ms	= 1000;
+	priv->profile.target		= sun8i_a33_mbus_set_dram_target;
+	priv->profile.get_dev_status	= sun8i_a33_mbus_get_dram_status;
+	priv->profile.freq_table	= priv->freq_table;
+	priv->profile.max_state		= max_state;
+
+	ret = devm_pm_opp_set_clkname(dev, "dram");
+	if (ret) {
+		err = "failed to add OPP table\n";
+		goto err_unlock_mbus;
+	}
+
+	base_freq = clk_get_rate(clk_get_parent(priv->clk_dram));
+	for (i = 0; i < max_state; ++i) {
+		unsigned int div = variant->max_dram_divider - i;
+
+		priv->freq_table[i] = base_freq / div;
+
+		ret = dev_pm_opp_add(dev, priv->freq_table[i], 0);
+		if (ret) {
+			err = "failed to add OPPs\n";
+			goto err_remove_opps;
+		}
+	}
+
+	ret = sun8i_a33_mbus_hw_init(dev, priv, priv->profile.initial_freq);
+	if (ret) {
+		err = "failed to init hardware\n";
+		goto err_remove_opps;
+	}
+
+	priv->devfreq_dram = devfreq_add_device(dev, &priv->profile,
+						DEVFREQ_GOV_SIMPLE_ONDEMAND,
+						&priv->gov_data);
+	if (IS_ERR(priv->devfreq_dram)) {
+		ret = PTR_ERR(priv->devfreq_dram);
+		err = "failed to add devfreq device\n";
+		goto err_remove_opps;
+	}
+
+	/*
+	 * This must be set manually after registering the devfreq device,
+	 * because there is no way to select a dynamic OPP as the suspend OPP.
+	 */
+	priv->devfreq_dram->suspend_freq = priv->freq_table[0];
+
+	return 0;
+
+err_remove_opps:
+	dev_pm_opp_remove_all_dynamic(dev);
+err_unlock_mbus:
+	clk_rate_exclusive_put(priv->clk_mbus);
+err_unlock_dram:
+	clk_rate_exclusive_put(priv->clk_dram);
+err_disable_bus:
+	clk_disable_unprepare(priv->clk_bus);
+
+	return dev_err_probe(dev, ret, err);
+}
+
+static int sun8i_a33_mbus_remove(struct platform_device *pdev)
+{
+	struct sun8i_a33_mbus *priv = platform_get_drvdata(pdev);
+	unsigned long initial_freq = priv->profile.initial_freq;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	devfreq_remove_device(priv->devfreq_dram);
+
+	ret = sun8i_a33_mbus_set_dram_freq(priv, initial_freq);
+	if (ret)
+		dev_warn(dev, "failed to restore DRAM frequency: %d\n", ret);
+
+	dev_pm_opp_remove_all_dynamic(dev);
+	clk_rate_exclusive_put(priv->clk_mbus);
+	clk_rate_exclusive_put(priv->clk_dram);
+	clk_disable_unprepare(priv->clk_bus);
+
+	return 0;
+}
+
+static const struct sun8i_a33_mbus_variant sun50i_a64_mbus = {
+	.min_dram_divider	= 1,
+	.max_dram_divider	= 4,
+	.odt_freq_mhz		= 400,
+};
+
+static const struct of_device_id sun8i_a33_mbus_of_match[] = {
+	{ .compatible = "allwinner,sun50i-a64-mbus", .data = &sun50i_a64_mbus },
+	{ .compatible = "allwinner,sun50i-h5-mbus", .data = &sun50i_a64_mbus },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sun8i_a33_mbus_of_match);
+
+static SIMPLE_DEV_PM_OPS(sun8i_a33_mbus_pm_ops,
+			 sun8i_a33_mbus_suspend, sun8i_a33_mbus_resume);
+
+static struct platform_driver sun8i_a33_mbus_driver = {
+	.probe	= sun8i_a33_mbus_probe,
+	.remove	= sun8i_a33_mbus_remove,
+	.driver	= {
+		.name		= "sun8i-a33-mbus",
+		.of_match_table	= sun8i_a33_mbus_of_match,
+		.pm		= pm_ptr(&sun8i_a33_mbus_pm_ops),
+	},
+};
+module_platform_driver(sun8i_a33_mbus_driver);
+
+MODULE_AUTHOR("Samuel Holland <samuel@sholland.org>");
+MODULE_DESCRIPTION("Allwinner sun8i/sun50i MBUS DEVFREQ Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.32.0

