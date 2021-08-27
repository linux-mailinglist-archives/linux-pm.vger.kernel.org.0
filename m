Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2764E3F9219
	for <lists+linux-pm@lfdr.de>; Fri, 27 Aug 2021 03:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243959AbhH0BnB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Aug 2021 21:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243941AbhH0BnB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Aug 2021 21:43:01 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D4CC061757;
        Thu, 26 Aug 2021 18:42:13 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id o10so10905374lfr.11;
        Thu, 26 Aug 2021 18:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DbfO6q4GXpyBccwxPwmjY0PAuMwlFBkYaU8fNql3Y5I=;
        b=nuwyVodyulgYm4czoyEH8CnfsucjmsDIbhhVJQubczBBrb+3c5nYUTJDGgP7eLg5Us
         kqJ9/M6jB4TpQ9CT5jc7nzqqhVHkT5AacFL1o0zzAA+JS48YkQYG5OgGAgVZil0cQGQQ
         Pi+JxtPcKFIypfqQd5lWX+V6/On+MCjQichjie9DlX1Se2Zt9OsqSHpC6Y2mk47Xobd+
         kQJBEchshDO/0mPvipGD05R5y3jPixPzjwOUWuklHB4QIt6zkfxW4SCy3Yq5nydl0Hem
         Ovh6DYw/iTfGvb1mwSEHLKqvtPsto++MecR84ZewEEQ5sySmkeP/s+6kSNhbm5YBJgLl
         MEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DbfO6q4GXpyBccwxPwmjY0PAuMwlFBkYaU8fNql3Y5I=;
        b=B3WUBA0u6VTc/mqRZTRjmnitswNtgwTTxMNLz/Ot0H5mP3OB72lFfggqsCtcmY+GuG
         61UQF9BtE3DFx50PxOyR3I9JofgQXIzTYPC69796Vshez2rwgAa6PFitR9WiPFhkVDP6
         yZqBInC7pUl81erZYuqPAVWR+/CarMPVfWb6OfATr/dEsdZQyIoteUI3FN7IMg4I1B5v
         8aZrgIrtSl+JCkuSAAs6RsZLFWhQ8VVtuTliqcSbd6i44mLORbmIrKVmsj5azSSJYFqJ
         TDY8GhO9DNjbQetaPvhn2yxbtetrc+MO6P6DCcJRygV6HL7WvyCDfHGV03BBrF4sweVs
         asqQ==
X-Gm-Message-State: AOAM530ZVHWcROcqTcDceBpCOXYf+SYxSA9rm1zjE5IFsTmcL5dUoqAg
        le1eXlCxJIITorjuiePs6r3fzx7cmqg=
X-Google-Smtp-Source: ABdhPJwXKANeBz7m7HyS9Ky0XhrHdPodup8uo+ZqGxp0t+fgy4uAdlqcZTBVApfoB+4KYRwK9tSIww==
X-Received: by 2002:a05:6512:3b14:: with SMTP id f20mr5101489lfv.614.1630028531264;
        Thu, 26 Aug 2021 18:42:11 -0700 (PDT)
Received: from [192.168.2.145] (94-29-17-251.dynamic.spd-mgts.ru. [94.29.17.251])
        by smtp.googlemail.com with ESMTPSA id z11sm515859ljn.114.2021.08.26.18.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 18:42:10 -0700 (PDT)
Subject: Re: [PATCH v9 1/8] opp: Add dev_pm_opp_from_clk_rate()
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210827013415.24027-1-digetx@gmail.com>
 <20210827013415.24027-2-digetx@gmail.com>
Message-ID: <73ae8568-cd81-08a8-796b-77b88ffce5e8@gmail.com>
Date:   Fri, 27 Aug 2021 04:42:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210827013415.24027-2-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

27.08.2021 04:34, Dmitry Osipenko пишет:
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 04b4691a8aac..fae5267f5218 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -939,7 +939,8 @@ static int _set_required_opps(struct device *dev,
>  	return ret;
>  }
>  
> -static void _find_current_opp(struct device *dev, struct opp_table *opp_table)
> +static struct dev_pm_opp *
> +_find_current_opp(struct device *dev, struct opp_table *opp_table)
>  {
>  	struct dev_pm_opp *opp = ERR_PTR(-ENODEV);
>  	unsigned long freq;
> @@ -961,7 +962,7 @@ static void _find_current_opp(struct device *dev, struct opp_table *opp_table)
>  		mutex_unlock(&opp_table->lock);
>  	}
>  
> -	opp_table->current_opp = opp;
> +	return opp;
>  }
>  
>  static int _disable_opp_table(struct device *dev, struct opp_table *opp_table)
> @@ -1003,7 +1004,7 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
>  
>  	/* Find the currently set OPP if we don't know already */
>  	if (unlikely(!opp_table->current_opp))
> -		_find_current_opp(dev, opp_table);
> +		opp_table->current_opp = _find_current_opp(dev, opp_table);
>  
>  	old_opp = opp_table->current_opp;
>  
> @@ -2931,3 +2932,38 @@ int dev_pm_opp_sync_regulators(struct device *dev)
>  	return ret;
>  }

Please skip these lines. I missed to remove them during rebase and
haven't noticed until now.
