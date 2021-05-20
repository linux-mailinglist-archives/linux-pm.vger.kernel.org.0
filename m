Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3E3389C2F
	for <lists+linux-pm@lfdr.de>; Thu, 20 May 2021 05:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhETD43 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 May 2021 23:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhETD43 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 May 2021 23:56:29 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46CDC061574
        for <linux-pm@vger.kernel.org>; Wed, 19 May 2021 20:55:08 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t11so8437753pjm.0
        for <linux-pm@vger.kernel.org>; Wed, 19 May 2021 20:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OZ6VS2QJMKCzoPLlDNWgVyV4xwBqPYXMZ6s6V0FP1g0=;
        b=oCmte63xvzhUNs94qdZmYE6cRuv8cTD8Rvshq/a7UxcZbRheldugpn+yj5tUJG5TZA
         YIcDm4hUw/dJeTSW9V/Vn8igeqZ3UYxi3tNM/C3DlPq2991nYIu+uEBwm27mMacvEM/A
         H6NFPJTjV8F4g5wP4iTbd8f1/BtJlDUksBLvjlSf/gjyxdpJXT0kCWu+YRtzzAT9q7hH
         Gs/Ajy71xyCSZeCNYSAXdE6tzOgyFlSevqz5zWiXU9CX3th7UJXM/7TCYNY8w/0EYhxf
         rdm8tPR/ozfZei20s92L+3M7SVal9aLKmwnMjpSZG/P/oxSwf3HHVMdqsWW7a3H6kTPB
         rdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OZ6VS2QJMKCzoPLlDNWgVyV4xwBqPYXMZ6s6V0FP1g0=;
        b=OSKppoSHqIE/4W9OH8ycGKzzfYk6sGCwDTHRIbOIb54CFSN3M2ZEJqdXhhUpskHL7W
         3N+2SiZkEvymZd1/nxxksdQSF6nztiNYhWyv5pvPKqmiFfdQHlVeZkEjsG7Lgm7ygusF
         OiNNX26geAWKYYsbxjbaH2Lz4+9YQ1jtEHP/zSa6dIUb5gDgR6L1GbWe4mPUm/h8Xc6E
         CN32UG4pBF6zW/FZiXO9zXtwQ4MJ7AK2tCHi6QZXgbS/5X97izcumgcfk6vzB+hiTZfx
         kSzPdXQOjsZCQ8kg0NuRoGuhG1Ruav7hdpoFsmNHFYWRBjaxogPzvpekZ1wLJfDvXFHa
         ntwg==
X-Gm-Message-State: AOAM531giUkDLYEkDrev3YkdHIvnMzU+/wIcOtIbi0Nz5cic6W3NOOxo
        eb2RtsIckLyQmKCK5TtWbSKXsw==
X-Google-Smtp-Source: ABdhPJzcJpX0uew5mRSMgYp21Vdrcgs5nOW8XPejq4gAYE/EMCAHLekXJ5VZxMf7m+5mTmTbj7cGww==
X-Received: by 2002:a17:902:8205:b029:f4:a8f3:78c8 with SMTP id x5-20020a1709028205b02900f4a8f378c8mr3352663pln.11.1621482908279;
        Wed, 19 May 2021 20:55:08 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id 6sm689249pfx.117.2021.05.19.20.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 20:55:07 -0700 (PDT)
Date:   Thu, 20 May 2021 09:25:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        mkorpershoek@baylibre.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] cpufreq: mediatek: add support for mt8365
Message-ID: <20210520035506.2ufedv7vj6wz2nze@vireshk-i7>
References: <20210519162550.3757832-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519162550.3757832-1-fparent@baylibre.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-05-21, 18:25, Fabien Parent wrote:
> Add compatible stirng for MediaTek MT8365 SoC. Add also the
> compatible in the blacklist of the cpufreq-dt-platdev driver.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  drivers/cpufreq/mediatek-cpufreq.c   | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 5e07065ec22f..d6fd821e3f5a 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -126,6 +126,7 @@ static const struct of_device_id blacklist[] __initconst = {
>  	{ .compatible = "mediatek,mt8173", },
>  	{ .compatible = "mediatek,mt8176", },
>  	{ .compatible = "mediatek,mt8183", },
> +	{ .compatible = "mediatek,mt8365", },
>  	{ .compatible = "mediatek,mt8516", },
>  
>  	{ .compatible = "nvidia,tegra20", },
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index f2e491b25b07..87019d5a9547 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -537,6 +537,7 @@ static const struct of_device_id mtk_cpufreq_machines[] __initconst = {
>  	{ .compatible = "mediatek,mt8173", },
>  	{ .compatible = "mediatek,mt8176", },
>  	{ .compatible = "mediatek,mt8183", },
> +	{ .compatible = "mediatek,mt8365", },
>  	{ .compatible = "mediatek,mt8516", },
>  
>  	{ }

Applied. Thanks.

-- 
viresh
