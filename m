Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B48766302D
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2019 07:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfGIFtm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jul 2019 01:49:42 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39342 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfGIFtm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jul 2019 01:49:42 -0400
Received: by mail-qk1-f196.google.com with SMTP id w190so2644975qkc.6;
        Mon, 08 Jul 2019 22:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G8bFHO9ERI+gTpLxJGdPs7eJ2Lvsv0iXpU1CdINSs20=;
        b=r6N4iEKIb1M6dPZmH5V0NwJGABKPMEHOathvp1R8fTfznxz++n/GX8mNBIOggA3e2Y
         WBBlwxVccGxFlSjUqXcLQaShyi1te9HsBgamOA6z6vC+p+ETZ51Z4RItVzSMumPg2F4N
         wM8vHvIDn0AyIQcRxIIrFvPz00HExwnDWn2EgeiChsi99XmorHxOqtKZsjVrnnrM9Rv5
         95EnD+VN3iJ+LLBKOLrGWtK157/Y3cP419UoY1aKtU/NG/5nL+Owb0wjNjWz3vH+KgZX
         YP/Q3A5SuMDVJxD7yXx6KN9x0jAJco/Voaqax0wgObGxEgrjDFwGa918CN3BTgI5MR1U
         JIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G8bFHO9ERI+gTpLxJGdPs7eJ2Lvsv0iXpU1CdINSs20=;
        b=T88CtsnSAZlIfskmhDeQXgqItQZkXsU/UeEzi9cvX1k3+UQYbq3hs8OoNWiTPX7YFY
         x6RYZ3YSPw6kieTo9UGhlRiupg8UIzDeC5YvUCnfT8pn7/GgfgIgazArv01VeajOyfbU
         P+N9rSDiN5DjFNkQn8GWGhmnx8y0v7UDPK4P9g1jAkwfYpFi/OZ4My3/23C+O/KUb5rb
         2pRa6KTcDaOXKXkvCaJ9gJp20ByX+76KHmuBacv4KCyR8A22OpGJPti0UUkbVObAPUeP
         ceUu/BUpMt1+7bJV9gsozTwRKTJKIKy7QgLs/r97rUVFRxzweFFvnDxF4/hTHvdTQnYr
         ltDQ==
X-Gm-Message-State: APjAAAUR4qSOWHp74HH3G3obFlu5J0VIiXrOrwTM8044P91+0ArcaQqF
        bNGMwekEs5fKIes1z3NPnhVpmeun
X-Google-Smtp-Source: APXvYqzHjOCe75idq3CFtuKGhVKAD514DDOOkm7xCpEwzs4U/kSkhhnH751s3KxvK1sZpmT08Pw0vQ==
X-Received: by 2002:ae9:ed4b:: with SMTP id c72mr17179650qkg.400.1562651381058;
        Mon, 08 Jul 2019 22:49:41 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id i23sm5592434qtm.17.2019.07.08.22.49.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 22:49:40 -0700 (PDT)
Subject: Re: [PATCH v1 6/6] cpuidle: tegra: Remove CPUIDLE_FLAG_TIMER_STOP
 from all states
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190707233809.14400-1-digetx@gmail.com>
 <20190707233809.14400-7-digetx@gmail.com>
Message-ID: <89baad3d-36f3-a2ac-3794-e174fbeb953a@gmail.com>
Date:   Tue, 9 Jul 2019 08:49:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190707233809.14400-7-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

08.07.2019 2:38, Dmitry Osipenko пишет:
> The Tegra's clocksource driver got some rework recently and now the
> internal/local CPU timers usage is discouraged on Tegra20/30 SoCs in
> a favor of the platform-specific timers that are assigned as per-CPU
> clocksources because they do not suffer from the CPU-freq changes and
> are always-ON during of CPU-idling. That happened in the commit
> f6d50ec5f85c ("clocksource/drivers/tegra: Support per-CPU timers on all
> Tegra's"). The Tegra's clocksource driver is the essential arch-driver
> that is guaranteed to always present on all Tegra SoCs up to Tegra124.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/cpuidle/cpuidle-tegra.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
> index 464b2376905a..e2aa46231c05 100644
> --- a/drivers/cpuidle/cpuidle-tegra.c
> +++ b/drivers/cpuidle/cpuidle-tegra.c
> @@ -143,7 +143,6 @@ static struct cpuidle_driver tegra_idle_driver = {
>  			.exit_latency		= 2000,
>  			.target_residency	= 2200,
>  			.power_usage		= 0,
> -			.flags			= CPUIDLE_FLAG_TIMER_STOP,
>  			.name			= "powered-down",
>  			.desc			= "CPU core powered-off",
>  		},
> @@ -152,8 +151,7 @@ static struct cpuidle_driver tegra_idle_driver = {
>  			.exit_latency		= 5000,
>  			.target_residency	= 10000,
>  			.power_usage		= 0,
> -			.flags			= CPUIDLE_FLAG_COUPLED |
> -						  CPUIDLE_FLAG_TIMER_STOP,
> +			.flags			= CPUIDLE_FLAG_COUPLED,
>  			.name			= "powered-down",
>  			.desc			= "CPU cluster powered-off",
>  		},
> 

Actually, it should be fine to keep this flag because I found that
tick_broadcast_oneshot_control() checks for the C3STOP flag and thus
CPUIDLE_FLAG_TIMER_STOP has no effect in that case. Will drop this patch in the next revision.
