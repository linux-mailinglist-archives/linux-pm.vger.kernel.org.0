Return-Path: <linux-pm+bounces-26954-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C01BAB1713
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 16:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67CB1889B5C
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 14:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929E8217668;
	Fri,  9 May 2025 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXO7Vzev"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F13021504F;
	Fri,  9 May 2025 14:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746800215; cv=none; b=iiyBZV8Lz/h8oZpESztfOlSOUNPhWlq0isThcdXdR/pXkLaVNU3/4wFL7Mx1GaQOMuEjNptrAvqlYdqe1jtTw0fnt2in6x1GzVvJwoo06PLAvwvxSs1x/Fj+TYnCNAA67KFwON0MRaDUDO3H61rfs7ZOAqJJJUcS1O+O5fSG/lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746800215; c=relaxed/simple;
	bh=uRHUJoqNa5K5mWMaXCiU/RiZB7ZiJa/lTWJxiEmFf94=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Eet/vSJlv4U2AcjA9PdXMIrLqd/x+6o515sVtC28OhhyZ7+UyTtza7MQavK1AihLAHJc+t44GhTecEHunVLzS6KG7j9HNVkXNBP9U3UZNi7aMXVKuWPOkLGJhyR+557J6B/+P7Ndr9s4PLpA+JFZFjmxIrfGw9KOBGYtnrO5jX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXO7Vzev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99232C4CEE4;
	Fri,  9 May 2025 14:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746800213;
	bh=uRHUJoqNa5K5mWMaXCiU/RiZB7ZiJa/lTWJxiEmFf94=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=TXO7VzevGMh3xxBVC9HgXjoevh+cWjCoMJFLZOEl9OqNrT8y38ICVKegnJWrkYfiL
	 GdtKF/w1ArYeG/uWIGlVFYVJkzaFMrsNyGJP48QfyAH0kMkaUjScgmwAR4k/KxNjW5
	 jxwA2Jondq7N3GTCS3M/kUHhyg+paPcDea8a2v7AYUQgUhTpntQbBNfFC/ncIQbbeT
	 JranlvwfoqjcAKLmoanKcN7m0mB1bBPZ7JBkvev6aadCnRTRl2pnQXu9CFBe6Zgbu6
	 5ecSGbcO0EUeEV2z2MLfCaYpN7pk/dYtkwM/+5gBWwTk/VCd8SwkgaYQg2LHIwcocd
	 /6fZOTP7vA5mg==
Date: Fri, 09 May 2025 09:16:51 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: tudor.ambarus@linaro.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, badhri@google.com, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, sre@kernel.org, conor+dt@kernel.org, 
 linux-samsung-soc@vger.kernel.org, alim.akhtar@samsung.com, 
 linux-arm-kernel@lists.infradead.org, krzk+dt@kernel.org, 
 dima.fedrau@gmail.com, linux-kernel@vger.kernel.org
To: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <20250508050856.674782-1-amitsd@google.com>
References: <20250508050856.674782-1-amitsd@google.com>
Message-Id: <174679984823.3368214.18196649123277436565.robh@kernel.org>
Subject: Re: [PATCH v1 0/2] Add graph connections between tcpc & fg for
 Pixel 6


On Wed, 07 May 2025 22:08:50 -0700, Amit Sunil Dhamne wrote:
> max77759 Type-C controller supplies VBUS into & out of (depending on the
> charging mode) the battery in Pixel 6. In order to represent this
> relationship, we use graph to connect tcpc & fuel gauge.
> 
> Link to USB connector binding that this patchset uses:
>  - https://lore.kernel.org/all/20250507-batt_ops-v2-1-8d06130bffe6@google.com/
> 
> This patchset depends on the following:
>  - https://lore.kernel.org/all/20250421-b4-gs101_max77759_fg-v3-0-50cd8caf9017@uclouvain.be/
> 
> Amit Sunil Dhamne (2):
>   dt-bindings: power: supply: max17201: add port property
>   arm64: dts: exynos: gs101-pixel-common: add graph property to connect
>     tcpc & fg
> 
>  .../bindings/power/supply/maxim,max17201.yaml      |  5 +++++
>  .../boot/dts/exynos/google/gs101-pixel-common.dtsi | 14 ++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> 
> base-commit: 92a09c47464d040866cf2b4cd052bc60555185fb
> prerequisite-patch-id: 74aa0a6fc4a5c56d870bb15375fad1fe41ffc1e9
> prerequisite-patch-id: 46f968300dcf5442e12d882ca23168494249d378
> prerequisite-patch-id: 3ad83a2782819bca215bb267d36a1ff04fe557b2
> prerequisite-patch-id: 86b5207d8f44255c36b1e600ecdf4f948c5da685
> prerequisite-patch-id: a15532888ff2572696d9fa6a14775e8ebf590391
> --
> 2.49.0.987.g0cc8ee98dc-goog
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


This patch series was applied (using b4) to base:
 Base: using specified base-commit 92a09c47464d040866cf2b4cd052bc60555185fb
 Deps: looking for dependencies matching 5 patch-ids
 Deps: Applying prerequisite patch: [PATCH v3 1/5] power: supply: correct capacity computation
 Deps: Applying prerequisite patch: [PATCH v3 2/5] power: supply: add support for max77759 fuel gauge
 Deps: Applying prerequisite patch: [PATCH v3 3/5] dt-bindings: power: supply: add max77759-fg flavor
 Deps: Applying prerequisite patch: [PATCH v3 4/5] arm64: defconfig: enable Maxim max1720x driver
 Deps: Applying prerequisite patch: [PATCH v3 5/5] arm64: dts: exynos: gs101-oriole: enable Maxim max77759 fuel gauge

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/exynos/' for 20250508050856.674782-1-amitsd@google.com:

arch/arm64/boot/dts/exynos/google/gs101-oriole.dtb: fuel-gauge@36 (maxim,max77759-fg): reg: [[54]] is too short
	from schema $id: http://devicetree.org/schemas/power/supply/maxim,max17201.yaml#
arch/arm64/boot/dts/exynos/google/gs101-oriole.dtb: fuel-gauge@36 (maxim,max77759-fg): reg-names: ['m5'] is too short
	from schema $id: http://devicetree.org/schemas/power/supply/maxim,max17201.yaml#
arch/arm64/boot/dts/exynos/google/gs101-oriole.dtb: fuel-gauge@36 (maxim,max77759-fg): Unevaluated properties are not allowed ('reg-names' was unexpected)
	from schema $id: http://devicetree.org/schemas/power/supply/maxim,max17201.yaml#
arch/arm64/boot/dts/exynos/google/gs101-raven.dtb: fuel-gauge@36 (maxim,max77759-fg): reg: [[54]] is too short
	from schema $id: http://devicetree.org/schemas/power/supply/maxim,max17201.yaml#
arch/arm64/boot/dts/exynos/google/gs101-raven.dtb: fuel-gauge@36 (maxim,max77759-fg): reg-names: ['m5'] is too short
	from schema $id: http://devicetree.org/schemas/power/supply/maxim,max17201.yaml#
arch/arm64/boot/dts/exynos/google/gs101-raven.dtb: fuel-gauge@36 (maxim,max77759-fg): Unevaluated properties are not allowed ('reg-names' was unexpected)
	from schema $id: http://devicetree.org/schemas/power/supply/maxim,max17201.yaml#






