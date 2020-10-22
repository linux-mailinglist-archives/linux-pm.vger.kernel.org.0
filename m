Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1FF295F01
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 14:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894401AbgJVMwL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 08:52:11 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44731 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442856AbgJVMwK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2020 08:52:10 -0400
Received: by mail-oi1-f194.google.com with SMTP id k27so1555740oij.11;
        Thu, 22 Oct 2020 05:52:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZvF70TonM5MSbQF+AKqyJMMY9TXMCxpwYzE0jaz0hE=;
        b=hJWsDN4EsTOFrX+1Z6P8g6QugvVSgW2is9phjdsFK3Vva2e5O5rAYd5c0zFYz0w/F1
         8jOD9lI5mQ/l1kDZ3EJe+S2ELMl0euZjgZt5/kMgGYdNcGt+2dznlELxrT2e+VBsKX32
         6IOhvAgWQE8XXNs8UDdEqhAzJHct2t1A2KanCEXJP34RwS4g1aM1yr32BkCgfz10bXoZ
         jrwt/yrimd44awlh32uP1SPvz2jpzfIxi4IDmlf+p5wdzyLFcNNeENk/Mu1V3uIwpTSo
         n3uWguLg5B1vDUcOgInXL6Kz3sNfaIV0AU2Jr1R1CeZshDjDJkEomzqcalP8VDNj0Iqa
         0n4g==
X-Gm-Message-State: AOAM5312zj/qg3w/DvGirEm/FT3lw7VuAM1bFYrCf1BUjBhs1MA0QRQI
        q/r1QwT/26G9lBx28zLdpGOOZDmzlWty1UC+0pIbJ97vCTk=
X-Google-Smtp-Source: ABdhPJzb4l+7pc9bnH+KW7qzDrOK3lOdWt9/5Ab6RxF4OeByO0SdXkaLEVEPxB9NevYbwbFbanVopUH79lMopHLTROM=
X-Received: by 2002:aca:c490:: with SMTP id u138mr1505068oif.54.1603371127905;
 Thu, 22 Oct 2020 05:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <1603249530-25218-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1603249530-25218-1-git-send-email-tiantao6@hisilicon.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 22 Oct 2020 14:51:56 +0200
Message-ID: <CAMuHMdVcraVpetQwdj7hW5bCum1SUXz14X6NhcVtq3BH3Csyzw@mail.gmail.com>
Subject: Re: [PATCH] thermal: replace spin_lock_irqsave by spin_lock in hard IRQ
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, amitk@kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Tian,

CC tglx

On Wed, Oct 21, 2020 at 2:15 PM Tian Tao <tiantao6@hisilicon.com> wrote:
> The code has been in a irq-disabled context since it is hard IRQ. There
> is no necessity to do it again.
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Thanks for your patch!

Is this also true if CONFIG_PREEMPT_RT=y, and all irq handlers execute
in the context of special tasks?

> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -409,16 +409,15 @@ static irqreturn_t rcar_thermal_irq(int irq, void *data)
>  {
>         struct rcar_thermal_common *common = data;
>         struct rcar_thermal_priv *priv;
> -       unsigned long flags;
>         u32 status, mask;
>
> -       spin_lock_irqsave(&common->lock, flags);
> +       spin_lock(&common->lock);
>
>         mask    = rcar_thermal_common_read(common, INTMSK);
>         status  = rcar_thermal_common_read(common, STR);
>         rcar_thermal_common_write(common, STR, 0x000F0F0F & mask);
>
> -       spin_unlock_irqrestore(&common->lock, flags);
> +       spin_unlock(&common->lock);
>
>         status = status & ~mask;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
