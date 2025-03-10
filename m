Return-Path: <linux-pm+bounces-23772-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D2FA599C7
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 16:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7494E16310D
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 15:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C17E22D4C9;
	Mon, 10 Mar 2025 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tN6SUlZf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188BD2206B2;
	Mon, 10 Mar 2025 15:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741620079; cv=none; b=Aa8qV/wKjbB1iM5H64ljOL6u5TEhlpwG/9zK3gjP1iTa6W1/j/nYlUDp3aHGZ1c29iOaOrvDY/UhKI+Gp5xPZJv2jF54cAVOYSkFxCdcq0eZIgJZ25iYecjvN9W9Fq9vgw8RdfvWtBNeLAoeVBdyFk2qx62uj8bL6FqPUE7CYGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741620079; c=relaxed/simple;
	bh=Lq4ng9tUDh+Do3SLF+xgV+HmrJ7By4mHdda8vZYyX2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUugrkI+wd+tBxG2EtoJ/vOAxrJL/z7P8tG+9d4sDF02TKMXQc4tCVj/oAsPhLx1pzA85nkRxeNZWNCpLyxLEDNgixA10wj0N7hz6MUx25O7I8ZOfL97xEGSH00unkQ5JnqFYCteC6u0pQzQwFZAHR+Vz7xOQA4Vj5yChbVLm9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tN6SUlZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420A6C4CEF0;
	Mon, 10 Mar 2025 15:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741620077;
	bh=Lq4ng9tUDh+Do3SLF+xgV+HmrJ7By4mHdda8vZYyX2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tN6SUlZfZij8LZDhONGQZYa0e7YUVUuznQJoN7QxJNnpe+jbNxOnouR+r6lsg7jz3
	 4Lnrtw2jbVBA9IJxSTQbHidaF0Xgxo30DQX/+dScJ3X+P/HfURJVPE7azLzRl75Iuj
	 R8qcVAe8zjuSBe0ms+K4GbTB1xyvm5SpRUbS7iX6tIkR0RqnWdsnTrb6c3W7zMZDv7
	 l93X3XUIGRPiEP671e+UX6rqe3SSv1Mnw8M1IfM3zl0B/hdXNP+qm2TErT9R6lsSAV
	 DzqqaC9VfMcf1rxLXbPztaw+62TIEvlf6O7v94iUwpFr2XUemJJ7QAOlLrT9UrMiF8
	 HR7YneCmAO6Ug==
Date: Mon, 10 Mar 2025 15:21:07 +0000
From: Mark Brown <broonie@kernel.org>
To: linux@treblig.org
Cc: arnd@arndb.de, lee@kernel.org, dmitry.torokhov@gmail.com,
	sre@kernel.org, lgirdwood@gmail.com, alexandre.belloni@bootlin.com,
	danielt@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
	linus.walleij@linaro.org, brgl@bgdev.pl, tsbogend@alpha.franken.de,
	linux-mips@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] regulator: pcf50633-regulator: Remove
Message-ID: <a45de47a-d3f8-4730-bb91-2782f52fd25f@sirena.org.uk>
References: <20250309193612.251929-1-linux@treblig.org>
 <20250309193612.251929-7-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xd0V7MnYEiEQnSNp"
Content-Disposition: inline
In-Reply-To: <20250309193612.251929-7-linux@treblig.org>
X-Cookie: I'm having an emotional outburst!!


--xd0V7MnYEiEQnSNp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 09, 2025 at 07:36:09PM +0000, linux@treblig.org wrote:

> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/mfd/pcf50633-core.c            |  35 +------
>  drivers/regulator/Kconfig              |   7 --
>  drivers/regulator/Makefile             |   1 -
>  drivers/regulator/pcf50633-regulator.c | 124 -------------------------
>  include/linux/mfd/pcf50633/core.h      |   1 -

Putting MFD changes into the subsystem changes just makes everything
harder to apply, please keep things separate unless there's a strong
need to keep everything integrated.

Acked-by: Mark Brown <broonie@kernel.org>

--xd0V7MnYEiEQnSNp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfPA2MACgkQJNaLcl1U
h9DJ2Af/XTN0nfI5RCpJ/Fr/iN6MekiWRzaQb3lLzvZytMpntNc4uPwT7p5rYEHa
ydU9MVFQh7Dyt0gJynsGwsny1gwwpV6lbD/t9Larxqo0gCebDw8KDzLqOEuj2U3k
0qHsl4zlFCcPbafwODYl+E6ZsaE2i6qIaaYkuRVNtMVDmJ60E3NBfow87xLD56q3
VH/Vp8e4kPNG/tHAfDadzy705WzmwwJHYSt1JCDPoyxlbXSrCzEDyN5w2+hq0Jvf
YbmzdUrP2MUQlvOolK/ciND0mX/VT17xsO6Wg2b4t2ZyuDkxJ9bod08/xTZk7BxA
j94zeh1q8atD27MZlCcC4ibCsF317A==
=A1eA
-----END PGP SIGNATURE-----

--xd0V7MnYEiEQnSNp--

