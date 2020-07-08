Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74F8218D24
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jul 2020 18:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbgGHQj4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jul 2020 12:39:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730157AbgGHQj4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Jul 2020 12:39:56 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C2F520720;
        Wed,  8 Jul 2020 16:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594226395;
        bh=si9R9YOpPstoou9WxWBNgmosG+kQzBPQSimX+2todNU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kYuGFbgc5ScwOake38b/0c4Q3UUTq874vrMs+mkeC4d90VGDkdlANcs3gLiwRgShT
         D4D7nu4T/2t6tPGAPlRttnXFJAt+oXZ8PMY7RRFhZVc6X77Kdbc4D9fWXQ9AiZ02eC
         EtTHvufxN+zYb7miMNJr1Wfe9TlPnIMOsElEP9Gc=
Received: by mail-oo1-f43.google.com with SMTP id z127so5419205ooa.3;
        Wed, 08 Jul 2020 09:39:55 -0700 (PDT)
X-Gm-Message-State: AOAM533GKwxWcMWpxpv7ZqwLcAMS6a59aXoKxWbSa12eMZmH25OAVJHR
        FV1zjle9FCWi6c/rcLYTBcAGOvPh9wRdYEbx4g==
X-Google-Smtp-Source: ABdhPJw98eGut4x1Dphx+po6Q/2rXcEkLotblIzQIjhYrS1ENyVSDVV9J3vSnlOvtvnWZa3lln2BohhrcL8U1WbVAUE=
X-Received: by 2002:a4a:7459:: with SMTP id t25mr39686838ooe.25.1594226394837;
 Wed, 08 Jul 2020 09:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200429205825.10604-1-robh@kernel.org> <20200617150850.t23gwj3p2qnduq2a@holly.lan>
In-Reply-To: <20200617150850.t23gwj3p2qnduq2a@holly.lan>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 8 Jul 2020 10:39:43 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+uTW_-cNOQFWPcYEVRvqf3DEqiaGTfV5uWag0zvAzjgA@mail.gmail.com>
Message-ID: <CAL_Jsq+uTW_-cNOQFWPcYEVRvqf3DEqiaGTfV5uWag0zvAzjgA@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] Modularizing Versatile Express
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Sebastian Reichel <sre@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 17, 2020 at 9:08 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Wed, Apr 29, 2020 at 03:58:09PM -0500, Rob Herring wrote:
> > This series enables building various Versatile Express platform drivers
> > as modules. The primary target is the Fast Model FVP which is supported
> > in Android. As Android is moving towards their GKI, or generic kernel,
> > the hardware support has to be in modules. Currently ARCH_VEXPRESS
> > enables several built-in only drivers. Some of these are needed, but
> > some are only needed for older 32-bit VExpress platforms and can just
> > be disabled. For FVP, the pl111 display driver is needed. The pl111
> > driver depends on vexpress-osc clocks which had a dependency chain of
> > vexpress-config --> vexpress-syscfg --> vexpress-sysreg. These
> > components relied on fixed initcall ordering and didn't support deferred
> > probe which would have complicated making them modules. All these levels
> > of abstraction are needlessly complicated, so this series simplifies
> > things a bit by merging the vexpress-config and vexpress-syscfg
> > functionality.
> >
> > There's a couple of other pieces to this which I've sent out separately
> > as they don't have dependencies with this series. The cross subsystem
> > dependencies in this series are mainly the ordering of enabling drivers
> > as modules.
>
> This series results in the vexpress-a15 console not coming up until very
> late in the boot process because the console arch_initcall() ends up
> being deferred because it's dependencies are no longer use
> core_initcall() to ensure they get in first.

Which was a hack...

> Is there a problem registering vexpress-osc, vexpress-sysreg and
> vexpress-config as core_initcall's so the console behaves nicely
> when they are all compiled as built-ins?

I think the correct way to solve this is with devlinks which reduces
the deferred probes. Can you see if that's better? That's still off by
default and needs a kernel command line option. That may just get the
console up at an earlier initcall level, but not before other h/w
drivers. I think having some way to prioritize probe order without
initcall hacks would be good. Then you could prioritize a console or
splash screen or ???.

Also, if you really need an early console, then use earlycon.

Rob
