Return-Path: <linux-pm+bounces-24806-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3A1A7BCCA
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 14:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A593189CA58
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 12:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658D41E5B73;
	Fri,  4 Apr 2025 12:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SI4iODPo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3ED1DB363
	for <linux-pm@vger.kernel.org>; Fri,  4 Apr 2025 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743770416; cv=none; b=p2GoYPXWKDnodzn8x2ImxJ3t+EDnxP2yPz8ZELZd4+bek7y8pISNsmRWwtvcXsJzouyCYjcxfdFVZjMXvH2tI03AbLrbV8CKbjGBubWWQbRRnA2t+WdO1XF5+s5Olejvaxfk+b7bQvLJog6Rf9MUlZ0wY+atIG72Y3NlCCQQ2fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743770416; c=relaxed/simple;
	bh=mp8cJLgoOUlOQe5pHPhCKpMgDHHkEU6HvefJQt9GYSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vvop47thcBBi4RL3cLr0SaI8STRyjdPaMWhZfO8eKiWCGhUxYJUXu7thnRZBbp32xIQDdYXQNjrNNGdf4/ZsdjGrCGNnKkQ9XLOvh4BAl9/X2YzOvPqIwESnzfwtJMgQ3E+54y4NZhShXEhqpp1feZuy224+Gbfa4HdU6KQLpmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SI4iODPo; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39973c72e8cso199944f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Apr 2025 05:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743770412; x=1744375212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BNkwiRggtXL8RMSGB6OjJXFLVErNHtUr3angEyuAVQ0=;
        b=SI4iODPoDhNz4qOyR+bFnwLqp+MzE7aFdGPzd/n4BtwaKktgy6kTSInQpVziNOVFJ8
         hk3eMVBygcgayBCPFYgGRK2GKJi41pzTC0K6t/JpQ3jOclD/9ZqgfwWgspCUQmqOpELi
         CZ3sJsWamR6+etd50oy951Rdvuh2xCiq125Dfq4f+O0ksCTMyaSQ85zBv2LyGs966zAi
         FdiA6oZMIG1fzXhQIaYtvdmR3Ozt90/rCj+NRq9r6IAkwldXoahCCLN1I96a/+fc7pjh
         JbzKnbJFM2sFwm20I0keNnW8sc6e86GADigBEnuHJW+23oIjdll4UbtHqb3NmL2o8OL0
         4Dsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743770412; x=1744375212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BNkwiRggtXL8RMSGB6OjJXFLVErNHtUr3angEyuAVQ0=;
        b=ZMqF2ADHCLinn9UFZHiqTX+UuKzBfcJ+jje9B6fBlYI3+0FzQt5dOt8urkfoqMLbL4
         COrTD72jJ1f6Ri0LSTBlhPcIFTXe1EmtNij4xoLCIdoNwkhBi9phHlhwoEqWerhDIB5V
         7mAOcrpUwajwsAn2umdHDRuwFPjcg10/awDq9XIKexrPJoJGZuYESwHVQ2WY88gUXe5n
         5yg2KRL9hj+Ky1Bwxbza5A6v8iz+CPgQ9jUEfUJc4zQrLP3RxPx6PctvexakbYMw+E4b
         auB+3V4UJtmHnS3H2s4Rp72ynVF2DVqzQMfNGls0r/NjUpO1eZIklJkl72jJInj3pJD+
         74cQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhLAtYIyYjn84eoeIqBKNPUVeqFS9bZ07nFxEQTj2GIjKT5+rQ1nkcpwBsWbGjII6bgGjf2X9eYw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi3ZwIcjcx9mHL3aTT8LizwIUHTNuCM6Z7qfnDRlDT9Quf5ypI
	3rIS7shLu89UChQQijXSWT0aST+b84bomzcaMwH7M4QxznQzxIfHmi1iGh8y9eeFUhpsNMHHCo2
	R
X-Gm-Gg: ASbGncvnCI/0YUIRjXl4hiirm7ePesSbgIQGWpMo3tg9c5XStkLXT02V+iJhcvIWwUc
	NijRiFfRnO3+frZOcrOhkPIPcSqTcgjmVFXsgAc2cdfx8SKMUUQXhWuJ4vniWGYKvxeDHS9huDY
	6cC1ZAcuVQFsbgMuE3eZb2PFx7UqT1hR6feeLhE5xEKcIZRGHAFl3EKJAqhzLzYZbJGFt1Qu7i3
	seAMCeMw/PsZQd6SmVy7c2aMNDNW5mwpUF1wOBdaTqkZLKoqffIVmzidJO1pnLS8BF8Vh4xFEcl
	BROntcMXCWtsnAOAIOl5g5OE0cRyh5CWMZlrq/RENWYH3HTkdNr/xg==
X-Google-Smtp-Source: AGHT+IEURi10IoT1+Q2AT0oaalmPLIi4DcXVocxxasvzE9bMjolz2JujxAXVP42nSP6DxQsuxh8uoA==
X-Received: by 2002:a5d:64c7:0:b0:39c:1258:17d7 with SMTP id ffacd0b85a97d-39cba94bb2bmr906076f8f.16.1743770412643;
        Fri, 04 Apr 2025 05:40:12 -0700 (PDT)
Received: from shite.. ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30096bb2sm4316476f8f.12.2025.04.04.05.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 05:40:12 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] cpufreq: Do not enable by default during compile testing
Date: Fri,  4 Apr 2025 14:40:06 +0200
Message-ID: <20250404124006.362723-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling the compile test should not cause automatic enabling of all
drivers.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/cpufreq/Kconfig.arm | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 4f9cb943d945..d4d625ded285 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -76,7 +76,7 @@ config ARM_VEXPRESS_SPC_CPUFREQ
 config ARM_BRCMSTB_AVS_CPUFREQ
 	tristate "Broadcom STB AVS CPUfreq driver"
 	depends on (ARCH_BRCMSTB && !ARM_SCMI_CPUFREQ) || COMPILE_TEST
-	default y
+	default ARCH_BRCMSTB
 	help
 	  Some Broadcom STB SoCs use a co-processor running proprietary firmware
 	  ("AVS") to handle voltage and frequency scaling. This driver provides
@@ -181,7 +181,7 @@ config ARM_RASPBERRYPI_CPUFREQ
 config ARM_S3C64XX_CPUFREQ
 	bool "Samsung S3C64XX"
 	depends on CPU_S3C6410 || COMPILE_TEST
-	default y
+	default CPU_S3C6410
 	help
 	  This adds the CPUFreq driver for Samsung S3C6410 SoC.
 
@@ -190,7 +190,7 @@ config ARM_S3C64XX_CPUFREQ
 config ARM_S5PV210_CPUFREQ
 	bool "Samsung S5PV210 and S5PC110"
 	depends on CPU_S5PV210 || COMPILE_TEST
-	default y
+	default CPU_S5PV210
 	help
 	  This adds the CPUFreq driver for Samsung S5PV210 and
 	  S5PC110 SoCs.
@@ -214,7 +214,7 @@ config ARM_SCMI_CPUFREQ
 config ARM_SPEAR_CPUFREQ
 	bool "SPEAr CPUFreq support"
 	depends on PLAT_SPEAR || COMPILE_TEST
-	default y
+	default PLAT_SPEAR
 	help
 	  This adds the CPUFreq driver support for SPEAr SOCs.
 
@@ -233,7 +233,7 @@ config ARM_TEGRA20_CPUFREQ
 	tristate "Tegra20/30 CPUFreq support"
 	depends on ARCH_TEGRA || COMPILE_TEST
 	depends on CPUFREQ_DT
-	default y
+	default ARCH_TEGRA
 	help
 	  This adds the CPUFreq driver support for Tegra20/30 SOCs.
 
@@ -241,7 +241,7 @@ config ARM_TEGRA124_CPUFREQ
 	bool "Tegra124 CPUFreq support"
 	depends on ARCH_TEGRA || COMPILE_TEST
 	depends on CPUFREQ_DT
-	default y
+	default ARCH_TEGRA
 	help
 	  This adds the CPUFreq driver support for Tegra124 SOCs.
 
@@ -256,14 +256,14 @@ config ARM_TEGRA194_CPUFREQ
 	tristate "Tegra194 CPUFreq support"
 	depends on ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC || (64BIT && COMPILE_TEST)
 	depends on TEGRA_BPMP
-	default y
+	default ARCH_TEGRA
 	help
 	  This adds CPU frequency driver support for Tegra194 SOCs.
 
 config ARM_TI_CPUFREQ
 	bool "Texas Instruments CPUFreq support"
 	depends on ARCH_OMAP2PLUS || ARCH_K3 || COMPILE_TEST
-	default y
+	default ARCH_OMAP2PLUS || ARCH_K3
 	help
 	  This driver enables valid OPPs on the running platform based on
 	  values contained within the SoC in use. Enable this in order to
-- 
2.45.2


