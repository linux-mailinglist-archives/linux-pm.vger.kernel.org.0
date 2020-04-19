Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5069A1AFC4E
	for <lists+linux-pm@lfdr.de>; Sun, 19 Apr 2020 19:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgDSRIO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Apr 2020 13:08:14 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36527 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgDSRIN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Apr 2020 13:08:13 -0400
Received: by mail-oi1-f196.google.com with SMTP id s202so6771979oih.3;
        Sun, 19 Apr 2020 10:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UkOoxFPOZSwtkQ3jPPRPGnUUdj04yB+81AESCw0IP4I=;
        b=MxjFndiCULr5cToRKlFSYNbKYa2z38CdlzvJHpIf86NsRQagAywF68b+hq7N4H/r9j
         lIwXprWfGylya7msYr7HmzGNnIAF39yqowEXQXVsMk2FnPhZWETqAzNnM//wtDSz3vlk
         zb7Sp55LWlIpJMg/2xItOdizhdpdnW89cNT1QBSXpQ5ykgbhdu3PuWxSwDrKOPACDV6C
         4I+F/9h5o5uHpMNh+KQ2U/L+qK24mk+Qz2tOHniMp9hbdRNFhg6mhRc72eV7sNJMPYE2
         WC3agNbAVYe+LO7dlWh/ldUcjFEhv1+kZFOJ2PH+G1j7YjM8FAs25LTu3tT5lfxvF+To
         9J5Q==
X-Gm-Message-State: AGi0PuaCgBfHudKdXm9yOCil2KU10TotreuRgEyP78FGBYWBeV0/baPA
        LRDzoUUARQLE0GfX9qzPlCV2Z78=
X-Google-Smtp-Source: APiQypLvLmvAdngacB2FLvtvW5eNlzo5ELiTv5EubT9pBJI0uhxmO0n9BcSwRiYhZN8jJTtJ8BYXXA==
X-Received: by 2002:aca:ad87:: with SMTP id w129mr7844827oie.173.1587316092388;
        Sun, 19 Apr 2020 10:08:12 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u205sm9661938oia.37.2020.04.19.10.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 10:08:11 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 00/17] Modularizing Versatile Express
Date:   Sun, 19 Apr 2020 12:07:53 -0500
Message-Id: <20200419170810.5738-1-robh@kernel.org>
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

Rob

[1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git vexpress-modules-v3

Rob Herring (17):
  ARM: vexpress: Move vexpress_flags_set() into arch code
  arm64: vexpress: Don't select CONFIG_POWER_RESET_VEXPRESS
  arm64: vexpress: Don't select CONFIG_VEXPRESS_CONFIG
  power/reset: vexpress: Support building as a module
  clk: versatile: Kill CONFIG_COMMON_CLK_VERSATILE
  clk: versatile: Only enable SP810 on 32-bit by default
  clk: vexpress-osc: Use the devres clock API variants
  clk: vexpress-osc: Support building as a module
  mfd: vexpress-sysreg: Drop selecting CONFIG_CLKSRC_MMIO
  mfd: vexpress-sysreg: Drop unused syscon child devices
  mfd: vexpress-sysreg: Use devres API variants
  mfd: vexpress-sysreg: Support building as a module
  bus: vexpress-config: Merge vexpress-syscfg into vexpress-config
  bus: vexpress-config: simplify config bus probing
  vexpress: Move site master init to vexpress-config bus
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
 drivers/bus/Kconfig                      |   2 +-
 drivers/bus/vexpress-config.c            | 354 ++++++++++++++++++-----
 drivers/clk/Makefile                     |   2 +-
 drivers/clk/versatile/Kconfig            |  15 +-
 drivers/clk/versatile/clk-vexpress-osc.c |  20 +-
 drivers/mfd/Kconfig                      |   5 +-
 drivers/mfd/vexpress-sysreg.c            |  99 +------
 drivers/misc/Kconfig                     |   9 -
 drivers/misc/Makefile                    |   1 -
 drivers/misc/vexpress-syscfg.c           | 280 ------------------
 drivers/power/reset/Kconfig              |   2 +-
 drivers/power/reset/vexpress-poweroff.c  |  10 +-
 include/linux/vexpress.h                 |  30 --
 21 files changed, 338 insertions(+), 526 deletions(-)
 delete mode 100644 drivers/misc/vexpress-syscfg.c

--
2.20.1
