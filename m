Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042B83EA82D
	for <lists+linux-pm@lfdr.de>; Thu, 12 Aug 2021 18:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhHLQCi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Aug 2021 12:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhHLQCi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Aug 2021 12:02:38 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF01C061756;
        Thu, 12 Aug 2021 09:02:12 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id w20so14359746lfu.7;
        Thu, 12 Aug 2021 09:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CS/Wz0hxjeRuV2qYV+d+qfHRa67sIp1agK0mKi6yjXs=;
        b=G/04w7wtOmMZZgNy+CxIVz0nxaDfHpD+7kHnrDoRjVIwHAsvkcJREFCPUvXK6sO/DS
         Bivh5JHOei5dqDLh8D+GOHXGCgQC4aodqLgv6m5REv+/YtBJnMA2WMJASgJ3IcGGxGeo
         2U8gGoNExAMhVmVmoeE1Vq/quzRTv93y8pZsTEOm/iZ3sXzTWQDcRQP2/G5aosVTGitx
         JWRKrSY6TYcrYxIYGDhFsyNfWAh/Ffep3QA7PhXEMb7xoOYnrzebIxbUWHWwKQ0wVhXz
         gvlAcCaBcWwCa803aHAgiQhvWRJJlS4StaXLt3a7fdVgpcbQ11nLaXwTFyVe4e4l5Pzr
         gwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CS/Wz0hxjeRuV2qYV+d+qfHRa67sIp1agK0mKi6yjXs=;
        b=X9zPW/8hjVuZD25z1NJMdfRxjQgEXhmvHaogmkvgTWp01Udk3oc+txzkrkvXQh7q8C
         KzxwJB5jHzm8XdjOM2NgqOAru5WBmEP2SbecFAeORbEuM53KzFa81K2ypseRFztho7J8
         wYA/2X6tznd3ys6bydd4xOiVxvlbx/mHa8/Sd+HJzPT6DPHAeNr6g9CPfjNyPuyIOUF4
         E8hl7clJtQoqY6SmW0AdXVe35LcETkGncmv9TIrHMcpTSwgmxGnhyzTVgMqb4GkzzBA0
         aZ8M1uGzeOPgJsAyR7OwoM2zANizxXOQF82P3tCyXAxGT+QBhVVgKUdS0mmSEmIPEzZS
         oDYw==
X-Gm-Message-State: AOAM531ruIRBKFQftN0VdyNSRedAM0IiQf9qbSSt6zKXm4Esur6HJABb
        UREBAd2MB4Oe4mik1yEWUcecl7sduOQ=
X-Google-Smtp-Source: ABdhPJzK2Sht+mseJfZIZ/v+XP0+TKaOoHv7LK0oG0RYgQRDA+YFv07LFralo6/orE6GD6kTCEZlCg==
X-Received: by 2002:ac2:5fe3:: with SMTP id s3mr2995322lfg.319.1628784131005;
        Thu, 12 Aug 2021 09:02:11 -0700 (PDT)
Received: from [192.168.2.145] (46-138-117-53.dynamic.spd-mgts.ru. [46.138.117.53])
        by smtp.googlemail.com with ESMTPSA id k14sm299816lfo.262.2021.08.12.09.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 09:02:10 -0700 (PDT)
Subject: Re: [PATCH v7 01/37] soc/tegra: pmc: Temporarily disable PMC state
 syncing
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210701232728.23591-1-digetx@gmail.com>
 <20210701232728.23591-2-digetx@gmail.com>
Message-ID: <9a2fc1f7-5c10-eac3-97ad-303bc86c0666@gmail.com>
Date:   Thu, 12 Aug 2021 19:02:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210701232728.23591-2-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

02.07.2021 02:26, Dmitry Osipenko пишет:
> Disable PMC state syncing in order to ensure that we won't break older
> kernels once device-trees will be updated with the addition of the power
> domains. Previously this was unnecessary because the plan was to make clk
> device that will attach to the domain for each clock, but the plan changed
> and now we're going make a better GENPD implementation that will require
> to update each device driver with the runtime PM and OPP support before
> we could safely enable the state syncing.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/soc/tegra/pmc.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index ea62f84d1c8b..f63dfb2ca3f9 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -360,6 +360,7 @@ struct tegra_pmc_soc {
>  	unsigned int num_pmc_clks;
>  	bool has_blink_output;
>  	bool has_usb_sleepwalk;
> +	bool supports_core_domain;
>  };
>  
>  /**
> @@ -3029,6 +3030,7 @@ static void tegra20_pmc_setup_irq_polarity(struct tegra_pmc *pmc,
>  }
>  
>  static const struct tegra_pmc_soc tegra20_pmc_soc = {
> +	.supports_core_domain = false,
>  	.num_powergates = ARRAY_SIZE(tegra20_powergates),
>  	.powergates = tegra20_powergates,
>  	.num_cpu_powergates = 0,
> @@ -3089,6 +3091,7 @@ static const char * const tegra30_reset_sources[] = {
>  };
>  
>  static const struct tegra_pmc_soc tegra30_pmc_soc = {
> +	.supports_core_domain = false,
>  	.num_powergates = ARRAY_SIZE(tegra30_powergates),
>  	.powergates = tegra30_powergates,
>  	.num_cpu_powergates = ARRAY_SIZE(tegra30_cpu_powergates),
> @@ -3145,6 +3148,7 @@ static const u8 tegra114_cpu_powergates[] = {
>  };
>  
>  static const struct tegra_pmc_soc tegra114_pmc_soc = {
> +	.supports_core_domain = false,
>  	.num_powergates = ARRAY_SIZE(tegra114_powergates),
>  	.powergates = tegra114_powergates,
>  	.num_cpu_powergates = ARRAY_SIZE(tegra114_cpu_powergates),
> @@ -3261,6 +3265,7 @@ static const struct pinctrl_pin_desc tegra124_pin_descs[] = {
>  };
>  
>  static const struct tegra_pmc_soc tegra124_pmc_soc = {
> +	.supports_core_domain = false,
>  	.num_powergates = ARRAY_SIZE(tegra124_powergates),
>  	.powergates = tegra124_powergates,
>  	.num_cpu_powergates = ARRAY_SIZE(tegra124_cpu_powergates),
> @@ -3386,6 +3391,7 @@ static const struct tegra_wake_event tegra210_wake_events[] = {
>  };
>  
>  static const struct tegra_pmc_soc tegra210_pmc_soc = {
> +	.supports_core_domain = false,
>  	.num_powergates = ARRAY_SIZE(tegra210_powergates),
>  	.powergates = tegra210_powergates,
>  	.num_cpu_powergates = ARRAY_SIZE(tegra210_cpu_powergates),
> @@ -3543,6 +3549,7 @@ static const struct tegra_wake_event tegra186_wake_events[] = {
>  };
>  
>  static const struct tegra_pmc_soc tegra186_pmc_soc = {
> +	.supports_core_domain = false,
>  	.num_powergates = 0,
>  	.powergates = NULL,
>  	.num_cpu_powergates = 0,
> @@ -3677,6 +3684,7 @@ static const struct tegra_wake_event tegra194_wake_events[] = {
>  };
>  
>  static const struct tegra_pmc_soc tegra194_pmc_soc = {
> +	.supports_core_domain = false,
>  	.num_powergates = 0,
>  	.powergates = NULL,
>  	.num_cpu_powergates = 0,
> @@ -3745,6 +3753,7 @@ static const char * const tegra234_reset_sources[] = {
>  };
>  
>  static const struct tegra_pmc_soc tegra234_pmc_soc = {
> +	.supports_core_domain = false,
>  	.num_powergates = 0,
>  	.powergates = NULL,
>  	.num_cpu_powergates = 0,
> @@ -3791,6 +3800,14 @@ static void tegra_pmc_sync_state(struct device *dev)
>  {
>  	int err;
>  
> +	/*
> +	 * Newer device-trees have power domains, but we need to prepare all
> +	 * device drivers with runtime PM and OPP support first, otherwise
> +	 * state syncing is unsafe.
> +	 */
> +	if (!pmc->soc->supports_core_domain)
> +		return;
> +
>  	/*
>  	 * Older device-trees don't have core PD, and thus, there are
>  	 * no dependencies that will block the state syncing. We shouldn't
> 

Thierry, could you please take this patch for 5.15? It should ease
further applying of the rest of the patches, thanks.
