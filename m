Return-Path: <linux-pm+bounces-26616-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB47AA7FE0
	for <lists+linux-pm@lfdr.de>; Sat,  3 May 2025 12:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6575D4602A2
	for <lists+linux-pm@lfdr.de>; Sat,  3 May 2025 10:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E05B1E32D5;
	Sat,  3 May 2025 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3M6XbVd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469201CEAC2;
	Sat,  3 May 2025 10:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746266836; cv=none; b=qYpfhZVOZIZrU5Q2oz8SNubTikielyy1CdllXZcMGED5h7qKk+k/HhbdVIDCKRkdBZJAwZEXtNLFvKAyr/hwM7HuE9MLPIgZo2kd3h7RrWqiTKgegRg60qhJhS+tj6yjZNKm7/gmb5U34ruwkS07txDBDCelBLbOYp1oiB8oVvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746266836; c=relaxed/simple;
	bh=A6sW0fHhezyvxJw0ueUn7VDzoKCJ4EosNM854fVXIRc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U0tceK80ZPtvucbji3l0LB2DzD60Arrgi4fy1+Tg1uSgaMqlicAhq+1FAP/V08GTJsdT6thVOEgiUBTklkclEWBjXUfmMcYd+9S0jxj9W5iVEAI3JbbuDo93M9SL88ulrKzy6WSTYlqnzpZzvNjURwbGHAztH0kragd8j8EMzi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3M6XbVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABDFAC4CEE3;
	Sat,  3 May 2025 10:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746266835;
	bh=A6sW0fHhezyvxJw0ueUn7VDzoKCJ4EosNM854fVXIRc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=q3M6XbVdckVpk5+qHUzI31GMalJN/2cH4nN547PXyZB5CWWbcEmfukrzzDd5zfoQd
	 rciN7vaEfgXM1KAf7icrGA+/mH9K3j/q6O3ihl4q5B7bAQs0GdM39ZnhPko1GuMwfR
	 q29Ad/fSPKfpSjGbYOkhD/utaMob1mxdxZCRhhUZgAZcuU1JGumBOKNhdNc7uL8YqX
	 AWuHM19PbgwH29+Rq5FnSo+45Cn7Ld/xoT2tSKYPHERRcY/LGeTceIcXMvBZ/ytWHJ
	 xWS6IuHvc+rGCcyNJ7ZY4ErKt+AcWojIi48AMEhSFbv3MEoyRStq186ZpR0JAleQDP
	 XgJmL+tDez3Xg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988CCC369D9;
	Sat,  3 May 2025 10:07:15 +0000 (UTC)
From: Sven Peter via B4 Relay <devnull+sven.svenpeter.dev@kernel.org>
Subject: [PATCH v4 0/9] Apple Mac System Management Controller
Date: Sat, 03 May 2025 10:06:47 +0000
Message-Id: <20250503-smc-6-15-v4-0-500b9b6546fc@svenpeter.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALfqFWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHQUlJIzE
 vPSU3UzU4B8JSMDI1MDYwMT3eLcZF0zXUNT3TSD1BQzQ8tUY8MUEyWg8oKi1LTMCrBR0bG1tQA
 Ek3W/WgAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4267; i=sven@svenpeter.dev;
 h=from:subject:message-id;
 bh=A6sW0fHhezyvxJw0ueUn7VDzoKCJ4EosNM854fVXIRc=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ4boq0N7VfUk+HOu9n5tUfVrDzzUWbhHOXfvjIrjV9t+r
 bmcH87TUcrCIMbBICumyLJ9v73pk4dvBJduuvQeZg4rE8gQBi5OAZhI61JGhvbsBZzL3Nfuexwz
 f+s5qXfXdjc/2ioW+epGWmng1aCPwWqMDKeYWrwfNV2a32pislHjxtaobe75f0/bPzc8HRhV+Uj
 lISMA
X-Developer-Key: i=sven@svenpeter.dev; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@svenpeter.dev/default with
 auth_id=167
X-Original-From: Sven Peter <sven@svenpeter.dev>
Reply-To: sven@svenpeter.dev

Hi,

It's been quite a while (end of 2022) since the last version of this
series was sent by Russel. I'd like to pick this up again and get SMC
upstream.

I've taken the last version from the ML and worked in the review
comments and some other changed:

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
https://github.com/AsahiLinux/linux/commits/sven/smc-v4/.

Merging:
The dt-binding patches all depend on each other such that they all
should probably go together with the mfd device itself.
The following commits also depend on mfd due to the new header file and
will either have to go through the mfd tree as well or we'll need an
immutable branch there.
I'll take the device tree updates through our tree which also has the
previous device tree updates these depend on.

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

Sven Peter (2):
      dt-bindings: power: reboot: Add Apple Mac SMC Reboot Controller
      mfd: Add Apple Silicon System Management Controller

 .../devicetree/bindings/gpio/apple,smc-gpio.yaml   |  37 ++
 .../devicetree/bindings/mfd/apple,smc.yaml         |  71 +++
 .../bindings/power/reset/apple,smc-reboot.yaml     |  52 ++
 MAINTAINERS                                        |   7 +
 arch/arm64/boot/dts/apple/t600x-die0.dtsi          |  35 ++
 arch/arm64/boot/dts/apple/t8103.dtsi               |  35 ++
 arch/arm64/boot/dts/apple/t8112.dtsi               |  35 ++
 drivers/gpio/Kconfig                               |  10 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-macsmc.c                         | 246 ++++++++
 drivers/mfd/Kconfig                                |  15 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/macsmc.c                               | 657 +++++++++++++++++++++
 drivers/power/reset/Kconfig                        |  11 +
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/macsmc-reboot.c                | 362 ++++++++++++
 include/linux/mfd/macsmc.h                         | 337 +++++++++++
 17 files changed, 1913 insertions(+)
---
base-commit: 8b7e6734e2231a549a23943678ee3452bd19a1fe
change-id: 20250304-smc-6-15-f0ed619e31d4

Best regards,
-- 
Sven Peter <sven@svenpeter.dev>



