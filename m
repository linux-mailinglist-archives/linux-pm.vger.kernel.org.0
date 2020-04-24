Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5B41B7EBF
	for <lists+linux-pm@lfdr.de>; Fri, 24 Apr 2020 21:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgDXTUa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Apr 2020 15:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726793AbgDXTU3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2020 15:20:29 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFE4C09B048
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 12:20:28 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d17so5086388pgo.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 12:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h9WOUp5WscPST9oWEpQEvY13ON01lmbF+7hS1W9VYTc=;
        b=f8G3tnqQ/WqZPljfWTrVZC9n1UKePvFXMcQkjcpQjgETjxr7tYA1VxsR86S6GKMJPw
         utt7CewjDTBe/ZGg5w3wq0yD30GCiNSCzXKPFQtuV6eS3iKl6dX4aTUjY8Lnmru3wrEM
         4bOOkSVOo0QMPs4KfbsDu8mPNyMQKVOsUSvB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h9WOUp5WscPST9oWEpQEvY13ON01lmbF+7hS1W9VYTc=;
        b=VNz+/CT4wx82UfKn+2v4doKFr7cY+oQPBQuhtoxxCEfQVIoc5e+/njeEjIVtDwj9LV
         DS7nCZpLMufAxNtwGcfhHjTxm9FdBkBg9lNr+Fw1QGhBw7iUR8QVMnje33zLBAoms3j2
         vYo/0OVJnrRi7PhwyfedTc71K/y+DyKRsaagLn7wPEJhRTH1y2bMl6CTjYhM4GPB6rFf
         qMJ5xkRiSpWiVq8yff0JDFzof1X1cAHk0wE6AXicEP0jLlIyjrEHeDF+nJA6BHZWn6/e
         kYPE7FDUTzKiNlR0Wg2MUZuN3lVSe5tBwe0mWs2Y9LMSqWKlXA/Ov57z+Qbmet5+EGqN
         qdEw==
X-Gm-Message-State: AGi0PuZDyfDHfPNE0vTvbpBeeqj8FNg9UN7jxUFJjV6FvZJ0I4rQLHqJ
        BFVnLqE2/jYkb3UKKjmrOxAEvGy2RW0=
X-Google-Smtp-Source: APiQypKHtaTOfbfv04ZVjhT/qaC/ObQFMxeu2fQuIgbViE8Aktyfcj/NkYEFIwRZBhR4lUCAABfCEw==
X-Received: by 2002:aa7:9429:: with SMTP id y9mr11767584pfo.8.1587756027512;
        Fri, 24 Apr 2020 12:20:27 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id v64sm6539551pfb.20.2020.04.24.12.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 12:20:26 -0700 (PDT)
Date:   Fri, 24 Apr 2020 12:20:25 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, rjw@rjwysocki.net, saravanak@google.com,
        sibis@codeaurora.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        jcrouse@codeaurora.org, evgreen@chromium.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/7] OPP: Add support for parsing interconnect
 bandwidth
Message-ID: <20200424192025.GA4525@google.com>
References: <20200424155404.10746-1-georgi.djakov@linaro.org>
 <20200424155404.10746-5-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200424155404.10746-5-georgi.djakov@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Fri, Apr 24, 2020 at 06:54:01PM +0300, Georgi Djakov wrote:
> The OPP bindings now support bandwidth values, so add support to parse it
> from device tree and store it into the new dev_pm_opp_icc_bw struct, which
> is part of the dev_pm_opp.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> v7:
> * Addressed some review comments from Viresh and Sibi.
> * Various other changes.
> 
> v2: https://lore.kernel.org/linux-arm-msm/20190423132823.7915-4-georgi.djakov@linaro.org/
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

huh?

>  	---help---
>  	  SOCs have a standard set of tuples consisting of frequency and
>  	  voltage pairs that the device will support per voltage domain. This
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index c9c1bbe6ae27..8e86811eb7b2 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -985,6 +985,12 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
>  				ret);
>  	}
>  
> +	/* Find interconnect path(s) for the device */
> +	ret = _of_find_paths(opp_table, dev);
> +	if (ret)
> +		dev_dbg(dev, "%s: Error finding interconnect paths: %d\n",
> +			__func__, ret);

why dev_dbg and not dev_warn?

> +
>  	BLOCKING_INIT_NOTIFIER_HEAD(&opp_table->head);
>  	INIT_LIST_HEAD(&opp_table->opp_list);
>  	kref_init(&opp_table->kref);
> @@ -1229,19 +1235,22 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_remove_all_dynamic);
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
>  	/* Put the supplies at the end of the OPP structure as an empty array */
>  	opp->supplies = (struct dev_pm_opp_supply *)(opp + 1);
> +	opp->bandwidth = (struct dev_pm_opp_icc_bw *)(opp->supplies + 1);

IIUC this needs to be:

	opp->bandwidth = (struct dev_pm_opp_icc_bw *)(opp->supplies + count);

maybe s/count/supply_count/

>  	INIT_LIST_HEAD(&opp->node);
>  
>  	return opp;
> @@ -1276,6 +1285,9 @@ int _opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2)
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
> @@ -332,6 +332,59 @@ static int _of_opp_alloc_required_opps(struct opp_table *opp_table,
>  	return ret;
>  }
>  
> +int _of_find_paths(struct opp_table *opp_table, struct device *dev)

nit: _of_find_icc_paths() to be more concise?

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

nit: no need for separate line

> +		return -EINVAL;
> +	}
> +
> +	num_paths = count / 2;
> +	opp_table->paths = kcalloc(num_paths, sizeof(*opp_table->paths),
> +				   GFP_KERNEL);

Add kfree(opp_table->paths) to _opp_table_kref_release() ?

> +	if (!opp_table->paths)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num_paths; i++) {
> +		opp_table->paths[i] = of_icc_get_by_index(dev, i);
> +		if (IS_ERR(opp_table->paths[i])) {
> +			ret = PTR_ERR(opp_table->paths[i]);
> +			if (ret != -EPROBE_DEFER) {
> +				dev_err(dev, "%s: Unable to get path%d: %d\n",
> +					__func__, i, ret);
> +			}

nit: curly braces not needed

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
>  static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
>  			      struct device_node *np)
>  {
> @@ -524,8 +577,11 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
>  static int _read_opp_key(struct dev_pm_opp *new_opp, struct device_node *np,
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
> @@ -535,10 +591,69 @@ static int _read_opp_key(struct dev_pm_opp *new_opp, struct device_node *np,
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

		kfree(peak_bw);

or re-arrange the kfree()'s below to be in the common code path

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

		kfree(avg_bw);

> +	}

nit: the two code blocks for peak and average bandwidth are mostly redundant.
If it weren't for the assignment of 'new_opp->bandwidth[i].avg' vs
'new_opp->bandwidth[i].peak' the above could easily be outsourced into a
helper function. With some pointer hacks you could still do this, but not
sure if it's worth the effort.

> +
> +	if (of_property_read_u32(np, "opp-level", &new_opp->level))
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
