Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 303EDE1D45
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2019 15:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405972AbfJWNuC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Oct 2019 09:50:02 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35299 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405956AbfJWNuB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2019 09:50:01 -0400
Received: by mail-ed1-f66.google.com with SMTP id k2so5124780edx.2;
        Wed, 23 Oct 2019 06:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8qBb291IPE2og/l7u8OiTDfQtbzmiVhAHgv1m3GbkfM=;
        b=PvPI2OUUIth0m6/ElRXyVRuYu9Qan/98GzjzGOkXBd5cUTPBNeyC1CjvIPtKtn1VQ5
         XKg24pqbXlp81cqT943pHDULu5qqNhSXr4hBAgj2CDhVOJH7/mXkV5DrDzXGFcaaJBDt
         ZGKnQgdBi5kir79+dSPmTkQkTjIGr4tgkGseYYxVe4ftNGu7nnicwoKW5yPfEAC5Rcpp
         TPmH/cRd861xPiqBiQs/ddK6b/aWKL7ews//H/01vvFLLpeSFQF4+U4MIMFCB8DiGroD
         EpUu7x4ieX+082Qqc4KklTZ/+cPk8k1g93bFxeyStPMNI3Nrzc/WeiY7wzvBff9Cu8QZ
         4+hA==
X-Gm-Message-State: APjAAAWm0xBPohVFjCswQjmCU2VAy7SOnr8jTJvWg6J4mEC3jUJmF25S
        2WdqDNAqQbmZLSmIeZ+v38k=
X-Google-Smtp-Source: APXvYqwjWvPU2P28o+R/0H7qCyJXE4W8hZoo+hrDHIsqBv9q1Xi6Hyp0zb62g4wWhOXMSl17h7J2Hw==
X-Received: by 2002:a50:ff19:: with SMTP id a25mr9916560edu.181.1571838599737;
        Wed, 23 Oct 2019 06:49:59 -0700 (PDT)
Received: from pi3 ([194.230.155.217])
        by smtp.googlemail.com with ESMTPSA id j43sm734313eda.19.2019.10.23.06.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 06:49:58 -0700 (PDT)
Date:   Wed, 23 Oct 2019 15:49:56 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kukjin Kim <kgene@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 33/36] ARM: s3c: move low-level clk reg access into
 platform code
Message-ID: <20191023134956.GK11048@pi3>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-33-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191010203043.1241612-33-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 10, 2019 at 10:30:17PM +0200, Arnd Bergmann wrote:
> Rather than have the cpufreq drivers touch include the
> common headers to get the constants, add a small indirection.
> This is still not the proper way that would do this through
> the common clk API, but it lets us kill off the header file
> usage.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-s3c24xx/Makefile               |  2 +-
>  arch/arm/mach-s3c24xx/cpufreq-utils.c        | 32 ++++++++++++++++++++
>  drivers/cpufreq/s3c2410-cpufreq.c            |  8 +----
>  drivers/cpufreq/s3c2412-cpufreq.c            | 10 ++----
>  drivers/cpufreq/s3c2440-cpufreq.c            | 16 +++-------
>  drivers/cpufreq/s3c24xx-cpufreq.c            | 11 ++-----
>  include/linux/soc/samsung/s3c-cpufreq-core.h |  7 +++++
>  7 files changed, 51 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
> index 695573df00b1..195a4cb23ecb 100644
> --- a/arch/arm/mach-s3c24xx/Makefile
> +++ b/arch/arm/mach-s3c24xx/Makefile
> @@ -38,7 +38,7 @@ obj-$(CONFIG_PM_SLEEP)		+= irq-pm.o sleep.o
>  
>  # common code
>  
> -obj-$(CONFIG_S3C2410_CPUFREQ_UTILS) += cpufreq-utils.o
> +obj-$(CONFIG_ARM_S3C24XX_CPUFREQ) += cpufreq-utils.o

Drop also here S3C2410_CPUFREQ_UTILS entirely.

Best regards,
Krzysztof

