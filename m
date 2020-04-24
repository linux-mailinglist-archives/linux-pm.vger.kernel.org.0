Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E5E1B7110
	for <lists+linux-pm@lfdr.de>; Fri, 24 Apr 2020 11:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgDXJhZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Apr 2020 05:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726665AbgDXJhY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2020 05:37:24 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CF3C09B047
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 02:37:24 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v8so9544062wma.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 02:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lpgfeCztxAhzxjhQqiFZc+a2M7I9kDIUKtebW9THuHo=;
        b=E+H+PKEWckalgAUrAxfA2tUr4Dr5zRoWeGzskBy6H53BglCw3eP155NoYhsC7jdQiI
         qluFEhKpQ+DSHSzqLqSZMeD0k14RwoB+SUuhVdhR8jgyw4gXACOPaWr9XutcMcLuLel3
         8WZxlynNH7qJd0BspwLL1sYeTrHFFu3a76G+RdF7obaS1pLM1DSCbMFbNY9dK4EZ5ymT
         tlnH/ERsB9TegNHu+KfzIuiJdzFqqCnkwQ8PTxfEGIX3McYJjbN7mZF6m5rNJlKz3aGn
         ZTeNp7OtPikPXwo7ZqOKDOi+bqkFqVzNR4szarGXzmGI+oivP5a8mWF6fMD7ByBzQbzj
         15Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lpgfeCztxAhzxjhQqiFZc+a2M7I9kDIUKtebW9THuHo=;
        b=eliLUOyjKs5eVg5KrX3XqHvjeJ9rQHrtJ9ZWJzxVITBqfB4W6ny9XDmoQUXi0G34/j
         wIG2AjUPwfDVUFcOYdArhtrgd6jnXB6U/XpLkEVipLk/k6ojj3YgA3f34dHvZQfiA1mV
         RovMZVw9brIKJS206zT2YUgivK7YT4n4oy/MaWBPjCz870JZ1DUHWaz1FZQss1aGwm0D
         GlTdi1h/BSW0SEANxswucudaDf7Nycsyw35x3EjDodRODaen3SCTKuHgodgQZLSoYnZw
         WuAj/XOiqwoV7qn5kH4Ngo4JCST94g1Csq2EmKQEXTZspF/5Do0hZz1Tc5mWXju6PuJl
         R5pw==
X-Gm-Message-State: AGi0PuayZ3gmDBYlv/C8/fe7NIRQBWcwujYNMsG/fP1Yr/rNntQjAYr0
        ou8zbqswa/lpVL8cfSfx4OedpA==
X-Google-Smtp-Source: APiQypIP711LckL5LI1ubR6GN3OUzUAydpJDOVRvnJ3Nw6MpHq29JuuPonguAQ22PujRITptpK9QEA==
X-Received: by 2002:a7b:c213:: with SMTP id x19mr8902459wmi.53.1587721043049;
        Fri, 24 Apr 2020 02:37:23 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id a7sm2062330wmj.12.2020.04.24.02.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 02:37:22 -0700 (PDT)
Date:   Fri, 24 Apr 2020 10:37:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     saravanan sekar <sravanhome@gmail.com>
Cc:     andy.shevchenko@gmail.com, robh+dt@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v9 2/6] mfd: mp2629: Add support for mps battery charger
Message-ID: <20200424093720.GA3542@dell>
References: <20200415162030.16414-1-sravanhome@gmail.com>
 <20200415162030.16414-3-sravanhome@gmail.com>
 <20200424071822.GM3612@dell>
 <8ff17d07-8030-fcfe-8d8a-3011e4077778@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ff17d07-8030-fcfe-8d8a-3011e4077778@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 24 Apr 2020, saravanan sekar wrote:

> Hi Lee,
> 
> On 24/04/20 9:18 am, Lee Jones wrote:
> > On Wed, 15 Apr 2020, Saravanan Sekar wrote:
> > 
> > > mp2629 is a highly-integrated switching-mode battery charge management
> > > device for single-cell Li-ion or Li-polymer battery.
> > > 
> > > Add MFD core enables chip access for ADC driver for battery readings,
> > > and a power supply battery-charger driver
> > > 
> > > Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> > > ---
> > >   drivers/mfd/Kconfig        |  9 ++++
> > >   drivers/mfd/Makefile       |  2 +
> > >   drivers/mfd/mp2629.c       | 86 ++++++++++++++++++++++++++++++++++++++
> > >   include/linux/mfd/mp2629.h | 19 +++++++++
> > >   4 files changed, 116 insertions(+)
> > >   create mode 100644 drivers/mfd/mp2629.c
> > >   create mode 100644 include/linux/mfd/mp2629.h
> > How is this driver registered?
> > 
> > Looks like it has device tree support.  Is there another way?
> Yes, only using device tree

Then how about using 'simple-mfd' and 'syscon'?

Then you can omit this driver completely.

> > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > index 3c547ed575e6..85be799795aa 100644
> > > --- a/drivers/mfd/Kconfig
> > > +++ b/drivers/mfd/Kconfig
> > > @@ -434,6 +434,15 @@ config MFD_MC13XXX_I2C
> > >   	help
> > >   	  Select this if your MC13xxx is connected via an I2C bus.
> > > +config MFD_MP2629
> > > +	tristate "Monolithic power system MP2629 ADC and Battery charger"
> > > +	depends on I2C
> > > +	select REGMAP_I2C
> > > +	help
> > > +	  Select this option to enable support for monolithic power system
> > > +	  battery charger. This provides ADC, thermal, battery charger power
> > > +	  management functions on the systems.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
