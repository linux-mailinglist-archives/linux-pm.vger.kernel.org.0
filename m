Return-Path: <linux-pm+bounces-25726-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC65AA93B5D
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 18:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E7261B62A76
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 16:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CA421A43B;
	Fri, 18 Apr 2025 16:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="JJm4KikH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AAF215782;
	Fri, 18 Apr 2025 16:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744995184; cv=none; b=s5d9kVBJsDtYdANk0b6jcPH7qzu3b/9DO4r024yxiBNFvBBBo1B51g8WQTrcGu9L414N15Qv5XXinHMNKXWtOQvvnz4RxXF0oW3QQXT6qZnozxnjjGxjZjq0UZ37XfBiRpnWNj12ostv+SG3aRdnEnvpdGe2mk/bgwAW21zdA6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744995184; c=relaxed/simple;
	bh=jxLmL4T/ZXU6zNqVJtPdipJUPwXGbrx0xljROGm+Ivo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DH38wSaegUw+FHQQmTokpjWMDBDBtk2HMONIpYIprjNfyp3wiB8dY9jBJtIB48KiekNCX31v6nEqtEDZdCxbnmdGpJhhRLGIT9oPniqg3p0KLhVu6mcp5yKKpp8FBKdKJNl6gPnnII3YAaflIaoC+zPECkWR+vKFp5NJM8Y+uPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=JJm4KikH; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8F72E10273DBF;
	Fri, 18 Apr 2025 18:52:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1744995179; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=nP/Cb1F2nH0EIylFlrsWtJWO7mmTiihFUufSwiESmK4=;
	b=JJm4KikHENA+J2FKS1pE3qWTpEhumcspSPtEuAePDoroxDzgME8wCP1DMXhxPtMb0ztwQ2
	c6tep90LSvhN8DxLwM8YQJ5lwBoOS1xisBaDE8lWg4ouz/gc0LMBnKXpQ8Kr3HiinvALd5
	1tEpTsk19lLKrI5EnxoPP/DKcYtSIRubrE6ggUMhsM1Srd13LDCK3keSH/DIhYWz2JfJX8
	MC25jXRztXXgD6mI/8ESirePB7wibVQyrLFLUtfn265LsbrgoYyHcwFXysvzHN6zvGS0YS
	e4lpJy33mMkq7m9Bfq2WYm6x4yXV3l1HLPiV1JT1P2lKKbDn5z3EfrwArA1ODg==
Date: Fri, 18 Apr 2025 18:52:52 +0200
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	Shuah Khan <skhan@linuxfoundation.org>, trenn@suse.com,
	shuah@kernel.org, jwyatt@redhat.com, jkacur@redhat.com,
	peng.fan@nxp.com, linux-pm@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.10 1/6] pm: cpupower: bench: Prevent NULL
 dereference on malloc failure
Message-ID: <aAKDZCxGo9iZ7IBS@duo.ucw.cz>
References: <20250331143710.1686600-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOFqKlcAubOSH2n/"
Content-Disposition: inline
In-Reply-To: <20250331143710.1686600-1-sashal@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3


--BOFqKlcAubOSH2n/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit 208baa3ec9043a664d9acfb8174b332e6b17fb69 ]
>=20
> If malloc returns NULL due to low memory, 'config' pointer can be NULL.
> Add a check to prevent NULL dereference.

This fixes nothing. We have oom killer, so we don't have malloc
returning NULL.

Best regards,
								Pavel
							=09
> +++ b/tools/power/cpupower/bench/parse.c
> @@ -120,6 +120,10 @@ FILE *prepare_output(const char *dirname)
>  struct config *prepare_default_config()
>  {
>  	struct config *config =3D malloc(sizeof(struct config));
> +	if (!config) {
> +		perror("malloc");
> +		return NULL;
> +	}
> =20
>  	dprintf("loading defaults\n");
> =20

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--BOFqKlcAubOSH2n/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaAKDZAAKCRAw5/Bqldv6
8uEkAKCIhRGMmSqVuiU9gR5/TjdSI33fGQCgwsdaVH4e/2hQzk4thuB03Lt4lgo=
=93w/
-----END PGP SIGNATURE-----

--BOFqKlcAubOSH2n/--

