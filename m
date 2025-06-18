Return-Path: <linux-pm+bounces-28960-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 028FBADED15
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 14:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7CB18912A2
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 12:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4E02E3AE7;
	Wed, 18 Jun 2025 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YsXxY8NY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE032E2651
	for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 12:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750251419; cv=none; b=KgFxh0ImH3vO7l/jqf66eY0vgQeK0RLAb25VNsZY1/M1YNX5/zqm5XRuh1HvupLRRlPjxqtrBbCJlStW/jLhUPxG+Am02pfKDF1Me75n6qCuzOWPsVS0REcDAaQ8AiHOlJEh7qTbuJ84vBybHvhiR1EgN+ndXYPJC1P9kvnpm2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750251419; c=relaxed/simple;
	bh=0wBAwwU35T2EdCWcWHBQveoDRg+cQ5ZJBxvRBpS8XqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xde9YzVGSWUpQvqIP7wZPDSw1HEAKvpScgoObps3/BuXmnwmv/O2N393Ex3qpm42spR2y2b+Y8LKB4MHGA4QZHlqXIlBGVR1YpV+UEWscxD7JcGf1B4tvLPZeG6X9fkRXbkMzGpIi0j1FyYrTkIUFYl7f87G4njmIMF4DBGJb58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YsXxY8NY; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e819aa98e7aso6189051276.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 05:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750251417; x=1750856217; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Jfv7W89jcyNI5g8maM5e0NmglDrqdzJne5yo5vZPXg=;
        b=YsXxY8NYzQoxZBRRqVNivh364fzheZLSJPL1iF2h8we2FJ8feKWiAKj6fIJCAen8Aw
         Q9YS8U4gUb5Ni50asVbfdiJ/q3AQdphjISts1bfPWBVBMeU+sYOiR3URsmhtcUkMXqkV
         9hi1z8nvl3KXcRMuDFXG/m+/9t81mjbFuR8v2LTZeRdF2lp+JYOp4HGGZxtqVLLiwLzC
         tNMG6ynqSdI2dRgtiWE/Povfe7HL9Fi4C/tb7SWtGdkXgGs/Wbl2e9jxF4KdQLTcTzUj
         sGRtN7G7n2FNmKQduoj7pgxJncgYYbOmh8gMQrdCwRYMNkEK24H8H3LDm+JDarRE1pSU
         CKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750251417; x=1750856217;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Jfv7W89jcyNI5g8maM5e0NmglDrqdzJne5yo5vZPXg=;
        b=YVI8W1i0FsGJ0QYGsBCLT5KVxCn2VYuYGpr0gPSaWrpDO+lifgmtHkESz9Opcv5p8y
         kQ+Yr0jjLP+BZV6+dvSwg6RjDUW9vWpJ2T3KoCPWfaRFDam/s+Gfhnq16vzCiE/MDEbv
         WZQ02zKMYdP53RKNWzclNwRr3otA6ZEot3EbsxkBv7z68iSdUxqzDq6TOmSegwWUtEN4
         vf94TYwOpBw5AUBwxKHXpIs1zsdfkrw3nukDq8PyfkWKig3y0acMHoVlK0xqggds/rcC
         I6uUU3bmiLpzVqS5VJQwhaBvKrv1FO33VKwSQ8LW0q27VGwCSc4zrjqGluGC7iSVPH3x
         FqmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk3eu2yS4itbEF4ZAo93dV4JzKafIX/h85Bnxjptr5T6p0ZM1Hc+wgrrRLJHj76iXRz4WUo1T3Gw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfqG+XTW+8zsAoAuaptVRm5woT0muulPW8/Wm3DJ9uj8m9ngWK
	ZQ8w00cJBuVX6j04DIsaZoaGmjIHLMskR3yMTxKGdqJNm8nqAk9SnLDaWO4SyR0zY092Tbkg3WQ
	TCwCBx5bUDAAS952+kboEeMa2mihbWtLej+0PscTx5g==
X-Gm-Gg: ASbGncuL/NjhhtWHfSvA7ms2mi6BG/mR78Svg6SlTYOzGlRxIsv8o9H1LN4c5NRqE93
	4jRIt44lD2OTAPUCDZeKnZ3fvCKM8fM4uyPp5xzEJEqVeFtCbvm5f0E1QGutcLOQ/WiPx+LPcFC
	srS4RGXJYdMfKh7vGSajQs+X4pve8cSdUbqaKEMM7nhho=
X-Google-Smtp-Source: AGHT+IEF7aSd2gChdpDkWFgFxP4fyCJRIi/0rOPMDF7EBy8fifK6rpldismzyPaU5FnMtFjQSC8V5hmVyzcxyRjq81Y=
X-Received: by 2002:a05:6902:a06:b0:e81:2740:2d96 with SMTP id
 3f1490d57ef6-e822acc6cc8mr22162870276.17.1750251416986; Wed, 18 Jun 2025
 05:56:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250518220707.669515-1-jonas@kwiboo.se>
In-Reply-To: <20250518220707.669515-1-jonas@kwiboo.se>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 18 Jun 2025 14:56:21 +0200
X-Gm-Features: AX0GCFurdlTWKY938doCIooXAEmUu9ZI2vYDArR38Vi5OuNwlGZr8B4vigPCwUY
Message-ID: <CAPDyKFrtp7MHMuXhhYm7c8TY9u5DoGV89x4d__gYLQSNU48voA@mail.gmail.com>
Subject: Re: [PATCH 0/9] rockchip: Add power controller support for RK3528
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yao Zi <ziyao@disroot.org>, 
	Chukun Pan <amadeus@jmu.edu.cn>, linux-rockchip@lists.infradead.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 May 2025 at 00:07, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> The Rockchip RK3528 support multiple power domains, one PD_GPU that can
> fully be powered down, and other that can be idle requested.
>
> Vendor kernel flag all power domains on RK3528 as always-on, this takes
> a different route and instead tries to describe all devices power-domain
> in the device tree, even for controllers with unsupported runtime status.
>
> The PD_RKVDEC is used by RKVDEC and DDRPHY CRU, and is kept disabled to
> prevent a full system reset when trying to read current rate of the
> SCMI_CLK_DDR clock.
>
> Patch 1-4 prepares and makes it possible to use the PD_GPU power domain
> for a separate "Add GPU support for RK3528" series.
>
> Patch 7-9 updates dt-bindings for controllers not supporting use of the
> power-domains prop and enables the PD_RKVENC, PD_VO and PD_VPU domains.
>
> pm_genpd_summary on a Radxa E20C after this:
>
>   domain                          status          children        performance
>       /device                         runtime status                  managed by
>   ------------------------------------------------------------------------------
>   vpu                             on                              0
>       ffaf0000.gpio                   unsupported                 0           SW
>       ffb10000.gpio                   unsupported                 0           SW
>       ffbe0000.ethernet               active                      0           SW
>       ffae0000.adc                    unsupported                 0           SW
>       ffbf0000.mmc                    suspended                   0           SW
>   vo                              on                              0
>       ffb00000.gpio                   unsupported                 0           SW
>       ffc30000.mmc                    suspended                   0           SW
>   venc                            on                              0
>       ffb20000.gpio                   unsupported                 0           SW
>       ffa58000.i2c                    unsupported                 0           SW
>   gpu                             off-0                           0
>       ff700000.gpu                    suspended                   0           SW
>
> Jonas Karlman (9):
>   dt-bindings: power: rockchip: Add support for RK3528
>   pmdomain: rockchip: Add support for RK3528
>   dt-bindings: rockchip: pmu: Add compatible for RK3528
>   arm64: dts: rockchip: Add power controller for RK3528
>   dt-bindings: mmc: sdhci-of-dwcmhsc: Allow use of a power-domain
>   dt-bindings: gpio: rockchip: Allow use of a power-domain
>   dt-bindings: i2c: i2c-rk3x: Allow use of a power-domain
>   dt-bindings: iio: adc: rockchip-saradc: Allow use of a power-domain
>   arm64: dts: rockchip: Enable more power domains for RK3528
>
>  .../devicetree/bindings/arm/rockchip/pmu.yaml |  2 +
>  .../bindings/gpio/rockchip,gpio-bank.yaml     |  3 +
>  .../devicetree/bindings/i2c/i2c-rk3x.yaml     |  3 +
>  .../bindings/iio/adc/rockchip-saradc.yaml     |  3 +
>  .../bindings/mmc/snps,dwcmshc-sdhci.yaml      |  4 -
>  .../power/rockchip,power-controller.yaml      |  1 +
>  arch/arm64/boot/dts/rockchip/rk3528.dtsi      | 87 +++++++++++++++++++
>  drivers/pmdomain/rockchip/pm-domains.c        | 27 ++++++
>  .../dt-bindings/power/rockchip,rk3528-power.h | 19 ++++
>  9 files changed, 145 insertions(+), 4 deletions(-)
>  create mode 100644 include/dt-bindings/power/rockchip,rk3528-power.h
>

Patch 1->3 applied for next, thanks! Note that patch1 and patch 3 are
also available on the immutable dt branch.

Kind regards
Uffe

