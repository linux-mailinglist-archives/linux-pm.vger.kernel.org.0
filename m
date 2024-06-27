Return-Path: <linux-pm+bounces-10123-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C49891AA06
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 16:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0663B22347
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 14:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2993C19645E;
	Thu, 27 Jun 2024 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wyvw3kj7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09F213DBBC;
	Thu, 27 Jun 2024 14:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719500221; cv=none; b=UD8FpDN1OUgT0ebPF9oMfg8Vqq65EJIsrLEEukeMdVlXWbpX19gxFJRm0p0qQFooAuCadLVQfusqpczr9pCmgHed0/vtHOQoC/0nuu6+nwvBt6zV1t/apZ4+qzyTJDVQMqtoDzdLmHkRsp2nfjpoSLd8i1GaXzPi/BXx8lxKsno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719500221; c=relaxed/simple;
	bh=i0jPmHeV6CW8BboUWCjCcCcbiGOGEGkREHGrut7jWv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swziQh3Nbna8gUH4OwaEWV4Mx9qQC2tzxB28YBo9vi9lfsslf0SemyoQmZ+Jq/wJyE9WFWAQJPv11yG868vnjcfDnsFkE8zksz61qzKfd+ZvGL3RRvmYpjMUBx0vfKvJgVUz6g1k0KUX8jHLkbwmjE1EGjVeNyUpyd60ZyLhxz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wyvw3kj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55D2C2BBFC;
	Thu, 27 Jun 2024 14:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719500220;
	bh=i0jPmHeV6CW8BboUWCjCcCcbiGOGEGkREHGrut7jWv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wyvw3kj7OLX/75jmYALHB97fyIeiAH0iDxbn/BkWcjaAGoC70sXoNhJjKlyOSlBYC
	 zwAtQhABTFQ/tQ6UZpQQORIkqQhKuS2qk7CkRMZx7b56tZXu/CSgXXyFg3EVHg93Hx
	 8huPSdgfgEHy4xEOqLNTWJ6D6YqGuZqUK78ohOg5OQKuK8TVUBXKRkT1wirNFZoZNk
	 k47gmn1A22mUQtYYLu7MlMqyndABXPKAtPQe/RGmfGrHOYeg5IWNWrSfEY6DkdATXs
	 1plpqQdbEHS6OgqoQjjg8fw57VH/ZQQoZwQj+uO5Ez/y4401OBnFEtuKA8xf82ML/L
	 bT6MTqIf7kFzQ==
Date: Thu, 27 Jun 2024 15:56:55 +0100
From: Conor Dooley <conor@kernel.org>
To: xianwei.zhao@amlogic.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jianxin Pan <jianxin.pan@amlogic.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Hongyu Chen <hongyu.chen1@amlogic.com>
Subject: Re: [PATCH 1/3] dt-bindings: power: add Amlogic A5 power domains
Message-ID: <20240627-fool-willfully-381d32cb7189@spud>
References: <20240627-a5_secpower-v1-0-1f47dde1270c@amlogic.com>
 <20240627-a5_secpower-v1-1-1f47dde1270c@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Nb7gwQ9rDGfruR6Q"
Content-Disposition: inline
In-Reply-To: <20240627-a5_secpower-v1-1-1f47dde1270c@amlogic.com>


--Nb7gwQ9rDGfruR6Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 07:47:51PM +0800, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>=20
> Add devicetree binding document and related header file for
> Amlogic A5 secure power domains.
>=20
> Signed-off-by: Hongyu Chen <hongyu.chen1@amlogic.com>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--Nb7gwQ9rDGfruR6Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZn19twAKCRB4tDGHoIJi
0kGoAP0fbvycpS60F3qceed5hqd3hvVpzthMCcPCceocqcNgggD8DdsmSP5iVjUF
/SiVKgXplReeg0WEoSoQAy7qQUiHQQU=
=G7MA
-----END PGP SIGNATURE-----

--Nb7gwQ9rDGfruR6Q--

