Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9184A296C54
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 11:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461710AbgJWJtw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 05:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461709AbgJWJtv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 05:49:51 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9E5C0613CE
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2020 02:49:50 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y14so725567pfp.13
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2020 02:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ds+2AlesstNrjvv4nwcmxJSo/ieAs5ttHx4GXc+QWbk=;
        b=OY+DErmPYRR3ebQio2a29igZWWNeZmqL3nn26tCPBqhUuOCHais3VBn1dsbfwJZAAU
         FP24up9hB5LW8UM9pF56Nl/Fkt5U8296/ykJ8MFWk9X9+be91hyxbWsZrpSuJMscczNl
         OmDQ6X16WFYJuzO9Lr0tzFKDEvigxw5OCbdaG69HUVzh6GFZB3ZlhT1Roy+C9m3n18HB
         GlOjnQFyBEuAXOyTFQZYsxgILmX4vdZhCcRWVPylDoYjbovaj5Ct08Cbk4lOeMQblrKS
         Nf9IVFwE3qsDGl9/mzKwHOsO35InyKZDEIlm4GijUHSvp9rcBTyyjGHYJb8EGgZkDo0+
         9lpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ds+2AlesstNrjvv4nwcmxJSo/ieAs5ttHx4GXc+QWbk=;
        b=juqnbcypILfRelm3RDNOaIjI9wtDE0CcyDvbxlBnUiINXY5kBgdwUwMaPGhxYveNV9
         93JgPaN4YDU+z8QGuLYmiSGcjhkg5EYJuuw2g7BgDV5MWB5UoZuKjrQfC8JSqk7bSqJH
         UaYQusHsnFT0Lt/LWoV+HDBIWi0IYWnUAAMEFxu++XXDu4YnuRgnIEdnSAupBSBC2nyj
         s0yQnj8SgMzGrj98iU4Fu1M3oV7UJIcNdZv7ATmzNNNiLLkpz397xiM1fPui4uZjyPGk
         4ejXRXXeZBXRr4z3T43eaN0Sd16DWn0UMzPIsuzeovJiMbp5YR7PrW4nEMgt6JkM2O6g
         Xf+A==
X-Gm-Message-State: AOAM531GFzO69cPLEs8Md3qPuFVVUdRPCffTZQazfEA6awzNHWUkXTCC
        DecYLgJcQ3hCcK7JEV7ibxDWxA==
X-Google-Smtp-Source: ABdhPJxx/4ESNHLGEf1LUWJQ4QHYkPBY+5yW6nifdizpiMsp51gRj/0uMm1irkxLyMAT1nMWudlRBA==
X-Received: by 2002:a17:90b:8c8:: with SMTP id ds8mr1554695pjb.40.1603446589577;
        Fri, 23 Oct 2020 02:49:49 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id ch21sm1609961pjb.24.2020.10.23.02.49.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Oct 2020 02:49:48 -0700 (PDT)
Date:   Fri, 23 Oct 2020 15:19:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Zhang Qilong <zhangqilong3@huawei.com>
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org
Subject: Re: [PATCH -next] cpufreq: remove unnecessary break
Message-ID: <20201023094946.ufaq746d33or5pmk@vireshk-i7>
References: <20201023095839.32218-1-zhangqilong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023095839.32218-1-zhangqilong3@huawei.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-10-20, 17:58, Zhang Qilong wrote:
> A 'break' is not needed because of previous 'return'
> 
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> ---
>  drivers/cpufreq/e_powersaver.c | 1 -
>  drivers/cpufreq/longhaul.c     | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/e_powersaver.c b/drivers/cpufreq/e_powersaver.c
> index 776a58bab0ff..ab93bce8ae77 100644
> --- a/drivers/cpufreq/e_powersaver.c
> +++ b/drivers/cpufreq/e_powersaver.c
> @@ -223,7 +223,6 @@ static int eps_cpu_init(struct cpufreq_policy *policy)
>  	case EPS_BRAND_C3:
>  		pr_cont("C3\n");
>  		return -ENODEV;
> -		break;
>  	}
>  	/* Enable Enhanced PowerSaver */
>  	rdmsrl(MSR_IA32_MISC_ENABLE, val);
> diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
> index 123fb006810d..182a4dbca095 100644
> --- a/drivers/cpufreq/longhaul.c
> +++ b/drivers/cpufreq/longhaul.c
> @@ -593,7 +593,6 @@ static void longhaul_setup_voltagescaling(void)
>  		break;
>  	default:
>  		return;
> -		break;
>  	}
>  	if (min_vid_speed >= highest_speed)
>  		return;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
