Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A291422D6C
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 18:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbhJEQLP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 12:11:15 -0400
Received: from marcansoft.com ([212.63.210.85]:46704 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235543AbhJEQLP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 5 Oct 2021 12:11:15 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 55D26419B4;
        Tue,  5 Oct 2021 15:59:41 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH 0/7] Apple SoC PMGR device power states driver
Date:   Wed,  6 Oct 2021 00:59:16 +0900
Message-Id: <20211005155923.173399-1-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series adds the driver for the Apple PMGR device power state
registers. These registers can clockgate and (in some cases) powergate
specific SoC blocks. They also control the reset line, and can have
additional features such as automatic power management.

The current driver supports only the lowest/highest power states,
provided via the genpd framework, plus reset support provided via
the reset subsystem.

Apple's PMGRs (there are two in the T8103) have a uniform register
bit layout (sometimes with varying features). To be able to support
multiple SoC generations as well as express pd relationships
dynamically, this binding describes each PMGR power state control
as a single devicetree node. Future SoC generations are expected to
retain backwards compatibility, allowing this driver to work on them
with only DT changes.

#1-#2: Adds the required device tree bindings
#3: The driver itself.
#4: Somewhat unrelated DT change, but I wanted to get it out of the way
    for #7
#5: Instantiates the driver in t8103.dtsi.
#6: Adds runtime-pm support to the Samsung UART driver, as a first
    consumer.
#7: Instantiates a second UART, to more easily test this.

There are currently no consumers for the reset functionality, so
it is untested, but we will be testing it soon with the NVMe driver
(as it is required to allow driver re-binding to work properly).

Hector Martin (7):
  dt-bindings: arm: apple: Add apple,pmgr binding
  dt-bindings: power: Add apple,pmgr-pwrstate binding
  soc: apple: Add driver for Apple PMGR power state controls
  arm64: dts: apple: t8103: Rename clk24 to clkref
  arm64: dts: apple: t8103: Add the UART PMGR tree
  tty: serial: samsung_tty: Support runtime PM
  arm64: dts: apple: t8103: Add UART2

 .../bindings/arm/apple/apple,pmgr.yaml        |  74 +++++
 .../bindings/power/apple,pmgr-pwrstate.yaml   | 117 ++++++++
 MAINTAINERS                                   |   3 +
 arch/arm64/boot/dts/apple/t8103-j274.dts      |   5 +
 arch/arm64/boot/dts/apple/t8103.dtsi          | 134 ++++++++-
 drivers/soc/Kconfig                           |   1 +
 drivers/soc/Makefile                          |   1 +
 drivers/soc/apple/Kconfig                     |  21 ++
 drivers/soc/apple/Makefile                    |   2 +
 drivers/soc/apple/apple-pmgr-pwrstate.c       | 281 ++++++++++++++++++
 drivers/tty/serial/samsung_tty.c              |  88 +++---
 11 files changed, 690 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
 create mode 100644 Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
 create mode 100644 drivers/soc/apple/Kconfig
 create mode 100644 drivers/soc/apple/Makefile
 create mode 100644 drivers/soc/apple/apple-pmgr-pwrstate.c

-- 
2.33.0

