Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1662443827
	for <lists+linux-pm@lfdr.de>; Tue,  2 Nov 2021 23:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhKBWEy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Nov 2021 18:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhKBWEx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Nov 2021 18:04:53 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713ACC061714;
        Tue,  2 Nov 2021 15:02:18 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id E8A8D5EBE;
        Tue,  2 Nov 2021 22:02:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E8A8D5EBE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1635890538; bh=dh+KdmP6MoWoVW3W+iVDSJslEzZnAzewMsCZBf9TP38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SNNsAYsMmzIeIBbJZfr6djLuXa9WdN8+vyk1Lkp3g0PL0vnsMZGLG7eLhgLpl2XVI
         sEMH56xmyvPsF0W+UXgo80OR1DaPExQaKLHHa0HWVSeAGv7uY+KNlszMYYWU0ZbNzM
         0kWZ/rB9BkZDYiSKY/QCPyqBlEMCwPZC98bVDjQmnoGBVvjX0y6v0hOXS1Weuh0PbU
         7Y+mbWBjMYrIJHifyWx5S4ChfKkO5M+5j5ucw7LAkFdx/WMtnaGi1132gplQo1mHAT
         TeauXEyyBGA0J/99Ig2XHHB8SVBqKhVXLB7SDKRneGXNC2/k6huM+E6DPRCJVLBMlH
         mg/sNlSB2593w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Cercueil <paul@crapouillou.net>,
        Lee Jones <lee.jones@linaro.org>,
        Paul Burton <paul.burton@mips.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH 1/9] Remove unused headers <linux/jz4740-adc.h> and <linux/power/jz4740-battery.h>
Date:   Tue,  2 Nov 2021 16:01:55 -0600
Message-Id: <20211102220203.940290-2-corbet@lwn.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211102220203.940290-1-corbet@lwn.net>
References: <20211102220203.940290-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit ff71266aa490 ("mfd: Drop obsolete JZ4740 driver") removed the last
file to include <linux/jz4740-adc.h> but left the header file itself
behind.  Nothing uses it, remove it now.

Similarly, aea12071d6fc ("power/supply: Drop obsolete JZ4740 driver")
deleted the last use of <linux/power/jz4740-battery.h>, so remove that one
too.

Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 include/linux/jz4740-adc.h           | 33 ----------------------------
 include/linux/power/jz4740-battery.h | 15 -------------
 2 files changed, 48 deletions(-)
 delete mode 100644 include/linux/jz4740-adc.h
 delete mode 100644 include/linux/power/jz4740-battery.h

diff --git a/include/linux/jz4740-adc.h b/include/linux/jz4740-adc.h
deleted file mode 100644
index 19d995c8bf06..000000000000
--- a/include/linux/jz4740-adc.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef __LINUX_JZ4740_ADC
-#define __LINUX_JZ4740_ADC
-
-struct device;
-
-/*
- * jz4740_adc_set_config - Configure a JZ4740 adc device
- * @dev: Pointer to a jz4740-adc device
- * @mask: Mask for the config value to be set
- * @val: Value to be set
- *
- * This function can be used by the JZ4740 ADC mfd cells to configure their
- * options in the shared config register.
-*/
-int jz4740_adc_set_config(struct device *dev, uint32_t mask, uint32_t val);
-
-#define JZ_ADC_CONFIG_SPZZ		BIT(31)
-#define JZ_ADC_CONFIG_EX_IN		BIT(30)
-#define JZ_ADC_CONFIG_DNUM_MASK		(0x7 << 16)
-#define JZ_ADC_CONFIG_DMA_ENABLE	BIT(15)
-#define JZ_ADC_CONFIG_XYZ_MASK		(0x2 << 13)
-#define JZ_ADC_CONFIG_SAMPLE_NUM_MASK	(0x7 << 10)
-#define JZ_ADC_CONFIG_CLKDIV_MASK	(0xf << 5)
-#define JZ_ADC_CONFIG_BAT_MB		BIT(4)
-
-#define JZ_ADC_CONFIG_DNUM(dnum)	((dnum) << 16)
-#define JZ_ADC_CONFIG_XYZ_OFFSET(dnum)	((xyz) << 13)
-#define JZ_ADC_CONFIG_SAMPLE_NUM(x)	((x) << 10)
-#define JZ_ADC_CONFIG_CLKDIV(div)	((div) << 5)
-
-#endif
diff --git a/include/linux/power/jz4740-battery.h b/include/linux/power/jz4740-battery.h
deleted file mode 100644
index 10da211678c8..000000000000
--- a/include/linux/power/jz4740-battery.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- *  Copyright (C) 2009, Jiejing Zhang <kzjeef@gmail.com>
- */
-
-#ifndef __JZ4740_BATTERY_H
-#define __JZ4740_BATTERY_H
-
-struct jz_battery_platform_data {
-	struct power_supply_info info;
-	int gpio_charge;	/* GPIO port of Charger state */
-	int gpio_charge_active_low;
-};
-
-#endif
-- 
2.31.1

