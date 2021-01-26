Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A56303A03
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jan 2021 11:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391897AbhAZKRs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jan 2021 05:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391676AbhAZKQW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jan 2021 05:16:22 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042A0C061573;
        Tue, 26 Jan 2021 02:15:42 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id b21so19042193edy.6;
        Tue, 26 Jan 2021 02:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/rct3g+soQkZfk4LEwZexkLFSPahpYR/2YSKQ5JilcY=;
        b=pzIvfmjkT8KVjUuO0izY/r1FVdyMrORT5Z1F8W9NRLH+n4u2t4OZiUj7y1hQsBOQya
         Szy1e+Rv+WzRWD+c4ebD8n+s4gaITnsfJv3woXVKSYZWYZxeie4aBY7U6/b8Xwl0zRTR
         eHZE8OxOmFFJC4n740aYtRue57KYhdFVvfJyPKvRuQRuO/e0PZkHBbpzKLFwUGbzFaYT
         4skZU0F+MI9j5ComzDmcdVEqveQUbSNpX4nDJhJ9UAGHE/KBipYxTL9d4V/TIT89wpmP
         wBpd6sucjsTVFnK/m3GoUqgFvB1FiXauvo3Hff2cB00wYuNc6AXTY7rPHSxVmHTyaU/A
         Wy2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/rct3g+soQkZfk4LEwZexkLFSPahpYR/2YSKQ5JilcY=;
        b=IGVr98UqZE6V7yd0cGN/x1AEvtmH9QQWjCTq9RATumNU+9LFJTXdLqBRBVdZD1dIIV
         dNuVIqQX2HzwCogjIZou4jXpaVQ/CSKytY0vOkZNoxK2a8hns0fP9PXkWX+BlrsPRsHd
         glg1jQLsmImHlIsnhZzociGGhFkXtUCZeqT24MNdMDw501bxHQxDq5X005DBMQcO93x1
         Xe7jX9EmqwJcomPIbNLD2ppCAsPrR3DawsoQzAkdn/8wzrzvICKBR0UVMqLVO0keBA2G
         A1yWAINtH2JBHrZAZLsI+GKow2FZ+ikXN/sJ8wjCqahvJDiJWcz1A8tnn+CttYeCOmR0
         qg0Q==
X-Gm-Message-State: AOAM532fkuBjaqAk258pEv1DFmKT3u2nXnDgmSc4ZjoY4nsm3uZuyMws
        YYl1fe3q5zUM4CjqpHb3yyY=
X-Google-Smtp-Source: ABdhPJzXiP/L6TlYulI6WQYvMi/C3+rPzj3ZcqLihXWoiJ7jInOnxySpjFmOkMqjeDts0pMV3hQclg==
X-Received: by 2002:a05:6402:1655:: with SMTP id s21mr3861428edx.360.1611656140787;
        Tue, 26 Jan 2021 02:15:40 -0800 (PST)
Received: from BV030612LT ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id br6sm7707782ejb.46.2021.01.26.02.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 02:15:40 -0800 (PST)
Date:   Tue, 26 Jan 2021 12:15:37 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 3/7] mfd: Add MFD driver for ATC260x PMICs
Message-ID: <20210126101537.GA1112736@BV030612LT>
References: <cover.1611165200.git.cristian.ciocaltea@gmail.com>
 <4bc76f9e3dc7204d7f407af6ee61c9f193a789d3.1611165200.git.cristian.ciocaltea@gmail.com>
 <20210125142558.GA4903@dell>
 <20210125184715.GA1061394@BV030612LT>
 <20210126081535.GB4903@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210126081535.GB4903@dell>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 26, 2021 at 08:15:35AM +0000, Lee Jones wrote:
> On Mon, 25 Jan 2021, Cristian Ciocaltea wrote:
> 
> > Hi Lee,
> > 
> > On Mon, Jan 25, 2021 at 02:25:58PM +0000, Lee Jones wrote:
> > > On Wed, 20 Jan 2021, Cristian Ciocaltea wrote:
> > > 
> > > > Add initial support for the Actions Semi ATC260x PMICs which integrates
> > > > Audio Codec, Power management, Clock generation and GPIO controller
> > > > blocks.
> > > > 
> > > > For the moment this driver only supports Regulator, Poweroff and Onkey
> > > > functionalities for the ATC2603C and ATC2609A chip variants.
> >  
> > [...]
> > 
> > > > +static void regmap_lock_mutex(void *__mutex)
> > > > +{
> > > > +	struct mutex *mutex = __mutex;
> > > > +
> > > > +	/*
> > > > +	 * Using regmap within an atomic context (e.g. accessing a PMIC when
> > > > +	 * powering system down) is normally allowed only if the regmap type
> > > > +	 * is MMIO and the regcache type is either REGCACHE_NONE or
> > > > +	 * REGCACHE_FLAT. For slow buses like I2C and SPI, the regmap is
> > > > +	 * internally protected by a mutex which is acquired non-atomically.
> > > > +	 *
> > > > +	 * Let's improve this by using a customized locking scheme inspired
> > > > +	 * from I2C atomic transfer. See i2c_in_atomic_xfer_mode() for a
> > > > +	 * starting point.
> > > > +	 */
> > > > +	if (system_state > SYSTEM_RUNNING && irqs_disabled())
> > > > +		mutex_trylock(mutex);
> > > > +	else
> > > > +		mutex_lock(mutex);
> > > > +}
> > > 
> > > Would this be useful to anyone else?
> > 
> > If you refer to the locking scheme, it is currently required by the
> > power-off driver to handle atomic contexts.
> 
> Right, but would this be helpful to any non-Actions drivers?
> 
> If so, perhaps it should reside as a Regmap helper?

I got it now, thanks for the suggestion. As a matter of fact this was
my initial intention, but since I was not aware of any other use case
I decided to keep it private for the moment.

Most probably this hardware design is not specific to Actions only, so
it might be helpful to other drivers as well. Therefore I am going to
reconsider this and if/when it is accepted upstream, I will come back
with a separate update patch for this driver.

> > > For my own reference (apply this as-is to your sign-off block):
> > 
> > Please note the patches "[4/7] regulator: ..." and "[5/7] power: ..."
> > have been already picked up by Mark and Sebastian, respectively, while
> > Dmitry suggested to merge "[6/7] input: ..." through MFD.
> 
> That's fine.
> 
> Please re-submit the patches which have not been applied already.

I have just submitted v7 with the two patches dropped.

> > >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > > 
> > 
> > Thanks,
> > Cristi
> 
> -- 
> Lee Jones [李琼斯]
> Senior Technical Lead - Developer Services
> Linaro.org │ Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
