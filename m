Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8713005C8
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 15:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbhAVOoO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 09:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728711AbhAVOoJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 09:44:09 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A78AC0613D6;
        Fri, 22 Jan 2021 06:43:28 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id v24so7849924lfr.7;
        Fri, 22 Jan 2021 06:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jMCudtyynWmB7aEQ/2mKpdIPdrvLhwN7tSnOotK9LLI=;
        b=UgLsWgsqDo0PWlYSTqySwM79RfGQMLk763CR8UmKZXKS/8bK5ZrkdEN8U2jcJ27cyg
         mCCZfsZdDourpx+D5zVHWAgGYk652CMO/HMZ9ItQHwBxUb+RmB/2JNgi5wwLp4wJzxva
         HXtaLX1yQ1fPAqXbLgohmJVYHy5t5Her6KRw51IUSU8ohnli6vZxsroOh8duQcYPo2fN
         EAPr9IzGCYVhvXnDQcOxBz5cipjkLWCrqtdASR/icQx4aPnGJYae7Irs8p2xWFDBK3PT
         UVPrn4lkMJGjcuZ+KqpE9yk++lo+GzfVYveNe/i5gUk0j/yP30PdEDYFm252fejH63pN
         cdYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jMCudtyynWmB7aEQ/2mKpdIPdrvLhwN7tSnOotK9LLI=;
        b=Lw9qN/FGKDywJSGAvkLVTTLkQ+C+IaV5gmlYVJxNVLwbDagHQYAX7x5ibhflaoFpl2
         6QjFfgcMrHtLb/NuzXQHObOFuisdfxY1IkdQ0mbbxy2no7mgAMVt+QNs/VIQgn4U02gT
         SSqlu2CCoZHR1dQsGOZn/3rEgIMVVFHnbCOMC7L76ba3A++M/yGoHHkYN+u0O8NLtfK5
         tmrQaMOLjlovFBoiA8NKouSJjTUL1piygSVu5I/DQld+kzhhQPEHH4t0kBedMp+fsnqp
         QJFxC7DZQbixlHTSmZzhO35+jqCTiuXdoeevQvD8vuelXKQ2+OWGtIpq0q2YVkjzHWTO
         UPFA==
X-Gm-Message-State: AOAM531CI8k41jsh+F7MI5fW/uxUPEOjTzIKbtoLp+uXY4XeVXFQX2GX
        IvNLDfsINDirnkw+G6jqzZc/sLOAb/s=
X-Google-Smtp-Source: ABdhPJycITAP+Nn8TYcngrjKYta9sqfgBgAfbSDZg3ga0+Ho3RkCOoZt5xzANvLS6FuHSWClofLUGg==
X-Received: by 2002:a05:6512:30a:: with SMTP id t10mr2152286lfp.124.1611326606916;
        Fri, 22 Jan 2021 06:43:26 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id p3sm905611lfu.271.2021.01.22.06.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 06:43:26 -0800 (PST)
Subject: Re: [PATCH v4 4/4] opp: Make _set_opp_custom() work without
 regulators
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210120222649.28149-1-digetx@gmail.com>
 <20210120222649.28149-5-digetx@gmail.com>
Message-ID: <91ae0843-3387-a8c4-6153-0599249ab367@gmail.com>
Date:   Fri, 22 Jan 2021 17:43:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210120222649.28149-5-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

21.01.2021 01:26, Dmitry Osipenko пишет:
> Check whether OPP table has regulators in _set_opp_custom() and set up
> dev_pm_set_opp_data accordingly. Now _set_opp_custom() works properly,
> i.e. it doesn't crash if OPP table doesn't have assigned regulators.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/opp/core.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 08d205a55c07..c38ac1cf62ac 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -829,23 +829,31 @@ static int _set_opp_custom(const struct opp_table *opp_table,
>  			   struct dev_pm_opp_supply *new_supply)
>  {
>  	struct dev_pm_set_opp_data *data;
> -	int size;
> +	int size, regulator_count;
> +
> +	if (opp_table->sod_supplies)
> +		regulator_count = opp_table->regulator_count;
> +	else
> +		regulator_count = 0;
>  
>  	data = opp_table->set_opp_data;
>  	data->regulators = opp_table->regulators;
> -	data->regulator_count = opp_table->regulator_count;
> +	data->regulator_count = regulator_count;
>  	data->clk = opp_table->clk;
>  	data->dev = dev;
>  
>  	data->old_opp.rate = old_freq;
> -	size = sizeof(*old_supply) * opp_table->regulator_count;
> -	if (!old_supply)
> -		memset(data->old_opp.supplies, 0, size);
> -	else
> -		memcpy(data->old_opp.supplies, old_supply, size);
> -
>  	data->new_opp.rate = freq;
> -	memcpy(data->new_opp.supplies, new_supply, size);
> +
> +	if (regulator_count) {
> +		size = sizeof(*old_supply) * opp_table->regulator_count;
> +		if (!old_supply)
> +			memset(data->old_opp.supplies, 0, size);
> +		else
> +			memcpy(data->old_opp.supplies, old_supply, size);
> +
> +		memcpy(data->new_opp.supplies, new_supply, size);
> +	}
>  
>  	return opp_table->set_opp(data);
>  }
> 

Looks good, thank you!
