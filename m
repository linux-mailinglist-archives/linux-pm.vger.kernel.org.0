Return-Path: <linux-pm+bounces-36207-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65382BDFED5
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 19:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FD854E1C4B
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 17:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9682FF14D;
	Wed, 15 Oct 2025 17:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="RckE5KE/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E619C22541B
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 17:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760550458; cv=none; b=Nu5crqqSqemT0UljGix4Mt44RXt6xJYdb2jQeYOeIeRlhEi5hTkfOcMYRPJ2xLh+JoR0uXfi3I/kpkn301jasr2zX1gb2dmTI6pIb0FCjuH82snaVnSlqLI5HIFIu2VmMZwsHWkT2IMm41ZILjgcN6EvvHIWGXFRo8W80TZUqTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760550458; c=relaxed/simple;
	bh=XYci9Jbg1YSxJrDSQcfb432jQLWAtdjEwDwtR+vFL/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpfC67nBwqpXeVdgyrId7/HRWKJhZzUEU6Vgy5rGtKSVe8mq4YXv6YJtbgDZRzxkGQELAKI+KJ17Iz/JsDxh0Xq/d9oavg6gx1VQg6WCyFBNpYfhC+m2LpnY2L45KhkxTUTYHb0wtO3PoO9likUKWhW8OI8bEZX1MwvbwRfLnqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=RckE5KE/; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=unMZ
	MaXqH6erkDNd8ZTHo4kcwNA9vy2tQxAx9IBZ26Y=; b=RckE5KE/mHjqjDx20G8r
	eVgXD4IfziC7m++Zu/jEK8xcjIbZdb7m4w+iEVRYBhvofiOMthqCSRqHss8ZtqCK
	c6n2Tx3UBTy0ZwhVRCi1sBF+1/3mdVp3GLSQlU7cdFPvQGmyy4NcQmwnmjVM9gXB
	53pP59r6Ne10763i52l7afJCQljg5PV53L4m7+AsmiGikJA6eYCECVjySv6THKO7
	Dmq7OCsQciMBuUXMQI9Y0EE3LrJnJBd516BRf/eWLqiyG0hQmcvmKA/UIOApSMl+
	KE8/dHPElxxaItP3FXB7X/9j72zXEdB+wi3LtQSubGZ/9CnkFFvoiZcRAXSWmh+O
	yQ==
Received: (qmail 3498416 invoked from network); 15 Oct 2025 19:47:30 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 15 Oct 2025 19:47:30 +0200
X-UD-Smtp-Session: l3s3148p1@mfTsFzZB/LO57tt+
Date: Wed, 15 Oct 2025 19:47:24 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pm@vger.kernel.org,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Zhang Rui <rui.zhang@intel.com>, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] thermal/drivers/rcar_gen3: Document R-Car Gen4 and
 RZ/G2 support in driver comment
Message-ID: <aO_eLEFLAnjc8n4G@shikoro>
References: <20251015155905.186612-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="agBlTKt9ud7zAUkN"
Content-Disposition: inline
In-Reply-To: <20251015155905.186612-1-marek.vasut+renesas@mailbox.org>


--agBlTKt9ud7zAUkN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> - *  R-Car Gen3 THS thermal sensor driver
> + *  R-Car Gen3/Gen4 and RZ/G2 THS thermal sensor driver

I am not opposed to the patch. Just want to mention that such
information gets stale all the time, so I would suggest:

+ R-Car Gen3 THS and compatible thermal sensor driver


--agBlTKt9ud7zAUkN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmjv3igACgkQFA3kzBSg
KbambA//Y30MTXO3cZ6UA0iQGOqMyTmI7VHLNiTEGQZvtBq0/KtWXCXQa5PpaT3m
NgU7E7o+fpkVB0joBuUJjK425t2MllL6DXTRp5OaWywDM86rwjFPPsZSZR/Qfz3F
lgc+ffSGPRMTVteTdPbfkj0Qmvrd3ityLS3oaXqRPzDPvNge+w48p98yqtqjzbGs
WByEvaHwQHtlF++OoX9BA/kzU5LyAyc/tpbw+zpbhAy1t8EGgcNAT145qS+mX+C7
MhtBFuup322xE1025Hh9rYxk+fA7G6c5QidLVLps8eGEjgiOFf0bkslVKh8WjWui
WuPZ9w2DpM6K6q0+KUNWTKJhkVZbbY4NJ2KAGjlLDpBPf/5bUnEwErmEj3LdzybX
QGHwupBlnXXLVEZfAoIKgayOCg4ycNeG/rxkvj8Cp9HkaaktSAPX0zEliECMLxy2
Kgd84U+GGxlYxipXuBoapcJ8g2l6zBfpi/fZNNrJp1t/igY/L3IiLZ0gFjsmRuW3
A9LllHNP+ukopD5uYRclmzZxd57V2ZU5ZM1fmHJXb88yNgWGMtL7DP2HD8GozOzi
8IDorr7a3+zxRTdDlmaNrk/WkaUKYFEymVlPjS0mkGTYJjlC8x37yrlQ1AFl9VIB
2FvrkX+MH4cwHDk0H6q8PLIBa5M0b6Df3FbRMGxoVwzD54Go0No=
=fe+O
-----END PGP SIGNATURE-----

--agBlTKt9ud7zAUkN--

