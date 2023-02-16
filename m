Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B3C6991A0
	for <lists+linux-pm@lfdr.de>; Thu, 16 Feb 2023 11:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjBPKhZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Feb 2023 05:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjBPKhH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Feb 2023 05:37:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED92C552A4
        for <linux-pm@vger.kernel.org>; Thu, 16 Feb 2023 02:36:48 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pSbcs-0003dB-21; Thu, 16 Feb 2023 11:36:30 +0100
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1pSbcp-005Kmq-0l; Thu, 16 Feb 2023 11:36:28 +0100
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1pSbco-002Wih-5E; Thu, 16 Feb 2023 11:36:26 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v3 15/19] PM / devfreq: rockchip-dfi: Add perf support
Date:   Thu, 16 Feb 2023 11:36:20 +0100
Message-Id: <20230216103624.591901-16-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230216103624.591901-1-s.hauer@pengutronix.de>
References: <20230216103624.591901-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The DFI is a unit which is suitable for measuring DDR utilization, but
so far it could only be used as an event driver for the DDR frequency
scaling driver. This adds perf support to the DFI driver.

Usage with the 'perf' tool can look like:

perf stat -a -e rockchip_ddr/cycles/,\
		rockchip_ddr/read-bytes/,\
		rockchip_ddr/write-bytes/,\
		rockchip_ddr/bytes/ sleep 1

 Performance counter stats for 'system wide':

        1582524826      rockchip_ddr/cycles/
           1802.25 MB   rockchip_ddr/read-bytes/
           1793.72 MB   rockchip_ddr/write-bytes/
           3595.90 MB   rockchip_ddr/bytes/

       1.014369709 seconds time elapsed

perf support has been tested on a RK3568 and a RK3399, the latter with
dual channel DDR.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/devfreq/event/rockchip-dfi.c | 349 +++++++++++++++++++++++++++
 include/soc/rockchip/rk3399_grf.h    |   2 +
 include/soc/rockchip/rk3568_grf.h    |   1 +
 3 files changed, 352 insertions(+)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index eae010644935a..400b1b360e3c9 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -20,6 +20,7 @@
 #include <linux/of_device.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/perf_event.h>
 
 #include <soc/rockchip/rockchip_grf.h>
 #include <soc/rockchip/rk3399_grf.h>
@@ -41,14 +42,30 @@
 					 DDRMON_CTRL_LPDDR4 | \
 					 DDRMON_CTRL_LPDDR23)
 
+#define DDRMON_CH0_WR_NUM		0x20
+#define DDRMON_CH0_RD_NUM		0x24
 #define DDRMON_CH0_COUNT_NUM		0x28
 #define DDRMON_CH0_DFI_ACCESS_NUM	0x2c
 #define DDRMON_CH1_COUNT_NUM		0x3c
 #define DDRMON_CH1_DFI_ACCESS_NUM	0x40
 
+enum access_type {
+	PERF_EVENT_CYCLES,
+	PERF_EVENT_READ_BYTES,
+	PERF_EVENT_WRITE_BYTES,
+	PERF_EVENT_BYTES,
+	PERF_ACCESS_TYPE_MAX,
+};
+
 struct dmc_count_channel {
 	u32 access;
 	u32 total;
+	u32 read_access;
+	u32 write_access;
+};
+
+struct dmc_count_channel64 {
+	u64 count[PERF_ACCESS_TYPE_MAX];
 };
 
 struct dmc_count {
@@ -65,6 +82,7 @@ struct rockchip_dfi {
 	struct devfreq_event_desc desc;
 	struct dmc_count count;
 	struct dmc_count last_event_count;
+	struct dmc_count last;
 	struct device *dev;
 	void __iomem *regs;
 	struct regmap *regmap_pmu;
@@ -73,6 +91,15 @@ struct rockchip_dfi {
 	struct mutex mutex;
 	u32 ddr_type;
 	unsigned int channel_mask;
+	enum cpuhp_state cpuhp_state;
+	struct hlist_node node;
+	struct pmu pmu;
+	struct hrtimer timer;
+	unsigned int cpu;
+	struct dmc_count_channel64 frr;
+	int active_events;
+	int burst_len;
+	int buswidth[DMC_MAX_CHANNELS];
 };
 
 static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
@@ -148,6 +175,10 @@ static void rockchip_dfi_read_counters(struct rockchip_dfi *dfi, struct dmc_coun
 	for (i = 0; i < DMC_MAX_CHANNELS; i++) {
 		if (!(dfi->channel_mask & BIT(i)))
 			continue;
+		count->c[i].read_access = readl_relaxed(dfi_regs +
+				DDRMON_CH0_RD_NUM + i * 20);
+		count->c[i].write_access = readl_relaxed(dfi_regs +
+				DDRMON_CH0_WR_NUM + i * 20);
 		count->c[i].access = readl_relaxed(dfi_regs +
 				DDRMON_CH0_DFI_ACCESS_NUM + i * 20);
 		count->c[i].total = readl_relaxed(dfi_regs +
@@ -218,6 +249,305 @@ static const struct devfreq_event_ops rockchip_dfi_ops = {
 	.set_event = rockchip_dfi_set_event,
 };
 
+#ifdef CONFIG_PERF_EVENTS
+
+static ssize_t ddr_perf_cpumask_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct pmu *pmu = dev_get_drvdata(dev);
+	struct rockchip_dfi *dfi = container_of(pmu, struct rockchip_dfi, pmu);
+
+	return cpumap_print_to_pagebuf(true, buf, cpumask_of(dfi->cpu));
+}
+
+static struct device_attribute ddr_perf_cpumask_attr =
+	__ATTR(cpumask, 0444, ddr_perf_cpumask_show, NULL);
+
+static struct attribute *ddr_perf_cpumask_attrs[] = {
+	&ddr_perf_cpumask_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ddr_perf_cpumask_attr_group = {
+	.attrs = ddr_perf_cpumask_attrs,
+};
+
+PMU_EVENT_ATTR_STRING(cycles, ddr_pmu_cycles, "event=0x00")
+
+PMU_EVENT_ATTR_STRING(read-bytes, ddr_pmu_read_bytes, "event=0x01")
+PMU_EVENT_ATTR_STRING(read-bytes.unit, ddr_pmu_read_bytes_unit, "MB");
+PMU_EVENT_ATTR_STRING(read-bytes.scale, ddr_pmu_read_bytes_scale, "9.536743164e-07");
+
+PMU_EVENT_ATTR_STRING(write-bytes, ddr_pmu_write_bytes, "event=0x02")
+PMU_EVENT_ATTR_STRING(write-bytes.unit, ddr_pmu_write_bytes_unit, "MB");
+PMU_EVENT_ATTR_STRING(write-bytes.scale, ddr_pmu_write_bytes_scale, "9.536743164e-07");
+
+PMU_EVENT_ATTR_STRING(bytes, ddr_pmu_bytes, "event=0x03")
+PMU_EVENT_ATTR_STRING(bytes.unit, ddr_pmu_bytes_unit, "MB");
+PMU_EVENT_ATTR_STRING(bytes.scale, ddr_pmu_bytes_scale, "9.536743164e-07");
+
+static struct attribute *ddr_perf_events_attrs[] = {
+	&ddr_pmu_cycles.attr.attr,
+	&ddr_pmu_read_bytes.attr.attr,
+	&ddr_pmu_read_bytes_unit.attr.attr,
+	&ddr_pmu_read_bytes_scale.attr.attr,
+	&ddr_pmu_write_bytes.attr.attr,
+	&ddr_pmu_write_bytes_unit.attr.attr,
+	&ddr_pmu_write_bytes_scale.attr.attr,
+	&ddr_pmu_bytes.attr.attr,
+	&ddr_pmu_bytes_unit.attr.attr,
+	&ddr_pmu_bytes_scale.attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ddr_perf_events_attr_group = {
+	.name = "events",
+	.attrs = ddr_perf_events_attrs,
+};
+
+PMU_FORMAT_ATTR(event, "config:0-7");
+
+static struct attribute *ddr_perf_format_attrs[] = {
+	&format_attr_event.attr,
+	NULL,
+};
+
+static const struct attribute_group ddr_perf_format_attr_group = {
+	.name = "format",
+	.attrs = ddr_perf_format_attrs,
+};
+
+static const struct attribute_group *attr_groups[] = {
+	&ddr_perf_events_attr_group,
+	&ddr_perf_cpumask_attr_group,
+	&ddr_perf_format_attr_group,
+	NULL,
+};
+
+static int rockchip_ddr_perf_event_init(struct perf_event *event)
+{
+	struct rockchip_dfi *dfi = container_of(event->pmu, struct rockchip_dfi, pmu);
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	if (event->attach_state & PERF_ATTACH_TASK)
+		return -EOPNOTSUPP;
+
+	if (event->cpu < 0) {
+		dev_warn(dfi->dev, "Can't provide per-task data!\n");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static void rockchip_ddr_perf_update_counters(struct rockchip_dfi *dfi)
+{
+	struct dmc_count count;
+	struct dmc_count *last = &dfi->last;
+	int blen = dfi->burst_len;
+	u32 diff;
+	int i;
+
+	rockchip_dfi_read_counters(dfi, &count);
+
+	diff = count.c[0].total - last->c[0].total;
+	dfi->frr.count[PERF_EVENT_CYCLES] += diff;
+
+	for (i = 0; i < DMC_MAX_CHANNELS; i++) {
+		if (!(dfi->channel_mask & BIT(i)))
+			continue;
+
+		diff = count.c[i].read_access - last->c[i].read_access;
+		dfi->frr.count[PERF_EVENT_READ_BYTES] += (u64)diff * blen * dfi->buswidth[i];
+
+		diff = count.c[i].write_access - last->c[i].write_access;
+		dfi->frr.count[PERF_EVENT_WRITE_BYTES] += (u64)diff * blen * dfi->buswidth[i];
+
+		diff = count.c[i].access - last->c[i].access;
+		dfi->frr.count[PERF_EVENT_BYTES] += (u64)diff * blen * dfi->buswidth[i];
+	}
+
+	dfi->last = count;
+}
+
+static void rockchip_ddr_perf_event_update(struct perf_event *event)
+{
+	struct rockchip_dfi *dfi = container_of(event->pmu, struct rockchip_dfi, pmu);
+	s64 prev;
+	u64 now;
+
+	rockchip_ddr_perf_update_counters(dfi);
+
+	now = dfi->frr.count[event->attr.config];
+	prev = local64_xchg(&event->hw.prev_count, now);
+	local64_add(now - prev, &event->count);
+}
+
+static void rockchip_ddr_perf_event_start(struct perf_event *event, int flags)
+{
+	struct rockchip_dfi *dfi = container_of(event->pmu, struct rockchip_dfi, pmu);
+
+	rockchip_ddr_perf_update_counters(dfi);
+
+	local64_set(&event->hw.prev_count, dfi->frr.count[event->attr.config]);
+}
+
+static int rockchip_ddr_perf_event_add(struct perf_event *event, int flags)
+{
+	struct rockchip_dfi *dfi = container_of(event->pmu, struct rockchip_dfi, pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	hwc->state |= PERF_HES_STOPPED;
+
+	dfi->active_events++;
+
+	if (dfi->active_events == 1) {
+		rockchip_dfi_enable(dfi);
+		hrtimer_start(&dfi->timer, 0, HRTIMER_MODE_REL);
+	}
+
+	if (flags & PERF_EF_START)
+		rockchip_ddr_perf_event_start(event, flags);
+
+	return 0;
+}
+
+static void rockchip_ddr_perf_event_stop(struct perf_event *event, int flags)
+{
+	rockchip_ddr_perf_event_update(event);
+}
+
+static void rockchip_ddr_perf_event_del(struct perf_event *event, int flags)
+{
+	struct rockchip_dfi *dfi = container_of(event->pmu, struct rockchip_dfi, pmu);
+
+	rockchip_ddr_perf_event_stop(event, PERF_EF_UPDATE);
+
+	dfi->active_events--;
+
+	if (dfi->active_events == 0) {
+		hrtimer_cancel(&dfi->timer);
+		rockchip_dfi_disable(dfi);
+	}
+}
+
+static enum hrtimer_restart rockchip_dfi_timer(struct hrtimer *timer)
+{
+	struct rockchip_dfi *dfi = container_of(timer, struct rockchip_dfi, timer);
+	ktime_t timeout;
+
+	rockchip_ddr_perf_update_counters(dfi);
+
+	timeout = ns_to_ktime(NSEC_PER_SEC);
+	hrtimer_forward_now(&dfi->timer, timeout);
+
+	return HRTIMER_RESTART;
+};
+
+static int ddr_perf_offline_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct rockchip_dfi *dfi = hlist_entry_safe(node, struct rockchip_dfi, node);
+	int target;
+
+	if (cpu != dfi->cpu)
+		return 0;
+
+	target = cpumask_any_but(cpu_online_mask, cpu);
+	if (target >= nr_cpu_ids)
+		return 0;
+
+	perf_pmu_migrate_context(&dfi->pmu, cpu, target);
+	dfi->cpu = target;
+
+	return 0;
+}
+
+static int rockchip_ddr_perf_init(struct rockchip_dfi *dfi)
+{
+	struct pmu *pmu = &dfi->pmu;
+	int ret;
+
+	pmu->module = THIS_MODULE;
+	pmu->capabilities = PERF_PMU_CAP_NO_EXCLUDE;
+	pmu->task_ctx_nr = perf_invalid_context;
+	pmu->attr_groups = attr_groups;
+	pmu->event_init  = rockchip_ddr_perf_event_init;
+	pmu->add = rockchip_ddr_perf_event_add;
+	pmu->del = rockchip_ddr_perf_event_del;
+	pmu->start = rockchip_ddr_perf_event_start;
+	pmu->stop = rockchip_ddr_perf_event_stop;
+	pmu->read = rockchip_ddr_perf_event_update;
+
+	dfi->cpu = raw_smp_processor_id();
+
+	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
+				      "rockchip_ddr_perf_pmu",
+				      NULL,
+				      ddr_perf_offline_cpu);
+
+	if (ret < 0) {
+		dev_err(dfi->dev, "cpuhp_setup_state_multi failed: %d\n", ret);
+		return ret;
+	}
+
+	dfi->cpuhp_state = ret;
+
+	/* Register the pmu instance for cpu hotplug */
+	ret = cpuhp_state_add_instance_nocalls(dfi->cpuhp_state, &dfi->node);
+	if (ret) {
+		dev_err(dfi->dev, "Error %d registering hotplug\n", ret);
+		goto cpuhp_instance_err;
+	}
+
+	hrtimer_init(&dfi->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	dfi->timer.function = rockchip_dfi_timer;
+
+	switch (dfi->ddr_type) {
+	case ROCKCHIP_DDRTYPE_LPDDR2:
+	case ROCKCHIP_DDRTYPE_LPDDR3:
+		dfi->burst_len = 8;
+		break;
+	case ROCKCHIP_DDRTYPE_LPDDR4:
+	case ROCKCHIP_DDRTYPE_LPDDR4X:
+		dfi->burst_len = 16;
+		break;
+	}
+
+	ret = perf_pmu_register(pmu, "rockchip_ddr", -1);
+	if (ret)
+		goto ddr_perf_err;
+
+	return 0;
+
+ddr_perf_err:
+	cpuhp_state_remove_instance_nocalls(dfi->cpuhp_state, &dfi->node);
+cpuhp_instance_err:
+	cpuhp_remove_multi_state(dfi->cpuhp_state);
+
+	return ret;
+}
+
+static void rockchip_ddr_perf_remove(struct rockchip_dfi *dfi)
+{
+	cpuhp_state_remove_instance_nocalls(dfi->cpuhp_state, &dfi->node);
+	cpuhp_remove_multi_state(dfi->cpuhp_state);
+
+	perf_pmu_unregister(&dfi->pmu);
+}
+
+#else
+static int rockchip_ddr_perf_init(struct rockchip_dfi *dfi)
+{
+	return 0;
+}
+
+static void rockchip_ddr_perf_remove(struct rockchip_dfi *dfi)
+{
+}
+#endif
+
 static int rk3399_dfi_init(struct rockchip_dfi *dfi)
 {
 	struct regmap *regmap_pmu = dfi->regmap_pmu;
@@ -234,6 +564,9 @@ static int rk3399_dfi_init(struct rockchip_dfi *dfi)
 
 	dfi->channel_mask = 3;
 
+	dfi->buswidth[0] = FIELD_GET(RK3399_PMUGRF_OS_REG2_BW_CH0, val) == 0 ? 4 : 2;
+	dfi->buswidth[1] = FIELD_GET(RK3399_PMUGRF_OS_REG2_BW_CH1, val) == 0 ? 4 : 2;
+
 	return 0;
 };
 
@@ -250,6 +583,8 @@ static int rk3568_dfi_init(struct rockchip_dfi *dfi)
 	if (FIELD_GET(RK3568_PMUGRF_OS_REG3_SYSREG_VERSION, reg3) >= 0x3)
 		dfi->ddr_type |= FIELD_GET(RK3568_PMUGRF_OS_REG3_DRAMTYPE_INFO_V3, reg3) << 3;
 
+	dfi->buswidth[0] = FIELD_GET(RK3568_PMUGRF_OS_REG2_BW_CH0, reg2) == 0 ? 4 : 2;
+
 	dfi->channel_mask = 1;
 
 	return 0;
@@ -325,13 +660,27 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
 		return PTR_ERR(dfi->edev);
 	}
 
+	ret = rockchip_ddr_perf_init(dfi);
+	if (ret)
+		return ret;
+
 	platform_set_drvdata(pdev, dfi);
 
 	return 0;
 }
 
+static int rockchip_dfi_remove(struct platform_device *pdev)
+{
+	struct rockchip_dfi *dfi = platform_get_drvdata(pdev);
+
+	rockchip_ddr_perf_remove(dfi);
+
+	return 0;
+}
+
 static struct platform_driver rockchip_dfi_driver = {
 	.probe	= rockchip_dfi_probe,
+	.remove	= rockchip_dfi_remove,
 	.driver = {
 		.name	= "rockchip-dfi",
 		.of_match_table = rockchip_dfi_id_match,
diff --git a/include/soc/rockchip/rk3399_grf.h b/include/soc/rockchip/rk3399_grf.h
index 775f8444bea8d..39cd44cec982f 100644
--- a/include/soc/rockchip/rk3399_grf.h
+++ b/include/soc/rockchip/rk3399_grf.h
@@ -12,5 +12,7 @@
 /* PMU GRF Registers */
 #define RK3399_PMUGRF_OS_REG2		0x308
 #define RK3399_PMUGRF_OS_REG2_DDRTYPE		GENMASK(15, 13)
+#define RK3399_PMUGRF_OS_REG2_BW_CH0		GENMASK(3, 2)
+#define RK3399_PMUGRF_OS_REG2_BW_CH1		GENMASK(19, 18)
 
 #endif
diff --git a/include/soc/rockchip/rk3568_grf.h b/include/soc/rockchip/rk3568_grf.h
index 575584e9d8834..52853efd6720e 100644
--- a/include/soc/rockchip/rk3568_grf.h
+++ b/include/soc/rockchip/rk3568_grf.h
@@ -4,6 +4,7 @@
 
 #define RK3568_PMUGRF_OS_REG2		0x208
 #define RK3568_PMUGRF_OS_REG2_DRAMTYPE_INFO		GENMASK(15, 13)
+#define RK3568_PMUGRF_OS_REG2_BW_CH0			GENMASK(3, 2)
 
 #define RK3568_PMUGRF_OS_REG3		0x20c
 #define RK3568_PMUGRF_OS_REG3_DRAMTYPE_INFO_V3		GENMASK(13, 12)
-- 
2.30.2

