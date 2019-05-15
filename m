Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 460C31EAA3
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2019 11:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfEOJGX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 May 2019 05:06:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38642 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfEOJGX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 May 2019 05:06:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id f2so1662661wmj.3
        for <linux-pm@vger.kernel.org>; Wed, 15 May 2019 02:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wFA5k42n2PvTkAtvZj4SXJNDy7f4n0IZQu6P7nqdQFk=;
        b=X4kG2qR8EPO/1PEqo1rglf1NosQAvqluV2o4RPotqdHeFYQETZNlwgC5sp94OvPiJs
         DoCeYV3ZOP1Mg/eir1rrA11RbRZTRbQh5fZ0eCusGa01sTnEZ9/1RYUpnVv6pmKr8h6H
         txEz1vwXOa8iN9LsTSXQCGhGcnw+2W+BKlFY3oNZ3kASHHImApY32cJo0XMVKVke55Dn
         ge0bcdddHtdn1nfNfs6ecsrMZuRL+6mXCZ9f6pZ5htntcHAxs0/uki1KLEg44imWSWc8
         IHOQUocdgwy+zjsnuLk5nXtH8Fev4zefuKu5pl1FvGyF8z/MZWm3NOSPPFHpjkK1/e2k
         9/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wFA5k42n2PvTkAtvZj4SXJNDy7f4n0IZQu6P7nqdQFk=;
        b=pU1VTFYVt0Ns4t4WfamavHRv6bT6yJg/c0ckqM1tOno5yfj430EkoBo7c3FQvNXKOe
         psLwuHuArtmcBod/wtmcEH4cibbjTqYwC21y7SF6YSV68j3fF4Pf6CkaaSrs9wVkIEWk
         5HfDyKyrLvEju7qUeRMu5Tv3effelVgpI+ME4RogtwQWq696YtFakrUsBVBib/2lw8x9
         uQ+5GaG7yWCpLDUyKQUuFkoW5iRELLshD5VgBKhfcdVxWXeCjkI3fgs8gdLKCl1ucKAM
         8Hyrs17rX9N49qwe9Qu/2hCXxFQl7jG3fD2sKlZJEZtX2pkp125vR4H5urso2AToUtDD
         WmJw==
X-Gm-Message-State: APjAAAUiSR7HxGp3ePHnU5zp41odCQJCh3qmjPR+XWBtRqWC4qxiKNDq
        n/8DakKrO1lNjwu207Kks3pGEQ==
X-Google-Smtp-Source: APXvYqzTYoePwqDD9esqOsGPBmEw78/sLxWA/IkhxSEMuPrS10a39mEN7tjOCD7++ZBv5UIs+Cb13g==
X-Received: by 2002:a1c:f70c:: with SMTP id v12mr21725967wmh.86.1557911180708;
        Wed, 15 May 2019 02:06:20 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id f7sm1151307wmc.26.2019.05.15.02.06.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 02:06:20 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] PM / EM: Expose perf domain struct
To:     Quentin Perret <quentin.perret@arm.com>, edubezval@gmail.com,
        rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        will.deacon@arm.com, catalin.marinas@arm.com
Cc:     dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190515082318.7993-1-quentin.perret@arm.com>
 <20190515082318.7993-3-quentin.perret@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0ced18eb-e424-fe6b-b11e-165a3c108170@linaro.org>
Date:   Wed, 15 May 2019 11:06:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515082318.7993-3-quentin.perret@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/05/2019 10:23, Quentin Perret wrote:
> In the current state, the perf_domain struct is fully defined only when
> CONFIG_ENERGY_MODEL=y. Since we need to write code that compiles both
> with or without that option in the thermal framework, make sure to
> actually define the struct regardless of the config option. That allows
> to avoid using stubbed accessor functions all the time in code paths
> that use the EM.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>

This patch implies the cpu cooling device can be set without the energy
model.

Isn't it possible to make a strong dependency for the cpu cooling device
on the energy model option, add the energy model as default on arm arch
and drop this patch?

After all, the cpu cooling is using the em framework.

> ---
>  include/linux/energy_model.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index aa027f7bcb3e..fb32b86a467d 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -9,7 +9,6 @@
>  #include <linux/sched/topology.h>
>  #include <linux/types.h>
>  
> -#ifdef CONFIG_ENERGY_MODEL
>  /**
>   * em_cap_state - Capacity state of a performance domain
>   * @frequency:	The CPU frequency in KHz, for consistency with CPUFreq
> @@ -40,6 +39,7 @@ struct em_perf_domain {
>  	unsigned long cpus[0];
>  };
>  
> +#ifdef CONFIG_ENERGY_MODEL
>  #define EM_CPU_MAX_POWER 0xFFFF
>  
>  struct em_data_callback {
> @@ -160,7 +160,6 @@ static inline int em_pd_nr_cap_states(struct em_perf_domain *pd)
>  }
>  
>  #else
> -struct em_perf_domain {};
>  struct em_data_callback {};
>  #define EM_DATA_CB(_active_power_cb) { }
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

