Return-Path: <linux-pm+bounces-30404-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C16FAFD8CD
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 22:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0504565A32
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 20:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43C8241103;
	Tue,  8 Jul 2025 20:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="VcLLmneH"
X-Original-To: linux-pm@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5A421CA0D;
	Tue,  8 Jul 2025 20:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752007793; cv=none; b=GpnBHkTDRqm0Gqfbv4gU4Qj8aAocoxnCzn98IN6BiT4IBnbZ9Kv2ZO+I5N/2T/UcZI6byO8cVAoFayYsh40qVG72jDjRtfPbOO7jt8F5sGQQUXDo/XWB6BGU0VRcFuzFexp1VLKoJQW4wpAVpZJwKYiITdqqeAqLa7cHXT16H70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752007793; c=relaxed/simple;
	bh=eqcR6mtdd9dODoWDixq3+pW1l3ct4DK+Du4dQri9f/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCqPivr1PHUloKr1OtDDUoUCSE8SfRO0iaSVTL3j4K/PPjE3/amemTQxhssxloampUoPjN7M0dbpaV80eBllI8IeSjsA+kECeAfwW2+gLv2nrfmZ5n/Mw/jh09dN7VVnv/2Fd+4gndOV4nMiWY1FuP6Plqja9Ni53w4ZdzaSTnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=VcLLmneH; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EA61C1C008E; Tue,  8 Jul 2025 22:49:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1752007789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B6e+VUwwKAkVhrA42dAu+CepDrK4drho9sSBVbt8xn0=;
	b=VcLLmneHsxHVSgw6vwWj2fWBquaRQe6L4Xuvs5NRXfKZB0BGYgEG4f/K5v6nWiYg6+FKaK
	C5fdO9qGaH0SMJmlTGF/5DdBRG7m+nj5iUutZGVXBw2JKvR4NGJqngzBZ1HbmfMko+zVBE
	P/keGjFSPpseZyRV/rtetdyl51LW7Xk=
Date: Tue, 8 Jul 2025 22:49:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Willy Tarreau <w@1wt.eu>
Cc: Sasha Levin <sashal@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	patches@lists.linux.dev, stable@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Nat Wittstock <nat@fardog.io>, Lucian Langa <lucilanga@7pot.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	rafael@kernel.org, len.brown@intel.com, linux-pm@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the
 suspend sequence
Message-ID: <aG2EbUlZJQ/MxwfY@duo.ucw.cz>
References: <20250708000215.793090-1-sashal@kernel.org>
 <20250708000215.793090-6-sashal@kernel.org>
 <87ms9esclp.fsf@email.froward.int.ebiederm.org>
 <aG2AcbhWmFwaHT6C@lappy>
 <aG2BjYoCUYUaLGsJ@duo.ucw.cz>
 <20250708204607.GA5648@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kf9+gjiYr3G8QaDc"
Content-Disposition: inline
In-Reply-To: <20250708204607.GA5648@1wt.eu>


--Kf9+gjiYr3G8QaDc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2025-07-08 22:46:07, Willy Tarreau wrote:
> On Tue, Jul 08, 2025 at 10:37:33PM +0200, Pavel Machek wrote:
> > On Tue 2025-07-08 16:32:49, Sasha Levin wrote:
> > > I've gone ahead and added you to the list of people who AUTOSEL will
> > > skip, so no need to worry about wasting your time here.
> >=20
> > Can you read?
> >=20
> > Your stupid robot is sending junk to the list. And you simply
> > blacklist people who complain? Resulting in more junk in autosel?
>=20
> No, he said autosel will now skip patches from you, not ignore your
> complaint. So eventually only those who are fine with autosel's job
> will have their patches selected and the other ones not. This will
> result in less patches there.

That's not how I understand it. Patch was not from Eric, patch was
being reviewed by Eric.
								Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--Kf9+gjiYr3G8QaDc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaG2EbQAKCRAw5/Bqldv6
8oqVAJsHwmGC9LtixX8rObtxca3u89YL+wCglZXkSkKVM9/SY0h33Hhigs2PI08=
=LJAt
-----END PGP SIGNATURE-----

--Kf9+gjiYr3G8QaDc--

