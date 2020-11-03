Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48EC2A3B9B
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 06:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgKCFBp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 00:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgKCFBp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2020 00:01:45 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160F6C061A47
        for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2020 21:01:45 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 13so13148635pfy.4
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2020 21:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a2hK/Zt+tHOLeBOM1RV+x0rUNVHJCjIJ0ta9fQYuGlw=;
        b=fsv92qZjIGtLDoGNPyoGBIcC/V49FfS/d+bdm9adJmzK8kv168J7MScR1jhbY5MTmG
         /IfO72YdcZ1OXkcrjnZVc+ooPS3W31SytXqQv2JW5tzZUYbdAMPGrToY1pQK9ND0+koI
         AzwUHkBYvxyyLTJcok7fjLeheOx4bGea0EVrgqaEQlBaCCe2xv6v6rYYI78NzTl11epP
         lJXxdxUcjGEwx7IlnknNA+MGNAJF06hEEPim2LWV8+rA/W5z5VDBZMOREZRPoEgXtPr8
         QdMS1iKlI7mk3vDNbDxZR9BFj7nheRL2gwt6w0jnbs8CKaJudOMhxW9fqWyURqFv2ZQO
         pKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a2hK/Zt+tHOLeBOM1RV+x0rUNVHJCjIJ0ta9fQYuGlw=;
        b=XFd6h9kT84Uh9Dsnp6lVKrgQPKqGDJhifKaU8F4Cauyj+w+wd7OBtrSjHfq6ROSKyf
         o+SdN2BKX1xCZ+kPuGwEXMVsRw0m70gp/AXOfVeq2vv1VScXsqt8boOpAYdUVDYm1Ivd
         Ji9aEUyaY6xuSZsgsWN3dvscsbT4GqUL/Z5PRugWUEf73LObGK8Fflz1SK/p8/rJQr/J
         gU9TXXI4gTR4mPJV9Ala1pu449lqqmdSR3jOMzmKwq3WVpvBDt8Mzh0K04v4G1oEUSnW
         27zB3CdZ2i4FMsJjpc5ALxHsPxF02PNrXkXCMAgUKcQGWyhQKfBHhG6vgyeH4hFToJuW
         Laeg==
X-Gm-Message-State: AOAM5331dlJDDEdqeAehsck1V+aRCNVYy2IQj39hFlmMQJozktL5e/a4
        UV5dfjMFHdanyTrk2lZKAJmxfQ==
X-Google-Smtp-Source: ABdhPJyWUS8zm8Na48K1tneF9X8r+aOUU0UCCgw5x7qYT0DpLvr/MkjfXCOFyt3HEqm4NScoGP/0vg==
X-Received: by 2002:a17:90a:aa91:: with SMTP id l17mr1849037pjq.198.1604379704421;
        Mon, 02 Nov 2020 21:01:44 -0800 (PST)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id h10sm14154774pgj.69.2020.11.02.21.01.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2020 21:01:43 -0800 (PST)
Date:   Tue, 3 Nov 2020 10:31:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nicola Mazzucato <nicola.mazzucato@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, vireshk@kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, nm@ti.com,
        daniel.lezcano@linaro.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com
Subject: Re: [PATCH v3 2/3] opp/of: Allow empty opp-table with opp-shared
Message-ID: <20201103050141.kiuyotzt4brisch7@vireshk-i7>
References: <20201102120115.29993-1-nicola.mazzucato@arm.com>
 <20201102120115.29993-3-nicola.mazzucato@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102120115.29993-3-nicola.mazzucato@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02-11-20, 12:01, Nicola Mazzucato wrote:
> The opp binding now allows to have an empty opp table and shared-opp to
> merely describe a hw connection among devices (f/v lines).
> 
> When initialising an opp table, allow such case by:
> - treating some errors as warnings
> - do not mark empty tables as shared
> - don't fail on empty table
> 
> Signed-off-by: Nicola Mazzucato <nicola.mazzucato@arm.com>
> ---
>  drivers/opp/of.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 874b58756220..b0230490bb31 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -157,6 +157,11 @@ static void _opp_table_free_required_tables(struct opp_table *opp_table)
>  /*
>   * Populate all devices and opp tables which are part of "required-opps" list.
>   * Checking only the first OPP node should be enough.
> + *
> + * Corner case: empty opp table and opp-shared found. In this case we set
> + * unconditionally the opp table access to exclusive, as the opp-shared property
> + * is used purely to describe hw connections. Such information will be retrieved
> + * via dev_pm_opp_of_get_sharing_cpus().
>   */
>  static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
>  					     struct device *dev,
> @@ -169,7 +174,9 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
>  	/* Traversing the first OPP node is all we need */
>  	np = of_get_next_available_child(opp_np, NULL);
>  	if (!np) {
> -		dev_err(dev, "Empty OPP table\n");
> +		dev_warn(dev, "Empty OPP table\n");
> +
> +		opp_table->shared_opp = OPP_TABLE_ACCESS_EXCLUSIVE;

I am not sure I understand the reasoning behind this.

>  		return;
>  	}
>  
> @@ -377,7 +384,9 @@ int dev_pm_opp_of_find_icc_paths(struct device *dev,
>  	struct icc_path **paths;
>  
>  	ret = _bandwidth_supported(dev, opp_table);
> -	if (ret <= 0)
> +	if (ret == -EINVAL)
> +		return 0; /* Empty OPP table is a valid corner-case, let's not fail */
> +	else if (ret <= 0)
>  		return ret;
>  
>  	ret = 0;
> -- 
> 2.27.0

-- 
viresh
