Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32BBB3708E4
	for <lists+linux-pm@lfdr.de>; Sat,  1 May 2021 22:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhEAUUR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 May 2021 16:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhEAUUQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 May 2021 16:20:16 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF163C06174A;
        Sat,  1 May 2021 13:19:25 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id m12so2146590eja.2;
        Sat, 01 May 2021 13:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iwRbqfsuZgS63ZFgVOdcZE7Z3XT4rd2RRq4WcdnJBfk=;
        b=flJtQEkoMweFE7j9AjOHs1k4tMN+7xl51HhELMKL7JRf99bM8XMZrzdWTIqNWj1V2B
         8wiXVD/xDO6KObfcEVGZQ1jIm1vA099b9Ad2130hw1sAwZITrEcB+NV3vdlc+LzSiSB0
         eiV9XPuY7Q/h4HpvzOmgX1RpBPWe6IaguM4vT8tWuZcr74Kx5bn0FgdxexLH30BbsVIF
         UwKByRe7qv+DXlxhqBzihlxWPdw+F/ny1CMW0F0HSwrF7apqgp3HGzmuujxSgu3dI4jd
         y4fuMCJf6rtgNr73s/wzPKvA12ZaLLzm9uQ4nx9AioeXXOeVLA4nDuB+yY3uzfhWUEzH
         9dWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iwRbqfsuZgS63ZFgVOdcZE7Z3XT4rd2RRq4WcdnJBfk=;
        b=A43WXZRzaXvMsg+dYoWH0q4GZDkpOe7HC9LDmZJRI6pqwzFXxx2IS0p49P+4Rbzbp5
         8SeVwzFvJDelN7uqvXkrFUNT2v5aknstEO+J2EdKhPPO4P/l1cR1PJn2eBWLgVOrJY/S
         PCQ/wHoLp0/dMBysWCw+eYtREqFs8R3zPiLgN8m6eZWvZIG56CiHe8Ai/yQUEQvb0pJw
         NyHw61ze2k3OI3Ga9ZVQ/kkEZ36XkLTbGsGLH1WNNOeoCZ4c3G3kt0MzldqwOGHV/Dwc
         L5Ah0OocgHYcfQ3Fwbjz903msrFtp1O9g/B3YmH56e1qe1gMCVDbWyH5zykfhdDSXo3x
         9mLA==
X-Gm-Message-State: AOAM533EZU2YNUx7j7vkLkxQ1+SdbdVWr+nheBePf+PcnaHfs7tRCWjN
        yJy2R9Xk6IQKvrJeFO2cOuohGRi07Jl1oc4xGQY=
X-Google-Smtp-Source: ABdhPJw99VTLlaig2Q/0aFVgbswqt0kl75wjBBz/BJrxURBhkf3WEw96m3uc+tH0AgtJptSfzVjXVqTeHERqmWP8Qzk=
X-Received: by 2002:a17:906:85c1:: with SMTP id i1mr10240242ejy.216.1619900364422;
 Sat, 01 May 2021 13:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210429203723.1177082-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20210429203723.1177082-1-martin.blumenstingl@googlemail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 1 May 2021 22:19:13 +0200
Message-ID: <CAFBinCArYQ_fHL0f4Vv3rGfSB=cHx-d=JPc4GuoZLopAVuxb8g@mail.gmail.com>
Subject: Re: [PATCH RFC] soc: amlogic: meson-ee-pwrc: Drop the .shutdown
 callback from the driver
To:     Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 29, 2021 at 10:37 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Stefan reports that rebooting his ODROID-N2+ (using a G12B SoC) results
> in the board hanging. His kernel config uses:
>   CONFIG_MESON_EE_PM_DOMAINS=y
>   CONFIG_DRM_MESON=m
>
> He reports that his kernel config results in the DRM driver's .shutdown
> callback to be executed after the power domain driver's .shutdown
> callback. That's problematic because meson_ee_pwrc_shutdown disables the
> clock which are used by the VPU IP. This causes the board to hang.
>
> Further he reports that changing from CONFIG_DRM_MESON=m to
> CONFIG_DRM_MESON=y reverses the order in which the DRM and power domain
> driver's shutdown functions are executed, making the reboot successful.
>
> The reason why we use meson_ee_pwrc_shutdown is because of the VPU power
> domain (which is causing the problem described above). It can be left
> enabled by u-boot. According to the original TOFIX comment in
> meson_ee_pwrc_init_domain we need to be careful because disabling the
> power domain could "cause system errors". As a workaround the clocks
> are manually enabled in meson_ee_pwrc_init_domain and the power domain
> is marked as GENPD_FLAG_ALWAYS_ON (so it can never be turned off).
>
> Experimenting has shown that the power domain itself can be disabled as
> long as we keep the clocks enabled if u-boot enabled the power domain
> but we don't have any driver enabled for the VPU (CONFIG_DRM_MESON=n).
>
> Keeping the clocks enabled is the responsibility of the CCF drivers, not
> the power domain driver. Even better: this is already covered as all
> gates in the VPU and VAPB tree on GX an G12 SoCs have the
> CLK_IGNORE_UNUSED flag set, meaning: if the bootloader has previously
> enabled the clock we're not touching it until a driver explicitly asks
> to enable (and then disable) it. In case of CONFIG_DRM_MESON=n we're
> never calling meson_ee_pwrc_on, meaning that we always keep the state of
> the clocks as set by u-boot.
>
> The original TOFIX comment also mentioned that we need to make sure not
> to mess up the clock's prepare/enable ref-counters. This is the only
> requirement that's left for the meson-ee-pwrc driver that needs to be
> managed for the VPU power domain.
>
> Three steps can improve this situation:
> - Don't prepare and enable the clocks (just to fix the ref-counting) in
>   meson_ee_pwrc_init_domain if u-boot left that power domain enabled.
>   Instead, remember if the clocks are enabled in meson_ee_pwrc_{on,off}
>   and only disable them if we have previously turned them on ourselves.
> - Drop GENPD_FLAG_ALWAYS_ON as we can always manage the state of the VPU
>   power domain if both the power domain controller and DRM driver are
>   enabled (=m or =y). If the power domain driver is enabled but the DRM
>   driver is disabled we can still use meson_ee_pwrc_off because it's not
>   trying to disable the clocks anymore
> - Drop meson_ee_pwrc_shutdown as it's the responsibility of the genpd
>   framework to call meson_ee_pwrc_off when needed (either when a power
>   domain is being disabled - regardless of whether it's was used by a
>   driver before or not). Now there's also no more shutdown callback
>   ordering dependency between the power domain driver and other drivers
>   anymore.
>
> Fixes: eef3c2ba0a42a6 ("soc: amlogic: Add support for Everything-Else power domains controller")
> Reported-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
unfortunately I need to add:
Nacked-by: myself

it turns out that the genpd framework does not call .power_on when the
power domain is already powered on during initialization
(pm_genpd_init)

I wonder if we need to extend the genpd to handle this use-case.
CCF (common clock framework) for example has CLK_IGNORE_UNUSED and a
.disable_unused callback which can be used to specifically manage the
"unused" use-case

my idea #1:
- add a GENPD_FLAG_IGNORE_UNUSED flag
- set it for the VPU power domain
- skip "unused" power domains which have the GENPD_FLAG_IGNORE_UNUSED flag set
- drop the GENPD_FLAG_ALWAYS_ON flag from the VPU power domain

my idea #2:
- a power_off_unused callback (with the same arguments as power_off)
could be introduced
- in pm_genpd_init we check if that callback is initialized, if not we
assign the power_off callback
- instead of using the power_off callback when disabling an unused
power domain the new power_off_unused callback is used
- for the meson-ee-pwrc we implement a special meson_ee_pwrc_power_off
function that is a no-op


Best regards,
Martin
