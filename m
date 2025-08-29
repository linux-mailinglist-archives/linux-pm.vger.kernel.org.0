Return-Path: <linux-pm+bounces-33413-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A38B3BD9C
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 16:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E3591CC1BC5
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 14:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87B1320CD8;
	Fri, 29 Aug 2025 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzWVE9Rs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E37320398;
	Fri, 29 Aug 2025 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756477653; cv=none; b=UTTctJxGhOke+7E36Sof7bbIFlUIf8trjRjWwzwox8/wUvIAqryEcjbbWIK3Y6Z3PpwKegjNLxcdyWF1bGdXLVCwafUlCljhgRWg4ecITS5+JX4gDANoBOVz4elyZf5iK55zi7vYAR9PitT6OceWisp1uyoSipyHUrJUxDBm0AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756477653; c=relaxed/simple;
	bh=jdMGIFYvqok3uA+n6cH3bsInCw2c3K7K0ooHXrgGJ1U=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=IDQHuNPM4RyncQi87WvvtVCq/ZxAnj1r125Kx01k3+P/MnGsWLvIWayTZczCR+NhAEamaw59+9rC9Q34gdM4HdOqnqjH86jBdZWxtQr/f6MPqdk8khCh+LdX6lGJU/9nPYg+W0cVYZCYnEtmhDY3BQjNnbC/DwcnN4xJSy96iLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzWVE9Rs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F62C4CEF0;
	Fri, 29 Aug 2025 14:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756477653;
	bh=jdMGIFYvqok3uA+n6cH3bsInCw2c3K7K0ooHXrgGJ1U=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=YzWVE9RsQzaSpE4jk9MGB//vhdQsZu5JE+4l04yvIfF/YwQ/7xcbG16/JeuoH3I0c
	 LbC8J40v0qexfI6zvFacHuR+/376z8qx0QFB5uVN/ZKRQJ6iEqLpoNkogB2r14KEpl
	 L+vogIZb+fugNejwwe/tAECuNdZWTCGsqNuquK0h9oDCEezZpAdNxPt3DMEmLhAYpL
	 6EZXh+GDvrgLLY5/4ogAgTJpzQjQxQG5YuYhpuw9rGl9C/uoC2RQnJf0bNTsUlxbIu
	 K8F1tM2eLUQ/DNkzq0z4uctGJn1ACv+m6kkyhAV4bx2xldO9XsnyDkSVsBSjYVqyH5
	 VGeqkEYN7nr2g==
Date: Fri, 29 Aug 2025 09:27:31 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Conor Dooley <conor+dt@kernel.org>, linux-tegra@vger.kernel.org, 
 Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org, 
 Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org, 
 MyungJoo Ham <myungjoo.ham@samsung.com>
To: Aaron Kling <webgeek1234@gmail.com>
In-Reply-To: <20250828-t210-actmon-v1-0-aeb19ec1f244@gmail.com>
References: <20250828-t210-actmon-v1-0-aeb19ec1f244@gmail.com>
Message-Id: <175647746367.734475.9455841505261457639.robh@kernel.org>
Subject: Re: [PATCH RFC 0/7] Support Tegra210 actmon for dynamic EMC
 scaling


On Thu, 28 Aug 2025 23:01:26 -0500, Aaron Kling wrote:
> This series adds interconnect support to tegra210 MC and EMC, then
> enables actmon. This enables dynamic emc scaling.
> 
> This series is marked RFC for two reasons:
> 
> 1) Calculating rate from bandwidth usage results in double the expected
>    rate. I thought this might be due to the ram being 64-bit, but the
>    related CFG5 register reports 32-bit on both p2371-2180 and
>    p3450-0000. I'm using the calculation used for Tegra124 and haven't
>    seen seen anything obviously different between the ram handling on
>    these archs to cause a different result. I have considered that the
>    number of channels might affect the reporting, and factoring in that
>    variable does result in the correct rate, but I don't want to assume
>    that's correct without confirmation.
> 
> 2) I am seeing intermittent instability when transitioning to rates of
>    204 MHz or below on p2371-2180. I have noted that if the first
>    transition to such a state works, then it continues to work for the
>    rest of that boot cycle. But the kernel will often panic the first
>    time it tries to downclock. I suspect this is a pre-existing issue
>    only brought to light now because nothing would ever lower the clock
>    rate previously.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
> Aaron Kling (7):
>       dt-bindings: memory: tegra210: Add memory client IDs
>       dt-bindings: devfreq: tegra30-actmon: Add Tegra124 fallback for Tegra210
>       soc: tegra: fuse: speedo-tegra210: Add soc speedo 2
>       memory: tegra210: Support interconnect framework
>       arm64: tegra: tegra210: Add actmon
>       arm64: tegra: Add interconnect properties to Tegra210 device-tree
>       arm64: tegra: Add OPP tables on Tegra210
> 
>  .../bindings/devfreq/nvidia,tegra30-actmon.yaml    |  13 +-
>  .../boot/dts/nvidia/tegra210-peripherals-opp.dtsi  | 135 ++++++++++
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  43 ++++
>  drivers/memory/tegra/Kconfig                       |   1 +
>  drivers/memory/tegra/tegra210-emc-core.c           | 276 ++++++++++++++++++++-
>  drivers/memory/tegra/tegra210-emc.h                |  25 ++
>  drivers/memory/tegra/tegra210.c                    |  81 ++++++
>  drivers/soc/tegra/fuse/speedo-tegra210.c           |   1 +
>  include/dt-bindings/memory/tegra210-mc.h           |  58 +++++
>  9 files changed, 626 insertions(+), 7 deletions(-)
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250822-t210-actmon-34904ce7ed0c
> prerequisite-change-id: 20250812-tegra210-speedo-470691e8b8cc:v1
> prerequisite-patch-id: 81859c81abbe79aed1cfbc95b4f5bcdc5637d6bd
> prerequisite-patch-id: 98bda8855bcc57c59b2231b7808d4478301afe68
> prerequisite-patch-id: 6e0b69d42ea542dc9f58b410abd5974644f75dc4
> prerequisite-patch-id: 9e3b9b2fdb8d9c2264dfa7641d1aec84fb7aedd9
> prerequisite-patch-id: ef4bcc4ddba7898b188fb3fc6e414a2662183f91
> 
> Best regards,
> --
> Aaron Kling <webgeek1234@gmail.com>
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
 Base: using specified base-commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585
 Deps: looking for dependencies matching 5 patch-ids
 Deps: Applying prerequisite patch: [PATCH 1/5] dt-bindings: clock: tegra124-dfll: Add property to limit frequency
 Deps: Applying prerequisite patch: [PATCH 2/5] soc: tegra: fuse: speedo-tegra210: Update speedo ids
 Deps: Applying prerequisite patch: [PATCH 3/5] soc: tegra: fuse: speedo-tegra210: Add sku 0x8F
 Deps: Applying prerequisite patch: [PATCH 4/5] clk: tegra: dfll: Support limiting max clock per device
 Deps: Applying prerequisite patch: [PATCH 5/5] arm64: tegra: Limit max cpu frequency on P3450

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/nvidia/' for 20250828-t210-actmon-v1-0-aeb19ec1f244@gmail.com:

arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dtb: external-memory-controller@7001b000 (nvidia,tegra210-emc): '#cooling-cells', '#interconnect-cells', 'operating-points-v2' do not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/memory-controllers/nvidia,tegra210-emc.yaml#
arch/arm64/boot/dts/nvidia/tegra210-p2371-0000.dtb: external-memory-controller@7001b000 (nvidia,tegra210-emc): '#cooling-cells', '#interconnect-cells', 'operating-points-v2' do not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/memory-controllers/nvidia,tegra210-emc.yaml#
arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dtb: external-memory-controller@7001b000 (nvidia,tegra210-emc): '#cooling-cells', '#interconnect-cells', 'operating-points-v2' do not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/memory-controllers/nvidia,tegra210-emc.yaml#
arch/arm64/boot/dts/nvidia/tegra210-smaug.dtb: external-memory-controller@7001b000 (nvidia,tegra210-emc): '#cooling-cells', '#interconnect-cells', 'operating-points-v2' do not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/memory-controllers/nvidia,tegra210-emc.yaml#
arch/arm64/boot/dts/nvidia/tegra210-p2894-0050-a08.dtb: external-memory-controller@7001b000 (nvidia,tegra210-emc): '#cooling-cells', '#interconnect-cells', 'operating-points-v2' do not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/memory-controllers/nvidia,tegra210-emc.yaml#
arch/arm64/boot/dts/nvidia/tegra210-p2571.dtb: external-memory-controller@7001b000 (nvidia,tegra210-emc): '#cooling-cells', '#interconnect-cells', 'operating-points-v2' do not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/memory-controllers/nvidia,tegra210-emc.yaml#






