Return-Path: <linux-pm+bounces-38757-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EFDC8C41A
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 23:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE7EC4E0F77
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 22:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEB4301718;
	Wed, 26 Nov 2025 22:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6RiDFTX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1753D2FFF89;
	Wed, 26 Nov 2025 22:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764197615; cv=none; b=V3+c25MMuts5FL50EhQzqjc8OD+eM1nnePOP/tEOLiJHTpY5Fh9blJ1ZeEK6j9FFUj8AsxCqvWLgmn1K8MgjxO++JqcsqYANFqkUQ0Nq+zgNWdPp6jbB0oIGWJimYrV2uzBW5qNgXHaFA3U4o4bXSfjg0J9N1jK24F21h51aTQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764197615; c=relaxed/simple;
	bh=sIWJDETkSZjUysA1861IYhNARDTVrkDW8iwNBjEg7Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgtTVjllp0ctJ3Mr6BrkWPHW3fDmB+HoF3w8d7CfJGgVlbkF7bxb/MVkDbknAjBWCio/cu89tValvp2WuEPdcsfp8jmVoPhjI0CRTM7lCgQJhd+a+K+NVvTNCZ+sOAhyrI/qfRvWCeDXcslWWklOXGwL541VbRsExB2KSjKVfvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6RiDFTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE3FC4CEF7;
	Wed, 26 Nov 2025 22:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764197614;
	bh=sIWJDETkSZjUysA1861IYhNARDTVrkDW8iwNBjEg7Ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f6RiDFTXJmfG8hzrmXMh4vvW7C6tqTW8VxlhHwIck7UNKlLDrQgu8vnSXucyw7Paz
	 rxlT2sNj7SR7INCyudTxtO6og7BgteyO81ZG1TtwWY1HDKEROgZC3c02ypTwHtb52w
	 0E1YiufzAE3afqKy5FTE8F0yz06qgf0KMRGvFYlxqepPx2tVBiC15x6GofG4ZjR2w6
	 yLWVzTgDElkjoQOOUJaFtZ1zGjO9UfgHtiDIOUUL7mqhdf2qTNqnYdlyze/pKt7HBs
	 JiWYi6Ebu46ICxChObfF1rJW4ySbqSsNqAGHKmOIhz+B7NrY/pydJDO+qF76sktWWw
	 IQQbsZSRlacEQ==
Received: by venus (Postfix, from userid 1000)
	id F094B1802F8; Wed, 26 Nov 2025 23:53:31 +0100 (CET)
Date: Wed, 26 Nov 2025 23:53:31 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Hans de Goede <hansg@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Guenter Roeck <linux@roeck-us.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>
Subject: Re: Linux 6.18-rc7
Message-ID: <fovf5vq2zfxogkon3vmy2tctjeieplisowymk4t4y755syuwvg@qt5rsfzjhkbc>
References: <CAHk-=wiFS7=wrjCoEguQUqwd=L4tJHNP8mCdagg0FR8NQTGLtw@mail.gmail.com>
 <0e90cb97-c0bc-48a9-92ec-2493e89ce6d5@roeck-us.net>
 <CAHk-=wj0coxhdnHMvhKAGfEy3AMgk+BX2n=Qvemt0Z=ZxsM8+A@mail.gmail.com>
 <d79d3d38-1fd3-4708-930c-621a4c28cce1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u7m4hd3i4ptkba3j"
Content-Disposition: inline
In-Reply-To: <d79d3d38-1fd3-4708-930c-621a4c28cce1@kernel.org>


--u7m4hd3i4ptkba3j
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Linux 6.18-rc7
MIME-Version: 1.0

Hi,

On Wed, Nov 26, 2025 at 09:45:16PM +0100, Hans de Goede wrote:
> Hi,
>=20
> On 26-Nov-25 9:37 PM, Linus Torvalds wrote:
> > On Tue, 25 Nov 2025 at 15:49, Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> i386:allyesconfig still suffers from
> >>
> >> Building i386:allyesconfig ... failed
> >=20
> > Bah. I'll give up on waiting for proper channels, and am just fixing
> > this myself.
>=20
> Note there is a perfectly fine and reviewed fix for this sitting
> in the linux-power-supply/next tree, unfortunately this never
> got send to you this cycle:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.gi=
t/commit/?h=3Dfor-next&id=3D3fd1695f5da0538ef72e1268baa00528b589347a

mh, I don't remember why I haven't queued this as a fix (i.e. to my
fixes branch instead of for-next). Sorry for the mess.

-- Sebastian

--u7m4hd3i4ptkba3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmknhOgACgkQ2O7X88g7
+prt5xAAo6BparuMO3e+N4KQtaDzWhx6fiEy8bXH+O5YeF8i/Y9PMcDje7j6D5ff
9m7Arq3aydW1gcUbQYGzLRoS/ofZ0CjwAwKHBZzjUyIAD8TnEt+YqkR6DSxTS7WS
HnazWXfK46tWLTI5wW5y8bOj7a6dlF8Q8x7Kp42YirizRjbiNcWDWZiwgIJrpx4Q
NZiSLX5bfnu1g+Z0qPGoCYWYKr+o+3+4e3ESR3NHd71jYgXjuj+r4S1WEf9sOxub
yk001YDiY50juXDM82d+hQKcLVzfG+TShzjHxSzoOYdnQNsQcGPL1HYehmxiCEuP
zt0PPLM9A6mFxWFExip6Lg1KG/+PxnxoHV2RhFqJccIAPCQ6kgSw+VvvThNizCXY
dK8gMFIUd3E1SXoxhl77B2Qi16sPZCEmOBVBFE5ii6xAiMWsAmbCSpcvEuzpHtyo
QH4d+mYR4W0FoX9nKjethj16Kw2+rRrBg9WkXeiBjCDSDopLaBbxu7Q0lskQPW++
JMzUtLxfLBv3Fw5GhQCf8gNNatE0IpgoYF/zIAGVJCFG2wUHt932r/8jq2vLE3XZ
zyB2CCaOzhENdbaj/ONhyxY48hgs8brqRyS6Tam8SWKEAmmeBC7pI2Mop8s8ivxz
XDA6yuhk9lrHhEIe3vCz5eR+8R7hRPFW9Q+obkMmUoRHILqvtGM=
=juG1
-----END PGP SIGNATURE-----

--u7m4hd3i4ptkba3j--

