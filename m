Return-Path: <linux-pm+bounces-21622-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA46A2E36F
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 06:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F8A188269A
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 05:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADEA17C220;
	Mon, 10 Feb 2025 05:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0OdoDze"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720F715A87C;
	Mon, 10 Feb 2025 05:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739164514; cv=none; b=GUvsnb999DiE7tzZlcWPf9TfhH8YkcPd4FVNpKA+Ytu2LSycBX9kpp4TuDRQ32usSKlDCwq/BthEbGrFpDYcKYXy3sCXGwzYSffWkL+KA7C10/M2yH2b6aBQeweZED+205+lkQ3RHUoSElCFeTFTHt5YFqC0PSsCLOnmOuwNHH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739164514; c=relaxed/simple;
	bh=MG3Ad9L3pB9/1Waq7rcu6JsxoIBzEerr0O3vqh6hS/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCBMYBLnXdgbaUwdZswe4xHMbBpdntcxJxlglUnQvpPN4bHH5wbDjxG7LzoU/L+bypTR8LHKNt15JD3UOAEMsjXO7D5DDWykTygQQYac+x/1Rjo6VB+6pGZQqts7LM+3VxfxcyinN/sHhsJMjjjfTJjDewooWq+oCZrYNGUUndM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0OdoDze; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e4562aa221so11900426d6.0;
        Sun, 09 Feb 2025 21:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739164511; x=1739769311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GniGuM78BIcAr7ts8pXvWJNfUZLhduP49+7UQWf5Z0E=;
        b=m0OdoDzeERryL/Y2VHcNsleGeLNkuuePGG27XA1TKjQQvlVbdTBVffY/JIrI6cBgMW
         XcLmFgvM3VvYTMZ2yzuKCLzPNjl0nfs83+fdj5H8Fn9XCm2NPC9ana0k+Tg6FaxrVYV8
         5bTg5uoibPLozia6CGX0vQs6UPQxz02DrgUAXhnWsVn4X/vGCHncoeCF2BU6y7jB9ur1
         n9c/2Cy40vzIGVxzT9RNz/uDT2MhQqP3iUYwTJdB6sUVNEnCJmUBCkNTJPoEvLkDPwnH
         tyorwmL8+WdIcvSrnRMb3tzYd0DI2tfZqU1gbIamXzLsz1RjE7aX0WGkC49hQs7fJabC
         k3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739164511; x=1739769311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GniGuM78BIcAr7ts8pXvWJNfUZLhduP49+7UQWf5Z0E=;
        b=DZnR6rP5Be6qZ7ZVfaQLUrlEmQ0ts4F/kvXZ9kkZPhvGl7saG/Pg0oUwuyMEDgs8X4
         9wIXQ2gAzRNgwWa1Tke267IXvXDkUrtHL+Awb8soPdttq5X3CNdA9r59pHELawRnbiLJ
         uextW4XjkEZZJm07oF6fZ+WE7ZPObWgo9gpVzQ/elMiw/ocRix75vm0Wjd1a5OJWneE4
         YdDvkJBriR+vRDtJ+W8BlIJu7soEpEtmlWW/+MuWycb1VCImrg5KQDHCzcKqqYWhAmsb
         S5zqoQ759gQiZBW9lcWaZ0g+5n0OL7Uiu/S4PKcyQBfgAj5f1OqqpdyxAlvzgJA10ORv
         HFkw==
X-Forwarded-Encrypted: i=1; AJvYcCV2zEd+k1ILaCwqGQFArVIxeeo7G2e7FdsIx05FCfPDgf7N6ujRFuyAmVKLAn78qdyM9mV0Qplag10h@vger.kernel.org, AJvYcCW7qs1WlaigFeD5kiu9UCTWyY8/YxJtJlm657NXqDhFglZqRRBiEp1RFY6HlE6RcGXZDB5CPUoAv3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHyLoh0jEw2Q7aozNEbBLhYN9wgnZBmkb9hLjoB2pb5uVVjK7U
	FzvylurPzOkJz+nvWGpzuCUKb9vZMFufgN50GhTeFJ+cGXU448S/
X-Gm-Gg: ASbGnctktZ4CX0hIlxHhLoijk9MJ5QQK2GE6Q8S6dZFxZnPWBl7nSEUksQKZrc4EixT
	1Hs5HUz9A5XEFWcRLRKAIPixjwGAZ0DSoglsvQlDH+uB9QOrjyYGcSjzFkTzHPkM6WJjtcIgkx2
	n3HJYxg0VFn2RN+Zp2zcBtQb0dKA5JOrW1a12BcEOZ68Jezosbhxhh3dD0XYplQngp71D3E2LSN
	lee2CgXNcGIeAV7hv6A6Hzj2cLxSSuwd86xj04obB+vRKfp7J4xt4jM8Ukkx/rngTA=
X-Google-Smtp-Source: AGHT+IH28KSGQngpOC4sMgaBVZJQsS3ItIqPoUQbHrVhyVBUOfjf9q5guk+CZKNPKJ4L2waMIxeNTQ==
X-Received: by 2002:ad4:5caf:0:b0:6da:dc79:a3cd with SMTP id 6a1803df08f44-6e4453fdde1mr194721716d6.0.1739164511260;
        Sun, 09 Feb 2025 21:15:11 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e460380644sm8468166d6.120.2025.02.09.21.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 21:15:10 -0800 (PST)
Date: Mon, 10 Feb 2025 13:15:05 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Chen Wang <unicorn_wang@outlook.com>, soc@lists.linux.dev, 
	Inochi Amaoto <inochiama@outlook.com>, Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org, 
	Haylen Chu <heylenay@outlook.com>, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, Inochi Amaoto <inochiama@gmail.com>
Subject: Re: [PATCH 00/10] arm64 support for Milk-V Duo Module 01 EVB
Message-ID: <xfvvie67ncfy5vnmk2lcjatvpmyneponc7ex4nv7otiiolruij@ejpqdomocv7z>
References: <20250209220646.1090868-1-alexander.sverdlin@gmail.com>
 <BMXPR01MB244050BA1841F4416FF0484CFEF22@BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BMXPR01MB244050BA1841F4416FF0484CFEF22@BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM>

On Mon, Feb 10, 2025 at 08:02:12AM +0800, Chen Wang wrote:
> 
> On 2025/2/10 6:06, Alexander Sverdlin wrote:
> > This series adds very basic support for Milk-V Duo Module 01 EVB [1] in
> > arm64 mode. The SoC (SG2000) is dual-arch, RiscV and ARM64, the latter has
> > been chosen because the upstream toolchain can be utilized.
> > 
> > Sophgo SG2000 seems to be a continuation of the Cvitek CV18xx series, same
> > peripherals with an addition of ARM64 core. Therefore it would be
> > beneficial not to copy-paste the peripherals' device-tree, but rather split
> > the most suitable riscv DT into ARCH-specific and peripherals parts and
> > just include the latter on the arm64 side.
> > 
> > This series adds the device-tree for Milk-V Duo Module 01 EVB, which
> > in turn contains Milk-V Duo Module 01 (separate .dtsi) on it, which has
> > SG2000 SoC inside (separate .dtsi).
> > 
> > This series has been tested with Sophgo-provided U-Boot binary [2]: it
> > boots from SD card, pinctrl, serial, GPIO drivers are functional (same
> > as for RiscV-based CV18xx SoCs).
> > New reset driver is provided as an alternative to the ATF PSCI handler,
> > which Sophgo only provides in binary form.
> 
> I just see Inochi posted a patchset about cv18xx reset driver [1]. FYI.
> 
> Maybe you and Inochi need to communicate with each other and synchronize the
> related work in this regard.
> 
> Link: https://lore.kernel.org/linux-riscv/20250209122936.2338821-1-inochiama@gmail.com/
> [1]
> 

It is a power restart device, not the reset controller, I suggests you change
the device name.

> > 
> > Partial SoC documentation is available [3].
> > 
> > This series lacks the support of:
> > - USB
> > - Audio
> > - Ethernet
> > - WiFi
> > - Bluetooth
> > - eMMC
> > - Video
> > 
> > It would probably make sense that the whole series would go into SOC tree,
> > even though technically nothing prevents the reboot/reset driver to come
> > in PM/reset tree. If everything would come together, `reboot` command would
> > work out of the box.
> > 
> > [1] https://milkv.io/docs/duo/getting-started/duo-module-01
> > [2] https://github.com/milkv-duo/duo-buildroot-sdk-v2/releases/
> > [3] https://github.com/sophgo/sophgo-doc/releases/download/sg2000-trm-v1.01/sg2000_trm_en.pdf
> > 
> > Alexander Sverdlin (10):
> >    arm64: Add SOPHGO SOC family Kconfig support
> >    riscv: dts: sophgo: cv18xx: Split into CPU core and peripheral parts
> >    arm64: dts: sophgo: Add initial SG2000 SoC device tree
> >    arm64: dts: sophgo: Add Duo Module 01
> >    arm64: dts: sophgo: Add Duo Module 01 Evaluation Board
> >    dt-bindings: mfd: syscon: Add Cvitek CV18xx rtcsys core and ctrl
> >      compatible
> >    dt-bindings: reset: sophgo: Add CV18xx reset controller
> >    riscv/arm64: dts: cv18xx: Add sysctl and reset nodes
> >    power: reset: cv18xx: New driver
> >    arm64: defconfig: Enable rudimentary Sophgo SG2000 support
> > 
> >   .../devicetree/bindings/mfd/syscon.yaml       |   4 +
> >   .../bindings/reset/sophgo,cv1800-reset.yaml   |  38 ++
> >   MAINTAINERS                                   |   1 +
> >   arch/arm64/Kconfig.platforms                  |  12 +
> >   arch/arm64/boot/dts/Makefile                  |   1 +
> >   arch/arm64/boot/dts/sophgo/Makefile           |   2 +
> >   arch/arm64/boot/dts/sophgo/sg2000.dtsi        |  79 +++++
> >   .../sophgo/sg2000_milkv_duo_module_01.dtsi    |  84 +++++
> >   .../sophgo/sg2000_milkv_duo_module_01_evb.dts |  30 ++
> >   arch/arm64/configs/defconfig                  |   3 +
> >   arch/riscv/boot/dts/sophgo/cv181x.dtsi        |   2 +-
> >   arch/riscv/boot/dts/sophgo/cv18xx-periph.dtsi | 329 ++++++++++++++++++
> >   arch/riscv/boot/dts/sophgo/cv18xx.dtsi        | 305 +---------------
> >   drivers/power/reset/Kconfig                   |  12 +
> >   drivers/power/reset/Makefile                  |   1 +
> >   drivers/power/reset/cv18xx-reset.c            |  89 +++++
> >   16 files changed, 689 insertions(+), 303 deletions(-)
> >   create mode 100644 Documentation/devicetree/bindings/reset/sophgo,cv1800-reset.yaml
> >   create mode 100644 arch/arm64/boot/dts/sophgo/Makefile
> >   create mode 100644 arch/arm64/boot/dts/sophgo/sg2000.dtsi
> >   create mode 100644 arch/arm64/boot/dts/sophgo/sg2000_milkv_duo_module_01.dtsi
> >   create mode 100644 arch/arm64/boot/dts/sophgo/sg2000_milkv_duo_module_01_evb.dts
> >   create mode 100644 arch/riscv/boot/dts/sophgo/cv18xx-periph.dtsi
> >   create mode 100644 drivers/power/reset/cv18xx-reset.c
> > 

