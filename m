Return-Path: <linux-pm+bounces-16873-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBF69B935F
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 15:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19CC28202C
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 14:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434E51A2C06;
	Fri,  1 Nov 2024 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IozSL3aH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149A5179A7;
	Fri,  1 Nov 2024 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730471789; cv=none; b=JYOPb11GTDpZRrRHHJCtMtDir9sRKC1WRAV56jN7PU2qfLU0b3r+ivrrX7iXGgz9ABTJYZ14edd644Xbs1jsfAIRxNQU0ZVFxLzLphXTEkhKSCSHTl/oVI4DZGbxC0R7nR5B0njQpr0k/VvIQnSe8O2hTK82ytbOkz7bqGbX7os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730471789; c=relaxed/simple;
	bh=1/pEX8FwTIxhnmeQL7MPiXImEyaF6EpOWIFGrZOswRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XY8f4WaZxaURpl2VK8NPSdvtFg2q9sYT5u+cgiz3YqBSfJBUgeN18aoH5uAikIAA/2l40q9jAlIy1ihP/Y9eqYPVkBvJhUrD966MtdIiOaFAvmu1f+w5fbSjTUdbdo+YABollgBf/XggdiCRIDgSyWRdeHxdl6P1XY3XKb6bBmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IozSL3aH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C52C4CECD;
	Fri,  1 Nov 2024 14:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730471788;
	bh=1/pEX8FwTIxhnmeQL7MPiXImEyaF6EpOWIFGrZOswRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IozSL3aHhqRaKcYyfa0WD79Vlz5T/vSYxNmn9MoG7K1OTynCHVgxQouuTJk7Hn/NX
	 +6S2d2z+2BLqv7PPk5GPxImCyRetd1Y6VGrh5c11f/7IF4f4CMUYab72VMzy81/jcj
	 fxbDRRdflJQCfSyQPQ6X5uJfQojTLPhvYnWaQbE8NI0j1iQJG9NAY+9zSv2voegFLE
	 ekEhV1L2au2w3wdhBW1umq3H7eGKTemgkMw05QaOfcm56+uDwA9qgBEOW4z9v/JzrL
	 RGC2BWNMWR7RwhyKG+/8sj66Tv3P+7Ci3/UCXnBn8OkGIJbThzppT5ViglBh3ALpPv
	 D8kqAp62xAGsQ==
Date: Fri, 1 Nov 2024 14:36:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	=?iso-8859-1?Q?Adri=E1n_Mart=EDnez?= Larumbe <adrian.larumbe@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v3 0/7] Fix RK3588 GPU domain
Message-ID: <9b4c9b61-a2be-465e-a4d9-034951fc862f@sirena.org.uk>
References: <20241022154508.63563-1-sebastian.reichel@collabora.com>
 <CAPDyKFoAv1jeQitHmTMhvwG9vGzN-vLby0fPzkX1E6+-Qe2dog@mail.gmail.com>
 <CAPDyKFp=sRLVBhW2aK87pYHVGi_6gNw=e3j3AGMnEWP2SVYFpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4w9LUYh3rdPapJlN"
Content-Disposition: inline
In-Reply-To: <CAPDyKFp=sRLVBhW2aK87pYHVGi_6gNw=e3j3AGMnEWP2SVYFpw@mail.gmail.com>
X-Cookie: We read to say that we have read.


--4w9LUYh3rdPapJlN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 01, 2024 at 12:56:16PM +0100, Ulf Hansson wrote:
> On Wed, 23 Oct 2024 at 12:05, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> > The merge strategy seems reasonable to me. But I am fine with that
> > whatever works for Mark.

> Mark, any update on this?

> If easier, you could also just ack the regulator patch (patch1), and
> can just take it all via my tree.

I'm still deciding what I think about the regulator patch, I can see why
it's wanted in this situation but it's also an invitation to misuse by
drivers just blindly requesting all supplies and not caring if things
work.

--4w9LUYh3rdPapJlN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmck52UACgkQJNaLcl1U
h9BIswgAhREhv5NFPElfnCbYT9C0D0ymldrMFWI9cF7UtXTg4cj/PeIv+sadGlLm
92+6J3FUI+r5Bal2AYXMPhBGlZ0wTAsJsNbvBgIjRbs5mhGH6LnaOBmzzUNimJEp
ICNHbRcmSuZny/YRTXJVh2jwn8VPYrY/NIbfs/mU6ytjVJalP467Oc4fra5aDKZ9
SIDqVqs7+QkkxECmjW0Nnu2CAJhR6+YnPmJrsyGBAyUGd6VwkxLoljbtIaNtwZlm
eB56mDdZOIpNNdipAtqbI3mLlGVz4H/4bCmETaEfMqPumYJVg1t5+9q7Jy1hCJFS
pbkoMBBZH9l1pkAekDvSGcTZkw0q7g==
=Gi4j
-----END PGP SIGNATURE-----

--4w9LUYh3rdPapJlN--

