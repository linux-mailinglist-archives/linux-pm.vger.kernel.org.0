Return-Path: <linux-pm+bounces-30334-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A99CDAFC2E1
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 08:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 806BA1899D39
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 06:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15974221282;
	Tue,  8 Jul 2025 06:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="pi9S06D/"
X-Original-To: linux-pm@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FB5220F4C;
	Tue,  8 Jul 2025 06:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751956793; cv=none; b=bAIBPJzJA7NlsEGJDKltMO632MeONBVdxt3a+Nr2rcsAbjo1bRkWLwt9X19hgJv3gX6cCcK6D3ctVmwmVZokhclq2G0dQ2wVxDqaGdIOlkfESuFjQbzuyLzl9qQvGTj08duLc1DeJsPOpmiycai4vrixnCneikTnmCuyNOdXfOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751956793; c=relaxed/simple;
	bh=/+rZ+qOaO2sDKbnd4NLr4zgegw4MO6vu4F3mLw7BGhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qcn36Qw6KMXKozL2Tc3oCvJ4okjZ5Q5B5CUPGaaTUowP19YP1ClHrQLd4GqPrL6cq06KU6D35vlr5H54vpt6nb0EQG+uPdODQqhnswHT57dFM/xcnYuQuQ++zcUW7Tu3uCH7fvQQoGQEFT0aYUyGtw3l8/O+Pp2RzgJMg0oi604=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=pi9S06D/; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EA5551C00B2; Tue,  8 Jul 2025 08:39:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1751956787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BkQDJKWFePkir3VVOngFU49HXADxPt6pfGrGXj/dAME=;
	b=pi9S06D/6cVWHJpKxkRtDpDBSlrWst1CBY0sx2rT9xV6TtgDCsNaqgO3WyNekmrrEgNPKv
	2IsGB0eSptYebbZJzyzlSLJjSkePo25qvzS13RPNykBqBw7sYCXVrzeaVATXOK/U9Llx2c
	9RZ5v8uUF+67/IdD+irc9CBiQX6zQmg=
Date: Tue, 8 Jul 2025 08:39:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Nat Wittstock <nat@fardog.io>, Lucian Langa <lucilanga@7pot.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	rafael@kernel.org, len.brown@intel.com, ebiederm@xmission.com,
	linux-pm@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the
 suspend sequence
Message-ID: <aGy9M3zEX7rgo5sS@duo.ucw.cz>
References: <20250708000215.793090-1-sashal@kernel.org>
 <20250708000215.793090-6-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1kwsET5uSiv9nLtr"
Content-Disposition: inline
In-Reply-To: <20250708000215.793090-6-sashal@kernel.org>


--1kwsET5uSiv9nLtr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Mario Limonciello <mario.limonciello@amd.com>
>=20
> [ Upstream commit 12ffc3b1513ebc1f11ae77d053948504a94a68a6 ]
>=20
> Currently swap is restricted before drivers have had a chance to do
> their prepare() PM callbacks. Restricting swap this early means that if
> a driver needs to evict some content from memory into sawp in it's
> prepare callback, it won't be able to.
>=20
> On AMD dGPUs this can lead to failed suspends under memory pressure
> situations as all VRAM must be evicted to system memory or swap.
>=20
> Move the swap restriction to right after all devices have had a chance
> to do the prepare() callback.  If there is any problem with the sequence,
> restore swap in the appropriate dpm resume callbacks or error handling
> paths.
>=20
> Closes: https://github.com/ROCm/ROCK-Kernel-Driver/issues/174
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Nat Wittstock <nat@fardog.io>
> Tested-by: Lucian Langa <lucilanga@7pot.org>
> Link: https://patch.msgid.link/20250613214413.4127087-1-superm1@kernel.org
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>


> ## Small, Contained Change
>=20
> 3. **Minimal Code Changes**: The fix is remarkably simple - it just
>    moves the `pm_restrict_gfp_mask()` call from early in the suspend
>    sequence to after `dpm_prepare()` completes. The changes are:

This is not contained change. It changes environment in which drivers run.

I have strong suspicion that you did not do actual analysis, but let
some kind of LVM "analyze", then signed it with your name. Is my
analysis correct?
								Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--1kwsET5uSiv9nLtr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaGy9MwAKCRAw5/Bqldv6
8ghtAJ9sA/huV29bml+0HHb127MElooywgCgnva6bxPc+31mjS5JfXMx0Nis0Ns=
=KqmG
-----END PGP SIGNATURE-----

--1kwsET5uSiv9nLtr--

