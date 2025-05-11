Return-Path: <linux-pm+bounces-27025-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C155FAB2A71
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 20:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2497B18971FF
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 18:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60E125F98F;
	Sun, 11 May 2025 18:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gw95Sgyn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E3D2AE9A;
	Sun, 11 May 2025 18:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746989441; cv=none; b=sdG+pErquAA9+SyRpjDH/crJu49mi8vJ2f2bgZN4Oicyy9p9WvB93hAwGjuDj68YGzm6f7V23WCGrHxEVMbZDmeH5cUF2rQJ0XMNG9rxSJ0feDvvo9H1LJk/tkj25nb3Zuyrj9YqOZoSJL0uH03zznxZWMIuHA+cSE3l+A394M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746989441; c=relaxed/simple;
	bh=tXb3gFWDeBnXVlC58EIGFnyOx0H+UU87UZKpSKOHEKg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/dBDhbIH73suGMXTrlrHikie51+1lCUNKO5SbBL2MPjnqWQpbmblmfBKUa0RREEfSc1/d97qYYLL8ThdpZP+AQ5p2xACyIOuPtE+mdLmrcDcs0ZhCrbITZj9R/pxaYEFHFkYRWtS2GVYUGxmSQwNmtaVLQus1aMiJrRBc5VAVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gw95Sgyn; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf257158fso24870445e9.2;
        Sun, 11 May 2025 11:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746989437; x=1747594237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfVw7emK/FD/l4aI0chA1J5Q6BXQe11qxLZZegq/ddU=;
        b=gw95SgynH3uTInBFvtulO93BuD0wb+hsnq9Yrdilj8vYTXAxZijBDyvB4INXt5TfdE
         Vor5Hq6y7TUvaJl/HLgackSeE+ZhNSmMk2+tgFr7wLtkJ2TMR/Y0MXP9CWW/YhqFnSm7
         kxFmM2OqaCVmja+vsi2EiJKHpHHZE7OMGsFoJB9/nHXRdg4iJ4sUpAfoyW8j4Wq72x2C
         9KvCvajm5D2268HtlB85IhXRACWMcuyrR3iPjmXpUEFqnLOWIo6jP8TR0alldCiFtqhy
         KJy3CZH+WQU56e9fzpve4FmeZKerIfrXsZIl6h9jBn1+91vOQCppYmoh+gqUQ5pPf1mF
         wDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746989437; x=1747594237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfVw7emK/FD/l4aI0chA1J5Q6BXQe11qxLZZegq/ddU=;
        b=KGoO/NiQ7l5sUBrEFsZWD1GDwY2ssP6yzTccRUwvTUGnLpYIYkXyQF9jSq8E4nBF2o
         O+a4yKiAaH/6X0TdLS2oF/0ob8+AA+HlUv1nwpjEn8j3kwwEVYod1sdklj84rpk8Rk+Z
         AigXOFBVabS6v3zF+dzwGbmz+hQkiGjXuoB/WvPjz5/ZFWeFcYVUW+Jbxkl5lRSQ0d+b
         XM9DgepARPCfx8Hq9fcpud70YQ8/shqePQfdRr6w+i2msy3lZnbFczhFP+bq4CRbkFBE
         0u28GDSyL4vPBmXCCypxhK56VYxKtJSA9C7SgkMeAyb36gyRn7i315TBdsvf/Esozi6v
         znhA==
X-Forwarded-Encrypted: i=1; AJvYcCV+k/D+B6BtMGeDhep2+FOLDc3hJqA3oLc1L/zeyyHmZ4d+pKT9pgGLzlOuoiVTMT2oDsKFQQonKCpj@vger.kernel.org, AJvYcCXIfw98JSKGdpdc1nZQompehVfpUZhs81M5vH1jLLIwPCcGzQdhDsK3ks8miVDYDSLvhVyjHGwPCUQRBi1Y@vger.kernel.org, AJvYcCXL61sNAg7jP7XQUPZc56WL81j1+boSY+0+UFZUa4C94UU6jqvzKINnGgcVNn53766ziNKjjujvByQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Xfnj+K4/gEDIyZPcGmxrp1D46LwhVLsOIXKvt4/gIWQXnkZD
	ZTK4U2F1B9dYKmDo1rpx3n+r7QZZOr/wcn8jNo8LYcr6w3t1zHng
X-Gm-Gg: ASbGncu8lc2cI2xgTh1g8rAxF7DD68XZE4DVRv3mt1Hvo52oXqBQbp8l6YdaJEarUCp
	EUcXoCw52n08M7uhJU7KnDSk1At2cwGOSEmAFBc7w+keUpLiCk+piNrn5KnZhGY5Ha5SO7xNhw4
	dLRaM7cFYIiBmr4eAakI2kxrIGv6+a84prN7seiIJpa02hJLmke5rxcIQFlIByi4DKvQwXqFF+Z
	GDL7xxckEOGu8nk7+4vwCiAMFf1fxFyqzHSLCoWxl1GbFWfSIHxLsZ7MZXvtuqMRhD9Pz/bnnZ0
	SwrkSfge9KFyoob27DZ1KLvsu0B2X5mry9RYmTOVL5WReg2ZI4wCdcMYzWGYbJB+8ZweQRtql0m
	t1ucG7yFaFZ3KOUJFKi6Y
X-Google-Smtp-Source: AGHT+IFG1bCbyEbDFYBWq09Ya4Sc29TKReMBp/srCNzUo76YcXqHlt/kCaNq+vgZN6FcpCVufnSV3w==
X-Received: by 2002:a05:600c:528a:b0:43d:abd:ad0e with SMTP id 5b1f17b1804b1-442d6d6b6ecmr90373585e9.18.1746989437170;
        Sun, 11 May 2025 11:50:37 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442cd34be0csm141257725e9.18.2025.05.11.11.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 11:50:36 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/2] thermal: Add support for Airoha EN7581 thermal sensor
Date: Sun, 11 May 2025 20:49:55 +0200
Message-ID: <20250511185003.3754495-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250511185003.3754495-1-ansuelsmth@gmail.com>
References: <20250511185003.3754495-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for Airoha EN7581 thermal sensor. This provide support for
reading the CPU or SoC Package sensor and to setup trip points for hot
and critical condition. An interrupt is fired to react on this and
doesn't require passive poll to read the temperature.

The thermal regs provide a way to read the ADC value from an external
register placed in the Chip SCU regs. Monitor will read this value and
fire an interrupt if the trip condition configured is reached.

The Thermal Trip and Interrupt logic is conceptually similar to Mediatek
LVTS Thermal but differ in register mapping and actual function/bug
workaround. The implementation only share some register names but from
functionality observation it's very different and used only for the
basic function of periodically poll the temp and trip the interrupt.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v7:
- Fix compilation warning for switch case empty default
Changes v6:
- Use minmax.h helper where possible
- Drop cast for void *
- Reset interrupt before calling update
- Improve logic for thermal temp read
Changes v5:
- Add additional info on difference from Mediatek LVTS driver
Changes v4:
- Handle offset and slope in priv driver
Changes v3:
- Handle thermal_zone_device moved in different header
- Enable interrupt after thermal register
- Use new way to provide slope and offset
Changes v2:
- Add missing Makefile and Kconfig entry (somehow not included in v1)
- Sort include header
- Add missing bitfield.h

 drivers/thermal/Kconfig          |   9 +
 drivers/thermal/Makefile         |   1 +
 drivers/thermal/airoha_thermal.c | 489 +++++++++++++++++++++++++++++++
 3 files changed, 499 insertions(+)
 create mode 100644 drivers/thermal/airoha_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 510c2b821546..a09c188b9ad1 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -327,6 +327,15 @@ config QORIQ_THERMAL
 	  cpufreq is used as the cooling device to throttle CPUs when the
 	  passive trip is crossed.
 
+config AIROHA_THERMAL
+	tristate "Airoha thermal sensor driver"
+	depends on ARCH_AIROHA || COMPILE_TEST
+	depends on MFD_SYSCON
+	depends on OF
+	help
+	  Enable this to plug the Airoha thermal sensor driver into the Linux
+	  thermal framework.
+
 config SPEAR_THERMAL
 	tristate "SPEAr thermal sensor driver"
 	depends on PLAT_SPEAR || COMPILE_TEST
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 9abf43a74f2b..d7718978db24 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_K3_THERMAL)	+= k3_bandgap.o k3_j72xx_bandgap.o
 # platform thermal drivers
 obj-y				+= broadcom/
 obj-$(CONFIG_THERMAL_MMIO)		+= thermal_mmio.o
+obj-$(CONFIG_AIROHA_THERMAL)	+= airoha_thermal.o
 obj-$(CONFIG_SPEAR_THERMAL)	+= spear_thermal.o
 obj-$(CONFIG_SUN8I_THERMAL)     += sun8i_thermal.o
 obj-$(CONFIG_ROCKCHIP_THERMAL)	+= rockchip_thermal.o
diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
new file mode 100644
index 000000000000..45116cdaee65
--- /dev/null
+++ b/drivers/thermal/airoha_thermal.c
@@ -0,0 +1,489 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/module.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/thermal.h>
+
+/* SCU regs */
+#define EN7581_PLLRG_PROTECT			0x268
+#define EN7581_PWD_TADC				0x2ec
+#define   EN7581_MUX_TADC			GENMASK(3, 1)
+#define EN7581_DOUT_TADC			0x2f8
+#define   EN7581_DOUT_TADC_MASK			GENMASK(15, 0)
+
+/* PTP_THERMAL regs */
+#define EN7581_TEMPMONCTL0			0x800
+#define   EN7581_SENSE3_EN			BIT(3)
+#define   EN7581_SENSE2_EN			BIT(2)
+#define   EN7581_SENSE1_EN			BIT(1)
+#define   EN7581_SENSE0_EN			BIT(0)
+#define EN7581_TEMPMONCTL1			0x804
+/* period unit calculated in BUS clock * 256 scaling-up */
+#define   EN7581_PERIOD_UNIT			GENMASK(9, 0)
+#define EN7581_TEMPMONCTL2			0x808
+#define   EN7581_FILT_INTERVAL			GENMASK(25, 16)
+#define   EN7581_SEN_INTERVAL			GENMASK(9, 0)
+#define EN7581_TEMPMONINT			0x80C
+#define   EN7581_STAGE3_INT_EN			BIT(31)
+#define   EN7581_STAGE2_INT_EN			BIT(30)
+#define   EN7581_STAGE1_INT_EN			BIT(29)
+#define   EN7581_FILTER_INT_EN_3		BIT(28)
+#define   EN7581_IMMD_INT_EN3			BIT(27)
+#define   EN7581_NOHOTINTEN3			BIT(26)
+#define   EN7581_HOFSINTEN3			BIT(25)
+#define   EN7581_LOFSINTEN3			BIT(24)
+#define   EN7581_HINTEN3			BIT(23)
+#define   EN7581_CINTEN3			BIT(22)
+#define   EN7581_FILTER_INT_EN_2		BIT(21)
+#define   EN7581_FILTER_INT_EN_1		BIT(20)
+#define   EN7581_FILTER_INT_EN_0		BIT(19)
+#define   EN7581_IMMD_INT_EN2			BIT(18)
+#define   EN7581_IMMD_INT_EN1			BIT(17)
+#define   EN7581_IMMD_INT_EN0			BIT(16)
+#define   EN7581_TIME_OUT_INT_EN		BIT(15)
+#define   EN7581_NOHOTINTEN2			BIT(14)
+#define   EN7581_HOFSINTEN2			BIT(13)
+#define   EN7581_LOFSINTEN2			BIT(12)
+#define   EN7581_HINTEN2			BIT(11)
+#define   EN7581_CINTEN2			BIT(10)
+#define   EN7581_NOHOTINTEN1			BIT(9)
+#define   EN7581_HOFSINTEN1			BIT(8)
+#define   EN7581_LOFSINTEN1			BIT(7)
+#define   EN7581_HINTEN1			BIT(6)
+#define   EN7581_CINTEN1			BIT(5)
+#define   EN7581_NOHOTINTEN0			BIT(4)
+/* Similar to COLD and HOT also these seems to be swapped in documentation */
+#define   EN7581_LOFSINTEN0			BIT(3) /* In documentation: BIT(2) */
+#define   EN7581_HOFSINTEN0			BIT(2) /* In documentation: BIT(3) */
+/* It seems documentation have these swapped as the HW
+ * - Fire BIT(1) when lower than EN7581_COLD_THRE
+ * - Fire BIT(0) and BIT(5) when higher than EN7581_HOT2NORMAL_THRE or
+ *     EN7581_HOT_THRE
+ */
+#define   EN7581_CINTEN0			BIT(1) /* In documentation: BIT(0) */
+#define   EN7581_HINTEN0			BIT(0) /* In documentation: BIT(1) */
+#define EN7581_TEMPMONINTSTS			0x810
+#define   EN7581_STAGE3_INT_STAT		BIT(31)
+#define   EN7581_STAGE2_INT_STAT		BIT(30)
+#define   EN7581_STAGE1_INT_STAT		BIT(29)
+#define   EN7581_FILTER_INT_STAT_3		BIT(28)
+#define   EN7581_IMMD_INT_STS3			BIT(27)
+#define   EN7581_NOHOTINTSTS3			BIT(26)
+#define   EN7581_HOFSINTSTS3			BIT(25)
+#define   EN7581_LOFSINTSTS3			BIT(24)
+#define   EN7581_HINTSTS3			BIT(23)
+#define   EN7581_CINTSTS3			BIT(22)
+#define   EN7581_FILTER_INT_STAT_2		BIT(21)
+#define   EN7581_FILTER_INT_STAT_1		BIT(20)
+#define   EN7581_FILTER_INT_STAT_0		BIT(19)
+#define   EN7581_IMMD_INT_STS2			BIT(18)
+#define   EN7581_IMMD_INT_STS1			BIT(17)
+#define   EN7581_IMMD_INT_STS0			BIT(16)
+#define   EN7581_TIME_OUT_INT_STAT		BIT(15)
+#define   EN7581_NOHOTINTSTS2			BIT(14)
+#define   EN7581_HOFSINTSTS2			BIT(13)
+#define   EN7581_LOFSINTSTS2			BIT(12)
+#define   EN7581_HINTSTS2			BIT(11)
+#define   EN7581_CINTSTS2			BIT(10)
+#define   EN7581_NOHOTINTSTS1			BIT(9)
+#define   EN7581_HOFSINTSTS1			BIT(8)
+#define   EN7581_LOFSINTSTS1			BIT(7)
+#define   EN7581_HINTSTS1			BIT(6)
+#define   EN7581_CINTSTS1			BIT(5)
+#define   EN7581_NOHOTINTSTS0			BIT(4)
+/* Similar to COLD and HOT also these seems to be swapped in documentation */
+#define   EN7581_LOFSINTSTS0			BIT(3) /* In documentation: BIT(2) */
+#define   EN7581_HOFSINTSTS0			BIT(2) /* In documentation: BIT(3) */
+/* It seems documentation have these swapped as the HW
+ * - Fire BIT(1) when lower than EN7581_COLD_THRE
+ * - Fire BIT(0) and BIT(5) when higher than EN7581_HOT2NORMAL_THRE or
+ *     EN7581_HOT_THRE
+ *
+ * To clear things, we swap the define but we keep them documented here.
+ */
+#define   EN7581_CINTSTS0			BIT(1) /* In documentation: BIT(0) */
+#define   EN7581_HINTSTS0			BIT(0) /* In documentation: BIT(1)*/
+/* Monitor will take the bigger threshold between HOT2NORMAL and HOT
+ * and will fire both HOT2NORMAL and HOT interrupt when higher than the 2
+ *
+ * It has also been observed that not setting HOT2NORMAL makes the monitor
+ * treat COLD threshold as HOT2NORMAL.
+ */
+#define EN7581_TEMPH2NTHRE			0x824
+/* It seems HOT2NORMAL is actually NORMAL2HOT */
+#define   EN7581_HOT2NORMAL_THRE		GENMASK(11, 0)
+#define EN7581_TEMPHTHRE			0x828
+#define   EN7581_HOT_THRE			GENMASK(11, 0)
+/* Monitor will use this as HOT2NORMAL (fire interrupt when lower than...)*/
+#define EN7581_TEMPCTHRE			0x82c
+#define   EN7581_COLD_THRE			GENMASK(11, 0)
+/* Also LOW and HIGH offset register are swapped */
+#define EN7581_TEMPOFFSETL			0x830 /* In documentation: 0x834 */
+#define   EN7581_LOW_OFFSET			GENMASK(11, 0)
+#define EN7581_TEMPOFFSETH			0x834 /* In documentation: 0x830 */
+#define   EN7581_HIGH_OFFSET			GENMASK(11, 0)
+#define EN7581_TEMPMSRCTL0			0x838
+#define   EN7581_MSRCTL3			GENMASK(11, 9)
+#define   EN7581_MSRCTL2			GENMASK(8, 6)
+#define   EN7581_MSRCTL1			GENMASK(5, 3)
+#define   EN7581_MSRCTL0			GENMASK(2, 0)
+#define EN7581_TEMPADCVALIDADDR			0x878
+#define   EN7581_ADC_VALID_ADDR			GENMASK(31, 0)
+#define EN7581_TEMPADCVOLTADDR			0x87c
+#define   EN7581_ADC_VOLT_ADDR			GENMASK(31, 0)
+#define EN7581_TEMPRDCTRL			0x880
+/*
+ * NOTICE: AHB have this set to 0 by default. Means that
+ * the same addr is used for ADC volt and valid reading.
+ * In such case, VALID ADDR is used and volt addr is ignored.
+ */
+#define   EN7581_RD_CTRL_DIFF			BIT(0)
+#define EN7581_TEMPADCVALIDMASK			0x884
+#define   EN7581_ADV_RD_VALID_POLARITY		BIT(5)
+#define   EN7581_ADV_RD_VALID_POS		GENMASK(4, 0)
+#define EN7581_TEMPADCVOLTAGESHIFT		0x888
+#define   EN7581_ADC_VOLTAGE_SHIFT		GENMASK(4, 0)
+/*
+ * Same values for each CTL.
+ * Can operate in:
+ * - 1 sample
+ * - 2 sample and make average of them
+ * - 4,6,10,16 sample, drop max and min and make avgerage of them
+ */
+#define   EN7581_MSRCTL_1SAMPLE			0x0
+#define   EN7581_MSRCTL_AVG2SAMPLE		0x1
+#define   EN7581_MSRCTL_4SAMPLE_MAX_MIX_AVG2	0x2
+#define   EN7581_MSRCTL_6SAMPLE_MAX_MIX_AVG4	0x3
+#define   EN7581_MSRCTL_10SAMPLE_MAX_MIX_AVG8	0x4
+#define   EN7581_MSRCTL_18SAMPLE_MAX_MIX_AVG16	0x5
+#define EN7581_TEMPAHBPOLL			0x840
+#define   EN7581_ADC_POLL_INTVL			GENMASK(31, 0)
+/* PTPSPARE0,2 reg are used to store efuse info for calibrated temp offset */
+#define EN7581_EFUSE_TEMP_OFFSET_REG		0xf20 /* PTPSPARE0 */
+#define   EN7581_EFUSE_TEMP_OFFSET		GENMASK(31, 16)
+#define EN7581_PTPSPARE1			0xf24 /* PTPSPARE1 */
+#define EN7581_EFUSE_TEMP_CPU_SENSOR_REG	0xf28 /* PTPSPARE2 */
+
+#define EN7581_SLOPE_X100_DIO_DEFAULT		5645
+#define EN7581_SLOPE_X100_DIO_AVS		5645
+
+#define EN7581_INIT_TEMP_CPK_X10		300
+#define EN7581_INIT_TEMP_FTK_X10		620
+#define EN7581_INIT_TEMP_NONK_X10		550
+
+#define EN7581_SCU_THERMAL_PROTECT_KEY		0x12
+#define EN7581_SCU_THERMAL_MUX_DIODE1		0x7
+
+/* Convert temp to raw value as read from ADC	((((temp / 100) - init) * slope) / 1000) + offset */
+#define TEMP_TO_RAW(priv, temp)			((((((temp) / 100) - (priv)->init_temp) * \
+						  (priv)->default_slope) / 1000) + \
+						 (priv)->default_offset)
+
+/* Convert raw to temp				((((temp - offset) * 1000) / slope + init) * 100) */
+#define RAW_TO_TEMP(priv, raw)			(((((raw) - (priv)->default_offset) * 1000) / \
+						  (priv)->default_slope + \
+						  (priv)->init_temp) * 100)
+
+#define AIROHA_MAX_SAMPLES			6
+
+struct airoha_thermal_priv {
+	void __iomem *base;
+	struct regmap *chip_scu;
+	struct resource scu_adc_res;
+
+	struct thermal_zone_device *tz;
+	int init_temp;
+	int default_slope;
+	int default_offset;
+};
+
+static int airoha_get_thermal_ADC(struct airoha_thermal_priv *priv)
+{
+	u32 val;
+
+	regmap_read(priv->chip_scu, EN7581_DOUT_TADC, &val);
+	return FIELD_GET(EN7581_DOUT_TADC_MASK, val);
+}
+
+static void airoha_init_thermal_ADC_mode(struct airoha_thermal_priv *priv)
+{
+	u32 adc_mux, pllrg;
+
+	/* Save PLLRG current value */
+	regmap_read(priv->chip_scu, EN7581_PLLRG_PROTECT, &pllrg);
+
+	/* Give access to thermal regs */
+	regmap_write(priv->chip_scu, EN7581_PLLRG_PROTECT, EN7581_SCU_THERMAL_PROTECT_KEY);
+	adc_mux = FIELD_PREP(EN7581_MUX_TADC, EN7581_SCU_THERMAL_MUX_DIODE1);
+	regmap_write(priv->chip_scu, EN7581_PWD_TADC, adc_mux);
+
+	/* Restore PLLRG value on exit */
+	regmap_write(priv->chip_scu, EN7581_PLLRG_PROTECT, pllrg);
+}
+
+static int airoha_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct airoha_thermal_priv *priv = thermal_zone_device_priv(tz);
+	int min_value, max_value, avg_value, value;
+	int i;
+
+	avg_value = 0;
+	min_value = INT_MAX;
+	max_value = INT_MIN;
+
+	for (i = 0; i < AIROHA_MAX_SAMPLES; i++) {
+		value = airoha_get_thermal_ADC(priv);
+		min_value = min(value, min_value);
+		max_value = max(value, max_value);
+		avg_value += value;
+	}
+
+	/* Drop min and max and average for the remaining sample */
+	avg_value -= (min_value + max_value);
+	avg_value /= AIROHA_MAX_SAMPLES - 2;
+
+	*temp = RAW_TO_TEMP(priv, avg_value);
+	return 0;
+}
+
+static int airoha_thermal_set_trips(struct thermal_zone_device *tz, int low,
+				    int high)
+{
+	struct airoha_thermal_priv *priv = thermal_zone_device_priv(tz);
+	bool enable_monitor = false;
+
+	if (high != INT_MAX) {
+		/* Validate high and clamp it a supported value */
+		high = clamp_t(int, high, RAW_TO_TEMP(priv, 0),
+			       RAW_TO_TEMP(priv, FIELD_MAX(EN7581_DOUT_TADC_MASK)));
+
+		/* We offset the high temp of 1°C to trigger correct event */
+		writel(TEMP_TO_RAW(priv, high) >> 4,
+		       priv->base + EN7581_TEMPOFFSETH);
+
+		enable_monitor = true;
+	}
+
+	if (low != -INT_MAX) {
+		/* Validate low and clamp it to a supported value */
+		low = clamp_t(int, high, RAW_TO_TEMP(priv, 0),
+			      RAW_TO_TEMP(priv, FIELD_MAX(EN7581_DOUT_TADC_MASK)));
+
+		/* We offset the low temp of 1°C to trigger correct event */
+		writel(TEMP_TO_RAW(priv, low) >> 4,
+		       priv->base + EN7581_TEMPOFFSETL);
+
+		enable_monitor = true;
+	}
+
+	/* Enable sensor 0 monitor after trip are set */
+	if (enable_monitor)
+		writel(EN7581_SENSE0_EN, priv->base + EN7581_TEMPMONCTL0);
+
+	return 0;
+}
+
+static const struct thermal_zone_device_ops thdev_ops = {
+	.get_temp = airoha_thermal_get_temp,
+	.set_trips = airoha_thermal_set_trips,
+};
+
+static irqreturn_t airoha_thermal_irq(int irq, void *data)
+{
+	struct airoha_thermal_priv *priv = data;
+	enum thermal_notify_event event;
+	bool update = false;
+	u32 status;
+
+	status = readl(priv->base + EN7581_TEMPMONINTSTS);
+	switch (status & (EN7581_HOFSINTSTS0 | EN7581_LOFSINTSTS0)) {
+	case EN7581_HOFSINTSTS0:
+		event = THERMAL_TRIP_VIOLATED;
+		update = true;
+		break;
+	case EN7581_LOFSINTSTS0:
+		event = THERMAL_EVENT_UNSPECIFIED;
+		update = true;
+		break;
+	default:
+		/* Should be impossible as we enable only these Interrupt */
+		break;
+	}
+
+	/* Reset Interrupt */
+	writel(status, priv->base + EN7581_TEMPMONINTSTS);
+
+	if (update)
+		thermal_zone_device_update(priv->tz, event);
+
+	return IRQ_HANDLED;
+}
+
+static void airoha_thermal_setup_adc_val(struct device *dev,
+					 struct airoha_thermal_priv *priv)
+{
+	u32 efuse_calib_info, cpu_sensor;
+
+	/* Setup thermal sensor to ADC mode and setup the mux to DIODE1 */
+	airoha_init_thermal_ADC_mode(priv);
+	/* sleep 10 ms for ADC to enable */
+	usleep_range(10 * USEC_PER_MSEC, 11 * USEC_PER_MSEC);
+
+	efuse_calib_info = readl(priv->base + EN7581_EFUSE_TEMP_OFFSET_REG);
+	if (efuse_calib_info) {
+		priv->default_offset = FIELD_GET(EN7581_EFUSE_TEMP_OFFSET, efuse_calib_info);
+		/* Different slope are applied if the sensor is used for CPU or for package */
+		cpu_sensor = readl(priv->base + EN7581_EFUSE_TEMP_CPU_SENSOR_REG);
+		if (cpu_sensor) {
+			priv->default_slope = EN7581_SLOPE_X100_DIO_DEFAULT;
+			priv->init_temp = EN7581_INIT_TEMP_FTK_X10;
+		} else {
+			priv->default_slope = EN7581_SLOPE_X100_DIO_AVS;
+			priv->init_temp = EN7581_INIT_TEMP_CPK_X10;
+		}
+	} else {
+		priv->default_offset = airoha_get_thermal_ADC(priv);
+		priv->default_slope = EN7581_SLOPE_X100_DIO_DEFAULT;
+		priv->init_temp = EN7581_INIT_TEMP_NONK_X10;
+		dev_info(dev, "missing thermal calibrarion EFUSE, using non calibrated value\n");
+	}
+}
+
+static void airoha_thermal_setup_monitor(struct airoha_thermal_priv *priv)
+{
+	/* Set measure mode */
+	writel(FIELD_PREP(EN7581_MSRCTL0, EN7581_MSRCTL_6SAMPLE_MAX_MIX_AVG4),
+	       priv->base + EN7581_TEMPMSRCTL0);
+
+	/*
+	 * Configure ADC valid reading addr
+	 * The AHB temp monitor system doesn't have direct access to the
+	 * thermal sensor. It does instead work by providing all kind of
+	 * address to configure how to access and setup an ADC for the
+	 * sensor. EN7581 supports only one sensor hence the
+	 * implementation is greatly simplified but the AHB supports
+	 * up to 4 different sensor from the same ADC that can be
+	 * switched by tuning the ADC mux or wiriting address.
+	 *
+	 * We set valid instead of volt as we don't enable valid/volt
+	 * split reading and AHB read valid addr in such case.
+	 */
+	writel(priv->scu_adc_res.start + EN7581_DOUT_TADC,
+	       priv->base + EN7581_TEMPADCVALIDADDR);
+
+	/*
+	 * Configure valid bit on a fake value of bit 16. The ADC outputs
+	 * max of 2 bytes for voltage.
+	 */
+	writel(FIELD_PREP(EN7581_ADV_RD_VALID_POS, 16),
+	       priv->base + EN7581_TEMPADCVALIDMASK);
+
+	/*
+	 * AHB supports max 12 bytes for ADC voltage. Shift the read
+	 * value 4 bit to the right. Precision lost by this is minimal
+	 * in the order of half a °C and is acceptable in the context
+	 * of triggering interrupt in critical condition.
+	 */
+	writel(FIELD_PREP(EN7581_ADC_VOLTAGE_SHIFT, 4),
+	       priv->base + EN7581_TEMPADCVOLTAGESHIFT);
+
+	/* BUS clock is 300MHz counting unit is 3 * 68.64 * 256 = 52.715us */
+	writel(FIELD_PREP(EN7581_PERIOD_UNIT, 3),
+	       priv->base + EN7581_TEMPMONCTL1);
+
+	/*
+	 * filt interval is 1 * 52.715us = 52.715us,
+	 * sen interval is 379 * 52.715us = 19.97ms
+	 */
+	writel(FIELD_PREP(EN7581_FILT_INTERVAL, 1) |
+	       FIELD_PREP(EN7581_FILT_INTERVAL, 379),
+	       priv->base + EN7581_TEMPMONCTL2);
+
+	/* AHB poll is set to 146 * 68.64 = 10.02us */
+	writel(FIELD_PREP(EN7581_ADC_POLL_INTVL, 146),
+	       priv->base + EN7581_TEMPAHBPOLL);
+}
+
+static int airoha_thermal_probe(struct platform_device *pdev)
+{
+	struct airoha_thermal_priv *priv;
+	struct device_node *chip_scu_np;
+	struct device *dev = &pdev->dev;
+	int irq, ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	chip_scu_np = of_parse_phandle(dev->of_node, "airoha,chip-scu", 0);
+	if (!chip_scu_np)
+		return -EINVAL;
+
+	priv->chip_scu = syscon_node_to_regmap(chip_scu_np);
+	if (IS_ERR(priv->chip_scu))
+		return PTR_ERR(priv->chip_scu);
+
+	of_address_to_resource(chip_scu_np, 0, &priv->scu_adc_res);
+	of_node_put(chip_scu_np);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+					airoha_thermal_irq, IRQF_ONESHOT,
+					pdev->name, priv);
+	if (ret) {
+		dev_err(dev, "Can't get interrupt working.\n");
+		return ret;
+	}
+
+	airoha_thermal_setup_monitor(priv);
+	airoha_thermal_setup_adc_val(dev, priv);
+
+	/* register of thermal sensor and get info from DT */
+	priv->tz = devm_thermal_of_zone_register(dev, 0, priv, &thdev_ops);
+	if (IS_ERR(priv->tz)) {
+		dev_err(dev, "register thermal zone sensor failed\n");
+		return PTR_ERR(priv->tz);
+	}
+
+	platform_set_drvdata(pdev, priv);
+
+	/* Enable LOW and HIGH interrupt */
+	writel(EN7581_HOFSINTEN0 | EN7581_LOFSINTEN0,
+	       priv->base + EN7581_TEMPMONINT);
+
+	return 0;
+}
+
+static const struct of_device_id airoha_thermal_match[] = {
+	{ .compatible = "airoha,en7581-thermal" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, airoha_thermal_match);
+
+static struct platform_driver airoha_thermal_driver = {
+	.driver = {
+		.name = "airoha-thermal",
+		.of_match_table = airoha_thermal_match,
+	},
+	.probe = airoha_thermal_probe,
+};
+
+module_platform_driver(airoha_thermal_driver);
+
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
+MODULE_DESCRIPTION("Airoha thermal driver");
+MODULE_LICENSE("GPL");
-- 
2.48.1


