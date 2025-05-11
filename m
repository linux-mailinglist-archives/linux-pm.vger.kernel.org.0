Return-Path: <linux-pm+bounces-26994-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BB8AB2726
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 10:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8F5C1899FAE
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 08:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2E71ACED3;
	Sun, 11 May 2025 08:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7Ma8ohw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7A32F872;
	Sun, 11 May 2025 08:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746951549; cv=none; b=Or/abx+nVqc9Wm5/mcUWsasWTpsuQD6cVkPhbUvyRuM6xDVJ+OJ8nSrTVcPIfA5Wd+NvaiBgOlqyxa0zrVGqbQqkQAzWRcs9Qc5TDuVqT2XzDv0Tms3XDoXRotj+/HDfqZJtL6yclQBV8j5f8SW7l8NWBfftiOlV6XVF+c6DNuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746951549; c=relaxed/simple;
	bh=AN3OnTybScRz8x1B3JwySPq8GXU7Hvcbq2tPBjfW/n0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GyaE1LRO3ovKrM7P74GYIYYisXDHSWLGZY5it2NUMz9K4sb+t0aHd+MaFi3CgTIKa08jiv8qIvOOhc3HKHHNC0h0RD/OOWNaZOoI0SR7WXS7ilvVAC2+WjpBq4ZophpqzryDppAp5JhR/xxEiwgIK7DxA4qncnumqVDInmKcl9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7Ma8ohw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB36EC4CEE4;
	Sun, 11 May 2025 08:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746951549;
	bh=AN3OnTybScRz8x1B3JwySPq8GXU7Hvcbq2tPBjfW/n0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=q7Ma8ohwFoDUrmJDzDIFxmQ6Fsd8YeUZ0BhnqbttPT0q+UrhXeiXTcaGcxl8Ea61r
	 IS+nMNFgDIGykTm1weLFgy5BYrMYaIrTBBRe4tuCBtph0tEAus6Vt5J4YKZIE8+z0V
	 LOVJDISNfQWsM/REfEz4VnwyG6gwjsZPm1FSR2boit9N4K/Qj+rn3NEL5MaadGvOrm
	 yzxLsmpUIwDWHCJ8HfKc82z9nAcWtYlOUcWg6z5ezZZO/WF3x/5v92VcaIrNcXEznw
	 EBp122VDudfBrXC+D3eESN8aoW8uu5P3Skn08EJ1KiwRjtgC/ii3sLRJ5f004mc6Lx
	 YkXWcT/tdunRw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4320C3ABC3;
	Sun, 11 May 2025 08:19:08 +0000 (UTC)
From: Sven Peter via B4 Relay <devnull+sven.svenpeter.dev@kernel.org>
Subject: [PATCH v5 00/10] Apple Mac System Management Controller
Date: Sun, 11 May 2025 08:18:35 +0000
Message-Id: <20250511-smc-6-15-v5-0-f5980bdb18bd@svenpeter.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFtdIGgC/0XMQQ6CMBCF4auQWTtmgLYJrryHYSHtVGZhIS1pN
 KR3t+LC5f/y8u2QOAonuDQ7RM6SZAk19KkBO9/Dg1Fcbeio09STwvS0aLDV6ImdaQfuW6eg3tf
 IXl4HdRtrz5K2Jb4POavv+kMq80eyQkJNNA2T0cp4e02Zw8obx7PjDGMp5QNSkX/ipAAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6421; i=sven@svenpeter.dev;
 h=from:subject:message-id;
 bh=AN3OnTybScRz8x1B3JwySPq8GXU7Hvcbq2tPBjfW/n0=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ4ZCbP76RVVTdtyuPLtryc3W9mPHL8iuPXfiS9z/ttADf
 6MV1mgwdZSyMIhxMMiKKbJs329v+uThG8Glmy69h5nDygQyhIGLUwAmolrIyPCBZf+EH2G/FDyP
 cx97lqOvuPXdAubPb2rLN8Wl/DKc22vD8FfwXeDTj26HLNSO1Fs/u7rk+4uKjR5uve8ndehxm9j
 UlfACAA==
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
https://github.com/AsahiLinux/linux/commits/sven/smc-v5/.

Merging:
The dt-binding patches all depend on each other such that they all
should probably go together with the mfd device itself.
The following commits also depend on mfd due to the new header file and
will either have to go through the mfd tree as well or we'll need an
immutable branch there or we just wait one kernel release and I'll
re-submit the rest then.
I'll take the device tree updates through our tree which also has the
previous device tree updates these depend on.

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

 .../devicetree/bindings/gpio/apple,smc-gpio.yaml   |  37 ++
 .../devicetree/bindings/mfd/apple,smc.yaml         |  71 +++
 .../bindings/power/reset/apple,smc-reboot.yaml     |  52 +++
 MAINTAINERS                                        |   7 +
 arch/arm64/boot/dts/apple/t600x-die0.dtsi          |  35 ++
 arch/arm64/boot/dts/apple/t8103.dtsi               |  35 ++
 arch/arm64/boot/dts/apple/t8112.dtsi               |  35 ++
 drivers/gpio/Kconfig                               |  10 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-macsmc.c                         | 293 ++++++++++++
 drivers/mfd/Kconfig                                |  15 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/macsmc.c                               | 506 +++++++++++++++++++++
 drivers/power/reset/Kconfig                        |  11 +
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/macsmc-reboot.c                | 363 +++++++++++++++
 drivers/soc/apple/rtkit.c                          |   3 +-
 include/linux/mfd/macsmc.h                         | 277 +++++++++++
 18 files changed, 1751 insertions(+), 2 deletions(-)
---
base-commit: 5abab6ab4ebacfff5857b63bd349902a6568d2e8
change-id: 20250304-smc-6-15-f0ed619e31d4

Best regards,
-- 
Sven Peter <sven@svenpeter.dev>



