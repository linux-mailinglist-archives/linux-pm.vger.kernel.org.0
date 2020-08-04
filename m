Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0414F23B96F
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 13:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgHDLMs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Aug 2020 07:12:48 -0400
Received: from foss.arm.com ([217.140.110.172]:42702 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728556AbgHDLLe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 Aug 2020 07:11:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F71E30E;
        Tue,  4 Aug 2020 04:10:17 -0700 (PDT)
Received: from [10.37.12.45] (unknown [10.37.12.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 588413F6CF;
        Tue,  4 Aug 2020 04:10:15 -0700 (PDT)
Subject: Re: [PATCH 2/4] scmi: perf: Extend protocol to support performance
 statistics
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, sudeep.holla@arm.com,
        viresh.kumar@linaro.org, rjw@rjwysocki.net
References: <20200729151208.27737-1-lukasz.luba@arm.com>
 <20200729151208.27737-3-lukasz.luba@arm.com>
 <20200731151557.GA19880@e119603-lin.cambridge.arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <00188f1b-e11d-df19-728b-4797cfe74c92@arm.com>
Date:   Tue, 4 Aug 2020 12:10:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200731151557.GA19880@e119603-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Cristian,

On 7/31/20 4:15 PM, Cristian Marussi wrote:
> Hi
> 
> On Wed, Jul 29, 2020 at 04:12:06PM +0100, Lukasz Luba wrote:
>> The firmware is able to maintain performance statistics and share with OS
>> via shared memory. The memory region can be interpreted by the SCMI perf
>> protocol after receiving and mapping the proper addresses from FW.
>> This patch aims to provide needed infrastructure and setup necessary
>> mechanisms in the protocol layer.
>>
>> It also extends API functions for the upper layer (cpufreq, devfreq)
>> with a new callback, which allows to retrieve the statistics for a
>> particular performance domain. The new structure scmi_perf_domain_stats
>> added in the header works as a glue for these two layers.
>>
>> The data processing code for the shared memory is aligned with SCMI v2
>> specification (DEN0056B) and handles the required endianness. It can
>> be changed in future not disturbing the upper layer.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/firmware/arm_scmi/perf.c | 210 +++++++++++++++++++++++++++++++
>>   include/linux/scmi_protocol.h    |  11 ++
>>   2 files changed, 221 insertions(+)
>>
>> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
>> index 3e1e87012c95..761067bb6237 100644
>> --- a/drivers/firmware/arm_scmi/perf.c
>> +++ b/drivers/firmware/arm_scmi/perf.c
>> @@ -19,6 +19,9 @@
>>   #include "common.h"
>>   #include "notify.h"
>>   
>> +#define PERF_DOMAIN_STATS_OFFSETS_BASE		0x10
>> +#define PERF_DOMAIN_COUNT_BASE			0x8
>> +
>>   enum scmi_performance_protocol_cmd {
>>   	PERF_DOMAIN_ATTRIBUTES = 0x3,
>>   	PERF_DESCRIBE_LEVELS = 0x4,
>> @@ -32,11 +35,27 @@ enum scmi_performance_protocol_cmd {
>>   };
>>   
>>   struct scmi_opp {
>> +	u32 id;
>>   	u32 perf;
>>   	u32 power;
>>   	u32 trans_latency_us;
>>   };
>>   
>> +struct scmi_perf_level_raw_stats {
>> +	__le32 perf_level_id;
>> +	__le32 reserved;
>> +	__le64 usage_count;
>> +	__le64 total_residency_us;
>> +};
>> +
>> +struct scmi_perf_domain_raw_stats {
>> +	__le16 perf_level_count;
>> +	__le16 curr_perf_level_id;
>> +	__le32 extended_stats_offset;
>> +	__le64 ts_last_change_us;
>> +	struct scmi_perf_level_raw_stats perf_level[];
>> +};
>> +
>>   struct scmi_msg_resp_perf_attributes {
>>   	__le16 num_domains;
>>   	__le16 flags;
>> @@ -161,13 +180,26 @@ struct perf_dom_info {
>>   	struct scmi_fc_info *fc_info;
>>   };
>>   
>> +struct scmi_perf_domain_stats_desc {
>> +	void __iomem *addr;
>> +	int *opp_map;
>> +	int size;
>> +};
>> +
>> +struct scmi_perf_stats_desc {
>> +	uint16_t domain_count;
>> +	struct scmi_perf_domain_stats_desc *domain_stats;
>> +};
>> +
>>   struct scmi_perf_info {
>>   	u32 version;
>>   	int num_domains;
>>   	bool power_scale_mw;
>>   	u64 stats_addr;
>>   	u32 stats_size;
>> +	void __iomem *stats_virt_addr;
>>   	struct perf_dom_info *dom_info;
>> +	struct scmi_perf_stats_desc *stats_desc;
>>   };
>>   
>>   static enum scmi_performance_protocol_cmd evt_2_cmd[] = {
>> @@ -175,6 +207,55 @@ static enum scmi_performance_protocol_cmd evt_2_cmd[] = {
>>   	PERF_NOTIFY_LEVEL,
>>   };
>>   
>> +static int scmi_perf_stats_init(const struct scmi_handle *handle,
>> +				struct scmi_perf_info *pi)
>> +{
>> +	struct scmi_perf_domain_stats_desc *domain_stats;
>> +	int i, domain_count;
>> +	__le32 offset;
>> +
> 
> LGTM by I'd add also the check for the Signature field first of all, to rule
> out misconfigured/misaligned memory when integrating with fw.
> Regarding revision and attributes, they are just zero and, as of now, not exposed
> to upper layers but I'm wondering if we should not parse and expose them too already
> to be future proof (since future SCMIv3 is near really and it will change this mechanism
> and bump revision field.)

Make sense, I will add that revision check.

> 
>> +	domain_count = le16_to_cpu(ioread16(pi->stats_virt_addr +
>> +					    PERF_DOMAIN_COUNT_BASE));
>> +
> 
> Would be worth to check this against pinfo->num_domains ? (real question)
> I suppose that if the platform limits the visible domains to this agent
> it should be consistent between stats and messages.

Good point. The value above should be less or equal to the previously
returned pi->num_domain. But if the firmware has a bug, then that could
explode. I will change it, and compare with the 'pi->num_domains'.


> 
>> +	pi->stats_desc = devm_kzalloc(handle->dev,
>> +				      sizeof(struct scmi_perf_stats_desc),
>> +				      GFP_KERNEL);
>> +	if (!pi->stats_desc)
>> +		return -ENOMEM;
>> +
>> +	pi->stats_desc->domain_stats = devm_kzalloc(handle->dev, domain_count *
>> +				sizeof(struct scmi_perf_domain_stats_desc),
> 
> nit: ... sizeof(*domain_stats) ?

yes

> 
>> +				GFP_KERNEL);
>> +	if (!pi->stats_desc->domain_stats)
>> +		return -ENOMEM;
>> +
>> +	pi->stats_desc->domain_count = domain_count;
>> +
>> +	for (i = 0; i < domain_count; i++) {
>> +		int stats_size;
>> +		__le16 opp_count;
>> +
>> +		offset = ioread32(pi->stats_virt_addr +
>> +				PERF_DOMAIN_STATS_OFFSETS_BASE + i * 4);
>> +		if (!offset)
>> +			continue;
>> +
>> +		domain_stats = &pi->stats_desc->domain_stats[i];
>> +
>> +		domain_stats->addr = pi->stats_virt_addr + le32_to_cpu(offset);
>> +
>> +		/* The first field is the performance level count. */
>> +		opp_count = le16_to_cpu(ioread16(domain_stats->addr));
>> +		stats_size = sizeof(struct scmi_perf_domain_raw_stats);
>> +		stats_size += sizeof(struct scmi_perf_level_raw_stats) *
>> +				opp_count;
>> +
>> +		domain_stats->size = stats_size;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static int scmi_perf_attributes_get(const struct scmi_handle *handle,
>>   				    struct scmi_perf_info *pi)
>>   {
>> @@ -198,6 +279,14 @@ static int scmi_perf_attributes_get(const struct scmi_handle *handle,
>>   		pi->stats_addr = le32_to_cpu(attr->stats_addr_low) |
>>   				(u64)le32_to_cpu(attr->stats_addr_high) << 32;
>>   		pi->stats_size = le32_to_cpu(attr->stats_size);
>> +		if (pi->stats_addr && pi->stats_size) {
>> +			pi->stats_virt_addr = devm_ioremap(handle->dev,
>> +					pi->stats_addr, pi->stats_size);
>> +			if (pi->stats_virt_addr)
>> +				ret = scmi_perf_stats_init(handle, pi);
>> +			else
>> +				ret = -ENOMEM;
>> +		}
>>   	}
>>   
>>   	scmi_xfer_put(handle, t);
>> @@ -298,6 +387,7 @@ scmi_perf_describe_levels_get(const struct scmi_handle *handle, u32 domain,
>>   			opp->power = le32_to_cpu(level_info->opp[cnt].power);
>>   			opp->trans_latency_us = le16_to_cpu
>>   				(level_info->opp[cnt].transition_latency_us);
>> +			opp->id = tot_opp_cnt + cnt;
>>   
>>   			dev_dbg(handle->dev, "Level %d Power %d Latency %dus\n",
>>   				opp->perf, opp->power, opp->trans_latency_us);
>> @@ -748,6 +838,125 @@ static bool scmi_fast_switch_possible(const struct scmi_handle *handle,
>>   	return dom->fc_info && dom->fc_info->level_set_addr;
>>   }
>>   
>> +static int scmi_dvfs_setup_opps_mapping(const struct scmi_handle *handle,
>> +					u32 domain_id)
>> +{
>> +	struct scmi_perf_domain_stats_desc *domain_stats;
>> +	struct scmi_perf_info *pi = handle->perf_priv;
>> +	struct perf_dom_info *dom;
>> +	struct scmi_opp *opp;
>> +	int idx, *mapping;
>> +
>> +	dom = pi->dom_info + domain_id;
>> +	if (!dom)
>> +		return -EIO;
> This is a bit scary without something like dom < pi->num_domains :D

That make sense in case of FW bug described above.

> 
>> +
>> +	mapping = devm_kzalloc(handle->dev, sizeof(int) * dom->opp_count,
>> +			       GFP_KERNEL);
>> +	if (!mapping)
>> +		return -ENOMEM;
>> +
>> +	/* Construct LUT with FW OPP ids as an index */
>> +	for (opp = dom->opp, idx = 0; idx < dom->opp_count; idx++, opp++)
>> +		mapping[opp->id] = idx;
>> +
>> +	domain_stats = &pi->stats_desc->domain_stats[domain_id];
>> +	domain_stats->opp_map = mapping;
>> +
>> +	return 0;
>> +}
>> +
>> +static int
>> +scmi_dvfs_stats_get(const struct scmi_handle *handle, u32 domain_id,
>> +		    struct scmi_perf_domain_stats *stats)
>> +{
>> +	struct scmi_perf_domain_stats_desc *domain_stats;
>> +	struct scmi_perf_domain_raw_stats *raw_stats[2];
>> +	struct scmi_perf_info *pi = handle->perf_priv;
>> +	struct scmi_perf_level_raw_stats *perf;
>> +	int i, index, ret = -EINVAL;
>> +	struct perf_dom_info *dom;
>> +	u64 transition_count = 0;
>> +	struct scmi_opp *opp;
>> +
>> +	if (!stats)
>> +		return -EINVAL;
>> +
>> +	if (!pi->stats_virt_addr || !pi->stats_desc ||
>> +		!pi->stats_desc->domain_stats)
>> +		return -ENOENT;
>> +
>> +	if (pi->stats_desc->domain_count <= domain_id ||
>> +		!pi->stats_desc->domain_stats[domain_id].addr)
>> +		return -ENOENT;
>> +
>> +	dom = pi->dom_info + domain_id;
> 
> same ....scary without something like dom < pi->num_domains, even more
> because this comes from the handle->statisticts_get() straight away

Same here. I will rewrite that bit with more safe checks.

> 
>> +	if (!dom)
>> +		return -EIO;
>> +
>> +	domain_stats = &pi->stats_desc->domain_stats[domain_id];
>> +
>> +	if (!domain_stats->opp_map) {
>> +		ret = scmi_dvfs_setup_opps_mapping(handle, domain_id);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	raw_stats[0] = vmalloc(domain_stats->size);
>> +	if (!raw_stats[0])
>> +		return -ENOMEM;
>> +
>> +	raw_stats[1] = vmalloc(domain_stats->size);
>> +	if (!raw_stats[1]) {
>> +		vfree(raw_stats[0]);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	/*
>> +	 * Let's try 10 times. If two consecutive reads are the same - done.
>> +	 * This approach is aligned with SCMI v2 specification.
>> +	 */
>> +	for (i = 0; i < 10; i++) {
>> +		memcpy_fromio(raw_stats[0], domain_stats->addr,
>> +			      domain_stats->size);
>> +		memcpy_fromio(raw_stats[1], domain_stats->addr,
>> +			      domain_stats->size);
>> +		if (!memcmp(raw_stats[0], raw_stats[1], domain_stats->size)) {
>> +			ret = 0;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (ret)
>> +		goto free_buf;
>> +
>> +	for (i = 0; i < dom->opp_count; i++) {
>> +		perf = &raw_stats[0]->perf_level[i];
>> +
>> +		transition_count += __le64_to_cpu(perf->usage_count);
>> +		stats->time_in_state[i] =
>> +				__le64_to_cpu(perf->total_residency_us);
>> +
>> +		/* Speed-up and initialize the frequencies only once. */
>> +		if (stats->freq_table[i] == 0) {
>> +			index = domain_stats->opp_map[i];
>> +			opp = &dom->opp[index];
>> +			stats->freq_table[i] = opp->perf * dom->mult_factor;
>> +		}
>> +	}
>> +
>> +	stats->total_trans = transition_count;
>> +
>> +	stats->last_index = __le16_to_cpu(raw_stats[0]->curr_perf_level_id);
>> +	stats->last_time = __le64_to_cpu(raw_stats[0]->ts_last_change_us);
>> +
>> +free_buf:
>> +	vfree(raw_stats[1]);
>> +	vfree(raw_stats[0]);
>> +
>> +	return ret;
>> +}
>> +
>>   static struct scmi_perf_ops perf_ops = {
>>   	.limits_set = scmi_perf_limits_set,
>>   	.limits_get = scmi_perf_limits_get,
>> @@ -760,6 +969,7 @@ static struct scmi_perf_ops perf_ops = {
>>   	.freq_get = scmi_dvfs_freq_get,
>>   	.est_power_get = scmi_dvfs_est_power_get,
>>   	.fast_switch_possible = scmi_fast_switch_possible,
>> +	.statistics_get = scmi_dvfs_stats_get,
>>   };
>>   
>>   static int scmi_perf_set_notify_enabled(const struct scmi_handle *handle,
>> diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
>> index 7e5dd7d1e221..3316ff4f9d34 100644
>> --- a/include/linux/scmi_protocol.h
>> +++ b/include/linux/scmi_protocol.h
>> @@ -55,6 +55,15 @@ struct scmi_clock_info {
>>   	};
>>   };
>>   
>> +struct scmi_perf_domain_stats {
>> +	unsigned long long last_time;
>> +	unsigned long long last_index;
>> +	unsigned int total_trans;
>> +	unsigned int state_num;
>> +	u64 *time_in_state;
> 
> ...got some recent negative feedback on mixing fixed-size fileds like u64 with
> generic like unsigned long/int etc...so maybe unsigned long long is better here
> since it is big enough; being this a time you could use ktime_t in other scenarios
> BUT I suppose here derives from the nice 64bit microseconds fields in shared mem
> stats so unsigned long long seems more clear (and ktime_t is signed and nanoseconds).

I followed the structure cpufreq_stats, which has these fields, but I
agree with you unsigned long long looks better here. I will change it.


Thank you for the review.

Regards,
Lukasz
