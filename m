Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72C9E132F69
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 20:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgAGT2f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 14:28:35 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:22667 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728412AbgAGT2f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2020 14:28:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578425314; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=RQwQB66tsLYS5Q5td7KICDIdEQhztmUN50oAmo2FSoI=;
 b=SNfmyYbXjNN8VXOGXcLKF4fdK42WvoBhkvqRYUKefN6enFyh7+IzwJz5IpLG3Or6BG0009YE
 A5zu9bmH+o66506bGdN5g+sr8Hl+nw9yeXHubzuQXL7o2SiT/UISyxEPh+dDNyuRt+cQ5/MM
 dHPbMy7QF/EhRs8dum62EwBb61E=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e14dbdc.7f9b421a4a78-smtp-out-n01;
 Tue, 07 Jan 2020 19:28:28 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E0877C447A2; Tue,  7 Jan 2020 19:28:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7B41DC433CB;
        Tue,  7 Jan 2020 19:28:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 08 Jan 2020 00:58:25 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        vincent.guittot@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        kernel-team@android.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] OPP: Add support for bandwidth OPP tables
In-Reply-To: <20191207002424.201796-3-saravanak@google.com>
References: <20191207002424.201796-1-saravanak@google.com>
 <20191207002424.201796-3-saravanak@google.com>
Message-ID: <c701fe1d94631e3aba92a8c80070c6a4@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Saravana,

Spent some time testing this series while
trying out dcvs on SDM845/SC7180. Apart from
the few minor issues it works quite well!

On 2019-12-07 05:54, Saravana Kannan wrote:
> Not all devices quantify their performance points in terms of 
> frequency.
> Devices like interconnects quantify their performance points in terms 
> of
> bandwidth. We need a way to represent these bandwidth levels in OPP. 
> So,
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
> @@ -1282,11 +1282,21 @@ static bool
> _opp_supported_by_regulators(struct dev_pm_opp *opp,
>  	return true;
>  }
> 
> +int opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2)
> +{
> +	if (opp1->rate != opp2->rate)
> +		return opp1->rate < opp2->rate ? -1 : 1;
> +	if (opp1->peak_bw != opp2->peak_bw)
> +		return opp1->peak_bw < opp2->peak_bw ? -1 : 1;
> +	return 0;
> +}
> +
>  static int _opp_is_duplicate(struct device *dev, struct dev_pm_opp 
> *new_opp,
>  			     struct opp_table *opp_table,
>  			     struct list_head **head)
>  {
>  	struct dev_pm_opp *opp;
> +	int opp_cmp;
> 
>  	/*
>  	 * Insert new OPP in order of increasing frequency and discard if
> @@ -1297,12 +1307,13 @@ static int _opp_is_duplicate(struct device
> *dev, struct dev_pm_opp *new_opp,
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
> @@ -521,6 +521,44 @@ void dev_pm_opp_of_remove_table(struct device 
> *dev)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
> 
> +static int _read_opp_key(struct dev_pm_opp *new_opp, struct 
> device_node *np,
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
> +
> +	return ret;
> +}
> +
>  /**
>   * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT 
> bindings)
>   * @opp_table:	OPP table
> @@ -558,26 +596,12 @@ static struct dev_pm_opp
> *_opp_add_static_v2(struct opp_table *opp_table,
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

if (!opp_table->is_genpd) {

_read_opp_key returns an error for genpd
opps so please check if it is a genpd
opp_table before erroring out here.

> +		dev_err(dev, "%s: opp key field not found\n", __func__);
> +		goto free_opp;
>  	}
> 
> -	of_property_read_u32(np, "opp-level", &new_opp->level);
> -
>  	/* Check if the OPP supports hardware's hierarchy of versions or not 
> */
>  	if (!_opp_is_supported(dev, opp_table, np)) {
>  		dev_dbg(dev, "OPP not supported by hardware: %llu\n", rate);
> @@ -616,7 +640,8 @@ static struct dev_pm_opp
> *_opp_add_static_v2(struct opp_table *opp_table,
>  	if (of_property_read_bool(np, "opp-suspend")) {
>  		if (opp_table->suspend_opp) {
>  			/* Pick the OPP with higher rate as suspend OPP */
> -			if (new_opp->rate > opp_table->suspend_opp->rate) {
> +			if (opp_compare_key(new_opp,
> +					    opp_table->suspend_opp) > 1) {

shouldn't the condition be > 0?

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
>   * @clock_latency_ns: Latency (in nanoseconds) of switching to this 
> OPP's
> @@ -78,6 +80,8 @@ struct dev_pm_opp {
>  	bool suspend;
>  	unsigned int pstate;
>  	unsigned long rate;
> +	unsigned int peak_bw;
> +	unsigned int avg_bw;
>  	unsigned int level;
> 
>  	struct dev_pm_opp_supply *supplies;
> @@ -213,6 +217,7 @@ struct opp_device *_add_opp_dev(const struct
> device *dev, struct opp_table *opp_
>  void _dev_pm_opp_find_and_remove_table(struct device *dev);
>  struct dev_pm_opp *_opp_allocate(struct opp_table *opp_table);
>  void _opp_free(struct dev_pm_opp *opp);
> +int opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2);
>  int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct
> opp_table *opp_table, bool rate_not_available);
>  int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
> unsigned long freq, long u_volt, bool dynamic);
>  void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask,
> int last_cpu);

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
