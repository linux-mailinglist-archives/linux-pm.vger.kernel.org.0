Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63AE21FD054
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jun 2020 17:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgFQPI6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jun 2020 11:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgFQPI5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jun 2020 11:08:57 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E3AC06174E
        for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2020 08:08:56 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id p5so2701883wrw.9
        for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2020 08:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+VNaCgKeSAnsN+2G9TGu/G00Sb3RTAWKbG0yrAPTqfc=;
        b=PjRd+YJaVQBUHQNA2/1ldZGAZDRGPLRJx6vn4bQ/rNkgw9VAr96cilJKYUFZfEaDA+
         HzU3AK3wJJQUDymlKwFpdQU8KjP99QeVmcn0bJsycQ7Wq5D+9EtJX0t2wxQ9iKJUqtbY
         tx+yLFVYPNGBR+uRQxD/S1Rez637Q7fxDxX81mpy6WoiSnRsothG21jfzqCrGGP5bkqy
         0GzHx/6bP6bsZjd8PkZSKBQpPddWd2Udbro03r3t9L7GMOohEYk3boX0FZsEtZ4ewoB8
         zXP8f2QUPfY9jxga/X7alS3BShywjSYVxo2Sty0oyjTNRupb+B3rgvceGjh8LZWY2PMt
         xrqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+VNaCgKeSAnsN+2G9TGu/G00Sb3RTAWKbG0yrAPTqfc=;
        b=QE6vF+7Ykt1pS2IvNicZsPXdL5FiTjfsKpyVAq0CBKiurOyaKs1YbB5GeXeBK0heiz
         zL2UpNJY0PTLbn6YclQ31q+enJvS/yHkqBf/kh9Gx+h9BJLqtTOLWoYgmDiBF19PJqC/
         19dswPL6pCsb3OUKJZF0YQPRyMFbE3om41kwFE7qq7L6sn7/dG6GSkXal7U8qBcuoKuG
         zKkl53EBdKq1OMf5/adQmoY67zXkafP6NIibuyFPMtLZ7VgbsXISUxQ75fkfOaoSBynS
         AtgAkwieKkIfYYS5FVEAsx/BluJme3z4+5ioGeyrnfbtOVEiSaO+Di1ZSpRbl//hnaVj
         DDLg==
X-Gm-Message-State: AOAM531ZItLy0mD70g/1Vh1SmWQ9NfsKOARm+eviAlEqx4rEP451GGvW
        qlZHdcm7koO++SrlpBd5l8zo6A==
X-Google-Smtp-Source: ABdhPJxX7JM0uX3X/Kwlok22E/PAQtWSfiY6CgMnhY7NTYOH/rojgKo8V80hqDPFuNDj3usNnCAXbA==
X-Received: by 2002:a5d:4a4d:: with SMTP id v13mr1522923wrs.142.1592406534608;
        Wed, 17 Jun 2020 08:08:54 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id j18sm35640740wrn.59.2020.06.17.08.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 08:08:53 -0700 (PDT)
Date:   Wed, 17 Jun 2020 16:08:50 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Sebastian Reichel <sre@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 00/17] Modularizing Versatile Express
Message-ID: <20200617150850.t23gwj3p2qnduq2a@holly.lan>
References: <20200429205825.10604-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429205825.10604-1-robh@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 29, 2020 at 03:58:09PM -0500, Rob Herring wrote:
> This series enables building various Versatile Express platform drivers
> as modules. The primary target is the Fast Model FVP which is supported
> in Android. As Android is moving towards their GKI, or generic kernel,
> the hardware support has to be in modules. Currently ARCH_VEXPRESS
> enables several built-in only drivers. Some of these are needed, but
> some are only needed for older 32-bit VExpress platforms and can just
> be disabled. For FVP, the pl111 display driver is needed. The pl111
> driver depends on vexpress-osc clocks which had a dependency chain of
> vexpress-config --> vexpress-syscfg --> vexpress-sysreg. These
> components relied on fixed initcall ordering and didn't support deferred
> probe which would have complicated making them modules. All these levels
> of abstraction are needlessly complicated, so this series simplifies
> things a bit by merging the vexpress-config and vexpress-syscfg
> functionality.
> 
> There's a couple of other pieces to this which I've sent out separately
> as they don't have dependencies with this series. The cross subsystem
> dependencies in this series are mainly the ordering of enabling drivers
> as modules.

This series results in the vexpress-a15 console not coming up until very
late in the boot process because the console arch_initcall() ends up
being deferred because it's dependencies are no longer use
core_initcall() to ensure they get in first.

Is there a problem registering vexpress-osc, vexpress-sysreg and
vexpress-config as core_initcall's so the console behaves nicely
when they are all compiled as built-ins?


Daniel.




> 
> A complete git branch is here[1]. Tested on Fast Model FVP Rev C.
> 
> v2:
> The major change is a boot fix for 32-bit VExpress platforms with patch 3.
> I also dropped 'power/reset: vexpress: Support building as a module' as it
> was incomplete and not needed for this series.
> 
> Rob
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git vexpress-modules-v4
> 
> Rob Herring (16):
>   ARM: vexpress: Move vexpress_flags_set() into arch code
>   arm64: vexpress: Don't select CONFIG_POWER_RESET_VEXPRESS
>   amba: Retry adding deferred devices at late_initcall
>   clk: versatile: Rework kconfig structure
>   clk: versatile: Only enable SP810 on 32-bit by default
>   clk: vexpress-osc: Use the devres clock API variants
>   clk: vexpress-osc: Support building as a module
>   mfd: vexpress-sysreg: Drop selecting CONFIG_CLKSRC_MMIO
>   mfd: vexpress-sysreg: Drop unused syscon child devices
>   mfd: vexpress-sysreg: Use devres API variants
>   mfd: vexpress-sysreg: Support building as a module
>   bus: vexpress-config: Merge vexpress-syscfg into vexpress-config
>   bus: vexpress-config: simplify config bus probing
>   vexpress: Move setting master site to vexpress-config bus
>   bus: vexpress-config: Support building as module
>   ARM: vexpress: Don't select VEXPRESS_CONFIG
> 
>  arch/arm/mach-integrator/Kconfig         |   1 -
>  arch/arm/mach-realview/Kconfig           |   1 -
>  arch/arm/mach-versatile/Kconfig          |   1 -
>  arch/arm/mach-vexpress/Kconfig           |   4 -
>  arch/arm/mach-vexpress/core.h            |   1 +
>  arch/arm/mach-vexpress/dcscb.c           |   1 +
>  arch/arm/mach-vexpress/v2m.c             |  23 ++
>  arch/arm64/Kconfig.platforms             |   3 -
>  drivers/amba/bus.c                       |  14 +-
>  drivers/bus/Kconfig                      |   2 +-
>  drivers/bus/vexpress-config.c            | 354 ++++++++++++++++++-----
>  drivers/clk/Makefile                     |   2 +-
>  drivers/clk/versatile/Kconfig            |  24 +-
>  drivers/clk/versatile/clk-vexpress-osc.c |  20 +-
>  drivers/mfd/Kconfig                      |   5 +-
>  drivers/mfd/vexpress-sysreg.c            |  99 +------
>  drivers/misc/Kconfig                     |   9 -
>  drivers/misc/Makefile                    |   1 -
>  drivers/misc/vexpress-syscfg.c           | 280 ------------------
>  include/linux/vexpress.h                 |  30 --
>  20 files changed, 354 insertions(+), 521 deletions(-)
>  delete mode 100644 drivers/misc/vexpress-syscfg.c
> 
> 
> base-commit: 8f3d9f354286745c751374f5f1fcafee6b3f3136
> ---
> 2.20.1
