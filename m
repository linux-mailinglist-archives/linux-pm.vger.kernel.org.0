Return-Path: <linux-pm+bounces-27175-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6724AB7DC0
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 08:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9002F4A54FB
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 06:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27221296705;
	Thu, 15 May 2025 06:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csVn2Z6A"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBF328153C;
	Thu, 15 May 2025 06:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747290134; cv=none; b=DEYcANiIV5dZcDbew8pKTOzE+V6XeqGNRx6SnVt+RnbE5QA0y7FTvkJjgss2owOQk5FJkeisKkrdeVAri90ErPmKE5dP4r7UVqdTb05q/Vu9WSrMWSyZgqlbF0j/QWVM5+d+dimIJuxC2VA/2FddrFPk3RMQpVbpaZC8EPV/bkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747290134; c=relaxed/simple;
	bh=4zeGaBUvC1Q9ojCS6BwilpI7jNLQBxZR8OQzD04olA4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aZlcfSXT5CbRIMu7VzrNjfVnNpoYKAF8GFVGRQPClmxVNhYzNp9GV5h7mUUIWkabRUK8jOmu50bMLTGwCQfKnvfqfkfF2ql9TVyPeEmwz4hqrZeRbpaJgW4A88XU4hMx6wQx0KC0J63X0maijNprTSJudN2XXvgkDfLeYTYyWjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csVn2Z6A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2371DC4CEE7;
	Thu, 15 May 2025 06:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747290134;
	bh=4zeGaBUvC1Q9ojCS6BwilpI7jNLQBxZR8OQzD04olA4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=csVn2Z6A8Sl3SqKO3MI5MubdJCB8umTAnTFO5SMw/elfFoZzdsYdpt/RDZBpzTS+D
	 b750TEKmduBW/BRISjdWknmxjvrJAYeRR44lbMSBNOUpiYAsSnBENfmfAX3ObU7JVQ
	 eNW5xm5MtIbtcwh1+Z7tidGqaTMKf9Iqz2SRS7bDVweaSYrkAilHX91qq8m+CeeUiQ
	 RNHfqKizr6VUkCFuk6znR7+3fICDvCWnHSYmIugJsJl+3L+WwdHZX9flrmZvjfN9Sg
	 n6So2U4wZNplCdbAxlEe+FGj0Tz64KBRC80c7riOnfTgdIGurersTsNtpn4AP0Od6A
	 QJMsL2mWgXgPA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C3EC2D0CD;
	Thu, 15 May 2025 06:22:14 +0000 (UTC)
From: Sven Peter via B4 Relay <devnull+sven.svenpeter.dev@kernel.org>
Subject: [PATCH v6 00/10] Apple Mac System Management Controller
Date: Thu, 15 May 2025 06:21:12 +0000
Message-Id: <20250515-smc-6-15-v6-0-c47b1ef4b0ae@svenpeter.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANmHJWgC/13MQQ6CMBCF4auQWVszhU4DrriHcWHpVLoQSEsaD
 eHuFlxIXL7J/N8CkYPnCJdigcDJRz8OeehTAV1/Hx4svM0bSiwJK1QiPjuhhSThkK2WDVfSKsj
 vU2DnXzt1veXd+ziP4b3LSW3XL5KZH5KUQEGIpjGalHZdGxMPE88czpYTbFCiQyzlIaYcO2pqN
 NbI2tj/eF3XD+K8fWjhAAAA
X-Change-ID: 20250304-smc-6-15-f0ed619e31d4
To: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
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
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7511; i=sven@svenpeter.dev;
 h=from:subject:message-id;
 bh=4zeGaBUvC1Q9ojCS6BwilpI7jNLQBxZR8OQzD04olA4=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ4ZqB1vgt88/QjfM+n7KTPLoEil3G/Gj/DdOiTiFbHRXb
 +BXtbzZUcrCIMbBICumyLJ9v73pk4dvBJduuvQeZg4rE8gQBi5OAZhI+RKG/2GGJdFRj9jNJ55j
 9PSXe3i7dBmTxo+YV0G7/W+y2gQe3c/w3z28aVtD+4H+FX17jrrN3eP3p0Neq+tAh/LX2mX6/eu
 aOQA=
X-Developer-Key: i=sven@svenpeter.dev; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@svenpeter.dev/default with
 auth_id=167
X-Original-From: Sven Peter <sven@svenpeter.dev>
Reply-To: sven@svenpeter.dev

Hi,

This series adds support for the System Management Controller found in
Apple Silicon devices which we model as a mfd. It also includes support
for the GPIO block and the power/reset block as sub-devices.

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

Dependencies:
The code and dt-bindings themselves apply cleanly to 6.15-rc1 but
the device tree changes require the already merged SPMI controller
and SPMI NVMEM series which will be part of 6.16.
The series is also using the printf format specifiers which will
land in 6.16 via the drm-misc tree.
A tree with all dependencies for testing is available at
https://github.com/AsahiLinux/linux/commits/smc-v6/.

Merging:
The dt-binding patches all depend on each other such that they all
should probably go together with the mfd device itself.
The following commits also depend on mfd due to the new header file and
will either have to go through the mfd tree as well or we'll need an
immutable branch there or we just wait one kernel release and I'll
re-submit the rest then.
I'll take the device tree updates through our tree which also has the
previous device tree updates these depend on.

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
 drivers/power/reset/macsmc-reboot.c                | 294 ++++++++++++
 drivers/soc/apple/rtkit.c                          |   3 +-
 include/linux/mfd/macsmc.h                         | 279 ++++++++++++
 18 files changed, 1664 insertions(+), 2 deletions(-)
---
base-commit: 5abab6ab4ebacfff5857b63bd349902a6568d2e8
change-id: 20250304-smc-6-15-f0ed619e31d4

Best regards,
-- 
Sven Peter <sven@svenpeter.dev>



