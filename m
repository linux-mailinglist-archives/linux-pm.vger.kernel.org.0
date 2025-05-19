Return-Path: <linux-pm+bounces-27374-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9336ABC58B
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 19:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE631B63907
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 17:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8122882B2;
	Mon, 19 May 2025 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcrmr7k7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E34286417;
	Mon, 19 May 2025 17:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747675595; cv=none; b=chqnDrtPAxxwHJoYqGX8Qbtts4QNDzNdYSrZB433Q/AzVlTZ7AxqhUjHiwsON1Y49F+3IKx7LaaBWyO5H0Q7cg8/ntFVGdP2tukZ31qg7l8umW/fD9+YMWNbTEPqYyYN8Wzl1buOs/IDIzEcASAVACoMB30T9yJR4/ieI0/0yu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747675595; c=relaxed/simple;
	bh=jeQ35J0E940DlPVRh1WHrINnYfAkrW8qW3LdtS5PWcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMDwyXc9Njeu1a8uEo/6ODxpw0krJvBERUwfYamSG0IVrSmHL/XrWtZRFf+2Y/RCAdNcFH71s8uPOmpLq6MqI7zVevDYyp3V4GkeZhtiKoLdoHKRI5CxZ8sGngpilIH5RB1dnVIXVRkvauyLAI/HOJQehr33YvFXYB/bHIB7aec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcrmr7k7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81046C4CEE4;
	Mon, 19 May 2025 17:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747675594;
	bh=jeQ35J0E940DlPVRh1WHrINnYfAkrW8qW3LdtS5PWcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pcrmr7k70KAL3T4uH6ZyAZJ6oMoNgXW9g13UAjU1SHsImlYAQomtDSTwuzQ67BDTU
	 KrNWkNeWmUcRGTDochkJsDhRRnM6VZ9qyOyedUdQ4x5/9mVzJi7VUsP3jit0TD21Kj
	 UeJzXxaUwOAtaCkZJ0CxxenOTNmzUisva3IlT53mUWkTyGnprt49rx1yXvLJ0Sa3au
	 IF0HEsTGwCmi0WAVS9O0D4LJFuDtIPtLXKPVHpYTjbONY9SPxLMNpbIhfy9gINHWOJ
	 w1um3/gCC+99QzgE0r4lWKcUN54thUxBcv7b697Y550p0mF31mmCDS5BPIoMpD5jL0
	 54iLxHZ/CTkpg==
Date: Mon, 19 May 2025 18:26:29 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>, Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>, linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] dt-bindings: mmc: sdhci-of-dwcmhsc: Allow use of a
 power-domain
Message-ID: <20250519-vision-mummify-dce8d0c6b5f9@spud>
References: <20250518220707.669515-1-jonas@kwiboo.se>
 <20250518220707.669515-6-jonas@kwiboo.se>
 <20250519-caress-traps-f61f0c6067b4@spud>
 <2d0524a9-50ff-4b49-bee9-8158c4c5b88b@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VhHNrynzgDnqDNY7"
Content-Disposition: inline
In-Reply-To: <2d0524a9-50ff-4b49-bee9-8158c4c5b88b@kwiboo.se>


--VhHNrynzgDnqDNY7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 07:03:37PM +0200, Jonas Karlman wrote:
> Hi Conor,
>=20
> On 2025-05-19 18:12, Conor Dooley wrote:
> > On Sun, May 18, 2025 at 10:06:52PM +0000, Jonas Karlman wrote:
> >> The commit 7e856617a1f3 ("dt-bindings: mmc: Add support for rk3576
> >> eMMC") limited use of power-domains to Rockchip RK3576.
> >>
> >> Remove the power-domains: false to allow use of power-domains with more
> >> controllers, e.g. with SDHCI on Rockchip RK3528.
> >=20
> > Meanwhile, you're allowing it for all devices, even ones where it is not
> > valid. I'm not keen on that.
>=20
> All Rockchip variants technically belong to a power-domain, not just the
> RK3576. E.g. for RK3588 a PD_NVM0 domain (not described in DT), for
> RK3568 a VD_LOGIC ALIVE / BIU_SECURE_FLASH idle-only domain, and as
> shown in this series for the RK3528 the PD_VPU idle-only domain.

If they all do, that's fine.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

--VhHNrynzgDnqDNY7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaCtpxQAKCRB4tDGHoIJi
0jpXAQCRjtc6HCVpjbNcGyMo5iiN8END3RXIkfZFHa8UJr5ObAD/WZJ8cGC0JbbN
IUx+X17xxuwKeFti8XtARnZ15p+IywA=
=oUeH
-----END PGP SIGNATURE-----

--VhHNrynzgDnqDNY7--

