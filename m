Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1FB3D8E66
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jul 2021 14:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbhG1M6I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Jul 2021 08:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbhG1M6H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jul 2021 08:58:07 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EEAC061757
        for <linux-pm@vger.kernel.org>; Wed, 28 Jul 2021 05:58:05 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id s48so3734596ybi.7
        for <linux-pm@vger.kernel.org>; Wed, 28 Jul 2021 05:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4bRUEOcKLm4DS4B/jW3feMkPgYheSCRlhCV3QPcIdfM=;
        b=r74xakMZ0GiSUxuVoyqO2APZWeaXmcbQVrXVDiOwVxqOXx9GehIwH9mGx4ycKOytQW
         HnGv1o7MAsiF5djl3nbNAK84t3xUkxmxrOJM4phlolM03We9YVytoRUiie5+/Ypy4woY
         4sE7Z6pQxSiPHIzdzOAM96SlrxLQT5vbDyuOAvqcyMr6kGKzm4MNt3iMa3aefeXISMpg
         HY+lYyVATYSzUISOzWqbZcZBfZtJePPI5Vy8xfUesSAhbHwc+0KgQwwYuSYdqRiWYfnc
         /oyM3k+Xr2a+7XBIJXAmMigVKATbwnjETeSXsSmxREWe7kaC+hmfbCqKCnCYB2xKlQ+m
         GyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4bRUEOcKLm4DS4B/jW3feMkPgYheSCRlhCV3QPcIdfM=;
        b=b+wwU+1EOZFVKF6xsq1jKJ+nUvjT55OEtolXJiqbESG4iQQrv71T8WtMS/fmzAULyA
         eQjisN2pDET/qKIrzawf5qmJEwlPwlusH2rUNuNTbG/a1q7onFwP/eMRXE+xMG4anZdv
         cboi0Umzcc1rQLgorumNvMcW9+M7HlVog390TZrQ6PaFQB9lbUEVNiGBFq+XHZtGlbir
         whYTeaQyZZCjo592PvLgdN37LgQp4MbZHLT5y88FD5iYmnHA/Yyp99tzn6SP1zszgJPE
         jJD4XCxTFXe8mFfrO8cLKQA7AL30T5uYPtVm/TtRBQ/MNFgS9z6EQJJ6yQIU7h9kx9z3
         rpMA==
X-Gm-Message-State: AOAM531vGEDwOtBIZIC7EwXZeEwMIIPKqsXhyC2e8qrr939nKQeOGhAR
        XUIlRX6KXGkahgCxAXHOw0pTNRMupBoxYdFzPNw=
X-Google-Smtp-Source: ABdhPJzmzWvu27COtLqMKKkTMUYpg/RrU2KpvbhDxtRYowsBJyb58EUIfvC1aCTFfcDylioNXM0Vz5iuQoLCN0k9lZk=
X-Received: by 2002:a25:808b:: with SMTP id n11mr18554881ybk.141.1627477084646;
 Wed, 28 Jul 2021 05:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210726190130.1973-1-macroalpha82@gmail.com>
In-Reply-To: <20210726190130.1973-1-macroalpha82@gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Wed, 28 Jul 2021 08:57:52 -0400
Message-ID: <CAMdYzYqjrReKOWBMsaGpjj-hSvQYap=hMeyvpeggKuz+mVkULw@mail.gmail.com>
Subject: Re: [RFC v2 0/4] power: supply: Add Support for RK817 Charger
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        maccraft123mc@gmail.com, sre@kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Chris Morgan <macromorgan@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 26, 2021 at 3:02 PM Chris Morgan <macroalpha82@gmail.com> wrote:
>
> From: Chris Morgan <macromorgan@hotmail.com>
>
> As this is my first charger driver, I'm submitting it as an RFC so I
> can get input from the community on what else is needed to make the
> driver consistent with the quality upstream expects.
>
> This series is to add support for the Rockchip rk817 battery charger
> which is present in all Rockchip RK817 PMICs. The driver was written
> as a joint effort by Maya Matuszczyk <maccraft123mc@gmail.com> and
> myself Chris Morgan <macromorgan@hotmail.com>.
>
> The driver requires some basic parameters be described about the
> battery in the devicetree such as the maximum capacity, the minimum
> and maximum voltage for the battery, the maximum charge current, the
> maximum charge voltage, and the value of sample resistors and sleep
> currents.
>
> The hardware itself contains an ADC capable of measuring the voltage,
> current, and temperature of the battery (though my implementation of an
> Odroid Go Advance lacks a thermistor for temperature). It also contains
> a columb counter, registers for tracking the measured voltage and
> current at boot, and a few bytes of nvram for storing data.

Feel free to add my Tested-by: Peter Geis <pgwipeout@gmail.com>

Tested on the Pine64 Quartz64 Model A.
We can't go as low on the battery voltage, otherwise the SOC becomes
unstable before it can shut down.
<3625000 0> seems sufficient for us though (adding this for the
benefit of anyone else testing).

Voltages are accurate as measured at the battery.
Are there plans to expose the thermal sensor (if that's possible)?

>
> Changes from V1:
>
>  - Fixed a CLANG warning regarding an uninitalized variable.
>  - Fixed a CLANG warning regarding a pointer as a bool value always
>    returning as true.
>  - Added Maya Matuszczyk to the Signed-off-by.
>
> Chris Morgan (4):
>   [RFC v2 1/4] dt-bindings: Add Rockchip rk817 battery charger support
>   [RFC v2 2/4] mfd: Add Rockchip rk817 battery charger support
>   [RFC v2 3/4] power: supply: Add charger driver for Rockchip RK817
>   [RFC 4/4] arm64: dts: rockchip: add rk817 charger to Odroid Go Advance
>
>  .../devicetree/bindings/mfd/rk808.txt         |  35 +-
>  .../boot/dts/rockchip/rk3326-odroid-go2.dts   |  25 +
>  drivers/mfd/rk808.c                           |  16 +-
>  drivers/power/supply/Kconfig                  |   6 +
>  drivers/power/supply/Makefile                 |   1 +
>  drivers/power/supply/rk817_charger.c          | 932 ++++++++++++++++++
>  include/linux/mfd/rk808.h                     |  87 ++
>  7 files changed, 1099 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/power/supply/rk817_charger.c
>
> --
> 2.25.1
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
