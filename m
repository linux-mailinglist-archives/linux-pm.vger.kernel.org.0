Return-Path: <linux-pm+bounces-14022-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3775F97547C
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 15:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7625BB27911
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 13:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9827C19CC07;
	Wed, 11 Sep 2024 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5NzTH2Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE9019C56B;
	Wed, 11 Sep 2024 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726062611; cv=none; b=moI9aZSH0d5+8NuhwHFVLj3O2OOVIyAt5WBVWStBxbfoRCqvRgNKO4T/meB45iAu/pLrhJJda7DYXLqULQUEDGplTAO0vEhW7LGKEg4ztpSm1T2bq8MTA5he8iRy865wXebsfkwjc3WjqP0EIsryvgkBqMo0scSWOHVxUu+rVwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726062611; c=relaxed/simple;
	bh=n0w/L13h5KJnUKr29cOQpa9dPb7ua+3fhbtUKOirdl4=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=QrD5Qzvkf45teT0KHQ57wuTzRPfw4+37EgBfTMFfIN0WJvZeJQu+qKMgFF/tT+YrpH8HRnWqZwuZ//h7asETMPczXZgL2lOQFJ+m+boBViPI5BS8r4WDl7ej7R/SsbTC2msIJOZgv9nn5RDVacESIvuSsZAiFwjUnUFG1odJshs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5NzTH2Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1507C4CEC0;
	Wed, 11 Sep 2024 13:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726062610;
	bh=n0w/L13h5KJnUKr29cOQpa9dPb7ua+3fhbtUKOirdl4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=J5NzTH2Zy3vwspTxk1Gx9maokpV8EhTnL1Bo9Swz8iCZNkeFfqz+QsLEfATlGRrpd
	 QC5I6rl891oBKsRSCicf9eSigmUDDlvRHJZsKXRhAncuN0My9XusrLnSY414UkPV2F
	 /i2gHoflMBcomJN0GjCGnm1t//+olscaI6RKu4VdK1apLpNZyTG895i9W5sKWj8BmW
	 SDmoOqYjjcWm8c5c3s0t0ZKFn7vfAG3GRXEYvB3kDrOlfcxtalMc6ic2u8yKriJHrm
	 Yakpvy3JZGd8n4grme4K5vOAxr/hGSG1dysQWbK/AD27EmVmcfXvZyxcLDALOqsbhY
	 OCnFfl0Sqa4bA==
Date: Wed, 11 Sep 2024 08:50:09 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Hector Martin <marcan@marcan.st>, 
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-kernel@vger.kernel.org, Mark Kettenis <kettenis@openbsd.org>, 
 linux-arm-kernel@lists.infradead.org, 
 "Rafael J . Wysocki" <rafael@kernel.org>, Sven Peter <sven@svenpeter.dev>, 
 Conor Dooley <conor+dt@kernel.org>, linux-watchdog@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Will Deacon <will@kernel.org>, 
 Guenter Roeck <linux@roeck-us.net>, Viresh Kumar <viresh.kumar@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, asahi@lists.linux.dev
In-Reply-To: <20240911084353.28888-2-towinchenmi@gmail.com>
References: <20240911084353.28888-2-towinchenmi@gmail.com>
Message-Id: <172606224294.90706.12818129202356312350.robh@kernel.org>
Subject: Re: [PATCH 00/22] Initial device trees for A7-A11 based Apple
 devices


On Wed, 11 Sep 2024 16:40:50 +0800, Nick Chan wrote:
> Hi,
> 
> This series adds device trees for all A7-A11 SoC based iPhones, iPads,
> iPod touches and Apple TVs.
> 
> The following devices has been excluded from this series:
>   - All T2 devices (A10-based): bootloader does not work (yet)
>   - HomePod: Not tested, and it's also a different form factor
> 
> This series supports the following on all devices:
> - SMP (spin-table)
> - UART
> - simple-framebuffer
> - watchdog
> - timer
> - pinctrl
> - AIC interrupts
> 
> The following is supported on A7-A10:
> - gpio-keys
> The buttons on A11 based devices like the iPhone X is a SMC subdevice,
> and cannot be supported in this way.
> 
> The following is supported on A10:
> - cpufreq
> 
> A10(X) has performance and efficiency core pairs that act as single logical
> cores, and only one type of core can be active at a given time. This results
> in a core that suddenly have its capacity lowered in low p-states,
> so the frequencies of the low p-states must be adjusted.
> 
> Patch dependencies:
> - The required AIC patches[1] has been sitting in linux-next since
> next-20240906, through the tip tree.
> - The important serial fixes[2] will go through the samsung tree and should
> be in good shape though those have not been merged.
> - The optional patch to disable 32-bit EL0 on A10(X)[3] has not received
> any comments (v1 or v2).
> 
> Authorship information:
> - The commits to actually add the dts files are mostly made by Konard,
> and Konard's sign-off is added by me with permission. I also updated the
> Konrad's email in the actual dts files. Konrad can confirm this.
> 
> - Everything else is entirely made by me, including the cpufreq additions
> into the dts file for A10.
> 
> [1]: https://lore.kernel.org/asahi/20240901034143.12731-1-towinchenmi@gmail.com
> [2]: https://lore.kernel.org/asahi/20240911050741.14477-1-towinchenmi@gmail.com
> [3]: https://lore.kernel.org/asahi/20240909091425.16258-1-towinchenmi@gmail.com
> 
> Nick Chan
> ---
> 
> Konrad Dybcio (8):
>   arm64: dts: apple: Add A7 devices
>   arm64: dts: apple: Add A8 devices
>   arm64: dts: apple: Add A8X devices
>   arm64: dts: apple: Add A9 devices
>   arm64: dts: apple: Add A9X devices
>   arm64: dts: apple: Add A10 devices
>   arm64: dts: apple: Add A10X devices
>   arm64: dts: apple: Add A11 devices
> 
> Nick Chan (14):
>   dt-bindings: arm: cpus: Add Apple A7-A11 CPU cores
>   dt-bindings: watchdog: apple,wdt: Add A7-A11 compatibles
>   dt-bindings: cpufreq: apple,cluster-cpufreq: Add A10 compatible
>   dt-bindings: pinctrl: apple,pinctrl: Add A7-A11 compatibles
>   dt-bindings: arm: apple: Add A7 devices
>   dt-bindings: arm: apple: Add A8 devices
>   dt-bindings: arm: apple: Add A8X devices
>   dt-bindings: arm: apple: Add A9 devices
>   dt-bindings: arm: apple: Add A9X devices
>   dt-bindings: arm: apple: Add A10 devices
>   dt-bindings: arm: apple: Add A10X devices
>   dt-bindings: arm: apple: Add A11 devices
>   arm64: dts: apple: t8010: Add cpufreq nodes
>   arm64: Kconfig: Update help text for CONFIG_ARCH_APPLE
> 
>  .../devicetree/bindings/arm/apple.yaml        | 160 ++++++++++-
>  .../devicetree/bindings/arm/cpus.yaml         |   6 +
>  .../cpufreq/apple,cluster-cpufreq.yaml        |   4 +-
>  .../bindings/pinctrl/apple,pinctrl.yaml       |   5 +
>  .../bindings/watchdog/apple,wdt.yaml          |   5 +
>  arch/arm64/Kconfig.platforms                  |   4 +-
>  arch/arm64/boot/dts/apple/Makefile            |  52 ++++
>  arch/arm64/boot/dts/apple/s5l8960x-5s.dtsi    |  52 ++++
>  arch/arm64/boot/dts/apple/s5l8960x-air1.dtsi  |  52 ++++
>  arch/arm64/boot/dts/apple/s5l8960x-j71.dts    |  14 +
>  arch/arm64/boot/dts/apple/s5l8960x-j72.dts    |  14 +
>  arch/arm64/boot/dts/apple/s5l8960x-j73.dts    |  14 +
>  arch/arm64/boot/dts/apple/s5l8960x-j85.dts    |  14 +
>  arch/arm64/boot/dts/apple/s5l8960x-j85m.dts   |  14 +
>  arch/arm64/boot/dts/apple/s5l8960x-j86.dts    |  14 +
>  arch/arm64/boot/dts/apple/s5l8960x-j86m.dts   |  14 +
>  arch/arm64/boot/dts/apple/s5l8960x-j87.dts    |  14 +
>  arch/arm64/boot/dts/apple/s5l8960x-j87m.dts   |  14 +
>  arch/arm64/boot/dts/apple/s5l8960x-mini2.dtsi |  52 ++++
>  arch/arm64/boot/dts/apple/s5l8960x-mini3.dtsi |  13 +
>  arch/arm64/boot/dts/apple/s5l8960x-n51.dts    |  14 +
>  arch/arm64/boot/dts/apple/s5l8960x-n53.dts    |  14 +
>  arch/arm64/boot/dts/apple/s5l8960x.dtsi       | 147 ++++++++++
>  arch/arm64/boot/dts/apple/s8000-j71s.dts      |  15 +
>  arch/arm64/boot/dts/apple/s8000-j72s.dts      |  15 +
>  arch/arm64/boot/dts/apple/s8000-n66.dts       |  15 +
>  arch/arm64/boot/dts/apple/s8000-n69u.dts      |  15 +
>  arch/arm64/boot/dts/apple/s8000-n71.dts       |  15 +
>  arch/arm64/boot/dts/apple/s8000.dtsi          | 179 ++++++++++++
>  arch/arm64/boot/dts/apple/s8001-j127.dts      |  14 +
>  arch/arm64/boot/dts/apple/s8001-j128.dts      |  14 +
>  arch/arm64/boot/dts/apple/s8001-j98a.dts      |  14 +
>  arch/arm64/boot/dts/apple/s8001-j99a.dts      |  14 +
>  arch/arm64/boot/dts/apple/s8001-pro.dtsi      |  45 +++
>  arch/arm64/boot/dts/apple/s8001.dtsi          | 167 +++++++++++
>  arch/arm64/boot/dts/apple/s8003-j71t.dts      |  15 +
>  arch/arm64/boot/dts/apple/s8003-j72t.dts      |  15 +
>  arch/arm64/boot/dts/apple/s8003-n66m.dts      |  15 +
>  arch/arm64/boot/dts/apple/s8003-n69.dts       |  15 +
>  arch/arm64/boot/dts/apple/s8003-n71m.dts      |  15 +
>  arch/arm64/boot/dts/apple/s8003.dtsi          |  19 ++
>  arch/arm64/boot/dts/apple/s800x-6s.dtsi       |  50 ++++
>  arch/arm64/boot/dts/apple/s800x-ipad5.dtsi    |  44 +++
>  arch/arm64/boot/dts/apple/s800x-se.dtsi       |  50 ++++
>  arch/arm64/boot/dts/apple/t7000-6.dtsi        |  50 ++++
>  arch/arm64/boot/dts/apple/t7000-j42d.dts      |  18 ++
>  arch/arm64/boot/dts/apple/t7000-j96.dts       |  14 +
>  arch/arm64/boot/dts/apple/t7000-j97.dts       |  14 +
>  arch/arm64/boot/dts/apple/t7000-mini4.dtsi    |  51 ++++
>  arch/arm64/boot/dts/apple/t7000-n102.dts      |  49 ++++
>  arch/arm64/boot/dts/apple/t7000-n56.dts       |  14 +
>  arch/arm64/boot/dts/apple/t7000-n61.dts       |  14 +
>  arch/arm64/boot/dts/apple/t7000.dtsi          | 147 ++++++++++
>  arch/arm64/boot/dts/apple/t7001-air2.dtsi     |  44 +++
>  arch/arm64/boot/dts/apple/t7001-j81.dts       |  14 +
>  arch/arm64/boot/dts/apple/t7001-j82.dts       |  14 +
>  arch/arm64/boot/dts/apple/t7001.dtsi          | 154 ++++++++++
>  arch/arm64/boot/dts/apple/t8010-7.dtsi        |  45 +++
>  arch/arm64/boot/dts/apple/t8010-d10.dts       |  14 +
>  arch/arm64/boot/dts/apple/t8010-d101.dts      |  14 +
>  arch/arm64/boot/dts/apple/t8010-d11.dts       |  14 +
>  arch/arm64/boot/dts/apple/t8010-d111.dts      |  14 +
>  arch/arm64/boot/dts/apple/t8010-fast.dtsi     |  27 ++
>  arch/arm64/boot/dts/apple/t8010-ipad6.dtsi    |  45 +++
>  arch/arm64/boot/dts/apple/t8010-ipad7.dtsi    |  15 +
>  arch/arm64/boot/dts/apple/t8010-j171.dts      |  14 +
>  arch/arm64/boot/dts/apple/t8010-j172.dts      |  14 +
>  arch/arm64/boot/dts/apple/t8010-j71b.dts      |  14 +
>  arch/arm64/boot/dts/apple/t8010-j72b.dts      |  14 +
>  arch/arm64/boot/dts/apple/t8010-n112.dts      |  48 ++++
>  arch/arm64/boot/dts/apple/t8010.dtsi          | 227 +++++++++++++++
>  arch/arm64/boot/dts/apple/t8011-j105a.dts     |  14 +
>  arch/arm64/boot/dts/apple/t8011-j120.dts      |  14 +
>  arch/arm64/boot/dts/apple/t8011-j121.dts      |  14 +
>  arch/arm64/boot/dts/apple/t8011-j207.dts      |  14 +
>  arch/arm64/boot/dts/apple/t8011-j208.dts      |  14 +
>  arch/arm64/boot/dts/apple/t8011-pro2.dtsi     |  45 +++
>  arch/arm64/boot/dts/apple/t8011.dtsi          | 175 ++++++++++++
>  arch/arm64/boot/dts/apple/t8015-8.dtsi        |  12 +
>  arch/arm64/boot/dts/apple/t8015-8plus.dtsi    |   9 +
>  arch/arm64/boot/dts/apple/t8015-d20.dts       |  14 +
>  arch/arm64/boot/dts/apple/t8015-d201.dts      |  14 +
>  arch/arm64/boot/dts/apple/t8015-d21.dts       |  14 +
>  arch/arm64/boot/dts/apple/t8015-d211.dts      |  14 +
>  arch/arm64/boot/dts/apple/t8015-d22.dts       |  14 +
>  arch/arm64/boot/dts/apple/t8015-d221.dts      |  14 +
>  arch/arm64/boot/dts/apple/t8015-x.dtsi        |  15 +
>  arch/arm64/boot/dts/apple/t8015.dtsi          | 269 ++++++++++++++++++
>  88 files changed, 3257 insertions(+), 4 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-5s.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-air1.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j71.dts
>  create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j72.dts
>  create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j73.dts
>  create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j85.dts
>  create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j85m.dts
>  create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j86.dts
>  create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j86m.dts
>  create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j87.dts
>  create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j87m.dts
>  create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-mini2.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-mini3.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-n51.dts
>  create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-n53.dts
>  create mode 100644 arch/arm64/boot/dts/apple/s5l8960x.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/s8000-j71s.dts
>  create mode 100644 arch/arm64/boot/dts/apple/s8000-j72s.dts
>  create mode 100644 arch/arm64/boot/dts/apple/s8000-n66.dts
>  create mode 100644 arch/arm64/boot/dts/apple/s8000-n69u.dts
>  create mode 100644 arch/arm64/boot/dts/apple/s8000-n71.dts
>  create mode 100644 arch/arm64/boot/dts/apple/s8000.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/s8001-j127.dts
>  create mode 100644 arch/arm64/boot/dts/apple/s8001-j128.dts
>  create mode 100644 arch/arm64/boot/dts/apple/s8001-j98a.dts
>  create mode 100644 arch/arm64/boot/dts/apple/s8001-j99a.dts
>  create mode 100644 arch/arm64/boot/dts/apple/s8001-pro.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/s8001.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/s8003-j71t.dts
>  create mode 100644 arch/arm64/boot/dts/apple/s8003-j72t.dts
>  create mode 100644 arch/arm64/boot/dts/apple/s8003-n66m.dts
>  create mode 100644 arch/arm64/boot/dts/apple/s8003-n69.dts
>  create mode 100644 arch/arm64/boot/dts/apple/s8003-n71m.dts
>  create mode 100644 arch/arm64/boot/dts/apple/s8003.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/s800x-6s.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/s800x-ipad5.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/s800x-se.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/t7000-6.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/t7000-j42d.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t7000-j96.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t7000-j97.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t7000-mini4.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/t7000-n102.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t7000-n56.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t7000-n61.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t7000.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/t7001-air2.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/t7001-j81.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t7001-j82.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t7001.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/t8010-7.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/t8010-d10.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t8010-d101.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t8010-d11.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t8010-d111.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t8010-fast.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/t8010-ipad6.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/t8010-ipad7.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/t8010-j171.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t8010-j172.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t8010-j71b.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t8010-j72b.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t8010-n112.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t8010.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/t8011-j105a.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t8011-j120.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t8011-j121.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t8011-j207.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t8011-j208.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t8011-pro2.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/t8011.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/t8015-8.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/t8015-8plus.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/t8015-d20.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t8015-d201.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t8015-d21.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t8015-d211.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t8015-d22.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t8015-d221.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t8015-x.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/t8015.dtsi
> 
> 
> base-commit: 6708132e80a2ced620bde9b9c36e426183544a23
> --
> 2.46.0
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y apple/s5l8960x-j71.dtb apple/s5l8960x-j72.dtb apple/s5l8960x-j73.dtb apple/s5l8960x-j85.dtb apple/s5l8960x-j85m.dtb apple/s5l8960x-j86.dtb apple/s5l8960x-j86m.dtb apple/s5l8960x-j87.dtb apple/s5l8960x-j87m.dtb apple/s5l8960x-n51.dtb apple/s5l8960x-n53.dtb apple/s8000-j71s.dtb apple/s8000-j72s.dtb apple/s8000-n66.dtb apple/s8000-n69u.dtb apple/s8000-n71.dtb apple/s8001-j127.dtb apple/s8001-j128.dtb apple/s8001-j98a.dtb apple/s8001-j99a.dtb apple/s8003-j71t.dtb apple/s8003-j72t.dtb apple/s8003-n66m.dtb apple/s8003-n69.dtb apple/s8003-n71m.dtb apple/t7000-j42d.dtb apple/t7000-j96.dtb apple/t7000-j97.dtb apple/t7000-n102.dtb apple/t7000-n56.dtb apple/t7000-n61.dtb apple/t7001-j81.dtb apple/t7001-j82.dtb apple/t8010-d10.dtb apple/t8010-d101.dtb apple/t8010-d11.dtb apple/t8010-d111.dtb apple/t8010-j171.dtb apple/t8010-j172.dtb apple/t8010-j71b.dtb apple/t8010-j72b.dtb apple/t8010-n112.dtb apple/t8011-j105a.dtb apple/t8011-j120.dtb apple/t8011-j121.dt
 b apple/t8011-j207.dtb apple/t8011-j208.dtb apple/t8015-d20.dtb apple/t8015-d201.dtb apple/t8015-d21.dtb apple/t8015-d211.dtb apple/t8015-d22.dtb apple/t8015-d221.dtb' for 20240911084353.28888-2-towinchenmi@gmail.com:

Error: arch/arm64/boot/dts/apple/t8010-n112.dts:21.18-19 syntax error
FATAL ERROR: Unable to parse input tree
make[3]: *** [scripts/Makefile.dtbs:129: arch/arm64/boot/dts/apple/t8010-n112.dtb] Error 1
make[2]: *** [scripts/Makefile.build:478: arch/arm64/boot/dts/apple] Error 2
make[2]: Target 'arch/arm64/boot/dts/apple/t8010-n112.dtb' not remade because of errors.
make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1392: apple/t8010-n112.dtb] Error 2
make: *** [Makefile:224: __sub-make] Error 2
make: Target 'apple/s5l8960x-j71.dtb' not remade because of errors.
make: Target 'apple/s5l8960x-j72.dtb' not remade because of errors.
make: Target 'apple/s5l8960x-j73.dtb' not remade because of errors.
make: Target 'apple/s5l8960x-j85.dtb' not remade because of errors.
make: Target 'apple/s5l8960x-j85m.dtb' not remade because of errors.
make: Target 'apple/s5l8960x-j86.dtb' not remade because of errors.
make: Target 'apple/s5l8960x-j86m.dtb' not remade because of errors.
make: Target 'apple/s5l8960x-j87.dtb' not remade because of errors.
make: Target 'apple/s5l8960x-j87m.dtb' not remade because of errors.
make: Target 'apple/s5l8960x-n51.dtb' not remade because of errors.
make: Target 'apple/s5l8960x-n53.dtb' not remade because of errors.
make: Target 'apple/s8000-j71s.dtb' not remade because of errors.
make: Target 'apple/s8000-j72s.dtb' not remade because of errors.
make: Target 'apple/s8000-n66.dtb' not remade because of errors.
make: Target 'apple/s8000-n69u.dtb' not remade because of errors.
make: Target 'apple/s8000-n71.dtb' not remade because of errors.
make: Target 'apple/s8001-j127.dtb' not remade because of errors.
make: Target 'apple/s8001-j128.dtb' not remade because of errors.
make: Target 'apple/s8001-j98a.dtb' not remade because of errors.
make: Target 'apple/s8001-j99a.dtb' not remade because of errors.
make: Target 'apple/s8003-j71t.dtb' not remade because of errors.
make: Target 'apple/s8003-j72t.dtb' not remade because of errors.
make: Target 'apple/s8003-n66m.dtb' not remade because of errors.
make: Target 'apple/s8003-n69.dtb' not remade because of errors.
make: Target 'apple/s8003-n71m.dtb' not remade because of errors.
make: Target 'apple/t7000-j42d.dtb' not remade because of errors.
make: Target 'apple/t7000-j96.dtb' not remade because of errors.
make: Target 'apple/t7000-j97.dtb' not remade because of errors.
make: Target 'apple/t7000-n102.dtb' not remade because of errors.
make: Target 'apple/t7000-n56.dtb' not remade because of errors.
make: Target 'apple/t7000-n61.dtb' not remade because of errors.
make: Target 'apple/t7001-j81.dtb' not remade because of errors.
make: Target 'apple/t7001-j82.dtb' not remade because of errors.
make: Target 'apple/t8010-d10.dtb' not remade because of errors.
make: Target 'apple/t8010-d101.dtb' not remade because of errors.
make: Target 'apple/t8010-d11.dtb' not remade because of errors.
make: Target 'apple/t8010-d111.dtb' not remade because of errors.
make: Target 'apple/t8010-j171.dtb' not remade because of errors.
make: Target 'apple/t8010-j172.dtb' not remade because of errors.
make: Target 'apple/t8010-j71b.dtb' not remade because of errors.
make: Target 'apple/t8010-j72b.dtb' not remade because of errors.
make: Target 'apple/t8010-n112.dtb' not remade because of errors.
make: Target 'apple/t8011-j105a.dtb' not remade because of errors.
make: Target 'apple/t8011-j120.dtb' not remade because of errors.
make: Target 'apple/t8011-j121.dtb' not remade because of errors.
make: Target 'apple/t8011-j207.dtb' not remade because of errors.
make: Target 'apple/t8011-j208.dtb' not remade because of errors.
make: Target 'apple/t8015-d20.dtb' not remade because of errors.
make: Target 'apple/t8015-d201.dtb' not remade because of errors.
make: Target 'apple/t8015-d21.dtb' not remade because of errors.
make: Target 'apple/t8015-d211.dtb' not remade because of errors.
make: Target 'apple/t8015-d22.dtb' not remade because of errors.
make: Target 'apple/t8015-d221.dtb' not remade because of errors.






