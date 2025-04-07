Return-Path: <linux-pm+bounces-24885-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D921AA7E587
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 18:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721FD3B083A
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 15:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829BB204F97;
	Mon,  7 Apr 2025 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xe5YDho2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581BD1C1AD4;
	Mon,  7 Apr 2025 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744041047; cv=none; b=fs52c0DURvosjwLf0JvMFNHnPmCR/sutT7PmROlohjwk8QJ5gZQ2DCiJD3gv/a3GpHOUDhRaAtcFhrNGlWmIbibVwKL8WDTPwV4fEksTMjFlNtvKcQs8UgkesPOLUqCLUuOFIrm937nBcMiOAaoizm9CMk4YgyhKBQL8EjfSdVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744041047; c=relaxed/simple;
	bh=HOVDM5euQFPEYRsSiD6INj8UKBND48N799jToiiUcwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4CfPnv//IKJR0zv8QvCQ2qgP5XW36ItgYCh8iv8s1IS5nElA7FTI1KPS5FzGThKe6Y9O/rKyrMsC1ymM2WGlYN1FIhGQgVX6cF+kgNGScIGLESImikURyga+L4g+fS7FJD9jRgeJetSafqqxPShVn+hWqI8rMHp2nQ/U8xjti4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xe5YDho2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89AAC4CEE9;
	Mon,  7 Apr 2025 15:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744041047;
	bh=HOVDM5euQFPEYRsSiD6INj8UKBND48N799jToiiUcwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xe5YDho20tt0siJerFzpmq9NDCAWHIYtVGUro+LhqodieEuMdX1pzUrpO+VGSpNOq
	 vdkCmy6gSbV1u6JVxZzIBd/IMiO8VXy/kkLE9hdndv16ribWcRslGQvqz5SK1Po17Y
	 393sKyBd68Uy7PNdkAfil3fYnhm1ipP67KyqsrZc0KryQ5IbSz30kcVHVn+svRpveX
	 x9iRGix2zt2ssYZuEo1SQ56H7fTRcmyfab/94gClr6VDZ6lQTM6v0UeWORPDMGsUeH
	 Pru+qlgwBH5BYsS+JLfEp2YLGcYygCaOnl0FQ8vLyiU2GbSmEMYzmdASdyauQjw8zl
	 euhgED/iB1JQQ==
Date: Mon, 7 Apr 2025 16:50:41 +0100
From: Conor Dooley <conor@kernel.org>
To: Drew Fustini <drew@pdp7.com>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, guoren@kernel.org,
	wefu@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, jszhang@kernel.org,
	ulf.hansson@linaro.org, m.szyprowski@samsung.com,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 5/5] riscv: Enable PM_GENERIC_DOMAINS for T-Head SoCs
Message-ID: <20250407-synergy-staff-b1cec90ffe72@spud>
References: <20250311171900.1549916-1-m.wilczynski@samsung.com>
 <CGME20250311172035eucas1p104dcbae706bec735194a1dc4a30db969@eucas1p1.samsung.com>
 <20250311171900.1549916-6-m.wilczynski@samsung.com>
 <Z/ArFVx6l5Urh9KV@x1>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1GHzjvTYK5Cechhc"
Content-Disposition: inline
In-Reply-To: <Z/ArFVx6l5Urh9KV@x1>


--1GHzjvTYK5Cechhc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 04, 2025 at 11:55:17AM -0700, Drew Fustini wrote:
> On Tue, Mar 11, 2025 at 06:19:00PM +0100, Michal Wilczynski wrote:
> > T-Head SoCs feature separate power domains (power islands) for major
> > components like the GPU, Audio, and NPU. To manage the power states of
> > these components effectively, the kernel requires generic power domain
> > support.
> >=20
> > This commit enables `CONFIG_PM_GENERIC_DOMAINS` for T-Head SoCs,
> > allowing the power domain driver for these components to be compiled and
> > integrated. This ensures proper power management and energy efficiency
> > on T-Head platforms.
> >=20
> > By selecting `PM_GENERIC_DOMAINS`, we provide the necessary framework
> > for the power domain drivers to function correctly on RISC-V
> > architecture with T-Head SoCs.
> >=20
> > Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> > ---
> >  arch/riscv/Kconfig.socs | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > index 1916cf7ba450..83833ded8908 100644
> > --- a/arch/riscv/Kconfig.socs
> > +++ b/arch/riscv/Kconfig.socs
> > @@ -53,6 +53,7 @@ config ARCH_THEAD
> >  	bool "T-HEAD RISC-V SoCs"
> >  	depends on MMU && !XIP_KERNEL
> >  	select ERRATA_THEAD
> > +	select PM_GENERIC_DOMAINS if PM
> >  	help
> >  	  This enables support for the RISC-V based T-HEAD SoCs.
> > =20
> > --=20
> > 2.34.1
> >=20
>=20
> Reviewed-by: Drew Fustini <drew@pdp7.com>
>=20
> Conor - would you be able to take this Kconfig.socs patch?

I can I suppose, sure.

--1GHzjvTYK5Cechhc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ/P0UQAKCRB4tDGHoIJi
0iqrAP98LTJtRIOeY8UUUHZUC78KX8XxI12BXLyp4jgDxClmsgEA0QO0tJ0PHxnZ
yruNFvb0b0zbXqoxQUCkKLMZmgOsDQM=
=bAyp
-----END PGP SIGNATURE-----

--1GHzjvTYK5Cechhc--

