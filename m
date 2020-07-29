Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D0D23214B
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 17:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgG2PMa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 11:12:30 -0400
Received: from foss.arm.com ([217.140.110.172]:53404 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbgG2PM0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Jul 2020 11:12:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C20DC30E;
        Wed, 29 Jul 2020 08:12:25 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.37.12.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 99BD63F66E;
        Wed, 29 Jul 2020 08:12:23 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com,
        viresh.kumar@linaro.org, lukasz.luba@arm.com, rjw@rjwysocki.net
Subject: [PATCH 2/4] scmi: perf: Extend protocol to support performance statistics
Date:   Wed, 29 Jul 2020 16:12:06 +0100
Message-Id: <20200729151208.27737-3-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729151208.27737-1-lukasz.luba@arm.com>
References: <20200729151208.27737-1-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The firmware is able to maintain performance statistics and share with OS
via shared memory. The memory region can be interpreted by the SCMI perf
protocol after receiving and mapping the proper addresses from FW.
This patch aims to provide needed infrastructure and setup necessary
mechanisms in the protocol layer.

It also extends API functions for the upper layer (cpufreq, devfreq)
with a new callback, which allows to retrieve the statistics for a
particular performance domain. The new structure scmi_perf_domain_stats
added in the header works as a glue for these two layers.

The data processing code for the shared memory is aligned with SCMI v2
specification (DEN0056B) and handles the required endianness. It can
be changed in future not disturbing the upper layer.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/firmware/arm_scmi/perf.c | 210 +++++++++++++++++++++++++++++++
 include/linux/scmi_protocol.h    |  11 ++
 2 files changed, 221 insertions(+)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 3e1e87012c95..761067bb6237 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -19,6 +19,9 @@
 #include "common.h"
 #include "notify.h"
 
+#define PERF_DOMAIN_STATS_OFFSETS_BASE		0x10
+#define PERF_DOMAIN_COUNT_BASE			0x8
+
 enum scmi_performance_protocol_cmd {
 	PERF_DOMAIN_ATTRIBUTES = 0x3,
 	PERF_DESCRIBE_LEVELS = 0x4,
@@ -32,11 +35,27 @@ enum scmi_performance_protocol_cmd {
 };
 
 struct scmi_opp {
+	u32 id;
 	u32 perf;
 	u32 power;
 	u32 trans_latency_us;
 };
 
+struct scmi_perf_level_raw_stats {
+	__le32 perf_level_id;
+	__le32 reserved;
+	__le64 usage_count;
+	__le64 total_residency_us;
+};
+
+struct scmi_perf_domain_raw_stats {
+	__le16 perf_level_count;
+	__le16 curr_perf_level_id;
+	__le32 extended_stats_offset;
+	__le64 ts_last_change_us;
+	struct scmi_perf_level_raw_stats perf_level[];
+};
+
 struct scmi_msg_resp_perf_attributes {
 	__le16 num_domains;
 	__le16 flags;
@@ -161,13 +180,26 @@ struct perf_dom_info {
 	struct scmi_fc_info *fc_info;
 };
 
+struct scmi_perf_domain_stats_desc {
+	void __iomem *addr;
+	int *opp_map;
+	int size;
+};
+
+struct scmi_perf_stats_desc {
+	uint16_t domain_count;
+	struct scmi_perf_domain_stats_desc *domain_stats;
+};
+
 struct scmi_perf_info {
 	u32 version;
 	int num_domains;
 	bool power_scale_mw;
 	u64 stats_addr;
 	u32 stats_size;
+	void __iomem *stats_virt_addr;
 	struct perf_dom_info *dom_info;
+	struct scmi_perf_stats_desc *stats_desc;
 };
 
 static enum scmi_performance_protocol_cmd evt_2_cmd[] = {
@@ -175,6 +207,55 @@ static enum scmi_performance_protocol_cmd evt_2_cmd[] = {
 	PERF_NOTIFY_LEVEL,
 };
 
+static int scmi_perf_stats_init(const struct scmi_handle *handle,
+				struct scmi_perf_info *pi)
+{
+	struct scmi_perf_domain_stats_desc *domain_stats;
+	int i, domain_count;
+	__le32 offset;
+
+	domain_count = le16_to_cpu(ioread16(pi->stats_virt_addr +
+					    PERF_DOMAIN_COUNT_BASE));
+
+	pi->stats_desc = devm_kzalloc(handle->dev,
+				      sizeof(struct scmi_perf_stats_desc),
+				      GFP_KERNEL);
+	if (!pi->stats_desc)
+		return -ENOMEM;
+
+	pi->stats_desc->domain_stats = devm_kzalloc(handle->dev, domain_count *
+				sizeof(struct scmi_perf_domain_stats_desc),
+				GFP_KERNEL);
+	if (!pi->stats_desc->domain_stats)
+		return -ENOMEM;
+
+	pi->stats_desc->domain_count = domain_count;
+
+	for (i = 0; i < domain_count; i++) {
+		int stats_size;
+		__le16 opp_count;
+
+		offset = ioread32(pi->stats_virt_addr +
+				PERF_DOMAIN_STATS_OFFSETS_BASE + i * 4);
+		if (!offset)
+			continue;
+
+		domain_stats = &pi->stats_desc->domain_stats[i];
+
+		domain_stats->addr = pi->stats_virt_addr + le32_to_cpu(offset);
+
+		/* The first field is the performance level count. */
+		opp_count = le16_to_cpu(ioread16(domain_stats->addr));
+		stats_size = sizeof(struct scmi_perf_domain_raw_stats);
+		stats_size += sizeof(struct scmi_perf_level_raw_stats) *
+				opp_count;
+
+		domain_stats->size = stats_size;
+	}
+
+	return 0;
+}
+
 static int scmi_perf_attributes_get(const struct scmi_handle *handle,
 				    struct scmi_perf_info *pi)
 {
@@ -198,6 +279,14 @@ static int scmi_perf_attributes_get(const struct scmi_handle *handle,
 		pi->stats_addr = le32_to_cpu(attr->stats_addr_low) |
 				(u64)le32_to_cpu(attr->stats_addr_high) << 32;
 		pi->stats_size = le32_to_cpu(attr->stats_size);
+		if (pi->stats_addr && pi->stats_size) {
+			pi->stats_virt_addr = devm_ioremap(handle->dev,
+					pi->stats_addr, pi->stats_size);
+			if (pi->stats_virt_addr)
+				ret = scmi_perf_stats_init(handle, pi);
+			else
+				ret = -ENOMEM;
+		}
 	}
 
 	scmi_xfer_put(handle, t);
@@ -298,6 +387,7 @@ scmi_perf_describe_levels_get(const struct scmi_handle *handle, u32 domain,
 			opp->power = le32_to_cpu(level_info->opp[cnt].power);
 			opp->trans_latency_us = le16_to_cpu
 				(level_info->opp[cnt].transition_latency_us);
+			opp->id = tot_opp_cnt + cnt;
 
 			dev_dbg(handle->dev, "Level %d Power %d Latency %dus\n",
 				opp->perf, opp->power, opp->trans_latency_us);
@@ -748,6 +838,125 @@ static bool scmi_fast_switch_possible(const struct scmi_handle *handle,
 	return dom->fc_info && dom->fc_info->level_set_addr;
 }
 
+static int scmi_dvfs_setup_opps_mapping(const struct scmi_handle *handle,
+					u32 domain_id)
+{
+	struct scmi_perf_domain_stats_desc *domain_stats;
+	struct scmi_perf_info *pi = handle->perf_priv;
+	struct perf_dom_info *dom;
+	struct scmi_opp *opp;
+	int idx, *mapping;
+
+	dom = pi->dom_info + domain_id;
+	if (!dom)
+		return -EIO;
+
+	mapping = devm_kzalloc(handle->dev, sizeof(int) * dom->opp_count,
+			       GFP_KERNEL);
+	if (!mapping)
+		return -ENOMEM;
+
+	/* Construct LUT with FW OPP ids as an index */
+	for (opp = dom->opp, idx = 0; idx < dom->opp_count; idx++, opp++)
+		mapping[opp->id] = idx;
+
+	domain_stats = &pi->stats_desc->domain_stats[domain_id];
+	domain_stats->opp_map = mapping;
+
+	return 0;
+}
+
+static int
+scmi_dvfs_stats_get(const struct scmi_handle *handle, u32 domain_id,
+		    struct scmi_perf_domain_stats *stats)
+{
+	struct scmi_perf_domain_stats_desc *domain_stats;
+	struct scmi_perf_domain_raw_stats *raw_stats[2];
+	struct scmi_perf_info *pi = handle->perf_priv;
+	struct scmi_perf_level_raw_stats *perf;
+	int i, index, ret = -EINVAL;
+	struct perf_dom_info *dom;
+	u64 transition_count = 0;
+	struct scmi_opp *opp;
+
+	if (!stats)
+		return -EINVAL;
+
+	if (!pi->stats_virt_addr || !pi->stats_desc ||
+		!pi->stats_desc->domain_stats)
+		return -ENOENT;
+
+	if (pi->stats_desc->domain_count <= domain_id ||
+		!pi->stats_desc->domain_stats[domain_id].addr)
+		return -ENOENT;
+
+	dom = pi->dom_info + domain_id;
+	if (!dom)
+		return -EIO;
+
+	domain_stats = &pi->stats_desc->domain_stats[domain_id];
+
+	if (!domain_stats->opp_map) {
+		ret = scmi_dvfs_setup_opps_mapping(handle, domain_id);
+		if (ret)
+			return ret;
+	}
+
+	raw_stats[0] = vmalloc(domain_stats->size);
+	if (!raw_stats[0])
+		return -ENOMEM;
+
+	raw_stats[1] = vmalloc(domain_stats->size);
+	if (!raw_stats[1]) {
+		vfree(raw_stats[0]);
+		return -ENOMEM;
+	}
+
+	/*
+	 * Let's try 10 times. If two consecutive reads are the same - done.
+	 * This approach is aligned with SCMI v2 specification.
+	 */
+	for (i = 0; i < 10; i++) {
+		memcpy_fromio(raw_stats[0], domain_stats->addr,
+			      domain_stats->size);
+		memcpy_fromio(raw_stats[1], domain_stats->addr,
+			      domain_stats->size);
+		if (!memcmp(raw_stats[0], raw_stats[1], domain_stats->size)) {
+			ret = 0;
+			break;
+		}
+	}
+
+	if (ret)
+		goto free_buf;
+
+	for (i = 0; i < dom->opp_count; i++) {
+		perf = &raw_stats[0]->perf_level[i];
+
+		transition_count += __le64_to_cpu(perf->usage_count);
+		stats->time_in_state[i] =
+				__le64_to_cpu(perf->total_residency_us);
+
+		/* Speed-up and initialize the frequencies only once. */
+		if (stats->freq_table[i] == 0) {
+			index = domain_stats->opp_map[i];
+			opp = &dom->opp[index];
+			stats->freq_table[i] = opp->perf * dom->mult_factor;
+		}
+	}
+
+	stats->total_trans = transition_count;
+
+	stats->last_index = __le16_to_cpu(raw_stats[0]->curr_perf_level_id);
+	stats->last_time = __le64_to_cpu(raw_stats[0]->ts_last_change_us);
+
+free_buf:
+	vfree(raw_stats[1]);
+	vfree(raw_stats[0]);
+
+	return ret;
+}
+
 static struct scmi_perf_ops perf_ops = {
 	.limits_set = scmi_perf_limits_set,
 	.limits_get = scmi_perf_limits_get,
@@ -760,6 +969,7 @@ static struct scmi_perf_ops perf_ops = {
 	.freq_get = scmi_dvfs_freq_get,
 	.est_power_get = scmi_dvfs_est_power_get,
 	.fast_switch_possible = scmi_fast_switch_possible,
+	.statistics_get = scmi_dvfs_stats_get,
 };
 
 static int scmi_perf_set_notify_enabled(const struct scmi_handle *handle,
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 7e5dd7d1e221..3316ff4f9d34 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -55,6 +55,15 @@ struct scmi_clock_info {
 	};
 };
 
+struct scmi_perf_domain_stats {
+	unsigned long long last_time;
+	unsigned long long last_index;
+	unsigned int total_trans;
+	unsigned int state_num;
+	u64 *time_in_state;
+	unsigned int *freq_table;
+};
+
 struct scmi_handle;
 
 /**
@@ -121,6 +130,8 @@ struct scmi_perf_ops {
 			     unsigned long *rate, unsigned long *power);
 	bool (*fast_switch_possible)(const struct scmi_handle *handle,
 				     struct device *dev);
+	int (*statistics_get)(const struct scmi_handle *handle, u32 domain_id,
+			      struct scmi_perf_domain_stats *stats);
 };
 
 /**
-- 
2.17.1

