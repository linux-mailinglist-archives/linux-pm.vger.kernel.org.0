Return-Path: <linux-pm+bounces-21813-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B07BA3091E
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 11:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 097571624D1
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 10:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888F71F4604;
	Tue, 11 Feb 2025 10:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WY+6xnxV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5406E1C3308;
	Tue, 11 Feb 2025 10:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739271051; cv=none; b=D7y8bbVwM/FBzh6F472G0bwI/H4uei2Cyelsv6FHaVD/C+uprgZq76t0wuaH9rMUszeQ4T4D7E5RnmE1Y54qW//+2PqTRyOtqwJ0iUeMMyWcREOcH4cW4bigLBkXotKyRl1VLa0qTJGNU217GUcYfayov4eVnUEckUsNY7QdkcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739271051; c=relaxed/simple;
	bh=013p6U9CkyzGbsFMDw5hD4LtqAl6uIDMuNEstJ38EU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjIh0kCGPAUCsRMwGqDloDMrYXkYTbEbEuhbFD0ShTmjmWyQWBZtuMr4mZL4JXrutEHKxXUXew+++RirBCaP6njYWME//NKFs+h84ZGLEwostPan8DK+GIhmHyzp0P9L+/KTfJYJs7BelY6AOGZlmtp/u6uyDaC/1wC5qkv1QEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WY+6xnxV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D78EC4CEE4;
	Tue, 11 Feb 2025 10:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739271050;
	bh=013p6U9CkyzGbsFMDw5hD4LtqAl6uIDMuNEstJ38EU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WY+6xnxVmSDxLNxTyv2FsAUgLaXUGS7FvHBvsBWLGeg6ohEEo/EnnCLl6QcwwctMZ
	 LzuoHFo4xJZTMmWSreF8xvpn8B5Y9JRiDYcvsRyFOqD/JnE9m2Cgvg/UblMxnXaf9h
	 qZTufFjmLAALumQ45jOmnsv2dig7BUpqT5dZmMNE/2vJMdCYH2x7BvsVS1cvMyTWJd
	 EVtX+8+fd2g7aZ/1rTN0QqqrKH8zmcGr20Z1byhEcnM4Txr2Xi18QjQUqkLYUrMUwi
	 p//l+oAdhcnxtNWFQ3JVEZEaUGWnthIUirtpLxYtxr2AXGzFO+sEej+nmE/bllDE4t
	 soBfwy0okj4OQ==
Date: Tue, 11 Feb 2025 10:50:44 +0000
From: Conor Dooley <conor@kernel.org>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: soc@lists.linux.dev, Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
	Haylen Chu <heylenay@outlook.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
	Jisheng Zhang <jszhang@kernel.org>, Chao Wei <chao.wei@sophgo.com>
Subject: Re: [PATCH v2 0/7] arm64 support for Milk-V Duo Module 01 EVB
Message-ID: <20250211-backwash-jester-2fdd6740000e@spud>
References: <20250210220951.1248533-1-alexander.sverdlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tVnH0HVkr/l99Dz5"
Content-Disposition: inline
In-Reply-To: <20250210220951.1248533-1-alexander.sverdlin@gmail.com>


--tVnH0HVkr/l99Dz5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 10, 2025 at 11:09:40PM +0100, Alexander Sverdlin wrote:
> This series adds very basic support for Milk-V Duo Module 01 EVB [1] in
> arm64 mode. The SoC (SG2000) is dual-arch, RiscV and ARM64, the latter has
> been chosen because the upstream toolchain can be utilized.

>  .../{riscv => soc/sophgo}/sophgo.yaml         |  7 +-
>  arch/arm64/Kconfig.platforms                  |  6 ++
>  arch/arm64/boot/dts/Makefile                  |  1 +
>  arch/arm64/boot/dts/sophgo/Makefile           |  2 +

I'd expect this to be maintained alongside the riscv support, how come
there's no maintainers entry change here?

>  .../sophgo/sg2000-milkv-duo-module-01-evb.dts | 31 +++++++
>  .../sophgo/sg2000-milkv-duo-module-01.dtsi    | 85 +++++++++++++++++
>  arch/arm64/boot/dts/sophgo/sg2000.dtsi        | 75 +++++++++++++++
>  arch/arm64/configs/defconfig                  |  5 +
>  arch/riscv/boot/dts/sophgo/cv1800b.dtsi       | 64 ++++++++++---
>  arch/riscv/boot/dts/sophgo/cv1812h.dtsi       | 64 ++++++++++---
>  arch/riscv/boot/dts/sophgo/cv181x.dtsi        |  2 +-
>  arch/riscv/boot/dts/sophgo/cv18xx-cpu.dtsi    | 57 ++++++++++++
>  arch/riscv/boot/dts/sophgo/cv18xx.dtsi        | 91 +++++--------------
>  arch/riscv/boot/dts/sophgo/sg2002.dtsi        | 64 ++++++++++---
>  14 files changed, 451 insertions(+), 103 deletions(-)
>  rename Documentation/devicetree/bindings/{riscv => soc/sophgo}/sophgo.yaml (80%)
>  create mode 100644 arch/arm64/boot/dts/sophgo/Makefile
>  create mode 100644 arch/arm64/boot/dts/sophgo/sg2000-milkv-duo-module-01-evb.dts
>  create mode 100644 arch/arm64/boot/dts/sophgo/sg2000-milkv-duo-module-01.dtsi
>  create mode 100644 arch/arm64/boot/dts/sophgo/sg2000.dtsi
>  create mode 100644 arch/riscv/boot/dts/sophgo/cv18xx-cpu.dtsi


--tVnH0HVkr/l99Dz5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ6srgQAKCRB4tDGHoIJi
0puLAQCT0dLjiS8f39e7ltuZPdGjdh8a4aC4NpEw33b3OSuNugD/Z7NyHS2OtCHX
teoIJE271CYirlmdAMsth4TJLf2e/w4=
=lK/q
-----END PGP SIGNATURE-----

--tVnH0HVkr/l99Dz5--

