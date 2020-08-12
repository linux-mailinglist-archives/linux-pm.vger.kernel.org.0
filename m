Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1272242EDE
	for <lists+linux-pm@lfdr.de>; Wed, 12 Aug 2020 21:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgHLTC5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Aug 2020 15:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgHLTC5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2020 15:02:57 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C5EC061383;
        Wed, 12 Aug 2020 12:02:57 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id p14so2702647wmg.1;
        Wed, 12 Aug 2020 12:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HaL2zh/WXFrk38V3//tUJzJt7K7m3lYKmEzICUwPAfg=;
        b=MjJD+VCKfzYVsZgX5Dc+eN1Jv709nvN3ChxDOXcdlNW5r7rC9iK+eJmMaFx0Onw2UY
         ZocoTU0dKjKxesgsr6graGWP86U2rbCTdf2ZjexlPcvEyT6eXskm76SQGdJUgNzXRYyx
         s9zX6QdonMvB+vhc8voH/BKliyJjIeCSz79nZyONKCgJcYxfBX9aT7GYgIxFVcsCBe4r
         Gtu6dbWIa3oRrkNTcTX7DCXZFb26cORK8OGHjnZpNXAfK+Y9XHwNAdu4qKRIkwerFx/4
         UJWX5qxUVG2q5bgOSW/SErfjnXqgFel8xLY6+s9b2Xqvc6RtwPcNNi9tRGR3lXVOOmrA
         h1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HaL2zh/WXFrk38V3//tUJzJt7K7m3lYKmEzICUwPAfg=;
        b=hrb2uG21RsXvDaCSUKJtNRda1U0mb3zZkMVdpDYD2I32rtB5oJZtYTqO67Hqs5FtaU
         xwGH49u6coojSa2rOiLEeVG6XCerPdqLaAeOufztodAz6SERybzRLs9tRMpigjGAxfVn
         I7T5P/X4R+3gqMJA/WaYscWhvIlrzwTJjoRL2NHSuSE8cElDLBhVmALja82EKukCNOku
         w2U8KXsYL7HhwIQbvIhK07oBqpxQsBKxR+yAVBO1IL2tw6to7ujCN2gq4V1BoF4kAONu
         plsrWRu5SWqDDhA8xQWYNHlsgeKu6bYD3mgr57ruf9xxXEYnA03DC/JNzzA7lpPGP5xL
         Z7mA==
X-Gm-Message-State: AOAM533+hTUUj1nwDSCrHqE4AHX9h7hlKfwXISp3r50Dt1BsJ5ISPGQ1
        aauLG1iTtHv9bv41nfAZ8Yk=
X-Google-Smtp-Source: ABdhPJzzb6/HsEpBtXZ/ASVQAMBc+auMcspov6YM7337Yaba/ksfKQK45O0cu92Ka+BJx44VCiCQxA==
X-Received: by 2002:a05:600c:2116:: with SMTP id u22mr961700wml.35.1597258975940;
        Wed, 12 Aug 2020 12:02:55 -0700 (PDT)
Received: from lenovo-laptop (cpc83647-brig20-2-0-cust926.3-3.cable.virginm.net. [82.19.195.159])
        by smtp.gmail.com with ESMTPSA id z7sm4811299wmk.6.2020.08.12.12.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 12:02:55 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
X-Google-Original-From: Alex Dewar <alex.dewar@gmx.co.uk>
Date:   Wed, 12 Aug 2020 20:02:53 +0100
To:     David Lechner <david@lechnology.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Bartosz Go??aszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH] power: supply: Add dependency to lego-ev3-battery
 Kconfig options
Message-ID: <20200812190253.zewvdfvyu6cnggcl@lenovo-laptop>
References: <20200809185444.54247-1-alex.dewar90@gmail.com>
 <d6c98ee6-f2f3-c55a-be16-3794ccf30a28@lechnology.com>
 <20200812133711.ddwhxypmvr27pxdu@lenovo-laptop>
 <ce0ae241-10e1-de5c-e694-2c00dc01a2c4@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce0ae241-10e1-de5c-e694-2c00dc01a2c4@lechnology.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 12, 2020 at 10:24:30AM -0500, David Lechner wrote:
> On 8/12/20 8:37 AM, Alex Dewar wrote:
> > On Tue, Aug 11, 2020 at 09:24:10AM -0500, David Lechner wrote:
> > > On 8/9/20 1:54 PM, Alex Dewar wrote:
> > > > This battery appears only to be used by a single board (DA850), so it
> > > > makes sense to add this to the Kconfig file so that users don't build
> > > > the module unnecessarily. It currently seems to be built for the x86
> > > > Arch Linux kernel where it's probably not doing much good.
> > > 
> > > It would probably also make sense to add "default n" since it only
> > > applies to one board in the entire arch.
> > 
> > Ah ok. That makes sense. Would you like me to send a follow-on patch for
> > this?
> 
> You can just send a v2 patch that includes the change below and the
> additional change.

I've just had a look at the documentation[1] and it seems that as there's
no "default y" there it'll default to n anyway. Have I got that right?

[1] https://www.kernel.org/doc/html/latest/kbuild/kconfig-language.html#menu-attributes

> 
> > 
> > Alex
> > 
> > > 
> > > BATTERY_LEGO_EV3 is already explicitly set to "m" in the appropriate
> > > defconfig file, so I don't think it would break anything.
> > > 
> > > > 
> > > > Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> > > > ---
> > > >    drivers/power/supply/Kconfig | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> > > > index faf2830aa1527..9f76e2f47ac6d 100644
> > > > --- a/drivers/power/supply/Kconfig
> > > > +++ b/drivers/power/supply/Kconfig
> > > > @@ -164,7 +164,7 @@ config BATTERY_DS2782
> > > >    config BATTERY_LEGO_EV3
> > > >    	tristate "LEGO MINDSTORMS EV3 battery"
> > > > -	depends on OF && IIO && GPIOLIB
> > > > +	depends on OF && IIO && GPIOLIB && (ARCH_DAVINCI_DA850 || COMPILE_TEST)
> > > >    	help
> > > >    	  Say Y here to enable support for the LEGO MINDSTORMS EV3 battery.
> > > > 
> > > 
> 
