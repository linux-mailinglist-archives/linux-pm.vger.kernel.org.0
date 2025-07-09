Return-Path: <linux-pm+bounces-30421-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D504DAFDF56
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 07:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 344DE5673B2
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 05:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA3F26A1AF;
	Wed,  9 Jul 2025 05:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="Iod5xTBH"
X-Original-To: linux-pm@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B241C1B6D08;
	Wed,  9 Jul 2025 05:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752039566; cv=none; b=ATOoQ3tyCl5CLlgiH5/qYJc2Vam2Tu08NLwKE0e2QxZmF6ROyleQjNEFQvgXxmy26rlMfIZfph45xnxUh2djQilsdWPLzs6rs4TMpA2iwJ4PPuMVSgksJ3e8S1VYEmBPqgycgDMcmzFzt55lfxV7ybkAgeSF08VfqeQRbI8kMus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752039566; c=relaxed/simple;
	bh=n0gmbWaoMc4QHu4q+1Uxx0ElnsLuexOtG+pOjym/Ehk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGElbjPzfhbphsfU3rt62WeLQY6lfc53rM36x50ytbI7o/VsZQzHu5GdeWt6DzYF2CwzNEHPjNFnSBTefD0Y/xSRDdIbxsPF1zT8GjnVEBMmsdSqvW4Eoh6PUBGOMbnY4X+V9hGDoJolrxIog5g+32ICByPkCHFDwtmGP03uYuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=Iod5xTBH; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DE9F61C00B2; Wed,  9 Jul 2025 07:39:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1752039562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AgGo0D6w/UsINXs2Wle7uc8mU/aFWH/QOKQE3QW+Hgk=;
	b=Iod5xTBHZgdsUmi51ar9v5dLDyhumMRHF8uBR4dIFbZ+ES0dYu7ki4ZhoaDGPmY90IP/DA
	CkV1368WIXJKNOOIzFy0W16xRNktUAbJ2ZruolHwgA7Fy4N4W54g35tmUf3VIcYjnsrHVD
	R5W7pldd1tuedKl6w6PruHRYq4chheE=
Date: Wed, 9 Jul 2025 07:39:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, patches@lists.linux.dev,
	stable@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Nat Wittstock <nat@fardog.io>, Lucian Langa <lucilanga@7pot.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	rafael@kernel.org, len.brown@intel.com, linux-pm@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the
 suspend sequence
Message-ID: <aG4AilDpnqrqHXaS@duo.ucw.cz>
References: <20250708000215.793090-1-sashal@kernel.org>
 <20250708000215.793090-6-sashal@kernel.org>
 <87ms9esclp.fsf@email.froward.int.ebiederm.org>
 <aG2AcbhWmFwaHT6C@lappy>
 <87tt3mqrtg.fsf@email.froward.int.ebiederm.org>
 <aG2bAMGrDDSvOhbl@lappy>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WlasF0qNpP9A3mRg"
Content-Disposition: inline
In-Reply-To: <aG2bAMGrDDSvOhbl@lappy>


--WlasF0qNpP9A3mRg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> In this instance I honestly haven't read the LLM explanation. I agree
> with you that the explanation is flawed, but the patch clearly fixes a
> problem:
>=20
> 	"On AMD dGPUs this can lead to failed suspends under memory
> 	pressure situations as all VRAM must be evicted to system memory
> 	or swap."
>=20
> So it was included in the AUTOSEL patchset.

Is "may fix a problem" the only criteria for -stable inclusion? You
have been acting as if so. Please update the rules, if so.

> > I assume going forward that AUTOSEL will not consider any patches
> > involving the core kernel and the user/kernel ABI going forward.  The
> > areas I have been involved with over the years, and for which my review
> > might be interesting.
>=20
> The filter is based on authorship and SoBs. Individual maintainers of a
> subsystem can elect to have their entire subsystem added to the ignore
> list.

Then the filter is misdesigned.

BR,
								Pavel


--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--WlasF0qNpP9A3mRg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaG4AigAKCRAw5/Bqldv6
8gTIAKC/zQyWgLHgvPMd65NHV3TkdPwjRgCeIAbYyb9XFecAJ4qXIm2LIa7gI/o=
=taVt
-----END PGP SIGNATURE-----

--WlasF0qNpP9A3mRg--

