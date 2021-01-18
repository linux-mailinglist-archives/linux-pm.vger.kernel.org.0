Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C202FACE4
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 22:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388792AbhARVmv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 16:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388664AbhARJ6y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 04:58:54 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9B1C061575
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 01:58:13 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id q4so8362822plr.7
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 01:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J5Dlakpa6uscV9wI+hxTT1e6AnkifWVChxQ3u0oHgAk=;
        b=b5hJhCKrotp/TDa/9Uf1MBhZqtL56ZL4fDD75pbp7afcoNHFk5rAdvanGFJON/fanQ
         e5pv+XHqAQBdZcAuM/UyKyPEzwaIbVqoGa96d8Mm17HDCdvg5NeOJzazAzp4qnY3vhP9
         7gHzWCsuQQpM/dz5MXkSqfynpOoaf3qHJQUty/nrVTWDlpTWM/gpq7JLR+COChxk7/LN
         EsEVH7mDRFodrON3MCceSSRAxQxI54/Jbya/tPpNCxIjgFvCzXX4a71Et0bso4OGqt7k
         6Wan2n0Gl6u3CMMw9nnjDyVZXpY0efE2vTGbs994tqbA6wnF5AIY/s0Srk0Pmd8y9LJb
         q32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J5Dlakpa6uscV9wI+hxTT1e6AnkifWVChxQ3u0oHgAk=;
        b=jkEIGyY1diIlN45uW0IpaUUIKNoli9l4P5yiy+Rn/f7Z6aAUkIXgMKxbZJi0Uv52J1
         Zpr/qaUghuRS/sb/paQLl5KZMV7iW6UYwDSo9aDZ3rtpW1dqD50VGTHOEZxQUHcGgpGm
         Mdb63RM0Q2KLoOs6h8K2WQfvWIsH/Nk+WOdVLjqBAqOqC9k7oukkBbkWSzl/COpQuml6
         8taXePckseTSrmiohbNXXqIyigoCtxSlX83jtoqmU6e0a1e5bkPVG8IQph7TIdW+HA+9
         bzAzrmSe2ODmuJ051wztHEr3zvqJG3hZShuXA9wOEgTcqP6u+e8mYNwzuNM5nNORb7hZ
         xGGg==
X-Gm-Message-State: AOAM5318D6MRzmGdAye92E+m+Wc7b/6yNGGhjSO2w2il1n/Wqmai0Plv
        dAk/t/q8mPCmtBNN5owKMC/nOw==
X-Google-Smtp-Source: ABdhPJzSn0ETidLntnQdkh8DW6sl+g3rqAMIpMzhQZ9ghdObttxe4TiUGn/0B/YlcXT/eWavHFQEow==
X-Received: by 2002:a17:902:6b02:b029:da:c6c0:d650 with SMTP id o2-20020a1709026b02b02900dac6c0d650mr25918569plk.74.1610963893396;
        Mon, 18 Jan 2021 01:58:13 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id p8sm15780055pjo.21.2021.01.18.01.58.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 01:58:12 -0800 (PST)
Date:   Mon, 18 Jan 2021 15:28:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
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
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 06/12] opp: Add dev_pm_opp_find_level_ceil()
Message-ID: <20210118095810.ta7cy7kjntalfnx7@vireshk-i7>
References: <20210118005524.27787-1-digetx@gmail.com>
 <20210118005524.27787-7-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118005524.27787-7-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-01-21, 03:55, Dmitry Osipenko wrote:
> Add a ceil version of the dev_pm_opp_find_level(). It's handy to have if
> levels don't start from 0 in OPP table and zero usually means a minimal
> level.
> 
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> Tested-by: Matt Merhar <mattmerhar@protonmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/opp/core.c     | 49 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h |  8 +++++++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 341484d58e6c..df0969002555 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -449,6 +449,55 @@ struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_exact);
>  
> +/**
> + * dev_pm_opp_find_level_ceil() - search for an rounded up level
> + * @dev:		device for which we do this operation
> + * @level:		level to search for
> + *
> + * Return: Searches for rounded up match in the opp table and returns pointer
> + * to the  matching opp if found, else returns ERR_PTR in case of error and
> + * should be handled using IS_ERR. Error return values can be:
> + * EINVAL:	for bad pointer
> + * ERANGE:	no match found for search
> + * ENODEV:	if device not found in list of registered devices
> + *
> + * The callers are required to call dev_pm_opp_put() for the returned OPP after
> + * use.
> + */
> +struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
> +					      unsigned int *level)
> +{
> +	struct opp_table *opp_table;
> +	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
> +
> +	opp_table = _find_opp_table(dev);
> +	if (IS_ERR(opp_table)) {
> +		int r = PTR_ERR(opp_table);
> +
> +		dev_err(dev, "%s: OPP table not found (%d)\n", __func__, r);
> +		return ERR_PTR(r);
> +	}
> +
> +	mutex_lock(&opp_table->lock);
> +
> +	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
> +		if (temp_opp->available && temp_opp->level >= *level) {
> +			opp = temp_opp;
> +			*level = opp->level;
> +
> +			/* Increment the reference count of OPP */
> +			dev_pm_opp_get(opp);
> +			break;
> +		}
> +	}
> +
> +	mutex_unlock(&opp_table->lock);
> +	dev_pm_opp_put_opp_table(opp_table);
> +
> +	return opp;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_ceil);
> +
>  static noinline struct dev_pm_opp *_find_freq_ceil(struct opp_table *opp_table,
>  						   unsigned long *freq)
>  {
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index f344be844bde..b7dc993487c7 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -111,6 +111,8 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
>  					      bool available);
>  struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
>  					       unsigned int level);
> +struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
> +					      unsigned int *level);
>  
>  struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
>  					      unsigned long *freq);
> @@ -234,6 +236,12 @@ static inline struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
>  	return ERR_PTR(-ENOTSUPP);
>  }
>  
> +static inline struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
> +					unsigned int *level)
> +{
> +	return ERR_PTR(-ENOTSUPP);
> +}
> +
>  static inline struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
>  					unsigned long *freq)
>  {

Applied. Thanks.

-- 
viresh
