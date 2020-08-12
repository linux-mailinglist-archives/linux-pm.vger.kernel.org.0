Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B33E242A77
	for <lists+linux-pm@lfdr.de>; Wed, 12 Aug 2020 15:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgHLNhR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Aug 2020 09:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgHLNhQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2020 09:37:16 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36892C06174A;
        Wed, 12 Aug 2020 06:37:16 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c19so4255137wmd.1;
        Wed, 12 Aug 2020 06:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gh5RuQr9sYj2H72mRcnwrN7pTYUJOiAR4CgKD33yTxU=;
        b=fRHpEzIaHPb+uHpcOClFgHp5YAmQztzS0AM0IRMXTvBzbJ8EBXYXmIWSxAzcrhZeyE
         D9Xdy+B3J1FnVe4nkFhr6zCmaf/aII0E5MtLyH6v92N4ceCLuTFjWRH0EI82Ddee59hT
         QodHzZ5aG9Kh44j8hDeqKHODfuOG5xo1eAYi9fz2de79SO6vrsuqOwmY95fO9qRrGuRv
         ldoUNSskvFgrXKJpy8Gu25M74XJVfkK+CNtr7pYGbj6gxUvpietmNdtHkpzQhNHEJMbl
         Aw0Iv87yXAyaJntDCmrUOldgom8UwayFi2Eai5jo/H/4nd8rqnDYklJ5ARq0B4XThKG+
         Vyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gh5RuQr9sYj2H72mRcnwrN7pTYUJOiAR4CgKD33yTxU=;
        b=n+b6Ms+1BUetd1c/zMQ3WzH7DU4dPqJqmzDrRMzypTOmTBYAAmlNp7/KZ2CN1Pdpm4
         xeDd9HRv3OkARRmQgejBLt5jIRJKXuwO1t3mvu37jslMGQ3YgS4CWjkDYPKF7BkZcUUD
         SXFzIIk8uJcraoBQYIMSzLbQzVY35x5JdNVE1OxLQU4cnc2fmOeHNjLBsVvAgT6QnHO6
         pNFZoeuSZgYOoVPfMGoEP0BvsANSByl8C5CuGHErEbeLPF+XSRkTjsn/yt2TFiwmqaXX
         rWVGMZ3gjqaJUft70iPN/sV3kV09lz0J6ODZ2GzBRxajBydYq3VizhLYCJMIyB3CiSZl
         ylEQ==
X-Gm-Message-State: AOAM5302ufB5mAI0WNCU05v45bu6OhiPk71W2K4cNVg6UyEjBJ7vpGJ1
        A6UmtMDdp9MXD+KnkwRUpbE=
X-Google-Smtp-Source: ABdhPJzYtGxaLfbKeJp1ezPkfrNo5tdNToPDncdlPqvlHAIYEydkF4Cn9Tf2xhmA4Je5U91R2x+L9w==
X-Received: by 2002:a1c:9c91:: with SMTP id f139mr9084066wme.134.1597239434901;
        Wed, 12 Aug 2020 06:37:14 -0700 (PDT)
Received: from lenovo-laptop (cpc83647-brig20-2-0-cust926.3-3.cable.virginm.net. [82.19.195.159])
        by smtp.gmail.com with ESMTPSA id d21sm3937182wmd.41.2020.08.12.06.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 06:37:14 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
X-Google-Original-From: Alex Dewar <alex.dewar@gmx.co.uk>
Date:   Wed, 12 Aug 2020 14:37:11 +0100
To:     David Lechner <david@lechnology.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Bartosz Go??aszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH] power: supply: Add dependency to lego-ev3-battery
 Kconfig options
Message-ID: <20200812133711.ddwhxypmvr27pxdu@lenovo-laptop>
References: <20200809185444.54247-1-alex.dewar90@gmail.com>
 <d6c98ee6-f2f3-c55a-be16-3794ccf30a28@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6c98ee6-f2f3-c55a-be16-3794ccf30a28@lechnology.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 11, 2020 at 09:24:10AM -0500, David Lechner wrote:
> On 8/9/20 1:54 PM, Alex Dewar wrote:
> > This battery appears only to be used by a single board (DA850), so it
> > makes sense to add this to the Kconfig file so that users don't build
> > the module unnecessarily. It currently seems to be built for the x86
> > Arch Linux kernel where it's probably not doing much good.
> 
> It would probably also make sense to add "default n" since it only
> applies to one board in the entire arch.

Ah ok. That makes sense. Would you like me to send a follow-on patch for
this?

Alex

> 
> BATTERY_LEGO_EV3 is already explicitly set to "m" in the appropriate
> defconfig file, so I don't think it would break anything.
> 
> > 
> > Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> > ---
> >   drivers/power/supply/Kconfig | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> > index faf2830aa1527..9f76e2f47ac6d 100644
> > --- a/drivers/power/supply/Kconfig
> > +++ b/drivers/power/supply/Kconfig
> > @@ -164,7 +164,7 @@ config BATTERY_DS2782
> >   config BATTERY_LEGO_EV3
> >   	tristate "LEGO MINDSTORMS EV3 battery"
> > -	depends on OF && IIO && GPIOLIB
> > +	depends on OF && IIO && GPIOLIB && (ARCH_DAVINCI_DA850 || COMPILE_TEST)
> >   	help
> >   	  Say Y here to enable support for the LEGO MINDSTORMS EV3 battery.
> > 
> 
