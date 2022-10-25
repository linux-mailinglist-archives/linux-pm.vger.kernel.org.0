Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5613660C317
	for <lists+linux-pm@lfdr.de>; Tue, 25 Oct 2022 07:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiJYFIN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Oct 2022 01:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiJYFH4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Oct 2022 01:07:56 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D07144E1C
        for <linux-pm@vger.kernel.org>; Mon, 24 Oct 2022 22:07:04 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id e129so10511420pgc.9
        for <linux-pm@vger.kernel.org>; Mon, 24 Oct 2022 22:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b0wunblmCvoNzFQ+Ax4TKZ+hqx1Bra2g+X5BnPCtjKo=;
        b=jFE6Hyrm+Lpe5udXJpySAIwraZa4iNCeSxsMwbiR3bPbgfHIJPH/lve2TrBnc+E4FU
         LtdFeGTgkaXgPerN3IywVP/HEEntwVO88rSgCxOnhi+WBaQYK0FDZG471nn4pFKByfGX
         gyxZd9tnTcC2K0fxAw4bG4Mz6edA+CWsNhNPMwiLXpgmS8BGsPB+ZU4Rx9zWBhHsq1PZ
         CE6HbEs/jt6Tq26FMWZb+MTX9CxQ7TzNKDIRxp+eG4dYELo+2Aiq5tB2lltb80+zYV66
         qCMv87gcoTavBPMSu+YFwyYZKcfj7L+CCCiAhAfSAs43CyxPzxKlhoqw6+Mm6TN4SaTs
         jJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0wunblmCvoNzFQ+Ax4TKZ+hqx1Bra2g+X5BnPCtjKo=;
        b=2bGBOzx4V//q9vO1bySOROYEN81+G1gqh+TJ8uFZWPpQDekjqlzQ56KifbAa0265E/
         PGvcWegv+3IlSRGre/9X0Y2E4eRy96znMELXrZh3GdGJATYWw9ix0oKZGJx4D0W6s7ly
         t9jLwwq/Gx+8McYFPShfUq5rTPGVk8NO5WAmacNTnnEKKPpYUhvN8x3OvF0v9JQTH7wl
         B9KnPsJFlPoVZ/fQqL5gVZTAsqacLpcMiMd8rTZlx3cfTWioQ861jgFhNmsiJzfYwdxj
         VlUCzmWnhQ8WRwy8bAxsTtHpXzLp75w4bNGPQ7k0J79gzgWaMsRwZYU81TV7PyMB6+A3
         T8Cg==
X-Gm-Message-State: ACrzQf0v/5DlDxUCb/EI1e9ndCE9Jq53nt0rq9oP9K/SUfZGr3Pz3l3X
        0cm8YA7m+1tjGvp5trXglLGhHQ==
X-Google-Smtp-Source: AMsMyM7hqviQBY3OSfS0lzYvRThyk6R7SGD7bS0FtbO5in9b0W3ENrdpYNpDzlCdWNdj/96voNr19Q==
X-Received: by 2002:a63:6742:0:b0:452:59b9:22e with SMTP id b63-20020a636742000000b0045259b9022emr30639524pgc.205.1666674423624;
        Mon, 24 Oct 2022 22:07:03 -0700 (PDT)
Received: from localhost ([122.172.87.26])
        by smtp.gmail.com with ESMTPSA id n13-20020a170902d2cd00b00176ae5c0f38sm512817plc.178.2022.10.24.22.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 22:07:02 -0700 (PDT)
Date:   Tue, 25 Oct 2022 10:37:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 04/11] ARM: sa1100: make cpufreq driver build standalone
Message-ID: <20221025050700.3dzdgicrx3hcdhqa@vireshk-i7>
References: <20221021155000.4108406-1-arnd@kernel.org>
 <20221021155000.4108406-5-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021155000.4108406-5-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-10-22, 17:49, Arnd Bergmann wrote:
> --- a/drivers/cpufreq/sa1110-cpufreq.c
> +++ b/drivers/cpufreq/sa1110-cpufreq.c
> @@ -29,6 +29,38 @@
>  
>  #undef DEBUG
>  
> +#define NR_FREQS	16
> +
> +/*
> + * This table is setup for a 3.6864MHz Crystal.
> + */
> +static struct cpufreq_frequency_table sa11x0_freq_table[NR_FREQS+1] = {
> +	{ .frequency = 59000,	/*  59.0 MHz */},
> +	{ .frequency = 73700,	/*  73.7 MHz */},
> +	{ .frequency = 88500,	/*  88.5 MHz */},
> +	{ .frequency = 103200,	/* 103.2 MHz */},
> +	{ .frequency = 118000,	/* 118.0 MHz */},
> +	{ .frequency = 132700,	/* 132.7 MHz */},
> +	{ .frequency = 147500,	/* 147.5 MHz */},
> +	{ .frequency = 162200,	/* 162.2 MHz */},
> +	{ .frequency = 176900,	/* 176.9 MHz */},
> +	{ .frequency = 191700,	/* 191.7 MHz */},
> +	{ .frequency = 206400,	/* 206.4 MHz */},
> +	{ .frequency = 221200,	/* 221.2 MHz */},
> +	{ .frequency = 235900,	/* 235.9 MHz */},
> +	{ .frequency = 250700,	/* 250.7 MHz */},
> +	{ .frequency = 265400,	/* 265.4 MHz */},
> +	{ .frequency = 280200,	/* 280.2 MHz */},
> +	{ .frequency = CPUFREQ_TABLE_END, },
> +};
> +
> +static unsigned int sa11x0_getspeed(unsigned int cpu)
> +{
> +	if (cpu)
> +		return 0;
> +	return sa11x0_freq_table[PPCR & 0xf].frequency;
> +}
> +
>  struct sdram_params {
>  	const char name[20];
>  	u_char  rows;		/* bits				 */

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
