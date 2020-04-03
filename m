Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21EAF19DB68
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 18:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404393AbgDCQVv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 12:21:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35623 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404282AbgDCQVu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Apr 2020 12:21:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so6923067wrx.2
        for <linux-pm@vger.kernel.org>; Fri, 03 Apr 2020 09:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6om/4rXdxtYXyimklhCnpP83StO5NVzKu/T922SS34M=;
        b=yEH8X6bUzhlfpFoHPfYBm5ygIWQGV9KCDraP6TSb7xIdsTs/raaOu737badT6/mctw
         fW1eZxZYGylg6rkma3Jb5qIn/TanPOVS6Z63Cbp3OvScJOrR6DKuOX+ejla807aUBQnz
         H1FA5p++hDhX4wypUp3T/o9blNJ5Ngy52SZANeQ0GgiijQBOwP7ITtjQtWFapz57tSlI
         T9RJTFBvB5jdpuyVonGywiwmDKua6PMfTB29LqPQvnTn/qvB4biwTNLAQA/OJWWY6dcY
         xZyN0Jc6FmplOuZLNi2p0pW+oV0aX492tMlH3NTTV1JYo+NUmxO6JKNFqvTjvdXy9VHY
         eCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6om/4rXdxtYXyimklhCnpP83StO5NVzKu/T922SS34M=;
        b=j3WpV3tFXWnxO/XcFZCIMqc53Te7lfgk2tjLsHuWYu04XUSKhsZBheODgykS8CT3DP
         I67cNaHSG6cC8jO2zo4QGfxM6sLuPCHfWOXW+a/XRFHhSpFOFH+lg/BUWq/xE0OuFTyC
         IiUicEVFs6vLEGitMVq3UEXrfyvqjB6TOItiDGTJjnxVPc4MahTtS8G8o4y9QtTEtGq9
         mLRaZ/qS7YESU8HcmizHfRH0Dzv9FuXLuL3OsYBlgkqB4pWCoZTX33XCkZkI6t/vExAV
         ASN3ZcGo4bvm38gv3a2tkdOavyvBp0rsc0GgypeUB15u2HREwppR80syhbCMnz0Yd1vj
         uIMg==
X-Gm-Message-State: AGi0PubiXyPztn20fRMpYN2kUImPhmD2VAQn3r+gFz6CdiVRzRmq4qA9
        OH7CVrsrZ1iqulrRAzlRVwz0AQ==
X-Google-Smtp-Source: APiQypJC0QFvkpwg+qtPIn1QqrcLlS94x6NsNWz9Js2RZ6gj+tFw0wlw3qn6bbEiKSoxgK83xLm2Fg==
X-Received: by 2002:adf:c984:: with SMTP id f4mr10579767wrh.81.1585930906813;
        Fri, 03 Apr 2020 09:21:46 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:cc78:8018:8980:25d8? ([2a01:e34:ed2f:f020:cc78:8018:8980:25d8])
        by smtp.googlemail.com with ESMTPSA id b203sm12141426wmc.45.2020.04.03.09.21.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 09:21:46 -0700 (PDT)
Subject: Re: [PATCH v5 2/5] OPP: refactor dev_pm_opp_of_register_em() and
 update related drivers
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com
Cc:     Morten.Rasmussen@arm.com, Dietmar.Eggemann@arm.com,
        javi.merino@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, rjw@rjwysocki.net, sudeep.holla@arm.com,
        viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org,
        rui.zhang@intel.com, amit.kucheria@verdurent.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        qperret@google.com, bsegall@google.com, mgorman@suse.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        kernel@pengutronix.de, khilman@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org,
        matthias.bgg@gmail.com, steven.price@arm.com,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, patrick.bellasi@matbug.net,
        orjan.eide@arm.com, rdunlap@infradead.org, mka@chromium.org
References: <20200318114548.19916-1-lukasz.luba@arm.com>
 <20200318114548.19916-3-lukasz.luba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 xsFNBFv/yykBEADDdW8RZu7iZILSf3zxq5y8YdaeyZjI/MaqgnvG/c3WjFaunoTMspeusiFE
 sXvtg3ehTOoyD0oFjKkHaia1Zpa1m/gnNdT/WvTveLfGA1gH+yGes2Sr53Ht8hWYZFYMZc8V
 2pbSKh8wepq4g8r5YI1XUy9YbcTdj5mVrTklyGWA49NOeJz2QbfytMT3DJmk40LqwK6CCSU0
 9Ed8n0a+vevmQoRZJEd3Y1qXn2XHys0F6OHCC+VLENqNNZXdZE9E+b3FFW0lk49oLTzLRNIq
 0wHeR1H54RffhLQAor2+4kSSu8mW5qB0n5Eb/zXJZZ/bRiXmT8kNg85UdYhvf03ZAsp3qxcr
 xMfMsC7m3+ADOtW90rNNLZnRvjhsYNrGIKH8Ub0UKXFXibHbafSuq7RqyRQzt01Ud8CAtq+w
 P9EftUysLtovGpLSpGDO5zQ++4ZGVygdYFr318aGDqCljKAKZ9hYgRimPBToDedho1S1uE6F
 6YiBFnI3ry9+/KUnEP6L8Sfezwy7fp2JUNkUr41QF76nz43tl7oersrLxHzj2dYfWUAZWXva
 wW4IKF5sOPFMMgxoOJovSWqwh1b7hqI+nDlD3mmVMd20VyE9W7AgTIsvDxWUnMPvww5iExlY
 eIC0Wj9K4UqSYBOHcUPrVOKTcsBVPQA6SAMJlt82/v5l4J0pSQARAQABzSpEYW5pZWwgTGV6
 Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz7Cwa4EEwEIAEECGwEFCwkIBwIGFQoJ
 CAsCBBYCAwECHgECF4ACGQEWIQQk1ibyU76eh+bOW/SP9LjScWdVJwUCXAkeagUJDRnjhwAh
 CRCP9LjScWdVJxYhBCTWJvJTvp6H5s5b9I/0uNJxZ1Un69gQAJK0ODuKzYl0TvHPU8W7uOeu
 U7OghN/DTkG6uAkyqW+iIVi320R5QyXN1Tb6vRx6+yZ6mpJRW5S9fO03wcD8Sna9xyZacJfO
 UTnpfUArs9FF1pB3VIr95WwlVoptBOuKLTCNuzoBTW6jQt0sg0uPDAi2dDzf+21t/UuF7I3z
 KSeVyHuOfofonYD85FkQJN8lsbh5xWvsASbgD8bmfI87gEbt0wq2ND5yuX+lJK7FX4lMO6gR
 ZQ75g4KWDprOO/w6ebRxDjrH0lG1qHBiZd0hcPo2wkeYwb1sqZUjQjujlDhcvnZfpDGR4yLz
 5WG+pdciQhl6LNl7lctNhS8Uct17HNdfN7QvAumYw5sUuJ+POIlCws/aVbA5+DpmIfzPx5Ak
 UHxthNIyqZ9O6UHrVg7SaF3rvqrXtjtnu7eZ3cIsfuuHrXBTWDsVwub2nm1ddZZoC530BraS
 d7Y7eyKs7T4mGwpsi3Pd33Je5aC/rDeF44gXRv3UnKtjq2PPjaG/KPG0fLBGvhx0ARBrZLsd
 5CTDjwFA4bo+pD13cVhTfim3dYUnX1UDmqoCISOpzg3S4+QLv1bfbIsZ3KDQQR7y/RSGzcLE
 z164aDfuSvl+6Myb5qQy1HUQ0hOj5Qh+CzF3CMEPmU1v9Qah1ThC8+KkH/HHjPPulLn7aMaK
 Z8t6h7uaAYnGzjMEXZLIEhYJKwYBBAHaRw8BAQdAGdRDglTydmxI03SYiVg95SoLOKT5zZW1
 7Kpt/5zcvt3CwhsEGAEIACAWIQQk1ibyU76eh+bOW/SP9LjScWdVJwUCXZLIEgIbAgCvCRCP
 9LjScWdVJ40gBBkWCAAdFiEEbinX+DPdhovb6oob3uarTi9/eqYFAl2SyBIAIQkQ3uarTi9/
 eqYWIQRuKdf4M92Gi9vqihve5qtOL396pnZGAP0c3VRaj3RBEOUGKxHzcu17ZUnIoJLjpHdk
 NfBnWU9+UgD/bwTxE56Wd8kQZ2e2UTy4BM8907FsJgAQLL4tD2YZggwWIQQk1ibyU76eh+bO
 W/SP9LjScWdVJ5CaD/0YQyfUzjpR1GnCSkbaLYTEUsyaHuWPI/uSpKTtcbttpYv+QmYsIwD9
 8CeH3zwY0Xl/1fE9Hy59z6Vxv9YVapLx0nPDOA1zDVNq2MnutxHb8t+Imjz4ERCxysqtfYrv
 gao3E/h0c8SEeh+bh5MkjwmU8CwZ3doWyiVdULKESe7/Gs5OuhFzaDVPCpWdsKdCAGyUuP/+
 qRWwKGVpWP0Rrt6MTK24Ibeu3xEZO8c3XOEXH5d9nf6YRqBEIizAecoCr00E9c+6BlRS0AqR
 OQC3/Mm7rWtco3+WOridqVXkko9AcZ8AiM5nu0F8AqYGKg0y7vkL2LOP8us85L0p57MqIR1u
 gDnITlTY0x4RYRWJ9+k7led5WsnWlyv84KNzbDqQExTm8itzeZYW9RvbTS63r/+FlcTa9Cz1
 5fW3Qm0BsyECvpAD3IPLvX9jDIR0IkF/BQI4T98LQAkYX1M/UWkMpMYsL8tLObiNOWUl4ahb
 PYi5Yd8zVNYuidXHcwPAUXqGt3Cs+FIhihH30/Oe4jL0/2ZoEnWGOexIFVFpue0jdqJNiIvA
 F5Wpx+UiT5G8CWYYge5DtHI3m5qAP9UgPuck3N8xCihbsXKX4l8bdHfziaJuowief7igeQs/
 WyY9FnZb0tl29dSa7PdDKFWu+B+ZnuIzsO5vWMoN6hMThTl1DxS+jc7ATQRb/8z6AQgAvSkg
 5w7dVCSbpP6nXc+i8OBz59aq8kuL3YpxT9RXE/y45IFUVuSc2kuUj683rEEgyD7XCf4QKzOw
 +XgnJcKFQiACpYAowhF/XNkMPQFspPNM1ChnIL5KWJdTp0DhW+WBeCnyCQ2pzeCzQlS/qfs3
 dMLzzm9qCDrrDh/aEegMMZFO+reIgPZnInAcbHj3xUhz8p2dkExRMTnLry8XXkiMu9WpchHy
 XXWYxXbMnHkSRuT00lUfZAkYpMP7La2UudC/Uw9WqGuAQzTqhvE1kSQe0e11Uc+PqceLRHA2
 bq/wz0cGriUrcCrnkzRmzYLoGXQHqRuZazMZn2/pSIMZdDxLbwARAQABwsGNBBgBCAAgFiEE
 JNYm8lO+nofmzlv0j/S40nFnVScFAlv/zPoCGwwAIQkQj/S40nFnVScWIQQk1ibyU76eh+bO
 W/SP9LjScWdVJ/g6EACFYk+OBS7pV9KZXncBQYjKqk7Kc+9JoygYnOE2wN41QN9Xl0Rk3wri
 qO7PYJM28YjK3gMT8glu1qy+Ll1bjBYWXzlsXrF4szSqkJpm1cCxTmDOne5Pu6376dM9hb4K
 l9giUinI4jNUCbDutlt+Cwh3YuPuDXBAKO8YfDX2arzn/CISJlk0d4lDca4Cv+4yiJpEGd/r
 BVx2lRMUxeWQTz+1gc9ZtbRgpwoXAne4iw3FlR7pyg3NicvR30YrZ+QOiop8psWM2Fb1PKB9
 4vZCGT3j2MwZC50VLfOXC833DBVoLSIoL8PfTcOJOcHRYU9PwKW0wBlJtDVYRZ/CrGFjbp2L
 eT2mP5fcF86YMv0YGWdFNKDCOqOrOkZVmxai65N9d31k8/O9h1QGuVMqCiOTULy/h+FKpv5q
 t35tlzA2nxPOX8Qj3KDDqVgQBMYJRghZyj5+N6EKAbUVa9Zq8xT6Ms2zz/y7CPW74G1GlYWP
 i6D9VoMMi6ICko/CXUZ77OgLtMsy3JtzTRbn/wRySOY2AsMgg0Sw6yJ0wfrVk6XAMoLGjaVt
 X4iPTvwocEhjvrO4eXCicRBocsIB2qZaIj3mlhk2u4AkSpkKm9cN0KWYFUxlENF4/NKWMK+g
 fGfsCsS3cXXiZpufZFGr+GoHwiELqfLEAQ9AhlrHGCKcgVgTOI6NHg==
Message-ID: <3ee5dc1a-fdfe-da17-9a62-a5182c1f4d3e@linaro.org>
Date:   Fri, 3 Apr 2020 18:21:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200318114548.19916-3-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/03/2020 12:45, Lukasz Luba wrote:
> The Energy Model framework supports both: CPUs and devfreq devices. Drop
> the CPU specific interface with cpumask and add struct device. Add also a
> return value. This new interface provides easy way to create a simple
> Energy Model, which then might be used in i.e. thermal subsystem.

This patch contains too many different changes.

There are fixes and traces added in addition to a function prototype change.

Please provide patches separated by logical changes.

If the cpumask is extracted in the underlying function
em_register_perf_domain() as suggested in the previous patch 1/5,
dev_pm_opp_of_register_em() can be struct device centric only.

> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/cpufreq/cpufreq-dt.c           |  2 +-
>  drivers/cpufreq/imx6q-cpufreq.c        |  2 +-
>  drivers/cpufreq/mediatek-cpufreq.c     |  2 +-
>  drivers/cpufreq/omap-cpufreq.c         |  2 +-
>  drivers/cpufreq/qcom-cpufreq-hw.c      |  2 +-
>  drivers/cpufreq/scpi-cpufreq.c         |  2 +-
>  drivers/cpufreq/vexpress-spc-cpufreq.c |  2 +-
>  drivers/opp/of.c                       | 71 ++++++++++++++++----------
>  include/linux/pm_opp.h                 | 15 +++++-
>  9 files changed, 65 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index 26fe8dfb9ce6..f9f03fd49b83 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -275,7 +275,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  	policy->cpuinfo.transition_latency = transition_latency;
>  	policy->dvfs_possible_from_any_cpu = true;
>  
> -	dev_pm_opp_of_register_em(policy->cpus);
> +	dev_pm_opp_of_register_em(cpu_dev, policy->cpus);
>  
>  	return 0;
>  
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index 285b8e9aa185..9764abf17ce3 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -193,7 +193,7 @@ static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
>  	policy->clk = clks[ARM].clk;
>  	cpufreq_generic_init(policy, freq_table, transition_latency);
>  	policy->suspend_freq = max_freq;
> -	dev_pm_opp_of_register_em(policy->cpus);
> +	dev_pm_opp_of_register_em(cpu_dev, policy->cpus);
>  
>  	return 0;
>  }
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index 0c98dd08273d..7d1212c9b7c8 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -448,7 +448,7 @@ static int mtk_cpufreq_init(struct cpufreq_policy *policy)
>  	policy->driver_data = info;
>  	policy->clk = info->cpu_clk;
>  
> -	dev_pm_opp_of_register_em(policy->cpus);
> +	dev_pm_opp_of_register_em(info->cpu_dev, policy->cpus);
>  
>  	return 0;
>  }
> diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
> index 8d14b42a8c6f..3694bb030df3 100644
> --- a/drivers/cpufreq/omap-cpufreq.c
> +++ b/drivers/cpufreq/omap-cpufreq.c
> @@ -131,7 +131,7 @@ static int omap_cpu_init(struct cpufreq_policy *policy)
>  
>  	/* FIXME: what's the actual transition time? */
>  	cpufreq_generic_init(policy, freq_table, 300 * 1000);
> -	dev_pm_opp_of_register_em(policy->cpus);
> +	dev_pm_opp_of_register_em(mpu_dev, policy->cpus);
>  
>  	return 0;
>  }
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index fc92a8842e25..0a04b6f03b9a 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -238,7 +238,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  		goto error;
>  	}
>  
> -	dev_pm_opp_of_register_em(policy->cpus);
> +	dev_pm_opp_of_register_em(cpu_dev, policy->cpus);
>  
>  	policy->fast_switch_possible = true;
>  
> diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
> index 20d1f85d5f5a..b0f5388b8854 100644
> --- a/drivers/cpufreq/scpi-cpufreq.c
> +++ b/drivers/cpufreq/scpi-cpufreq.c
> @@ -167,7 +167,7 @@ static int scpi_cpufreq_init(struct cpufreq_policy *policy)
>  
>  	policy->fast_switch_possible = false;
>  
> -	dev_pm_opp_of_register_em(policy->cpus);
> +	dev_pm_opp_of_register_em(cpu_dev, policy->cpus);
>  
>  	return 0;
>  
> diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
> index 83c85d3d67e3..4e8b1dee7c9a 100644
> --- a/drivers/cpufreq/vexpress-spc-cpufreq.c
> +++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
> @@ -450,7 +450,7 @@ static int ve_spc_cpufreq_init(struct cpufreq_policy *policy)
>  	policy->freq_table = freq_table[cur_cluster];
>  	policy->cpuinfo.transition_latency = 1000000; /* 1 ms */
>  
> -	dev_pm_opp_of_register_em(policy->cpus);
> +	dev_pm_opp_of_register_em(cpu_dev, policy->cpus);
>  
>  	if (is_bL_switching_enabled())
>  		per_cpu(cpu_last_req_freq, policy->cpu) =
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 0efd6cf6d023..f94d095113e7 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -1036,18 +1036,18 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_of_node);
>  
>  /*
>   * Callback function provided to the Energy Model framework upon registration.
> - * This computes the power estimated by @CPU at @kHz if it is the frequency
> + * This computes the power estimated by @dev at @kHz if it is the frequency
>   * of an existing OPP, or at the frequency of the first OPP above @kHz otherwise
>   * (see dev_pm_opp_find_freq_ceil()). This function updates @kHz to the ceiled
>   * frequency and @mW to the associated power. The power is estimated as
> - * P = C * V^2 * f with C being the CPU's capacitance and V and f respectively
> - * the voltage and frequency of the OPP.
> + * P = C * V^2 * f with C being the device's capacitance and V and f
> + * respectively the voltage and frequency of the OPP.
>   *
> - * Returns -ENODEV if the CPU device cannot be found, -EINVAL if the power
> - * calculation failed because of missing parameters, 0 otherwise.
> + * Returns -EINVAL if the power calculation failed because of missing
> + * parameters, 0 otherwise.
>   */
> -static int __maybe_unused _get_cpu_power(unsigned long *mW, unsigned long *kHz,
> -					 struct device *cpu_dev)
> +static int __maybe_unused _get_power(unsigned long *mW, unsigned long *kHz,
> +				     struct device *dev)
>  {
>  	struct dev_pm_opp *opp;
>  	struct device_node *np;
> @@ -1056,7 +1056,7 @@ static int __maybe_unused _get_cpu_power(unsigned long *mW, unsigned long *kHz,
>  	u64 tmp;
>  	int ret;
>  
> -	np = of_node_get(cpu_dev->of_node);
> +	np = of_node_get(dev->of_node);
>  	if (!np)
>  		return -EINVAL;
>  
> @@ -1066,7 +1066,7 @@ static int __maybe_unused _get_cpu_power(unsigned long *mW, unsigned long *kHz,
>  		return -EINVAL;
>  
>  	Hz = *kHz * 1000;
> -	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &Hz);
> +	opp = dev_pm_opp_find_freq_ceil(dev, &Hz);
>  	if (IS_ERR(opp))
>  		return -EINVAL;
>  
> @@ -1086,30 +1086,38 @@ static int __maybe_unused _get_cpu_power(unsigned long *mW, unsigned long *kHz,
>  
>  /**
>   * dev_pm_opp_of_register_em() - Attempt to register an Energy Model
> - * @cpus	: CPUs for which an Energy Model has to be registered
> + * @dev		: Device for which an Energy Model has to be registered
> + * @cpus	: CPUs for which an Energy Model has to be registered. For
> + *		other type of devices it should be set to NULL.
>   *
>   * This checks whether the "dynamic-power-coefficient" devicetree property has
>   * been specified, and tries to register an Energy Model with it if it has.
> + * Having this property means the voltages are known for OPPs and the EM
> + * might be calculated.
>   */
> -void dev_pm_opp_of_register_em(struct cpumask *cpus)
> +int dev_pm_opp_of_register_em(struct device *dev, struct cpumask *cpus)
>  {
> -	struct em_data_callback em_cb = EM_DATA_CB(_get_cpu_power);
> -	int ret, nr_opp, cpu = cpumask_first(cpus);
> -	struct device *cpu_dev;
> +	struct em_data_callback em_cb = EM_DATA_CB(_get_power);
>  	struct device_node *np;
> +	int ret, nr_opp;
>  	u32 cap;
>  
> -	cpu_dev = get_cpu_device(cpu);
> -	if (!cpu_dev)
> -		return;
> +	if (IS_ERR_OR_NULL(dev)) {
> +		ret = -EINVAL;
> +		goto failed;
> +	}
>  
> -	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
> -	if (nr_opp <= 0)
> -		return;
> +	nr_opp = dev_pm_opp_get_opp_count(dev);
> +	if (nr_opp <= 0) {
> +		ret = -EINVAL;
> +		goto failed;
> +	}
>  
> -	np = of_node_get(cpu_dev->of_node);
> -	if (!np)
> -		return;
> +	np = of_node_get(dev->of_node);
> +	if (!np) {
> +		ret = -EINVAL;
> +		goto failed;
> +	}
>  
>  	/*
>  	 * Register an EM only if the 'dynamic-power-coefficient' property is
> @@ -1120,9 +1128,20 @@ void dev_pm_opp_of_register_em(struct cpumask *cpus)
>  	 */
>  	ret = of_property_read_u32(np, "dynamic-power-coefficient", &cap);
>  	of_node_put(np);
> -	if (ret || !cap)
> -		return;
> +	if (ret || !cap) {
> +		dev_dbg(dev, "Couldn't find proper 'dynamic-power-coefficient' in DT\n");
> +		ret = -EINVAL;
> +		goto failed;
> +	}
>  
> -	em_register_perf_domain(cpu_dev, nr_opp, &em_cb, cpus);
> +	ret = em_register_perf_domain(dev, nr_opp, &em_cb, cpus);
> +	if (ret)
> +		goto failed;
> +
> +	return 0;
> +
> +failed:
> +	dev_dbg(dev, "Couldn't register Energy Model %d\n", ret);
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_of_register_em);
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index 747861816f4f..822ff9f52bf7 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -11,6 +11,7 @@
>  #ifndef __LINUX_OPP_H__
>  #define __LINUX_OPP_H__
>  
> +#include <linux/energy_model.h>
>  #include <linux/err.h>
>  #include <linux/notifier.h>
>  
> @@ -360,7 +361,11 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpuma
>  struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
>  struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
>  int of_get_required_opp_performance_state(struct device_node *np, int index);
> -void dev_pm_opp_of_register_em(struct cpumask *cpus);
> +int dev_pm_opp_of_register_em(struct device *dev, struct cpumask *cpus);
> +static inline void dev_pm_opp_of_unregister_em(struct device *dev)
> +{
> +	em_unregister_perf_domain(dev);
> +}
>  #else
>  static inline int dev_pm_opp_of_add_table(struct device *dev)
>  {
> @@ -400,7 +405,13 @@ static inline struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
>  	return NULL;
>  }
>  
> -static inline void dev_pm_opp_of_register_em(struct cpumask *cpus)
> +static inline int dev_pm_opp_of_register_em(struct device *dev,
> +					    struct cpumask *cpus)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +static inline void dev_pm_opp_of_unregister_em(struct device *dev)
>  {
>  }
>  
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
