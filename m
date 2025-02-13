Return-Path: <linux-pm+bounces-22022-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D87A3489A
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 16:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4F5A16442D
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 15:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBD91D6DB4;
	Thu, 13 Feb 2025 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="jSmhxf+u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6660518A6C4
	for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 15:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739461903; cv=none; b=Qu3/ncrM+uIQ+UJsH3L8yb69vR/z7YlEQHyFXfDsCzqEwEdb7+xLsobirrzr8Izty07tIlvo4/KJQuZRcLJ7v7+eJZUpb5jCppSAdTGgCK4OU0KT6RgkOqR/jan99Ws18pMMyzuB16qHT9vTl07PN9cBUXhshaAW8JfEJV4mPqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739461903; c=relaxed/simple;
	bh=dWOaHC0+96XuRzyjiuYqb/FLWuMQd9XDcQE2Lru9iWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLEG+0xCYgaw/GShRqOBuNfOCxPSqy8liNiHcCJ4mGIWs9IKfajdiIDOH6qRgRPSpIKACiGi9LMa6GyLu+zhPYpaUi/WH9j4bluNxmG4/fNR8y69KQZ64ZD8X42YRy2upsAk3mIeYMuiGTSRzHylI9zGiMcfxjkdDk/RttD/KeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=jSmhxf+u; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=dWOa
	HC0+96XuRzyjiuYqb/FLWuMQd9XDcQE2Lru9iWw=; b=jSmhxf+uPseSkWq6Jc5r
	rLJu93XhNzTqAnJdj7Kv2slaOPz4N3jLnVTE3ML3DRT8cNQb0jomMc9Jj4vlzMVP
	4mWbnBdP//4BdKFRbtYMoMvauHVpA60Gf812u39xa+yB62IjxROv6rEman6OX8IE
	BKpZUUsevSKIx3q8/JGAt/rD+mZyqkbE4F6G4Hc3vj7JbzFX2mn9D/QXkE2fPzA6
	pfUt0nKEki1nwFFicCQIN1PROKHCiMPoQRAiCuXYyRcHTdcMpploXwacET4Rcyh0
	JkBILJGdZlXw/mRfQ/WpHN99iYoWr3X1Bx4xBFbceJiSVT4kgrjh7isnuq/0la9L
	VQ==
Received: (qmail 1932185 invoked from network); 13 Feb 2025 16:51:38 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Feb 2025 16:51:38 +0100
X-UD-Smtp-Session: l3s3148p1@ExqICAguFspehh99
Date: Thu, 13 Feb 2025 16:51:37 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	Bence =?utf-8?B?Q3PDs2vDoXM=?= <csokas.bence@prolan.hu>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
	Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 1/2] power: ip5xxx_power: Make use of
 i2c_get_match_data()
Message-ID: <Z64VCeUWIsNbg_g8@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Bence =?utf-8?B?Q3PDs2vDoXM=?= <csokas.bence@prolan.hu>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
	Sebastian Reichel <sre@kernel.org>
References: <20250213114613.2646933-1-andriy.shevchenko@linux.intel.com>
 <20250213114613.2646933-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Jnew7k6MiJ09mEs0"
Content-Disposition: inline
In-Reply-To: <20250213114613.2646933-2-andriy.shevchenko@linux.intel.com>


--Jnew7k6MiJ09mEs0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 01:45:04PM +0200, Andy Shevchenko wrote:
> Get matching data in one step by switching to use i2c_get_match_data().
>=20
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

Applied to for-next, thanks!


--Jnew7k6MiJ09mEs0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmeuFQkACgkQFA3kzBSg
KbaVyQ//VZfDXVtbS8X2ax1ClaKPnDT2Aac1yuVmRlBRSw/NqcdwDCKFwQuLyEcg
rtAIOGtA9SW/DUaToKJrDvDoVTHpv9s1kEyZEO3SjCxHzRJytLqMpp2foQYYSWRK
tXhHvWPQRGozXWKcSE7CyU4FsKf7GPQOlbuQ1XE6jtzr1zKs/62VQnw4u1uF/T3k
Zfw2+RKWv3VloHywu53rQJPaDbND/1XAUbjAmGBEw/mi1GHtO0xY5kYPzzWBRy5E
2UAv1QRJyFYIqhWaOnE8Y0Fs0A3EU2301tb5auLry9gcrVkgImy29sIRB5/jki3g
Pvp0uaRExHSMAhYhHa72UudqYzE8to+VGhlzFv3h3G7tfOwS/N9HWZ5lLXbpa+FD
GBEd+zDLUg1m4L/+fTEnsdxCxbCKp31Y9ZDuu/LbpKYoEKEnpfVPrLonRNZutafX
GW7AmwCOAqN6Nr/0DjkVlY7a3o7SOxuoQU30T1YnJKnauJyv0se4SeIR1SNNXFuJ
bjxf+D/uCRc79Dt0BRuyC4pg/IsgXHoO0ZGjRyVLBwCMysEo1XSlrFJna7Fynr1r
X6u8x410wIXn+UYdlrWo6E68WzR1esQEkCAdpsBBNRTYOpLZQy7Yez6WEy3jhvE4
5mlDef47jxmSdAY4C6abc7+mPqDel+bRAFvdEc6mDyhmeo8bejI=
=4BJb
-----END PGP SIGNATURE-----

--Jnew7k6MiJ09mEs0--

