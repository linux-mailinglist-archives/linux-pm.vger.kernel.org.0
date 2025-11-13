Return-Path: <linux-pm+bounces-37996-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72564C59E1C
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 20:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9B43AA5DD
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 19:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C8C31B839;
	Thu, 13 Nov 2025 19:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2zBNUi+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6653031B13C;
	Thu, 13 Nov 2025 19:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763063986; cv=none; b=KQPNx7n53TO1wCk8wNzw1THHZW4JxBgmOkNK5PMQxm+zPVOxxNALWJn8U1wge/ADs74PvxLu5vm3U7H7VbPoGX3BoFUn0+BtACZ9kv2H5FJuxCGbWV/7ez5F4P2kS0xQcqFwQi+bbLXfI6gUWyiQJBCVJv8P3+5AV9rO4LhJie8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763063986; c=relaxed/simple;
	bh=albEH2IwQeApwJMRsxBQcInlleO96o5R96BSCYwWvmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dg1e06230Bhq6aAP9vBulx6cs8PAHvvahrQZS8Oj1o7ig+02bmJbDU5K3HWq9TmG97xH+djtU9XUmAH92kA/Enj1UPDTxQseoCT5AhyhvnA1xSFWXRNjTFBUreptdqB3EbhVSJByBf6euiDRwIXB3fI7oVqz+Oam/+pdvjWhkPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2zBNUi+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0E7C113D0;
	Thu, 13 Nov 2025 19:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763063986;
	bh=albEH2IwQeApwJMRsxBQcInlleO96o5R96BSCYwWvmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B2zBNUi+8bbGLwAJ/33NOAz2+djFfC5eQbi/Cth7/8eALanAeHfR8UqigSOeS1eK6
	 0J2KS1AqXEUZ3b3W5eX+BU/cZNax5FH2whih2ho//jwVgL+rG5Ae4w+aQNPoqaO8KB
	 U1ZaqS9NW064N38cdtaqw75gk/+uAIQrCLnBFJncbiLJ7Sf5d12aH30GhO7SEhF9Aj
	 FbDuHSeUbiAN6hudq2B3qtbZKH7BelJciRHB2cGpLmaxZHF/rSe8Geog0xcWL0Ho4C
	 px/YF+CLRhJJsZY+qd2+KlfWCgdW3m4W61lk2kDZk61HrVM8vvvceuW63Xk0mTH+0R
	 m4ea7uK/dEGYg==
Received: by venus (Postfix, from userid 1000)
	id DE84B180785; Thu, 13 Nov 2025 12:16:21 +0100 (CET)
Date: Thu, 13 Nov 2025 12:16:21 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Lucas Zampieri <lzampier@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Bastien Nocera <hadess@hadess.net>, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/3] HID: Add support for multiple batteries per
 device
Message-ID: <z7rlg27pref5o3y5c3lrxab7pilzuxqgofuogh5547kw5jpj56@basmdf4uwh56>
References: <20251113001508.713574-1-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u3i5adcbhywjdycu"
Content-Disposition: inline
In-Reply-To: <20251113001508.713574-1-lzampier@redhat.com>


--u3i5adcbhywjdycu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH v2 0/3] HID: Add support for multiple batteries per
 device
MIME-Version: 1.0

Hi,

On Thu, Nov 13, 2025 at 12:15:02AM +0000, Lucas Zampieri wrote:
> ## Request for Comments
>=20
> Is list-based storage appropriate or would another structure work better?
> Should we support usage-based identification in addition to report ID for
> devices using the same report ID? Is sequential naming (battery-N) suffic=
ient
> or should batteries have semantic role identifiers like "main", "stylus",=
 "dock"?

If unique semantic identifiers are available they are obviously a better
choice.

> To HID maintainers (Jiri Kosina, Benjamin Tissoires): Does this belong in
> hid-input.c or should it be separate? Any concerns about the backwards
> compatibility approach? Meaning, should I have removed the whole
> dev->bat legacy mapping and use the new struct?
>=20
> To power supply maintainers (Sebastian Reichel): Any issues with multiple
> power_supply devices from a single HID device?

I don't see any issues with that.

Greetings,

-- Sebastian

--u3i5adcbhywjdycu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmkVvf4ACgkQ2O7X88g7
+ppbvg//XLJry0vRnhIFIutwoLrryUxt16rSUfo0i/YAB03VQOQ/2o9XzmSUkFlO
2WGvBbm1dRjkfw44CXCQLNvdz5nfKjSRvAnVRV2JW4kqjG67hdtN18iR0v0Hz13q
VWWYtnDBcGS1+ICCZJfVRW1K03+3SaUSU5luyytIx22qAI5+LMfaW8FxqgbPNNcX
uEQtMIIDaX4+cy/yGmdOXq2lPAj35tHcLR8hOmWo6bY84Byt+SuTItIQhCKzPGHO
aGTN1oyXCwqVbsrWlSpjqgeLstWNBqjMzMHkmeU2rA4SJkgMnLDkGICLfhgbnnfz
rwmVK/xHcJGvR8BB6YGRAs8yt8dUIbYSuBYjcuVHCN/ntgcQUbGybiSMmXArlFBV
aYgLyzOduvdRfq+FYM8xQgX6P+q54mZ2cnQdIoiw0jx8WC3oFid/E+wn+IVjlK7w
H3mbeOoJtIIjJLw7wkHRkjBISgxVxeJYavYTGD1dkZH3DjeQDlTzwZxprtUNcl3Q
P8EzRKoQkYXZBOL8R/46CiOpFkBnYXDfavzrQZQ/3G+xjEi3uhr8Z+gVqqmF5VzC
JtB8Aoh26KHrKC5MSh8Z0G2GWFJdsEAwav0DpgWvk7tP5jfyCWy06VU2gXiaME+r
YO31U1dvvtM9jB7wCpQWyP1PoZXWQ9gPBvEkulzIYl6Dh02tDfs=
=uYh1
-----END PGP SIGNATURE-----

--u3i5adcbhywjdycu--

