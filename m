Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7AADE1D09
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2019 15:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405980AbfJWNo0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Oct 2019 09:44:26 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42880 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405903AbfJWNoZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2019 09:44:25 -0400
Received: by mail-ed1-f68.google.com with SMTP id s20so9794877edq.9;
        Wed, 23 Oct 2019 06:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hBKYE+zy7+DFfvyH7A7knU3GB9ufsS1mx+vP5bbzBP0=;
        b=h+15i4clnO21Zx9dM+73o0B2yXXTJmzRzBHqEXYW1uCb4maysbPf2EpfP2y/jWyQpF
         dPvd08udhWwotPD3HLTKBt6ka5b8X6qI8s7tw7xdywZdR4Yb8bxND5lh2DssOkrU6Ul8
         mLGSJr9FhVXlEIaEN1WsXBd9OWKgQUMPP80dpqiP6M/+wCOclGQsx9iq34DMoVgaAo3/
         9MXE5+GytSW5N2/wpTToUWXSMg1Hv3dGsd8t+8CtROektv8v4vjw1mXRxYE4pLavN8jW
         ZCR9HtoIC2kuTE7UgWFcZgFwxkPvl5Go4zqgNO8jlgagNCxzLfFmzjCqbcPO2c5GAb5G
         4xIQ==
X-Gm-Message-State: APjAAAVFaWR9/NRMnCEZ0p4XQBLa+d4Lc1+wAc3uYx6kbbP2vbRexzIW
        1h/TPwmJ4kL9MtlTX9saKiiodoaI2YE=
X-Google-Smtp-Source: APXvYqw1ctMopj1G34EABDvNktzYOL72/P1RYQagEEVZr6sIwqcab9NGrf4osslw7kr0sYn6k43JVw==
X-Received: by 2002:a17:906:c801:: with SMTP id cx1mr33598956ejb.266.1571838263609;
        Wed, 23 Oct 2019 06:44:23 -0700 (PDT)
Received: from pi3 ([194.230.155.217])
        by smtp.googlemail.com with ESMTPSA id z65sm848736ede.86.2019.10.23.06.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 06:44:22 -0700 (PDT)
Date:   Wed, 23 Oct 2019 15:44:20 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kukjin Kim <kgene@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 31/36] ARM: s3c: cpufreq: use global
 s3c2412_cpufreq_setrefresh
Message-ID: <20191023134420.GJ11048@pi3>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-31-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191010203043.1241612-31-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 10, 2019 at 10:30:15PM +0200, Arnd Bergmann wrote:
> There are two identical copies of the s3c2412_cpufreq_setrefresh
> function: a static one in the cpufreq driver and a global
> version in iotiming-s3c2412.c.
> 
> As the function requires the use of a hardcoded register address
> from a header that we want to not be visible to drivers, just
> move the existing global function and add a declaration in
> one of the cpufreq header files.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/cpufreq/s3c2412-cpufreq.c            | 23 --------------------
>  include/linux/soc/samsung/s3c-cpufreq-core.h |  1 +
>  2 files changed, 1 insertion(+), 23 deletions(-)
> 
> diff --git a/drivers/cpufreq/s3c2412-cpufreq.c b/drivers/cpufreq/s3c2412-cpufreq.c
> index 38dc9e6db633..a77c63e92e1a 100644
> --- a/drivers/cpufreq/s3c2412-cpufreq.c
> +++ b/drivers/cpufreq/s3c2412-cpufreq.c
> @@ -25,8 +25,6 @@
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
>  
> -#include <mach/s3c2412.h>
> -
>  #include <mach/map.h>
>  
>  #define S3C2410_CLKREG(x) ((x) + S3C24XX_VA_CLKPWR)
> @@ -156,27 +154,6 @@ static void s3c2412_cpufreq_setdivs(struct s3c_cpufreq_config *cfg)
>  	clk_set_parent(armclk, cfg->divs.dvs ? hclk : fclk);
>  }
>  
> -static void s3c2412_cpufreq_setrefresh(struct s3c_cpufreq_config *cfg)
> -{
> -	struct s3c_cpufreq_board *board = cfg->board;
> -	unsigned long refresh;
> -
> -	s3c_freq_dbg("%s: refresh %u ns, hclk %lu\n", __func__,
> -		     board->refresh, cfg->freq.hclk);
> -
> -	/* Reduce both the refresh time (in ns) and the frequency (in MHz)
> -	 * by 10 each to ensure that we do not overflow 32 bit numbers. This
> -	 * should work for HCLK up to 133MHz and refresh period up to 30usec.
> -	 */
> -
> -	refresh = (board->refresh / 10);
> -	refresh *= (cfg->freq.hclk / 100);
> -	refresh /= (1 * 1000 * 1000);	/* 10^6 */
> -
> -	s3c_freq_dbg("%s: setting refresh 0x%08lx\n", __func__, refresh);
> -	__raw_writel(refresh, S3C2412_REFRESH);
> -}
> -
>  /* set the default cpu frequency information, based on an 200MHz part
>   * as we have no other way of detecting the speed rating in software.
>   */
> diff --git a/include/linux/soc/samsung/s3c-cpufreq-core.h b/include/linux/soc/samsung/s3c-cpufreq-core.h
> index 4d22be1031b9..eca942559014 100644
> --- a/include/linux/soc/samsung/s3c-cpufreq-core.h
> +++ b/include/linux/soc/samsung/s3c-cpufreq-core.h
> @@ -246,6 +246,7 @@ extern int s3c2412_iotiming_calc(struct s3c_cpufreq_config *cfg,
>  
>  extern void s3c2412_iotiming_set(struct s3c_cpufreq_config *cfg,
>  				 struct s3c_iotimings *iot);
> +extern void s3c2412_cpufreq_setrefresh(struct s3c_cpufreq_config *cfg);

I think that it does not cover the !CONFIG_S3C2412_IOTIMING case.
Either you need to provide also the empty stub or add default=y to
S3C2412_IOTIMING. Otherwise cpufreq driver might end up without this.

Best regards,
Krzysztof
