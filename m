Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F2F6CF9D4
	for <lists+linux-pm@lfdr.de>; Thu, 30 Mar 2023 05:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjC3D4U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Mar 2023 23:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjC3D4R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Mar 2023 23:56:17 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234F85252
        for <linux-pm@vger.kernel.org>; Wed, 29 Mar 2023 20:56:16 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id z19so16927808plo.2
        for <linux-pm@vger.kernel.org>; Wed, 29 Mar 2023 20:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680148575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lJXVAs2LvL25HAIC0YoBuUnogToPjprkwIwJI/mvA/Y=;
        b=EfqNB7z/UIiQkcE+wUyXMQxvirYl67cKtAKFp95pPIF7b0mlGTSUfsOe2GvOT/TBq5
         z8KqaPOKHxpUoGl8KYlgLqJvHq+84QrvQB3/uLOzzkToyC3OrsFUeYLMzOwhPmPUI4XY
         iGfqLvHKDbb6OlHqU69UPjwHTOiWyW9Ro04cx4D5mK+h3gj5nOa5Y1R3d04u0GcKWH7c
         MN57OqQC73GtnGZk0zGFqjfBaCsFri14dJ5gWYHDR8ZbyPS+w4q8GAeXw8ogRtoVOQY9
         40N3TwmIP9ehIBVWVFVPeDxLtVuJ2lPw/pF7lnZC7vtYux8XlkGyas9jm4YoDEQjGVc4
         daCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680148575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJXVAs2LvL25HAIC0YoBuUnogToPjprkwIwJI/mvA/Y=;
        b=JgcKGNtICqojtHq0DNC27kxWhwyqdR2MDlhArS1q0SHoCKUFHZFMQ8cU0LctaTIuos
         UKJ3DpiwQi0WozVD+2jzIfPbCS0pbT8hmTyAfTDlDeDo+lRW1+PezAFye7lWS2GwGYzA
         HZEF3UfXV83Fi/Gymye9pq40YCWxG2NXuNgB/h/m0H3Izh1yN2u7QvQVe7wOPiFXUJp2
         Kh8lPJcpG/N5KJEMxgxxtDQPH8l8VoEJDVonrLMZ0jXWJaJmnqKuQBxNkwG9Nks1dkvm
         HlVprRI0E5EnWPwAOU+3Pxb6Z0irEfFxJRuDJ7e5e60mpD2F5RVrKG4efzJ5Sq6iAlqK
         ZokQ==
X-Gm-Message-State: AAQBX9d6jBPGBhYS5i45dm6Q69sv4RyBx9aTX3vKWws7KM9nDWpZw9tM
        EQXF2EuQRVgh0DMFsbD+IC7t+zTyH8Ghvepwvdg=
X-Google-Smtp-Source: AKy350Y4bHzSwVaP2R4ddddVL9JjndqCcTwzOh6FrpuPtk5dBHqzrz+B7C9xj2yMjVmOx92CQoKchw==
X-Received: by 2002:a17:90a:5e4d:b0:23f:58a2:7d6d with SMTP id u13-20020a17090a5e4d00b0023f58a27d6dmr23952512pji.6.1680148575089;
        Wed, 29 Mar 2023 20:56:15 -0700 (PDT)
Received: from localhost ([122.172.85.168])
        by smtp.gmail.com with ESMTPSA id mr17-20020a17090b239100b002369a14d6b1sm2195578pjb.31.2023.03.29.20.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 20:56:14 -0700 (PDT)
Date:   Thu, 30 Mar 2023 09:26:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yang Shi <yang@os.amperecomputing.com>
Cc:     rafael@kernel.org, scott@os.amperecomputing.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org, lukasz.luba@arm.com,
        ionela.voinescu@arm.com
Subject: Re: [PATCH] cpufreq: CPPC: use 10ms delay instead of 2us to avoid
 high error
Message-ID: <20230330035612.ekh2lpqzohggg6uf@vireshk-i7>
References: <20230328193846.8757-1-yang@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328193846.8757-1-yang@os.amperecomputing.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

+ few folks.

On 28-03-23, 12:38, Yang Shi wrote:
> When testing CPPC cpufreq on our platform, we noticed the error may be quite
> high and the high error may happen quite often.  For example, on a platform
> with a maximum frequency of 2.8GHz when the CPUs were fully loaded (100% load),
> we saw cpuinfo_cur_freq may show 4GHz, it means the error is > 40%.  And the
> high error (> 1%) happened 256 times out of 2127 samples (sampled every 3
> seconds) in an approximate 2hrs test.
> 
> We tried to enlarge the delay, and tested with 100us, 1ms and 10ms.  The
> below is the results.
> 
> 100us:
> The highest error is 4GHz, 22 times out of 3623 samples
> 
> 1ms:
> The highest error is 3.3GHz, 3 times out of 2814 samples
> 
> 10ms:
> No high error anymore
> 
> Increase the measurement delay in cppc_cpufreq_get_rate to 10ms to avoid
> high measurement errors.
> 
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 022e3555407c..c2bf65448d3d 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -851,7 +851,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>  	if (ret)
>  		return ret;
>  
> -	udelay(2); /* 2usec delay between sampling */
> +	mdelay(10); /* 10msec delay between sampling */
>  
>  	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
>  	if (ret)
> -- 
> 2.39.2

-- 
viresh
