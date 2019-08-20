Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 909CD95723
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2019 08:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbfHTGNG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Aug 2019 02:13:06 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42900 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728878AbfHTGNF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2019 02:13:05 -0400
Received: by mail-pl1-f194.google.com with SMTP id y1so2188946plp.9
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2019 23:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4L1H8UAZlMHn0p2Ts3WDSXBKtsgxNg2xEuqMLeeVySs=;
        b=i64qWvdRHZZjBpci/c66ngwbqQ4opTcwKStfh30IinU4DaU6dVIKv7Z8sx3uUIBBH9
         bjqL5vOusq4RCXTDeusUS47ow8i5+AAfBATwc1MhCJCREHH6Rw4YvEh6yT3OoHJH9iJh
         Y+J8dw1ExisMmBg3x9tBHRwZD+bLxWBJDgZDYHi7UAk4dyrGA1mniNnSbHgZWAvzqJu4
         H1v9sgEmNXLk9RIYohlwBKKDij3/3786jlyvW4o5OKQdI68cfN0xGzPhrJYVQ350rArU
         HneqGRLs2WOMSm2WIoZuY2zr3VAuweG+IYyI089/pTgUi8J5UBBHlCpqx0RJUzD3GlBa
         Azpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4L1H8UAZlMHn0p2Ts3WDSXBKtsgxNg2xEuqMLeeVySs=;
        b=Jci5KuyKXguctdIIg1/q+aHbBoa+W6N0zEWoxdN/FPjYjsgi+dA6YbjgRCv62tAyhX
         bo7LlFhsVOeGXrQGwX5T4EVzt5mMJlOxveRAk6MTBFnNjY+1xceAt5rSQu3WH2d5VKU3
         uxy3ormsD6kqrL5j9qd2wg4If352wqIZDeMGxPxfsxhaSDYBC8zxQiwZh00l8uGPPgGS
         gsmDUDPoaJIAnr/jvlIC289BXjRB7Oz0Md16/EBpyetTcRqlpNLURZaaHXJebVGfB9XS
         vUep+u8yS7zPDwJewA8YXJfxwJAcTaGv75wJrWHu/5HYpr4IVnhMMm2YuuCKvN/Xr8Vo
         fhAA==
X-Gm-Message-State: APjAAAV9imoye3tnzInISqMlIaPTgUMaCgFi+DZlPRgEHNl4pcK+6d3C
        HZ0zt6huXmRo7WtQdjp3aeWayA==
X-Google-Smtp-Source: APXvYqyFzTzO21rrXX8ctX7zGynDXIqF0/JJMnX15asxyvnKk6LEC+y8Cct7RTvzy5d8IBntRUzkOQ==
X-Received: by 2002:a17:902:2f05:: with SMTP id s5mr26727203plb.170.1566281584586;
        Mon, 19 Aug 2019 23:13:04 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id a142sm21041119pfd.147.2019.08.19.23.13.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 23:13:03 -0700 (PDT)
Date:   Tue, 20 Aug 2019 11:43:00 +0530
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
Subject: Re: [PATCH v5 2/3] OPP: Add support for bandwidth OPP tables
Message-ID: <20190820061300.wa2dirylb7fztsem@vireshk-i7>
References: <20190807223111.230846-1-saravanak@google.com>
 <20190807223111.230846-3-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807223111.230846-3-saravanak@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-08-19, 15:31, Saravana Kannan wrote:
> Not all devices quantify their performance points in terms of frequency.
> Devices like interconnects quantify their performance points in terms of
> bandwidth. We need a way to represent these bandwidth levels in OPP. So,
> add support for parsing bandwidth OPPs from DT.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/opp/of.c  | 41 ++++++++++++++++++++++++++++++++---------
>  drivers/opp/opp.h |  4 +++-
>  2 files changed, 35 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 1813f5ad5fa2..e1750033fef9 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -523,6 +523,35 @@ void dev_pm_opp_of_remove_table(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
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
> +		new_opp->rate = (unsigned long)rate;
> +		return 0;
> +	}
> +

Please read opp-level also here and do error handling.

> +	ret = of_property_read_u32(np, "opp-peak-kBps", &bw);
> +	if (ret)
> +		return ret;
> +	new_opp->rate = (unsigned long) bw;
> +
> +	ret = of_property_read_u32(np, "opp-avg-kBps", &bw);
> +	if (!ret)
> +		new_opp->avg_bw = (unsigned long) bw;

If none of opp-hz/level/peak-kBps are available, print error message here
itself..

> +
> +	return 0;

You are returning 0 on failure as well here.

> +}
> +
>  /**
>   * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
>   * @opp_table:	OPP table
> @@ -560,22 +589,16 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>  	if (!new_opp)
>  		return ERR_PTR(-ENOMEM);
>  
> -	ret = of_property_read_u64(np, "opp-hz", &rate);
> +	ret = _read_opp_key(new_opp, np);
>  	if (ret < 0) {
>  		/* "opp-hz" is optional for devices like power domains. */
>  		if (!opp_table->is_genpd) {
> -			dev_err(dev, "%s: opp-hz not found\n", __func__);
> +			dev_err(dev, "%s: opp-hz or opp-peak-kBps not found\n",
> +				__func__);
>  			goto free_opp;
>  		}
>  
>  		rate_not_available = true;

Move all above as well to read_opp_key().

> -	} else {
> -		/*
> -		 * Rate is defined as an unsigned long in clk API, and so
> -		 * casting explicitly to its type. Must be fixed once rate is 64
> -		 * bit guaranteed in clk API.
> -		 */
> -		new_opp->rate = (unsigned long)rate;
>  	}
>  
>  	of_property_read_u32(np, "opp-level", &new_opp->level);
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index 01a500e2c40a..6bb238af9cac 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -56,7 +56,8 @@ extern struct list_head opp_tables;
>   * @turbo:	true if turbo (boost) OPP
>   * @suspend:	true if suspend OPP
>   * @pstate: Device's power domain's performance state.
> - * @rate:	Frequency in hertz
> + * @rate:	Frequency in hertz OR Peak bandwidth in kilobytes per second
> + * @avg_bw:	Average bandwidth in kilobytes per second

Please add separate entry for peak_bw here.

I know you reused rate because you don't want to reimplement the helpers we
have. Maybe we can just update them to return peak_bw when opp-hz isn't present.

>   * @level:	Performance level
>   * @supplies:	Power supplies voltage/current values
>   * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
> @@ -78,6 +79,7 @@ struct dev_pm_opp {
>  	bool suspend;
>  	unsigned int pstate;
>  	unsigned long rate;
> +	unsigned long avg_bw;
>  	unsigned int level;
>  
>  	struct dev_pm_opp_supply *supplies;
> -- 
> 2.23.0.rc1.153.gdeed80330f-goog

-- 
viresh
