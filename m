Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E99D520F89
	for <lists+linux-pm@lfdr.de>; Tue, 10 May 2022 10:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbiEJIQc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 May 2022 04:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiEJIQc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 May 2022 04:16:32 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB7FF74B8
        for <linux-pm@vger.kernel.org>; Tue, 10 May 2022 01:12:34 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id a15-20020a17090ad80f00b001dc2e23ad84so1398464pjv.4
        for <linux-pm@vger.kernel.org>; Tue, 10 May 2022 01:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GgyywbUmtILgp/wvvcsqELPk8sbdswIe5sEtYfMivvE=;
        b=rNbeIahNNjFADBiapx76jRbHbwNwPqBjvbS/yGH4r1iAKLOzpPaEC9ZDc8hkixik73
         P5uD0eZRQv8jWs5/sV+8UV3bidqToM98pKnpRIuUkYOfhfstIwTJoPBxA/uz2PdvEQ9I
         K/m0YsAXA7u2zeUHjBxT7KL5oi8XIhwNZDjqLOxOEEC1GmumbHrC0W6UmwAJ5Nq6F40H
         ZneAzcK3oab6uJyxJMXx4u1MPuEDb9svPJ0VmuW/xJ2DAjoofz7pBDNWSY6YvAdglEAt
         GYPDfTst6IAi1aUPvylXif9IxulGpqXGh7TuOP3YdX/TJEfrA/GDsOodVmyIoqrMEjBt
         kBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GgyywbUmtILgp/wvvcsqELPk8sbdswIe5sEtYfMivvE=;
        b=Z2iz/E2IushQIudKkTh2vVkG7bSldGQWad9t7FndRFYqdo3jsJIPfkJOD7WHxXWvyd
         e1fxbfS8H6FSYvkS8xuVNz+kFGBK9+/E9XiyQ7WlsREf+R51qR+TQ0peLeqxNq2BWqtq
         6LuPVxn9GSN8VawF+f2HOHO5Bbdles3nOcYYXQUinzLq5MD+gzBh46SGP1ng0Y0LGdXM
         Mws3vWqA6lofYbKk/P99S7T4XQBcoPHu/mwknOn4WUXNX/FGWWBaoZT79TV+4HfwQ2Iu
         ZBUmH8ETvGrDb7gU1b9eLIBrt9hM0LKHJhNOMUFFf7EzEMq2iUJMVGSidUMa8OzoYxrZ
         zvjg==
X-Gm-Message-State: AOAM532PIseZuMz+cYXyXa2iuWEi2GdQCshNUrHbD4aOl7bqnPTJd7OY
        JvS6Y5jFRFSgOaWokv93fjy2EQ==
X-Google-Smtp-Source: ABdhPJwcv12Soh8pLojrYlMpwtpxb8N7+SLb4GnvbtYHqs/lqRSoCcmiAtufKplJ/GKYTHrtAaj0QA==
X-Received: by 2002:a17:903:410b:b0:15c:fd57:aa34 with SMTP id r11-20020a170903410b00b0015cfd57aa34mr19368857pld.82.1652170354409;
        Tue, 10 May 2022 01:12:34 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id b15-20020a056a0002cf00b0050dc762814dsm10011525pft.39.2022.05.10.01.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 01:12:33 -0700 (PDT)
Date:   Tue, 10 May 2022 13:42:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>,
        Jia-Wei Chang <jia-wei.chang@mediatek.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] cpufreq: mediatek: Fix potential deadlock problem in
 mtk_cpufreq_set_target
Message-ID: <20220510081232.4u25qgryszzqblho@vireshk-i7>
References: <20220510080136.11950-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510080136.11950-1-wanjiabing@vivo.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-05-22, 16:01, Wan Jiabing wrote:
> Fix following coccichek error:
> ./drivers/cpufreq/mediatek-cpufreq.c:199:2-8: preceding lock on line
> ./drivers/cpufreq/mediatek-cpufreq.c:208:2-8: preceding lock on line
> 
> mutex_lock is acquired but not released before return.
> Use 'goto out' to help releasing the mutex_lock.
> 
> Fixes: c210063b40ac ("cupful: mediatek: Add opp notification support")

cupful ??

> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index 75bf21ddf61f..4c6d53c99d79 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -196,7 +196,8 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
>  
>  	if (pre_vproc < 0) {
>  		dev_err(cpu_dev, "invalid Vproc value: %d\n", pre_vproc);
> -		return pre_vproc;
> +		ret = pre_vproc;
> +		goto out;
>  	}
>  
>  	freq_hz = freq_table[index].frequency * 1000;
> @@ -205,7 +206,8 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
>  	if (IS_ERR(opp)) {
>  		dev_err(cpu_dev, "cpu%d: failed to find OPP for %ld\n",
>  			policy->cpu, freq_hz);
> -		return PTR_ERR(opp);
> +		ret = PTR_ERR(opp);
> +		goto out;
>  	}
>  	vproc = dev_pm_opp_get_voltage(opp);
>  	dev_pm_opp_put(opp);
> -- 
> 2.35.1

-- 
viresh
