Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B643F30B0EB
	for <lists+linux-pm@lfdr.de>; Mon,  1 Feb 2021 20:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhBAT4X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Feb 2021 14:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbhBATze (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Feb 2021 14:55:34 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D558C061573;
        Mon,  1 Feb 2021 11:54:53 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id h12so24505572lfp.9;
        Mon, 01 Feb 2021 11:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xNZmBp/NiAMhZaOERjhb6fMDFf2qqf4mAQ51ygipeQY=;
        b=lbdzyrBvHigqHOmgNAq5dH4y1FeuWfRIaOOAPsoRhLcstaYZ8OnTc9JDc2vfj8txQn
         NWlgwCUlkywea+CggPhPU82lpMOPzGQb4Rp8tSVe5cw6jh4s4lkE7SlVn5osGewBI4UW
         R4NOXAYDSQNQxa6byK8kkYhv+HTRQirjjOdj4VBpqxQ4DgjM/zswVGM3StVbpCLWzaTe
         9M29hy4FJ1YVxPRYHkdBDVepWobhW6zXWlQpSv2N7zl6dRGJrKlyVgnU89G3UkVeN4XG
         /VZzAnbFsTEzYvYDl3pfNauV8ZF4UFzaLL8jvEwA2IrWlMQe50qVPi9uX6OuhdniogAz
         sFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xNZmBp/NiAMhZaOERjhb6fMDFf2qqf4mAQ51ygipeQY=;
        b=qnMXbNKzKplGU7Svx3S8rCUyUtkvGd/HVxiSaTFsMQDNlnfT9VZCPqxK4DEKqyDOji
         wvRdeT9tDh+ISKIN25YmnmD8RozmgbVpBuQ0xY5nUyFMGTdanUTYkxhe5B5zYScARnxL
         +6dKBu6XweQwgpNXHlCPN23lBKka+PXNrC3zZarYlMH+8R7yow8YBYCfQW4RTRsA6m4R
         RU8F6xZiGP2wGIizdzkB1q8LN5XyYV2fY/nXaWL9EIjzz6PyDDnvheUsj+lZwjTE1XjR
         OMybUsw7W6dZ2+/Da+taukysSkMXfvAgh2Gzd+BFi4Mi9b7/kkHlcgTQNJ1Q5Nljb2gG
         ATDw==
X-Gm-Message-State: AOAM532p27ZKPz9kL04a4VZ6SfFDWRnkiUQIrZ4T0ddUPrJcahkdKus4
        excehI2GKGw8bMlry/J5GidZqnS1tmw=
X-Google-Smtp-Source: ABdhPJxIuWRfc32O54z4/fRPd2HxwmXl7qreqL8CxoCppKQNa32s+SYrCxnsihXGsebYITP0skNnrQ==
X-Received: by 2002:a19:5f0a:: with SMTP id t10mr9165525lfb.568.1612209290313;
        Mon, 01 Feb 2021 11:54:50 -0800 (PST)
Received: from ?IPv6:2a00:1370:814d:ea25:a10:76ff:fe69:21b6? ([2a00:1370:814d:ea25:a10:76ff:fe69:21b6])
        by smtp.googlemail.com with ESMTPSA id x31sm3114995lfu.10.2021.02.01.11.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 11:54:49 -0800 (PST)
Subject: Re: [PATCH V2] opp: Don't ignore clk_get() errors other than -ENOENT
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
References: <61854037cd4d3ac367cfda3f02fd1557b1b3bb8b.1612153322.git.viresh.kumar@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e6523427-0484-18c3-5b66-a35146556bab@gmail.com>
Date:   Mon, 1 Feb 2021 22:54:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <61854037cd4d3ac367cfda3f02fd1557b1b3bb8b.1612153322.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

01.02.2021 07:22, Viresh Kumar пишет:
> Not all devices that need to use OPP core need to have clocks, a missing
> clock is fine in which case -ENOENT shall be returned by clk_get().
> 
> Anything else is an error and must be handled properly.
> 
> Reported-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2:
> - s/ENODEV/ENOENT
> - Use dev_err_probe()
> 
> Stephen, is the understanding correct that -ENOENT is the only error
> returned for missing clocks ?
> 
>  drivers/opp/core.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index a518173fd64a..0beb3ee79523 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1252,6 +1252,8 @@ static struct opp_table *_update_opp_table_clk(struct device *dev,
>  					       struct opp_table *opp_table,
>  					       bool getclk)
>  {
> +	int ret;
> +
>  	/*
>  	 * Return early if we don't need to get clk or we have already tried it
>  	 * earlier.
> @@ -1261,18 +1263,19 @@ static struct opp_table *_update_opp_table_clk(struct device *dev,
>  
>  	/* Find clk for the device */
>  	opp_table->clk = clk_get(dev, NULL);
> -	if (IS_ERR(opp_table->clk)) {
> -		int ret = PTR_ERR(opp_table->clk);
>  
> -		if (ret == -EPROBE_DEFER) {
> -			dev_pm_opp_put_opp_table(opp_table);
> -			return ERR_PTR(ret);
> -		}
> +	ret = PTR_ERR_OR_ZERO(opp_table->clk);
> +	if (!ret)
> +		return opp_table;
>  
> +	if (ret == -ENOENT) {
>  		dev_dbg(dev, "%s: Couldn't find clock: %d\n", __func__, ret);
> +		return opp_table;
>  	}
>  
> -	return opp_table;
> +	dev_pm_opp_put_opp_table(opp_table);
> +
> +	return ERR_PTR(dev_err_probe(dev, ret, "Couldn't find clock\n"));
>  }
>  
>  /*
> 

Thanks, looks okay.

Although, I think the previous variant of coding style was a bit more appropriate, i.e. like this:

dev_err_probe(dev, "%s: Couldn't find clock: %d\n", __func__, ret);

return ERR_PTR(ret);
