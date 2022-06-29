Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF6655F9CA
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jun 2022 09:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbiF2Hx1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jun 2022 03:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbiF2HxL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jun 2022 03:53:11 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E9F3B3E5
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 00:52:59 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e2so21034384edv.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 00:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NVOkXLmoRORRDlnK8ZUeIL+gfaMag/9GYHUkDD1/2+A=;
        b=GFAIyXPMCvtmzn/WTlueMGio4NTjs+kt73DyQldj8eYka+NV2PVXWMl5APQ5wLoJsN
         A4aHo3W6cQl+o94595z4m5XTe8WS6/8ZUu2pT5RRg2/3AxUDgLMsG0ZIy2H8/k+FGu1e
         4zmIEb271W0mvHMvRoEWAqu+kjHSLvhI8uSO8HlzPJDPb5hdzrmnHM2riAwvPfrnr/qA
         e3XxqcSafwqGUiJzoFZt98rI8Uy/XRYiy8ohlA+oCMCKqJEMxmbSbxtCXqHGPY/HPLyV
         PoBpMp1y9si1V3MBA4fnj0YI7a/CcUCfFsiOAzH8Y0iNBVL/smFeFRssx4+0uBb9+VdH
         w0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NVOkXLmoRORRDlnK8ZUeIL+gfaMag/9GYHUkDD1/2+A=;
        b=3XS5hPsGnBxtS3hYUxs7Y6/62dgwe1BvaIl8XqDV0HpZiCt4dE3s3uHnYnCgpHxasd
         XCgnmzKFPD9zpmqJEsn/7Qt+WUyXvRobIx6kEZ5otz4lPmvWjLJ24cdnINUPfpbCNOCL
         kXx5Rs4JR/c7oltR2eOkdLFP4wFU7HcfcKOWlp9y72GejPkYIEUU4jtc2xBVAwhzt6IR
         Sm4yW34QlDPGu816XHgkD293qMfC/6oaG5c8AlPqK90p4uMwVKWmWuT7bPADVkf0TUmu
         BtBRwhQPlVfSFdMQN6Li5sTt8md4gWwhoR+f09xu+UBvpi4hJHDLPp9AfcmK8XWgU2CK
         NtHQ==
X-Gm-Message-State: AJIora/+QV+1hg4sY8ifawHfU79sESnQPhriMiqJStojRwz32SbLQuIb
        EhNQq/IbFiQQg7p2/YNSMDYFcw==
X-Google-Smtp-Source: AGRyM1uXsU6gydS3qaBCPRY0yUuaB5FrBB9jqOH9EHysNs8uKnwjsvft604h6lNls6tkVN9bupQQmA==
X-Received: by 2002:a05:6402:2741:b0:434:fe8a:1f96 with SMTP id z1-20020a056402274100b00434fe8a1f96mr2513145edd.331.1656489177835;
        Wed, 29 Jun 2022 00:52:57 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id t2-20020a056402020200b00437db6acaeesm432173edv.95.2022.06.29.00.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 00:52:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thara Gopinath <thara.gopinath@gmail.com>
Subject: [PATCH v5 2/4] soc: qcom: icc-bwmon: Add bandwidth monitoring driver
Date:   Wed, 29 Jun 2022 09:52:48 +0200
Message-Id: <20220629075250.17610-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220629075250.17610-1-krzysztof.kozlowski@linaro.org>
References: <20220629075250.17610-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Bandwidth monitoring (BWMON) sits between various subsytems like CPU,
GPU, Last Level caches and memory subsystem.  The BWMON can be
configured to monitor the data throuhput between memory and other
subsytems.  The throughput is measured within specified sampling window
and is used to vote for corresponding interconnect bandwidth.

Current implementation brings support for BWMON v4, used for example on
SDM845 to measure bandwidth between CPU (gladiator_noc) and Last Level
Cache (memnoc).  Usage of this BWMON allows to remove fixed bandwidth
votes from cpufreq (CPU nodes) thus achieve high memory throughput even
with lower CPU frequencies.

Co-developed-by: Thara Gopinath <thara.gopinath@gmail.com>
Signed-off-by: Thara Gopinath <thara.gopinath@gmail.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS                  |   7 +
 drivers/soc/qcom/Kconfig     |  15 ++
 drivers/soc/qcom/Makefile    |   1 +
 drivers/soc/qcom/icc-bwmon.c | 421 +++++++++++++++++++++++++++++++++++
 4 files changed, 444 insertions(+)
 create mode 100644 drivers/soc/qcom/icc-bwmon.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6157e706ed02..968a0494d768 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16376,6 +16376,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/i2c/i2c-qcom-cci.txt
 F:	drivers/i2c/busses/i2c-qcom-cci.c
 
+QUALCOMM INTERCONNECT BWMON DRIVER
+M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/interconnect/qcom,msm8998-cpu-bwmon.yaml
+F:	drivers/soc/qcom/icc-bwmon.c
+
 QUALCOMM IOMMU
 M:	Rob Clark <robdclark@gmail.com>
 L:	iommu@lists.linux-foundation.org
diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index e718b8735444..35c5192dcfc7 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -228,4 +228,19 @@ config QCOM_APR
 	  application processor and QDSP6. APR is
 	  used by audio driver to configure QDSP6
 	  ASM, ADM and AFE modules.
+
+config QCOM_ICC_BWMON
+	tristate "QCOM Interconnect Bandwidth Monitor driver"
+	depends on ARCH_QCOM || COMPILE_TEST
+	select PM_OPP
+	help
+	  Sets up driver monitoring bandwidth on various interconnects and
+	  based on that voting for interconnect bandwidth, adjusting their
+	  speed to current demand.
+	  Current implementation brings support for BWMON v4, used for example
+	  on SDM845 to measure bandwidth between CPU (gladiator_noc) and Last
+	  Level Cache (memnoc).  Usage of this BWMON allows to remove fixed
+	  bandwidth votes from cpufreq (CPU nodes) thus achieve high memory
+	  throughput even with lower CPU frequencies.
+
 endmenu
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 70d5de69fd7b..d66604aff2b0 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -28,3 +28,4 @@ obj-$(CONFIG_QCOM_LLCC) += llcc-qcom.o
 obj-$(CONFIG_QCOM_RPMHPD) += rpmhpd.o
 obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
 obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
+obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
new file mode 100644
index 000000000000..1eed075545db
--- /dev/null
+++ b/drivers/soc/qcom/icc-bwmon.c
@@ -0,0 +1,421 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014-2018, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2021-2022 Linaro Ltd
+ * Author: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, based on
+ *         previous work of Thara Gopinath and msm-4.9 downstream sources.
+ */
+#include <linux/interconnect.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/sizes.h>
+
+/*
+ * The BWMON samples data throughput within 'sample_ms' time. With three
+ * configurable thresholds (Low, Medium and High) gives four windows (called
+ * zones) of current bandwidth:
+ *
+ * Zone 0: byte count < THRES_LO
+ * Zone 1: THRES_LO < byte count < THRES_MED
+ * Zone 2: THRES_MED < byte count < THRES_HIGH
+ * Zone 3: THRES_HIGH < byte count
+ *
+ * Zones 0 and 2 are not used by this driver.
+ */
+
+/* Internal sampling clock frequency */
+#define HW_TIMER_HZ				19200000
+
+#define BWMON_GLOBAL_IRQ_STATUS			0x0
+#define BWMON_GLOBAL_IRQ_CLEAR			0x8
+#define BWMON_GLOBAL_IRQ_ENABLE			0xc
+#define BWMON_GLOBAL_IRQ_ENABLE_ENABLE		BIT(0)
+
+#define BWMON_IRQ_STATUS			0x100
+#define BWMON_IRQ_STATUS_ZONE_SHIFT		4
+#define BWMON_IRQ_CLEAR				0x108
+#define BWMON_IRQ_ENABLE			0x10c
+#define BWMON_IRQ_ENABLE_ZONE1_SHIFT		5
+#define BWMON_IRQ_ENABLE_ZONE2_SHIFT		6
+#define BWMON_IRQ_ENABLE_ZONE3_SHIFT		7
+#define BWMON_IRQ_ENABLE_MASK			(BIT(BWMON_IRQ_ENABLE_ZONE1_SHIFT) | \
+						 BIT(BWMON_IRQ_ENABLE_ZONE3_SHIFT))
+
+#define BWMON_ENABLE				0x2a0
+#define BWMON_ENABLE_ENABLE			BIT(0)
+
+#define BWMON_CLEAR				0x2a4
+#define BWMON_CLEAR_CLEAR			BIT(0)
+
+#define BWMON_SAMPLE_WINDOW			0x2a8
+#define BWMON_THRESHOLD_HIGH			0x2ac
+#define BWMON_THRESHOLD_MED			0x2b0
+#define BWMON_THRESHOLD_LOW			0x2b4
+
+#define BWMON_ZONE_ACTIONS			0x2b8
+/*
+ * Actions to perform on some zone 'z' when current zone hits the threshold:
+ * Increment counter of zone 'z'
+ */
+#define BWMON_ZONE_ACTIONS_INCREMENT(z)		(0x2 << ((z) * 2))
+/* Clear counter of zone 'z' */
+#define BWMON_ZONE_ACTIONS_CLEAR(z)		(0x1 << ((z) * 2))
+
+/* Zone 0 threshold hit: Clear zone count */
+#define BWMON_ZONE_ACTIONS_ZONE0		(BWMON_ZONE_ACTIONS_CLEAR(0))
+
+/* Zone 1 threshold hit: Increment zone count & clear lower zones */
+#define BWMON_ZONE_ACTIONS_ZONE1		(BWMON_ZONE_ACTIONS_INCREMENT(1) | \
+						 BWMON_ZONE_ACTIONS_CLEAR(0))
+
+/* Zone 2 threshold hit: Increment zone count & clear lower zones */
+#define BWMON_ZONE_ACTIONS_ZONE2		(BWMON_ZONE_ACTIONS_INCREMENT(2) | \
+						 BWMON_ZONE_ACTIONS_CLEAR(1) | \
+						 BWMON_ZONE_ACTIONS_CLEAR(0))
+
+/* Zone 3 threshold hit: Increment zone count & clear lower zones */
+#define BWMON_ZONE_ACTIONS_ZONE3		(BWMON_ZONE_ACTIONS_INCREMENT(3) | \
+						 BWMON_ZONE_ACTIONS_CLEAR(2) | \
+						 BWMON_ZONE_ACTIONS_CLEAR(1) | \
+						 BWMON_ZONE_ACTIONS_CLEAR(0))
+/* Value for BWMON_ZONE_ACTIONS */
+#define BWMON_ZONE_ACTIONS_DEFAULT		(BWMON_ZONE_ACTIONS_ZONE0 | \
+						 BWMON_ZONE_ACTIONS_ZONE1 << 8 | \
+						 BWMON_ZONE_ACTIONS_ZONE2 << 16 | \
+						 BWMON_ZONE_ACTIONS_ZONE3 << 24)
+
+/*
+ * There is no clear documentation/explanation of BWMON_THRESHOLD_COUNT
+ * register. Based on observations, this is number of times one threshold has to
+ * be reached, to trigger interrupt in given zone.
+ *
+ * 0xff are maximum values meant to ignore the zones 0 and 2.
+ */
+#define BWMON_THRESHOLD_COUNT			0x2bc
+#define BWMON_THRESHOLD_COUNT_ZONE1_SHIFT	8
+#define BWMON_THRESHOLD_COUNT_ZONE2_SHIFT	16
+#define BWMON_THRESHOLD_COUNT_ZONE3_SHIFT	24
+#define BWMON_THRESHOLD_COUNT_ZONE0_DEFAULT	0xff
+#define BWMON_THRESHOLD_COUNT_ZONE2_DEFAULT	0xff
+
+/* BWMONv4 count registers use count unit of 64 kB */
+#define BWMON_COUNT_UNIT_KB			64
+#define BWMON_ZONE_COUNT			0x2d8
+#define BWMON_ZONE_MAX(zone)			(0x2e0 + 4 * (zone))
+
+struct icc_bwmon_data {
+	unsigned int sample_ms;
+	unsigned int default_highbw_kbps;
+	unsigned int default_medbw_kbps;
+	unsigned int default_lowbw_kbps;
+	u8 zone1_thres_count;
+	u8 zone3_thres_count;
+};
+
+struct icc_bwmon {
+	struct device *dev;
+	void __iomem *base;
+	int irq;
+
+	unsigned int default_lowbw_kbps;
+	unsigned int sample_ms;
+	unsigned int max_bw_kbps;
+	unsigned int min_bw_kbps;
+	unsigned int target_kbps;
+	unsigned int current_kbps;
+};
+
+static void bwmon_clear_counters(struct icc_bwmon *bwmon)
+{
+	/*
+	 * Clear counters. The order and barriers are
+	 * important. Quoting downstream Qualcomm msm-4.9 tree:
+	 *
+	 * The counter clear and IRQ clear bits are not in the same 4KB
+	 * region. So, we need to make sure the counter clear is completed
+	 * before we try to clear the IRQ or do any other counter operations.
+	 */
+	writel(BWMON_CLEAR_CLEAR, bwmon->base + BWMON_CLEAR);
+}
+
+static void bwmon_clear_irq(struct icc_bwmon *bwmon)
+{
+	/*
+	 * Clear zone and global interrupts. The order and barriers are
+	 * important. Quoting downstream Qualcomm msm-4.9 tree:
+	 *
+	 * Synchronize the local interrupt clear in mon_irq_clear()
+	 * with the global interrupt clear here. Otherwise, the CPU
+	 * may reorder the two writes and clear the global interrupt
+	 * before the local interrupt, causing the global interrupt
+	 * to be retriggered by the local interrupt still being high.
+	 *
+	 * Similarly, because the global registers are in a different
+	 * region than the local registers, we need to ensure any register
+	 * writes to enable the monitor after this call are ordered with the
+	 * clearing here so that local writes don't happen before the
+	 * interrupt is cleared.
+	 */
+	writel(BWMON_IRQ_ENABLE_MASK, bwmon->base + BWMON_IRQ_CLEAR);
+	writel(BIT(0), bwmon->base + BWMON_GLOBAL_IRQ_CLEAR);
+}
+
+static void bwmon_disable(struct icc_bwmon *bwmon)
+{
+	/* Disable interrupts. Strict ordering, see bwmon_clear_irq(). */
+	writel(0x0, bwmon->base + BWMON_GLOBAL_IRQ_ENABLE);
+	writel(0x0, bwmon->base + BWMON_IRQ_ENABLE);
+
+	/*
+	 * Disable bwmon. Must happen before bwmon_clear_irq() to avoid spurious
+	 * IRQ.
+	 */
+	writel(0x0, bwmon->base + BWMON_ENABLE);
+}
+
+static void bwmon_enable(struct icc_bwmon *bwmon, unsigned int irq_enable)
+{
+	/* Enable interrupts */
+	writel(BWMON_GLOBAL_IRQ_ENABLE_ENABLE,
+	       bwmon->base + BWMON_GLOBAL_IRQ_ENABLE);
+	writel(irq_enable, bwmon->base + BWMON_IRQ_ENABLE);
+
+	/* Enable bwmon */
+	writel(BWMON_ENABLE_ENABLE, bwmon->base + BWMON_ENABLE);
+}
+
+static unsigned int bwmon_kbps_to_count(unsigned int kbps)
+{
+	return kbps / BWMON_COUNT_UNIT_KB;
+}
+
+static void bwmon_set_threshold(struct icc_bwmon *bwmon, unsigned int reg,
+				unsigned int kbps)
+{
+	unsigned int thres;
+
+	thres = mult_frac(bwmon_kbps_to_count(kbps), bwmon->sample_ms,
+			  MSEC_PER_SEC);
+	writel_relaxed(thres, bwmon->base + reg);
+}
+
+static void bwmon_start(struct icc_bwmon *bwmon,
+			const struct icc_bwmon_data *data)
+{
+	unsigned int thres_count;
+	int window;
+
+	bwmon_clear_counters(bwmon);
+
+	window = mult_frac(bwmon->sample_ms, HW_TIMER_HZ, MSEC_PER_SEC);
+	/* Maximum sampling window: 0xfffff */
+	writel_relaxed(window, bwmon->base + BWMON_SAMPLE_WINDOW);
+
+	bwmon_set_threshold(bwmon, BWMON_THRESHOLD_HIGH,
+			    data->default_highbw_kbps);
+	bwmon_set_threshold(bwmon, BWMON_THRESHOLD_MED,
+			    data->default_medbw_kbps);
+	bwmon_set_threshold(bwmon, BWMON_THRESHOLD_LOW,
+			    data->default_lowbw_kbps);
+
+	thres_count = data->zone3_thres_count << BWMON_THRESHOLD_COUNT_ZONE3_SHIFT |
+		      BWMON_THRESHOLD_COUNT_ZONE2_DEFAULT << BWMON_THRESHOLD_COUNT_ZONE2_SHIFT |
+		      data->zone1_thres_count << BWMON_THRESHOLD_COUNT_ZONE1_SHIFT |
+		      BWMON_THRESHOLD_COUNT_ZONE0_DEFAULT;
+	writel_relaxed(thres_count, bwmon->base + BWMON_THRESHOLD_COUNT);
+	writel_relaxed(BWMON_ZONE_ACTIONS_DEFAULT,
+		       bwmon->base + BWMON_ZONE_ACTIONS);
+	/* Write barriers in bwmon_clear_irq() */
+
+	bwmon_clear_irq(bwmon);
+	bwmon_enable(bwmon, BWMON_IRQ_ENABLE_MASK);
+}
+
+static irqreturn_t bwmon_intr(int irq, void *dev_id)
+{
+	struct icc_bwmon *bwmon = dev_id;
+	unsigned int status, max;
+	int zone;
+
+	status = readl(bwmon->base + BWMON_IRQ_STATUS);
+	status &= BWMON_IRQ_ENABLE_MASK;
+	if (!status) {
+		/*
+		 * Only zone 1 and zone 3 interrupts are enabled but zone 2
+		 * threshold could be hit and trigger interrupt even if not
+		 * enabled.
+		 * Such spurious interrupt might come with valuable max count or
+		 * not, so solution would be to always check all
+		 * BWMON_ZONE_MAX() registers to find the highest value.
+		 * Such case is currently ignored.
+		 */
+		return IRQ_NONE;
+	}
+
+	bwmon_disable(bwmon);
+
+	zone = get_bitmask_order(status >> BWMON_IRQ_STATUS_ZONE_SHIFT) - 1;
+	/*
+	 * Zone max bytes count register returns count units within sampling
+	 * window.  Downstream kernel for BWMONv4 (called BWMON type 2 in
+	 * downstream) always increments the max bytes count by one.
+	 */
+	max = readl(bwmon->base + BWMON_ZONE_MAX(zone)) + 1;
+	max *= BWMON_COUNT_UNIT_KB;
+	bwmon->target_kbps = mult_frac(max, MSEC_PER_SEC, bwmon->sample_ms);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t bwmon_intr_thread(int irq, void *dev_id)
+{
+	struct icc_bwmon *bwmon = dev_id;
+	unsigned int irq_enable = 0;
+	struct dev_pm_opp *opp, *target_opp;
+	unsigned int bw_kbps, up_kbps, down_kbps;
+
+	bw_kbps = bwmon->target_kbps;
+
+	target_opp = dev_pm_opp_find_bw_ceil(bwmon->dev, &bw_kbps, 0);
+	if (IS_ERR(target_opp) && PTR_ERR(target_opp) == -ERANGE)
+		target_opp = dev_pm_opp_find_bw_floor(bwmon->dev, &bw_kbps, 0);
+
+	bwmon->target_kbps = bw_kbps;
+
+	bw_kbps--;
+	opp = dev_pm_opp_find_bw_floor(bwmon->dev, &bw_kbps, 0);
+	if (IS_ERR(opp) && PTR_ERR(opp) == -ERANGE)
+		down_kbps = bwmon->target_kbps;
+	else
+		down_kbps = bw_kbps;
+
+	up_kbps = bwmon->target_kbps + 1;
+
+	if (bwmon->target_kbps >= bwmon->max_bw_kbps)
+		irq_enable = BIT(BWMON_IRQ_ENABLE_ZONE1_SHIFT);
+	else if (bwmon->target_kbps <= bwmon->min_bw_kbps)
+		irq_enable = BIT(BWMON_IRQ_ENABLE_ZONE3_SHIFT);
+	else
+		irq_enable = BWMON_IRQ_ENABLE_MASK;
+
+	bwmon_set_threshold(bwmon, BWMON_THRESHOLD_HIGH, up_kbps);
+	bwmon_set_threshold(bwmon, BWMON_THRESHOLD_MED, down_kbps);
+	/* Write barriers in bwmon_clear_counters() */
+	bwmon_clear_counters(bwmon);
+	bwmon_clear_irq(bwmon);
+	bwmon_enable(bwmon, irq_enable);
+
+	if (bwmon->target_kbps == bwmon->current_kbps)
+		goto out;
+
+	dev_pm_opp_set_opp(bwmon->dev, target_opp);
+	bwmon->current_kbps = bwmon->target_kbps;
+
+out:
+	dev_pm_opp_put(target_opp);
+	if (!IS_ERR(opp))
+		dev_pm_opp_put(opp);
+
+	return IRQ_HANDLED;
+}
+
+static int bwmon_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dev_pm_opp *opp;
+	struct icc_bwmon *bwmon;
+	const struct icc_bwmon_data *data;
+	int ret;
+
+	bwmon = devm_kzalloc(dev, sizeof(*bwmon), GFP_KERNEL);
+	if (!bwmon)
+		return -ENOMEM;
+
+	data = of_device_get_match_data(dev);
+
+	bwmon->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(bwmon->base)) {
+		dev_err(dev, "failed to map bwmon registers\n");
+		return PTR_ERR(bwmon->base);
+	}
+
+	bwmon->irq = platform_get_irq(pdev, 0);
+	if (bwmon->irq < 0) {
+		dev_err(dev, "failed to acquire bwmon IRQ\n");
+		return bwmon->irq;
+	}
+
+	ret = devm_pm_opp_of_add_table(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add OPP table\n");
+
+	bwmon->max_bw_kbps = UINT_MAX;
+	opp = dev_pm_opp_find_bw_floor(dev, &bwmon->max_bw_kbps, 0);
+	if (IS_ERR(opp))
+		return dev_err_probe(dev, ret, "failed to find max peak bandwidth\n");
+
+	bwmon->min_bw_kbps = 0;
+	opp = dev_pm_opp_find_bw_ceil(dev, &bwmon->min_bw_kbps, 0);
+	if (IS_ERR(opp))
+		return dev_err_probe(dev, ret, "failed to find min peak bandwidth\n");
+
+	bwmon->sample_ms = data->sample_ms;
+	bwmon->default_lowbw_kbps = data->default_lowbw_kbps;
+	bwmon->dev = dev;
+
+	bwmon_disable(bwmon);
+	ret = devm_request_threaded_irq(dev, bwmon->irq, bwmon_intr,
+					bwmon_intr_thread,
+					IRQF_ONESHOT, dev_name(dev), bwmon);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to request IRQ\n");
+
+	platform_set_drvdata(pdev, bwmon);
+	bwmon_start(bwmon, data);
+
+	return 0;
+}
+
+static int bwmon_remove(struct platform_device *pdev)
+{
+	struct icc_bwmon *bwmon = platform_get_drvdata(pdev);
+
+	bwmon_disable(bwmon);
+
+	return 0;
+}
+
+/* BWMON v4 */
+static const struct icc_bwmon_data sdm845_bwmon_data = {
+	.sample_ms = 4,
+	.default_highbw_kbps = 4800 * 1024, /* 4.8 GBps */
+	.default_medbw_kbps = 512 * 1024, /* 512 MBps */
+	.default_lowbw_kbps = 0,
+	.zone1_thres_count = 16,
+	.zone3_thres_count = 1,
+};
+
+static const struct of_device_id bwmon_of_match[] = {
+	{ .compatible = "qcom,sdm845-cpu-bwmon", .data = &sdm845_bwmon_data },
+	{}
+};
+MODULE_DEVICE_TABLE(of, bwmon_of_match);
+
+static struct platform_driver bwmon_driver = {
+	.probe = bwmon_probe,
+	.remove = bwmon_remove,
+	.driver = {
+		.name = "qcom-bwmon",
+		.of_match_table = bwmon_of_match,
+	},
+};
+module_platform_driver(bwmon_driver);
+
+MODULE_AUTHOR("Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>");
+MODULE_DESCRIPTION("QCOM BWMON driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

