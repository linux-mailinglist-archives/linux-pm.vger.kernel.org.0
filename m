Return-Path: <linux-pm+bounces-33120-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD799B366B0
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 15:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48DCAB61971
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 13:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A871352FE7;
	Tue, 26 Aug 2025 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J//Si2GW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE71341ABD;
	Tue, 26 Aug 2025 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216608; cv=none; b=j50clJ4Xax6nGSPgHu8GmbKZziPjoUufgSjaPOprxIeMtFK7/pQc8rPHtwwmwJ+TlnFPy/9iKKXiOxZ2ExaozOmgmVlIoXQ+tCydhHx9iwlRWsUkh+oDYcK5ojEjP1BBEHfQsmNMb5+6HpOOTsXqXcSxtxo0Z5RVptWG2qE+aMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216608; c=relaxed/simple;
	bh=GAK3iErIJh5FHvvRonZ/RMRYuNJxBuLG4M3JABISxbU=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=S/axGT3jFdP4vG0H+oKbSNRNsMGGe8BRu6X5RaLNc+p8rOgB0QhDMI6DBoZX3n2f6z7A7JmRffMZAN040sf6XU4NlxT6yEHRhX+vfXpo/o8rNUBLyB0KfSKFIKh3IwDp98HkstAKrbkJvfCcpuXfxMv12DoLpF3iPLLFxDOBXS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J//Si2GW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412E6C116B1;
	Tue, 26 Aug 2025 13:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756216605;
	bh=GAK3iErIJh5FHvvRonZ/RMRYuNJxBuLG4M3JABISxbU=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=J//Si2GWx4doiSIjC71SHMojeaD1+tCxptmSzaXZqxSx3rCUTtGQ+N7qSq0mOM8hl
	 RdvRAjAI4KD/o56UqmJBJ7h9hifetskHNsgG6r/jlVtoaErGvd0QQjU3sQT1uE8Ete
	 cDAayHCLQUSflFpyl1uH2n8CYd/EcdD+7f+YaTcNOlSE0LI5Ou+0HTthv4IVq/mTt+
	 Wnsvyky7VR2spB54QCYWFuJ+p2kR6iUBfte8T6jcIFXZHO1ayCudO5gD+qSP1QC/sn
	 wsg4DZjJg/QQMiAEqVVXFxc2LYHuYDNusrNbdM7mEorQgDXPfu9bP/MWHiTYqy11lV
	 /WAgbi+dJWiXw==
Date: Tue, 26 Aug 2025 08:56:44 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Thierry Reding <treding@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>, linux-tegra@vger.kernel.org, 
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
 linux-pm@vger.kernel.org
To: Svyatoslav Ryhel <clamor95@gmail.com>
In-Reply-To: <20250826061117.63643-1-clamor95@gmail.com>
References: <20250826061117.63643-1-clamor95@gmail.com>
Message-Id: <175621649727.159471.17430997152265024171.robh@kernel.org>
Subject: Re: [PATCH v3 0/4] clk: tegra: add DFLL support for Tegra114


On Tue, 26 Aug 2025 09:11:13 +0300, Svyatoslav Ryhel wrote:
> DFLL is a dedicated clock source for the Fast CPU. The DFLL is based on
> a ring oscillator and translates voltage changes into frequency
> compensation changes needed to prevent the CPU from failing and is
> essential for correct CPU frequency scaling.
> 
> ---
> Changes in v2:
> - dropped 'drivers:' from commit title
> - aligned naming to Tegra114
> 
> Changes in v3:
> - add DFLL support for Tegra 114 was split into dt header addition,
>   DFLL reset configuration and CVB tables implementation.
> - added cleaner commit message to dt header commit
> - added T210_ prefixes to Tegra210 CVB table macros
> ---
> 
> Svyatoslav Ryhel (4):
>   dt-bindings: reset: add Tegra114 car header
>   clk: tegra: add DFLL DVCO reset control for Tegra114
>   clk: tegra: dfll: add CVB tables for Tegra114
>   ARM: tegra: Add DFLL clock support for Tegra114
> 
>  arch/arm/boot/dts/nvidia/tegra114.dtsi     |  33 +++++
>  drivers/clk/tegra/Kconfig                  |   2 +-
>  drivers/clk/tegra/clk-tegra114.c           |  30 +++-
>  drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 158 +++++++++++++++++----
>  drivers/clk/tegra/clk.h                    |   2 -
>  include/dt-bindings/reset/tegra114-car.h   |  13 ++
>  6 files changed, 204 insertions(+), 34 deletions(-)
>  create mode 100644 include/dt-bindings/reset/tegra114-car.h
> 
> --
> 2.48.1
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
 Base: attempting to guess base-commit...
 Base: tags/next-20250825 (best guess, 3/5 blobs matched)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/nvidia/' for 20250826061117.63643-1-clamor95@gmail.com:

arch/arm/boot/dts/nvidia/tegra114-tn7.dtb: /clock@70110000: failed to match any schema with compatible: ['nvidia,tegra114-dfll']
arch/arm/boot/dts/nvidia/tegra114-tn7.dtb: cpu@0 (arm,cortex-a15): 'operating-points' is a dependency of 'clock-latency'
	from schema $id: http://devicetree.org/schemas/arm/cpus.yaml#
arch/arm/boot/dts/nvidia/tegra114-tn7.dtb: cpu@0 (arm,cortex-a15): Unevaluated properties are not allowed ('clock-latency' was unexpected)
	from schema $id: http://devicetree.org/schemas/arm/cpus.yaml#
arch/arm/boot/dts/nvidia/tegra114-roth.dtb: /clock@70110000: failed to match any schema with compatible: ['nvidia,tegra114-dfll']
arch/arm/boot/dts/nvidia/tegra114-roth.dtb: cpu@0 (arm,cortex-a15): 'operating-points' is a dependency of 'clock-latency'
	from schema $id: http://devicetree.org/schemas/arm/cpus.yaml#
arch/arm/boot/dts/nvidia/tegra114-roth.dtb: cpu@0 (arm,cortex-a15): Unevaluated properties are not allowed ('clock-latency' was unexpected)
	from schema $id: http://devicetree.org/schemas/arm/cpus.yaml#
arch/arm/boot/dts/nvidia/tegra114-dalmore.dtb: /clock@70110000: failed to match any schema with compatible: ['nvidia,tegra114-dfll']
arch/arm/boot/dts/nvidia/tegra114-dalmore.dtb: cpu@0 (arm,cortex-a15): 'operating-points' is a dependency of 'clock-latency'
	from schema $id: http://devicetree.org/schemas/arm/cpus.yaml#
arch/arm/boot/dts/nvidia/tegra114-dalmore.dtb: cpu@0 (arm,cortex-a15): Unevaluated properties are not allowed ('clock-latency' was unexpected)
	from schema $id: http://devicetree.org/schemas/arm/cpus.yaml#
arch/arm/boot/dts/nvidia/tegra114-asus-tf701t.dtb: /clock@70110000: failed to match any schema with compatible: ['nvidia,tegra114-dfll']
arch/arm/boot/dts/nvidia/tegra114-asus-tf701t.dtb: cpu@0 (arm,cortex-a15): 'operating-points' is a dependency of 'clock-latency'
	from schema $id: http://devicetree.org/schemas/arm/cpus.yaml#
arch/arm/boot/dts/nvidia/tegra114-asus-tf701t.dtb: cpu@0 (arm,cortex-a15): Unevaluated properties are not allowed ('clock-latency' was unexpected)
	from schema $id: http://devicetree.org/schemas/arm/cpus.yaml#






