Return-Path: <linux-pm+bounces-28394-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85660AD3E66
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 18:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C5D33A5467
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 16:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0016A23D290;
	Tue, 10 Jun 2025 16:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5/9TmYS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4CB1EFFB0;
	Tue, 10 Jun 2025 16:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749571839; cv=none; b=umITsl5VD3+4RZGMZUazjo8qbGt8kxhWudI64KGe8JBXHRpIsTZ1erZmJ4N2oIX4jLcyjpJEQxKPQ1yj+UIe3JbDpZbWJVmYLTby+MGGr+ZvPbJ4fM8LysClA5fxjp5gflxJ+ASaA9fg37t8+6EmaPJ5TWch57v+fXycHeZl2yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749571839; c=relaxed/simple;
	bh=G6G21+hjtH2bOLL4/jVWPD0fGJK8bLCuFpdREfk6nLY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oEvPivRJO26/NTuCpe3l8h0ze/fgs2BUmZSomiPUBhq84ssqTyIZ7A8MaD5tzJVDlX4mF6hEMu/9C16C1rCZneCkLpMvXtZipfVOWqzPHOcGfODzsLe+Fvxh2+LQgnr7X4jQTkTLfmFjJmfgjON4AaSKD7JQJSwQsmOH+1w1zuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5/9TmYS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F741C4CEED;
	Tue, 10 Jun 2025 16:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749571839;
	bh=G6G21+hjtH2bOLL4/jVWPD0fGJK8bLCuFpdREfk6nLY=;
	h=From:Subject:Date:To:Cc:From;
	b=O5/9TmYSjJU98jFm0Hr5jzKvMsR34UKTRzurHNRgQBuLfAf7E2dJkedoW3KLLvV6x
	 TpCZQQ5twrq6JCGod5u1/OPwRkwRFoC6rw52t+wg9Xki0A+Xplhf4FEDuJwE4/7APF
	 ab2tiW34uoU9MqmHd3eJbtUnUa8vpfODrvPQK6mSSAg5IhiPpIaYhvQVubPS4wrCXu
	 citu/41eVkSbDgfjSreKjNDWPH75EieKNObFTZ8VSkBUfMOjbx4CXbUCR4tQewUv6B
	 LCxDDThyeMEmB0QS6aK3QB5KERDwLgm/fCs20gZM+jflXsfkHfeg9DLtz9HELBTDVF
	 jL6P0kvs+rg/g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353DBC5B543;
	Tue, 10 Jun 2025 16:10:39 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Subject: [PATCH v7 00/10] Apple Mac System Management Controller
Date: Tue, 10 Jun 2025 15:29:41 +0000
Message-Id: <20250610-smc-6-15-v7-0-556cafd771d3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGVPSGgC/23MQQ6CMBCF4auYrq2ZQqeAK+9hXNB2Kl0IpCWNh
 nB3Cy4kxuWbzPfPLFLwFNn5MLNAyUc/9HlUxwMzXdvfiXubNyugQChB8vgwXHGB3AFZJRoqhZU
 sv4+BnH9uqest787HaQivrZzkev1EcuYbSZIDRwDdaIVSOXOJifqRJgonS4mtoYQ7LMQOY8YOm
 xq01aLW9h9We4w7rDI2stKCnNTQ0i9eluUNRgkYQh4BAAA=
X-Change-ID: 20250304-smc-6-15-f0ed619e31d4
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Hector Martin <marcan@marcan.st>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Lee Jones <lee@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6948; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=G6G21+hjtH2bOLL4/jVWPD0fGJK8bLCuFpdREfk6nLY=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ4aHf0FJdtfeqBvX28XU5QL+651omvHsbNX/I3P/xFZaM
 780PFfSUcrCIMbBICumyLJ9v73pk4dvBJduuvQeZg4rE8gQBi5OAZjIxUsM/0yKbl/d8an3p3rL
 5CcJLXWqNj+XL4pw+xfbf3yDpueqeWsYGTpexL9982FZLH/6F3Emp4MtUwrbNd8U3jbKnKD357t
 yKhMA
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

Hi,

This series adds support for the System Management Controller found in
Apple Silicon devices which we model as a mfd. It also includes support
for the GPIO block and the power/reset block as sub-devices.

Changes between v6 and v7:
  - Rebased on 6.16-rc1
  - Dropped mfd- prefix from the macsmc driver name
  - Removed the check if the MBSE key exists in the reboot driver since
    we can rely on the device tree now
  - Changed my mail address to kernel.org

Changes between v5 and v6:
  - Actually reorder struct members this time, start comments with an
    uppercase letter, and use devm_ for mfd_register_devices instead of
    dropping those fixup commits by accident
  - Stefan's comment: Renamed ret to bfr in the reboot driver
  - Sebastian's comments on the reboot driver:
    - Moved Kconfig dependencies to MFD device and made reboot only
      depend on that one
    - Removed sysfs file to configure "reboot after power loss" for now
      since this probably belongs in a userspace tool that directly
      writes to nvmem instead
    - Dropped setting pdev->dev.of_node since that's already done
      automatically and adjusted #include to linux/mod_devicetable.h
    - Dropped MODULE_ALIAS which was probably a leftover from a previous
      version that did not use of_match_table
  - Rob's comments to the dt-bindings
    - Removed examples from sub-devices and added them to the main smc
      binding
    - Removed a spurious |

Changes between v4 and v5:
  - Alyssa's comments:
    - Made the WARN_ON in the reboot driver more obvious
    - Added missing brackets around a for loop in the reboot driver
    - Used min instead of open-coded variant inside the gpio driver
    - Reoder struct memebers to prevent padding inside the mfd driver
  - Lee's comments:
    - All comments now start with an uppercase letter
    - Removed apple_smc_read_ioft_scaled and apple_smc_read_f32_scaled
      since these are not yet used and likely don't belong into
      drivers/mfd
    - Relaced if (ret != 0) with if (ret) when possible
    - Used devm_platform_get_and_ioremap_resource to get and map the
      SRAM resource
    - Used reverse Christmas-tree formating when declaring variables
    - Dropped _platform left-overs from probe and remove functions
    - Removed dev_dbg prints which are no long required after
      development
    - Reworked is_alive/is_initialized so that it's obvious how errors
      during boot are propagated from the callback to the probe function
    - Used dev_warn instead of dev_err in a few places
    - Removed no-op apple_smc_rtkit_shmem_destroy; this required an
      additional change in rtkit.c because we had a check there that's a
      bit too strict
    - Removed struct resource in apple_smc_rtkit_shmem_setup and
      open-coded resource_contains instead
    - Unwrapped lines with less than 100 chars
    - Made sure to compile with W=1 and ran scripts/kernel-doc -v
      on macsmc.h once and fixed any fallout
  - Removed first_key/last_key from struct smc and moved
    apple_smc_find_first_key_index to the gpio driver since it's only
    used there anyway to find the index of the first GPIO key (gP00)
  - Return -EIO when a command fails instead of whatever SMC returns
    which does not map to Linux errnos on errors

Changes between v3 and v4:
  - Added documentation for all functions and structs
  - Fixed dt-bindings and re-ordered commits so that the mfd one comes
    last and can include the gpio subdevice
  - Added the reset driver and corresponding bindings
  - Reworked the atomic mode inside SMC since the previous implementation
    called mutex_lock from atomic context
  - Removed the backend split for now which lead to a quite intense discussion
    for the previous versions which hadn't been solved as far as I could tell
    from the old threads.
    It's also been 2+ years and I haven't heard of any backend implementation
    for T2 or even older macs. It's also unclear to me which sub-devices
    are actually useful there because at least GPIO and shutdown/reboot
    from this series will not work as-is there.
    I'd rather have this initial version which only supports M1+ macs upstream
    and then iterate there if any other backend is developed.
    I'll gladly help to re-introduce backend support if it's ever required.

v6: https://lore.kernel.org/asahi/20250515-smc-6-15-v6-0-c47b1ef4b0ae@svenpeter.dev/
v5: https://lore.kernel.org/asahi/20250511-smc-6-15-v5-0-f5980bdb18bd@svenpeter.dev/
v4: https://lore.kernel.org/asahi/20250503-smc-6-15-v4-0-500b9b6546fc@svenpeter.dev/
v3: https://lore.kernel.org/asahi/Y2qEpgIdpRTzTQbN@shell.armlinux.org.uk/
v2: https://lore.kernel.org/asahi/YxdInl2qzQWM+3bs@shell.armlinux.org.uk/
v1: https://lore.kernel.org/asahi/YxC5eZjGgd8xguDr@shell.armlinux.org.uk/

Best,

Sven

---
Hector Martin (5):
      gpio: Add new gpio-macsmc driver for Apple Macs
      power: reset: macsmc-reboot: Add driver for rebooting via Apple SMC
      arm64: dts: apple: t8103: Add SMC node
      arm64: dts: apple: t8112: Add SMC node
      arm64: dts: apple: t600x: Add SMC node

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
 arch/arm64/boot/dts/apple/t600x-die0.dtsi          |  35 ++
 arch/arm64/boot/dts/apple/t8103.dtsi               |  35 ++
 arch/arm64/boot/dts/apple/t8112.dtsi               |  35 ++
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
 18 files changed, 1660 insertions(+), 2 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250304-smc-6-15-f0ed619e31d4

Best regards,
-- 
Sven Peter <sven@kernel.org>



