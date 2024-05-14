Return-Path: <linux-pm+bounces-7795-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC938C4CE5
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 09:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431371C20F2D
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 07:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB0B11711;
	Tue, 14 May 2024 07:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="COtaSGcd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D48E1171D
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 07:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715671426; cv=none; b=BLNsJPM3Wq70oZz5Vf6AVYc3+LGNXrwoGR3K4An3DBIjPPQ6ST2joC+WmPFuacygcPvZcrYEb8CnqOwAf25vsvxHDcvoLrfOc00TPCwVGFSpHmC88fh6kpMzsOeh5XqATHUqyIQygfTvPkc8BaQ1tdg3sM7W0j5q14g+8Odtpg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715671426; c=relaxed/simple;
	bh=DS00xBzbHpMSZfc6ghFoF/lxTdDZGe9GaNKVcrMza4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m021DTo2KHvXqdReRsWNX6cODVZQvkZpYm/uFRti/4wK/FV184a7GClCoWeB/GTI6wNGaOlODL2o378FwVjKxjPpVJLiZjNmF2TSuH09gwdidd0H0npI278ar29Vs8u4n54nqL1L/MU3/EBawhyAAHSKGRC+jICC7vu199VGTWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=COtaSGcd; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=DS00
	xBzbHpMSZfc6ghFoF/lxTdDZGe9GaNKVcrMza4I=; b=COtaSGcdsFzVOT9Vx7ud
	jWPtLpwrpU5sSOZ++XsxGToHsLm2pQUJNCa9N+E9LLqiirRPsYW6X5SAfGbBMQ+r
	kWd71/mS/eQlKU9l913nCfs4+QFuAQnjJw3juHmS5IedJoexdW0XcIfqZBl4Bjhk
	y72qaKgzjGnwunTgNyL2mUtq0WbKPHqtdF5QYdiEEqr0kNRiD2W6GAPjDBJB3Qg0
	vMKgM15KanhySzIuw6RZbvvCYf54HXbdxUtE1yC5ceb17YLhWO+uolExHdAbdxLF
	7qaE/gRvIoyGs73V+3rcBdUKhkGSsO+T6Dcm2TVxRps/QQBcvgqU7fV0musbBS+e
	GA==
Received: (qmail 2406829 invoked from network); 14 May 2024 09:23:38 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 14 May 2024 09:23:38 +0200
X-UD-Smtp-Session: l3s3148p1@Pntv4WQYvqtehhtP
Date: Tue, 14 May 2024 09:23:37 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>, 
	Peter Rosin <peda@axentia.se>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "Rob Herring (Arm)" <robh@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: sbs-manager: Remove class argument from
 i2c_mux_add_adapter()
Message-ID: <5j5qm3o5pu6nhvw2in32amvntc5d3qlfgogtkdjxcyy6mgncyk@l3e3z62lppa7>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, linux-i2c@vger.kernel.org, 
	Heiner Kallweit <hkallweit1@gmail.com>, Peter Rosin <peda@axentia.se>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	"Rob Herring (Arm)" <robh@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240513201400.16589-2-wsa+renesas@sang-engineering.com>
 <4g4u2g2nrcpjvx4uswxppw2vsfzwcsy6kbsjp7ukksgfyhgnqb@s5n6jlz6w7af>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jhvwrlkcfjqma4ff"
Content-Disposition: inline
In-Reply-To: <4g4u2g2nrcpjvx4uswxppw2vsfzwcsy6kbsjp7ukksgfyhgnqb@s5n6jlz6w7af>


--jhvwrlkcfjqma4ff
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > The to-be-fixed patch is only in linux-next in my i2c/for-next tree. We
> > want to remove this unneeded parameter in the next mergewindow. I
> > suggest that I just put it on top of my branch to avoid the
> > dependencies. A quick ack would be super-awesome! Thanks.
>=20
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Awesome, thanks a ton!


--jhvwrlkcfjqma4ff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmZDEXYACgkQFA3kzBSg
KbaMdRAAjAeGMkxTpHobXw2NjleV4xBtZa9B0wT9Ig6CpdZ2iLo/JBW39HnHAz3w
5sKGmOK5E7C9CUg42dyqn3Tje/eDuRyoBl0oaTrGye73gn8CD9gNCNmuPbM8v9ny
zoErsfuSYbb+QnCFwqCh68aQuzqu+9x+KJRK0bvYSS2zuZoOAXGqb/zgnMtQ4A/x
vY6SuH3PL44o3XVedDf6IWe3wVxNo6dbFYwlDcoOTIqE6ds7ZKR4tnlUUMtBPneA
iMNF++K+HEMZ4Ey0Dnty2oYStv+9QOcMnRMjbQ6xVLKskJxBLi672Dd/opBBbSqg
T949nrWLhOBVYLZpgJj+/+BDaUBvHBkCwHzVLWXQzM5az266adwZq9WNM+g/tRUG
YRhGwlKO1yBqTWjStmtRPih+od5MgUUCxrmsM9Ah5kcLDBEAiNd8xBKlIcnfS5yv
evbcg6UAK38acqfX4PYOxO5CiX7hra73plfdrjKcRQrZK6lqJTgQqXiaVYPEPc/8
+nZCjhvp3X70nQ0AWBPFPzUkvWaOsJ2eznDfmixQTwoAyjeoSUWzgpDq2o9CbpDB
KO7zS5FIEmfNGQiX9RaYKEcqgC6re4HAbqr2l1459TeNEE3CfLFxUJeJwdLlzp/G
NCAQhssbjwz0bSTnHWCtGxoDcmwlnGEWnbWXOeEHOAftUCPR2Pw=
=Xqoj
-----END PGP SIGNATURE-----

--jhvwrlkcfjqma4ff--

