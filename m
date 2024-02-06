Return-Path: <linux-pm+bounces-3489-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9BA84B8AA
	for <lists+linux-pm@lfdr.de>; Tue,  6 Feb 2024 15:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4537228C48F
	for <lists+linux-pm@lfdr.de>; Tue,  6 Feb 2024 14:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861461339BD;
	Tue,  6 Feb 2024 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RBHswoEn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C46A1332BA
	for <linux-pm@vger.kernel.org>; Tue,  6 Feb 2024 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231460; cv=none; b=nLwSS5Eu4wIqkfnVcmjH5rQDal20OpS8texv1ewH3OpT8fm3OirTEIB+oiej6E7JC4ODnwdjRMXqwsJEQfkBzAAdCR4EAz5mMD6j/L67iCYDG8kFLNqdznzFuOvsOBU9J5RJ7ZMkSO3VTwox0896w9qKhu8/sajYdW9fsVafGf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231460; c=relaxed/simple;
	bh=msEfwhV3HoCipEB+GKffGUeyyj2VovDScomEYsfnrT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oos1vmNxMvwqycrGQDzPY79khyhpQozXlmWnLWzELxFa0sW4WiwZAjsF1FkXYw/iMbm44ArHGHgoaROoo02TZDEUbsQm9BfAS/Isx5j592WkBdVVoquHQo7EHb7GqXeW/OuZBqZDq0RfymLgqrqj14lg+OB/njKU8u3INaGLPw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RBHswoEn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40ff940b456so753005e9.2
        for <linux-pm@vger.kernel.org>; Tue, 06 Feb 2024 06:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707231457; x=1707836257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdH/MMRBTUfqayVAnmhejns1JtGutpHRzA8LTWcgILQ=;
        b=RBHswoEnMHhmIeslhpgKCttm9e68yGPHrvR4glYKLQtK1hb0Nbk6ROfFLYGBgujErt
         CcSo+VwSjCwmDmT1PpYTHuHGsQWG2cPBhUQd4pUJDV/evycY042p7L5v02UIEs3xb2Sw
         0RFXQAFXUCPPVwAeZQ5ScfkEqUiGRPLfz3XeILFx3td8omaX9JPT1IJPAdWV8GX8BiDA
         GOSfOahyxVxdLMTlgcrZl7QCm2m5MEJDTSWYuyuPa+WdUruS8auvlq0iZ2yhi416Uo3f
         gEDV79SRIa4Kf8hr7xTkrJ12THycG2eOaOfjsZ2GV3XU1M9/7ackip27yuRnKuMBX7J5
         18zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707231457; x=1707836257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XdH/MMRBTUfqayVAnmhejns1JtGutpHRzA8LTWcgILQ=;
        b=ECu41QtoTdV4huXIjs5NnYA8N0bzGhNWcIm0UPJmLog5v0MQj34g/IBXf3ReV1l4kU
         qZmRN8ijzAKKkA4BMXmOXcw5sn4JpSLA1II+k9yPrWslYRlJc/YO08MAp0vubnrXP+A/
         SsKEGONrk6qIw76xVnK5yHVjO4GOXtGFFGmjkQv+a0M68GXSDXAha54fBJyBM/b6hekI
         BBhWHfYiG4PjvIzkfY22dY9J+uC2o7i8W6R7PRJNimn6S60HYaq0JkqWG1IAgWAWrwyL
         I5lvf7Vz1I8CIhnTskZUxCXvqbbYlswxL1tkqKH7nSjKytefjxfkw28vE1aY8bkGfTQm
         OVoA==
X-Gm-Message-State: AOJu0Yx6nWg9/qbcNqrOrmNlPG18TPNLfYk21Rp1I8FPQiGbyVZw20vV
	GWzFg2Pc4w1ym437/QzEA8gotrK69uU5ji89+7b4FmkPRRCATrOyQn3JELCz3dc=
X-Google-Smtp-Source: AGHT+IEANI1IHeJsecUK707xmJF7E4tpQM8iIUO3QCbVIvB3uiEIfJf5lxl8quWa7bhmLD1KFJ0Gpg==
X-Received: by 2002:a05:600c:46ce:b0:40f:f4e0:c2c6 with SMTP id q14-20020a05600c46ce00b0040ff4e0c2c6mr402014wmo.12.1707231456795;
        Tue, 06 Feb 2024 06:57:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVtBTsv+GjvgKmDiMh00jYW5nzyq5ivozfUkLVr71EUPRNMJwVsYPPrGe4+GmTAMNtbTLLLgzfqETgNFMq4IlEupzzva2xnI3fo1Ulg14Xzn+dPTOHlxLjJEPhj0LcA83m28CFlabDX47m+DM6TiEZAEnwN4B6OPHDwR3tvbffao96CM648BE0gj9C+7JKzTTpCGpPz9523uYe42JQXyLl0q/CGTgkQupU3E2Gikxz78F7d8FsHYNvFvJ/Ob+ahn36iLomPVR1aG3ovKaca1Ayeal7LJbGJ3uo+s5bNr6xD18Z0s68SzbdcpCdX0cs3kTQLggIKeVC6Eu+17BQtZT4UNy4LUaO12FJ3n8cdlc+A/X52vPZ/cGGIx2nZcjywV00iCJZtaQRHY2KWeqLP1eLDq32bEjZeoVeUDxJE0vubBZ1XSv+eJ3yFH3vvikF4tuG2Vgyc4fVMueTg7N2XqrD07MU96qbmcEtc
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id l14-20020a05600c4f0e00b0040fc56712e8sm2257896wmq.17.2024.02.06.06.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 06:57:36 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Andrew Davis <afd@ti.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 2/3] cpufreq: ti-cpufreq: Support nvmem for chip version
Date: Tue,  6 Feb 2024 15:57:20 +0100
Message-ID: <20240206145721.2418893-3-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206145721.2418893-1-msp@baylibre.com>
References: <20240206145721.2418893-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support using nvmem-cells 'chipvariant' and 'chipspeed' instead of
syscon. This makes it more flexible and moves more configuration into
the devicetree.

If nvmem-cells are present, probing will fail if the configuration of
these cells is broken. If nvmem-cells is not present syscon will be
used.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/cpufreq/ti-cpufreq.c | 105 ++++++++++++++++++++++-------------
 1 file changed, 66 insertions(+), 39 deletions(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 46c41e2ca727..3ee72b1309f0 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -10,6 +10,7 @@
 #include <linux/io.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -65,6 +66,7 @@ struct ti_cpufreq_soc_data {
 
 struct ti_cpufreq_data {
 	struct device *cpu_dev;
+	struct device *dev;
 	struct device_node *opp_node;
 	struct regmap *syscon;
 	const struct ti_cpufreq_soc_data *soc_data;
@@ -244,31 +246,40 @@ static struct ti_cpufreq_soc_data am625_soc_data = {
 static int ti_cpufreq_get_efuse(struct ti_cpufreq_data *opp_data,
 				u32 *efuse_value)
 {
+	struct device_node *np = opp_data->opp_node;
 	struct device *dev = opp_data->cpu_dev;
 	u32 efuse;
 	int ret;
 
-	ret = regmap_read(opp_data->syscon, opp_data->soc_data->efuse_offset,
-			  &efuse);
-	if (ret == -EIO) {
-		/* not a syscon register! */
-		void __iomem *regs = ioremap(OMAP3_SYSCON_BASE +
-				opp_data->soc_data->efuse_offset, 4);
-
-		if (!regs)
-			return -ENOMEM;
-		efuse = readl(regs);
-		iounmap(regs);
+	ret = nvmem_cell_read_u32(opp_data->dev, "chipspeed", &efuse);
+	if (ret && (ret != -ENOENT || !opp_data->syscon))
+		return dev_err_probe(dev, ret,
+				     "Failed to read nvmem cell 'chipspeed': %pe",
+				     ERR_PTR(ret));
+
+	if (ret) {
+		ret = regmap_read(opp_data->syscon, opp_data->soc_data->efuse_offset,
+				  &efuse);
+		if (ret == -EIO) {
+			/* not a syscon register! */
+			void __iomem *regs = ioremap(OMAP3_SYSCON_BASE +
+					opp_data->soc_data->efuse_offset, 4);
+
+			if (!regs)
+				return -ENOMEM;
+			efuse = readl(regs);
+			iounmap(regs);
+			}
+		else if (ret) {
+			dev_err(dev,
+				"Failed to read the efuse value from syscon: %d\n",
+				ret);
+			return ret;
 		}
-	else if (ret) {
-		dev_err(dev,
-			"Failed to read the efuse value from syscon: %d\n",
-			ret);
-		return ret;
-	}
 
-	efuse = (efuse & opp_data->soc_data->efuse_mask);
-	efuse >>= opp_data->soc_data->efuse_shift;
+		efuse = (efuse & opp_data->soc_data->efuse_mask);
+		efuse >>= opp_data->soc_data->efuse_shift;
+	}
 
 	*efuse_value = opp_data->soc_data->efuse_xlate(opp_data, efuse);
 
@@ -285,30 +296,41 @@ static int ti_cpufreq_get_efuse(struct ti_cpufreq_data *opp_data,
 static int ti_cpufreq_get_rev(struct ti_cpufreq_data *opp_data,
 			      u32 *revision_value)
 {
+	struct device_node *np = opp_data->opp_node;
 	struct device *dev = opp_data->cpu_dev;
 	u32 revision;
 	int ret;
 
-	ret = regmap_read(opp_data->syscon, opp_data->soc_data->rev_offset,
-			  &revision);
-	if (ret == -EIO) {
-		/* not a syscon register! */
-		void __iomem *regs = ioremap(OMAP3_SYSCON_BASE +
-				opp_data->soc_data->rev_offset, 4);
-
-		if (!regs)
-			return -ENOMEM;
-		revision = readl(regs);
-		iounmap(regs);
+	ret = nvmem_cell_read_u32(opp_data->dev, "chipvariant", &revision);
+	if (ret && (ret != -ENOENT || !opp_data->syscon))
+		return dev_err_probe(dev, ret,
+				     "Failed to read nvmem cell 'chipvariant': %pe",
+				     ERR_PTR(ret));
+
+	if (ret) {
+		ret = regmap_read(opp_data->syscon, opp_data->soc_data->rev_offset,
+				  &revision);
+		if (ret == -EIO) {
+			/* not a syscon register! */
+			void __iomem *regs = ioremap(OMAP3_SYSCON_BASE +
+					opp_data->soc_data->rev_offset, 4);
+
+			if (!regs)
+				return -ENOMEM;
+			revision = readl(regs);
+			iounmap(regs);
+			}
+		else if (ret) {
+			dev_err(dev,
+				"Failed to read the revision number from syscon: %d\n",
+				ret);
+			return ret;
 		}
-	else if (ret) {
-		dev_err(dev,
-			"Failed to read the revision number from syscon: %d\n",
-			ret);
-		return ret;
+
+		revision = (revision >> REVISION_SHIFT) & REVISION_MASK;
 	}
 
-	*revision_value = BIT((revision >> REVISION_SHIFT) & REVISION_MASK);
+	*revision_value = BIT(revision);
 
 	return 0;
 }
@@ -392,9 +414,14 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 		goto register_cpufreq_dt;
 	}
 
-	ret = ti_cpufreq_setup_syscon_register(opp_data);
-	if (ret)
-		goto fail_put_node;
+	opp_data->dev = &pdev->dev;
+	opp_data->dev->of_node = opp_data->opp_node;
+
+	if (!of_property_read_bool(opp_data->opp_node, "nvmem-cells")) {
+		ret = ti_cpufreq_setup_syscon_register(opp_data);
+		if (ret)
+			goto fail_put_node;
+	}
 
 	/*
 	 * OPPs determine whether or not they are supported based on
-- 
2.43.0


