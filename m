Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9552304836
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jan 2021 20:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbhAZFsZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jan 2021 00:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730610AbhAYSsA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jan 2021 13:48:00 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFB7C0613D6;
        Mon, 25 Jan 2021 10:47:19 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id g1so16761332edu.4;
        Mon, 25 Jan 2021 10:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nDehBXC5CPnwPawQZMlRv9xTC6ikQPcXUSWi8mtNNCM=;
        b=bFCjrLXgHhYQFWM05dJfAnHtfh9k/ZIWNa+ZXxtNtEcHRgf2YRrSHPidxK2p3hzpjK
         jPgGX/IhNMA4EG1zXRnXlC644Ah2yojB3EZrVisNuCyjrel4cSWWLUw8WQ6PfhIXE+RY
         wm+T0/u/d3kA2jT9taZ2oq1HDMmBEgwmPvgSbxs7+UHz6TrX5xZzhUExGS4rSB2JlYIe
         3YT/1PpKMeuLi7uoWoYE2ofK2w1Ebo/QxKsfjZ8hrYtTrFhnDvZZg2DBEjAJlcPUCAz8
         taLFzpa3PD3RiXa9jOdjEU1SzXFmI2IEHqkjvq6W53zQs+00uyF5mwIox2pza2EyJs3Q
         iwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nDehBXC5CPnwPawQZMlRv9xTC6ikQPcXUSWi8mtNNCM=;
        b=FX1MiI4QpIX8UOqEsYUeJK09F1QrCQmSQz28jaZk1jVhvkc+z2+bRYOsoc67fq9Amg
         W46dNjKQDa/Mfz2uZtq04xPtfuPn+Y+z6s13c5delRlvVcFwHxnDo6yxvZTRXYYJUrHn
         hejx+QpXxmwL8SdA/JdJN0ZEZH4+v7gHcIMPmmn7Vrj/3ZBoJRc2RCPexH0wrkKkx8+a
         vKMI74L8loUxW+YTKnBy14ZDn49gBbXfoWhX0TokYxR0IGoMMmapMXwhDZA6AeVzUDPv
         cJSW/D+nYC6WA4S9qIWTf4ot8AKzzjph3maOtEJ33d69gJIZ0GcL1QvDfwE+KSs6Prui
         3AUw==
X-Gm-Message-State: AOAM532SbhMA7MQoDKe6vW578nMtqTr00qHEMm4bghEMzpN8f+VtRoXK
        qZgm1Z+eyRjcffImGHqr2MMmXWctlCw=
X-Google-Smtp-Source: ABdhPJy3nYjnWIw/wvYkqBmyMQLIZ/bguKH8rV+PJA7vyKO58ToviMoMPnwQCxTouI22RmDwtQ60TA==
X-Received: by 2002:a05:6402:1152:: with SMTP id g18mr1698932edw.18.1611600438569;
        Mon, 25 Jan 2021 10:47:18 -0800 (PST)
Received: from BV030612LT ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id x2sm9652071eds.51.2021.01.25.10.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 10:47:17 -0800 (PST)
Date:   Mon, 25 Jan 2021 20:47:15 +0200
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
Message-ID: <20210125184715.GA1061394@BV030612LT>
References: <cover.1611165200.git.cristian.ciocaltea@gmail.com>
 <4bc76f9e3dc7204d7f407af6ee61c9f193a789d3.1611165200.git.cristian.ciocaltea@gmail.com>
 <20210125142558.GA4903@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210125142558.GA4903@dell>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lee,

On Mon, Jan 25, 2021 at 02:25:58PM +0000, Lee Jones wrote:
> On Wed, 20 Jan 2021, Cristian Ciocaltea wrote:
> 
> > Add initial support for the Actions Semi ATC260x PMICs which integrates
> > Audio Codec, Power management, Clock generation and GPIO controller
> > blocks.
> > 
> > For the moment this driver only supports Regulator, Poweroff and Onkey
> > functionalities for the ATC2603C and ATC2609A chip variants.
 
[...]

> > +static void regmap_lock_mutex(void *__mutex)
> > +{
> > +	struct mutex *mutex = __mutex;
> > +
> > +	/*
> > +	 * Using regmap within an atomic context (e.g. accessing a PMIC when
> > +	 * powering system down) is normally allowed only if the regmap type
> > +	 * is MMIO and the regcache type is either REGCACHE_NONE or
> > +	 * REGCACHE_FLAT. For slow buses like I2C and SPI, the regmap is
> > +	 * internally protected by a mutex which is acquired non-atomically.
> > +	 *
> > +	 * Let's improve this by using a customized locking scheme inspired
> > +	 * from I2C atomic transfer. See i2c_in_atomic_xfer_mode() for a
> > +	 * starting point.
> > +	 */
> > +	if (system_state > SYSTEM_RUNNING && irqs_disabled())
> > +		mutex_trylock(mutex);
> > +	else
> > +		mutex_lock(mutex);
> > +}
> 
> Would this be useful to anyone else?

If you refer to the locking scheme, it is currently required by the
power-off driver to handle atomic contexts.

> For my own reference (apply this as-is to your sign-off block):

Please note the patches "[4/7] regulator: ..." and "[5/7] power: ..."
have been already picked up by Mark and Sebastian, respectively, while
Dmitry suggested to merge "[6/7] input: ..." through MFD.

>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
> -- 
> Lee Jones [李琼斯]
> Senior Technical Lead - Developer Services
> Linaro.org │ Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog

Thanks,
Cristi
