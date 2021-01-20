Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD412FCA0B
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 05:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbhATElN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 23:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbhATEkT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 23:40:19 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EF0C0613C1
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 20:39:39 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id t6so11839326plq.1
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 20:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3Mw9kpTWYLs3GYeFCfv2XLbWScki4E8QbYrJLATCMOM=;
        b=NSOrtz9JoqUpYLUCCHjbFEdlVTD56bqaffClcuXWTCrFL897Lom+Qbl/QZRG8jUavo
         3BVHucGwNpSvG0TN0uzfs/15kOixsoGwr8cAkkZLHw1iKT1Fd/re6YcN3qoWaR4RSryj
         X5cI35dcMrlx6A+1XOsn10yQZuQ+JvIwix4AF9qhS4cpacFOSXlaol/YjhXX32T+kMLd
         WcknRbRNUX85FbG4GwK36nACqMC3Jc0LCvtv7cFCZCKK1+jL4ieziZFp8Vfi20lCTTbN
         Dt8QtG7YTyV/mN0q68LmIAzplQu6gYW0MGfJmEzp+44ebL/CksaqbgtbMJ1+DX9F8TlH
         8lLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3Mw9kpTWYLs3GYeFCfv2XLbWScki4E8QbYrJLATCMOM=;
        b=JixZvMHQpodGQ/Gtro//ETe6JnivS6BXbgv59Xz37VwYgWRJf84Dv55OB98VyItM7E
         jN4tWI1Anhx0pV76dtgGPXGW8y2r5sJFk5S577jX5bHQWye153BgtfAC8OL5LGc6MNm6
         7LD5189+Y1nkeurx7S3C/DrX5wvepEIP3wcShuiVrkWhQSbBKWhgH2fpXB2HydQhKKUi
         FTafoNu28/Olx0V4xaG8FaI2JDJ8qCQ5kYQMNvePsqQE7hyZOWTYi4+TTXpprGv0cvxt
         jD2sRSKGgoGoQsRUSqitZCBEP5N8TXepuHg0MAXvtoKQIsXgg4a07fpxf9jgwMvq3dPp
         ZhbA==
X-Gm-Message-State: AOAM531JEQ3HoM7uTunSszfDUv+D+WSqTiMEAiUKqhCI+Nr6TqqvZTIS
        +nayDuzzBmX8q1T7/KaMTMlhjw==
X-Google-Smtp-Source: ABdhPJxWrwGkrMAt216utAgHlcqTJR4nbRCrGF/RIvEBvOStwKqO/SPw4ZkPZWTjLIEYXgSFndBaEA==
X-Received: by 2002:a17:902:b692:b029:de:43aa:6537 with SMTP id c18-20020a170902b692b02900de43aa6537mr8177507pls.65.1611117578969;
        Tue, 19 Jan 2021 20:39:38 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id u68sm620672pfb.70.2021.01.19.20.39.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jan 2021 20:39:38 -0800 (PST)
Date:   Wed, 20 Jan 2021 10:09:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 1/3] PM: domains: Make set_performance_state()
 callback optional
Message-ID: <20210120043933.6ilryvgkhvnsrei7@vireshk-i7>
References: <20210120015010.14191-1-digetx@gmail.com>
 <20210120015010.14191-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120015010.14191-2-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-01-21, 04:50, Dmitry Osipenko wrote:
> Make set_performance_state() callback optional in order to remove the
> need from power domain drivers to implement a dummy callback. If callback
> isn't implemented by a GENPD driver, then the performance state is passed
> to the parent domain.
> 
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> Tested-by: Matt Merhar <mattmerhar@protonmail.com>
> [tested on NVIDIA Tegra20/30/124 SoCs]
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/base/power/domain.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 9a14eedacb92..0bd0cdc30393 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -297,6 +297,18 @@ static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
>  	return state;
>  }
>  
> +static int _genpd_xlate_performance_state(struct generic_pm_domain *src_genpd,
> +					  struct generic_pm_domain *dst_genpd,
> +					  unsigned int pstate)

I would name them as genpd and parent, that makes it more readable for it.

-- 
viresh
