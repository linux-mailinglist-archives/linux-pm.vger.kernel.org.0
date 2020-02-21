Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68F42168141
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 16:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbgBUPQT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 10:16:19 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40581 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727699AbgBUPQS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 10:16:18 -0500
Received: by mail-wm1-f68.google.com with SMTP id t14so2288689wmi.5
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2020 07:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lsRtvfQ93vhY3R5WN0DHRgFSBr0NRD5+eVgC+E/3Pbw=;
        b=fAAklVNs6u22WEFZnDC9d3+wS0ae4X2F3sUylnwCuDLPilr2eb91R4kz0vBP7QrY/v
         QKDxU7B7r4SuuQR4fWjmrGd9kF0elPfjL6nTklyFRi+Yng5dntCdgTHHcN478Yg3aJRA
         B94xKDBI6YBo3mAp3NyWMsm0TG1okPl9+xTc27v/at80ODKV0fXF+7nwvGDdGlCD0JdI
         0OnR6zADpSAuhYhBmVicqBS5eXMNLC7B8tgGwSb3ejDcTaY8HHEC28xksKWyFzKns3WJ
         EueDIvgrc5dCfwDqMMRpyTwE7GOZGmOYu5/VjtsyPJR+C9E9d+ojXpEJu/kGABv4mDpS
         7Myg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lsRtvfQ93vhY3R5WN0DHRgFSBr0NRD5+eVgC+E/3Pbw=;
        b=kL2PfxeoSnjCy3uiXLu3KdjbK6KGEZEah9SntF5y1LVVMJPOAI2rCyZeq3NccNdDe4
         QAMxXHuaYit39Xx/9HHGwyVlzzndFgSa1/1hpiii/y9hOfWma7APgTR14fvA6xpbmVXp
         sZz4jSAeuikEbzV2YubGk4q04YN/RIRgVb2J+yuG8eXbaUZttkanuU0DcGO+dKWPTnsy
         j1rSC6sqA2W7zxGsVQVI4saOO3+ocE4XPNWrqosp4CcYiVvBjxVZoAB2WZEryqHuBfqr
         KVDgU1qDljYrK45gZMWuy3Igtyc1AbVjHiwk12WMeNoxkDaQdt5mlgmY/lU+K06SJRAJ
         QiQA==
X-Gm-Message-State: APjAAAXHr/sgfM2HHil4qskag/95jODysMw1LDongT6NYdQQdDydJ3Xm
        JoXaPed7mJkbz8jOaABqQI299A==
X-Google-Smtp-Source: APXvYqxw++XREifah78diEeK1TZzx8Ns6mS0TdJog/RtI1u9e/6SveUpjFpR92+56VCNuy0kMv6cdw==
X-Received: by 2002:a7b:c92e:: with SMTP id h14mr4450716wml.110.1582298175055;
        Fri, 21 Feb 2020 07:16:15 -0800 (PST)
Received: from linaro.org ([2a01:e34:ed2f:f020:903b:a048:f296:e3ae])
        by smtp.gmail.com with ESMTPSA id b16sm3955789wmj.39.2020.02.21.07.16.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 07:16:14 -0800 (PST)
Date:   Fri, 21 Feb 2020 16:16:12 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 05/17] ARM: tegra: Propagate error from
 tegra_idle_lp2_last()
Message-ID: <20200221151612.GJ10516@linaro.org>
References: <20200212235134.12638-1-digetx@gmail.com>
 <20200212235134.12638-6-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200212235134.12638-6-digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 13, 2020 at 02:51:22AM +0300, Dmitry Osipenko wrote:
> Technically cpu_suspend() may fail and it's never good to lose information
> about failure. For example things like cpuidle core could correctly sample
> idling time in the case of failure.
> 
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Tested-by: Jasper Korten <jja2000@gmail.com>
> Tested-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

[ ... ]

>  	cpu_cluster_pm_enter();
>  	suspend_cpu_complex();
>  
> -	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
> +	err = cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
>  
>  	/*
>  	 * Resume L2 cache if it wasn't re-enabled early during resume,
> @@ -208,6 +210,8 @@ void tegra_idle_lp2_last(void)
>  
>  	restore_cpu_complex();

If the cpu_suspend fails, does restore_cpu_complex() need to be called ?

>  	cpu_cluster_pm_exit();
> +
> +	return err;
>  }

[ ... ]

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
