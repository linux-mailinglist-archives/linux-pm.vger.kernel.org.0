Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEBC6ADBA
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 19:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbfGPRdV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 13:33:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47006 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbfGPRdU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 13:33:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 265C361795; Tue, 16 Jul 2019 17:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563298400;
        bh=+Imo2mVUwvcbt03J0N9jwlpPEyT65MKGbLzHzRIbFw0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Q4ky4kHD2/NF8AHekYy9TXpk12WZSm0vKe+YV+L48VLVxFeBepC8M/5bMpTfSYIkA
         SakxsLNlvIdLaDCB58p2OPisQE8BHBuSRvA65fGqNUa4HCbJ4uc5G4UGqeSeHQV0Bh
         J4XL21aukZKeV6ynKa9OuW+dNw1xqYWjj33tPRtw=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7139C60588;
        Tue, 16 Jul 2019 17:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563298398;
        bh=+Imo2mVUwvcbt03J0N9jwlpPEyT65MKGbLzHzRIbFw0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UohcQSftbbO4Z9SAD5IHkJdkvb50ePL45SDqn2lV/cQfc/pEfuapm9qNMKvySxCG0
         mLf+6QGXQuvsN5iy2+ZAcCCm22Wkfg6AgWliGsaM9CGBBkOKqN/j46fbKAaGCAsmGS
         kDp7qxkTdv2hx7oogGfD7W5Hk7a78DfEzByNcWJA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7139C60588
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH v3 2/6] OPP: Add support for bandwidth OPP tables
To:     Saravana Kannan <saravanak@google.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     vincent.guittot@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        kernel-team@android.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        adharmap@codeaurora.org
References: <20190703011020.151615-1-saravanak@google.com>
 <20190703011020.151615-3-saravanak@google.com>
From:   Sibi Sankar <sibis@codeaurora.org>
Message-ID: <5dd35be3-fd03-c9cc-1eed-ce4bc1433363@codeaurora.org>
Date:   Tue, 16 Jul 2019 23:03:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190703011020.151615-3-saravanak@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Saravana,

On 7/3/19 6:40 AM, Saravana Kannan wrote:
> Not all devices quantify their performance points in terms of frequency.
> Devices like interconnects quantify their performance points in terms of
> bandwidth. We need a way to represent these bandwidth levels in OPP. So,
> add support for parsing bandwidth OPPs from DT.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>   drivers/opp/of.c  | 34 ++++++++++++++++++++++++++++++++--
>   drivers/opp/opp.h |  4 +++-
>   2 files changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index c10c782d15aa..54fa70ed2adc 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -552,6 +552,35 @@ void dev_pm_opp_of_remove_table(struct device *dev)
>   }
>   EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
>   
> +static int _read_opp_key(struct dev_pm_opp *new_opp, struct device_node *np)
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
> +		new_opp->rate = (unsigned long)rate
now that the rate gets set here, please remove the rate assignment in
_opp_add_static_v2

> +		return 0;
> +	}
> +
> +	ret = of_property_read_u32(np, "opp-peak-KBps", &bw);
> +	if (ret)
> +		return ret;
> +	new_opp->rate = (unsigned long) &bw;

should be bw instead

> +
> +	ret = of_property_read_u32(np, "opp-avg-KBps", &bw);
> +	if (!ret)
> +		new_opp->avg_bw = (unsigned long) &bw;

ditto

> +
> +	return 0;
> +}
> +
>   /**
>    * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
>    * @opp_table:	OPP table
> @@ -589,11 +618,12 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>   	if (!new_opp)
>   		return ERR_PTR(-ENOMEM);
>   
> -	ret = of_property_read_u64(np, "opp-hz", &rate);
> +	ret = _read_opp_key(new_opp, np);
>   	if (ret < 0) {
>   		/* "opp-hz" is optional for devices like power domains. */
>   		if (!opp_table->is_genpd) {
> -			dev_err(dev, "%s: opp-hz not found\n", __func__);
> +			dev_err(dev, "%s: opp-hz or opp-peak-bw not found\n",
> +				__func__);

please remove the else part where rate value will be reset.

>   			goto free_opp;
>   		}
>   
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index 569b3525aa67..ead2cdafe957 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -59,7 +59,8 @@ extern struct list_head opp_tables;
>    * @turbo:	true if turbo (boost) OPP
>    * @suspend:	true if suspend OPP
>    * @pstate: Device's power domain's performance state.
> - * @rate:	Frequency in hertz
> + * @rate:	Frequency in hertz OR Peak bandwidth in kilobytes per second
> + * @avg_bw:	Average bandwidth in kilobytes per second
>    * @level:	Performance level
>    * @supplies:	Power supplies voltage/current values
>    * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
> @@ -81,6 +82,7 @@ struct dev_pm_opp {
>   	bool suspend;
>   	unsigned int pstate;
>   	unsigned long rate;
> +	unsigned long avg_bw;
>   	unsigned int level;
>   
>   	struct dev_pm_opp_supply *supplies;
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
