Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991A61CA295
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 07:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgEHFXl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 01:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgEHFXl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2020 01:23:41 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E25C05BD0B
        for <linux-pm@vger.kernel.org>; Thu,  7 May 2020 22:23:40 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q24so3723009pjd.1
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2020 22:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0ahYPnFGgIMDjQSfV7hJnYdkOoepBn7h7C04Xu4iOHY=;
        b=XDzzOWAz1DGuofj463zagNRWU0ERqALCX98vKPku9sqz4LvMcN51P3d72Q1dwPOKug
         JS2ZhSqvPLLXWGospnhS5fVo7S2dH2pW2MlVcr24w4fcpMs2HN+rnhumjOBAwZ/BpAVT
         nOlFyscQk06CW/5JRJ+vYsbkJL1hZgohMaJk32ZM8Rgya7RGqAAbXGCwHzIG90eegcso
         7HRQUlZfrmGDNZHGO7Ggh7w9Ys/EHJ2CP0sXH90fc4UBQf3A7Eq/ySjdtzDbpgMOFbd5
         lwn/nJ/ZAjJGH94R7bcboH4d3eDRXIPSNhQLaDqvmt7E4fkGT8MHs2V+BQtWPKjS6n7Q
         FYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0ahYPnFGgIMDjQSfV7hJnYdkOoepBn7h7C04Xu4iOHY=;
        b=Wran3fFnm8TlFuJKlqWxtCUo8e8+C8z7gLi7pFv2wu5qaDiJO225Z2gtbs4c8iqQEZ
         2rfhR1ImHjIUvDdoENiWRuZgbuN9acoboPvRfrdFh34bbqvhKhRwwwSPlMe9K4P3sR6g
         Bc/Tr0P/ajQvR/KCejXxGf4lvY4cAwxk3eEysAKDzJbH787YKLA2hx6sb5jj3K21tcbG
         hJW8qhF2A7kgenB/wEtGO1H97CTaStZcnRsLYsqjUuB2bSoH5k3OAF1M6L0G3nyt3Eku
         00unDw8ZTwXUvqU5Wfsh0OA02WPh2vYlKaRYVDtujJdpXCFqFrAAfEZqMrTpV9MYbAUQ
         bAzw==
X-Gm-Message-State: AGi0PubXLbhqAen8aydEuiPrHuMkUWYQDnmeu7aVeQUji/eg87tCvEzz
        Sd4lOcllJhRLVJ3vsqEhKuMVwQ==
X-Google-Smtp-Source: APiQypLBhp9TJEejGQtByXiKySJX/jdsmq9jhlKhi7eQSSPKRyH4YiAtD9EqAjmvsrH/i3x5jnI3tQ==
X-Received: by 2002:a17:902:a413:: with SMTP id p19mr766371plq.1.1588915420189;
        Thu, 07 May 2020 22:23:40 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id w125sm467721pgw.22.2020.05.07.22.23.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 22:23:39 -0700 (PDT)
Date:   Fri, 8 May 2020 10:53:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Jens Axboe <axboe@kernel.dk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] cpufreq: qoriq: Add platform dependencies
Message-ID: <20200508052337.spla662td4kge3wm@vireshk-i7>
References: <20200507112955.23520-1-geert+renesas@glider.be>
 <20200507112955.23520-3-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507112955.23520-3-geert+renesas@glider.be>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-05-20, 13:29, Geert Uytterhoeven wrote:
> The Freescale QorIQ clock controller is only present on Freescale E500MC
> and Layerscape SoCs.  Add platform dependencies to the QORIQ_CPUFREQ
> config symbol, to avoid asking the user about it when configuring a
> kernel without E500MC or Layerscape support.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/cpufreq/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index c3e6bd59e9208822..e917501325525f16 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -323,7 +323,8 @@ endif
>  
>  config QORIQ_CPUFREQ
>  	tristate "CPU frequency scaling driver for Freescale QorIQ SoCs"
> -	depends on OF && COMMON_CLK && (PPC_E500MC || ARM || ARM64)
> +	depends on OF && COMMON_CLK
> +	depends on PPC_E500MC || SOC_LS1021A || ARCH_LAYERSCAPE || COMPILE_TEST
>  	select CLK_QORIQ
>  	help
>  	  This adds the CPUFreq driver support for Freescale QorIQ SoCs

Applied. Thanks.

-- 
viresh
