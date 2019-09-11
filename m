Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86B11B0579
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2019 00:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbfIKWTD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Sep 2019 18:19:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43751 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729003AbfIKWTC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2019 18:19:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id d15so14562494pfo.10
        for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2019 15:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=6COMbNYiBAH3DK2IekDUzK6LyWxPCeshYdSnc/L9JbE=;
        b=MKCb5mvqx7vPVDdvPX6sQfysgXJv0ZZJl6EQ2OfyWJs4KKhQeIz+B5sY8CGkAWe3mr
         WLLmqjsA62JkEmSYcKh9IBNCO5nQso0zq79qJrBlQAJmaW0S5IAnKvrcnzq40sGoS9fj
         Thwp/O6v/DqgKe76f6Z/ADzXrx88+AIR8oKZ3M8cWyMWwh6Q2LF85onrjItleYz8UGWh
         h4lTXaIxEHBMSA9jLY5z/8YCeJ409s0es7VB4Usz3wWUBWqFHOR069KpMZN42JNP1vuj
         C09KT4kazMZogjTUByrzFV8gjkhdl2Cy95jtqmoC4mm48r0qtR/TblXm8+DreAIqVFUq
         4nFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=6COMbNYiBAH3DK2IekDUzK6LyWxPCeshYdSnc/L9JbE=;
        b=igUbDWxs5cW3zdgNlzxVewG5yv07ies2aWiKN0MTiOF39dc2KgGTUkqOG0U8vY02bd
         sdb7GHDc7Y4D9FlWj45rqGz0SZpcsMsm9B082buO8aiWCGY1FmTyUqmVJYJ6mIt2aU3i
         gZPmN9TQkCKOjlTAU4v3iH0tY6rG0uzYhXlThWU/JGnRsAt9YDICRy+OALzWhQg1r+of
         OMJ141apc/dDc5EvO6vZZBrc6r3YAhxg6O/q8wvnnB6NwhZ5Jq+CsC7rwOcgjGEBek4s
         7+lH0DvYj/AlQNfVix2ipK+lpQLkahuyJDxQ/Hivj/YgLEs3NxCG6YOVKLA5vswACiD9
         rT1w==
X-Gm-Message-State: APjAAAWg7k5Gt+0b3CafVmKcwWaIzkQ4LrXPcz+1Xkr4/VdC5hmsfqyn
        ph/54RAfvJ+ALs6yMWxoiNDAq6kTRGYNEQ==
X-Google-Smtp-Source: APXvYqz+YhEdUNHVYAJHHVB+HxkousclqJcLJHmh0ogARlkU8Fktq7uSORReGl5PSbO3udOKXbq3uQ==
X-Received: by 2002:a65:6102:: with SMTP id z2mr34643771pgu.391.1568240341618;
        Wed, 11 Sep 2019 15:19:01 -0700 (PDT)
Received: from localhost ([49.248.179.160])
        by smtp.gmail.com with ESMTPSA id i194sm4085709pgc.0.2019.09.11.15.19.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Sep 2019 15:19:01 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        arm@kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 2/4] arm64: Kconfig: Fix BRCMSTB driver dependencies
Date:   Thu, 12 Sep 2019 03:48:46 +0530
Message-Id: <21b9dd0bf0bbc80b69bc81a7efb88243e4981c56.1568239378.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1568239378.git.amit.kucheria@linaro.org>
References: <cover.1568239378.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1568239378.git.amit.kucheria@linaro.org>
References: <cover.1568239378.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Push various BRCMSTB drivers behind ARCH_BRCMSTB dependency so that it
doesn't get enabled by default on other platforms.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/bus/Kconfig         | 1 +
 drivers/power/reset/Kconfig | 1 +
 drivers/soc/bcm/Kconfig     | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 1851112ccc29..d80e8d70bf10 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -22,6 +22,7 @@ config ARM_CCI400_PORT_CTRL
 
 config BRCMSTB_GISB_ARB
 	bool "Broadcom STB GISB bus arbiter"
+	depends on ARCH_BRCMSTB
 	depends on ARM || ARM64 || MIPS
 	default ARCH_BRCMSTB || BMIPS_GENERIC
 	help
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 651b763f80cd..6f0b1ed1a05a 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -59,6 +59,7 @@ config POWER_RESET_BRCMKONA
 
 config POWER_RESET_BRCMSTB
 	bool "Broadcom STB reset driver"
+	depends on ARCH_BRCMSTB
 	depends on ARM || ARM64 || MIPS || COMPILE_TEST
 	depends on MFD_SYSCON
 	default ARCH_BRCMSTB || BMIPS_GENERIC
diff --git a/drivers/soc/bcm/Kconfig b/drivers/soc/bcm/Kconfig
index 648e32693b7e..5a8ff33241ae 100644
--- a/drivers/soc/bcm/Kconfig
+++ b/drivers/soc/bcm/Kconfig
@@ -24,6 +24,7 @@ config RASPBERRYPI_POWER
 
 config SOC_BRCMSTB
 	bool "Broadcom STB SoC drivers"
+	depends on ARCH_BRCMSTB
 	depends on ARM || ARM64 || BMIPS_GENERIC || COMPILE_TEST
 	select SOC_BUS
 	help
-- 
2.17.1

