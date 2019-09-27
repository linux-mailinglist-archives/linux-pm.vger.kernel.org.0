Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A68A8C0914
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2019 18:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfI0QCS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Sep 2019 12:02:18 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45574 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbfI0QCR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Sep 2019 12:02:17 -0400
Received: by mail-pl1-f194.google.com with SMTP id u12so1265288pls.12
        for <linux-pm@vger.kernel.org>; Fri, 27 Sep 2019 09:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=29a3oTunOouDFzxMtIrWBXRyyY3LWhUwRCrePjAx2qE=;
        b=hjOW3C4SuSB7unJjx+5yJqjFuAldtauxybxk3cFSxQaAi/4e2KMQ5NI0EB1NNtU0qH
         cGdKRs/ubtIEtWKlpW1ocUVwjIJRmYWOzzUhbRyKQdXU+6wQ0TgkJr1gw+EqD3zHXdH0
         n8Yh8s/nV0q88MN/8eTOSlrHBN54E60xXDlIqi4XS+0r5whpKFVIm5W9GzB2TGCXXsYg
         Abgl4pZGte7BQ2QkOSc8lgsBxcO2JERK0RIAkorcmy6y1T/xwnUUewm+J//PZ6Y1bx49
         Pk9N2zMO6R7zVsUrJt/SJrV5GvSOETzFSEI+ZDMZoK53UcVEfDZhyWiJXRy2e4Q1QuJk
         NOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=29a3oTunOouDFzxMtIrWBXRyyY3LWhUwRCrePjAx2qE=;
        b=lv8N4cTjbOo+SKqQlBfkqCzXnF9ByqU38LjDkJpzaVzYk4SQH6CgDQBwp1x7yantSp
         Ju3krgyG3tsBke5yYTXDEjS2MQvitJL8NzrCiTqvbftfo9LFeX8t8mO/XYTseIaz7YV1
         3akefVlstZtmdoETydZBcSQ0pZXbKB4+Mwp/N8zXutTW/d8UlhBvhEl9LS7IDUAR5JXG
         pYoQRLfkJ8kEf0zS3A+Fuxdz81h47lwmsDDIL1SrFtCymG9OhLGJPyR/V7pS7QNy9ZTQ
         qSy+EhTEKLjAwV5gaI2wgIo3ruibSHPGC4CFS4crcr9lDbdkW+OERPs3yOeWZcD9qsoz
         pE0A==
X-Gm-Message-State: APjAAAUBKPa1WYhKUF1p7FJmO5mhW4TrNwGfjXgH7oz+gA2GlGimc2DA
        K0oLX/XaE1xABp+wX80k1drm/g==
X-Google-Smtp-Source: APXvYqwb2qcrphZZtwIWMoEm1Jl9XAX4IezpkCTvrSf1SgdfEcRynzdCEgT5Z+6j0c7zO2GfixPHEw==
X-Received: by 2002:a17:902:9896:: with SMTP id s22mr5360521plp.207.1569600135203;
        Fri, 27 Sep 2019 09:02:15 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id 196sm3586887pfz.99.2019.09.27.09.02.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Sep 2019 09:02:14 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@kernel.org>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] soc: amlogic: ee-pwrc: ensure driver state maches HW state
In-Reply-To: <21eafa69-fe26-2df1-d187-cddfe5b37951@baylibre.com>
References: <20190925213528.21515-1-khilman@kernel.org> <20190925213528.21515-3-khilman@kernel.org> <8936e777-8996-5c7b-ea9d-8e17c8d6c4b1@baylibre.com> <7hwodulvu6.fsf@baylibre.com> <21eafa69-fe26-2df1-d187-cddfe5b37951@baylibre.com>
Date:   Fri, 27 Sep 2019 09:02:13 -0700
Message-ID: <7h1rw1iv7e.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 26/09/2019 21:08, Kevin Hilman wrote:
>> Neil Armstrong <narmstrong@baylibre.com> writes:
>> 
>>> On 25/09/2019 23:35, Kevin Hilman wrote:
>>>> From: Kevin Hilman <khilman@baylibre.com>
>>>>
>>>> During init, ensure that the driver on/off state as well as clock and
>>>> reset state matches the hardware state.  Do this by always calling the
>>>> drivers 'on' function, and then callling the 'off' function if the
>>>> HW state was initially detected as off.
>> 
>> [...]
>> 
>>> I don't see what you are trying to solve except simplifying the code.
>> 
>> Simplifying the code is a worthwhile goal on its own, but that's not the
>> only thing I'm tring to accomplish.
>
> I still find it ugly to power_on a domain to power it off right afterwards.
> The issue is with the CCF enable handling which is not in sync with the
> HW, if you boot with an already enabled clock, it won't be marked enabled
> in CCF, and it's clearly bad when you want to have a fine-tuned gate state
> handling.

It's not just the clocks.  The only thing we actually know is the HW
state of the sleep bit (because we read it.)  We don't know the state of
all the mem_pd bits or the iso_reg, nor do we know the state of the
reset lines.  Calling 'on' ensures everything is where we expect, and
we're not relying on the bootloader to do it.

>> Part of the goal is make the init less VPU specific and thus make it
>> more understandable/maintainable.  But the more important part is to
>> ensure that the driver state and HW state is consistent for all the
>> domains (not just VPU.)  I've had to debug lots of power-domain issues,
>> and inconsistiences between HW state and driver state tend to be the
>> primary cause of problems.
>> 
>> Also I'm generally not a fan of the "don't mess with bootloader state"
>> approach as that leads to subtle dependencies on specific bootloader
>> versions that are also difficult to debug.
>> 
>> Antother equally important goal is to actually be able to power-down the
>> VPU when it's not used.  Right now, we'll never power off the VPU if the
>> bootloader enabled it, and that seems a bit extreme so I'm looking to
>> improve that and be able to power off the VPU when not used.
>> 
>>> And the case is more that "matching the clock state" here, the
>>> pm_domain_always_on_gov was is a real case when booting from the Amlogic
>>> U-boot.
>> 
>> I'm not understanding what you mean about vendor uboot.  I've done
>> testing with vendor uboot too:
>> 
>> I tried on g12a-u200, g12a-x96-max, and sm1-khadas-vim3l all of which
>> have vendor uboot, and I tried before and after $SUBJECT patch.
>> 
>> In all cases, I see the vendor uboot splash screen, and I see the
>> framebuffer console from linux after kernel boot.  I see the same
>> behavior before and after my patch.
>> 
>> I also tried on g12b-odroid-n2 (vendor uboot), and there is _no_ uboot
>> spash screen, but I see the linux framebuffer console come up both
>> before and after my patch.
>
> Thanks for testing all these cases
>
>> 
>> What's the specific case you're worried about with vendor uboot?
>
> It's an issue I got when bringing up mainline uboot and the vpu power controller
> driver, I had regressions on GXBB and GXL boards.
> But it seems it's no more the case on G12A/G12B, we'll see this when
> GX support will be added in this driver.
>
>> Also...  note something interesting I noticed on sm1-khadas-vim3l:
>> before my patch, the framebuffer console appears, but the background is
>> a bluish/green color.  After my patch, the background is black (as
>> expected.)  
>
> Yes it's an issue I have on my infinite todo list, it's a different
> init done by the latest vendor uboot. I have a fix but it seems it
> breaks display when booting other boards.
>
>> 
>>> The display power domain is complex and as been half solved by using
>>> "simple-framebuffer" on gx and is missing on g12a/g12b/sm1.
>>>
>>> For example, Debian installer runs without the modules, but will use
>>> the EFIfb set by U-Boot, but in this precise case :
>>> - the DRM driver isn't loaded
>>> - we can't hook this power domain with EFIfb
>> 
>> OK, so I agree that this case where we want the display to continue to
>> work but linux DRM drivers never loaded is a special case.
>> 
>> Is there a way to check if efifb is enabled?  Is the the linux driver
>> (drivers/video/fbdev/efifb.c) or something else only done by uboot?
>> 
>> If we can detect efifb from the kernel (not just whether the domain is
>> already on), then a simple addition to my patch like this:
>> 
>>  	if (is_off)
>>  		meson_ee_pwrc_off(&dom->base);
>> +	else if (efifb_is_enabled)
>> +		dom->base.flags |= GENPD_FLAG_ALWAYS_ON;
>> 
>> would force the domain always-on in the case of efifb.  
>> 
>> In fact, now that I think of it, simply adding:
>> 
>>  	if (is_off)
>>  		meson_ee_pwrc_off(&dom->base);
>> +	else
>> +		dom->base.flags |= GENPD_FLAG_ALWAYS_ON;
>> 
>> to my current patch would get back to the same behavior of the existing
>> driver.  But I still don't like the idea that we can *never* power off
>> the VPU if the bootloader enables it. :( I'd rather see patches
>> conditionally adding that flag with detailed explanations as to why it's
>> needed.
>> 
>>> When *not* in EFIfb, we use simple-framebuffer on GX, using this
>>> power domain, but it hasn't been copied to G12A.
>> 
>> I don't quite understand what problem simple-framebuffer is
>> solving. Could you explain that in more detail.
>
> simple-framebuffer has the power domain hooked in it's node, so
> when u-boot will boot linux with HDMI enabled it will enable
> this node and until the DRM driver loads the simple-framebuffer
> will live and keep the power domain enabled.

Ah, thanks for the explanation.  I didn't realize it was u-boot that was
adding/enabling the simplefb node in the DT.

>> 
>> Assuming it is solving something, why can't it be used on g12[ab]/sm1 ?
>
> It will, but I need to push the patches.
>

OK.

>>> Personally I'll leave this code until we really tested and checked all
>>> uses cases, 
>> 
>> Right, I don't want to break anything on purpose, but I think the
>> current state of this driver is fragile and difficult to
>> understand/maintain, so I would be grateful for any help in
>> understanding the corner cases better, as well as testing them (or
>> explaining to me how to reproduce them.)
>> 
>> Generally, with long-term maintenance in mind, if I'm forced to choose
>> between understandable/maintainable code and "covers 100% of corner
>> cases" I will most often chose the former.
>> 
>>> not only on the sei510/sei610 using mainline u-boot.
>> 
>> See above about all the other boards with vendor uboots also tested.
>
> Let's leave apart the vendor uboot issue for g12.
>
> Since display support for G12A will land soon in mainline U-boot, let me
> push the DT patches for simple-framebuffer to we have a fallback in
> case the DRM driver isn't loaded/built.
>
> We can consider that in case of EFIfb, the simple-framebuffer node would have
> been enabled and the power domain hooked and enabled.

OK, that makes sense to me.

So can I consider this an 'ack' from you for this patch, as long as I
wait to apply it until the simplefb DT patches are also merged?

Thanks,

Kevin
