Return-Path: <linux-pm+bounces-30402-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EF9AFD897
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 22:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 288223AA668
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 20:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8AD221546;
	Tue,  8 Jul 2025 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="RX7Jeon8"
X-Original-To: linux-pm@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8482921C184;
	Tue,  8 Jul 2025 20:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752007321; cv=none; b=hNU9Hl0iN14Jj1oS8tff3DY7YwPyevat1ysNG0gFq4vbKjQ1DGQ6ISooGr9v66W2fJKg+fv7391cI8Zgu2APoUuFFtmgJ+I+P5uWLsf5So30GnmPVGKwdQKDAixJp0p8vzCGWZqzMEwox75fFOqGqvP15o75/gL7naW6xoMXGiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752007321; c=relaxed/simple;
	bh=YBrwH5NazNEuTadfM0TLyXTHBwYFWCZ/Ysm1nG+bh+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciy6C1mA/5uH9IokBl67Mx7znanv2DC591/4cc7S4c+CE58UqhEPuPYjJWmiMXvHmtd9WIqQMQpsf5nzu19UlvjsoQm4q9/wtH+sG+vpMO7kWXJAlATMxGGgKeUwWMqVIwTtpWxILXj5efh5vBm4aILxoVFZGNGROJvwv8uMYvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=RX7Jeon8; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id CD9461C008E; Tue,  8 Jul 2025 22:41:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1752007317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cZhTr8BNsb/IuarKIUCHdKLZrZHK9BdGzp5OHwK+lhU=;
	b=RX7Jeon8wS2ySxsAnXhakzhF4H3VSMWaw2X6XumJhMHs5hLCtDfHE/FGnpDqRkxP3rlcIO
	Ood3GWLZu+1jQtnixserm+7FLHxEdRvWRKon8HEn1RqE7HnvuZEHRHoeutXkb7244c9VDx
	//T5r7vYBnWF/LsuR0a0LuGGlT0NU/0=
Date: Tue, 8 Jul 2025 22:41:57 +0200
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
Message-ID: <aG2ClcspT5ESNPGk@duo.ucw.cz>
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
	protocol="application/pgp-signature"; boundary="FIQQfs2YSIsZNrSH"
Content-Disposition: inline
In-Reply-To: <aG2AcbhWmFwaHT6C@lappy>


--FIQQfs2YSIsZNrSH
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

Do you have half a brain, or is it LLM talking again?

You are sending autogenerated junk and signing it with your
name. That's not okay. You are putting Signed-off on patches you have
not checked. That's not okay, either.

Stop it.
								Pavel

--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--FIQQfs2YSIsZNrSH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaG2ClQAKCRAw5/Bqldv6
8oVqAJ0R4LSUicsx/XcVgjLO2Is7LGBfcgCgnqYVuoQFYklyJ2fQpX6V5XYDkZ4=
=0ktO
-----END PGP SIGNATURE-----

--FIQQfs2YSIsZNrSH--

