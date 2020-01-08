Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9297B133FB0
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 11:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgAHKxy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 05:53:54 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55751 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbgAHKxy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 05:53:54 -0500
Received: by mail-pj1-f68.google.com with SMTP id d5so899978pjz.5
        for <linux-pm@vger.kernel.org>; Wed, 08 Jan 2020 02:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=STBEgNuy8lz4/AudmUx23rJGibKwthfZkRpgmM09tVY=;
        b=N7F+JP7xjleGQ/DQfzVh5ePkXJfOFfZ8Tmy/Xw72Q9FhVazYEDHntSiDCWlPJB8RxS
         0lk8a+qDnU6Gyp+QaHkkZIZzkzr6P3VPx7KyWg2N57X3PGaO3sBHwTmb/HL2p9e94c1j
         Vv7o4N2VgTJqVLrB9aj4VrSy7ZDBRHdeY498mvo87IuMD2PWU8w3rgkgqA+o3nPavY7i
         hB8b2+pBFHxRm5SEyuRL28W6LpgJM00Y6VuN0NdGuvVFv55jewgZo98ssUF0mNUHFHbb
         y+5F6NQkOSJBkhXedVhKrXZe9mSu4jmv9agrSt+98MsSNierS7yeUyrPaObx0V/mBF3Y
         bSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=STBEgNuy8lz4/AudmUx23rJGibKwthfZkRpgmM09tVY=;
        b=lg+/KmBlAq3uWRSEVvvf2uRPtxgh69Pd3jkBX4KdlkdOVJ2g9i8OJKPz7KRPlg2qD4
         HTtdg0MEEQfHd1xORuxxdiLRohy/iUwsPunGywdVPnqqd8iDYBXnSdtQ+/rt+4nf/5u/
         Ogd2zK/mBqmFWag0ZCkXG/B4yRRLzhZAiJIfQBxCivds2w/ERuLG7Y1YTsRa6HOfFgpr
         uA4FqZOfCNpOxboVowlxcbcLfROdz/Qx9twu2jxSEHdrTvCGX0uHtV8JZJXs6Gw6iIpZ
         KYNdVBC/QDF7G13LtH+1j6Vm7oo61/4n55naau6fgpARPqrbXRwq34oK+eT33bI2RHS5
         ofjA==
X-Gm-Message-State: APjAAAVB+RSj6BwSX7opZGow8iD6vJVQLtcC9HDeHxxmnPdByKQK67qs
        ZQSZUgg2+bJsQdvrEBlt1zgpFw==
X-Google-Smtp-Source: APXvYqxdLix7z72IgP1QZiKqUQ5IkOZZmcUIJTTtf6yKOTcTtQA3PGO+nkAVHgeUEhV7QYAwk0iRIg==
X-Received: by 2002:a17:902:6b4b:: with SMTP id g11mr4477491plt.26.1578480833114;
        Wed, 08 Jan 2020 02:53:53 -0800 (PST)
Received: from localhost ([122.172.26.121])
        by smtp.gmail.com with ESMTPSA id x11sm2962961pfn.53.2020.01.08.02.53.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 02:53:52 -0800 (PST)
Date:   Wed, 8 Jan 2020 16:23:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        vincent.guittot@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>, sibis@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        kernel-team@android.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] OPP: Add support for bandwidth OPP tables
Message-ID: <20200108105348.p4y3s2mbuchiu4mf@vireshk-i7>
References: <20191207002424.201796-1-saravanak@google.com>
 <20191207002424.201796-3-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191207002424.201796-3-saravanak@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-12-19, 16:24, Saravana Kannan wrote:
> Not all devices quantify their performance points in terms of frequency.
> Devices like interconnects quantify their performance points in terms of
> bandwidth. We need a way to represent these bandwidth levels in OPP. So,
> add support for parsing bandwidth OPPs from DT.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/opp/core.c | 15 +++++++++--
>  drivers/opp/of.c   | 63 ++++++++++++++++++++++++++++++++--------------
>  drivers/opp/opp.h  |  5 ++++
>  3 files changed, 62 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index be7a7d332332..c79bbfac7289 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1282,11 +1282,21 @@ static bool _opp_supported_by_regulators(struct dev_pm_opp *opp,
>  	return true;
>  }
>  
> +int opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2)
> +{
> +	if (opp1->rate != opp2->rate)
> +		return opp1->rate < opp2->rate ? -1 : 1;
> +	if (opp1->peak_bw != opp2->peak_bw)
> +		return opp1->peak_bw < opp2->peak_bw ? -1 : 1;

Please also add level here.

> +	return 0;
> +}
> +
>  static int _opp_is_duplicate(struct device *dev, struct dev_pm_opp *new_opp,
>  			     struct opp_table *opp_table,
>  			     struct list_head **head)
>  {
>  	struct dev_pm_opp *opp;
> +	int opp_cmp;
>  
>  	/*
>  	 * Insert new OPP in order of increasing frequency and discard if
> @@ -1297,12 +1307,13 @@ static int _opp_is_duplicate(struct device *dev, struct dev_pm_opp *new_opp,
>  	 * loop.
>  	 */
>  	list_for_each_entry(opp, &opp_table->opp_list, node) {
> -		if (new_opp->rate > opp->rate) {
> +		opp_cmp = opp_compare_key(new_opp, opp);
> +		if (opp_cmp > 0) {
>  			*head = &opp->node;
>  			continue;
>  		}
>  
> -		if (new_opp->rate < opp->rate)
> +		if (opp_cmp < 0)
>  			return 0;
>  
>  		/* Duplicate OPPs */
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 1cbb58240b80..b565da5a2b1f 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -521,6 +521,44 @@ void dev_pm_opp_of_remove_table(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
>  
> +static int _read_opp_key(struct dev_pm_opp *new_opp, struct device_node *np,
> +			 bool *rate_not_available)
> +{
> +	int ret;
> +	u64 rate;
> +	u32 bw;
> +
> +	ret = of_property_read_u64(np, "opp-hz", &rate);
> +	if (!ret) {
> +		/*
> +		 * Rate is defined as an unsigned long in clk API, and so
> +		 * casting explicitly to its type. Must be fixed once rate is 64
> +		 * bit guaranteed in clk API.
> +		 */
> +		new_opp->rate = (unsigned long)rate;
> +		goto out;
> +	}
> +
> +	ret = of_property_read_u32(np, "opp-peak-kBps", &bw);
> +	if (!ret) {
> +		new_opp->peak_bw = bw;
> +
> +		if (!of_property_read_u32(np, "opp-avg-kBps", &bw))
> +			new_opp->avg_bw = bw;

Maybe
		of_property_read_u32(np, "opp-avg-kBps", &new_opp->avg_bw);

and same for opp-peak-kbps as well.

> +	}
> +
> +out:
> +	*rate_not_available = !!ret;
> +	/*
> +	 * If ret is 0 at this point, we have already found a key. If we
> +	 * haven't found a key yet, then ret already has an error value. In
> +	 * either case, we don't need to update ret.
> +	 */
> +	of_property_read_u32(np, "opp-level", &new_opp->level);

Yes, it wasn't done earlier but we should do it now. Check level as
well and treat it as any other key.

I think add a preparatory patch first which does all the cleanup
before bandwidth thing is added.

> +
> +	return ret;
> +}
> +
>  /**
>   * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
>   * @opp_table:	OPP table
> @@ -558,26 +596,12 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>  	if (!new_opp)
>  		return ERR_PTR(-ENOMEM);
>  
> -	ret = of_property_read_u64(np, "opp-hz", &rate);
> -	if (ret < 0) {
> -		/* "opp-hz" is optional for devices like power domains. */
> -		if (!opp_table->is_genpd) {
> -			dev_err(dev, "%s: opp-hz not found\n", __func__);
> -			goto free_opp;
> -		}
> -
> -		rate_not_available = true;
> -	} else {
> -		/*
> -		 * Rate is defined as an unsigned long in clk API, and so
> -		 * casting explicitly to its type. Must be fixed once rate is 64
> -		 * bit guaranteed in clk API.
> -		 */
> -		new_opp->rate = (unsigned long)rate;
> +	ret = _read_opp_key(new_opp, np, &rate_not_available);
> +	if (ret) {
> +		dev_err(dev, "%s: opp key field not found\n", __func__);
> +		goto free_opp;
>  	}
>  
> -	of_property_read_u32(np, "opp-level", &new_opp->level);
> -
>  	/* Check if the OPP supports hardware's hierarchy of versions or not */
>  	if (!_opp_is_supported(dev, opp_table, np)) {
>  		dev_dbg(dev, "OPP not supported by hardware: %llu\n", rate);
> @@ -616,7 +640,8 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>  	if (of_property_read_bool(np, "opp-suspend")) {
>  		if (opp_table->suspend_opp) {
>  			/* Pick the OPP with higher rate as suspend OPP */
> -			if (new_opp->rate > opp_table->suspend_opp->rate) {
> +			if (opp_compare_key(new_opp,
> +					    opp_table->suspend_opp) > 1) {

Maybe leave this place as is as we never want to compare anything else
but rate.

>  				opp_table->suspend_opp->suspend = false;
>  				new_opp->suspend = true;
>  				opp_table->suspend_opp = new_opp;
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index 01a500e2c40a..0def3154d07b 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -57,6 +57,8 @@ extern struct list_head opp_tables;
>   * @suspend:	true if suspend OPP
>   * @pstate: Device's power domain's performance state.
>   * @rate:	Frequency in hertz
> + * @peak_bw:	Peak bandwidth in kilobytes per second
> + * @avg_bw:	Average bandwidth in kilobytes per second
>   * @level:	Performance level
>   * @supplies:	Power supplies voltage/current values
>   * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
> @@ -78,6 +80,8 @@ struct dev_pm_opp {
>  	bool suspend;
>  	unsigned int pstate;
>  	unsigned long rate;
> +	unsigned int peak_bw;
> +	unsigned int avg_bw;
>  	unsigned int level;
>  
>  	struct dev_pm_opp_supply *supplies;
> @@ -213,6 +217,7 @@ struct opp_device *_add_opp_dev(const struct device *dev, struct opp_table *opp_
>  void _dev_pm_opp_find_and_remove_table(struct device *dev);
>  struct dev_pm_opp *_opp_allocate(struct opp_table *opp_table);
>  void _opp_free(struct dev_pm_opp *opp);
> +int opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2);

make it _opp_compare_key() instead.

>  int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct opp_table *opp_table, bool rate_not_available);
>  int _opp_add_v1(struct opp_table *opp_table, struct device *dev, unsigned long freq, long u_volt, bool dynamic);
>  void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, int last_cpu);
> -- 
> 2.24.0.393.g34dc348eaf-goog

-- 
viresh
