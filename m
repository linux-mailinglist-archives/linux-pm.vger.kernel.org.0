Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2BBA7E80
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2019 10:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbfIDIyI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Sep 2019 04:54:08 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.168]:17514 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728951AbfIDIyB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Sep 2019 04:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1567587237;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=dZKIb+kqBtMMkRmH1et2CqnuKTB7ip16x82qjTFoRWk=;
        b=mpd3B8nsjLKPWcsckwtCkQYXJ6sTguuAg4K9oQ48jv60pbmyyYWrd8pI4z6fqhMFQX
        oKjbQv0/YlxoS24Illslbuaio7RRdGJdW1u5Q0Qt4me6dA1UN4S+P25MTv8tmGoVov8x
        4jXLDOtm/QzSFlMJihihwXv+jjWNVP9r6NpTkf4QlIgd479isFXKVz/9QcjTpnGgn6TG
        hSXNng01Cm5MwrJ9DZmWXt0Q38sx+2Txcmop3PCeBBb+ZQnkGI3sfWcmbIaiTl/3x0FM
        i6957EbD1n6VH5EyAPHsHcV9FS+Q7PD3SzqtI/RhVleyC8VgLmmF5FKPo43CCN6RzErf
        hu3w==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1mfYzBGHXH6GK4zSwk="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id u036f9v848rgcLe
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 4 Sep 2019 10:53:42 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        =?UTF-8?q?Andr=C3=A9=20Roth?= <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [RFC v2 1/3] cpufreq: ti-cpufreq: add support for omap34xx and omap36xx
Date:   Wed,  4 Sep 2019 10:53:39 +0200
Message-Id: <a889b10386bebfbfd6cdb5491367235290d53247.1567587220.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1567587220.git.hns@goldelico.com>
References: <cover.1567587220.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds code and tables to read the silicon revision and
eFuse (speed binned / 720 MHz grade) bits for selecting
opp-v2 table entries.

Since these bits are not always part of the syscon register
range (like for am33xx, am43, dra7), we add code to directly
read the register values using ioremap() if syscon access fails.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/cpufreq/ti-cpufreq.c | 87 +++++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 2ad1ae17932d..b3de3162ea73 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -31,6 +31,11 @@
 #define DRA7_EFUSE_OD_MPU_OPP			BIT(1)
 #define DRA7_EFUSE_HIGH_MPU_OPP			BIT(2)
 
+#define OMAP3_CONTROL_DEVICE_STATUS		0x4800244C
+#define OMAP3_CONTROL_IDCODE			0x4830A204
+#define OMAP34xx_ProdID_SKUID			0x4830A20C
+#define OMAP3_SYSCON_BASE	(0x48000000 + 0x2000 + 0x270)
+
 #define VERSION_COUNT				2
 
 struct ti_cpufreq_data;
@@ -84,6 +89,13 @@ static unsigned long dra7_efuse_xlate(struct ti_cpufreq_data *opp_data,
 	return calculated_efuse;
 }
 
+static unsigned long omap3_efuse_xlate(struct ti_cpufreq_data *opp_data,
+				      unsigned long efuse)
+{
+	/* OPP enable bit ("Speed Binned") */
+	return BIT(efuse);
+}
+
 static struct ti_cpufreq_soc_data am3x_soc_data = {
 	.efuse_xlate = amx3_efuse_xlate,
 	.efuse_fallback = AM33XX_800M_ARM_MPU_MAX_FREQ,
@@ -111,6 +123,56 @@ static struct ti_cpufreq_soc_data dra7_soc_data = {
 	.multi_regulator = true,
 };
 
+/*
+ * OMAP35x TRM (SPRUF98K):
+ *  CONTROL_IDCODE (0x4830 A204) describes Silicon revisions.
+ *  Control OMAP Status Register 15:0 (Address 0x4800 244C)
+ *    to separate between omap3503, omap3515, omap3525, omap3530
+ *    and feature presence.
+ *    There are encodings for versions limited to 400/266MHz
+ *    but we ignore.
+ *    Not clear if this also holds for omap34xx.
+ *  some eFuse values e.g. CONTROL_FUSE_OPP1_VDD1
+ *    are stored in the SYSCON register range
+ *  Register 0x4830A20C [ProdID.SKUID] [0:3]
+ *    0x0 for normal 600/430MHz device.
+ *    0x8 for 720/520MHz device.
+ *    Not clear what omap34xx value is.
+ */
+
+static struct ti_cpufreq_soc_data omap34xx_soc_data = {
+	.efuse_xlate = omap3_efuse_xlate,
+	.efuse_offset = OMAP34xx_ProdID_SKUID - OMAP3_SYSCON_BASE,
+	.efuse_shift = 3,
+	.efuse_mask = BIT(3),
+	.rev_offset = OMAP3_CONTROL_IDCODE - OMAP3_SYSCON_BASE,
+	.multi_regulator = false,
+};
+
+/*
+ * AM/DM37x TRM (SPRUGN4M)
+ *  CONTROL_IDCODE (0x4830 A204) describes Silicon revisions.
+ *  Control Device Status Register 15:0 (Address 0x4800 244C)
+ *    to separate between am3703, am3715, dm3725, dm3730
+ *    and feature presence.
+ *   Speed Binned = Bit 9
+ *     0 800/600 MHz
+ *     1 1000/800 MHz
+ *  some eFuse values e.g. CONTROL_FUSE_OPP 1G_VDD1
+ *    are stored in the SYSCON register range.
+ *  There is no 0x4830A20C [ProdID.SKUID] register (exists but
+ *    seems to always read as 0).
+ */
+
+static struct ti_cpufreq_soc_data omap36xx_soc_data = {
+	.efuse_xlate = omap3_efuse_xlate,
+	.efuse_offset = OMAP3_CONTROL_DEVICE_STATUS - OMAP3_SYSCON_BASE,
+	.efuse_shift = 9,
+	.efuse_mask = BIT(9),
+	.rev_offset = OMAP3_CONTROL_IDCODE - OMAP3_SYSCON_BASE,
+	.multi_regulator = false,
+};
+
 /**
  * ti_cpufreq_get_efuse() - Parse and return efuse value present on SoC
  * @opp_data: pointer to ti_cpufreq_data context
@@ -127,7 +189,15 @@ static int ti_cpufreq_get_efuse(struct ti_cpufreq_data *opp_data,
 
 	ret = regmap_read(opp_data->syscon, opp_data->soc_data->efuse_offset,
 			  &efuse);
-	if (ret) {
+	if (ret == -EIO) {
+		/* not a syscon register! */
+		void __iomem *regs = ioremap(OMAP3_SYSCON_BASE +
+				opp_data->soc_data->efuse_offset, 4);
+
+		efuse = readl(regs);
+		iounmap(regs);
+		}
+	else if (ret) {
 		dev_err(dev,
 			"Failed to read the efuse value from syscon: %d\n",
 			ret);
@@ -158,7 +228,15 @@ static int ti_cpufreq_get_rev(struct ti_cpufreq_data *opp_data,
 
 	ret = regmap_read(opp_data->syscon, opp_data->soc_data->rev_offset,
 			  &revision);
-	if (ret) {
+	if (ret == -EIO) {
+		/* not a syscon register! */
+		void __iomem *regs = ioremap(OMAP3_SYSCON_BASE +
+				opp_data->soc_data->rev_offset, 4);
+
+		revision = readl(regs);
+		iounmap(regs);
+		}
+	else if (ret) {
 		dev_err(dev,
 			"Failed to read the revision number from syscon: %d\n",
 			ret);
@@ -190,6 +268,11 @@ static const struct of_device_id ti_cpufreq_of_match[] = {
 	{ .compatible = "ti,am33xx", .data = &am3x_soc_data, },
 	{ .compatible = "ti,am43", .data = &am4x_soc_data, },
 	{ .compatible = "ti,dra7", .data = &dra7_soc_data },
+	{ .compatible = "ti,omap34xx", .data = &omap34xx_soc_data, },
+	{ .compatible = "ti,omap36xx", .data = &omap36xx_soc_data, },
+	/* legacy */
+	{ .compatible = "ti,omap3430", .data = &omap34xx_soc_data, },
+	{ .compatible = "ti,omap3630", .data = &omap36xx_soc_data, },
 	{},
 };
 
-- 
2.19.1

