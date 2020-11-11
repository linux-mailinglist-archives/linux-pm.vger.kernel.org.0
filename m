Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4B62AEDA7
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 10:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgKKJ00 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 11 Nov 2020 04:26:26 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40184 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgKKJ0Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Nov 2020 04:26:25 -0500
Received: by mail-ed1-f67.google.com with SMTP id p93so1537038edd.7;
        Wed, 11 Nov 2020 01:26:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OdzB/jIicwSRsIBqe3je5Z5qz8YP6pSQHD6SoGClZyc=;
        b=eBihg8aBBU8+XvRLEeRyMWgJ/R7iRq30bWNxEX6jE8i4l0MWtLjqVs113coO8B627L
         BaTkVAuYJuaOLgjQMsjC+uKorbCoDANtXEK5+Dz38D1QUWbpukQf+L3g9nTTdGp5mztR
         iWEvkxPnYdE87SLdyQ4VEyo31EPmkON9PAyiyoy+o/5tl4Ei46nycn1KvMqrhWEtCMXc
         2EmqPUnwgyII9mdxCc9/EIhI2OCHsyS0unncpGOplTcKbqSweGchbffQbi+HMVKIOt+x
         AX8okiLHj4hLx69d1CbBpwqCwjWL3tguIjppm0VBAXIHLWMNkKaZmvIqMJ3hejKaMRLn
         7Sbw==
X-Gm-Message-State: AOAM531uFRuDDQXFDc+fr3sE7sla1x3S3KS/7ol97yl5sIcNrXDya8fh
        XUou3T+CqS3OJFmernlEkTo=
X-Google-Smtp-Source: ABdhPJwycZxm4vB3dtSk1cfv3vSWVxzMWnM8OiFZHVme5ZFG51Ffl5xHG5HC9WEEjJoIIV42kr7DPQ==
X-Received: by 2002:a05:6402:b02:: with SMTP id bm2mr24912274edb.299.1605086782978;
        Wed, 11 Nov 2020 01:26:22 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id k4sm639339edq.73.2020.11.11.01.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 01:26:21 -0800 (PST)
Date:   Wed, 11 Nov 2020 10:26:19 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v8 11/26] memory: tegra124-emc: Make driver modular
Message-ID: <20201111092619.GD4050@kozik-lap>
References: <20201111011456.7875-1-digetx@gmail.com>
 <20201111011456.7875-12-digetx@gmail.com>
 <20201111090434.GB4050@kozik-lap>
 <f44b64f5-6b08-5f1e-4f9b-a73a1705d493@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <f44b64f5-6b08-5f1e-4f9b-a73a1705d493@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 11, 2020 at 12:17:37PM +0300, Dmitry Osipenko wrote:
> 11.11.2020 12:04, Krzysztof Kozlowski пишет:
> >> -obj-$(CONFIG_TEGRA124_EMC)		+= clk-tegra124-emc.o
> >> +obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= clk-tegra124-emc.o
> >> +obj-$(CONFIG_ARCH_TEGRA_132_SOC)	+= clk-tegra124-emc.o
> > How is it related to modularization? It looks like different issue is
> > fixed here.
> 
> The CONFIG_TEGRA124_EMC now could be 'm', while the clock code must be
> built-in. The TEGRA124 EMC driver is used by T124 and T132 SoCs.\

Mhmm,  the CONFIG_TEGRA124_EMC depends on ARCH_TEGRA_124_SOC so on the
config !ARCH_TEGRA_124_SOC && ARCH_TEGRA_132_SOC this was not
selected. Now it will be selected.

> 
> ...
> >> diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
> >> index 6b565f6b5f66..2da7c93c1a6c 100644
> >> --- a/drivers/clk/tegra/clk.h
> >> +++ b/drivers/clk/tegra/clk.h
> >> @@ -881,18 +881,6 @@ void tegra_super_clk_gen5_init(void __iomem *clk_base,
> >>  			void __iomem *pmc_base, struct tegra_clk *tegra_clks,
> >>  			struct tegra_clk_pll_params *pll_params);
> >>  
> >> -#ifdef CONFIG_TEGRA124_EMC
> >> -struct clk *tegra_clk_register_emc(void __iomem *base, struct device_node *np,
> >> -				   spinlock_t *lock);
> >> -#else
> >> -static inline struct clk *tegra_clk_register_emc(void __iomem *base,
> >> -						 struct device_node *np,
> >> -						 spinlock_t *lock)
> >> -{
> >> -	return NULL;
> >> -}
> >> -#endif
> > Why clock changes are so tightly coupled with making an EMC driver
> > modular? Usually this should be a separate change - you adjust any
> > dependencies to accept late or deferred probing, exported symbols,
> > loosen the coupling between drivers, etc. and then you convert something
> > to module.
> 
> Because the clock and EMC driver were not separated from each other
> previously. The clock part can't be modularized easily and probably
> shouldn't.
> 
> I'm not sure whether it's actually possible to split this patch without
> taking a closer a look.
> 
> I'm also doubt that it would really worth the effort for a 100 lines of
> a changed code.

Indeed, the clk and emc drivers are so tightly coupled that anyway it
would be big patch to change the interfaces followed up a small one
making emc module. OK.

Best regards,
Krzysztof

