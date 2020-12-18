Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B200C2DE73A
	for <lists+linux-pm@lfdr.de>; Fri, 18 Dec 2020 17:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgLRQH4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Dec 2020 11:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgLRQHz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Dec 2020 11:07:55 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C08C0617A7;
        Fri, 18 Dec 2020 08:07:15 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id h16so2870838edt.7;
        Fri, 18 Dec 2020 08:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wzkg9HGLizXQ+9HDpc1WbATbetIVR7/Fro/Ux3+6OgA=;
        b=RZn5K7ghqFrFRHAWNUJrDX3DnMDr2eZAQTEYqdPyiYe5bfli3vb5zMCkLGeNkjmAmz
         b8Jz1OUrK40kkrdce6s4ykBvygXyHSf4R2OGCiYnYotxMX8mSDRxuuiaVUM8bfRuFj9d
         RuBOqDSo9Z03rPJ5kOaMYMtfu73/y8mpnqHB6U26ULA4rbKueLrzjrHsnWQxHtf0o6pZ
         2n+W6D354TDPljCSkIKol7JrTXIO1rewtq/NrwP0yT+ijfcvg7yPwotas1W0/REgWK6v
         t47xv7iqpkPpDtFRIPzAa9MDViMtp51nmgPI87QRG9P1OpfrjUq+0y+kjM1zepVslDmo
         FyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wzkg9HGLizXQ+9HDpc1WbATbetIVR7/Fro/Ux3+6OgA=;
        b=uQNOHWblnCHeByYujCwkeExnxbcW4+Gpqdcmxb1n7eYGMwlDhJZXpaVDY1aVo0OMwo
         t5IlME4x3Av/E1+1X68ZtRbrUxgLNy50q33FWdLW+z6ZEAbN7fi42DU0hXcGxsLt/yo0
         IF/HwZSPpbO3aVxK6VCYpPA1mfrBe4Tpm6bGZhEkip5XHPZiqignQBcB8+QANS3LYafY
         YwirGHk+CdHwcdYRd3UvV1ey9v47zEmyYiMCS5sdOswF9JKW4grqARg6i/pORXVlaE4w
         O6b8AmVn1IRizs06KLvJZ82wnKgozdc5WW6bmTV1/CYof+o+/ntVto5az5Y0f54X+BJo
         JFxQ==
X-Gm-Message-State: AOAM531CMluFXrCau4N+I6+p6RevFZpdrKXOnPIEwqjTYMSZta/HoJ2G
        1nG3E3rFX5GrrSqLK03hWec=
X-Google-Smtp-Source: ABdhPJxvDwAoAVnPk2gGAa5lSa6k9PViJHSSVYv10/jkGSPcg1UXin24sgPKCxZMHjdbU8zNjmkxag==
X-Received: by 2002:aa7:df91:: with SMTP id b17mr5134614edy.272.1608307634082;
        Fri, 18 Dec 2020 08:07:14 -0800 (PST)
Received: from BV030612LT ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id f17sm11561803edu.25.2020.12.18.08.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 08:07:12 -0800 (PST)
Date:   Fri, 18 Dec 2020 18:07:10 +0200
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
Message-ID: <20201218160710.GA134686@BV030612LT>
References: <cover.1607216141.git.cristian.ciocaltea@gmail.com>
 <f538c21de556c66390614bad778f7dc095222e8c.1607216141.git.cristian.ciocaltea@gmail.com>
 <20201216101000.GD207743@dell>
 <20201217231731.GA104305@BV030612LT>
 <20201218132139.GR207743@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201218132139.GR207743@dell>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Dec 18, 2020 at 01:21:39PM +0000, Lee Jones wrote:
> On Fri, 18 Dec 2020, Cristian Ciocaltea wrote:
> 
> > Hi Lee,
> > 
> > Thank you for the detailed review!
> > 
> > I will prepare a new revision, but there are still a couple of open
> > points..
> 
> Could you please snip your replies, leaving only the open points.
> 
> Scrolling through lots of empty quotes or "done" comments is quite
> time consuming.  Thanks.

Sure, I'll take that into account.

> [...]
> 
> > > > +	ret = regmap_read(atc260x->regmap, atc260x->rev_reg, &chip_rev);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Failed to get chip revision\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	if (chip_rev < 0 || chip_rev > 31) {
> > > > +		dev_err(dev, "Unknown chip revision: %d\n", ret);
> > > > +		return -EINVAL;
> > > > +	}
> > > 
> > > This still seems limiting.
> > 
> > This is based on the vendor implementation. Unfortunately I don't have
> > access to a data sheet or any other source of information about the
> > management of the chip revisions.
> 
> So which versions does this driver work with?  All 32?

I'm not even sure there are so many revisions, I guess that's just a
rough validation for a vendor reserved range.

For the moment, the only place where the functionality is affected
by the chip revision is in the regulator driver - there is a special
handling for the ATC2603C rev.B chip variant.

I expect some additional handling might be required for new drivers
bringing support for the other functions provided by the hardware.

> [...]

Thanks,
Cristi
