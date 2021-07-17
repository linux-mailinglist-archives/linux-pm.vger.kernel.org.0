Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF013CC561
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jul 2021 20:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbhGQS0H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Jul 2021 14:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbhGQS0D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Jul 2021 14:26:03 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909BEC061764;
        Sat, 17 Jul 2021 11:23:06 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y42so21617123lfa.3;
        Sat, 17 Jul 2021 11:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y3OZLq2rPlmjb4eTZVA72YHD2U1D5fyvvBeZCksHTBM=;
        b=AFYE4MWu2LD8yqc/DOWsG5KH4C+QlMgmvCZKJE7qo7zIn4gCC0RSFqAwzH5TuWLC6l
         liogtvCcXGBzAscd77plfr2kGlv/oyNJ7wFMbfy3cqx+QyNDA0BeKWGjAHIYNZDGNiTB
         aDV1fIJosWdr+IRZQi4TnCquXhJvVSsqpHDrgYzvoLZcZAUqes4yxcZZSYqVWbLX5Mj4
         7y1+VNk6pr5NJOGdmmHpgZPObydw/2IkUAmqL2ddxvY1toUgV9C8oecGUiirXxvHEDqL
         yKO+3iRRD5Ag8vRWr8TYek7x7uE0UduhrtEP5/FAqn3jdAfoN4CEssxqDCjSLbs2BEW3
         Lnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y3OZLq2rPlmjb4eTZVA72YHD2U1D5fyvvBeZCksHTBM=;
        b=UXx+BiZTwjOdpeQ8lkNRO1XWkt/yw4OOXQV7YRmVuxtZlENRQlixs9+HfVdynR+/Ex
         BH6zDRa740biqx1T7t5c3spqxyyby5JBNtA19y1x/Z86R4qXGgGyJxwAiYlH5iF58G34
         U5LffoqWJ2tJRD8ILRb6ps3A9HL+9WQWxfVBX79kbz0zuYhZT1m1K34mbZfCRboNAt2M
         TCtuyq2FWYonIhifezhc2On0cXSdq9OfI7o1toCwjjk7XluBqyZEOlU66HBY6lZatam2
         8Rmd6CayNYDknsLaH57m37g2YMhYk+qd3GzH8xFep1SqMYOYqI+72vfTDdIUFubsoZMO
         ojKg==
X-Gm-Message-State: AOAM533CVmAcHhtlBId3K+EAstnVp7GD9p7Spk6LNgwC6/OOm9dQgJW4
        OeNNBwfgfQpAhL56uICZTwY=
X-Google-Smtp-Source: ABdhPJyJ9ak0rHyiDZg1Cvjlt9fd1TvUWYBIhMERuPp4gaGpYQlr8Gt6ETrpR4OLlmt6PwDjEbj9Eg==
X-Received: by 2002:a05:6512:3c93:: with SMTP id h19mr12297571lfv.512.1626546184878;
        Sat, 17 Jul 2021 11:23:04 -0700 (PDT)
Received: from localhost.localdomain (46-138-17-250.dynamic.spd-mgts.ru. [46.138.17.250])
        by smtp.gmail.com with ESMTPSA id z20sm1409532ljk.123.2021.07.17.11.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 11:23:04 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v5 04/12] usb: phy: tegra: Support OTG mode programming
Date:   Sat, 17 Jul 2021 21:21:26 +0300
Message-Id: <20210717182134.30262-5-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210717182134.30262-1-digetx@gmail.com>
References: <20210717182134.30262-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Support programming USB PHY into OTG mode.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/phy/phy-tegra-usb.c   | 197 +++++++++++++++++++++++++++++-
 include/linux/usb/tegra_usb_phy.h |   5 +
 2 files changed, 197 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index c0f432d509aa..d6197a462749 100644
--- a/drivers/usb/phy/phy-tegra-usb.c
+++ b/drivers/usb/phy/phy-tegra-usb.c
@@ -63,6 +63,10 @@
 #define   A_VBUS_VLD_WAKEUP_EN			BIT(30)
 
 #define USB_PHY_VBUS_WAKEUP_ID			0x408
+#define   ID_INT_EN				BIT(0)
+#define   ID_CHG_DET				BIT(1)
+#define   VBUS_WAKEUP_INT_EN			BIT(8)
+#define   VBUS_WAKEUP_CHG_DET			BIT(9)
 #define   VBUS_WAKEUP_STS			BIT(10)
 #define   VBUS_WAKEUP_WAKEUP_EN			BIT(30)
 
@@ -158,6 +162,10 @@
 #define   USB_USBMODE_HOST			(3 << 0)
 #define   USB_USBMODE_DEVICE			(2 << 0)
 
+#define PMC_USB_AO				0xf0
+#define   VBUS_WAKEUP_PD_P0			BIT(2)
+#define   ID_PD_P0				BIT(3)
+
 static DEFINE_SPINLOCK(utmip_pad_lock);
 static unsigned int utmip_pad_count;
 
@@ -533,13 +541,14 @@ static int utmi_phy_power_on(struct tegra_usb_phy *phy)
 	val &= ~USB_WAKE_ON_RESUME_EN;
 	writel_relaxed(val, base + USB_SUSP_CTRL);
 
-	if (phy->mode == USB_DR_MODE_PERIPHERAL) {
+	if (phy->mode != USB_DR_MODE_HOST) {
 		val = readl_relaxed(base + USB_SUSP_CTRL);
 		val &= ~(USB_WAKE_ON_CNNT_EN_DEV | USB_WAKE_ON_DISCON_EN_DEV);
 		writel_relaxed(val, base + USB_SUSP_CTRL);
 
 		val = readl_relaxed(base + USB_PHY_VBUS_WAKEUP_ID);
 		val &= ~VBUS_WAKEUP_WAKEUP_EN;
+		val &= ~(ID_CHG_DET | VBUS_WAKEUP_CHG_DET);
 		writel_relaxed(val, base + USB_PHY_VBUS_WAKEUP_ID);
 
 		val = readl_relaxed(base + USB_PHY_VBUS_SENSORS);
@@ -687,9 +696,10 @@ static int utmi_phy_power_off(struct tegra_usb_phy *phy)
 		 * Ask VBUS sensor to generate wake event once cable is
 		 * connected.
 		 */
-		if (phy->mode == USB_DR_MODE_PERIPHERAL) {
+		if (phy->mode != USB_DR_MODE_HOST) {
 			val = readl_relaxed(base + USB_PHY_VBUS_WAKEUP_ID);
 			val |= VBUS_WAKEUP_WAKEUP_EN;
+			val &= ~(ID_CHG_DET | VBUS_WAKEUP_CHG_DET);
 			writel_relaxed(val, base + USB_PHY_VBUS_WAKEUP_ID);
 
 			val = readl_relaxed(base + USB_PHY_VBUS_SENSORS);
@@ -904,26 +914,146 @@ static void tegra_usb_phy_shutdown(struct usb_phy *u_phy)
 	phy->freq = NULL;
 }
 
+static irqreturn_t tegra_usb_phy_isr(int irq, void *data)
+{
+	u32 val, int_mask = ID_CHG_DET | VBUS_WAKEUP_CHG_DET;
+	struct tegra_usb_phy *phy = data;
+	void __iomem *base = phy->regs;
+
+	/*
+	 * The PHY interrupt also wakes the USB controller driver since
+	 * interrupt is shared. We don't do anything in the PHY driver,
+	 * so just clear the interrupt.
+	 */
+	val = readl_relaxed(base + USB_PHY_VBUS_WAKEUP_ID);
+	writel_relaxed(val, base + USB_PHY_VBUS_WAKEUP_ID);
+
+	return val & int_mask ? IRQ_HANDLED : IRQ_NONE;
+}
+
 static int tegra_usb_phy_set_wakeup(struct usb_phy *u_phy, bool enable)
 {
 	struct tegra_usb_phy *phy = to_tegra_usb_phy(u_phy);
+	void __iomem *base = phy->regs;
+	int ret = 0;
+	u32 val;
+
+	if (phy->wakeup_enabled && phy->mode != USB_DR_MODE_HOST &&
+	    phy->irq > 0) {
+		disable_irq(phy->irq);
+
+		val = readl_relaxed(base + USB_PHY_VBUS_WAKEUP_ID);
+		val &= ~(ID_INT_EN | VBUS_WAKEUP_INT_EN);
+		writel_relaxed(val, base + USB_PHY_VBUS_WAKEUP_ID);
+
+		enable_irq(phy->irq);
+
+		free_irq(phy->irq, phy);
+
+		phy->wakeup_enabled = false;
+	}
+
+	if (enable && phy->mode != USB_DR_MODE_HOST && phy->irq > 0) {
+		ret = request_irq(phy->irq, tegra_usb_phy_isr, IRQF_SHARED,
+				  dev_name(phy->u_phy.dev), phy);
+		if (!ret) {
+			disable_irq(phy->irq);
+
+			/*
+			 * USB clock will be resumed once wake event will be
+			 * generated.  The ID-change event requires to have
+			 * interrupts enabled, otherwise it won't be generated.
+			 */
+			val = readl_relaxed(base + USB_PHY_VBUS_WAKEUP_ID);
+			val |= ID_INT_EN | VBUS_WAKEUP_INT_EN;
+			writel_relaxed(val, base + USB_PHY_VBUS_WAKEUP_ID);
+
+			enable_irq(phy->irq);
+		} else {
+			dev_err(phy->u_phy.dev,
+				"Failed to request interrupt: %d", ret);
+			enable = false;
+		}
+	}
 
 	phy->wakeup_enabled = enable;
 
-	return 0;
+	return ret;
 }
 
 static int tegra_usb_phy_set_suspend(struct usb_phy *u_phy, int suspend)
 {
 	struct tegra_usb_phy *phy = to_tegra_usb_phy(u_phy);
+	int ret;
 
 	if (WARN_ON(!phy->freq))
 		return -EINVAL;
 
+	/*
+	 * PHY is sharing IRQ with the CI driver, hence here we either
+	 * disable interrupt for both PHY and CI or for CI only.  The
+	 * interrupt needs to be disabled while hardware is reprogrammed
+	 * because interrupt touches the programmed registers, and thus,
+	 * there could be a race condition.
+	 */
+	if (phy->irq > 0)
+		disable_irq(phy->irq);
+
 	if (suspend)
-		return tegra_usb_phy_power_off(phy);
+		ret = tegra_usb_phy_power_off(phy);
 	else
-		return tegra_usb_phy_power_on(phy);
+		ret = tegra_usb_phy_power_on(phy);
+
+	if (phy->irq > 0)
+		enable_irq(phy->irq);
+
+	return ret;
+}
+
+static int tegra_usb_phy_configure_pmc(struct tegra_usb_phy *phy)
+{
+	int err, val = 0;
+
+	/* older device-trees don't have PMC regmap */
+	if (!phy->pmc_regmap)
+		return 0;
+
+	/*
+	 * Tegra20 has a different layout of PMC USB register bits and AO is
+	 * enabled by default after system reset on Tegra20, so assume nothing
+	 * to do on Tegra20.
+	 */
+	if (!phy->soc_config->requires_pmc_ao_power_up)
+		return 0;
+
+	/* enable VBUS wake-up detector */
+	if (phy->mode != USB_DR_MODE_HOST)
+		val |= VBUS_WAKEUP_PD_P0 << phy->instance * 4;
+
+	/* enable ID-pin ACC detector for OTG mode switching */
+	if (phy->mode == USB_DR_MODE_OTG)
+		val |= ID_PD_P0 << phy->instance * 4;
+
+	/* disable detectors to reset them */
+	err = regmap_set_bits(phy->pmc_regmap, PMC_USB_AO, val);
+	if (err) {
+		dev_err(phy->u_phy.dev, "Failed to disable PMC AO: %d\n", err);
+		return err;
+	}
+
+	usleep_range(10, 100);
+
+	/* enable detectors */
+	err = regmap_clear_bits(phy->pmc_regmap, PMC_USB_AO, val);
+	if (err) {
+		dev_err(phy->u_phy.dev, "Failed to enable PMC AO: %d\n", err);
+		return err;
+	}
+
+	/* detectors starts to work after 10ms */
+	usleep_range(10000, 15000);
+
+	return 0;
 }
 
 static int tegra_usb_phy_init(struct usb_phy *u_phy)
@@ -967,6 +1097,10 @@ static int tegra_usb_phy_init(struct usb_phy *u_phy)
 			goto disable_vbus;
 	}
 
+	err = tegra_usb_phy_configure_pmc(phy);
+	if (err)
+		goto close_phy;
+
 	err = tegra_usb_phy_power_on(phy);
 	if (err)
 		goto close_phy;
@@ -1135,11 +1269,56 @@ static int utmi_phy_probe(struct tegra_usb_phy *tegra_phy,
 	return 0;
 }
 
+static void tegra_usb_phy_put_pmc_device(void *dev)
+{
+	put_device(dev);
+}
+
+static int tegra_usb_phy_parse_pmc(struct device *dev,
+				   struct tegra_usb_phy *phy)
+{
+	struct platform_device *pmc_pdev;
+	struct of_phandle_args args;
+	int err;
+
+	err = of_parse_phandle_with_fixed_args(dev->of_node, "nvidia,pmc",
+					       1, 0, &args);
+	if (err) {
+		if (err != -ENOENT)
+			return err;
+
+		dev_warn_once(dev, "nvidia,pmc is missing, please update your device-tree\n");
+		return 0;
+	}
+
+	pmc_pdev = of_find_device_by_node(args.np);
+	of_node_put(args.np);
+	if (!pmc_pdev)
+		return -ENODEV;
+
+	err = devm_add_action_or_reset(dev, tegra_usb_phy_put_pmc_device,
+				       &pmc_pdev->dev);
+	if (err)
+		return err;
+
+	if (!platform_get_drvdata(pmc_pdev))
+		return -EPROBE_DEFER;
+
+	phy->pmc_regmap = dev_get_regmap(&pmc_pdev->dev, "usb_sleepwalk");
+	if (!phy->pmc_regmap)
+		return -EINVAL;
+
+	phy->instance = args.args[0];
+
+	return 0;
+}
+
 static const struct tegra_phy_soc_config tegra20_soc_config = {
 	.utmi_pll_config_in_car_module = false,
 	.has_hostpc = false,
 	.requires_usbmode_setup = false,
 	.requires_extra_tuning_parameters = false,
+	.requires_pmc_ao_power_up = false,
 };
 
 static const struct tegra_phy_soc_config tegra30_soc_config = {
@@ -1147,6 +1326,7 @@ static const struct tegra_phy_soc_config tegra30_soc_config = {
 	.has_hostpc = true,
 	.requires_usbmode_setup = true,
 	.requires_extra_tuning_parameters = true,
+	.requires_pmc_ao_power_up = true,
 };
 
 static const struct of_device_id tegra_usb_phy_id_table[] = {
@@ -1172,6 +1352,7 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	tegra_phy->soc_config = of_device_get_match_data(&pdev->dev);
+	tegra_phy->irq = platform_get_irq_optional(pdev, 0);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -1215,6 +1396,12 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	err = tegra_usb_phy_parse_pmc(&pdev->dev, tegra_phy);
+	if (err) {
+		dev_err_probe(&pdev->dev, err, "Failed to get PMC regmap\n");
+		return err;
+	}
+
 	phy_type = of_usb_get_phy_mode(np);
 	switch (phy_type) {
 	case USBPHY_INTERFACE_MODE_UTMI:
diff --git a/include/linux/usb/tegra_usb_phy.h b/include/linux/usb/tegra_usb_phy.h
index fd1c9f6a4e37..d3e65eb9e16f 100644
--- a/include/linux/usb/tegra_usb_phy.h
+++ b/include/linux/usb/tegra_usb_phy.h
@@ -18,6 +18,7 @@
 
 #include <linux/clk.h>
 #include <linux/gpio.h>
+#include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/usb/otg.h>
 
@@ -30,6 +31,7 @@
  *      enter host mode
  * requires_extra_tuning_parameters: true if xcvr_hsslew, hssquelch_level
  *      and hsdiscon_level should be set for adequate signal quality
+ * requires_pmc_ao_power_up: true if USB AO is powered down by default
  */
 
 struct tegra_phy_soc_config {
@@ -37,6 +39,7 @@ struct tegra_phy_soc_config {
 	bool has_hostpc;
 	bool requires_usbmode_setup;
 	bool requires_extra_tuning_parameters;
+	bool requires_pmc_ao_power_up;
 };
 
 struct tegra_utmip_config {
@@ -62,6 +65,7 @@ enum tegra_usb_phy_port_speed {
 struct tegra_xtal_freq;
 
 struct tegra_usb_phy {
+	int irq;
 	int instance;
 	const struct tegra_xtal_freq *freq;
 	void __iomem *regs;
@@ -70,6 +74,7 @@ struct tegra_usb_phy {
 	struct clk *pll_u;
 	struct clk *pad_clk;
 	struct regulator *vbus;
+	struct regmap *pmc_regmap;
 	enum usb_dr_mode mode;
 	void *config;
 	const struct tegra_phy_soc_config *soc_config;
-- 
2.32.0

