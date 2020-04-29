Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4629B1BE941
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 22:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgD2U6a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 16:58:30 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46022 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgD2U6a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 16:58:30 -0400
Received: by mail-ot1-f68.google.com with SMTP id e20so2954643otk.12;
        Wed, 29 Apr 2020 13:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MnHANIm3Lt/vh28RWXjD/MDMuUK3kNL3Hz3uh0uBuNk=;
        b=Sfe+apAwzsYN0iKTjM6fEjESDUeqo4npmZO4FYsb+oHgtZz6iF76AVyFZMDLJYV8di
         CpI6BSmGcYydRl/WjJQb7IyVzv0P+D8Nu5cJR9NlIiMC+bZnp1xdp2QGLmatpNUBDmLX
         +bPfm7XmwCG9GW6jR7irpJHucskwXlfhPT0fEhI/sANeaVq4c8LNcYsju2B2rsecvQ/k
         wj5Pxv3R6bmrjdL3t6ocM8vS6I/4XjWWk/wlyDNduH+Cq4TiAIbxZwx+KQxCgw2tf/nc
         npfHQVJZi03mq2JkptOHz60uee8WnW8ahYb5goxeuwZrJtuTHwfbZd3dVcTLirwqDFic
         iaDg==
X-Gm-Message-State: AGi0PuafbfLQtmfMIGEInnxypkLdbPpKvR2k0mYw7rBr3GD8uVACWVvo
        SO/ToR5ZjhCOjweGKNGC7w==
X-Google-Smtp-Source: APiQypIrHRKHQtFy0c/K7pk+j4P/vsiyNqYsBEwDCGgpoagGDyB7Mio4YrRyWmBtS8KUovUwq+wDbw==
X-Received: by 2002:a9d:6b13:: with SMTP id g19mr2806662otp.249.1588193907789;
        Wed, 29 Apr 2020 13:58:27 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id z13sm653162oth.10.2020.04.29.13.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 13:58:27 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 00/17] Modularizing Versatile Express
Date:   Wed, 29 Apr 2020 15:58:09 -0500
Message-Id: <20200429205825.10604-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series enables building various Versatile Express platform drivers
as modules. The primary target is the Fast Model FVP which is supported
in Android. As Android is moving towards their GKI, or generic kernel,
the hardware support has to be in modules. Currently ARCH_VEXPRESS
enables several built-in only drivers. Some of these are needed, but
some are only needed for older 32-bit VExpress platforms and can just
be disabled. For FVP, the pl111 display driver is needed. The pl111
driver depends on vexpress-osc clocks which had a dependency chain of
vexpress-config --> vexpress-syscfg --> vexpress-sysreg. These
components relied on fixed initcall ordering and didn't support deferred
probe which would have complicated making them modules. All these levels
of abstraction are needlessly complicated, so this series simplifies
things a bit by merging the vexpress-config and vexpress-syscfg
functionality.

There's a couple of other pieces to this which I've sent out separately
as they don't have dependencies with this series. The cross subsystem
dependencies in this series are mainly the ordering of enabling drivers
as modules.

A complete git branch is here[1]. Tested on Fast Model FVP Rev C.

v2:
The major change is a boot fix for 32-bit VExpress platforms with patch 3.
I also dropped 'power/reset: vexpress: Support building as a module' as it
was incomplete and not needed for this series.

Rob

[1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git vexpress-modules-v4

Rob Herring (16):
  ARM: vexpress: Move vexpress_flags_set() into arch code
  arm64: vexpress: Don't select CONFIG_POWER_RESET_VEXPRESS
  amba: Retry adding deferred devices at late_initcall
  clk: versatile: Rework kconfig structure
  clk: versatile: Only enable SP810 on 32-bit by default
  clk: vexpress-osc: Use the devres clock API variants
  clk: vexpress-osc: Support building as a module
  mfd: vexpress-sysreg: Drop selecting CONFIG_CLKSRC_MMIO
  mfd: vexpress-sysreg: Drop unused syscon child devices
  mfd: vexpress-sysreg: Use devres API variants
  mfd: vexpress-sysreg: Support building as a module
  bus: vexpress-config: Merge vexpress-syscfg into vexpress-config
  bus: vexpress-config: simplify config bus probing
  vexpress: Move setting master site to vexpress-config bus
  bus: vexpress-config: Support building as module
  ARM: vexpress: Don't select VEXPRESS_CONFIG

 arch/arm/mach-integrator/Kconfig         |   1 -
 arch/arm/mach-realview/Kconfig           |   1 -
 arch/arm/mach-versatile/Kconfig          |   1 -
 arch/arm/mach-vexpress/Kconfig           |   4 -
 arch/arm/mach-vexpress/core.h            |   1 +
 arch/arm/mach-vexpress/dcscb.c           |   1 +
 arch/arm/mach-vexpress/v2m.c             |  23 ++
 arch/arm64/Kconfig.platforms             |   3 -
 drivers/amba/bus.c                       |  14 +-
 drivers/bus/Kconfig                      |   2 +-
 drivers/bus/vexpress-config.c            | 354 ++++++++++++++++++-----
 drivers/clk/Makefile                     |   2 +-
 drivers/clk/versatile/Kconfig            |  24 +-
 drivers/clk/versatile/clk-vexpress-osc.c |  20 +-
 drivers/mfd/Kconfig                      |   5 +-
 drivers/mfd/vexpress-sysreg.c            |  99 +------
 drivers/misc/Kconfig                     |   9 -
 drivers/misc/Makefile                    |   1 -
 drivers/misc/vexpress-syscfg.c           | 280 ------------------
 include/linux/vexpress.h                 |  30 --
 20 files changed, 354 insertions(+), 521 deletions(-)
 delete mode 100644 drivers/misc/vexpress-syscfg.c


base-commit: 8f3d9f354286745c751374f5f1fcafee6b3f3136
--
2.20.1
