Return-Path: <linux-pm+bounces-23044-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0521A47ABC
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 11:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 898DB16D82D
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 10:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EB722B597;
	Thu, 27 Feb 2025 10:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GommgqJB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BC522A4E0
	for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2025 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740653202; cv=none; b=TJmN+vZvL4q4MtLYZqfJs6JubOhJOibGrGFg5OVWdMwO521j46rZGTDsfa1uX1BBR0MnarzFe+6a/Lku+ur2JM2n1zDPEkd1uKAlyWY9ui0hpZsZpl/YEYGysMkZzcQpdBC1QrWpCDjjmygAdW1jTEr+GhyLwFL+j71MmOoaxtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740653202; c=relaxed/simple;
	bh=W9D+anLswderraXRnZUvbxnOgYIsKuJjLY7iig4it4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hXcGXTgX378MIvPRnAUCu6LDQ5ma8vu0ycXdEOaYLTIFxOFuUnidJbUfcHdNKa1ZYygZVgrihWNAc5SDZms9EAfO4AxfWXbX6Dm4bDyfLk38rQZq8fGfwiVdBffgpkpwLXbEirIh3lgHTNcxjPlnzCPZrwcxyIFsJ4qLfQEKSbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GommgqJB; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e0b70fb1daso1214481a12.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2025 02:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740653199; x=1741257999; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2GinroxZiXaUl0iulTclS3Q5Hjx+0LaS8RfRGW3GbBU=;
        b=GommgqJBDnmdCWUQoaT/QRdTmY4OZMLY4f/lOQxdY3kKNUeZ/Kh9UTxpVkOimpzOg1
         7IiL9URGjV3A1ZmfU+jVStjqJCC/ACb+SukMt9LcTfzudK2jAzQhG3jUcgCsHgT5qjNw
         xHdmwj5xg3Kso1JBMzfgJYKheV/jDJtHuWTpNRgZBgW9FnLzuoC4sgtxRb1tPPfGkAK0
         iTkbE+8O6bSEqMQTIZnALNvJSXiipBycvL7E1mNtsx4WWuq+5/DC9wm3IKTcCZxxtHb6
         PvuoD21i4ZTag2K9CiGyoAyFI3ktwX2nbjVGx+bwwcYW7UBUY6kznuYcO4KLmho0M5AQ
         xEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740653199; x=1741257999;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GinroxZiXaUl0iulTclS3Q5Hjx+0LaS8RfRGW3GbBU=;
        b=VPOmDaZDzsntW4xOhXNcl7TvHDk80ZR3a7HD/xQRgTNJsuQQKYNfutKnJrLYMd7mHs
         EtwL4nMx2r96k+eZwe0fnvQpYEUAHG1XU1q234iMc+D5irvkQOs2sgI6RoRTXD/es1di
         7NZKH65bzdVvgeUE1yitIR9wqWpB4aNcrRZxE6/9KuFSLiIiwVhzwT3p3I/RBFW1GHrL
         4RMvJmXtKYiJ3pDts43CeXZ1brrpD+IVivk2yOtm7ZGwkRByWAHgiCle3l/ynfkXzBrD
         dUopHjcuUwdEOIk+9iF+zAkKxJNmubE7t7BA4oTi34CLOhsdBMUaWJo1nF9HTEVWvkxK
         sQGA==
X-Forwarded-Encrypted: i=1; AJvYcCVHPXiemIUUr95Oh4FcnKA2CTGFT/IIdokfKUFka0n8cLcjXVZyMXcTufrPaMfnL49cX2ewAIdxQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2y5tAWkdGTb7DgvL5VmTKqNQq9qxLQpya6D96tacHcofYOWKQ
	WERuYgvT+cO22BDYINz1hHLURUwPRNkdI1HndNfEpAa9DPaC5BdmHnYVKUT7KMM=
X-Gm-Gg: ASbGncsLAQ0iB+2/CTQ0CuN0e/gIqYcuontkRfnMcaMe6QpHCOkpBIRPy30lj5DnM61
	yvhhFuYaamU5oSMk7ApgWqHuNImMwz1H6k36u42uIQ5P2cEHsSGY1mz+Wd1Ua63JamUKBNMQI2o
	/eQX4Nj0aTnUODixShRf1Y+GIQ6nCAk7IUncx3u7sr9qFFrd7zv9kPcfvz9WvM7x+iyaAdA/z3w
	aDoAXBXeO7rZfHh7oilyUtYPIpy4/Pf8s5kRMRhJjy56efr5bDh9U17OYQid3E2C6MNZJyMqrwP
	wUVU6Evwo2EDxhx+Z8t40cAVcl2/iyj8GlpQxk6JFB65mU6otBWgMJ5i+wvJo9v/bX6C3tOhHE6
	6Lr+0TmDuiw==
X-Google-Smtp-Source: AGHT+IFqCgtaEn18UyqkDgMvhRqj12YBC1o82ZagmdpxbrZDloQykLk5OMYN37B77iU31+3OfQ8GNw==
X-Received: by 2002:a05:6402:27d3:b0:5e0:82a0:50ab with SMTP id 4fb4d7f45d1cf-5e4a0e160e3mr9376148a12.27.1740653198730;
        Thu, 27 Feb 2025 02:46:38 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3bb5ad8sm901032a12.34.2025.02.27.02.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 02:46:38 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 27 Feb 2025 10:46:14 +0000
Subject: [PATCH v3 2/2] power: reset: syscon-reboot: support different
 reset modes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250227-syscon-reboot-reset-mode-v3-2-959ac53c338a@linaro.org>
References: <20250227-syscon-reboot-reset-mode-v3-0-959ac53c338a@linaro.org>
In-Reply-To: <20250227-syscon-reboot-reset-mode-v3-0-959ac53c338a@linaro.org>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

Linux supports a couple different reset modes, but this driver here
doesn't distinguish between them and issues the same syscon register
write irrespective of the reset mode requested by the kernel.

Update this driver to support most of Linux' reset modes: cold, hard,
warm, and soft.

The actions to take for these are taken from DT, and are all new
optional properties. The property names match the existing properties
supported but should be prefixed with the reset mode.

This change is meant to be backwards compatible with existing DTs, and
if Linux requests a reset mode that this driver doesn't support, or
that the DT doesn't specify, the reset is triggered using the fallback
/ default entry.

As an example why this is useful, other than properly supporting the
Linux reboot= kernel command line option or sysfs entry, this change
allows platforms to e.g. default to a more secure cold-reset, but
also to do a warm-reset in case RAM contents needs to be retained
across the reset.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/power/reset/syscon-reboot.c | 96 ++++++++++++++++++++++++++++++++-----
 1 file changed, 85 insertions(+), 11 deletions(-)

diff --git a/drivers/power/reset/syscon-reboot.c b/drivers/power/reset/syscon-reboot.c
index d623d77e657e4c233d8ae88bb099bee13c48a9ef..81b917a531b8bf04d7c5e7027bdc3290f2183eb0 100644
--- a/drivers/power/reset/syscon-reboot.c
+++ b/drivers/power/reset/syscon-reboot.c
@@ -14,11 +14,29 @@
 #include <linux/reboot.h>
 #include <linux/regmap.h>
 
-struct syscon_reboot_context {
-	struct regmap *map;
+/* REBOOT_GPIO doesn't make sense for syscon-reboot */
+static const struct {
+	enum reboot_mode mode;
+	const char *prefix;
+} prefix_map[] = {
+	{ .mode = REBOOT_COLD, .prefix = "cold"  },
+	{ .mode = REBOOT_WARM, .prefix = "warm"  },
+	{ .mode = REBOOT_HARD, .prefix = "hard"  },
+	{ .mode = REBOOT_SOFT, .prefix = "soft"  },
+};
+
+struct reboot_mode_bits {
 	u32 offset;
 	u32 value;
 	u32 mask;
+	bool valid;
+};
+
+struct syscon_reboot_context {
+	struct regmap *map;
+
+	struct reboot_mode_bits mode_bits[REBOOT_SOFT + 1];
+	struct reboot_mode_bits catchall;
 	struct notifier_block restart_handler;
 };
 
@@ -28,9 +46,16 @@ static int syscon_restart_handle(struct notifier_block *this,
 	struct syscon_reboot_context *ctx =
 			container_of(this, struct syscon_reboot_context,
 					restart_handler);
+	const struct reboot_mode_bits *mode_bits;
+
+	if (mode < ARRAY_SIZE(ctx->mode_bits) && ctx->mode_bits[mode].valid)
+		mode_bits = &ctx->mode_bits[mode];
+	else
+		mode_bits = &ctx->catchall;
 
 	/* Issue the reboot */
-	regmap_update_bits(ctx->map, ctx->offset, ctx->mask, ctx->value);
+	regmap_update_bits(ctx->map, mode_bits->offset, mode_bits->mask,
+			   mode_bits->value);
 
 	mdelay(1000);
 
@@ -60,12 +85,61 @@ static int syscon_reboot_probe(struct platform_device *pdev)
 	if (of_property_read_s32(pdev->dev.of_node, "priority", &priority))
 		priority = 192;
 
-	if (of_property_read_u32(pdev->dev.of_node, "offset", &ctx->offset))
-		if (of_property_read_u32(pdev->dev.of_node, "reg", &ctx->offset))
+	/* try to catch enum reboot_mode changing in any incompatible way */
+	BUILD_BUG_ON(ARRAY_SIZE(prefix_map) != ARRAY_SIZE(ctx->mode_bits));
+	BUILD_BUG_ON(ARRAY_SIZE(ctx->mode_bits) <= REBOOT_COLD);
+	BUILD_BUG_ON(ARRAY_SIZE(ctx->mode_bits) <= REBOOT_WARM);
+	BUILD_BUG_ON(ARRAY_SIZE(ctx->mode_bits) <= REBOOT_HARD);
+	BUILD_BUG_ON(ARRAY_SIZE(ctx->mode_bits) <= REBOOT_SOFT);
+
+	for (int i = 0; i < ARRAY_SIZE(prefix_map); ++i) {
+		const char * const prefix = prefix_map[i].prefix;
+		struct reboot_mode_bits * const mode_bits =
+			&ctx->mode_bits[prefix_map[i].mode];
+		char prop[32];
+
+		snprintf(prop, sizeof(prop), "%s-offset", prefix);
+		if (of_property_read_u32(pdev->dev.of_node, prop,
+					 &mode_bits->offset)) {
+			snprintf(prop, sizeof(prop), "%s-reg", prefix);
+			if (of_property_read_u32(pdev->dev.of_node, prop,
+						 &mode_bits->offset))
+				continue;
+		}
+
+		snprintf(prop, sizeof(prop), "%s-value", prefix);
+		if (of_property_read_u32(pdev->dev.of_node, prop,
+					 &mode_bits->value)) {
+			/*
+			 * unlike catchall below, don't support old binding
+			 * here
+			 */
+			dev_err(dev, "'%s' is mandatory\n", prop);
+			continue;
+		}
+
+		snprintf(prop, sizeof(prop), "%s-mask", prefix);
+		mask_err = of_property_read_u32(pdev->dev.of_node, prop,
+						&mode_bits->mask);
+
+		if (mask_err)
+			/* support value without mask */
+			mode_bits->mask = 0XFFFFFFFF;
+
+		mode_bits->valid = true;
+	}
+
+	/* catch-all entry */
+	if (of_property_read_u32(pdev->dev.of_node, "offset",
+				 &ctx->catchall.offset))
+		if (of_property_read_u32(pdev->dev.of_node, "reg",
+					 &ctx->catchall.offset))
 			return -EINVAL;
 
-	value_err = of_property_read_u32(pdev->dev.of_node, "value", &ctx->value);
-	mask_err = of_property_read_u32(pdev->dev.of_node, "mask", &ctx->mask);
+	value_err = of_property_read_u32(pdev->dev.of_node, "value",
+					 &ctx->catchall.value);
+	mask_err = of_property_read_u32(pdev->dev.of_node, "mask",
+					&ctx->catchall.mask);
 	if (value_err && mask_err) {
 		dev_err(dev, "unable to read 'value' and 'mask'");
 		return -EINVAL;
@@ -73,11 +147,11 @@ static int syscon_reboot_probe(struct platform_device *pdev)
 
 	if (value_err) {
 		/* support old binding */
-		ctx->value = ctx->mask;
-		ctx->mask = 0xFFFFFFFF;
+		ctx->catchall.value = ctx->catchall.mask;
+		ctx->catchall.mask = 0xFFFFFFFF;
 	} else if (mask_err) {
-		/* support value without mask*/
-		ctx->mask = 0xFFFFFFFF;
+		/* support value without mask */
+		ctx->catchall.mask = 0xFFFFFFFF;
 	}
 
 	ctx->restart_handler.notifier_call = syscon_restart_handle;

-- 
2.48.1.711.g2feabab25a-goog


