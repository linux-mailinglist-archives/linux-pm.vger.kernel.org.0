Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD56EC4773
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 08:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfJBGFQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 02:05:16 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45494 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbfJBGFJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2019 02:05:09 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191002060507euoutp01bd86e3d7b732818563196cdb616028d3~Jv1LibE341737717377euoutp01D
        for <linux-pm@vger.kernel.org>; Wed,  2 Oct 2019 06:05:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191002060507euoutp01bd86e3d7b732818563196cdb616028d3~Jv1LibE341737717377euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569996307;
        bh=c/2DarJPQlVGpO7uo/P0CC3CsQjlRXLLsP6XaaSE8qo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=une8KGnfziwGXCglD+SUKpryt+n+Ssm4xCHLD09biaSrcToUBonF6NNL+Mfp95M6s
         nktHe3lO1OevMHNMKCsLddiXKzIQhee/KE/WiDlBcxeNeLv8onDeDnTQPCVnocLrXu
         l+cCI7IAMdReChhDFFEy/cY4YdrpzrRrTv18ZHrw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191002060507eucas1p10737da51552e6b8652ca1dcde6ecb161~Jv1LRQHSr0048900489eucas1p1B;
        Wed,  2 Oct 2019 06:05:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C1.D9.04309.31E349D5; Wed,  2
        Oct 2019 07:05:07 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191002060507eucas1p169394dec59f010e112eb38d83e3fb8ba~Jv1K8W1Af1218212182eucas1p1a;
        Wed,  2 Oct 2019 06:05:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191002060507eusmtrp10ae19bc96bd9a93df78fd541a0491479~Jv1K7r34d2145721457eusmtrp1Q;
        Wed,  2 Oct 2019 06:05:07 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-65-5d943e1321d6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AD.EB.04117.31E349D5; Wed,  2
        Oct 2019 07:05:07 +0100 (BST)
Received: from AMDC3778.digital.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191002060506eusmtip29e375027648baa6b08fd56e4986441be~Jv1KHo0he2638126381eusmtip28;
        Wed,  2 Oct 2019 06:05:06 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        robh+dt@kernel.org, willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v3 4/4] memory: samsung: exynos5422-dmc: Add support for
 interrupt from performance counters
Date:   Wed,  2 Oct 2019 08:04:55 +0200
Message-Id: <20191002060455.3834-5-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002060455.3834-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsWy7djP87rCdlNiDX58kbPYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht7jVIGOx6fE1VovLu+awWXzuPcJoMeP8PiaLtUfuslss
        vX6RyeJ24wo2i9a9R9gtDr9pZ7X4duIRo4Ogx5p5axg9ds66y+6xaVUnm8fmJfUeB9/tYfLo
        27KK0ePzJrkA9igum5TUnMyy1CJ9uwSujCcb1jMXXC6p6Pn8mrGBcX58FyMnh4SAicS1pfOY
        uhi5OIQEVjBKLJ21jB3C+cIo8XzLLqjMZ0aJ2ft2sMC0PHxxmg0isZxRYvutpyxwLRMPLgdy
        ODjYBPQkdqwqBGkQEVjMKPHtcBRIDbPANiaJB6u+sYIkhAXyJPbufAFmswioSsw9fZMRxOYV
        sJNYfPEuG8Q2eYnVGw4wg9icAvYS7+7fYIaIn2KX2PDYBMJ2kXjT/IoVwhaWeHV8CzuELSNx
        enIP1NXFEg29Cxkh7BqJx/1zoWqsJQ4fv8gKcjOzgKbE+l36EGFHiWf7usBekRDgk7jxVhAk
        zAxkTto2nRkizCvR0SYEUa0hsaXnAhOELSaxfM00qOEeEv/ftDJDQmcSo8TpXd/ZJjDKz0JY
        toCRcRWjeGppcW56arFRXmq5XnFibnFpXrpecn7uJkZgWjr97/iXHYy7/iQdYhTgYFTi4W0I
        mhwrxJpYVlyZe4hRgoNZSYTX5s+kWCHelMTKqtSi/Pii0pzU4kOM0hwsSuK81QwPooUE0hNL
        UrNTUwtSi2CyTBycUg2MDBX/OplSlt0UyX75YPld5YVVXhM/PJjGwzT7yvlFC2JPKF/4OGnO
        ha3udy4JOWupbVDn+vVg+lXv71lhJwtm+wtN7UrcvlNLf1WItMgTBwfNR0XHhVr3LvKUXTKR
        5dzdnyEG09qKOqKPrDfeIK+5s6LqwVn9KXzMMp8tN83p6O58sfK0N4dhohJLcUaioRZzUXEi
        AEuVMRxHAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsVy+t/xe7rCdlNiDeZsYLXYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht7jVIGOx6fE1VovLu+awWXzuPcJoMeP8PiaLtUfuslss
        vX6RyeJ24wo2i9a9R9gtDr9pZ7X4duIRo4Ogx5p5axg9ds66y+6xaVUnm8fmJfUeB9/tYfLo
        27KK0ePzJrkA9ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy
        1CJ9uwS9jCcb1jMXXC6p6Pn8mrGBcX58FyMnh4SAicTDF6fZuhi5OIQEljJKrP68kQkiISYx
        ad92dghbWOLPtS6ook+MEs8n/wdyODjYBPQkdqwqBImLCCxnlDi26i0ziMMscIRJ4ujqa4wg
        RcICORLTG4xABrEIqErMPX2TEcTmFbCTWHzxLhvEAnmJ1RsOMIPYnAL2Eu/u32AGaRUCqvl/
        pnICI98CRoZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgXGy7djPLTsYu94FH2IU4GBU4uFt
        CJocK8SaWFZcmXuIUYKDWUmE1+bPpFgh3pTEyqrUovz4otKc1OJDjKZAN01klhJNzgfGcF5J
        vKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBkZ1vmccx+ZrW+RartdI
        Vjk996LSw4SqoGzz4x/N3C9/mvA0LDNjxev+76/v3vs23bbHKSGSu1V9puYjhXkJjL/2X3Pc
        vd7a5bKkU0hxu+Sp4z7ny5OC9VN6TG/r3LA4NvH9/erTLJw75u/fKPAqnEvDg7Hh6Ref+ruP
        T60Tfc6iJvWqf9aLi6JKLMUZiYZazEXFiQDpFegrqQIAAA==
X-CMS-MailID: 20191002060507eucas1p169394dec59f010e112eb38d83e3fb8ba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191002060507eucas1p169394dec59f010e112eb38d83e3fb8ba
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191002060507eucas1p169394dec59f010e112eb38d83e3fb8ba
References: <20191002060455.3834-1-l.luba@partner.samsung.com>
        <CGME20191002060507eucas1p169394dec59f010e112eb38d83e3fb8ba@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce a new interrupt driven mechanism for managing speed of the
memory controller. The interrupts are generated due to performance
counters overflow. The performance counters might track memory reads,
writes, transfers, page misses, etc. In the basic algorithm tracking
read transfers and calculating memory pressure should be enough to
skip polling mode in devfreq.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/memory/samsung/exynos5422-dmc.c | 345 ++++++++++++++++++++++--
 1 file changed, 320 insertions(+), 25 deletions(-)

diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index 0fe5f2186139..47dbf6d1789f 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -8,6 +8,7 @@
 #include <linux/devfreq.h>
 #include <linux/devfreq-event.h>
 #include <linux/device.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
@@ -35,6 +36,61 @@
 #define USE_BPLL_TIMINGS			(0)
 #define EXYNOS5_AREF_NORMAL			(0x2e)
 
+#define DREX_PPCCLKCON		(0x0130)
+#define DREX_PEREV2CONFIG	(0x013c)
+#define DREX_PMNC_PPC		(0xE000)
+#define DREX_CNTENS_PPC		(0xE010)
+#define DREX_CNTENC_PPC		(0xE020)
+#define DREX_INTENS_PPC		(0xE030)
+#define DREX_INTENC_PPC		(0xE040)
+#define DREX_FLAG_PPC		(0xE050)
+#define DREX_PMCNT2_PPC		(0xE130)
+
+/*
+ * A value for register DREX_PMNC_PPC which should be written to reset
+ * the cycle counter CCNT (a reference wall clock). It sets zero to the
+ * CCNT counter.
+ */
+#define CC_RESET		BIT(2)
+
+/*
+ * A value for register DREX_PMNC_PPC which does the reset of all performance
+ * counters to zero.
+ */
+#define PPC_COUNTER_RESET	BIT(1)
+
+/*
+ * Enables all configured counters (including cycle counter). The value should
+ * be written to the register DREX_PMNC_PPC.
+ */
+#define PPC_ENABLE		BIT(0)
+
+/* A value for register DREX_PPCCLKCON which enables performance events clock.
+ * Must be written before first access to the performance counters register
+ * set, otherwise it could crash.
+ */
+#define PEREV_CLK_EN		BIT(0)
+
+/*
+ * Values which are used to enable counters, interrupts or configure flags of
+ * the performance counters. They configure counter 2 and cycle counter.
+ */
+#define PERF_CNT2		BIT(2)
+#define PERF_CCNT		BIT(31)
+
+/*
+ * Performance event types which are used for setting the preferred event
+ * to track in the counters.
+ * There is a set of different types, the values are from range 0 to 0x6f.
+ * These settings should be written to the configuration register which manages
+ * the type of the event (register DREX_PEREV2CONFIG).
+ */
+#define READ_TRANSFER_CH0	(0x6d)
+#define READ_TRANSFER_CH1	(0x6f)
+
+#define PERF_COUNTER_START_VALUE 0xff000000
+#define PERF_EVENT_UP_DOWN_THRESHOLD 900000000ULL
+
 /**
  * struct dmc_opp_table - Operating level desciption
  *
@@ -85,6 +141,10 @@ struct exynos5_dmc {
 	struct clk *mout_mx_mspll_ccore_phy;
 	struct devfreq_event_dev **counter;
 	int num_counters;
+	u64 last_overflow_ts[2];
+	unsigned long load;
+	unsigned long total;
+	bool in_irq_mode;
 };
 
 #define TIMING_FIELD(t_name, t_bit_beg, t_bit_end) \
@@ -653,6 +713,173 @@ static int exynos5_counters_get(struct exynos5_dmc *dmc,
 	return 0;
 }
 
+/**
+ * exynos5_dmc_start_perf_events() - Setup and start performance event counters
+ * @dmc:	device for which the counters are going to be checked
+ * @beg_value:	initial value for the counter
+ *
+ * Function which enables needed counters, interrupts and sets initial values
+ * then starts the counters.
+ */
+static void exynos5_dmc_start_perf_events(struct exynos5_dmc *dmc,
+					  u32 beg_value)
+{
+	/* Enable interrupts for counter 2 */
+	writel(PERF_CNT2, dmc->base_drexi0 + DREX_INTENS_PPC);
+	writel(PERF_CNT2, dmc->base_drexi1 + DREX_INTENS_PPC);
+
+	/* Enable counter 2 and CCNT  */
+	writel(PERF_CNT2 | PERF_CCNT, dmc->base_drexi0 + DREX_CNTENS_PPC);
+	writel(PERF_CNT2 | PERF_CCNT, dmc->base_drexi1 + DREX_CNTENS_PPC);
+
+	/* Clear overflow flag for all counters */
+	writel(PERF_CNT2 | PERF_CCNT, dmc->base_drexi0 + DREX_FLAG_PPC);
+	writel(PERF_CNT2 | PERF_CCNT, dmc->base_drexi1 + DREX_FLAG_PPC);
+
+	/* Reset all counters */
+	writel(CC_RESET | PPC_COUNTER_RESET, dmc->base_drexi0 + DREX_PMNC_PPC);
+	writel(CC_RESET | PPC_COUNTER_RESET, dmc->base_drexi1 + DREX_PMNC_PPC);
+
+	/*
+	 * Set start value for the counters, the number of samples that
+	 * will be gathered is calculated as: 0xffffffff - beg_value
+	 */
+	writel(beg_value, dmc->base_drexi0 + DREX_PMCNT2_PPC);
+	writel(beg_value, dmc->base_drexi1 + DREX_PMCNT2_PPC);
+
+	/* Start all counters */
+	writel(PPC_ENABLE, dmc->base_drexi0 + DREX_PMNC_PPC);
+	writel(PPC_ENABLE, dmc->base_drexi1 + DREX_PMNC_PPC);
+}
+
+/**
+ * exynos5_dmc_perf_events_calc() - Calculate utilization
+ * @dmc:	device for which the counters are going to be checked
+ * @diff_ts:	time between last interrupt and current one
+ *
+ * Function which calculates needed utilization for the devfreq governor.
+ * It prepares values for 'busy_time' and 'total_time' based on elapsed time
+ * between interrupts, which approximates utilization.
+ */
+static void exynos5_dmc_perf_events_calc(struct exynos5_dmc *dmc, u64 diff_ts)
+{
+	/*
+	 * This is a simple algorithm for managing traffic on DMC.
+	 * When there is almost no load the counters overflow every 4s,
+	 * no mater the DMC frequency.
+	 * The high load might be approximated using linear function.
+	 * Knowing that, simple calculation can provide 'busy_time' and
+	 * 'total_time' to the devfreq governor which picks up target
+	 * frequency.
+	 * We want a fast ramp up and slow decay in frequency change function.
+	 */
+	if (diff_ts < PERF_EVENT_UP_DOWN_THRESHOLD) {
+		/*
+		 * Set higher utilization for the simple_ondemand governor.
+		 * The governor should increase the frequency of the DMC.
+		 */
+		dmc->load = 70;
+		dmc->total = 100;
+	} else {
+		/*
+		 * Set low utilization for the simple_ondemand governor.
+		 * The governor should decrease the frequency of the DMC.
+		 */
+		dmc->load = 35;
+		dmc->total = 100;
+	}
+
+	dev_dbg(dmc->dev, "diff_ts=%llu\n", diff_ts);
+}
+
+/**
+ * exynos5_dmc_perf_events_check() - Checks the status of the counters
+ * @dmc:	device for which the counters are going to be checked
+ *
+ * Function which is called from threaded IRQ to check the counters state
+ * and to call approximation for the needed utilization.
+ */
+static void exynos5_dmc_perf_events_check(struct exynos5_dmc *dmc)
+{
+	u32 val;
+	u64 diff_ts, ts;
+
+	ts = ktime_get_ns();
+
+	/* Stop all counters */
+	writel(0, dmc->base_drexi0 + DREX_PMNC_PPC);
+	writel(0, dmc->base_drexi1 + DREX_PMNC_PPC);
+
+	/* Check the source in interrupt flag registers (which channel) */
+	val = readl(dmc->base_drexi0 + DREX_FLAG_PPC);
+	if (val) {
+		diff_ts = ts - dmc->last_overflow_ts[0];
+		dmc->last_overflow_ts[0] = ts;
+		dev_dbg(dmc->dev, "drex0 0xE050 val= 0x%08x\n",  val);
+	} else {
+		val = readl(dmc->base_drexi1 + DREX_FLAG_PPC);
+		diff_ts = ts - dmc->last_overflow_ts[1];
+		dmc->last_overflow_ts[1] = ts;
+		dev_dbg(dmc->dev, "drex1 0xE050 val= 0x%08x\n",  val);
+	}
+
+	exynos5_dmc_perf_events_calc(dmc, diff_ts);
+
+	exynos5_dmc_start_perf_events(dmc, PERF_COUNTER_START_VALUE);
+}
+
+/**
+ * exynos5_dmc_enable_perf_events() - Enable performance events
+ * @dmc:	device for which the counters are going to be checked
+ *
+ * Function which is setup needed environment and enables counters.
+ */
+static void exynos5_dmc_enable_perf_events(struct exynos5_dmc *dmc)
+{
+	u64 ts;
+
+	/* Enable Performance Event Clock */
+	writel(PEREV_CLK_EN, dmc->base_drexi0 + DREX_PPCCLKCON);
+	writel(PEREV_CLK_EN, dmc->base_drexi1 + DREX_PPCCLKCON);
+
+	/* Select read transfers as performance event2 */
+	writel(READ_TRANSFER_CH0, dmc->base_drexi0 + DREX_PEREV2CONFIG);
+	writel(READ_TRANSFER_CH1, dmc->base_drexi1 + DREX_PEREV2CONFIG);
+
+	ts = ktime_get_ns();
+	dmc->last_overflow_ts[0] = ts;
+	dmc->last_overflow_ts[1] = ts;
+
+	/* Devfreq shouldn't be faster than initialization, play safe though. */
+	dmc->load = 99;
+	dmc->total = 100;
+}
+
+/**
+ * exynos5_dmc_disable_perf_events() - Disable performance events
+ * @dmc:	device for which the counters are going to be checked
+ *
+ * Function which stops, disables performance event counters and interrupts.
+ */
+static void exynos5_dmc_disable_perf_events(struct exynos5_dmc *dmc)
+{
+	/* Stop all counters */
+	writel(0, dmc->base_drexi0 + DREX_PMNC_PPC);
+	writel(0, dmc->base_drexi1 + DREX_PMNC_PPC);
+
+	/* Disable interrupts for counter 2 */
+	writel(PERF_CNT2, dmc->base_drexi0 + DREX_INTENC_PPC);
+	writel(PERF_CNT2, dmc->base_drexi1 + DREX_INTENC_PPC);
+
+	/* Disable counter 2 and CCNT  */
+	writel(PERF_CNT2 | PERF_CCNT, dmc->base_drexi0 + DREX_CNTENC_PPC);
+	writel(PERF_CNT2 | PERF_CCNT, dmc->base_drexi1 + DREX_CNTENC_PPC);
+
+	/* Clear overflow flag for all counters */
+	writel(PERF_CNT2 | PERF_CCNT, dmc->base_drexi0 + DREX_FLAG_PPC);
+	writel(PERF_CNT2 | PERF_CCNT, dmc->base_drexi1 + DREX_FLAG_PPC);
+}
+
 /**
  * exynos5_dmc_get_status() - Read current DMC performance statistics.
  * @dev:	device for which the statistics are requested
@@ -669,18 +896,24 @@ static int exynos5_dmc_get_status(struct device *dev,
 	unsigned long load, total;
 	int ret;
 
-	ret = exynos5_counters_get(dmc, &load, &total);
-	if (ret < 0)
-		return -EINVAL;
+	if (dmc->in_irq_mode) {
+		stat->current_frequency = dmc->curr_rate;
+		stat->busy_time = dmc->load;
+		stat->total_time = dmc->total;
+	} else {
+		ret = exynos5_counters_get(dmc, &load, &total);
+		if (ret < 0)
+			return -EINVAL;
 
-	/* To protect from overflow in calculation ratios, divide by 1024 */
-	stat->busy_time = load >> 10;
-	stat->total_time = total >> 10;
+		/* To protect from overflow, divide by 1024 */
+		stat->busy_time = load >> 10;
+		stat->total_time = total >> 10;
 
-	ret = exynos5_counters_set_event(dmc);
-	if (ret < 0) {
-		dev_err(dev, "could not set event counter\n");
-		return ret;
+		ret = exynos5_counters_set_event(dmc);
+		if (ret < 0) {
+			dev_err(dev, "could not set event counter\n");
+			return ret;
+		}
 	}
 
 	return 0;
@@ -712,7 +945,6 @@ static int exynos5_dmc_get_cur_freq(struct device *dev, unsigned long *freq)
  * It provides to the devfreq framework needed functions and polling period.
  */
 static struct devfreq_dev_profile exynos5_dmc_df_profile = {
-	.polling_ms = 500,
 	.target = exynos5_dmc_target,
 	.get_dev_status = exynos5_dmc_get_status,
 	.get_cur_freq = exynos5_dmc_get_cur_freq,
@@ -1108,6 +1340,24 @@ static inline int exynos5_dmc_set_pause_on_switching(struct exynos5_dmc *dmc)
 	return 0;
 }
 
+static irqreturn_t dmc_irq_thread(int irq, void *priv)
+{
+	int res;
+	struct exynos5_dmc *dmc = priv;
+
+	mutex_lock(&dmc->df->lock);
+
+	exynos5_dmc_perf_events_check(dmc);
+
+	res = update_devfreq(dmc->df);
+	if (res)
+		dev_warn(dmc->dev, "devfreq failed with %d\n", res);
+
+	mutex_unlock(&dmc->df->lock);
+
+	return IRQ_HANDLED;
+}
+
 /**
  * exynos5_dmc_probe() - Probe function for the DMC driver
  * @pdev:	platform device for which the driver is going to be initialized
@@ -1125,6 +1375,7 @@ static int exynos5_dmc_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct exynos5_dmc *dmc;
 	struct resource *res;
+	int irq[2];
 
 	dmc = devm_kzalloc(dev, sizeof(*dmc), GFP_KERNEL);
 	if (!dmc)
@@ -1172,24 +1423,59 @@ static int exynos5_dmc_probe(struct platform_device *pdev)
 		goto remove_clocks;
 	}
 
-	ret = exynos5_performance_counters_init(dmc);
+	ret = exynos5_dmc_set_pause_on_switching(dmc);
 	if (ret) {
-		dev_warn(dev, "couldn't probe performance counters\n");
+		dev_warn(dev, "couldn't get access to PAUSE register\n");
 		goto remove_clocks;
 	}
 
-	ret = exynos5_dmc_set_pause_on_switching(dmc);
-	if (ret) {
-		dev_warn(dev, "couldn't get access to PAUSE register\n");
-		goto err_devfreq_add;
+	/* There is two modes in which the driver works: polling or IRQ */
+	irq[0] = platform_get_irq_byname(pdev, "drex_0");
+	irq[1] = platform_get_irq_byname(pdev, "drex_1");
+	if (irq[0] > 0 && irq[1] > 0) {
+		ret = devm_request_threaded_irq(dev, irq[0], NULL,
+						dmc_irq_thread, IRQF_ONESHOT,
+						dev_name(dev), dmc);
+		if (ret) {
+			dev_err(dev, "couldn't grab IRQ\n");
+			goto remove_clocks;
+		}
+
+		ret = devm_request_threaded_irq(dev, irq[1], NULL,
+						dmc_irq_thread, IRQF_ONESHOT,
+						dev_name(dev), dmc);
+		if (ret) {
+			dev_err(dev, "couldn't grab IRQ\n");
+			goto remove_clocks;
+		}
+
+		/*
+		 * Setup default thresholds for the devfreq governor.
+		 * The values are chosen based on experiments.
+		 */
+		dmc->gov_data.upthreshold = 55;
+		dmc->gov_data.downdifferential = 5;
+
+		exynos5_dmc_enable_perf_events(dmc);
+
+		dmc->in_irq_mode = 1;
+	} else {
+		ret = exynos5_performance_counters_init(dmc);
+		if (ret) {
+			dev_warn(dev, "couldn't probe performance counters\n");
+			goto remove_clocks;
+		}
+
+		/*
+		 * Setup default thresholds for the devfreq governor.
+		 * The values are chosen based on experiments.
+		 */
+		dmc->gov_data.upthreshold = 30;
+		dmc->gov_data.downdifferential = 5;
+
+		exynos5_dmc_df_profile.polling_ms = 500;
 	}
 
-	/*
-	 * Setup default thresholds for the devfreq governor.
-	 * The values are chosen based on experiments.
-	 */
-	dmc->gov_data.upthreshold = 30;
-	dmc->gov_data.downdifferential = 5;
 
 	dmc->df = devm_devfreq_add_device(dev, &exynos5_dmc_df_profile,
 					  DEVFREQ_GOV_SIMPLE_ONDEMAND,
@@ -1200,12 +1486,18 @@ static int exynos5_dmc_probe(struct platform_device *pdev)
 		goto err_devfreq_add;
 	}
 
+	if (dmc->in_irq_mode)
+		exynos5_dmc_start_perf_events(dmc, PERF_COUNTER_START_VALUE);
+
 	dev_info(dev, "DMC initialized\n");
 
 	return 0;
 
 err_devfreq_add:
-	exynos5_counters_disable_edev(dmc);
+	if (dmc->in_irq_mode)
+		exynos5_dmc_disable_perf_events(dmc);
+	else
+		exynos5_counters_disable_edev(dmc);
 remove_clocks:
 	clk_disable_unprepare(dmc->mout_bpll);
 	clk_disable_unprepare(dmc->fout_bpll);
@@ -1225,7 +1517,10 @@ static int exynos5_dmc_remove(struct platform_device *pdev)
 {
 	struct exynos5_dmc *dmc = dev_get_drvdata(&pdev->dev);
 
-	exynos5_counters_disable_edev(dmc);
+	if (dmc->in_irq_mode)
+		exynos5_dmc_disable_perf_events(dmc);
+	else
+		exynos5_counters_disable_edev(dmc);
 
 	clk_disable_unprepare(dmc->mout_bpll);
 	clk_disable_unprepare(dmc->fout_bpll);
-- 
2.17.1

