Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4355B25A65
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2019 00:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfEUWnU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 May 2019 18:43:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37146 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfEUWnU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 May 2019 18:43:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id 7so212872wmo.2
        for <linux-pm@vger.kernel.org>; Tue, 21 May 2019 15:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rh5zhmB9pIXrzawqY8AKtcg1nijof3Pl+JZMPvAKIzI=;
        b=sBHQ9lvYYxn/XTvH7+SdJa/IDZqqFTmcRI3bdiKSLSVdBpU9GaM3Bu6X25o8dM/3a2
         qI1wkOioqEXX2qHB++OCUs/P4XIPejw/FJK9z8V50OKPZaEa4bzEWIJ+ToAP9P85LVid
         KHU+joijWlZm0cGtqdgbRK9mSKz6GJvrKcjt/Tt735dU3Hx7+CJquNnwAH/ggWevEV1C
         kHweFjDll9zVhB0K4XL9QTFLrZPq19CamY5CNdgnYa5Nff+/ZSAGgQ0BAt09x9KCujos
         PbBWhTCh8P8lBLPGjiKULHPCwYUSajJ5WnP2Fm8BpQuB+dT/5dF0ue/9iT4Q7jAU23lR
         V/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rh5zhmB9pIXrzawqY8AKtcg1nijof3Pl+JZMPvAKIzI=;
        b=ZH9Nm9bH+JjVLrT0ZvagnLiJHSGkPQgxEWVrKTrvDxgBeMQvNJcnoIe3A7jsmiokms
         cBRaHh/Ac4CFU3dgS585+Vr97sYFTHt7PHM6K1NJnk7c+GD24S9uWMTE/pKxA/EsRI3q
         KvvKh5vf6L36+IhmkaCBHwBnEfT/ryLCoRw+ejyu+LoVYv/FMfOfskBjGoQYDUrNHIZh
         Vx+Uj5ygiH1WUY2ODME5FziH/i8hUWh6l68WkjSnNc34ode4KPbtvTIN2kAv4gY/rs1e
         V/+Xm4zJl7rVblcI/iQ013tk9BkWBaShqv2iiT0FUkR33C+tQxTCaDVrnKqj56IchF8H
         b1Rw==
X-Gm-Message-State: APjAAAWXcxwt9gFBLSuDw72aNdMv7EO5gVwvYLJtVXLCW5yqVsGy/06i
        e8Hke9JImtnn8U05t5oMQ1zNtmwxFImCW3lu359V
X-Google-Smtp-Source: APXvYqwGSHyBn5RiOCFkhuZPXWdleQytgHyzzVkjLADG8gu+JFArhym1azbwi1YXhYp8TCGjSWX5MV989/0Pk0bWPJE=
X-Received: by 2002:a1c:6783:: with SMTP id b125mr4851689wmc.79.1558478597215;
 Tue, 21 May 2019 15:43:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190521130357.20803-1-miquel.raynal@bootlin.com> <20190521130357.20803-3-miquel.raynal@bootlin.com>
In-Reply-To: <20190521130357.20803-3-miquel.raynal@bootlin.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue, 21 May 2019 17:43:05 -0500
Message-ID: <CAErSpo5i3y4CxZXV7E4tUR66uXaUa3B_-YT2+zfzZUGMmge7Ow@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] clk: mvebu: armada-37xx-periph: change
 suspend/resume time
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Tue, May 21, 2019 at 8:04 AM
To: Michael Turquette, Stephen Boyd, Rob Herring, Mark Rutland
Cc: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>, Thomas
Petazzoni, Antoine Tenart, Gregory Clement, Maxime Chevallier, Nadav
Haklai, Bjorn Helgaas, Rafael J . Wysocki, <linux-pm@vger.kernel.org>,
Miquel Raynal

> Armada 3700 PCIe IP relies on the PCIe clock managed by this
> driver. For reasons related to the PCI core's organization when
> suspending/resuming, PCI host controller drivers must reconfigure
> their register at suspend_noirq()/resume_noirq() which happens after
> suspend()/suspend_late() and before resume_early()/resume().

"For reasons related to the PCI core's organization" manages to
suggest that this change wouldn't be needed if only the PCI core did
something differently, without actually being specific about what it
would need to do differently.

Is there something the PCI core could do better to make this easier?
Or is it just something like "the PCI core needs to access registers
after suspend_late()"?  You mention the host controller, but of course
that's not itself a PCI device, so the PCI core doesn't have much to
do with it directly.

s/register/registers/ ?

> Device link support in the clock framework enforce that the clock
> driver's resume() callback will be called before the PCIe
> driver's. But, any resume_noirq() callback will be called before all
> the registered resume() callbacks.
>
> The solution to support PCIe resume operation is to change the
> "priority" of this clock driver PM callbacks to "_noirq()".
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/clk/mvebu/armada-37xx-periph.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
> index 1e18c5a875bd..bee45e43a85f 100644
> --- a/drivers/clk/mvebu/armada-37xx-periph.c
> +++ b/drivers/clk/mvebu/armada-37xx-periph.c
> @@ -715,8 +715,8 @@ static int __maybe_unused armada_3700_periph_clock_resume(struct device *dev)
>  }
>
>  static const struct dev_pm_ops armada_3700_periph_clock_pm_ops = {
> -       SET_SYSTEM_SLEEP_PM_OPS(armada_3700_periph_clock_suspend,
> -                               armada_3700_periph_clock_resume)
> +       SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(armada_3700_periph_clock_suspend,
> +                                     armada_3700_periph_clock_resume)
>  };
>
>  static int armada_3700_periph_clock_probe(struct platform_device *pdev)
> --
> 2.19.1
>
