Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF86338F52
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 15:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhCLOBj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 09:01:39 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:36416 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhCLOBW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 09:01:22 -0500
Received: by mail-wm1-f52.google.com with SMTP id r15-20020a05600c35cfb029010e639ca09eso15865511wmq.1;
        Fri, 12 Mar 2021 06:01:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dSgPlkTo0bSewDX1VN5wr7O5veJFSznpHWcEpbI4QKM=;
        b=H5wckEC1Syf3wGHcBxgHmkYON/e8XPwf3RV3SoH6hNyv0vXkaNxPhlziTGBNZo/rsE
         xS10zraOqCPt0l9zWgmzMpIKMuDpwC8mjgKqcDtzi2OA8Yh+lM5YvMIq3R1KsxLH77Qd
         KBYGk5E/3zfWF3FNVzb2xROS4crMGLQT/YxgOM0GAOZlvSJyKqgAgTT33NWcA+HRfpzt
         PZwHEco577fhBiYJVx66LsdWoE/gKZWHDGc6e6hoqQJRUJhkrWovudBQ7QZOmZ0Dh8e6
         1WgTriiGHB60yhrdR4rMRAcBmrMRkr1hWOURRD4kJekquLfeMtWC5kr2CnZ/UG+V+KOD
         WI5A==
X-Gm-Message-State: AOAM530i9uwwxRopeAg42D9dllDp727QFKyjhlHc+sjY4f+L1THf4gZN
        fgak9I+oJg+4lN/VHqBLDQY=
X-Google-Smtp-Source: ABdhPJwiZEetYlMeeisQXsl4kW/wbXmh4k53PtOmwkq0FytsdghJcrC1Stammny/+lC5OhGuLfZizQ==
X-Received: by 2002:a1c:f406:: with SMTP id z6mr13529356wma.24.1615557679040;
        Fri, 12 Mar 2021 06:01:19 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id l9sm2170676wmq.2.2021.03.12.06.01.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 06:01:17 -0800 (PST)
Subject: Re: [PATCH] cpufreq: Rudimentary typos fix in the file
 s5pv210-cpufreq.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
References: <20210312120817.12604-1-unixbhaskar@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <4c0c0738-72c3-7704-500a-28cb1a068aa1@kernel.org>
Date:   Fri, 12 Mar 2021 15:01:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210312120817.12604-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/03/2021 13:08, Bhaskar Chowdhury wrote:
> 
> s/untile/until/
> s/souce/source/
> s/divier/divider/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  drivers/cpufreq/s5pv210-cpufreq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
> index bed496cf8d24..1cfea5339beb 100644
> --- a/drivers/cpufreq/s5pv210-cpufreq.c
> +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> @@ -378,7 +378,7 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
>  		/*
>  		 * 6. Turn on APLL
>  		 * 6-1. Set PMS values
> -		 * 6-2. Wait untile the PLL is locked
> +		 * 6-2. Wait until the PLL is locked
>  		 */
>  		if (index == L0)
>  			writel_relaxed(APLL_VAL_1000, S5P_APLL_CON);
> @@ -390,7 +390,7 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
>  		} while (!(reg & (0x1 << 29)));
> 
>  		/*
> -		 * 7. Change souce clock from SCLKMPLL(667Mhz)
> +		 * 7. Change source clock from SCLKMPLL(667Mhz)
>  		 * to SCLKA2M(200Mhz) in MFC_MUX and G3D MUX
>  		 * (667/4=166)->(200/4=50)Mhz
>  		 */
> @@ -439,7 +439,7 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
>  	}
> 
>  	/*
> -	 * L4 level need to change memory bus speed, hence onedram clock divier
> +	 * L4 level need to change memory bus speed, hence onedram clock divider

Also grammar fix: need/needs.

Best regards,
Krzysztof
