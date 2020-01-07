Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2571113372F
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 00:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbgAGXRF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 18:17:05 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40900 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgAGXRF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2020 18:17:05 -0500
Received: by mail-lf1-f65.google.com with SMTP id i23so996086lfo.7;
        Tue, 07 Jan 2020 15:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z3UtITc4zK9Gssc2kyYRqxkunqDolPS6OQRkM0QUDtY=;
        b=EQsoySUSRqREURbglDkMpdKVjg7eKOdVdnGQceh4ZMZckD9eTKjPsdhL+J6E+QZ69N
         QyuynbapDeAO0nc3e4xnbjaxGiBgLXE71h2iL85U+G/ycdrz7H07Cpj/yPyaeO3F+4Rt
         /WUO85IAyOKH3NhVnNdAFoYsmqcpbDBBJUvv6NXa8C9yHLjXJEyPnNQFBfAau/Nu7bzs
         qlAckR03wlON54gxxfPHou2/3MmBavmx5cb2wBQadXgAQxQImuvPEqfkM8/Bq1T+JqXI
         5ZvOuE41iPq+wKT4RMc9Myu3ablGDLJJSXQAPUanLqQn3HaTArsHCA9VKrfDVSKnDFy2
         OWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z3UtITc4zK9Gssc2kyYRqxkunqDolPS6OQRkM0QUDtY=;
        b=kp8jjM1+S13xUS+Wfr8vOi9/uZRUsvLUzzSJPknjunRkhChKLoohRl8Pdab92ce3rN
         +2UTtzEacWG0+n5bTsGyY4X5NoOLA+mhh6dH8rZyDQkriWdL7sjd/SR2oWDhWtbY//rv
         ZDaZ34pVXFrQ2KsymkHA38JsHd5j/cbvbUKfbKlCTkR6Rfw1IKFfbi3rcOc/yEpV52Sg
         cPxVpGPAVJdY3abSPjtlep54d4/8dJebL7BlCHsFd+5025DPqwZ/dLQTwMJ0aIhG1kXp
         f+REIFodGNPlwZct08C81pbHI1SfXzI7ulxaXYIjef8Y1PSGt1NHnXkuvWaedrSCZwWD
         lHKg==
X-Gm-Message-State: APjAAAWNmDaeZLagUmFytqfklg0PR/OVbGVgANkZNyNzk3+6NTQ1Ab3v
        Lw+vo7J3FCWrRLrsWkd9sF/VGEIV
X-Google-Smtp-Source: APXvYqxZMJb5KnSBEXAC4K7LWG92+6r0yVQIv2mY1VHq/LxhTXrOjzLw0n/qj2BPsGoqosGpf6xGxA==
X-Received: by 2002:a19:9157:: with SMTP id y23mr1176014lfj.74.1578439021866;
        Tue, 07 Jan 2020 15:17:01 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id t27sm407149ljd.26.2020.01.07.15.17.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 15:17:01 -0800 (PST)
Subject: Re: [PATCH v6 00/12] NVIDIA Tegra20 CPUFreq driver major update
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191218202142.11717-1-digetx@gmail.com>
Message-ID: <ff3006a1-b5b1-5854-3a2c-67278e53b6dd@gmail.com>
Date:   Wed, 8 Jan 2020 02:17:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191218202142.11717-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

18.12.2019 23:21, Dmitry Osipenko пишет:
> Hello,
> 
> This series moves intermediate-clk handling from tegra20-cpufreq into
> tegra-clk driver. This allows us to switch to generic cpufreq-dt driver
> which brings voltage scaling, per-hardware OPPs and Tegra30 support out
> of the box. All boards need to adopt CPU OPPs in their device-trees in
> order to get cpufreq support.
> 
> Changelog:
> 
> v6: - Dropped "cpufreq: dt-platdev: Blacklist NVIDIA Tegra20 and Tegra30 SoCs"
>       patch from the series since Viresh picked up that patch separately.
> 
>     - Added two new patches to this series:
> 
>         ARM: tegra: Switch CPU to PLLP on resume from LP1 on Tegra30/114/124
>         ARM: tegra: Don't enable PLLX while resuming from LP1 on Tegra30
> 
>       Previously these patches were sent out separately from this series,
>       but it should be more consistent to include them into the series since
>       they directly relate to enabling of the cpufreq driver on Tegra30.
> 
> v5: - The "Use generic cpufreq-dt driver (Tegra30 supported now)" patch
>       is separated now into two patches by factoring out the blacklisting
>       of cpufreq-dt-platdev into a standalone patch. This is done in a
>       response to request from Jon Hunter to fix the warning splats during
>       boot that are coming from OPP core because OPPs are unavailable. The
>       OPPs will become available once tegra20-cpufreq driver will be updated
>       to support the cpufreq-dt.
> 
> v4: - Updated CCLK diagram in the "Add custom CCLK implementation" patch.
> 
>     - <linux/cpu.h> is now included in the "Use generic cpufreq-dt driver"
>       patch, for consistency.
> 
>     - Returned value of get_cpu_device() is now checked in the "Use generic
>       cpufreq-dt driver" patch, for consistency as well.
> 
> v3: - The "Add custom CCLK implementation" patch was updated in accordance
>       to the comments from Peter De Schrijver. We will not use the clock
>       skipper.
> 
>     - Re added OPPs for T30 Beaver board because Thierry has that board ;)
> 
>     - Added r-b for the "DT binding" patch from Rob Herring.
> 
> v2: - Kept modularity of the tegra20-cpufreq as was requested by Viresh Kumar
>       in a review comment to v1.
> 
>     - Added acks from Viresh Kumar.
> 
>     - Added tested-by from Nicolas Chauvet to the "trimslice" patch.
>       Nicolas told me on IRC that it works fine.
> 
>     - Fixed compilation of the "Add custom CCLK implementation" patch. The
>       error happened because v1 was based on top of yet unreviewed/unapplied
>       patch "clk: tegra: divider: Support enable-bit for Super clocks".
>       Thanks to Peter Geis for reporting the problem.
> 
>     - Replaced Tegra30 "beaver" board with "cardhu-a04" because turned out
>       that's what NVIDIA uses in the testing farm.
> 
> Dmitry Osipenko (12):
>   clk: tegra: Add custom CCLK implementation
>   clk: tegra: pll: Add pre/post rate-change hooks
>   clk: tegra: cclk: Add helpers for handling PLLX rate changes
>   clk: tegra20: Use custom CCLK implementation
>   clk: tegra30: Use custom CCLK implementation
>   ARM: tegra: Switch CPU to PLLP on resume from LP1 on Tegra30/114/124
>   ARM: tegra: Don't enable PLLX while resuming from LP1 on Tegra30
>   dt-bindings: cpufreq: Add binding for NVIDIA Tegra20/30
>   cpufreq: tegra20: Use generic cpufreq-dt driver (Tegra30 supported
>     now)
>   ARM: tegra: Create tegra20-cpufreq platform device on Tegra30
>   ARM: dts: tegra30: beaver: Set up voltage regulators for DVFS
>   ARM: dts: tegra30: beaver: Add CPU Operating Performance Points
> 
>  .../cpufreq/nvidia,tegra20-cpufreq.txt        |  56 +++++
>  arch/arm/boot/dts/tegra30-beaver.dts          |  40 +++-
>  arch/arm/mach-tegra/sleep-tegra30.S           |  18 +-
>  arch/arm/mach-tegra/tegra.c                   |   4 +
>  drivers/clk/tegra/Makefile                    |   1 +
>  drivers/clk/tegra/clk-pll.c                   |  12 +-
>  drivers/clk/tegra/clk-tegra-super-cclk.c      | 212 +++++++++++++++++
>  drivers/clk/tegra/clk-tegra20.c               |   7 +-
>  drivers/clk/tegra/clk-tegra30.c               |   6 +-
>  drivers/clk/tegra/clk.h                       |  19 +-
>  drivers/cpufreq/Kconfig.arm                   |   6 +-
>  drivers/cpufreq/tegra20-cpufreq.c             | 217 +++++-------------
>  12 files changed, 418 insertions(+), 180 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
>  create mode 100644 drivers/clk/tegra/clk-tegra-super-cclk.c
> 

Hello Peter,

Could you please take a look at the patches and ACK them if they are
okay to you?
