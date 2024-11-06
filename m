Return-Path: <linux-pm+bounces-17075-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A909BF309
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 17:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087521F214CF
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 16:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343B9201021;
	Wed,  6 Nov 2024 16:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOIN6gWB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D2C18B48B;
	Wed,  6 Nov 2024 16:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730909796; cv=none; b=p60NoiWOy8x8+ZUPQ7ZkAzeLtzMi8l4oalRAz+WbzfyK8+p6mzIyyVz5RtK8WH5Ja6YWZIxUT4yw2f6lrc0FTBK/YDCtCKG7ZRzzVwkfmgHd5Kc64NnGhVvQMDNhP97VhEw7avvqmF2auntZPzn/9LXyFgqRTdgK+I7jnMT45/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730909796; c=relaxed/simple;
	bh=qRGU4RUqChfhcxpb0dUaFVDhL+6ttSNAKLTGzeeHc8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXZwB17istnZaPoYI2Y11f4qbNaAqj1e9yHZs9PsDOUK5X+YFH+N3y/ZvEpjd0Tiy9uKAdVlNQGmX6CB6y14rFnKSD5zYgyTofUayI6iUCeFa4PRQmOco+4a9bFwwAMFp1Rb2U/3P/ikiTXpwDMWMZMfpMY90Xy7cfY86qOhQj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOIN6gWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC16EC4CEC6;
	Wed,  6 Nov 2024 16:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730909795;
	bh=qRGU4RUqChfhcxpb0dUaFVDhL+6ttSNAKLTGzeeHc8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tOIN6gWB8PagNoC8TVFz54hj7uIEjWIkiwWpBkqrSSQUF4qQQDdgRwEI1AVG7FVoH
	 HtAyNvvNUtp4hRHlqrCDxQrMrHD2GA2B5Yzk6JXvJcvaUAHgqkPJE/RN5fZHaoFMZe
	 d1JMB9Hyz2jb2p2MWxiaoLfvkPEfPf8qDqGyhsaZCxkQR11S5JdIvkvTZjH9pFRAdj
	 HJ3rjdm0/SeXGNx03z3me0okMX5Vrxo3+lhyN6nm1em7ws/shHY+jK+u5wuPNqKaKd
	 Yh9KI+s8H2CX930niLHLefl6882hizGXRDhGsmI2YzB6rwUGAgSG0n5BR0+I8AOyGv
	 hQnGkrA+M3FmA==
Date: Wed, 6 Nov 2024 16:16:31 +0000
From: Conor Dooley <conor@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v2 1/2] dt-bindings: power/supply: Add ltc4162-f/s and
 ltc4015
Message-ID: <20241106-riveting-implant-41db6f7ed66e@spud>
References: <20241106015537.6189-1-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3phU+roiop2B7xTt"
Content-Disposition: inline
In-Reply-To: <20241106015537.6189-1-kimseer.paller@analog.com>


--3phU+roiop2B7xTt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2024 at 09:55:36AM +0800, Kim Seer Paller wrote:
> LTC4162-L 35V/3.2A Multi-Cell Lithium-Ion Step-Down Battery Charger
> LTC4162-F 35V/3.2A Multi-Cell LiFePO4 Step-Down Battery Charger
> LTC4162-S 35V/3.2A Lead-Acid Step-Down Battery Charger
> LTC4015 35V/3.2A Multichemistry Buck Battery Charger Controller
>=20
> - Add compatible entries for ltc4162-f/s and ltc4015
> - Include datasheets for new devices
>=20
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
> V1 -> V2: Modified commit message describing differences between
>           variants/devices.

What you need to do is explain what makes the programming model for the
devices different. These are all 35V/3.2A, it is plausible that despite
the different battery chemistries these are designed for that the
programming model would be the same.

--3phU+roiop2B7xTt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZyuWXwAKCRB4tDGHoIJi
0jl9AP98aabBIZKBYV2Ki1P1pBa1W22o/ubd3ZiCbQoxzcAtWAEA4J0a1PIScoz3
qQUogwAwxLcJExl5AkKVxgba9JRuSg4=
=XIdJ
-----END PGP SIGNATURE-----

--3phU+roiop2B7xTt--

