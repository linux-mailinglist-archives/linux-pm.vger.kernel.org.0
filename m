Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435263AA3F3
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 21:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhFPTLT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 15:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbhFPTLJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 15:11:09 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E6EC061574
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 12:09:02 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a11so3823829wrt.13
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 12:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nLVDBTWNz5n+zUU4LbtZG+43+EwMaSV4mGSFCqMWcW4=;
        b=eJArqBVqGlkVZSf51Xd5+P0dv0rFGd3fSD4c7jRFUklxI8l/wxb0cYb6R9G+e9YlbB
         5bPfWKs6kzOVskWksNC6qwHLiAV1uMPf/Z9Z8jkt3gYsXhdvi8UbNETrjzyeLW3/qzo1
         ns04iePMwxa6bx1zIO0CLxPpK+xFK/eT4KhJGYTToNYhDnyjbQf+LgHN87ha0SxYtKEE
         9MsXYtsaOgVfP4pbXBvK0nfyKQkewjCBISzdvalGQa45HDCbLLEla6XVETkYz1KyADO5
         fObIpenozSTfvS3X0oBAjEgtSWcitMMPmNTNGJ9/9FFgm2PEuQnmIQUp0P9h9s7V7/p9
         LmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nLVDBTWNz5n+zUU4LbtZG+43+EwMaSV4mGSFCqMWcW4=;
        b=m7TJtKEkddUTjbmC2v9anPPBnPpXAibTNwEgUtrnwOj8IHXKlvBv8W8YSzgTHzHXRz
         GLRsII4HrlCsK+9WbrMTLWm/kDLyL5d9AeH2IGb/I7lQMEDtW9rbBfDArI0yOspcIx58
         ROfg3NFaX7EnKcH1povP8IhgkrLBc7DbW7p4ucGhUg33Ene6Qhksm9cY5WTRC/+/5ux1
         P57GMHz3GDGp8AsedvAagYmkTrESWm+ar1o647YZskQr+RVxSF9lxujFVh1rncxBrAY2
         53ew4ixXmC68d7Xs4Z/lPL+ECMYwCWywU8/n/ZjL1FNVimC7Yf/moCOwh3lVf+whibfZ
         UsGg==
X-Gm-Message-State: AOAM532U8poa8rtwNtd+TaX8BwtmgXnNJ/DFgIXQ2zZa2JZZ1AmLck6j
        l8/7dOxsH6U2wRZrgMd9k/1qmw==
X-Google-Smtp-Source: ABdhPJwaeWVE2xcq6puggeiJuqIA+QoPr7qU71EqextGBQIa1TdaDFxClpwauH1vz5rFBuw9lNccyw==
X-Received: by 2002:adf:f942:: with SMTP id q2mr630838wrr.427.1623870540977;
        Wed, 16 Jun 2021 12:09:00 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:60a0:f51c:af6:2dab? ([2a01:e34:ed2f:f020:60a0:f51c:af6:2dab])
        by smtp.googlemail.com with ESMTPSA id z5sm2949798wrp.92.2021.06.16.12.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 12:09:00 -0700 (PDT)
Subject: Re: [PATCH v1 4/5] clk: tegra: Add stubs needed for compile testing
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20210606222817.12388-1-digetx@gmail.com>
 <20210606222817.12388-5-digetx@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d74be172-1ef5-48f7-e1a1-de63a05f64ba@linaro.org>
Date:   Wed, 16 Jun 2021 21:08:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210606222817.12388-5-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/06/2021 00:28, Dmitry Osipenko wrote:
> Add stubs needed for compile-testing of tegra-cpuidle driver.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  include/linux/clk/tegra.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/clk/tegra.h b/include/linux/clk/tegra.h
> index d128ad1570aa..9bd06d8a5436 100644
> --- a/include/linux/clk/tegra.h
> +++ b/include/linux/clk/tegra.h
> @@ -42,7 +42,11 @@ struct tegra_cpu_car_ops {
>  #endif
>  };
>  
> +#ifdef CONFIG_ARCH_TEGRA
>  extern struct tegra_cpu_car_ops *tegra_cpu_car_ops;
> +#else
> +static struct tegra_cpu_car_ops *tegra_cpu_car_ops __maybe_unused;
> +#endif

Why not just have __may_be_unused without the #ifdef ?

>  static inline void tegra_wait_cpu_in_reset(u32 cpu)
>  {
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
