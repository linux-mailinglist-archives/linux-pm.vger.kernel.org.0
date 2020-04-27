Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BA71B9FBE
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 11:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgD0JWY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 05:22:24 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33769 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgD0JWY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2020 05:22:24 -0400
Received: by mail-ot1-f68.google.com with SMTP id j26so25016103ots.0;
        Mon, 27 Apr 2020 02:22:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8DC9wuWVCpF4fX18bDiRbTVykcklvB3HgA/RSTX3Ci8=;
        b=mhsPza1L+7xZRs4T2p5Egg3AsNIqgbf6S8LCkx2Av9mky2fXKgFR8KEoUPI0792Lhj
         fvNrfEwjG/kdUl0t1Ddlo5vclAinBnS6rV3quLRCt2IzQDpHjRRkfyz7Tx2Cljj0s0rX
         teBGZISSKPlooHXEynRAxzRXOXDsgmoJuFL/TYu5Y6i7I6zWFb/hDZRUwI2bnF27Fufg
         TKf+0nmDiLq1b+GZfDSYDQfoa5ptABQ4vk6TrTV6xjq/Xr7mY+J5NApVn0aXDr46mYab
         +N46vkgSHy0X5T18EyRbPeI/0fHuuV5eqAHp09c4gXFtUIVxGLOCyZU2opw5pwa0ZXwX
         Pe1w==
X-Gm-Message-State: AGi0PuZMG2Q7eecdWDmM+0Kdf5SsSB7kjAKoysccHwrNmyh4BRnHMqB3
        VfIhtQLbDZYPGBPicbsolA9AkuXT5PmIZS3qV/k=
X-Google-Smtp-Source: APiQypJ10JMZ48yMEr4gCPT2ON7rEsolbc8FeD4lWrGcROoB5VwAc887q0ILi7S4AP3Z/A1HrLX90XTtwrazUTrCwvg=
X-Received: by 2002:a9d:7d85:: with SMTP id j5mr16573914otn.107.1587979343075;
 Mon, 27 Apr 2020 02:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <1587678050-23468-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1587678050-23468-11-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1587678050-23468-11-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Apr 2020 11:22:11 +0200
Message-ID: <CAMuHMdV6J-_gBkzhUXtA8OrxhJVzyrAqjA8oeGJGBp86X-C3Nw@mail.gmail.com>
Subject: Re: [PATCH 10/10] cpufreq: dt: Add support for r8a7742
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Marian-Cristian Rotariu 
        <marian-cristian.rotariu.rb@bp.renesas.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Prabhakar,

This patch should be merged through Viresh's cpufreq tree (CCed).

On Thu, Apr 23, 2020 at 11:41 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add the compatible strings for supporting the generic cpufreq driver on
> the Renesas RZ/G1H (R8A7742) SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -53,6 +53,7 @@ static const struct of_device_id whitelist[] __initconst = {
>         { .compatible = "renesas,r7s72100", },
>         { .compatible = "renesas,r8a73a4", },
>         { .compatible = "renesas,r8a7740", },
> +       { .compatible = "renesas,r8a7742", },
>         { .compatible = "renesas,r8a7743", },
>         { .compatible = "renesas,r8a7744", },
>         { .compatible = "renesas,r8a7745", },
> --
> 2.7.4

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
