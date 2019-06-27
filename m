Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F23157C2A
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 08:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfF0G1k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 02:27:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41292 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfF0G1j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 02:27:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E38E4607B9; Thu, 27 Jun 2019 06:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561616858;
        bh=Cf2dAn18T6Mta3dGa1udRELSbbFTQR0q093lyI5gGNY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Mz2j4iofbcP0YOKDVHPzcsi8AY5TdtxjJ9KejibCjxnp6zY8yn//alJLJbUHe2ilt
         tEyKSmuYGWIn7jzUibXFlPy4MEtcb9nYRIgrhytb7gL6MqDeoqQ8MNJTUs02vj1jlv
         wWlEUtOFo8vM+3GcLcQwhs0NlX46loYzEWkt9D+w=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.79.43.230] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9DB4B607B9;
        Thu, 27 Jun 2019 06:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561616853;
        bh=Cf2dAn18T6Mta3dGa1udRELSbbFTQR0q093lyI5gGNY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FxOx9GYsWHNMzoYZ9ZeMl6lG0Z5pktSLVN6qB69EDkusS81MwF4azkkE/vHpNHt1B
         vMQUFgrnkG22WXPkf1YKZMiTBLLQbj+LapEyObaSO0oVu5tkmRJJC02V18kvghaZ8O
         g3VWfJKb190IdouBF/nbZ8dru2bAJsuf7dxX4biE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9DB4B607B9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH v2 3/5] OPP: Add support for parsing the interconnect
 bandwidth
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
Cc:     vireshk@kernel.org, sboyd@kernel.org, nm@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net,
        jcrouse@codeaurora.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20190423132823.7915-1-georgi.djakov@linaro.org>
 <20190423132823.7915-4-georgi.djakov@linaro.org>
 <20190424055208.kermzymve2foguhl@vireshk-i7>
From:   Sibi Sankar <sibis@codeaurora.org>
Message-ID: <f2d1f0bc-c785-abe1-34ad-efdf25c3b8a8@codeaurora.org>
Date:   Thu, 27 Jun 2019 11:57:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424055208.kermzymve2foguhl@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Georgi,

In addition to Viresh's comments I found a few more while testing the
series on SDM845.

On 4/24/19 11:22 AM, Viresh Kumar wrote:
> On 23-04-19, 16:28, Georgi Djakov wrote:
>> The OPP bindings now support bandwidth values, so add support to parse it
>> from device tree and store it into the new dev_pm_opp_icc_bw struct, which
>> is part of the dev_pm_opp.
>>
>> Also add and export the dev_pm_opp_set_paths() and dev_pm_opp_put_paths()
>> helpers, to set (and release) an interconnect paths to a device. The
>> bandwidth of these paths will be updated when the OPPs are switched.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>   drivers/opp/core.c     |  87 ++++++++++++++++++++++++++++++++++-
>>   drivers/opp/of.c       | 102 +++++++++++++++++++++++++++++++++++++++++
>>   drivers/opp/opp.h      |   9 ++++
>>   include/linux/pm_opp.h |  14 ++++++
>>   4 files changed, 210 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>> index 0420f7e8ad5b..97ee39ecdebd 100644
>> --- a/drivers/opp/core.c
>> +++ b/drivers/opp/core.c
>> @@ -19,6 +19,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/device.h>
>>   #include <linux/export.h>
>> +#include <linux/interconnect.h>
> 
> Just include this once in opp.h and the other .c files won't need it.
> 
>>   #include <linux/pm_domain.h>
>>   #include <linux/regulator/consumer.h>
>>   
>> @@ -876,6 +877,8 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
>>   				ret);
>>   	}
>>   
>> +	_of_find_paths(opp_table, dev);
>> +
>>   	BLOCKING_INIT_NOTIFIER_HEAD(&opp_table->head);
>>   	INIT_LIST_HEAD(&opp_table->opp_list);
>>   	kref_init(&opp_table->kref);
>> @@ -1129,11 +1132,12 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_remove_all_dynamic);
>>   struct dev_pm_opp *_opp_allocate(struct opp_table *table)
>>   {
>>   	struct dev_pm_opp *opp;
>> -	int count, supply_size;
>> +	int count, supply_size, icc_size;
>>   
>>   	/* Allocate space for at least one supply */
>>   	count = table->regulator_count > 0 ? table->regulator_count : 1;
>>   	supply_size = sizeof(*opp->supplies) * count;
>> +	icc_size = sizeof(*opp->bandwidth) * table->path_count;
>>   
>>   	/* allocate new OPP node and supplies structures */
>>   	opp = kzalloc(sizeof(*opp) + supply_size, GFP_KERNEL);
> 
> You never updated this to include icc_size :(
> 
>> @@ -1141,7 +1145,8 @@ struct dev_pm_opp *_opp_allocate(struct opp_table *table)
>>   		return NULL;
>>   
>>   	/* Put the supplies at the end of the OPP structure as an empty array */
>> -	opp->supplies = (struct dev_pm_opp_supply *)(opp + 1);
>> +	opp->bandwidth = (struct dev_pm_opp_icc_bw *)(opp + 1);
> 
> Keep the order as supplies and then bandwidth.
> 
>> +	opp->supplies = (struct dev_pm_opp_supply *)(opp + icc_size + 1);

opp->supplies = (struct dev_pm_opp_supply *)(opp + 1);
opp->bandwidth = (struct dev_pm_opp_icc_bw *)(opp->supplies + 1);

> 
> Did you check what address gets assigned here ? I think the pointer
> addition will screw things up for you.
> 
>>   	INIT_LIST_HEAD(&opp->node);
>>   
>>   	return opp;
>> @@ -1637,6 +1642,84 @@ void dev_pm_opp_put_clkname(struct opp_table *opp_table)
>>   }
>>   EXPORT_SYMBOL_GPL(dev_pm_opp_put_clkname);
>>   
>> +/**
>> + * dev_pm_opp_set_paths() - Set interconnect path for a device
>> + * @dev: Device for which interconnect path is being set.
>> + *
>> + * This must be called before any OPPs are initialized for the device.
>> + */
>> +struct opp_table *dev_pm_opp_set_paths(struct device *dev)
> 
> I got a bit confused. Why is this routine required exactly as
> _of_find_paths() would have already done something similar ?
> 
>> +{
>> +	struct opp_table *opp_table;
>> +	int ret, i;
>> +
>> +	opp_table = dev_pm_opp_get_opp_table(dev);
>> +	if (!opp_table)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	/* This should be called before OPPs are initialized */
>> +	if (WARN_ON(!list_empty(&opp_table->opp_list))) {
>> +		ret = -EBUSY;
>> +		goto err;
>> +	}
>> +
>> +	/* Another CPU that shares the OPP table has set the path */
>> +	if (opp_table->paths)
>> +		return opp_table;
>> + >> +	opp_table->paths = kmalloc_array(opp_table->path_count,

of_find_paths might have failed so you would want to
re-calculate opp_table->path_count.

>> +					 sizeof(*opp_table->paths), GFP_KERNEL);
>> +
>> +	/* Find interconnect path(s) for the device */
>> +	for (i = 0; i < opp_table->path_count; i++) {
>> +		opp_table->paths[i] = of_icc_get_by_index(dev, i);
>> +		if (IS_ERR(opp_table->paths[i])) {
>> +			ret = PTR_ERR(opp_table->paths[i]);
>> +			if (ret != -EPROBE_DEFER)
>> +				dev_err(dev, "%s: Couldn't find path%d: %d\n",
>> +					__func__, i, ret);

we should clean up by call icc_put on the paths that succeeded
and free/set the opp_table->paths to NULL.

>> +			goto err;
>> +		}
>> +	}
>> +
>> +	return opp_table;
>> +
>> +err:
>> +	dev_pm_opp_put_opp_table(opp_table);
>> +
>> +	return ERR_PTR(ret);
>> +}
>> +EXPORT_SYMBOL_GPL(dev_pm_opp_set_paths);
>> +
>> +/**
>> + * dev_pm_opp_put_paths() - Release interconnect path resources
>> + * @opp_table: OPP table returned from dev_pm_opp_set_paths().
>> + */
>> +void dev_pm_opp_put_paths(struct opp_table *opp_table)
>> +{
>> +	int i;
>> +
>> +	if (!opp_table->paths) {
>> +		pr_err("%s: Doesn't have paths set\n", __func__);
>> +		return;
>> +	}
>> +
>> +	/* Make sure there are no concurrent readers while updating opp_table */
>> +	WARN_ON(!list_empty(&opp_table->opp_list));
>> +
>> +	for (i = opp_table->path_count - 1; i >= 0; i--)
>> +		icc_put(opp_table->paths[i]);
>> +
>> +	_free_set_opp_data(opp_table);
>> +
>> +	kfree(opp_table->paths);
>> +	opp_table->paths = NULL;
>> +	opp_table->path_count = 0;
>> +
>> +	dev_pm_opp_put_opp_table(opp_table);
>> +}
>> +EXPORT_SYMBOL_GPL(dev_pm_opp_put_paths);
>> +
>>   /**
>>    * dev_pm_opp_register_set_opp_helper() - Register custom set OPP helper
>>    * @dev: Device for which the helper is getting registered.
>> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
>> index c10c782d15aa..00af23280bc6 100644
>> --- a/drivers/opp/of.c
>> +++ b/drivers/opp/of.c
>> @@ -16,6 +16,7 @@
>>   #include <linux/cpu.h>
>>   #include <linux/errno.h>
>>   #include <linux/device.h>
>> +#include <linux/interconnect.h>
>>   #include <linux/of_device.h>
>>   #include <linux/pm_domain.h>
>>   #include <linux/slab.h>
>> @@ -363,6 +364,45 @@ static int _of_opp_alloc_required_opps(struct opp_table *opp_table,
>>   	return ret;
>>   }
>>   
>> +int _of_find_paths(struct opp_table *opp_table, struct device *dev)
>> +{
>> +	struct device_node *np;
>> +	int ret, i, count, num_paths;
>> +
>> +	np = of_node_get(dev->of_node);
>> +	if (np) {
> 
> I would rather do:
> 
>          if (!np)
>                  return 0;
> 
> That will kill unnecessary line breaks and indentation.
> 
>> +		count = of_count_phandle_with_args(np, "interconnects",
>> +						   "#interconnect-cells");

count will be an error code if interconnect property is missing
so we need to account for that as well.

> 
> You can do of_node_put() right here as it isn't used afterwards.
> 
>> +		if (count % 2) {
> 
> Shouldn't this be 4 instead of 2 ? Each path is represented as:
> 
> <&noc MASTER_CPU &noc SLAVE_DDR>
> 
> which has 4 fields.
> 
>> +			dev_err(dev, "%s: Invalid interconnects values\n",
>> +				__func__);
>> +			ret = -EINVAL;
>> +			goto put_of_node;
>> +		}
>> +
>> +		num_paths = count / 2;
>> +		opp_table->paths = kcalloc(num_paths, sizeof(*opp_table->paths),
>> +					   GFP_KERNEL);
>> +		if (!opp_table->paths) {
>> +			ret = -ENOMEM;
>> +			goto put_of_node;
>> +		}
>> +
>> +		for (i = 0; i < num_paths; i++)
>> +			opp_table->paths[i] = of_icc_get_by_index(dev, i);

we should clean up by call icc_put on the paths that succeeded
and free/set the opp_table->paths to NULL.

>> +
>> +		opp_table->path_count = num_paths;
>> +		of_node_put(np);
>> +	}
>> +
>> +	return 0;
>> +
>> +put_of_node:
>> +	of_node_put(np);
>> +
>> +	return ret;
>> +}
>> +
>>   static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
>>   			      struct device_node *np)
>>   {
>> @@ -539,6 +579,64 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
>>   	return ret;
>>   }
>>   
>> +static int opp_parse_icc_bw(struct dev_pm_opp *opp, struct device *dev,
>> +			    struct opp_table *opp_table)
>> +{
>> +	struct property *prop = NULL;
>> +	u32 *bandwidth;
>> +	char name[] = "bandwidth-MBps";
>> +	int count, i, j, ret;
>> +
>> +	/* Search for "bandwidth-MBps" */
>> +	prop = of_find_property(opp->np, name, NULL);
>> +
>> +	/* Missing property is not a problem */
>> +	if (!prop) {
>> +		dev_dbg(dev, "%s: Missing %s property\n", __func__, name);
>> +		return 0;
>> +	}
>> +
>> +	if (!prop->value) {
>> +		dev_dbg(dev, "%s: Missing %s value\n", __func__, name);
>> +		return -ENODATA;
>> +	}
>> +
>> +	/*
>> +	 * Bandwidth consists of average and peak values like:
>> +	 * bandwidth-MBps = <avg-MBps peak-MBps>
>> +	 */
>> +	count = prop->length / sizeof(u32);
>> +	if (count % 2) {
>> +		dev_err(dev, "%s: Invalid %s values\n", __func__, name);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (opp_table->path_count != count / 2) {
>> +		dev_err(dev, "%s Mismatch between values and paths (%d %d)\n",
>> +			__func__, opp_table->path_count, count / 2);
>> +		return -EINVAL;
>> +	}
>> +
>> +	bandwidth = kmalloc_array(count, sizeof(*bandwidth), GFP_KERNEL);
>> +	if (!bandwidth)
>> +		return -ENOMEM;
>> +
>> +	ret = of_property_read_u32_array(opp->np, name, bandwidth, count);
>> +	if (ret) {
>> +		dev_err(dev, "%s: Error parsing %s: %d\n", __func__, name, ret);
>> +		goto free_bandwidth;
>> +	}
>> +	for (i = 0, j = 0; i < count; i++) {
>> +		opp->bandwidth[i].avg = MBps_to_icc(bandwidth[j++]);
>> +		opp->bandwidth[i].peak = MBps_to_icc(bandwidth[j++]);
>> +	}
>> +
>> +free_bandwidth:
>> +	kfree(bandwidth);
>> +
>> +	return ret;
>> +}
>> +
>>   /**
>>    * dev_pm_opp_of_remove_table() - Free OPP table entries created from static DT
>>    *				  entries
>> @@ -635,6 +733,10 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>>   	if (opp_table->is_genpd)
>>   		new_opp->pstate = pm_genpd_opp_to_performance_state(dev, new_opp);
>>   
>> +	ret = opp_parse_icc_bw(new_opp, dev, opp_table);
>> +	if (ret)
>> +		goto free_opp;
>> +
>>   	ret = _opp_add(dev, new_opp, opp_table, rate_not_available);
>>   	if (ret) {
>>   		/* Don't return error for duplicate OPPs */
>> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
>> index 569b3525aa67..70a537f2dbd3 100644
>> --- a/drivers/opp/opp.h
>> +++ b/drivers/opp/opp.h
>> @@ -24,6 +24,7 @@
>>   
>>   struct clk;
>>   struct regulator;
>> +struct icc_path;
>>   
>>   /* Lock to allow exclusive modification to the device and opp lists */
>>   extern struct mutex opp_table_lock;
>> @@ -62,6 +63,7 @@ extern struct list_head opp_tables;
>>    * @rate:	Frequency in hertz
>>    * @level:	Performance level
>>    * @supplies:	Power supplies voltage/current values
>> + * @bandwidth:	Interconnect bandwidth values
>>    * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
>>    *		frequency from any other OPP's frequency.
>>    * @required_opps: List of OPPs that are required by this OPP.
>> @@ -84,6 +86,7 @@ struct dev_pm_opp {
>>   	unsigned int level;
>>   
>>   	struct dev_pm_opp_supply *supplies;
>> +	struct dev_pm_opp_icc_bw *bandwidth;
>>   
>>   	unsigned long clock_latency_ns;
>>   
>> @@ -150,6 +153,8 @@ enum opp_table_access {
>>    * @regulator_count: Number of power supply regulators. Its value can be -1
>>    * (uninitialized), 0 (no opp-microvolt property) or > 0 (has opp-microvolt
>>    * property).
>> + * @paths: Interconnect path handles
>> + * @path_count: Number of interconnect paths
>>    * @genpd_performance_state: Device's power domain support performance state.
>>    * @is_genpd: Marks if the OPP table belongs to a genpd.
>>    * @set_opp: Platform specific set_opp callback
>> @@ -194,6 +199,8 @@ struct opp_table {
>>   	struct clk *clk;
>>   	struct regulator **regulators;
>>   	int regulator_count;
>> +	struct icc_path **paths;
>> +	unsigned int path_count;
>>   	bool genpd_performance_state;
>>   	bool is_genpd;
>>   
>> @@ -228,12 +235,14 @@ void _of_clear_opp_table(struct opp_table *opp_table);
>>   struct opp_table *_managed_opp(struct device *dev, int index);
>>   void _of_opp_free_required_opps(struct opp_table *opp_table,
>>   				struct dev_pm_opp *opp);
>> +int _of_find_paths(struct opp_table *opp_table, struct device *dev);
>>   #else
>>   static inline void _of_init_opp_table(struct opp_table *opp_table, struct device *dev, int index) {}
>>   static inline void _of_clear_opp_table(struct opp_table *opp_table) {}
>>   static inline struct opp_table *_managed_opp(struct device *dev, int index) { return NULL; }
>>   static inline void _of_opp_free_required_opps(struct opp_table *opp_table,
>>   					      struct dev_pm_opp *opp) {}
>> +static inline int _of_find_paths(struct opp_table *opp_table, struct device *dev) { return 0; }
>>   #endif
>>   
>>   #ifdef CONFIG_DEBUG_FS
>> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
>> index 24c757a32a7b..dabee09a92b8 100644
>> --- a/include/linux/pm_opp.h
>> +++ b/include/linux/pm_opp.h
>> @@ -43,6 +43,18 @@ struct dev_pm_opp_supply {
>>   	unsigned long u_amp;
>>   };
>>   
>> +/**
>> + * struct dev_pm_opp_icc_bw - Interconnect bandwidth values
>> + * @avg:	Average bandwidth corresponding to this OPP (in icc units)
>> + * @peak:	Peak bandwidth corresponding to this OPP (in icc units)
>> + *
>> + * This structure stores the bandwidth values for a single interconnect path.
>> + */
>> +struct dev_pm_opp_icc_bw {
>> +	u32 avg;
>> +	u32 peak;
>> +};
>> +
>>   /**
>>    * struct dev_pm_opp_info - OPP freq/voltage/current values
>>    * @rate:	Target clk rate in hz
>> @@ -127,6 +139,8 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * con
>>   void dev_pm_opp_put_regulators(struct opp_table *opp_table);
>>   struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char * name);
>>   void dev_pm_opp_put_clkname(struct opp_table *opp_table);
>> +struct opp_table *dev_pm_opp_set_paths(struct device *dev);
>> +void dev_pm_opp_put_paths(struct opp_table *opp_table);
>>   struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
>>   void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
>>   struct opp_table *dev_pm_opp_set_genpd_virt_dev(struct device *dev, struct device *virt_dev, int index);
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
