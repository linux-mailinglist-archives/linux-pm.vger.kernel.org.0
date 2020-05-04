Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FC41C48C1
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 23:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgEDVD4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 17:03:56 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:24312 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728065AbgEDVDz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2020 17:03:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588626233; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=cnpTVGsk5cKEizkJnxpynIZXwfS02A3yLTeMRtpkXuk=;
 b=V7OuOwnpTKa2qskD9k3nFifZpPGKBmw4+u+LbCBPNZOkb7E8+h25P7QiQmNzPe4sMMJgzFYE
 jOtQzw9CkeuoVz+kJfLJsLX6bNnVmibzZDkFPAQXm9mvUnW1PDYcmnhaV2gLnXsEx5NzZvHL
 rqBggYhayazqcpJ556FSRsZdOss=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb08325.7f1840757a78-smtp-out-n05;
 Mon, 04 May 2020 21:03:33 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AF80EC43637; Mon,  4 May 2020 21:03:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 14BD4C433CB;
        Mon,  4 May 2020 21:03:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 May 2020 02:33:32 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, rjw@rjwysocki.net, saravanak@google.com,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        vincent.guittot@linaro.org, jcrouse@codeaurora.org,
        evgreen@chromium.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v7 4/7] OPP: Add support for parsing interconnect
 bandwidth
In-Reply-To: <20200424155404.10746-5-georgi.djakov@linaro.org>
References: <20200424155404.10746-1-georgi.djakov@linaro.org>
 <20200424155404.10746-5-georgi.djakov@linaro.org>
Message-ID: <1c49953a26f40aa01c034f2829e15d1b@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Georgi,

Apart from the Matthias's comments
ran into a few issues during testing.

On 2020-04-24 21:24, Georgi Djakov wrote:
> The OPP bindings now support bandwidth values, so add support to parse 
> it
> from device tree and store it into the new dev_pm_opp_icc_bw struct, 
> which
> is part of the dev_pm_opp.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> v7:
> * Addressed some review comments from Viresh and Sibi.
> * Various other changes.
> 
> v2:
> https://lore.kernel.org/linux-arm-msm/20190423132823.7915-4-georgi.djakov@linaro.org/
> 
>  drivers/opp/Kconfig    |   1 +
>  drivers/opp/core.c     |  16 +++++-
>  drivers/opp/of.c       | 119 ++++++++++++++++++++++++++++++++++++++++-
>  drivers/opp/opp.h      |   9 ++++
>  include/linux/pm_opp.h |  12 +++++
>  5 files changed, 153 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/opp/Kconfig b/drivers/opp/Kconfig
> index 35dfc7e80f92..230d2b84436c 100644
> --- a/drivers/opp/Kconfig
> +++ b/drivers/opp/Kconfig
> @@ -2,6 +2,7 @@
>  config PM_OPP
>  	bool
>  	select SRCU
> +	depends on INTERCONNECT || !INTERCONNECT
>  	---help---
>  	  SOCs have a standard set of tuples consisting of frequency and
>  	  voltage pairs that the device will support per voltage domain. This
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index c9c1bbe6ae27..8e86811eb7b2 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -985,6 +985,12 @@ static struct opp_table
> *_allocate_opp_table(struct device *dev, int index)
>  				ret);
>  	}
> 
> +	/* Find interconnect path(s) for the device */
> +	ret = _of_find_paths(opp_table, dev);
> +	if (ret)
> +		dev_dbg(dev, "%s: Error finding interconnect paths: %d\n",
> +			__func__, ret);
> +
>  	BLOCKING_INIT_NOTIFIER_HEAD(&opp_table->head);
>  	INIT_LIST_HEAD(&opp_table->opp_list);
>  	kref_init(&opp_table->kref);
> @@ -1229,19 +1235,22 @@ 
> EXPORT_SYMBOL_GPL(dev_pm_opp_remove_all_dynamic);
>  struct dev_pm_opp *_opp_allocate(struct opp_table *table)
>  {
>  	struct dev_pm_opp *opp;
> -	int count, supply_size;
> +	int count, supply_size, icc_size;
> 
>  	/* Allocate space for at least one supply */
>  	count = table->regulator_count > 0 ? table->regulator_count : 1;
>  	supply_size = sizeof(*opp->supplies) * count;
> +	icc_size = sizeof(*opp->bandwidth) * table->path_count;
> 
>  	/* allocate new OPP node and supplies structures */
> -	opp = kzalloc(sizeof(*opp) + supply_size, GFP_KERNEL);
> +	opp = kzalloc(sizeof(*opp) + supply_size + icc_size, GFP_KERNEL);
> +
>  	if (!opp)
>  		return NULL;
> 
>  	/* Put the supplies at the end of the OPP structure as an empty array 
> */
>  	opp->supplies = (struct dev_pm_opp_supply *)(opp + 1);
> +	opp->bandwidth = (struct dev_pm_opp_icc_bw *)(opp->supplies + 1);
>  	INIT_LIST_HEAD(&opp->node);
> 
>  	return opp;
> @@ -1276,6 +1285,9 @@ int _opp_compare_key(struct dev_pm_opp *opp1,
> struct dev_pm_opp *opp2)
>  {
>  	if (opp1->rate != opp2->rate)
>  		return opp1->rate < opp2->rate ? -1 : 1;
> +	if (opp1->bandwidth && opp2->bandwidth &&
> +	    opp1->bandwidth[0].peak != opp2->bandwidth[0].peak)
> +		return opp1->bandwidth[0].peak < opp2->bandwidth[0].peak ? -1 : 1;
>  	if (opp1->level != opp2->level)
>  		return opp1->level < opp2->level ? -1 : 1;
>  	return 0;
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index e33169c7e045..978e445b0cdb 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -332,6 +332,59 @@ static int _of_opp_alloc_required_opps(struct
> opp_table *opp_table,
>  	return ret;
>  }
> 
> +int _of_find_paths(struct opp_table *opp_table, struct device *dev)
> +{
> +	struct device_node *np;
> +	int ret, i, count, num_paths;
> +
> +	np = of_node_get(dev->of_node);
> +	if (!np)
> +		return 0;
> +
> +	count = of_count_phandle_with_args(np, "interconnects",
> +					   "#interconnect-cells");
> +	of_node_put(np);
> +	if (count < 0)
> +		return 0;
> +
> +	/* two phandles when #interconnect-cells = <1> */
> +	if (count % 2) {
> +		dev_err(dev, "%s: Invalid interconnects values\n",
> +			__func__);
> +		return -EINVAL;
> +	}
> +
> +	num_paths = count / 2;
> +	opp_table->paths = kcalloc(num_paths, sizeof(*opp_table->paths),
> +				   GFP_KERNEL);
> +	if (!opp_table->paths)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num_paths; i++) {
> +		opp_table->paths[i] = of_icc_get_by_index(dev, i);

now that icc_get is part of the
opp core framework shouldn't we
do a put on table remove as well?

> +		if (IS_ERR(opp_table->paths[i])) {
> +			ret = PTR_ERR(opp_table->paths[i]);
> +			if (ret != -EPROBE_DEFER) {
> +				dev_err(dev, "%s: Unable to get path%d: %d\n",
> +					__func__, i, ret);
> +			}
> +			goto err;
> +		}
> +	}
> +	opp_table->path_count = num_paths;
> +
> +	return 0;
> +
> +err:
> +	while (i--)
> +		icc_put(opp_table->paths[i]);
> +
> +	kfree(opp_table->paths);
> +	opp_table->paths = NULL;
> +
> +	return ret;
> +}
> +
>  static bool _opp_is_supported(struct device *dev, struct opp_table 
> *opp_table,
>  			      struct device_node *np)
>  {
> @@ -524,8 +577,11 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
>  static int _read_opp_key(struct dev_pm_opp *new_opp, struct 
> device_node *np,
>  			 bool *rate_not_available)
>  {
> +	struct property *peak, *avg;
> +	u32 *peak_bw, *avg_bw;
>  	u64 rate;
> -	int ret;
> +	int ret, i, count;
> +	bool found = false;
> 
>  	ret = of_property_read_u64(np, "opp-hz", &rate);
>  	if (!ret) {
> @@ -535,10 +591,69 @@ static int _read_opp_key(struct dev_pm_opp
> *new_opp, struct device_node *np,
>  		 * bit guaranteed in clk API.
>  		 */
>  		new_opp->rate = (unsigned long)rate;
> +		found = true;
>  	}
>  	*rate_not_available = !!ret;
> 
> -	of_property_read_u32(np, "opp-level", &new_opp->level);
> +	peak = of_find_property(np, "opp-peak-kBps", NULL);
> +	if (peak) {
> +		/*
> +		 * Bandwidth consists of peak and average (optional) values:
> +		 * opp-peak-kBps = <path1_value path2_value>;
> +		 * opp-avg-kBps = <path1_value path2_value>;
> +		 */
> +		count = peak->length / sizeof(u32);
> +		peak_bw = kmalloc_array(count, sizeof(*peak_bw), GFP_KERNEL);
> +		if (!peak_bw)
> +			return -ENOMEM;
> +
> +		ret = of_property_read_u32_array(np, "opp-peak-kBps", peak_bw,
> +						 count);
> +		if (ret) {
> +			pr_err("%s: Error parsing opp-peak-kBps: %d\n",
> +			       __func__, ret);
> +			goto free_peak_bw;
> +		}
> +
> +		for (i = 0; i < count; i++)
> +			new_opp->bandwidth[i].peak = kBps_to_icc(peak_bw[i]);
> +
> +		found = true;
> +	}
> +
> +	avg = of_find_property(np, "opp-avg-kBps", NULL);
> +	if (peak && avg) {
> +		count = avg->length / sizeof(u32);
> +		avg_bw = kmalloc_array(count, sizeof(*avg_bw), GFP_KERNEL);
> +		if (!avg_bw) {
> +			ret = -ENOMEM;
> +			goto free_peak_bw;
> +		}
> +
> +		ret = of_property_read_u32_array(np, "opp-avg-kBps", avg_bw,
> +						 count);
> +		if (ret) {
> +			pr_err("%s: Error parsing opp-avg-kBps: %d\n",
> +			       __func__, ret);
> +			goto free_avg_bw;
> +		}
> +
> +		for (i = 0; i < count; i++)
> +			new_opp->bandwidth[i].avg = kBps_to_icc(avg_bw[i]);
> +	}
> +
> +	if (of_property_read_u32(np, "opp-level", &new_opp->level))

of_property_read_u32 returns 0 on
success so should use logical not
instead ^^

> +		found = true;
> +
> +	if (found)
> +		return 0;
> +
> +	return ret;
> +
> +free_avg_bw:
> +	kfree(avg_bw);
> +free_peak_bw:
> +	kfree(peak_bw);
> 
>  	return ret;
>  }
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index bcadb1e328a4..2e0113360297 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -12,6 +12,7 @@
>  #define __DRIVER_OPP_H__
> 
>  #include <linux/device.h>
> +#include <linux/interconnect.h>
>  #include <linux/kernel.h>
>  #include <linux/kref.h>
>  #include <linux/list.h>
> @@ -59,6 +60,7 @@ extern struct list_head opp_tables;
>   * @rate:	Frequency in hertz
>   * @level:	Performance level
>   * @supplies:	Power supplies voltage/current values
> + * @bandwidth:	Interconnect bandwidth values
>   * @clock_latency_ns: Latency (in nanoseconds) of switching to this 
> OPP's
>   *		frequency from any other OPP's frequency.
>   * @required_opps: List of OPPs that are required by this OPP.
> @@ -81,6 +83,7 @@ struct dev_pm_opp {
>  	unsigned int level;
> 
>  	struct dev_pm_opp_supply *supplies;
> +	struct dev_pm_opp_icc_bw *bandwidth;
> 
>  	unsigned long clock_latency_ns;
> 
> @@ -146,6 +149,8 @@ enum opp_table_access {
>   * @regulator_count: Number of power supply regulators. Its value can 
> be -1
>   * (uninitialized), 0 (no opp-microvolt property) or > 0 (has 
> opp-microvolt
>   * property).
> + * @paths: Interconnect path handles
> + * @path_count: Number of interconnect paths
>   * @genpd_performance_state: Device's power domain support performance 
> state.
>   * @is_genpd: Marks if the OPP table belongs to a genpd.
>   * @set_opp: Platform specific set_opp callback
> @@ -189,6 +194,8 @@ struct opp_table {
>  	struct clk *clk;
>  	struct regulator **regulators;
>  	int regulator_count;
> +	struct icc_path **paths;
> +	unsigned int path_count;
>  	bool genpd_performance_state;
>  	bool is_genpd;
> 
> @@ -224,12 +231,14 @@ void _of_clear_opp_table(struct opp_table 
> *opp_table);
>  struct opp_table *_managed_opp(struct device *dev, int index);
>  void _of_opp_free_required_opps(struct opp_table *opp_table,
>  				struct dev_pm_opp *opp);
> +int _of_find_paths(struct opp_table *opp_table, struct device *dev);
>  #else
>  static inline void _of_init_opp_table(struct opp_table *opp_table,
> struct device *dev, int index) {}
>  static inline void _of_clear_opp_table(struct opp_table *opp_table) {}
>  static inline struct opp_table *_managed_opp(struct device *dev, int
> index) { return NULL; }
>  static inline void _of_opp_free_required_opps(struct opp_table 
> *opp_table,
>  					      struct dev_pm_opp *opp) {}
> +static inline int _of_find_paths(struct opp_table *opp_table, struct
> device *dev) { return 0; }
>  #endif
> 
>  #ifdef CONFIG_DEBUG_FS
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index 747861816f4f..cfceb0290401 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -41,6 +41,18 @@ struct dev_pm_opp_supply {
>  	unsigned long u_amp;
>  };
> 
> +/**
> + * struct dev_pm_opp_icc_bw - Interconnect bandwidth values
> + * @avg:	Average bandwidth corresponding to this OPP (in icc units)
> + * @peak:	Peak bandwidth corresponding to this OPP (in icc units)
> + *
> + * This structure stores the bandwidth values for a single 
> interconnect path.
> + */
> +struct dev_pm_opp_icc_bw {
> +	u32 avg;
> +	u32 peak;
> +};
> +
>  /**
>   * struct dev_pm_opp_info - OPP freq/voltage/current values
>   * @rate:	Target clk rate in hz

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
