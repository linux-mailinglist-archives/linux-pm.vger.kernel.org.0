Return-Path: <linux-pm+bounces-23903-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570A1A5D733
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 08:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63D9B16B951
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 07:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401081E9B07;
	Wed, 12 Mar 2025 07:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwkpk1x+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157C51DE4CE;
	Wed, 12 Mar 2025 07:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741763988; cv=none; b=LSp/pCJ+3E66VmndmPUKOCiWnZ9X4GLwQHc4JSViEZax8jlVhDPM3sLb8iMiFD+QR34Eeezhz8xS9qHANIiE7IbN4tNsQbByUep4U8kxU8rrY9m3dSERwjVCD8nHi8RZpSn457Qzqtr37hcLm8W4EFlkb9+A4SGhi4CV6sa/odg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741763988; c=relaxed/simple;
	bh=6Vp2RbvbiDxsKzgbBgmKIz+1OnS+5xYMUafOAmv8oO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E//SfPBQxE7akf0wOuXbcxipcdFUQWIaVn3VZEXurR2Mz7vycRoLr2PPd0cvJ2jZ51v5T5kdg6gWSMUWNdbsQNmETXYlmlr9DtsNinr8Q89TTFFAr5vTQfgQRgx8Y+g+10YKF9sBB+RpHA0ZI65HxWEdTrgXzbSPQYf1/xyW0pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwkpk1x+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4903BC4CEE3;
	Wed, 12 Mar 2025 07:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741763987;
	bh=6Vp2RbvbiDxsKzgbBgmKIz+1OnS+5xYMUafOAmv8oO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mwkpk1x+a3IZVy+9eamRc7ExEz6XtNhstl20LiJEAA0+mtnya75dTqedvDXckFFpC
	 LJc7kLbkG6SVty+WVQscA7HM5X4pfY2YAcmGgeMf3gGAxMsrOzG+ypQHP1SE54SdHz
	 Uq2fqlUkLNOvm/k/8TFF/nIoobBBn5zRmh8nQRutCTbVBVdx9x57kSuCJ5+lzqHjBr
	 sQH9nCbxxOFuMGPxq4aKLFkScecX0NzggxirqoLb+tTGQ8nMP961Qa9XFQ3ixaTAKZ
	 //MkmI4ytuX7dKPoRqzWoVewXrzwtitLVmVeEqryMfT5Hk0X9YJzQLGSkjW2sXnm1x
	 RCPbMvHr/hvgA==
Received: by venus (Postfix, from userid 1000)
	id 55F8E180692; Wed, 12 Mar 2025 08:19:44 +0100 (CET)
Date: Wed, 12 Mar 2025 08:19:44 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Sicelo <absicsz@gmail.com>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, pali@kernel.org, 
	linux-pm@vger.kernel.org, maemo-leste@lists.dyne.org, phone-devel@vger.kernel.org, 
	Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, akemnade@kernel.org
Subject: Re: [PATCH] power: supply: bq27xxx: do not report bogus zero values
Message-ID: <b6xa7az5ohopf52ykp3quomkqpo5xmt2fratcmcw3efmkpa6nm@eth4wv4wm577>
References: <20250207220605.106768-1-absicsz@gmail.com>
 <CB5B8FE7-D619-4D30-BD2D-58B6CEF83D46@goldelico.com>
 <511351B0-A78B-4517-B183-D39A4F807CB6@goldelico.com>
 <Z8FtlaYkbVG1xrsc@tp440p.steeds.sam>
 <C0E0C7EA-7C42-4DE3-9FCA-DAAA7B65B583@goldelico.com>
 <Z8GHuu8RXkcY8utL@tp440p.steeds.sam>
 <4D7D3E00-59C6-42F6-AE96-F04970D60E8D@goldelico.com>
 <Z88g2yBuRkCl_yAu@tp440p.steeds.sam>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z7lfqwgmcoaxlzdh"
Content-Disposition: inline
In-Reply-To: <Z88g2yBuRkCl_yAu@tp440p.steeds.sam>


--z7lfqwgmcoaxlzdh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] power: supply: bq27xxx: do not report bogus zero values
MIME-Version: 1.0

Hi,

On Mon, Mar 10, 2025 at 07:26:51PM +0200, Sicelo wrote:
> Hi Sebastian
>=20
> On Fri, Feb 28, 2025 at 11:01:35AM +0100, H. Nikolaus Schaller wrote:
> > > It is in linux-next [0]. Not sure if that counts?
> >=20
> > Ah, I didn't recognize that (and must admit that I did not search throu=
gh
> > linux-next). Sometimes maintainers close a discussion by telling that it
> > has been merged.
> >=20
> > Maybe Sebastian can replace it or recommends a fixup.
> >=20
> > > I guess the only option now is to submit a follow-up fix?
>=20
> How would you like me to correct the bugs I introduced with the patch in
> the subject of this email?
>=20
> I guess it will either be:
>=20
> - submit v2 against linux-power-supply/master or
>   linux-power-supply/fixes (so the bad commit will be removed from
>   future history)
> - submit a new patch against linux-power-supply/for-next (so the bad
>   commit will always be in the history)
> - use a different solution you suggest
>=20
> I apologize for introducing the bug and have taken the time to more
> thoroughly test the changes, with help from HNS. I have the patch ready
> now, and just need to be sure how to submit it.
>=20
> Kind Regards
> Sicelo A. Mhlongo

Sorry for the delayed response. You need to prepare a follow-up
patch against power-supply's for-next branch. Dropping the broken
patch would require rebasing the whole branch. The only options
you have are:

1. Revert the original broken patch with a proper long description,
   then create a new fix
2. Add a fix on top of the broken fix

Please don't forget to add

Fixes: f3974aca381e ("power: supply: bq27xxx: do not report bogus zero valu=
es")

Thanks,

-- Sebastian

--z7lfqwgmcoaxlzdh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmfRNYwACgkQ2O7X88g7
+powdA//VVZrqIGw7HsCPdNa9ZHEL6GhoS5krlBLUdqqEsxEd8w8xi1BGT8V3wox
++Jx5eU3I/siOr9aLQzBXQCcqfzbdDFUzHEFKIS7tzgsTS9jBklLE5Z4DrZ0IWVe
BtTPR8tO+EuxxtBD1COQZR2TouGflHC8krcfQ47vwmEeP5FZKXayYNgNr1zsncQG
JzTrCe8D9Tq1C4ESnfDKZbFxy21dyUXs5UH3/AlI8IlQhozT1UNN78Y34v4QbT8d
VQl8CGr12w2JfYvTxywl4LMyY1Lyx5CW+a/mHKHltQEXlSwABFY6T3Yxa95DEKvE
6SLrBQrleB+FIu7S6647DiddoDt+cccRGjFCvDqBfnpsOQVCRUj6Qj9Cq8FvG9rw
szAURGenXUqPy76LFW+09CTbzTSCcj1/i92Sk07sObpUQXyNsCfrjiihoYrNg4Hh
ftKijYIg++CTqd94ExKMxSSiG/41e3mjtTSzcO0C/vPyNhkjlKzMddq9jMD0lDzX
YCRaS5GopNvZpMeVgVTJ/hYv31rc7C5tKPgJ7996BmWMVWdtTd7f3TzehoB9GUeu
U2cl0KEU6v5GAXgVQAF+20eexd8em5kR2KGSJPej2WNR1l7Q6ZusTh8rodR+8fA4
2JwgWNG+Kb1XEPB+LA4TQuy390d4OaWywU1N7/YMb99qr9LSRP0=
=xTJ+
-----END PGP SIGNATURE-----

--z7lfqwgmcoaxlzdh--

