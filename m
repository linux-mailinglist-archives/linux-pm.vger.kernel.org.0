Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FCB1B3BB1
	for <lists+linux-pm@lfdr.de>; Wed, 22 Apr 2020 11:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgDVJrt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Apr 2020 05:47:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbgDVJrt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Apr 2020 05:47:49 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FBED2071E;
        Wed, 22 Apr 2020 09:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587548868;
        bh=VDHv7iN7f71wDl0Vm0L8nrtTCwARrTeDoVAxeAGLVmo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=VbAV/lWHS2qQ8ld0T0GumGUybrF3+jzfqIyvP++6F+z/oF6aGijuYj7rFrmyK4hXh
         IVpszqtn7I+Khe4u6muPSMSuIY68b/BnG+9+iiTjimExGrZ2VNCAXOgZOT0lKpe+eX
         duDW8qDbVJCQrR6kaxDa/V0LidGo8iCNTAM+NhEY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200419170810.5738-6-robh@kernel.org>
References: <20200419170810.5738-1-robh@kernel.org> <20200419170810.5738-6-robh@kernel.org>
Subject: Re: [PATCH 05/17] clk: versatile: Kill CONFIG_COMMON_CLK_VERSATILE
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Will Deacon <will@kernel.org>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
To:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Date:   Wed, 22 Apr 2020 02:47:47 -0700
Message-ID: <158754886772.132238.8648193086417881263@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Rob Herring (2020-04-19 10:07:58)
> diff --git a/drivers/clk/versatile/Kconfig b/drivers/clk/versatile/Kconfig
> index c2618f1477a2..3465fb291998 100644
> --- a/drivers/clk/versatile/Kconfig
> +++ b/drivers/clk/versatile/Kconfig
> @@ -1,22 +1,14 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config ICST
> -       bool
> -
> -config COMMON_CLK_VERSATILE
> -       bool "Clock driver for ARM Reference designs"
> -       depends on ARCH_INTEGRATOR || ARCH_REALVIEW || \
> -               ARCH_VERSATILE || ARCH_VEXPRESS || ARM64 || \
> -               COMPILE_TEST
> +       bool "Clock driver for ARM Reference designs ICST" if COMPILE_TEST
>         select REGMAP_MMIO
>         ---help---
>           Supports clocking on ARM Reference designs:
>           - Integrator/AP and Integrator/CP
>           - RealView PB1176, EB, PB11MP and PBX
> -         - Versatile Express
> =20
>  config CLK_SP810
>         bool "Clock driver for ARM SP810 System Controller"
> -       depends on COMMON_CLK_VERSATILE

Shouldn't this get the depends from COMMON_CLK_VERSATILE so that this
option isn't exposed unless someone is compile testing or using that
platform?

>         default y if ARCH_VEXPRESS
>         ---help---
>           Supports clock muxing (REFCLK/TIMCLK to TIMERCLKEN0-3) capabili=
ties
> @@ -24,8 +16,7 @@ config CLK_SP810
> =20
>  config CLK_VEXPRESS_OSC
>         bool "Clock driver for Versatile Express OSC clock generators"
> -       depends on COMMON_CLK_VERSATILE
> -       depends on VEXPRESS_CONFIG
> +       depends on VEXPRESS_CONFIG || COMPILE_TEST
>         default y if ARCH_VEXPRESS
>         ---help---
>           Simple regmap-based driver driving clock generators on Versatile
