Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E011B5063
	for <lists+linux-pm@lfdr.de>; Thu, 23 Apr 2020 00:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgDVWej (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Apr 2020 18:34:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgDVWej (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Apr 2020 18:34:39 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66FC720787;
        Wed, 22 Apr 2020 22:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587594878;
        bh=SNLJpvjts7rfI5JB0oV0kkk5fsoKCQ2Y16T9IZfyysU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jfEGWgL3I7QE5dnT9rxy4Uh0or1xw7bOlQluSsJjQV2pMj3+bHmUWPnl+9rV5U8ne
         AAabN2yFwNtBeg1WcMgBiezmMS82oeM0GmunyElkIOERrFQiLYuPSuBFXrffoNjL7a
         dpAAZK6RY5ygJQAYsPKTD8Zwe73PoTVt8hiAjUCE=
Received: by mail-qk1-f175.google.com with SMTP id n143so4327710qkn.8;
        Wed, 22 Apr 2020 15:34:38 -0700 (PDT)
X-Gm-Message-State: AGi0PuYpHE6R0dLPDGLB7vllMGMTsODmWDzd49rIqqdYK/wHAS7X1v/5
        XbP40UbYnyNa06sBQPWoQm8WKEpPnrcUGiQYLw==
X-Google-Smtp-Source: APiQypKvREuslhX7owSjgWSS+4M/X4oIDaXzXQlnQscoYPYL8BsUg9lRR4iwpRQ3uKjlf98Z0AnWRF3ELD7q9OJL57M=
X-Received: by 2002:a37:61cd:: with SMTP id v196mr559236qkb.393.1587594877490;
 Wed, 22 Apr 2020 15:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200419170810.5738-1-robh@kernel.org> <20200419170810.5738-6-robh@kernel.org>
 <158754886772.132238.8648193086417881263@swboyd.mtv.corp.google.com>
In-Reply-To: <158754886772.132238.8648193086417881263@swboyd.mtv.corp.google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 22 Apr 2020 17:34:26 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLhdpye3z4-mznA+mV6y-mgfDONYZNW+39nZgEXH2_eEw@mail.gmail.com>
Message-ID: <CAL_JsqLhdpye3z4-mznA+mV6y-mgfDONYZNW+39nZgEXH2_eEw@mail.gmail.com>
Subject: Re: [PATCH 05/17] clk: versatile: Kill CONFIG_COMMON_CLK_VERSATILE
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Will Deacon <will@kernel.org>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 22, 2020 at 4:47 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Rob Herring (2020-04-19 10:07:58)
> > diff --git a/drivers/clk/versatile/Kconfig b/drivers/clk/versatile/Kconfig
> > index c2618f1477a2..3465fb291998 100644
> > --- a/drivers/clk/versatile/Kconfig
> > +++ b/drivers/clk/versatile/Kconfig
> > @@ -1,22 +1,14 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  config ICST
> > -       bool
> > -
> > -config COMMON_CLK_VERSATILE
> > -       bool "Clock driver for ARM Reference designs"
> > -       depends on ARCH_INTEGRATOR || ARCH_REALVIEW || \
> > -               ARCH_VERSATILE || ARCH_VEXPRESS || ARM64 || \
> > -               COMPILE_TEST
> > +       bool "Clock driver for ARM Reference designs ICST" if COMPILE_TEST
> >         select REGMAP_MMIO
> >         ---help---
> >           Supports clocking on ARM Reference designs:
> >           - Integrator/AP and Integrator/CP
> >           - RealView PB1176, EB, PB11MP and PBX
> > -         - Versatile Express
> >
> >  config CLK_SP810
> >         bool "Clock driver for ARM SP810 System Controller"
> > -       depends on COMMON_CLK_VERSATILE
>
> Shouldn't this get the depends from COMMON_CLK_VERSATILE so that this
> option isn't exposed unless someone is compile testing or using that
> platform?

IMO, once the dependencies get complicated enough, it's better to just
expose the option. But I could drop just the select and keep the
depends. It's primarily having both that we didn't need.

Rob
