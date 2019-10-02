Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79953C9387
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 23:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfJBVde (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 17:33:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45180 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfJBVde (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2019 17:33:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id y72so281797pfb.12
        for <linux-pm@vger.kernel.org>; Wed, 02 Oct 2019 14:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8XR0z8nVsrTH9SjYUvL864JxswMR5JXpGrN9af9PQc0=;
        b=egPSRHXxNXrqsqqU3qFdaZ/q1JB3mN2LSZEDi7SwD9fc3pG/S2pxMLfZZmx8Wrx1ws
         iDcUFhanpu0/y9JLriS74G9REK/5Xi6gCaIg0t3Fj8BTEekt0nq3CUfw8bYPAquqc+ii
         WEr2VvrLcKtzsTki0nP3KtJ/TSuOCUOLYnj0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8XR0z8nVsrTH9SjYUvL864JxswMR5JXpGrN9af9PQc0=;
        b=ZZlU2JtONNebznE5oUMWjU4U7OAdAgfn+wvyPmIym5I+p/3E7hndye8uss/zg449tf
         l7jbOS6+UYlBTj1+HakQ6+XD9kKANrmeTiFgQ+6ev7eRKcbl7s83OWOwRsIujbNWE28G
         VEpQ7nXZcWi6L/qLK0vnlBOSlcaL8Wx0dUxNpo6mmqFwasOMenuRBdtxgRpswsqWW3Ht
         W8xP2UdmQZWumqAtc6XLqmSTnwHMevPOyIR9lU7+Hl4UQFN6jWWoaVQQJysTLsM7Z3X8
         mtjoVIABg0fu6hkGNtBt6urlFIXIz1iAZVTwruzRIur+gr8fE1EKMEk6bmlt8V+uYrsW
         9B7Q==
X-Gm-Message-State: APjAAAWbGFW5y18F7qkjO6vJIx3BUWjf4NDVqHTD8b/JVkgx0tXJ7f4k
        okNf3BQzYZE6tq7y3gktFNpZoA==
X-Google-Smtp-Source: APXvYqyQIgtvZsqL/4S3dtAlXaur3e2GH1E+K5/9qdE4PswmIsWs22/2sffAY0ZoGs1OpAIqAJbbLg==
X-Received: by 2002:a17:90b:903:: with SMTP id bo3mr6676659pjb.52.1570052013681;
        Wed, 02 Oct 2019 14:33:33 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id p189sm288617pga.2.2019.10.02.14.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 14:33:32 -0700 (PDT)
Date:   Wed, 2 Oct 2019 14:33:30 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 3/8] PM / devfreq: Set scaling_max_freq to max on OPP
 notifier error
Message-ID: <20191002213330.GG87296@google.com>
References: <cover.1570044052.git.leonard.crestez@nxp.com>
 <bee69d4635f83d8812fedbc108beb6c51ac9d4e7.1570044052.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bee69d4635f83d8812fedbc108beb6c51ac9d4e7.1570044052.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 02, 2019 at 10:25:06PM +0300, Leonard Crestez wrote:
> The devfreq_notifier_call functions will update scaling_min_freq and
> scaling_max_freq when the OPP table is updated.
> 
> If fetching the maximum frequency fails then scaling_max_freq remains
> set to zero which is confusing. Set to ULONG_MAX instead so we don't
> need special handling for this case in other places.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/devfreq/devfreq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 32bbf6e80380..3e0e936185a3 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -557,12 +557,14 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
>  	devfreq->scaling_min_freq = find_available_min_freq(devfreq);
>  	if (!devfreq->scaling_min_freq)
>  		goto out;
>  
>  	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
> -	if (!devfreq->scaling_max_freq)
> +	if (!devfreq->scaling_max_freq) {
> +		devfreq->scaling_max_freq = ULONG_MAX;
>  		goto out;
> +	}
>  
>  	err = update_devfreq(devfreq);
>  
>  out:
>  	mutex_unlock(&devfreq->lock);
> -- 
> 2.17.1
> 

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
