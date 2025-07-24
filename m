Return-Path: <linux-pm+bounces-31366-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA9FB107A6
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 12:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B194516782C
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 10:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1530264612;
	Thu, 24 Jul 2025 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPbDDm+c"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89072263F34;
	Thu, 24 Jul 2025 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753352738; cv=none; b=MjRLXc8aBRo1qM+y1I8Onqmg/lRAkGv/16khtqIxVyj1/bp9DbXM05x54EMOIf9GnLHndJeuAOyBEXOpSe1B/bhSmn83R9j1f3fGT5Nm3ndvAZfqLmXnTXEl58QjpCggMMS6fMkMD/y9B+xkzxuRNzadSUpuRuTbUS2n9jBmTCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753352738; c=relaxed/simple;
	bh=HBCOj9X488KZ8EnGV22QDU0a1yTLfx7WU/YCXnS4Ax4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zk44QAbpNXfGS8T6dJGiDXIKaTxPMrn6ird7dd5Pe97Dv/jkSOBGCzS5zzmhH1WNiq8CUjIyF6Z2jBVz+8BDYh2eNhdREeo3xmMTT6EAKaiFrVptsOMJyPwXYE7BJilbc/oIoKOwA0S6aUOxwdPoUq1WsFTk9YeISkKNW/FvwDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPbDDm+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365DFC4CEED;
	Thu, 24 Jul 2025 10:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753352738;
	bh=HBCOj9X488KZ8EnGV22QDU0a1yTLfx7WU/YCXnS4Ax4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kPbDDm+cRKEYAvRaF8+5CoNKgi462vLKxYcf7h6hZqkKxCZ4WGm1og6XBGIc15S/D
	 EVIzQrKrcGrW2SVFWz5Qx2Bcs5DjbpxtwJFnHgCet7z9MZw6a3zxSl8XgA++3EP1j0
	 UWnS2CUOzhpZs3voKHDB68vzCZIlBdlKWhb8gFxnChP9G1Lz2wsxmmIS6Msfml3x2Z
	 0rN5W0pxqizWkRG+bW6koilrIHglKTNXrtMdBAUjpjr8bBpN+G6VWXofw7Z2gVMg8C
	 Z9ObT3bvh8tC/jDx6x5x8qqIByhwARzYS7AGb1yDw4QYz60E1JlKaEP4nhrvblDbSE
	 ffqY0R+I37a1w==
Date: Thu, 24 Jul 2025 11:25:29 +0100
From: Lee Jones <lee@kernel.org>
To: Sven Peter <sven@kernel.org>
Cc: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Marc Zyngier <maz@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [GIT PULL] Immutable branch between MFD, GPIO, Power and SoC due for
 the v6.17 merge window
Message-ID: <20250724102529.GA11056@google.com>
References: <20250610-smc-6-15-v7-0-556cafd771d3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250610-smc-6-15-v7-0-556cafd771d3@kernel.org>

Enjoy!

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-gpio-power-soc-v6.17

for you to fetch changes up to 819687eb28e501d21dabd6a3f52454638a815071:

  power: reset: macsmc-reboot: Add driver for rebooting via Apple SMC (2025-07-24 09:47:33 +0100)

----------------------------------------------------------------
Immutable branch between MFD, GPIO, Power and SoC due for the v6.17 merge window

----------------------------------------------------------------
Hector Martin (2):
      gpio: Add new gpio-macsmc driver for Apple Macs
      power: reset: macsmc-reboot: Add driver for rebooting via Apple SMC

Russell King (Oracle) (2):
      dt-bindings: gpio: Add Apple Mac SMC GPIO block
      dt-bindings: mfd: Add Apple Mac System Management Controller

Sven Peter (3):
      dt-bindings: power: reboot: Add Apple Mac SMC Reboot Controller
      soc: apple: rtkit: Make shmem_destroy optional
      mfd: Add Apple Silicon System Management Controller

 .../devicetree/bindings/gpio/apple,smc-gpio.yaml   |  29 ++
 .../devicetree/bindings/mfd/apple,smc.yaml         |  79 ++++
 .../bindings/power/reset/apple,smc-reboot.yaml     |  40 ++
 MAINTAINERS                                        |   7 +
 drivers/gpio/Kconfig                               |  10 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-macsmc.c                         | 292 ++++++++++++
 drivers/mfd/Kconfig                                |  18 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/macsmc.c                               | 498 +++++++++++++++++++++
 drivers/power/reset/Kconfig                        |   9 +
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/macsmc-reboot.c                | 290 ++++++++++++
 drivers/soc/apple/rtkit.c                          |   3 +-
 include/linux/mfd/macsmc.h                         | 279 ++++++++++++
 15 files changed, 1555 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/apple,smc-gpio.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/apple,smc.yaml
 create mode 100644 Documentation/devicetree/bindings/power/reset/apple,smc-reboot.yaml
 create mode 100644 drivers/gpio/gpio-macsmc.c
 create mode 100644 drivers/mfd/macsmc.c
 create mode 100644 drivers/power/reset/macsmc-reboot.c
 create mode 100644 include/linux/mfd/macsmc.h

-- 
Lee Jones [李琼斯]

