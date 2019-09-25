Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A40CCBE248
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 18:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502028AbfIYQSs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 12:18:48 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59804 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502049AbfIYQSr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2019 12:18:47 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190925161845euoutp01a54512e92692e4933a22882e4f592bfe~Hur8XynSp0250602506euoutp01S
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2019 16:18:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190925161845euoutp01a54512e92692e4933a22882e4f592bfe~Hur8XynSp0250602506euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569428325;
        bh=fw1EEZnhFrtARqPwoUvNOiK/Zw4kSymDCjusQOhZI/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WDXwvOgYhqYk3BamBbwAnThx415IbRpCs/j+u8yEXXA24KZ+d0HbYpOhjRyPAigcK
         nKBUaIXR/XEFaDKSvKmQbsFnqaGqx83KPejbTC1ZVw849fCXkGrZ8L4jf3p/KEUDwh
         t2ICmUSsOQA3xZmVSotn5zOG+Mgk0HyaaSWkXLfw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190925161844eucas1p1f81126abe02cb811d2a6de0abfa4293e~Hur790lUH1838118381eucas1p1l;
        Wed, 25 Sep 2019 16:18:44 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 5B.CB.04374.4639B8D5; Wed, 25
        Sep 2019 17:18:44 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190925161844eucas1p2dc69a451c2d86fd7f4be2b33940f8d62~Hur7iIwul3066830668eucas1p2u;
        Wed, 25 Sep 2019 16:18:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190925161844eusmtrp29aef68e86729bbfa4e822aa7b8283749~Hur7hLudC0276502765eusmtrp2Q;
        Wed, 25 Sep 2019 16:18:44 +0000 (GMT)
X-AuditID: cbfec7f5-4ddff70000001116-19-5d8b9364063d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 65.0B.04117.4639B8D5; Wed, 25
        Sep 2019 17:18:44 +0100 (BST)
Received: from AMDC3778.digital.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190925161843eusmtip108b55dd3516a18883b1f690fae94a7ca~Hur6z2kWL0410704107eusmtip1q;
        Wed, 25 Sep 2019 16:18:43 +0000 (GMT)
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
Subject: [PATCH 3/3] memory: samsung: exynos5422-dmc: Add support for
 interrupt from performance counters
Date:   Wed, 25 Sep 2019 18:18:13 +0200
Message-Id: <20190925161813.21117-4-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190925161813.21117-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRj229k5O0qL4xT9UFEYiV1wFvbji6IsgobdjFJjYbXyMMXNy45a
        lpQKqXmtRmmjUktRpqUuXXOoTV1OjZomNTNN0R+m8wJpUiiV88z697zP5XteXj4SEzTjXmRs
        fDKtjJfKhYQLV9f9yxIYrcqP2jnf44saS+txZF2awlGZ6T2OiidtGLJYGnjoXdYsDw1n+CDt
        5CccDRoeEWix0ARQqaWdg56bRnmoyjrAQV8yawh0q83EQ12zOTha7pkAIa7iuid1QNyiHuWJ
        tZrbhPhl5U1xx3wrR1zUpAHiRa1vGE/isi+alsem0sqg/RddYgzTy0SiOeZq74deIgMMhecB
        ZxJSu6Ft2MzJAy6kgKoB0PimyjEsAVic08Jlh0UAp5vU2EakPWscY4VqAEs0VuxfpM82RuQB
        kiQoEdRrkuwBd+oZgMtdErsHo3QcOK5Zxu2CGxUHa6cLCTvmUv5wIbeLa8d86gBsX1Xz2DY/
        WNtgXG92pkLg97mW9f0g1ceDI72vAWs6DA3VKi6L3eCMuckR9oF/Wso4LGZgRmGFw58OJ4sf
        Ozx7YZd5ALcvjVHbYL0hiKUPQtNCM8dOQ2ozHJpztdPYGrynK8FYmg9zswWseytsKuh3FHnA
        6roHjsfFsFLV7ziiCsAp2wr3DvBT/y8rB0ADPOkURiGjmeB4+oqIkSqYlHiZ6HKCQgvWPtPb
        3+YfetC+eqkTUCQQbuIbI/KjBLg0lUlTdAJIYkJ3vtonL0rAj5amXaOVCReUKXKa6QTeJFfo
        yb/uNH5OQMmkyXQcTSfSyg2VQzp7ZQDFN5lNMmi9GzMaQJwQUfrU1r7k9CPhOVrjyYIZXVHb
        dIS300RUyX1JzlhP2Kkt1kbbykOvuuwgw+jH4EiPsx1ff1ZmFulDVfln4j5XHCuYiwwsOJ58
        utCv7OmegPOHRnRpSv8bO0JHRIHDr9LljeNJ3UmlAwtxR3t1L8ql7qF0uZDLxEh3bceUjPQv
        3mtVGkgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t/xu7opk7tjDT5/ZbXYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht7jVIGOx6fE1VovLu+awWXzuPcJoMeP8PiaLtUfuslss
        vX6RyeJ24wo2i9a9R9gtDr9pZ7X4duIRo4Ogx5p5axg9ds66y+6xaVUnm8fmJfUeB9/tYfLo
        27KK0ePzJrkA9ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy
        1CJ9uwS9jF0vv7EVHM+oOHnpJFsD443QLkZODgkBE4l9TQ+Yuxi5OIQEljJKzD30jxEiISYx
        ad92dghbWOLPtS42EFtI4BOjxIL/gl2MHBxsAnoSO1YVgvSKCCxnlDi26i3YIGaBI0wSR1df
        AxskLJApMX3/TRYQm0VAVeJ9x2Ewm1fAXmLfn1lQC+QlVm84wAxicwo4SHx6u5MJYpm9xPM1
        J5gmMPItYGRYxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERgp24793LKDsetd8CFGAQ5GJR5e
        icjuWCHWxLLiytxDjBIczEoivLNkumKFeFMSK6tSi/Lji0pzUosPMZoCHTWRWUo0OR8YxXkl
        8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhgPrpj4sGCVx4VzVx0v
        bV7U3PFKSzC28kn2uYxrscz8vs9XPbYpSflwwdO/zfmjtuOnFcdDlGyX/DO32CtgfS9R4qTi
        q+KC3n2cv0NFd/V8juJmkVSQ8pfbdP5n6eu6ZtkFc9cpGWvvX7BGcs6fW7fNg2befH5B+/je
        2Rcn/myZNt91z+xVK54WKLEUZyQaajEXFScCAFnPiMCqAgAA
X-CMS-MailID: 20190925161844eucas1p2dc69a451c2d86fd7f4be2b33940f8d62
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190925161844eucas1p2dc69a451c2d86fd7f4be2b33940f8d62
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190925161844eucas1p2dc69a451c2d86fd7f4be2b33940f8d62
References: <20190925161813.21117-1-l.luba@partner.samsung.com>
        <CGME20190925161844eucas1p2dc69a451c2d86fd7f4be2b33940f8d62@eucas1p2.samsung.com>
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
 drivers/memory/samsung/exynos5422-dmc.c | 297 ++++++++++++++++++++++--
 1 file changed, 272 insertions(+), 25 deletions(-)

diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index 0fe5f2186139..86e1844b97ef 100644
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
@@ -35,6 +36,29 @@
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
+#define CC_RESET		BIT(2)
+#define PPC_COUNTER_RESET	BIT(1)
+#define PPC_ENABLE		BIT(0)
+#define PEREV_CLK_EN		BIT(0)
+#define PERF_CNT2		BIT(2)
+#define PERF_CCNT		BIT(31)
+
+#define READ_TRANSFER_CH0	(0x6d)
+#define READ_TRANSFER_CH1	(0x6f)
+
+#define PERF_COUNTER_START_VALUE 0xff000000
+#define PERF_EVENT_UP_DOWN_THRESHOLD 900000000ULL
+
 /**
  * struct dmc_opp_table - Operating level desciption
  *
@@ -85,6 +109,9 @@ struct exynos5_dmc {
 	struct clk *mout_mx_mspll_ccore_phy;
 	struct devfreq_event_dev **counter;
 	int num_counters;
+	u64 last_overflow_ts[2];
+	unsigned long load, total;
+	bool in_irq_mode;
 };
 
 #define TIMING_FIELD(t_name, t_bit_beg, t_bit_end) \
@@ -653,6 +680,167 @@ static int exynos5_counters_get(struct exynos5_dmc *dmc,
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
+	/* Enable counter 2 and CCNT  */
+	writel(PERF_CNT2 | PERF_CCNT, dmc->base_drexi0 + DREX_CNTENS_PPC);
+	writel(PERF_CNT2 | PERF_CCNT, dmc->base_drexi1 + DREX_CNTENS_PPC);
+	/* Clear overflow flag for all counters */
+	writel(PERF_CNT2 | PERF_CCNT, dmc->base_drexi0 + DREX_FLAG_PPC);
+	writel(PERF_CNT2 | PERF_CCNT, dmc->base_drexi1 + DREX_FLAG_PPC);
+	/* Reset all counters */
+	writel(CC_RESET | PPC_COUNTER_RESET, dmc->base_drexi0 + DREX_PMNC_PPC);
+	writel(CC_RESET | PPC_COUNTER_RESET, dmc->base_drexi1 + DREX_PMNC_PPC);
+	/*
+	 * Set start value for the counters, the number of samples that
+	 * will be gathered is calculated as: 0xffffffff - beg_value
+	 */
+	writel(beg_value, dmc->base_drexi0 + DREX_PMCNT2_PPC);
+	writel(beg_value, dmc->base_drexi1 + DREX_PMCNT2_PPC);
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
+	dmc->in_irq_mode = 1;
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
+	/* Disable interrupts for counter 2 */
+	writel(PERF_CNT2, dmc->base_drexi0 + DREX_INTENC_PPC);
+	writel(PERF_CNT2, dmc->base_drexi1 + DREX_INTENC_PPC);
+	/* Disable counter 2 and CCNT  */
+	writel(PERF_CNT2 | PERF_CCNT, dmc->base_drexi0 + DREX_CNTENC_PPC);
+	writel(PERF_CNT2 | PERF_CCNT, dmc->base_drexi1 + DREX_CNTENC_PPC);
+	/* Clear overflow flag for all counters */
+	writel(PERF_CNT2 | PERF_CCNT, dmc->base_drexi0 + DREX_FLAG_PPC);
+	writel(PERF_CNT2 | PERF_CCNT, dmc->base_drexi1 + DREX_FLAG_PPC);
+}
+
 /**
  * exynos5_dmc_get_status() - Read current DMC performance statistics.
  * @dev:	device for which the statistics are requested
@@ -669,18 +857,24 @@ static int exynos5_dmc_get_status(struct device *dev,
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
@@ -712,7 +906,6 @@ static int exynos5_dmc_get_cur_freq(struct device *dev, unsigned long *freq)
  * It provides to the devfreq framework needed functions and polling period.
  */
 static struct devfreq_dev_profile exynos5_dmc_df_profile = {
-	.polling_ms = 500,
 	.target = exynos5_dmc_target,
 	.get_dev_status = exynos5_dmc_get_status,
 	.get_cur_freq = exynos5_dmc_get_cur_freq,
@@ -1108,6 +1301,26 @@ static inline int exynos5_dmc_set_pause_on_switching(struct exynos5_dmc *dmc)
 	return 0;
 }
 
+static irqreturn_t dmc_irq_thread(int irq, void *priv)
+{
+	int res;
+	struct exynos5_dmc *dmc = priv;
+
+	dev_dbg(dmc->dev, "irq thread handler\n");
+
+	mutex_lock(&dmc->df->lock);
+
+	exynos5_dmc_perf_events_check(dmc);
+
+	res = update_devfreq(dmc->df);
+	if (res)
+		dev_err(dmc->dev, "devfreq failed with %d\n", res);
+
+	mutex_unlock(&dmc->df->lock);
+
+	return IRQ_HANDLED;
+}
+
 /**
  * exynos5_dmc_probe() - Probe function for the DMC driver
  * @pdev:	platform device for which the driver is going to be initialized
@@ -1125,6 +1338,7 @@ static int exynos5_dmc_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct exynos5_dmc *dmc;
 	struct resource *res;
+	int irq;
 
 	dmc = devm_kzalloc(dev, sizeof(*dmc), GFP_KERNEL);
 	if (!dmc)
@@ -1172,24 +1386,48 @@ static int exynos5_dmc_probe(struct platform_device *pdev)
 		goto remove_clocks;
 	}
 
-	ret = exynos5_performance_counters_init(dmc);
-	if (ret) {
-		dev_warn(dev, "couldn't probe performance counters\n");
-		goto remove_clocks;
-	}
-
 	ret = exynos5_dmc_set_pause_on_switching(dmc);
 	if (ret) {
 		dev_warn(dev, "couldn't get access to PAUSE register\n");
 		goto err_devfreq_add;
 	}
 
-	/*
-	 * Setup default thresholds for the devfreq governor.
-	 * The values are chosen based on experiments.
-	 */
-	dmc->gov_data.upthreshold = 30;
-	dmc->gov_data.downdifferential = 5;
+	/* There is two modes in which the driver works: polling or IRQ */
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
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
+	} else {
+		ret = devm_request_threaded_irq(dev, irq, NULL,
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
+	}
+
 
 	dmc->df = devm_devfreq_add_device(dev, &exynos5_dmc_df_profile,
 					  DEVFREQ_GOV_SIMPLE_ONDEMAND,
@@ -1200,12 +1438,18 @@ static int exynos5_dmc_probe(struct platform_device *pdev)
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
@@ -1225,7 +1469,10 @@ static int exynos5_dmc_remove(struct platform_device *pdev)
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

