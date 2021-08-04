Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B343DFA28
	for <lists+linux-pm@lfdr.de>; Wed,  4 Aug 2021 06:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhHDEC7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Aug 2021 00:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhHDECv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Aug 2021 00:02:51 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11CAC0613D5
        for <linux-pm@vger.kernel.org>; Tue,  3 Aug 2021 21:02:39 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id k2so1534882plk.13
        for <linux-pm@vger.kernel.org>; Tue, 03 Aug 2021 21:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZB8hSYRKOrLl+E7loPd/8HK8c+ZXrxlOogYwUY2eSfs=;
        b=xuIYEBsn2ryqdGX+FkuwetInmokALqieaEGMa8kT90J0hA64MKJqN0LJ878I/0lb0v
         tkhcV8blLh+C1rmWsmvy+Aux/jdhiT9Z2rmcDr7uPC1+pfCN/TZGCpfWTV0diARD4xwW
         UItWZf4bsjcUCjL2MGH5HHjx8MZY17xbW0F97PHlpCMA5NvJM5uemsbs9K81DN50Eu5A
         XzbRGMyFC8HsaYITWy9qRAGTQ3aa158OQn+jl4R4IlsMlUWJ2m4LjsxYsCN0UCHOnM2/
         4aCgBGoeHSX9jDDlyxsLDysGL9MslKaWc4w2pOpAODcJrvOQigULv7OqP4th2UBSFISU
         hbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZB8hSYRKOrLl+E7loPd/8HK8c+ZXrxlOogYwUY2eSfs=;
        b=NonCRX6URCBSpM6Lf+cbCQ4yKWbmSC7BplacMb3c3uycruRFffZhxzph3uyZetX50x
         8F34Q4FKij0swZU1YGh2IJTMCXR4cvqbZ4tsB1i2xGXxI69oHJ2sveVtZ/FCdkbAu0iP
         GMLxFHuGOfv0FBhRApxtpT2htt9jCZWpkaxG1wgvjkDwdWDXRhf/XHm7nzg78f4lq0NS
         lG+n5VjAVijbpHnvAmMFt6JZAfq3YrABi14ER4Sskbnkf9MxnxO13ZmwCMSHm+VnTj5x
         h40OynnfqblyXGXHQmwSZKxXI+gh73z/6ullUhVN9ljscna4atUFfICz5+fKQzwIBufh
         KYaA==
X-Gm-Message-State: AOAM531AMJVOFQwieKI1Qcbrf6p9DDR/o+V2E6X+2ymBMtjH8l9qy7c0
        jvVDJ0eXUBdnbva8XS/pVJfDeA==
X-Google-Smtp-Source: ABdhPJy3dsyNIt/AZvz2RkHKRr3vR7DVqumnZSQuCTMohgzQ/9WXO5p0bWhT04eDCNmAyiuOnAi//g==
X-Received: by 2002:a17:902:ce8f:b029:12c:c4e7:682d with SMTP id f15-20020a170902ce8fb029012cc4e7682dmr7288244plg.58.1628049759151;
        Tue, 03 Aug 2021 21:02:39 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id g20sm723281pfv.88.2021.08.03.21.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 21:02:38 -0700 (PDT)
Date:   Wed, 4 Aug 2021 09:32:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        cristian.marussi@arm.com, rjw@rjwysocki.net,
        nicola.mazzucato@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: arm_scmi: Fix error path when allocation
 failed
Message-ID: <20210804040237.ssrba26jpe572mjf@vireshk-i7>
References: <20210803090744.12143-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803090744.12143-1-lukasz.luba@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-08-21, 10:07, Lukasz Luba wrote:
> Stop the initialization when cpumask allocation failed and return an
> error.
> 
> Fixes: 80a064dbd556 ("scmi-cpufreq: Get opp_shared_cpus from opp-v2 for EM")
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
> changes:
> v2:
> - removed dev_warn() since it's not needed in this case
> - adjusted the patch description
> 
>  drivers/cpufreq/scmi-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index ec9a87ca2dbb..75f818d04b48 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -134,7 +134,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>  	}
>  
>  	if (!zalloc_cpumask_var(&opp_shared_cpus, GFP_KERNEL))
> -		ret = -ENOMEM;
> +		return -ENOMEM;
>  
>  	/* Obtain CPUs that share SCMI performance controls */
>  	ret = scmi_get_sharing_cpus(cpu_dev, policy->cpus);

Applied. Thanks.

-- 
viresh
