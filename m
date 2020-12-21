Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D412DFBAB
	for <lists+linux-pm@lfdr.de>; Mon, 21 Dec 2020 12:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgLUL57 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Dec 2020 06:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgLUL56 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Dec 2020 06:57:58 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CECBC0613D3;
        Mon, 21 Dec 2020 03:57:18 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id i24so9301825edj.8;
        Mon, 21 Dec 2020 03:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=D1SdyTtuFBbZo+GeEb6UhFf7p1TbonbHMIxr8E0IyNM=;
        b=Ye5NLzGYUIqjKRdjny1Q712KjVU2opQXzHSiRK0d0idpVzvIMIaKmdUFJx2dJsvLa2
         TQjyUp+sJIpM9h77oxhfxXA6uhrYix7QwTlwIZRj8MtsAuz8nqWrYyewNRgH+JKp2yaS
         5WWYcGPBQYwOt1QU6yY8dvQTiQ1BWvsnKW2QqZG4Z9Oqkb+vlRCQHqmIXnmxYUKjWCDQ
         w83w7fAQj3xD7HtwKhXcky33oQdtsqoXrmVpDi6sBWsAZHK1UC54n1SWZflaTqRsK2Ve
         zcwm90p3hmnQv6g6MWm85M0MdOEX5NzlDn2ic8G9pjugHZO7y/zLydP9nBZsjZ7+6C8Z
         jfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=D1SdyTtuFBbZo+GeEb6UhFf7p1TbonbHMIxr8E0IyNM=;
        b=KcwmKC1g3CMHoqZPbbXQ4l00ZVdKwU4oESCBCF9PMUzs3zGTe7KgYh1fHoXLGIov1c
         MW9L3Nq3HAG+lWMluDXN5ScyM3HPOGuRgIGjx63Ify0mPXnkqvrNSOD29y6ve5DN2DJZ
         WArAbwj8EjIh9cKJ3gptgnp3aJbNk4VXtHhNfNJNgXlMFxmDFj/UNAFvCDarxK4R/Pis
         /rF1r5jp01LuvF0lbASdcST19QrT4WOGg7Xl9uqVIcO062LjoLT+gSduPY8rwqYFj9yK
         gG/eAddaNxUzKoQJMLdZ6sb3vcbwFp9h860K7lhOSV/xBs/odrsns81emFykp5Xq6qMo
         EV+w==
X-Gm-Message-State: AOAM530//jzVbwVvDfqxWhgj7vFxbfoj8o4zyF8eXY316v+R+uyF8DCE
        gC+QS0xY8xQxJj/pCskklIY=
X-Google-Smtp-Source: ABdhPJwWiV8YbhKsl5hEA2wObCWB8satrfPYQBdDBA6Gi5q/nAUN9anac1HYiv1kqBWvRSE/5uLFcQ==
X-Received: by 2002:a05:6402:8d9:: with SMTP id d25mr15396335edz.278.1608551836837;
        Mon, 21 Dec 2020 03:57:16 -0800 (PST)
Received: from BV030612LT ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id a20sm29110331edr.70.2020.12.21.03.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 03:57:16 -0800 (PST)
Date:   Mon, 21 Dec 2020 13:57:13 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
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
Message-ID: <20201221115713.GA155203@BV030612LT>
References: <cover.1607216141.git.cristian.ciocaltea@gmail.com>
 <f538c21de556c66390614bad778f7dc095222e8c.1607216141.git.cristian.ciocaltea@gmail.com>
 <20201216101000.GD207743@dell>
 <20201217231731.GA104305@BV030612LT>
 <20201218132139.GR207743@dell>
 <20201218160710.GA134686@BV030612LT>
 <20201221081015.GA4825@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201221081015.GA4825@dell>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 21, 2020 at 08:10:15AM +0000, Lee Jones wrote:
> On Fri, 18 Dec 2020, Cristian Ciocaltea wrote:
> 
> > On Fri, Dec 18, 2020 at 01:21:39PM +0000, Lee Jones wrote:
> > > On Fri, 18 Dec 2020, Cristian Ciocaltea wrote:
> > > 
> > > > Hi Lee,
> > > > 
> > > > Thank you for the detailed review!
> > > > 
> > > > I will prepare a new revision, but there are still a couple of open
> > > > points..
> > > 
> > > Could you please snip your replies, leaving only the open points.
> > > 
> > > Scrolling through lots of empty quotes or "done" comments is quite
> > > time consuming.  Thanks.
> > 
> > Sure, I'll take that into account.
> > 
> > > [...]
> > > 
> > > > > > +	ret = regmap_read(atc260x->regmap, atc260x->rev_reg, &chip_rev);
> > > > > > +	if (ret) {
> > > > > > +		dev_err(dev, "Failed to get chip revision\n");
> > > > > > +		return ret;
> > > > > > +	}
> > > > > > +
> > > > > > +	if (chip_rev < 0 || chip_rev > 31) {
> > > > > > +		dev_err(dev, "Unknown chip revision: %d\n", ret);
> > > > > > +		return -EINVAL;
> > > > > > +	}
> > > > > 
> > > > > This still seems limiting.
> > > > 
> > > > This is based on the vendor implementation. Unfortunately I don't have
> > > > access to a data sheet or any other source of information about the
> > > > management of the chip revisions.
> > > 
> > > So which versions does this driver work with?  All 32?
> > 
> > I'm not even sure there are so many revisions, I guess that's just a
> > rough validation for a vendor reserved range.
> > 
> > For the moment, the only place where the functionality is affected
> > by the chip revision is in the regulator driver - there is a special
> > handling for the ATC2603C rev.B chip variant.
> > 
> > I expect some additional handling might be required for new drivers
> > bringing support for the other functions provided by the hardware.
> 
> The current patch seems to insinuate that 32 versions are currently
> supported.  What is the chip_rev for the ATC2603C rev.B?

I only own the rev.A for the ATC2603C variant, for which I read '0' from
the chip rev register.

However what really matters for the driver is not the raw value, but the
one computed via:

atc260x->ic_ver = __ffs(chip_rev + 1U);

This is basically a translation of the raw value to a chip version
that is used in the context of the special handling mentioned above:

enum atc260x_ver {
	ATC260X_A = 0,
	ATC260X_B,
	ATC260X_C,
	ATC260X_D,
	ATC260X_E,
	ATC260X_F,
	ATC260X_G,
	ATC260X_H,
};

So we actually could handle up to 8 chip versions with the current
management scheme.

> -- 
> Lee Jones [李琼斯]
> Senior Technical Lead - Developer Services
> Linaro.org │ Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
