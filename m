Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE732DE33C
	for <lists+linux-pm@lfdr.de>; Fri, 18 Dec 2020 14:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgLRNWY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Dec 2020 08:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbgLRNWX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Dec 2020 08:22:23 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3312EC06138C
        for <linux-pm@vger.kernel.org>; Fri, 18 Dec 2020 05:21:43 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r7so2132337wrc.5
        for <linux-pm@vger.kernel.org>; Fri, 18 Dec 2020 05:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=F+ibjVaRawhB9by9+I/z97txlwumatdH7xKnsmPgCGQ=;
        b=k5O8dSEmSegIR7pYA9kV2ana+UeZIpHtGeDaUNyh9fmp8oCXJhsX8wUXP68tD5eWZv
         RJZNsMiPVsggdsokowNDv9oX1TWqyfbNOEo8AjdDAIwgyrys3P5y66kWCBOsEuPhQfec
         eWWyJzb0+2YmlgcrJ2Vewwut/ZG8owPpSTRMsG51UIA2RshPJJEckF1PF17v/GpCTCN9
         JmoP6ZT/ILZd8XyE1rTs3xCfMNWWFloEsQPfq5hm3XQ/W43zMNM8RXcjG3enzySy8Pjl
         dsIx74U40ax+muXd4/dAAMrr3h1qL1rj64mYoHM78mhsD9v5orIYz88yAK90ivsTkSv1
         QU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=F+ibjVaRawhB9by9+I/z97txlwumatdH7xKnsmPgCGQ=;
        b=svgRgLNtz2ezHu6xKbmklhICkHLlQd27OZdEoWV3r6+MO5/Uei39rpfxaPKWx8usHO
         1mk9LHp4O+W847lGbA+tgOTR7lYNKVt/RAevVC28bgkADcmcqlQUeiVpJGOY+Bhbwkct
         wUObA15eMx/8wc2Rvsn+QzqIXWQtC0JEjyfM9bBnpQqLU0Nq+q8KSOLMTbKkIMl1mlHa
         /e3zNHNZ+d0l+n5aTkgdFnKplzsDptIULhKpfD38JdkImBIkEH+X816hl5Y+3MYXThEV
         z9T4neax+4I3t/WuibL3W4RDLhYadmqYi/lSXlrk/dDiHfP0puVhRaW3XywftsbUksDN
         Wsgg==
X-Gm-Message-State: AOAM532Maqjqcejn4zEvloOh6R/pCgyVkFtQFhtuUEZfaIzLl9lNHrKW
        oxKKi/QbrkB1UaM0SLPg3RiNBw==
X-Google-Smtp-Source: ABdhPJwtBIUdA1p+Ktu1cWhF7xpUYRoQd2G/kpx1lZYPa72QSunJ0F9p0UsLXj2jqK45VkD4M5qrZw==
X-Received: by 2002:a05:6000:11c1:: with SMTP id i1mr4613985wrx.16.1608297701780;
        Fri, 18 Dec 2020 05:21:41 -0800 (PST)
Received: from dell ([91.110.221.216])
        by smtp.gmail.com with ESMTPSA id c190sm11393200wme.19.2020.12.18.05.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 05:21:41 -0800 (PST)
Date:   Fri, 18 Dec 2020 13:21:39 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 3/7] mfd: Add MFD driver for ATC260x PMICs
Message-ID: <20201218132139.GR207743@dell>
References: <cover.1607216141.git.cristian.ciocaltea@gmail.com>
 <f538c21de556c66390614bad778f7dc095222e8c.1607216141.git.cristian.ciocaltea@gmail.com>
 <20201216101000.GD207743@dell>
 <20201217231731.GA104305@BV030612LT>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201217231731.GA104305@BV030612LT>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 18 Dec 2020, Cristian Ciocaltea wrote:

> Hi Lee,
> 
> Thank you for the detailed review!
> 
> I will prepare a new revision, but there are still a couple of open
> points..

Could you please snip your replies, leaving only the open points.

Scrolling through lots of empty quotes or "done" comments is quite
time consuming.  Thanks.

[...]

> > > +	/*
> > > +	 * Using regmap within an atomic context (e.g. accessing a PMIC when
> > > +	 * powering system down) is normally allowed only if the regmap type
> > > +	 * is MMIO and the regcache type is either REGCACHE_NONE or
> > > +	 * REGCACHE_FLAT. For slow buses like I2C and SPI, the regmap is
> > > +	 * internally protected by a mutex which is acquired non-atomically.
> > > +	 *
> > > +	 * Let's improve this by using a customized locking scheme inspired
> > > +	 * from I2C atomic transfer. See i2c_in_atomic_xfer_mode() for a
> > > +	 * starting point.
> > > +	 */
> > > +	if (system_state > SYSTEM_RUNNING && irqs_disabled())
> > 
> > Were does system_state come from?
> 
> It is declared in 'include/linux/kernel.h':
> 
> extern enum system_states {
> 	SYSTEM_BOOTING,
> 	SYSTEM_SCHEDULING,
> 	SYSTEM_RUNNING,
> 	SYSTEM_HALT,
> 	SYSTEM_POWER_OFF,
> 	SYSTEM_RESTART,
> 	SYSTEM_SUSPEND,
> } system_state;
> 
> The definition is in 'init/main.c':
> 
> enum system_states system_state __read_mostly;
> EXPORT_SYMBOL(system_state);

Ah, it's a system wide thing.  No problem.

[...]

> > > +	ret = regmap_read(atc260x->regmap, atc260x->rev_reg, &chip_rev);
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to get chip revision\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	if (chip_rev < 0 || chip_rev > 31) {
> > > +		dev_err(dev, "Unknown chip revision: %d\n", ret);
> > > +		return -EINVAL;
> > > +	}
> > 
> > This still seems limiting.
> 
> This is based on the vendor implementation. Unfortunately I don't have
> access to a data sheet or any other source of information about the
> management of the chip revisions.

So which versions does this driver work with?  All 32?

[...]

> > > +const struct of_device_id atc260x_i2c_of_match[] = {
> > > +	{ .compatible = "actions,atc2603c", .data = (void *)ATC2603C },
> > > +	{ .compatible = "actions,atc2609a", .data = (void *)ATC2609A },
> > > +	{ /* sentinel */ }
> > 
> > I think you can drop the (void *) casts.
> 
> Without the cast, I get the following compiler warning:
> 
> drivers/mfd/atc260x-i2c.c:46:46: warning: initialization of ‘const void *’
> from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
>   { .compatible = "actions,atc2603c", .data = ATC2603C },

Perhaps I'm getting confused with addresses of things.  Never mind.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
