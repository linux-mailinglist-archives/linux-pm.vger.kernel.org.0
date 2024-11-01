Return-Path: <linux-pm+bounces-16889-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A439B985C
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 20:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F52C282EA0
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 19:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9841CF5D9;
	Fri,  1 Nov 2024 19:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="io6aL7bA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57691CCEE3;
	Fri,  1 Nov 2024 19:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730488954; cv=none; b=gRpM/NYcQtKPkRbzTUaP6moLOvGqQbVkmWqszxSml7X+wDU9KzlLczTv5oTAncVWOKKt4uqjvjLjd/OdnIWr+O3N3Tm7c9h4rce+mWj2KyxTq5QPTsgonnbGlF0oeOTah9t4/aZZZB0yOJhC5G1l2u7dipBqv7xtYWp0Y60GFVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730488954; c=relaxed/simple;
	bh=O/ym4d0WTlG6huG3aJJmFPNVCgzuGvNmZvEadQiWdng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdkanDhWxYBdu+eUo+qU/ZE9xxMIJPPmvW+TWHUAC//9BaCSKcPVM3vVDFV+leGZrfzVOXCmOkMTE4K9XRirEGpk55Iry1M1HClHGzpxrN8v433OUANG3Sz9btvGDWlXuXVS/j46IrfHj16imxU54v+1z52se/7qS5YeTpPRb5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=io6aL7bA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E628C4CECE;
	Fri,  1 Nov 2024 19:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730488954;
	bh=O/ym4d0WTlG6huG3aJJmFPNVCgzuGvNmZvEadQiWdng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=io6aL7bAV2/t2veS2luEgDTV9BS6/r7pU6DL0zi+yggHcih8kGCJEpXBQcakZm+29
	 VFdP0zayDHjHbeoZTSifM6wGBVPLgzNy/m3cIgYIjB828vKQz2WKpPLdNQkcZKvI/l
	 ZXsXbWFsaguNPaLAIVZW186qSAVeIPsVDqMPYCklFEjdzgfVB+jfN6noBjVpEHf+m1
	 uYFpt/Qlpk+GhgcUTWe1wLl92uVLftZ50E7v/JFjiv5e0CtLlMrRVZlQtdOdyv7gaC
	 l1LzAcytEXhgdRizzMU3/kYaFApFCFvi0LPjmJ/P6zuBatMvo15Fo1/Jyrid+EQelp
	 Tbn0oog2SLYYw==
Date: Fri, 1 Nov 2024 19:22:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Chen-Yu Tsai <wens@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	=?iso-8859-1?Q?Adri=E1n_Mart=EDnez?= Larumbe <adrian.larumbe@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH v3 0/7] Fix RK3588 GPU domain
Message-ID: <cbe94b51-09f3-44ca-b2f1-f8da7ffdf05a@sirena.org.uk>
References: <20241022154508.63563-1-sebastian.reichel@collabora.com>
 <CAPDyKFoAv1jeQitHmTMhvwG9vGzN-vLby0fPzkX1E6+-Qe2dog@mail.gmail.com>
 <CAPDyKFp=sRLVBhW2aK87pYHVGi_6gNw=e3j3AGMnEWP2SVYFpw@mail.gmail.com>
 <9b4c9b61-a2be-465e-a4d9-034951fc862f@sirena.org.uk>
 <CAGb2v65ahUB_Q+HPFV6B-UqWCbCNLdGz58BGo9iHRhVyf1ruZA@mail.gmail.com>
 <27yrptpmhdbugmrgxaxllnbllv3adu3tzgl7e26b3flsvhlf3g@nfqn2fvmktmc>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p4SFN8OtHYlRMYXM"
Content-Disposition: inline
In-Reply-To: <27yrptpmhdbugmrgxaxllnbllv3adu3tzgl7e26b3flsvhlf3g@nfqn2fvmktmc>
X-Cookie: We read to say that we have read.


--p4SFN8OtHYlRMYXM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 01, 2024 at 08:04:52PM +0100, Sebastian Reichel wrote:
> On Fri, Nov 01, 2024 at 10:41:14PM +0800, Chen-Yu Tsai wrote:

> > There's still the issue of backwards compatibility with older device
> > trees that are missing said supply though.

> Exactly :)

> As far as I can see the same misuse potential also exists for the
> plain devm_regulator_get() version.

You'll get warnings but I'm not sure that's such a huge issue?

--p4SFN8OtHYlRMYXM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmclKnMACgkQJNaLcl1U
h9B9twf/QTGk86FAM5H8xV0Epn/9qOT85YTAzZYDwwWc0yqPqBqNwkRR6JhBRkb2
3KIhctV4uLAJgKQDk9zR7n79rZj0x08PPS1O5b2OzpS/UmWYEH4I8ZHjdpdDuuIr
I0PZjazDxBp5fAPieR5Jf5iXwhfN/QAJ5CqqePZs+V4vOc0ENyQXhozZCCiKWSr5
SDk10YySJNmEQpwuWPXLt/5F9GFtVA3EcK4E/0GU8vnQFgHcFNjI8W9ekN+/1U0w
Fy7VLGtmx9KfgnCtcqqYDEB7dgwvxoVfKWCkmyvvrG4gE4GyvgCe7vxiPAxg9ti+
0o1QDSRVbsBURb10e6VxYXEjr5tTpw==
=23kx
-----END PGP SIGNATURE-----

--p4SFN8OtHYlRMYXM--

