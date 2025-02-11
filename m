Return-Path: <linux-pm+bounces-21838-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6784A30D46
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 14:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DCD83A3945
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 13:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CF62309AF;
	Tue, 11 Feb 2025 13:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcVQPflK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A1F26BD9A;
	Tue, 11 Feb 2025 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739281713; cv=none; b=IIpVMELnTK5JFdV21/yaH9mE6yi1KNPwNMS3zJMC1gay+1kCCUiGOC0uvo5xE/7RbcBZLzbnNjvduY2b74uiMkMb2Gcq2Zn4EXjfuSkH9isyrbgLG42rkpRJrq0pOMp91mBEFkY41sbroUhgplTpgX8HYsueuXIGeTimJe5hLFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739281713; c=relaxed/simple;
	bh=m4AD7l25AQkFx45miPWzhVwRxJcr7K3gU5TBHvJZg1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpEHcns7mhbBwDBemp14qNOaQKmy6O+JKtgMct19eiRSxK/i/fAST9qoMDnwNrt8nrqvjgumR/N1SaH/FT8R3vh+CdukFUYMGemDqHj2ZJlF5M8+ptQT6lA6YAGtSD0UKHs+x9A/EuNHvRQxk5mLiYpSrl+AiMmIIYopwC04STQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcVQPflK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55D5C4CEDD;
	Tue, 11 Feb 2025 13:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739281712;
	bh=m4AD7l25AQkFx45miPWzhVwRxJcr7K3gU5TBHvJZg1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mcVQPflKFMGoFzsFfHOsGL1PwQhEKzlleh8Z7aEpchFrTuDQWFtAEziZt/fYy546n
	 nkK+3UAReOzjD1YMoeLjznwqK+e7DDZ+6lW9lq5yAhkG7vMloOP2UnFThpMo6kh0lB
	 spnwOSgNPjHjnPxvTW7gzxLcU026tU/JychinezqD9mhQrevMGDezrweJsX99g0nHp
	 PomcPn7yA4YRn3VBUoNgyAV7IZbR8GbLwIUlLK+6npQJvBObyzBReoxMNAI3Amh+vZ
	 wc0nqLLs07OcGqhabSAMNURKk27r6PgeT4nXy51ARGH0Ndu3CifTgtPY/TL5BaLCSR
	 jB0i3eDhRpoFw==
Date: Tue, 11 Feb 2025 13:48:26 +0000
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
Message-ID: <20250211-stubble-senate-0bbb0b04a989@spud>
References: <20250210220951.1248533-1-alexander.sverdlin@gmail.com>
 <20250211-backwash-jester-2fdd6740000e@spud>
 <b1f05bff1d6c3f0cb1b381c15dcf222ec4c7f1b1.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MwDx1V044X6pY5Zr"
Content-Disposition: inline
In-Reply-To: <b1f05bff1d6c3f0cb1b381c15dcf222ec4c7f1b1.camel@gmail.com>


--MwDx1V044X6pY5Zr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 01:43:31PM +0100, Alexander Sverdlin wrote:
> Hi Conor!
>=20
> On Tue, 2025-02-11 at 10:50 +0000, Conor Dooley wrote:
> > On Mon, Feb 10, 2025 at 11:09:40PM +0100, Alexander Sverdlin wrote:
> > > This series adds very basic support for Milk-V Duo Module 01 EVB [1] =
in
> > > arm64 mode. The SoC (SG2000) is dual-arch, RiscV and ARM64, the latte=
r has
> > > been chosen because the upstream toolchain can be utilized.
> >=20
> > > =A0 .../{riscv =3D> soc/sophgo}/sophgo.yaml=A0=A0=A0=A0=A0=A0=A0=A0 |=
=A0 7 +-
> > > =A0 arch/arm64/Kconfig.platforms=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |=A0 6 ++
> > > =A0 arch/arm64/boot/dts/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |=A0 1 +
> > > =A0 arch/arm64/boot/dts/sophgo/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 |=A0 2 +
> >=20
> > I'd expect this to be maintained alongside the riscv support, how come
> > there's no maintainers entry change here?
>=20
> MAINTAINERS file has "K: sophgo" entry already, I suppose new files will
> fall into this category? That's why I've ignored this specific checkpatch=
 warning
> in all patches. Am I wrong?

Ah, I didn't realise.

>=20
> > > =A0 .../sophgo/sg2000-milkv-duo-module-01-evb.dts | 31 +++++++
> > > =A0 .../sophgo/sg2000-milkv-duo-module-01.dtsi=A0=A0=A0 | 85 ++++++++=
+++++++++
> > > =A0 arch/arm64/boot/dts/sophgo/sg2000.dtsi=A0=A0=A0=A0=A0=A0=A0 | 75 =
+++++++++++++++
> > > =A0 arch/arm64/configs/defconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |=A0 5 +
> > > =A0 arch/riscv/boot/dts/sophgo/cv1800b.dtsi=A0=A0=A0=A0=A0=A0 | 64 ++=
++++++++---
> > > =A0 arch/riscv/boot/dts/sophgo/cv1812h.dtsi=A0=A0=A0=A0=A0=A0 | 64 ++=
++++++++---
> > > =A0 arch/riscv/boot/dts/sophgo/cv181x.dtsi=A0=A0=A0=A0=A0=A0=A0 |=A0 =
2 +-
> > > =A0 arch/riscv/boot/dts/sophgo/cv18xx-cpu.dtsi=A0=A0=A0 | 57 ++++++++=
++++
> > > =A0 arch/riscv/boot/dts/sophgo/cv18xx.dtsi=A0=A0=A0=A0=A0=A0=A0 | 91 =
+++++--------------
> > > =A0 arch/riscv/boot/dts/sophgo/sg2002.dtsi=A0=A0=A0=A0=A0=A0=A0 | 64 =
++++++++++---
> > > =A0 14 files changed, 451 insertions(+), 103 deletions(-)
> > > =A0 rename Documentation/devicetree/bindings/{riscv =3D> soc/sophgo}/=
sophgo.yaml (80%)
> > > =A0 create mode 100644 arch/arm64/boot/dts/sophgo/Makefile
> > > =A0 create mode 100644 arch/arm64/boot/dts/sophgo/sg2000-milkv-duo-mo=
dule-01-evb.dts
> > > =A0 create mode 100644 arch/arm64/boot/dts/sophgo/sg2000-milkv-duo-mo=
dule-01.dtsi
> > > =A0 create mode 100644 arch/arm64/boot/dts/sophgo/sg2000.dtsi
> > > =A0 create mode 100644 arch/riscv/boot/dts/sophgo/cv18xx-cpu.dtsi
>=20
> --=20
> Alexander Sverdlin.
>=20

--MwDx1V044X6pY5Zr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ6tVKgAKCRB4tDGHoIJi
0ryCAQCUpDB6cCAXqj3ZVyMpBboraj1VJvvnCB34OKgyUALr6AEAqOw2FC6cSonT
W2P4mgYpwfIsREbExnYGXzdSKPmwnAU=
=5MES
-----END PGP SIGNATURE-----

--MwDx1V044X6pY5Zr--

