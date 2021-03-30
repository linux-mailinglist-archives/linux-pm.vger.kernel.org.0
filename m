Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D4F34E035
	for <lists+linux-pm@lfdr.de>; Tue, 30 Mar 2021 06:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhC3EhH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Mar 2021 00:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbhC3Egf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Mar 2021 00:36:35 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76295C061762
        for <linux-pm@vger.kernel.org>; Mon, 29 Mar 2021 21:36:32 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id g10so5495932plt.8
        for <linux-pm@vger.kernel.org>; Mon, 29 Mar 2021 21:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BvRbBZnASVdYfsaOe0CfduFdiRkLJ8niuBgOzm/MRro=;
        b=iECcxBCZLcHI2v1Czg8SPMUOeAdilEubHiugaH6gep3GwMFvqHzkAFlHfzV/6n5d5i
         LHAvlhvfTwVVKMtNq4F+NEC8QOj5ohxl0NWe0lCOWyOHIlCnZ5ekGlgBIiW9qHjqXwch
         P5A3H3ZJB18TMtjD1GjTi5lo3mKTEicYIFlZ+isPWC2MNNQqcv6gg37RgOoai3Ek1+GN
         TmGm60kgXb73h356o9Upw6ZgoPT0PcbFqGrPi5iYL6yvQ7XfLCH28QqGjvlSBm81dC3W
         9jjeu2dwfSOLqyf/ibNeSuPB0E66R4HvenL5m+Hzko5D3mmh4Ihgp8CD4HwptB5s78/D
         CLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BvRbBZnASVdYfsaOe0CfduFdiRkLJ8niuBgOzm/MRro=;
        b=VUjqXVUcMn3w5PhKfDedZzRYz3fxC2HIlrJSfP5BOhIzcf7Hh75KILa1H6PczmmP8K
         hERNSnB9yAjAda9bmLfkkso6VhGfI8ZqDyrWtkfFArefENL9FRyFI+t+0jeJSWZPtR2e
         Fvq/L/CL4u+ayjB+MF0tOpNiHs/Qj5/ghMT5SaT+Mgw5t57bk507QiLmDvSZgUoyuqCN
         P6xuvltVG3bz9/2ozQZtXE5A989BcGizOdHFEcUa5xKXHVwaOqGKJBcNIU9f9jRZ0tVM
         dCl2rV2TT+fbJwCF0j2YGhPD7Wdgeq6ZhXcMfxFIGrTavxvidtvajjy4kTagxj+IqBkx
         EeGA==
X-Gm-Message-State: AOAM532aFJjlnohX2drroWosp0ycfizYRKQByvpk/rp9o82W5fcEOxJb
        l/uBdAxKvXdXp/fQXrKV7EPaGA==
X-Google-Smtp-Source: ABdhPJwshx2ncunskGbMt8kWnyEKe9h4R6stukSh3ZR36FNExYlVwD6kQZCJJns2C8g4gluFQJdAcw==
X-Received: by 2002:a17:90a:c588:: with SMTP id l8mr2432201pjt.120.1617078991995;
        Mon, 29 Mar 2021 21:36:31 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id e6sm2638506pgh.17.2021.03.29.21.36.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Mar 2021 21:36:31 -0700 (PDT)
Date:   Tue, 30 Mar 2021 10:06:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH V8 2/8] cpufreq: mediatek: Enable clock and regulator
Message-ID: <20210330043629.x62j2apv2nv4mw67@vireshk-i7>
References: <1616499241-4906-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1616499241-4906-3-git-send-email-andrew-sh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616499241-4906-3-git-send-email-andrew-sh.cheng@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-03-21, 19:33, Andrew-sh.Cheng wrote:
> From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
> 
> Need to enable regulator,
> so that the max/min requested value will be recorded
> even it is not applied right away.
> 
> Intermediate clock is not always enabled by ccf in different projects,
> so cpufreq should enable it by itself.
> 
> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 33 +++++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index f2e491b25b07..432368707ea6 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -350,6 +350,11 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>  		ret = PTR_ERR(proc_reg);
>  		goto out_free_resources;
>  	}
> +	ret = regulator_enable(proc_reg);
> +	if (ret) {
> +		pr_warn("enable vproc for cpu%d fail\n", cpu);
> +		goto out_free_resources;
> +	}

Regulators are enabled by OPP core as well now, you sure this is
required ?

-- 
viresh
