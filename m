Return-Path: <linux-pm+bounces-16418-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0BF9AEDFB
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 19:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94866B26130
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 17:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A1F1FF7D7;
	Thu, 24 Oct 2024 17:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Jl6zQTjb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2F31FF60D
	for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2024 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790794; cv=none; b=j0PDJ3DdOA2WcbPKP9KapxHj5aHwhAuRVDUk9gDixNgimvzhRIr0G3KVvDhqWUum2kRyilk3tXQ+jzzz0lw6sEmmG/JEbKbKWZBasa1MAbMsindJY4m9EJZ5aJd7C9ILyA+U5R4tqKYnUAleUVbuR4gADpcXjC64a6Nq98vAeNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790794; c=relaxed/simple;
	bh=RwEePPnICKDq/hGzPzFY9TDugPuK4+JiAhBYXPj1EVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBQhWj/XmZhRr0u84Jyew7S5/E2/gfQkIVogI868ZykIAXP0jxsMiwCLpMW++upB8/yKo72/IgBOqh+F2oRrdsMSPFmAtW7x4Za5gMXrLplAqX/mVUMbqe5UD8K1byJhWQ3ZUxhjn9AKpfRkbUgAjgZR1LgcEXdRQvfaGiKvXR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Jl6zQTjb; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so15833335e9.2
        for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2024 10:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729790789; x=1730395589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=df4TNSGzSNKm0QFOAhtHpnlWhy9nagHU1mwVeiJhueE=;
        b=Jl6zQTjbWhos+uZl0SNToDY2DbXryHaTbqEOb3AL7nrCFsjdOe59trDBeDKHI8Qdmr
         aPMzHyedJjgpwEzBuIjg8ECxivhTWMIOSwIq1eYJVH3AaT3+YvvfdZs4BihLfz96e+nN
         PSkZCCndK3vg//jNHnNpnotGwnJgCAOrIpnqnbw0Sw3/2Cngtn5bTnibHlMjvtXMLxcI
         sN7NQWXFA7/lwQ3bwAU8Wh5JcbBK/hifKlQfJrpqfv57NMYSJ4zXYErKqXo4jMXWQl/v
         kZafLVWk6++cwEMtv3mUlgaZL3dGoJ72jYkzFv5Vi61KeuecN7srE/fd0fFKQvmjZCPq
         ByxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729790789; x=1730395589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=df4TNSGzSNKm0QFOAhtHpnlWhy9nagHU1mwVeiJhueE=;
        b=ExMpb7k0Pn/KOVoT/6y6CfJC0jzTr41bLqVtHnvFm4qKy1/4qzJdofjMyvPxJMG5lq
         iQKEPA7ORutjgpbeIeaGukgteGVapAw2LIprxkwwdXWsPqTlDrmStuH526SKCEtkvSu7
         0Xt3NSvJF9BsSxOsZ/A8FD5CZd98x+TnBrDLcrO+w3IdWTNDz7SsV3PQE1rivRllpGNT
         0JUNOGK7//Vele4SrtRK6NxbceX2c0tPADsoIAA8NsoCdaL9LEkihs9Rhw2Daow7yWoG
         fQQzH1OHJ3Uxgx+DNyrt+Uhg7LELjCR6iaVgN+Em5OHEXZaDgN1UtoAlha3f+d1I7G4Y
         bN4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXDv88ICAh1UUhKdh89TXQ+tAOJU0R0BB9hVPGM9A1wCd4WxI5f2wVToG0zK+DdTDopixXtENmskg==@vger.kernel.org
X-Gm-Message-State: AOJu0YybfW8sU8UtxQGhEdN+PBYi0x0UZknuJngc0TMQEbnyffJN6YJc
	j+TMh21PihrESR2ZjTx2cSiyWZQjbmviTwetaFssHaCwa79WCTOt8SqD2i6Zxao=
X-Google-Smtp-Source: AGHT+IERuGJIotkBPQnG/sDjxSCMdboz8SG9EaUnlFwZt5gyjZXzk4XrIIAOtG10KxDOLzg+kXRQFQ==
X-Received: by 2002:a5d:4cc3:0:b0:37d:46fa:d1d7 with SMTP id ffacd0b85a97d-37efcf91b9emr6075835f8f.57.1729790789509;
        Thu, 24 Oct 2024 10:26:29 -0700 (PDT)
Received: from localhost (p50915d2d.dip0.t-ipconnect.de. [80.145.93.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9bb15sm11814624f8f.99.2024.10.24.10.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 10:26:29 -0700 (PDT)
Date: Thu, 24 Oct 2024 19:26:28 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, Ulf Hansson <ulf.hansson@linaro.org>, 
	Michael Trimarchi <michael@amarulasolutions.com>, linux-pm@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Sascha Hauer <s.hauer@pengutronix.de>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
	Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pmdomain: imx: gpcv2: replace dev_err() with
 dev_err_probe()
Message-ID: <4vws5lnu4efupunha74pdlgtd754w6n2loymgywrxhwm2rqic2@gz4efozdrpqm>
References: <20241024103540.3482216-1-dario.binacchi@amarulasolutions.com>
 <20241024110123.wix35njjbh3nx7kn@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ow3mz7ffba4wu6es"
Content-Disposition: inline
In-Reply-To: <20241024110123.wix35njjbh3nx7kn@pengutronix.de>


--ow3mz7ffba4wu6es
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pmdomain: imx: gpcv2: replace dev_err() with
 dev_err_probe()
MIME-Version: 1.0

Hallo Marco,

On Thu, Oct 24, 2024 at 01:01:23PM +0200, Marco Felsch wrote:
> On 24-10-24, Dario Binacchi wrote:
> > The patch standardizes the probe() code by replacing the two occurrences
> > of dev_err() with dev_err_probe(). Indeed, dev_err_probe() was used in =
all
> > other error paths of the probe() function.
>=20
> I assume that this paths aren't using dev_err_probe because these paths
> can't return EPROBE_DEFER and therefore dev_err_probe() would use
> dev_err() anyway.

Note that dev_err_probe() has advantages even if the error code isn't
EPROBE_DEFER. In this case it's mentioning the error code.

See also commits
	7065f92255bb ("driver core: Clarify that dev_err_probe() is OK even w/out =
-EPROBE_DEFER")
	532888a59505 ("driver core: Better advertise dev_err_probe()")

Best regards
Uwe


--ow3mz7ffba4wu6es
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcag0EACgkQj4D7WH0S
/k7z5wf8CJItP63PC6N/D5K9sQTx0ydliUNv7dA1lUSVuiADSLncCZVZu3zmSuiZ
6Ta9uxNeZuOyJSAtq5mXX70s8vNrRycm/rYxPoZNvvB62ZHQOyweWF0f0Ce1AwGn
keWSqZ3/B9mNSgtSqmyEi3HHcx61NbjjO230wOBvNKfUElyL4ozrgbzFv2qbLZYF
Nt5xFEoEQiw0riAk7lgyOazrA/6D5ZyJ60YZ5AdifNXgDLfU5OkRmpVh4/eOGKD0
x/Rn15dujV72q8n+ZyXqyifZUbnGVTXYWnNzNwqwcPT/y2ESWjPMC6uyeUwiEMuo
xHEVQMNz7SHRR8PmDEwbI/fmJdDOjg==
=kHdL
-----END PGP SIGNATURE-----

--ow3mz7ffba4wu6es--

