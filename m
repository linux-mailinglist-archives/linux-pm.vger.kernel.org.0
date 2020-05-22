Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B161DF114
	for <lists+linux-pm@lfdr.de>; Fri, 22 May 2020 23:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbgEVV2e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 May 2020 17:28:34 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:36632 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731035AbgEVV2e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2020 17:28:34 -0400
Received: by mail-il1-f194.google.com with SMTP id 17so12159149ilj.3;
        Fri, 22 May 2020 14:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aeNkqKnvqrQ1R9V6A7mXbyK3G4VemHM61exPIH1obU8=;
        b=toDixm3r78ob4m1rBDOOq6aEFOX1cMsnnypBr+soAcOLbklCtOcz/y4Q8AJaUNYnFn
         wcbIHu1EqFqEdfvw820qNELwVJA05OAfCgwWWj0vXqUJVzISsiC0AmaqMTpGkHrwP9WT
         Ma6hBtNRkir9rLjAEiMiviXc0oDNASGY5RGQTbdW3cFQw5swLBs1n5Gn4zgXgMkuq7aP
         rqGGB6Ge+Y4+80FOeK8/DQIBIjSW7piLj0CR5M9P1uroj9ZgN8BoVdbvUAdRSBxigiBP
         l0CZ2L3IT69eX3yUs0d77142YZoSmnb8SSSCFl3Q2dZH3OuluXsOwClTnga9sglyM/N4
         8HUA==
X-Gm-Message-State: AOAM533l4ZoILMBigswybeK0pHI3cZE2ImGcFLs8+I54dt9Aofs6QUXZ
        LgzSmKX8eeU40ONWI84a97DYehVvmWs=
X-Google-Smtp-Source: ABdhPJxqs7mPKhasfMjw+2Tly2+Y+QUzs6NUQl34JF5bRHWwIbhB/Cbx9lPWfsTZeeLAl+TerA0d1g==
X-Received: by 2002:a92:914d:: with SMTP id t74mr14383223ild.182.1590182911723;
        Fri, 22 May 2020 14:28:31 -0700 (PDT)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com. [209.85.166.52])
        by smtp.gmail.com with ESMTPSA id y12sm5450562ilk.16.2020.05.22.14.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 14:28:31 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id q8so11555333iow.7;
        Fri, 22 May 2020 14:28:30 -0700 (PDT)
X-Received: by 2002:a6b:1505:: with SMTP id 5mr4759580iov.198.1590182910435;
 Fri, 22 May 2020 14:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200507112955.23520-1-geert+renesas@glider.be> <20200507112955.23520-4-geert+renesas@glider.be>
In-Reply-To: <20200507112955.23520-4-geert+renesas@glider.be>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 22 May 2020 16:28:06 -0500
X-Gmail-Original-Message-ID: <CADRPPNQxRwa2kQj_5K26RcovBhtfxdKitOxBKF8sgoyu9O+W-Q@mail.gmail.com>
Message-ID: <CADRPPNQxRwa2kQj_5K26RcovBhtfxdKitOxBKF8sgoyu9O+W-Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] clk: qoriq: Add platform dependencies
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Shawn Guo <shawnguo@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org,
        linux-clk <linux-clk@vger.kernel.org>, linux-pm@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 7, 2020 at 6:31 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> The Freescale QorIQ clock controller is only present on Freescale E500MC
> and Layerscape SoCs.  Add platform dependencies to the CLK_QORIQ config
> symbol, to avoid asking the user about it when configuring a kernel
> without E500MC or Layerscape support.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Hi Michael/Stephen,

Are you applying this patch?  If not I can apply it with your ACK.

Regards,
Leo

> ---
>  drivers/clk/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index bcb257baed06daa0..22bf015610d1724c 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -232,7 +232,8 @@ config COMMON_CLK_AXI_CLKGEN
>
>  config CLK_QORIQ
>         bool "Clock driver for Freescale QorIQ platforms"
> -       depends on (PPC_E500MC || ARM || ARM64 || COMPILE_TEST) && OF
> +       depends on OF
> +       depends on PPC_E500MC || SOC_LS1021A || ARCH_LAYERSCAPE || COMPILE_TEST
>         ---help---
>           This adds the clock driver support for Freescale QorIQ platforms
>           using common clock framework.
> --
> 2.17.1
>
