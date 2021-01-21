Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABBC2FE602
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 10:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbhAUJMg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 04:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbhAUJMF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 04:12:05 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80405C061795
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 01:11:15 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id g24so1537258edw.9
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 01:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WLXeWIIoAu3UvtfUefXR9qcSia3PjDVI/Fbc5zrav74=;
        b=L0WyjqaHw0/lRmseCIJJbm0McdMQpzOm/7kVIAnPv9TUdDWiA0dMSeUtNdBHKJD+3t
         r0JwbHmd5Z23dT9lioDVG2jgdlTOM1lnbmB4M7fNcvygWoRf8krfXnzPP0Bcz/z8YG9p
         FoDZz5hLYSFh1bTyeIepXRlh+VS5k0TBAaqcd4YWIaptS0i7CTeFPH8AveyFs/enFj1P
         OHCA72zAkf80LvVLIQqekwMPMD+DUJbmTNB00ALDKuauYkRB+TNZyk05sSSRqMcNgHrZ
         C2u//DcTUii2Oca69dD2DvQW8RLLX0XHRjaWUJsF6j0FEFs8BxSteQAwpCOBtdqdti64
         qMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WLXeWIIoAu3UvtfUefXR9qcSia3PjDVI/Fbc5zrav74=;
        b=MbKFGcwsCxHLcHSQNAs4kdqPLHV8FOM3pOkkw4IhHoBxNDS1r73lDkQVNP6Q4RMTyI
         wjQwnEAReYEuScxtIiHpTMDk+CztgNI/LqV2IKkcHLlY2DqbhhgrNrfts+Aks4MRnS3b
         HnnSSDYJVaxNKfBVaHVhOZvjidc8l6TZc59dB7MCnUYzkOUgs8Y9g0uZWt31lVk0rkLz
         JJxtDVgbL4zfRtyao7gNKybRinAV3kiudBRYR3+5QRpj7/w5to0m33U0IansU2/+5aaj
         Ut6Y1ZKpI+edTtylfGXfYD822ghyR3GTgQ3IWdbJiTYdYD3shJ8+pdoLD57eP2DDL1O9
         6mwg==
X-Gm-Message-State: AOAM533R4s6vfv3taOf9/ShMJE/LkycRXLfRe3dvI+vZIiN3DYltpHy4
        B2+qR4/6DF0LvtEAQozUcC/eCd4f7C9dRNK/JKscYQ==
X-Google-Smtp-Source: ABdhPJzCxyeIcXGOlc4+TBm6gMHiw/i/Y7fx9SBhhCx7//bBXwiSd+CK8jbzA4TdALgfZUw3o+e89xwXFxeHzE+WiQA=
X-Received: by 2002:aa7:c384:: with SMTP id k4mr10130943edq.23.1611220274094;
 Thu, 21 Jan 2021 01:11:14 -0800 (PST)
MIME-Version: 1.0
References: <17nqrn25-rp5s-4652-o5o1-72p2oprqpq90@onlyvoer.pbz>
In-Reply-To: <17nqrn25-rp5s-4652-o5o1-72p2oprqpq90@onlyvoer.pbz>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 21 Jan 2021 14:41:02 +0530
Message-ID: <CA+G9fYsyXsNSXGy6BWZ6mgpAP=+7r6Xy9jQ2xxb9mXyHdRoBCg@mail.gmail.com>
Subject: Re: [PATCH] PM / clk: make PM clock layer compatible with clocks that
 must sleep
To:     Nicolas Pitre <npitre@baylibre.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Nicolas,

On Tue, 5 Jan 2021 at 08:48, Nicolas Pitre <npitre@baylibre.com> wrote:
>
> The clock API splits its interface into sleepable ant atomic contexts:
>
> - clk_prepare/clk_unprepare for stuff that might sleep
>
> - clk_enable_clk_disable for anything that may be done in atomic context
>

<trim>

>
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
>
> diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
> index ced6863a16..a62fb0f9b1 100644
> --- a/drivers/base/power/clock_ops.c
> +++ b/drivers/base/power/clock_ops.c

<trim>

> @@ -64,17 +166,20 @@ static void pm_clk_acquire(struct device *dev, struct pm_clock_entry *ce)
>                 ce->clk = clk_get(dev, ce->con_id);
>         if (IS_ERR(ce->clk)) {
>                 ce->status = PCE_STATUS_ERROR;
> +               return;
> +       } else if (clk_is_enabled_when_prepared(ce->clk)) {

arm-linux-gnueabihf-ld: drivers/base/power/clock_ops.o: in function
`pm_clk_acquire':
drivers/base/power/clock_ops.c:170: undefined reference to
`clk_is_enabled_when_prepared'

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

This build error was noticed on arm architecture on linux next 20210121 tag.
Following builds failed.
 - arm (omap1_defconfig) with clang-10 - FAILED
 - arm (omap1_defconfig) with clang-11 - FAILED

 - arm (omap1_defconfig) with gcc-8 - FAILED
 - arm (omap1_defconfig) with gcc-9 - FAILED
 - arm (omap1_defconfig) with gcc-10 - FAILED

Steps to reproduce:
---------------------------
1)

# TuxMake is a command line tool and Python library that provides
# portable and repeatable Linux kernel builds across a variety of
# architectures, toolchains, kernel configurations, and make targets.
#
# TuxMake supports the concept of runtimes.
# See https://docs.tuxmake.org/runtimes/, for that to work it requires
# that you install podman or docker on your system.
#
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.

tuxmake --runtime docker --target-arch arm --toolchain gcc-8 --kconfig
omap1_defconfig

2)
tuxbuild build --git-repo
https://gitlab.com/Linaro/lkft/mirrors/next/linux-next --git-sha
bc085f8fc88fc16796c9f2364e2bfb3fef305cad --target-arch arm --toolchain
gcc-8 --kconfig omap1_defconfig

-- 
Linaro LKFT
https://lkft.linaro.org
