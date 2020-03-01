Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A184174D91
	for <lists+linux-pm@lfdr.de>; Sun,  1 Mar 2020 14:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgCANyh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Mar 2020 08:54:37 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:34234 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgCANyh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Mar 2020 08:54:37 -0500
Received: by mail-vk1-f196.google.com with SMTP id w67so2247153vkf.1
        for <linux-pm@vger.kernel.org>; Sun, 01 Mar 2020 05:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4p3ea/93vVO3AS5Nk2JVeePiOdyOs8HUXKWbFRb7Ksw=;
        b=VQu+9m3TVZBXWiuCW/69+JNNOucQrwjY+YC9TtY29U5TBfL3hxQe80JZBXno0Seggc
         qSTxsFljwgZ1b2AK8p0Ha05DHE4ebJGmQttyqmqh1roBtAJ6YMGEsmXCLnsLWV0jXOn3
         jat4muoLvWi6dEOycIrmkPbZGViyHTjQg6xWPaJtUJdJt0oLeTK8EpK4DYXk5dR4oAI9
         qwf6IekSmR1MiUjb3R/wLf3LfyE4ptDTGqoMOepZffotKDS5jch5i8abWm3ZT0PEG089
         aCA3E9o8SKLK8VsCL3KlH1FDpO5k5/9QW9OUGT0nx+lJCG+jHMyc10FNqgNTLrDqMcOB
         nu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4p3ea/93vVO3AS5Nk2JVeePiOdyOs8HUXKWbFRb7Ksw=;
        b=hZ73SieknTmHRsPphOVrYe5kMly7FLIljmjoVk6Sk3cP8+xg3PP+k7/LTrHaH1zgaU
         5VhinMi/7oWQTVwgZlgVG/RxPvFC93++Cll0W1HJE/OHbVuQIg+w68tlxbk169dWp64P
         QExGebbaSZMotebN3e0MZbgVE/7Ax+LXsvXXApy42NDFF3YzNW5pyXt2ivKgGu6NX0Jn
         el3aEjKG/edmeXFOM6nRd9k/FCS2zoQ1dgw6BDLl8R9u6Fxvs7G0QZNx8KUfhWm9wVIL
         KiJxcPyxTVKcXnz6c8tDI7twTZVqXc5unRWho0JRHdadw+15eLsE36qGqjWpl/1H8yDy
         j1hw==
X-Gm-Message-State: ANhLgQ36CR3oIE3OhPrDx87z/WA+3yNdhKiVSibOqoDlRiaft21d3QFz
        hHpTqN194MZipUFvQ0C+/WuzNZOTlQpZin34nEM3mQ==
X-Google-Smtp-Source: ADFU+vtyKNi2NBK3A4Jk6IXT5Ag4VKXG3PE84eY3507ibdyko3BtKPfOyqM9xkKIc/gx0to3rWSP7PEFB2fxtIp9kjI=
X-Received: by 2002:ac5:c7a9:: with SMTP id d9mr7036811vkn.79.1583070875758;
 Sun, 01 Mar 2020 05:54:35 -0800 (PST)
MIME-Version: 1.0
References: <20200229204527.143796-1-linus.walleij@linaro.org>
In-Reply-To: <20200229204527.143796-1-linus.walleij@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Sun, 1 Mar 2020 19:24:24 +0530
Message-ID: <CAHLCerPmxgXbMGrkJ6O1FuAE_JCv0zHnjNuXJ0fVy66t-87qPg@mail.gmail.com>
Subject: Re: [PATCH] thermal: Rephrase the Kconfig text for thermal
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Mar 1, 2020 at 2:17 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> The thermal subsystem may have relied on sysfs in 2008 when it
> was introduced, but these days the thermal zones will more often
> than not come from the hardware descriptions and not from sysfs.
>
> Drop the "Generic" phrases as well: there are no non-generic
> drivers that I know of, the thermal framework is by definition
> generic.
>
> Reword a bit and fix some grammar.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/Kconfig | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 5a05db5438d6..a88aa0f6c5a8 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -1,17 +1,18 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  #
> -# Generic thermal sysfs drivers configuration
> +# Generic thermal drivers configuration
>  #
>
>  menuconfig THERMAL
> -       bool "Generic Thermal sysfs driver"
> +       bool "Thermal drivers"
>         help
> -         Generic Thermal Sysfs driver offers a generic mechanism for
> +         Thermal drivers offers a generic mechanism for
>           thermal management. Usually it's made up of one or more thermal
> -         zone and cooling device.
> +         zones and cooling devices.
>           Each thermal zone contains its own temperature, trip points,
> -         cooling devices.
> -         All platforms with ACPI thermal support can use this driver.
> +         and cooling devices.
> +         All platforms with ACPI or Open Firmware thermal support can use
> +         this driver.
>           If you want this support, you should say Y here.
>
>  if THERMAL
> --
> 2.24.1
>
