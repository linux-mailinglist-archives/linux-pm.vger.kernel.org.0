Return-Path: <linux-pm+bounces-37181-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC53C250BC
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 13:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4A224E11E6
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 12:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0B3335569;
	Fri, 31 Oct 2025 12:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ruyJKIOO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C300C1C28E;
	Fri, 31 Oct 2025 12:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761914356; cv=none; b=VAnxT/+FHev12J6QvwHjOPTP9Cdqa1Ol1KqaBhbpVWeBuGE9KYvyV7NtilrHFagnBKhf1C2y3uI37dK8foPlQqtoc1VVYekalQ79Hac4V4PcQ1i2OIughyq5s0UJnhuD1ZjBaYAVrjmYc8n1x4lNSVAAF0U3DCH/TshDPeNyQ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761914356; c=relaxed/simple;
	bh=DUW2HwuVCCP1E1hde9M1EoWIauwT+OPTiC2Rn/96ljA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNlGuhHxymjR/+rMyQ5l/wNrnBG+8K7ma8fPPHImXzlz8MCnLEanht35hgsP0OccV1RtJFWPbRILqYZg8rItJulihQo95F0cLmI7TdG44gF03Pr+PmO6NKfDlnkhJQOpvPibhmvgKDUjXspDzF6F0yt/JcHk175QpcqZgI2cbWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ruyJKIOO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD88C4CEE7;
	Fri, 31 Oct 2025 12:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761914356;
	bh=DUW2HwuVCCP1E1hde9M1EoWIauwT+OPTiC2Rn/96ljA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ruyJKIOOtOEEQ+8XOeehhB5S+GDMrNwlnu3aI44VE33hSi1Ioy465llBSJBU4/Luk
	 4UMoUVh+knOSVCJYWdKaevlOpecb7oKclQv9LDsu6ABuFBIWa/p4RMfL+oHST+6hc5
	 17lzxbGXPL0L5qJku0v0hThdiu+M2XSGC3GvEj1dfzNx55zGQ6oOtdmXsI6JwYqSNd
	 szK0Bzgq0m07IQ6Fnad3pRhvoG+nkh8KCzIxurTJCQVpp+aLJS4cmNHfonZHo5VMB/
	 +ZaW1crRWodnO0gcx+OIVf81QtXMoyeFyXhrpQ3SJUMdCkQZzu7TiT1fW1yJocJr23
	 rDPdM210bQ7IA==
Date: Fri, 31 Oct 2025 12:39:09 +0000
From: Mark Brown <broonie@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Stefan Wahren <wahrenst@gmx.net>, Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Melissa Wen <mwen@igalia.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	kernel-dev@igalia.com, kernel-list@raspberrypi.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	"open list:GENERIC PM DOMAINS" <linux-pm@vger.kernel.org>
Subject: Re: RPi 4 deferred probe timeout of V3D PM domain
Message-ID: <3c171b6b-f8f5-4192-a3a3-da453a900316@sirena.org.uk>
References: <ad07546f-0c2d-4bc2-b794-755b892c7328@sirena.org.uk>
 <a016e7e1-09f7-4056-a855-6cfaa8d51962@gmx.net>
 <10a4ef77-0e70-4ef2-b1df-535b476d256d@sirena.org.uk>
 <ecd75fd5-3131-4d10-ae3d-b6f608d9622a@gmx.net>
 <25e500c2-3dc1-476c-b6c1-ac4098a0501d@sirena.org.uk>
 <d6b14388-e0ab-44f0-b4d9-78adf74c2a7f@gmx.net>
 <d88f6420-5013-4856-99d6-da28f79bd7a5@sirena.org.uk>
 <CGME20251030191426eucas1p29ce063b538b60e4a998bcd32f925267c@eucas1p2.samsung.com>
 <043f1702-52fc-4a83-82f7-683a26851623@gmx.net>
 <b02c8890-4568-4afe-8628-10b77e79bf44@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o3fwRCeo9dva3t0m"
Content-Disposition: inline
In-Reply-To: <b02c8890-4568-4afe-8628-10b77e79bf44@samsung.com>
X-Cookie: Byte your tongue.


--o3fwRCeo9dva3t0m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 09:12:57PM +0100, Marek Szyprowski wrote:
> On 30.10.2025 20:13, Stefan Wahren wrote:

> > Any ideas how to solve this?

> As I mentioned in the other thread, this is imho a configuration issue.=
=20
> If core modules are distributed on NFS rootfs, then one should increase=
=20
> deferred probe timeout by adding deferred_probe_timeout=3D60 to cmdline.=
=20

Like I say I just don't think we should apply timeouts that take things
out of commision entirely.

> On the other hand drivers built into the kernel should not depend on the=
=20
> resources provided by the drivers built as modules, so maybe it would=20
> make sense to change CONFIG_CLK_RASPBERRYPI from 'm' to 'y' in=20
> arch/arm64/configs/defconfig.

Or the GPU driver should be moved to a module to match the clock.

--o3fwRCeo9dva3t0m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkErewACgkQJNaLcl1U
h9CwoAf/TasMrYudnRIfHbZsVEJFG+6aRlxnjE4Ih5HjcUqIsa72WZFNuGACxeR9
lPgBRD2CZ8qVpdjik03ktb1PP/EnkwGxy/3elXC/YxgpWgyE4SGmiX668YojrLsw
ZAzcmwOckrGshx2O2N34zF58asnUSdPRbBVKLMNQ02koZ7brVqtQ1fLJdK9kL9qr
hu2AUeBcAOUuSGvmQKdg6cRf8owTOEv/hUd/lclvZVnZzK2CV5vs/vZG616sF8Mf
wo7+WQktr1bs38NGV4NYNtHOpCK5XrrmZUF6kRxN8P+3X3DYWEj3a++itNGUJjz5
rjOllqjvNXZrwXbKl34E5pNJNpNk8A==
=MfxU
-----END PGP SIGNATURE-----

--o3fwRCeo9dva3t0m--

