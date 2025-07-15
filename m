Return-Path: <linux-pm+bounces-30868-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80842B060F7
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 16:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A50E50303F
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 14:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3E3292B5F;
	Tue, 15 Jul 2025 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L+1//roP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667431F4CB3
	for <linux-pm@vger.kernel.org>; Tue, 15 Jul 2025 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588576; cv=none; b=MdKiPbhij+KrEud7BB3AFlBa3cDmSum8DzlZ/cWDg7qaqkKscdvWGJap4doQhQleuDWMpY+jDWei71lM6d5SUSgUdKcXlNtUb3rWrV6doHnSbZWqEz5aMUxYIvMfsENpMLi4B9piW3Pg0qs6x7P6vnFgjYutXXMvBJ3NSUTEwGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588576; c=relaxed/simple;
	bh=jJTBj4fac1bgJaznP0nVpLk5OWhiPHvmPDoBk2KvbXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LzMB1BwttBZM2pwBcZ3fx24I9+iB7NLaerjP4HiXXRpApV6ILETeUQeh46tHnylQ6X8EL1hLBYPERBqdRDbqzHXLSnqGb/h2WmMFbK5bWG2jd17Umxob5bSMzQqT5JKOzWvck8ed8oSgYuSoawcqO7EqlCVEhWJ4hEotGcnrmwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L+1//roP; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e8bbeee8450so206424276.1
        for <linux-pm@vger.kernel.org>; Tue, 15 Jul 2025 07:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752588573; x=1753193373; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rdR+LRqRBkJBUvCkbRrJJULDxmBDkmzUM6UrN84Yku0=;
        b=L+1//roPMDgq3RPR8h7Vo/VMdYeqZKj8ooDwz1UOXvNXnxMIqZV7OS4DMPaFYCC7+l
         RLBTcNQM0BO5qgzlAVfg48WLxWQKazZjmRvKNIfDe9BElnzVoVo0LX9O/BFkLhI/IiXG
         zUFzuSaa00lVlxtgBT4/15zl7DaX+um5tn6SCiusvS4jdYNlCigGyX7qSb7jvsmRiz9f
         vLTT006V0lBJz+WRCmU4McG5T1TPZ/EVAWfPR5Ovry+FCSZZfkuEf+YCx8/TCzHMCH8X
         hpBndrn64zUaZ2e9L81AJQWJ5sgTW8fok8B4Xx1lo2zFH8J52UHKCvWQJJlP6DRnCvHk
         xB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752588573; x=1753193373;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rdR+LRqRBkJBUvCkbRrJJULDxmBDkmzUM6UrN84Yku0=;
        b=U7ZeVbKWfh/K4eEF+V5d58gQ7aQMKAHstpv77LbK5rUdKGMPPZfELMUP7rO5PzsGyr
         1pzBUziKWveJMOsUQD3fd0FSl5pyBHKd7wpKV2a2w2nCe/yUYKwPx7L88niHRtSYzCDM
         tC/sv+BaRhPQ/CFBJbSslkC+p97iUIv8FYoVhw0bpDYM2PNO44tHa8lLhLpP9Uji4hJV
         pjAh6ZjA8k7j+RGh1qzeCqubx1ul42Y+MMvUOoH7XURwem/NQIyowRuiFBLDi4Tfk+Kl
         7r0LWLMSFsQB0y6Pb5zS9oPxt39Hc1rXxyWKDIz5LikK37C8g2jP4RZqRVvlnD71lhQm
         mBXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKRMXh23wSiybEtuG8t5c2z2FJWjH9ysrxF2s0ZQpz3smjf7ecHFrMFKvYphvE/Y/jKno43bkYEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxorSaE7cKtufX6UekAPeHmquENKkVcXA5sspAmJKjsdlvUEtfj
	NMSqdD6DCmG3nrf5DlNtgNJxsVa+/rORZy/gxBtl4uHUq6p01Rk3SxwDiw3Nds7OHXHzaVi60uY
	shzA9Lb5uZUsvR1FaQAVhTBDCPyg9jA3kRsV/8vMntA==
X-Gm-Gg: ASbGncsKO3i02oJgXFVqYP2uk/KveZbq9avboECDOK4WlwG02YTN6MnViM/HZh1XAoo
	94yqACDi3SJxQ6zgepTQ+9IfznduY626Kz+emccGRal080n+C0hZwdXRa65u26ThxsrUIiyxRg4
	hdbokCcKtqE4bHO6dL1fUus3Rgd0KvuQ3PxZOTpJ+THLRlHvLooSFhEmORS5rF/QP1DwazZByVq
	i+vdydo
X-Google-Smtp-Source: AGHT+IFr5aZe129SXty/aUauZ98iCrC5028PDfP3/dwd83DOGHiwFr2/EEOsdifr9IoyiESxKl68x3MmFGTyJODgVvM=
X-Received: by 2002:a05:690c:b82:b0:712:c295:d010 with SMTP id
 00721157ae682-717d5e2848bmr255785147b3.33.1752588573210; Tue, 15 Jul 2025
 07:09:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250712074021.805953-1-wens@kernel.org>
In-Reply-To: <20250712074021.805953-1-wens@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 15 Jul 2025 16:08:57 +0200
X-Gm-Features: Ac12FXzjyKVG9YpXDr4ujfp7DHXXwLEZE6WjntfBOMpvZOZeuC_qP0opUlbqcZM
Message-ID: <CAPDyKFoSe3sch1ooP7e-TOiB91y=_Q=-FaSooc2ROoMwfEsP+g@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] allwinner: a523: Add power controllers
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej@kernel.org>, 
	Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andre Przywara <andre.przywara@arm.com>, linux-sunxi@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 12 Jul 2025 at 09:40, Chen-Yu Tsai <wens@kernel.org> wrote:
>
> From: Chen-Yu Tsai <wens@csie.org>
>
> Hi folks,
>
> This is v3 of my A523 power controllers series.
>
> Changes since v2:
> - pck600 driver:
>   - Fixed whitespace issue
>   - Added explanation about possible PCK-600 lineage and document
>     references to driver
>   - Changed Kconfig option to tristate
>   - Rewrote Kconfig option help text to make it clear that the driver
>     is required for certain peripherals to work
>   - Made it depend on ARCH_SUNXI or COMPILE_TEST
>   - Made it enabled by default for ARCH_SUNXI
>   - Renamed PPU_PWSR_PWR_STATUS to PPU_PWR_STATUS, and added a comment
>     to note the macro is shared between two registers
> - New patch changing sun20i-ppu driver to tristate, and enable by
>   default for ARCH_SUNXI
> - Fixed pck-600 header path in dtsi file
> - Link to v2:
>   https://lore.kernel.org/all/20250709155343.3765227-1-wens@kernel.org/
>
> Changes since v1:
> - Re-order compatible string entries
> - Fix name of header file to match compatible string
> - Link to v1:
>   https://lore.kernel.org/all/20250627152918.2606728-1-wens@kernel.org/
>
> This series adds the power controllers found in the Allwinner A523
> family of SoCs. There are two power controllers. One is the same type
> as those found in the D1 SoC, just with a different number of valid
> power domains. The second is (I assume) a unit based on ARM's PCK-600
> power controller. Some of the registers and values match up, but there
> are extra registers for delay controls in the PCK-600's reserved
> register range.
>
> Patch 1 adds new compatible string entries for both of these
> controllers.
>
> Patch 2 adds support for the A523 PPU to the existing D1 PPU driver.
>
> Patch 3 adds a new driver of the PCK-600 unit in the A523 SoC.
>
> Patch 4 aligns Kconfig dependencies and default for SUN20I_PPU with the
> new PCK-600 driver.
>
> Patch 5 adds device nodes for both of these controllers.
>
>
> Please have a look. The power controllers are critical for enabling more
> peripherals, such as display output, camera input, video codecs, the NPU,
> and a second DWMAC-compatible ethernet interface.
>
>
> Thanks
> ChenYu
>
>
> Chen-Yu Tsai (5):
>   dt-bindings: power: Add A523 PPU and PCK600 power controllers
>   pmdomain: sunxi: sun20i-ppu: add A523 support
>   pmdomain: sunxi: add driver for Allwinner A523's PCK-600 power
>     controller
>   pmdomain: sunxi: sun20i-ppu: change to tristate and enable for
>     ARCH_SUNXI
>   arm64: dts: allwinner: a523: Add power controller device nodes
>
>  .../power/allwinner,sun20i-d1-ppu.yaml        |   4 +-
>  .../arm64/boot/dts/allwinner/sun55i-a523.dtsi |  18 ++
>  drivers/pmdomain/sunxi/Kconfig                |  19 +-
>  drivers/pmdomain/sunxi/Makefile               |   1 +
>  drivers/pmdomain/sunxi/sun20i-ppu.c           |  17 ++
>  drivers/pmdomain/sunxi/sun55i-pck600.c        | 234 ++++++++++++++++++
>  .../power/allwinner,sun55i-a523-pck-600.h     |  15 ++
>  .../power/allwinner,sun55i-a523-ppu.h         |  12 +
>  8 files changed, 316 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/pmdomain/sunxi/sun55i-pck600.c
>  create mode 100644 include/dt-bindings/power/allwinner,sun55i-a523-pck-600.h
>  create mode 100644 include/dt-bindings/power/allwinner,sun55i-a523-ppu.h
>
> --
> 2.39.5
>

Patch 1->4 applied for next (the dt patch is also available on the
immutable dt branch), thanks!

Kind regards
Uffe

