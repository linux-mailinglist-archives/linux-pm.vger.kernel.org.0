Return-Path: <linux-pm+bounces-22658-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B07A3FA8B
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 17:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154D24426B8
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 16:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B2B20CCF4;
	Fri, 21 Feb 2025 16:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9ky2b6a"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E6E1EBA14;
	Fri, 21 Feb 2025 16:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153809; cv=none; b=Af+STjCDiy+btnFJIPKepoIH0r8ZaqA8cJ9HbWAuLFP1hKdE9gZPJVyPGHNMscINLXV29aVF2hP+QB+wq2grS/zWwYKt+eYV6+AZ+wDZ7rk1uZE1JIDotBODV1r7rQKTfsSzF7omgUSl8D1UFipwwwbDdrIfXHpiG6ERttiOZd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153809; c=relaxed/simple;
	bh=LclqReflO2tGzw33tF/ps3Kyb0oFA93UVfVnH0V8JCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6KwJFzbYAudapzQD41nuCQkm4GTQSxNH9PV4YcHoIS9IWtHmaiWLs+RvGo5MOFYz9OxGALSqxwshvDFmMei5oRPvj8dwKWzojTRI4pMpDZuhYYzfB2m0dRHNsUUrpIzgMCj0Y/Cyu+rQ2h8V95YLZBhJtCgqe/OteyPr8TWAdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9ky2b6a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4DCC4CED6;
	Fri, 21 Feb 2025 16:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740153809;
	bh=LclqReflO2tGzw33tF/ps3Kyb0oFA93UVfVnH0V8JCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z9ky2b6aFfaWFuN7W9X4tHxmNSwKIfI7KNaXLJTAOoGsU0zfXloi5LMuxani8P7Gk
	 +V7rhWSbe6zbftjcnj3QBKnUOSYeyMKkd4kAI+knzSAod1nlDKBGBp+/pytgh/wHsi
	 knqjuG52ZtxQWnfEb526TbdoYwcHUAof5D59eRGSXDnZVcA9tgVdYW33K8n++Wvaxk
	 X92VgjNBsv3nxa+y89M4ifD6jB5F1dAaC0ePclV2w+Rt91l22aEKzMbJ2jfSZeR2/4
	 Bcb7ItLXJn3B/5+EjTYn64Pn8DnoDTa8qwYg7X7EtIXC2RwPWszhZEATOQhlimg8V5
	 mjDLj9XH5osTw==
Date: Fri, 21 Feb 2025 16:03:22 +0000
From: Lee Jones <lee@kernel.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [GIT PULL] Immutable branch between MFD, Input, LEDs and Power due
 for the v6.15 merge window
Message-ID: <20250221160322.GE824852@google.com>
References: <20250123-starqltechn_integration_upstream-v17-0-8b06685b6612@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250123-starqltechn_integration_upstream-v17-0-8b06685b6612@gmail.com>

Enjoy!

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-input-leds-power-v6.15

for you to fetch changes up to aebb5fc9a0d87916133b911e1ef2cc04a7996335:

  leds: max77705: Add LEDs support (2025-02-20 16:38:37 +0000)

----------------------------------------------------------------
Immutable branch between MFD, Input, LEDs and Power due for the v6.15 merge window

----------------------------------------------------------------
Dzmitry Sankouski (7):
      dt-bindings: power: supply: add maxim,max77705 charger
      dt-bindings: mfd: Add maxim,max77705
      power: supply: max77705: Add charger driver for Maxim 77705
      mfd: simple-mfd-i2c: Add MAX77705 support
      mfd: Add new driver for MAX77705 PMIC
      Input: max77693 - add max77705 haptic support
      leds: max77705: Add LEDs support

 .../devicetree/bindings/mfd/maxim,max77705.yaml    | 158 ++++++
 .../bindings/power/supply/maxim,max77705.yaml      |  50 ++
 MAINTAINERS                                        |   4 +
 drivers/input/misc/Kconfig                         |   6 +-
 drivers/input/misc/max77693-haptic.c               |  13 +-
 drivers/leds/Kconfig                               |   8 +
 drivers/leds/Makefile                              |   1 +
 drivers/leds/leds-max77705.c                       | 275 ++++++++++
 drivers/mfd/Kconfig                                |  13 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/max77705.c                             | 182 +++++++
 drivers/mfd/simple-mfd-i2c.c                       |  11 +
 drivers/power/supply/Kconfig                       |   6 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/max77705_charger.c            | 581 +++++++++++++++++++++
 include/linux/mfd/max77693-common.h                |   4 +-
 include/linux/mfd/max77705-private.h               | 195 +++++++
 include/linux/power/max77705_charger.h             | 195 +++++++
 18 files changed, 1699 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max77705.yaml
 create mode 100644 drivers/leds/leds-max77705.c
 create mode 100644 drivers/mfd/max77705.c
 create mode 100644 drivers/power/supply/max77705_charger.c
 create mode 100644 include/linux/mfd/max77705-private.h
 create mode 100644 include/linux/power/max77705_charger.h

-- 
Lee Jones [李琼斯]

