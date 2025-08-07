Return-Path: <linux-pm+bounces-32046-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88140B1DAE7
	for <lists+linux-pm@lfdr.de>; Thu,  7 Aug 2025 17:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 637947A8DAD
	for <lists+linux-pm@lfdr.de>; Thu,  7 Aug 2025 15:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D8126A08D;
	Thu,  7 Aug 2025 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDdnwW0D"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CDB26562A;
	Thu,  7 Aug 2025 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754581237; cv=none; b=Q3aA16kdoywiNXcGYjamafsOZwfbOn+ipAfoSKsSj3CBP807y69PGwLUkacOpYaEbV+43ROCy9QTyJ4RIrndcCvTrbsXp+45/HwQJoWWsqNl9WBM+Zu1zwCdeSt+IVkDRgMb8lXNygxD04aCB2lohorEDDrGPzjqqO10YV/1NrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754581237; c=relaxed/simple;
	bh=oxkXLZvPp3BqQEgtA6OlLjO1pulHs/NQGwamKgBjikQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7xumc6mtPahNAR0h+jX3S5hH28CttGlEaOJneAyg9Q69eDoUcdQauA+1qi4rGzo91x0zclgxmEB7fp0CTu9/IaB9kufcsUVTsexFirQvNeyIKj4hcxDDUumGKmSox1eFNdO0j/mj6+4pZfZd4zxngLs2mttj1JxdmtunLOp/ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDdnwW0D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B39CC4CEEB;
	Thu,  7 Aug 2025 15:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754581234;
	bh=oxkXLZvPp3BqQEgtA6OlLjO1pulHs/NQGwamKgBjikQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rDdnwW0DKcf/KVyf/uUqQ8cftSD+Xa9fB2BIXHgOnz7NdndcxH2o+EPXPHUVwwAeb
	 CEPycnxuWPsTGUfG3cL65ht6RKlV99cwxjQUTRmqEbZ9uJ40mxPS6CKA8EKyXQ+6Cb
	 uJag1T1BbVniRqyZuK3rXvJpSWiR70+E3WkXllCLdHFZB0dsElwF37SsTNpf96w8Kz
	 NdolM9USSXP1YkV/ehKsWaHmVypfFMkXVQ/+1J+gTT4i6M0OzQ9KKSb1fEpMy7J1Ce
	 bvtImt3bohQcqn2mUV4blTq6Z/dw/PjdX/7qEfhs1wyO4nlfz8L+dNYEce1yOkSeqg
	 xhj1OqNdeEPqw==
Date: Thu, 7 Aug 2025 16:40:28 +0100
From: Conor Dooley <conor@kernel.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	David Wronek <david@mainlining.org>, Karel Balej <balejk@matfyz.cz>,
	phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH RFC 0/5] Marvell PXA1908 power domains
Message-ID: <20250807-avatar-comply-30aa8001aa82@spud>
References: <20250806-pxa1908-genpd-v1-0-16409309fc72@dujemihanovic.xyz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="61gm189z7gN5234q"
Content-Disposition: inline
In-Reply-To: <20250806-pxa1908-genpd-v1-0-16409309fc72@dujemihanovic.xyz>


--61gm189z7gN5234q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 06, 2025 at 07:33:19PM +0200, Duje Mihanovi=C4=87 wrote:
> Hello,
>=20
> This series implements support for the power domains found in Marvell's
> PXA1908 SoC. The domains control power for the graphics, video and image
> processors along with the DSI PHY.
>=20
> The series is based on master as the MAINTAINERS and device tree patches
> depend on the very recently merged initial Marvell PXA1908 support series.
> That series can be found at the following link:
> https://lore.kernel.org/all/20250708-pxa1908-lkml-v16-0-b4392c484180@duje=
mihanovic.xyz

It's not clear to me, nor mentioned anywhere I could see, why this is an
RFC. What are you actually soliciting feedback on?

>=20
> Signed-off-by: Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>
> ---
> Duje Mihanovi=C4=87 (5):
>       dt-bindings: clock: marvell,pxa1908: Add simple-mfd, syscon compati=
ble to apmu
>       dt-bindings: power: Add Marvell PXA1908 domains
>       pmdomain: marvell: Add PXA1908 power domains
>       MAINTAINERS: PXA1908: Add power domain controller
>       arm64: dts: marvell: pxa1908: Add power controller
>=20
>  .../devicetree/bindings/clock/marvell,pxa1908.yaml |  36 ++-
>  .../power/marvell,pxa1908-power-controller.yaml    | 105 +++++++
>  MAINTAINERS                                        |   5 +
>  .../marvell/mmp/pxa1908-samsung-coreprimevelte.dts |   1 +
>  arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi       |  36 ++-
>  drivers/pmdomain/Kconfig                           |   1 +
>  drivers/pmdomain/Makefile                          |   1 +
>  drivers/pmdomain/marvell/Kconfig                   |  16 +
>  drivers/pmdomain/marvell/Makefile                  |   3 +
>  .../pmdomain/marvell/pxa1908-power-controller.c    | 347 +++++++++++++++=
++++++
>  include/dt-bindings/power/marvell,pxa1908-power.h  |  17 +
>  11 files changed, 561 insertions(+), 7 deletions(-)
> ---
> base-commit: cca7a0aae8958c9b1cd14116cb8b2f22ace2205e
> change-id: 20250803-pxa1908-genpd-15918db5260c
>=20
> Best regards,
> --=20
> Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>
>=20

--61gm189z7gN5234q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaJTI7AAKCRB4tDGHoIJi
0qRUAPsGIBNq7EJeNjCewk/s7WezXIszK4j07CCitkja8bCHUQD/QUq7puCrhLyP
vAJwA5dguhkavA4C1I5FPJDQbUdK5gM=
=rOfT
-----END PGP SIGNATURE-----

--61gm189z7gN5234q--

