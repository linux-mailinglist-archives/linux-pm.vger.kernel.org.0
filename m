Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9643BF9CC
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2019 21:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfIZTII (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Sep 2019 15:08:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38092 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfIZTIH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Sep 2019 15:08:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id x10so2057785pgi.5
        for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2019 12:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=F73+uceeMuwpCeg4MV5QzpHw3q82Pex8Nuzkj5F9opo=;
        b=jG3mOcORe7V8TStUeyIHOoco3/ZswveSY1cOOp7+I6U41pzEdJnFQwWJ98wBGIA2JH
         ysiJn7mqk0oWBxQ/cx9Ucobt9do5ZcSNfrPnJ8SxX2FJ3OTLpp65IYyr1yVF5s1zn5g1
         y47d+NB/p0veHoUaA/rMoR7KUvOVtyee6EJUU0sm3hwXuBRVVFS8Z4QnY9/NNrsw5js9
         557vui3D5YVUp+54ISTnwmbrDt4XS18I/v/hSaT1mpHn3Sp2L4ZUhV/29wqn3bwaNI69
         A9cjhnRNxswTYp8QBLslLYsx6mHdnviP7NKfIu5cZlTlsiTa5yx+dQJ7UHqFj07JaEeO
         81MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=F73+uceeMuwpCeg4MV5QzpHw3q82Pex8Nuzkj5F9opo=;
        b=pk9tYMOn67e84AP0hRYXoXmp/MfwgPocYodTd/dgK9mpZCow/5RzlLNJYePggzhPRr
         dKz/JNL7W8V5qDjipqUJ97Zeh3ewEXYR0DfyQgsCF5LUaiXyymNKRHgxrFfUf+jXpOS7
         wBzVHiWTEbieyo4Dr5pTMvdyfI4EDe0ilS2pKpzT1UuiUxOnYHCQYwYPWliYFvcJUNFa
         FQiKZatooYVIrgISkrfa7j9/6NUw9WuWQyKQU7db7wHQ6hQaAtzZFDS9SXVPNmZoeK0C
         Cocz0fWVBW3Pj9c0subgPUvNZXaY1xmEGfeiCquToqiEXnV5Yhk3cC/cbA3xQi/TqAM0
         j/yQ==
X-Gm-Message-State: APjAAAXyArUokiiNIJrKpGDtOnuAHdephaLBoh8Na6HC/+GYz67E8oM1
        /J7RL0Q9OWv+2ok3aVL5AvwIjBRwph5nhA==
X-Google-Smtp-Source: APXvYqwcQ3nCA8Z13SSlrZG7RcPrMaxO33BCtRCxeOgnBoi95HRUlE0FcaBHLDCq4saFBcU8qbnZnQ==
X-Received: by 2002:aa7:8acf:: with SMTP id b15mr5312222pfd.191.1569524885043;
        Thu, 26 Sep 2019 12:08:05 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id k3sm3221570pgl.9.2019.09.26.12.08.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Sep 2019 12:08:04 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@kernel.org>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] soc: amlogic: ee-pwrc: ensure driver state maches HW state
In-Reply-To: <8936e777-8996-5c7b-ea9d-8e17c8d6c4b1@baylibre.com>
References: <20190925213528.21515-1-khilman@kernel.org> <20190925213528.21515-3-khilman@kernel.org> <8936e777-8996-5c7b-ea9d-8e17c8d6c4b1@baylibre.com>
Date:   Thu, 26 Sep 2019 12:08:01 -0700
Message-ID: <7hwodulvu6.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 25/09/2019 23:35, Kevin Hilman wrote:
>> From: Kevin Hilman <khilman@baylibre.com>
>> 
>> During init, ensure that the driver on/off state as well as clock and
>> reset state matches the hardware state.  Do this by always calling the
>> drivers 'on' function, and then callling the 'off' function if the
>> HW state was initially detected as off.

[...]

> I don't see what you are trying to solve except simplifying the code.

Simplifying the code is a worthwhile goal on its own, but that's not the
only thing I'm tring to accomplish.

Part of the goal is make the init less VPU specific and thus make it
more understandable/maintainable.  But the more important part is to
ensure that the driver state and HW state is consistent for all the
domains (not just VPU.)  I've had to debug lots of power-domain issues,
and inconsistiences between HW state and driver state tend to be the
primary cause of problems.

Also I'm generally not a fan of the "don't mess with bootloader state"
approach as that leads to subtle dependencies on specific bootloader
versions that are also difficult to debug.

Antother equally important goal is to actually be able to power-down the
VPU when it's not used.  Right now, we'll never power off the VPU if the
bootloader enabled it, and that seems a bit extreme so I'm looking to
improve that and be able to power off the VPU when not used.

> And the case is more that "matching the clock state" here, the
> pm_domain_always_on_gov was is a real case when booting from the Amlogic
> U-boot.

I'm not understanding what you mean about vendor uboot.  I've done
testing with vendor uboot too:

I tried on g12a-u200, g12a-x96-max, and sm1-khadas-vim3l all of which
have vendor uboot, and I tried before and after $SUBJECT patch.

In all cases, I see the vendor uboot splash screen, and I see the
framebuffer console from linux after kernel boot.  I see the same
behavior before and after my patch.

I also tried on g12b-odroid-n2 (vendor uboot), and there is _no_ uboot
spash screen, but I see the linux framebuffer console come up both
before and after my patch.

What's the specific case you're worried about with vendor uboot?

Also...  note something interesting I noticed on sm1-khadas-vim3l:
before my patch, the framebuffer console appears, but the background is
a bluish/green color.  After my patch, the background is black (as
expected.)  

> The display power domain is complex and as been half solved by using
> "simple-framebuffer" on gx and is missing on g12a/g12b/sm1.
>
> For example, Debian installer runs without the modules, but will use
> the EFIfb set by U-Boot, but in this precise case :
> - the DRM driver isn't loaded
> - we can't hook this power domain with EFIfb

OK, so I agree that this case where we want the display to continue to
work but linux DRM drivers never loaded is a special case.

Is there a way to check if efifb is enabled?  Is the the linux driver
(drivers/video/fbdev/efifb.c) or something else only done by uboot?

If we can detect efifb from the kernel (not just whether the domain is
already on), then a simple addition to my patch like this:

 	if (is_off)
 		meson_ee_pwrc_off(&dom->base);
+	else if (efifb_is_enabled)
+		dom->base.flags |= GENPD_FLAG_ALWAYS_ON;

would force the domain always-on in the case of efifb.  

In fact, now that I think of it, simply adding:

 	if (is_off)
 		meson_ee_pwrc_off(&dom->base);
+	else
+		dom->base.flags |= GENPD_FLAG_ALWAYS_ON;

to my current patch would get back to the same behavior of the existing
driver.  But I still don't like the idea that we can *never* power off
the VPU if the bootloader enables it. :( I'd rather see patches
conditionally adding that flag with detailed explanations as to why it's
needed.

> When *not* in EFIfb, we use simple-framebuffer on GX, using this
> power domain, but it hasn't been copied to G12A.

I don't quite understand what problem simple-framebuffer is
solving. Could you explain that in more detail.

Assuming it is solving something, why can't it be used on g12[ab]/sm1 ?

> Personally I'll leave this code until we really tested and checked all
> uses cases, 

Right, I don't want to break anything on purpose, but I think the
current state of this driver is fragile and difficult to
understand/maintain, so I would be grateful for any help in
understanding the corner cases better, as well as testing them (or
explaining to me how to reproduce them.)

Generally, with long-term maintenance in mind, if I'm forced to choose
between understandable/maintainable code and "covers 100% of corner
cases" I will most often chose the former.

> not only on the sei510/sei610 using mainline u-boot.

See above about all the other boards with vendor uboots also tested.

Kevin
