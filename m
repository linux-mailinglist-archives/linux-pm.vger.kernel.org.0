Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20AD942D30C
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 08:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbhJNG6o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 02:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhJNG6n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Oct 2021 02:58:43 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6B2C061746
        for <linux-pm@vger.kernel.org>; Wed, 13 Oct 2021 23:56:39 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id m21so4608945pgu.13
        for <linux-pm@vger.kernel.org>; Wed, 13 Oct 2021 23:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ElQNmzsxcV0CPmY8lvOg8SstMmCe+niXLKtqIMPRzlc=;
        b=Xp5UvWAIJv0+50PGfjRILQj/4/m2mfb9EUgCxvcD+M7fvKZBW3ScvNqMtwYsIBUolx
         amwkMgIcTtK444A6G5yuXtwsK0LfRQaiW8On3gx2OrterEklOFlmopltMMiLERqADDeP
         YodOx0s0JroK/EqhGJxBmfIhAc/Dsrs2dDmo6+RGW1HWNO+NtZd5dhw056LK+ZDA4BUo
         aexhlv7+hP84yByZj4zkeDEzgJPYOkjmJA5VDaYpIztTS/5AkoWO8af4x80fBBYTMbSA
         q1kvSHyhxw+2NQizDfbXkDoWawxzEr0v42mukXgU8EEAunkIDOjMXYOp4fAqAo0ZaaVP
         gkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ElQNmzsxcV0CPmY8lvOg8SstMmCe+niXLKtqIMPRzlc=;
        b=xCK+PHUSeLOPcJJQHHKETmiDhKozTkouldibC4SYB39BplYhLG0OHEr4hPtIZO4JF4
         UkL0gXvXf8Bw1TJFjtDUoXKpB+9Pexsz1PS4hOkbs3rw359COSmxs14xvW02VcfbQ309
         PU2m7Gxwr/sFF002KGE551BG6kVQUix/ZXy3ulBFEBRLb0SycbvCD8NTRsCIoYcH1rJ8
         shF5bgBnA1XEjyr9hnAw3ZCspEAgKf7GYr+XF/9aiSoMobJPW1k6JJGTFJbPRtGKZwGX
         Yvf0+jQ1hL0oJiDYX9AejLEBORaxi8rd0LQFYCXkRHFLIAlgKz/3Jq6wDojUktW0kVSC
         aNdg==
X-Gm-Message-State: AOAM530AvXTmOGNwbrY4O74jBtyqB1bIRzydQumZ6cjlBiZZumBKQm2E
        2BZx7ecCxHxPiMV/gQJnss6H++Jyvce4Zw==
X-Google-Smtp-Source: ABdhPJwVIm0nmI+e9hjedM+iJOgP7Bo19ctF0+0OahszYFIkHTFSCY/vLqLX9TFlcadPSMGBhvfjlQ==
X-Received: by 2002:a65:6187:: with SMTP id c7mr2918324pgv.317.1634194598786;
        Wed, 13 Oct 2021 23:56:38 -0700 (PDT)
Received: from localhost ([106.201.113.61])
        by smtp.gmail.com with ESMTPSA id j12sm1427294pff.127.2021.10.13.23.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 23:56:38 -0700 (PDT)
Date:   Thu, 14 Oct 2021 12:26:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Hector Martin <marcan@marcan.st>
Cc:     Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/9] opp: core: Don't warn if required OPP device
 does not exist
Message-ID: <20211014065636.lkv77aqbugp3qhif@vireshk-i7>
References: <20211011165707.138157-1-marcan@marcan.st>
 <20211011165707.138157-5-marcan@marcan.st>
 <20211012032144.2ltlpat7orrsyr6k@vireshk-i7>
 <b7cd51ec-38e5-11d8-5193-1170c9d60ac9@marcan.st>
 <20211012055143.xmkbvhbnolspgjin@vireshk-i7>
 <caf16a6c-f127-7f27-ed17-0522d9f1fb9e@marcan.st>
 <20211012092603.lkmhhjoo5v67wh44@vireshk-i7>
 <049FC437-EC38-4FE5-891E-5E25960892CF@marcan.st>
 <20211012093252.hb6rlcpxv5bmk7n3@vireshk-i7>
 <0db8e994-ac2c-8fad-55d0-1b5a9e2e21f2@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0db8e994-ac2c-8fad-55d0-1b5a9e2e21f2@marcan.st>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14-10-21, 15:52, Hector Martin wrote:
> The CPU devices aren't attached to their genpd, so the required OPP
> transition fails with the same error.
> 
> However, this was easier to fix than I expected. With this patch to
> cpufreq-dt, it all works properly, and I can drop the parent genpd
> from the clock node and related handling. Thoughts?
> 
> commit c4f88743374c1f4678ee7f17fb6cae30ded9ed59
> Author: Hector Martin <marcan@marcan.st>
> Date:   Thu Oct 14 15:47:45 2021 +0900
> 
>     cpufreq: dt: Attach CPU devices to power domains
>     This allows the required-opps mechanism to work for CPU OPP tables,
>     triggering specific OPP levels in a parent power domain.
>     Signed-off-by: Hector Martin <marcan@marcan.st>
> 
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index 8fcaba541539..5b22846b557d 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -16,6 +16,7 @@
>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/pm_domain.h>
>  #include <linux/pm_opp.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
> @@ -264,6 +265,16 @@ static int dt_cpufreq_early_init(struct device *dev, int cpu)
>  		goto out;
>  	}
> +	/*
> +	 * Attach the CPU device to its genpd domain (if any), to allow OPP
> +	 * dependencies to be satisfied.
> +	 */
> +	ret = genpd_dev_pm_attach(cpu_dev);
> +	if (ret <= 0) {
> +		dev_err(cpu_dev, "Failed to attach CPU device to genpd\n");
> +		goto out;
> +	}
> +

Other platform do this from some other place I think.

Ulf, where should this code be moved ? cpu-clk driver ?

-- 
viresh
