Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033DD2511BB
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 07:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgHYFuI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 01:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbgHYFuI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 01:50:08 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327FAC0613ED
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 22:50:07 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w186so3943432pgb.8
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 22:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vnJNUHtuFQUFx13e1DH6FdQTNcSlnOczZJdYD+gETKQ=;
        b=sUtrjydErcLgPizhn/Xtx4ItBgxoAz/OtzMIkDhh/Q2SE9qFJyNZ2IWh/2wrLbP6F3
         vMtRByRkp1mYza87avjNVjpHkG6lCbqxvXdcHvDFWIUUDogaJ2wO/o4/rENLnkbuOACB
         Hps0Tvpynh9hWCbsYRkAKdJwaeblvE+o/JQuCsq1VknHKEl6aAc7zlJDEZijhlYuLR3i
         ND/Go6sn4ST2/vDfSmtmhqTcmAI2UtUsC21eT/h6OZwd1Ipp6dRZnrCk2yFlAF7tZXmf
         RGy1hmTFbfTZYLSQluB5wNe7oBjCkvwFyXaDTcVXAOzhh74RtFdCJtggaXeZT7b5TZrc
         YyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vnJNUHtuFQUFx13e1DH6FdQTNcSlnOczZJdYD+gETKQ=;
        b=fKVHrjFZByKpoeXCehbd4kiNjoapduNlrFvD5S50PnXtDGH1AXcMAqOOukUln2Dofh
         GKn1OslcsBPju2lfDw8VnBkg9SlyZxQjvIhnNeq4bNV3Gsuon0q0Ni49wMlUzPfVdVxA
         Of5ootTxo/pA9NSP3rMmxgWnkgo55Q1VR0E6Xwfyua9DrpioJhmIO/IiQEg6bdKCZyCM
         L2XFK2t+29hHbbb8jl23xCf8IPpAYRdmYd4q4LktJy43C16bgyzy6nuPqgIfciWxtGch
         0B4emMZgc88H7zEZN+Vxvg1MnS/79TkryUU2DYJTZ89Ev0wlTMrbelYsQtZcUVMiemCu
         3qmw==
X-Gm-Message-State: AOAM532r1NiZpk15G5ymZ9lpPyhsW/Y+p41Z5z/m0XWpdD2mLjWZRCcI
        GxwUn9mpepcnmvCr97kpnojSCg==
X-Google-Smtp-Source: ABdhPJx7LW43H/WEVT3wFqJuqlI6n26TIbT5/snnF9dSqDbHnlNMONApn7rCm69tVvLefn/LYmHMeQ==
X-Received: by 2002:a63:31d0:: with SMTP id x199mr5238003pgx.99.1598334606437;
        Mon, 24 Aug 2020 22:50:06 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id o5sm2988556pgi.18.2020.08.24.22.50.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 22:50:05 -0700 (PDT)
Date:   Tue, 25 Aug 2020 11:20:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] cpufreq: tegra186: Fix initial frequency
Message-ID: <20200825055003.qfsuktsv7cyouxei@vireshk-i7>
References: <20200824145907.331899-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824145907.331899-1-jonathanh@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-08-20, 15:59, Jon Hunter wrote:
> Commit 6cc3d0e9a097 ("cpufreq: tegra186: add
> CPUFREQ_NEED_INITIAL_FREQ_CHECK flag") fixed CPUFREQ support for
> Tegra186 but as a consequence the following warnings are now seen on
> boot ...
> 
>  cpufreq: cpufreq_online: CPU0: Running at unlisted freq: 0 KHz
>  cpufreq: cpufreq_online: CPU0: Unlisted initial frequency changed to: 2035200 KHz
>  cpufreq: cpufreq_online: CPU1: Running at unlisted freq: 0 KHz
>  cpufreq: cpufreq_online: CPU1: Unlisted initial frequency changed to: 2035200 KHz
>  cpufreq: cpufreq_online: CPU2: Running at unlisted freq: 0 KHz
>  cpufreq: cpufreq_online: CPU2: Unlisted initial frequency changed to: 2035200 KHz
>  cpufreq: cpufreq_online: CPU3: Running at unlisted freq: 0 KHz
>  cpufreq: cpufreq_online: CPU3: Unlisted initial frequency changed to: 2035200 KHz
>  cpufreq: cpufreq_online: CPU4: Running at unlisted freq: 0 KHz
>  cpufreq: cpufreq_online: CPU4: Unlisted initial frequency changed to: 2035200 KHz
>  cpufreq: cpufreq_online: CPU5: Running at unlisted freq: 0 KHz
>  cpufreq: cpufreq_online: CPU5: Unlisted initial frequency changed to: 2035200 KHz
> 
> Fix this by adding a 'get' callback for the Tegra186 CPUFREQ driver to
> retrieve the current operating frequency for a given CPU. The 'get'
> callback uses the current 'ndiv' value that is programmed to determine
> that current operating frequency.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> Changes since V1:
> - Moved code into a 'get' callback
> 
>  drivers/cpufreq/tegra186-cpufreq.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
> index 01e1f58ba422..0d0fcff60765 100644
> --- a/drivers/cpufreq/tegra186-cpufreq.c
> +++ b/drivers/cpufreq/tegra186-cpufreq.c
> @@ -14,6 +14,7 @@
>  
>  #define EDVD_CORE_VOLT_FREQ(core)		(0x20 + (core) * 0x4)
>  #define EDVD_CORE_VOLT_FREQ_F_SHIFT		0
> +#define EDVD_CORE_VOLT_FREQ_F_MASK		0xffff
>  #define EDVD_CORE_VOLT_FREQ_V_SHIFT		16
>  
>  struct tegra186_cpufreq_cluster_info {
> @@ -91,10 +92,39 @@ static int tegra186_cpufreq_set_target(struct cpufreq_policy *policy,
>  	return 0;
>  }
>  
> +static unsigned int tegra186_cpufreq_get(unsigned int cpu)
> +{
> +	struct cpufreq_frequency_table *tbl;
> +	struct cpufreq_policy *policy;
> +	void __iomem *edvd_reg;
> +	unsigned int i, freq = 0;
> +	u32 ndiv;
> +
> +	policy = cpufreq_cpu_get(cpu);
> +	if (!policy)
> +		return -EINVAL;

This should be return 0;

Applied with that change. Thanks.

-- 
viresh
