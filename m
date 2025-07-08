Return-Path: <linux-pm+bounces-30400-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104D7AFD885
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 22:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2E5F7AD591
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 20:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED939241690;
	Tue,  8 Jul 2025 20:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="qwDekM2X"
X-Original-To: linux-pm@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CF323D28E;
	Tue,  8 Jul 2025 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752007058; cv=none; b=L/NHA26po3H8piFT4yqZ7ExPdQwiTnCnmysyX+swVmi7RGaSAGCBWio4pjaGm4Dhxy0dhXuJYq3N5puB8ACfBYME6YDx9181zOYtL0Pgfbsged/j6ESObwPsGcs8qAbbtLBQwiyuC/o+EmBrKlyig+sDk3sTvfK8QI7kuaa1p+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752007058; c=relaxed/simple;
	bh=lVEtCaM7F5XNE7/1Gl7B82FmK4I6MX75xDzCQd77dLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKXkjw9aZdwQLOeBv6JnnpR7IZTj8fuo66FNdmbPXVf1Kq7knY9k31dIoFIN+N76+DEg69tlW7G8HNpLjgry/uipKEDHUWFZJPOnf78pDl1H1PeNdJtfIh8Qp26glhxxHhczrtE27nDeCEz9I8a/aAL7QlnIlBeOCVjvusWTju8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=qwDekM2X; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7AA711C008E; Tue,  8 Jul 2025 22:37:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1752007053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FPbGDVquPjNFCdLnk3gjYikEVK1iQ5FM8B55Z2acikM=;
	b=qwDekM2XCgBC2riOL+ehBllLuBtozXQ9xCvJmUp/KvGErYDb1V3W1ZFBhrDQ7/TCM7TlSO
	i402zsDt6M2zI2p+vPCFkpfzEO7q7WIG5xfbRQfLQoRYxbWxYWVqvvWdkiOeMFlTVMrOsq
	Z8i9Nt3tw4TObWT5mSZRY+8O5X9PXPw=
Date: Tue, 8 Jul 2025 22:37:33 +0200
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
Message-ID: <aG2BjYoCUYUaLGsJ@duo.ucw.cz>
References: <20250708000215.793090-1-sashal@kernel.org>
 <20250708000215.793090-6-sashal@kernel.org>
 <87ms9esclp.fsf@email.froward.int.ebiederm.org>
 <aG2AcbhWmFwaHT6C@lappy>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nNCUwPYE9969vNp4"
Content-Disposition: inline
In-Reply-To: <aG2AcbhWmFwaHT6C@lappy>


--nNCUwPYE9969vNp4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2025-07-08 16:32:49, Sasha Levin wrote:
> On Tue, Jul 08, 2025 at 02:32:02PM -0500, Eric W. Biederman wrote:
> >=20
> > Wow!
> >=20
> > Sasha I think an impersonator has gotten into your account, and
> > is just making nonsense up.
>=20
> https://lore.kernel.org/all/aDXQaq-bq5BMMlce@lappy/
>=20
> > At best all of this appears to be an effort to get someone else to
> > do necessary thinking for you.  As my time for kernel work is very
> > limited I expect I will auto-nack any such future attempts to outsource
> > someone else's thinking on me.
>=20
> I've gone ahead and added you to the list of people who AUTOSEL will
> skip, so no need to worry about wasting your time here.

Can you read?

Your stupid robot is sending junk to the list. And you simply
blacklist people who complain? Resulting in more junk in autosel?

	  	     	       		    	      	 Pavel

--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--nNCUwPYE9969vNp4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaG2BjQAKCRAw5/Bqldv6
8uqrAJ9aR2BgDB5TDKwRlvnzo5jPapRSRQCgsgZWldJBSXfWXm/fdwX6FNodniY=
=gTnq
-----END PGP SIGNATURE-----

--nNCUwPYE9969vNp4--

