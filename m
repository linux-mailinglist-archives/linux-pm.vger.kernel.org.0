Return-Path: <linux-pm+bounces-27205-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E73DEAB906C
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 22:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8EFC1BC08D1
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 20:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464A21DE3A5;
	Thu, 15 May 2025 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="W/H+IKBT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D8E8488
	for <linux-pm@vger.kernel.org>; Thu, 15 May 2025 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747339233; cv=none; b=Y9fNQjmLzfirjYWUcdeu0Kow30S6kLAN5Tdxt5Jm9LO3D+GV5K0Jc2zePFgJlfsjbv+vBzbTPH7PPElUmm887V+IzfqCtYnfNJ/vP2Z/XrBT5oqEbO99vdCl/CEChDrrtVKhttC2eM1ub4OijcKjx/T98CL0QHeF3WSiXXA7LEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747339233; c=relaxed/simple;
	bh=h1sXw35rTSS7pTuDFEY54HVj+OPPf2cg7Q7+jHB1Tok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZNXcIsmchgbxoPJylAoUO4l+O5skFSUjl1YWdFUcr+M+wzR+oERj4I3wcxVyTHYOSVb+4FTFDHF6fEkeCMfc26h/9r3DZsRhzDq3Q0UGKWm2JrZTO6yLgLtjmy3EfLvRAeVJjalDp4JWOo4A2Lm+4coV/7lnebBDYssKZOhCjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=W/H+IKBT; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-acb5ec407b1so210629966b.1
        for <linux-pm@vger.kernel.org>; Thu, 15 May 2025 13:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747339229; x=1747944029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h1sXw35rTSS7pTuDFEY54HVj+OPPf2cg7Q7+jHB1Tok=;
        b=W/H+IKBTR16r7fpUf6/RRUjLPfNT8ZRiGRU5CBZPlXNk579zR7eASG72jkBUXa6AYL
         nvgqjXHCkZSOxd0J/Hi0gTz77eWjF58Cw6cBhLyNkW6KY2w5Ek2IKbOLMRDPRtUyEHGN
         H4a26lX3tDdeAKA+MU7kqj5hGZOA/lOPOV1pZGpQZ5jpqnSe92I3Ksay2nNeq9fwOGQ2
         MHUaKdIgh9sAEmVnzwe0Qci/y6M5L4ZsbamD4MmcrbfwhjF4fdW+GJ7ebWdUftNsNfux
         1KRVP3JAeaz4um5TsgcRT6MISfNaxHhlrN2LuEHQc6GQdhW4D4WUby1GO6sbChzyRcwc
         Gb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747339229; x=1747944029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1sXw35rTSS7pTuDFEY54HVj+OPPf2cg7Q7+jHB1Tok=;
        b=BzVdmpTxdsXDRjUoW/WvT5zLOORji5d+Sb5lJ9/KsV4gHoYOOrjoT/VPKm7OanROHa
         nrlc5nreVM+5BSRvvOvFf83bo/0KtpYLBQaPGi0bMM+zAKmkbePlJN/ShKSZQMfhgRL4
         qXixF46ix6lfYcxbW9NJPeFSyDRBciab+2YTw5Jitn5KEXJ8wzC3E8wy2bE3SNCTt7ix
         hJVTQE4YraM8E+jb2A3nkFQlaZCJxYMjLPkUrIwEGk4Q3DQaSuP4LrOxa7xb3gGnSE+m
         mN2YO0+RKtxfrKAkeUEVYElqrzQbK1HtF0b09R6jdeOZLSI/YLF2eFhk6igo2GdfhZqQ
         Y4+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjimu4+g3Kb6086EOwPsDF1Qao5fnp5JL6yfaHR4uz0LF5sbmpqxyWtmpsrTW5MmGDaeZlzsQbfg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2fiXIV9OVwkSXY+Scus+/NAU7I4kCsGHX9V2jz3HStAgUvgjG
	rXgwU+9s34D7AVv/khIk6ZoXsxEKyaVjgmFoLVhuh40S2M6NQZnxMcBJWtL5+c7Azs4=
X-Gm-Gg: ASbGncv/8cZ5cYyvAIW6M4n6SgxeDL0ELcHWmc9M6bORi7SfVXuhnZQnyy4B97YxioC
	JDXExx5H6/2egfkdcui5HtIEztzpfYuSSeiaGvssQPuC/Xq//sgphYY/q6ap9XLwkZZik0HhJkj
	wyy5C7vrtkGXZxAnqtlTmi4DWkyv+VD4wqDx5NvseyDzEQ6w96iG79vscZi2pFLAAFql/mJaMgl
	ql+pmEpiUFyd0Y7d+IXiNntDqeYByLl5BFI4BydR2HWp3i52PHCHd3wbitjMucwwEfjNU4+78ud
	BdpcymTMt/gstgNoo71/C4ZYGK6lNtU0R82VBMWYj0X0bGxUNM6EEjTA
X-Google-Smtp-Source: AGHT+IGPOFtpI/vK8bB6QX01z/3mHJSuoT96bx2VZRxF7C4JeqX1CuZQvwl02jljZ2PZvA1htePF9A==
X-Received: by 2002:a17:907:1c0f:b0:ad2:2ef3:d487 with SMTP id a640c23a62f3a-ad52d5ff0f5mr99764766b.58.1747339229197;
        Thu, 15 May 2025 13:00:29 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ad52d06df95sm34035166b.56.2025.05.15.13.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 13:00:28 -0700 (PDT)
Date: Thu, 15 May 2025 22:00:26 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Chanwoo Choi <chanwoo@kernel.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, oe-kbuild-all@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] PM / devfreq: sun8i-a33-mbus: Simplify by using more
 devm functions
Message-ID: <tdqcadvrr4lfn2ipkbcu2n7zgv3e57q25tirvuo5ooh5zzf6my@u27v7wxswber>
References: <20250513203908.205060-2-u.kleine-koenig@baylibre.com>
 <CAGTfZH2jVrD_Bfu3NZJ+vNdQCjdxo4vygxWob+h0VasyxUa4gA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h3k2tl2vtfjhrlpb"
Content-Disposition: inline
In-Reply-To: <CAGTfZH2jVrD_Bfu3NZJ+vNdQCjdxo4vygxWob+h0VasyxUa4gA@mail.gmail.com>


--h3k2tl2vtfjhrlpb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] PM / devfreq: sun8i-a33-mbus: Simplify by using more
 devm functions
MIME-Version: 1.0

Hello,

On Thu, May 15, 2025 at 11:38:11PM +0900, Chanwoo Choi wrote:
> On Wed, May 14, 2025 at 5:39=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> >
> > MIME-Version: 1.0
> > Content-Type: text/plain; charset=3DUTF-8
> > Content-Transfer-Encoding: 8bit
>=20
> Applied it after removing the above unneeded information.

Oh indeed. That happend because I added a newline in the header part of
the patch mail. Thanks for fixing.

Uwe

--h3k2tl2vtfjhrlpb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgmR9cACgkQj4D7WH0S
/k7qZgf/W9wz4qM8Tz2N3KVv0s0oVU6w1DHns83H0SunE+jquxj7/y0evxnc1Ilq
V7aafapnyBgz/U74H9Utvd9gMBwKk0+lnAQXnOnGeySRsr05q1toZq1bVilPn44z
c3HCsfln9Kb7m4ysM5O6U8p92h9Rg7uP0epQ02JXxknaQDHiY0Ac+EzsZZw1uRbe
mvlrfet/eYHmpaMPxlRM6ksBrxJQpSIKuJpIIf1VlkWNniiXY93fl4yor/7JCj0L
v/fgrnnDu+6Gk6c7cj1fvpL3Twh3AlRwx5lmMkJ7HoSvxhNcrIc2m7U4o9/pCEh6
jTzhBsJxpV9AAfOGA02x5qQdG3x9wg==
=60Q6
-----END PGP SIGNATURE-----

--h3k2tl2vtfjhrlpb--

