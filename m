Return-Path: <linux-pm+bounces-30401-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF23CAFD886
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 22:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9AA58606F
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 20:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC89C14A60D;
	Tue,  8 Jul 2025 20:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="RCtuY5pt"
X-Original-To: linux-pm@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B182192F9;
	Tue,  8 Jul 2025 20:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752007135; cv=none; b=syqBPuPmrTyUM8QAVKe7NBxgNm8xWv7veTs+vA5M6ArwnewttPwMA8f3l/kz2qaoUnCrcNAuV+8oQlbFWcfJzUiUFBZF2J31cT5Tg3V4k6IiN4HkDUO0SyVe1qdWxX7RcqAYjrPel1qaAWif/64NdQfyIsAg1MUoqUi2PW9sKGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752007135; c=relaxed/simple;
	bh=U8unJv4Tf7k5cCC/fetgdZKkMvT8rvcfxo+tnHc78ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+tkTPCyQcTu7Y2ThkgLcx8/E5oJMN7sJC2uhtU5YBkbHbYQlLrPA7JUpV69U2QOKAMzDZBoSP//H61gZLlZrae2kYHiDcmF6gD/gXYml9fEjsGhyLRxezXPurB3xq0DsYfyacmVjqcIO0JXg8NJ29B5yxIg/TPHt7IdB200dLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=RCtuY5pt; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7AFFF1C008E; Tue,  8 Jul 2025 22:38:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1752007132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eo6RLYnfDwilrvMsNkS6FuRCCx3qPpmVDAwaxfXrbHM=;
	b=RCtuY5pt6EofRPXHAagFGKHELeg6upWbmkojqAswlpCA9UP4sIMf3oc9I5ssIKPXGsMV15
	2VoLCpFlAejpZzresIVvMAWAZV5rdQ3Q3jKsyaAKBwguMyEeaPo8ZMwwOEZC0+4Ba9Hxop
	JfSmbBao6709cOZnUikFu40vKL6ST20=
Date: Tue, 8 Jul 2025 22:38:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Sasha Levin <sashal@kernel.org>, patches@lists.linux.dev,
	stable@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Nat Wittstock <nat@fardog.io>, Lucian Langa <lucilanga@7pot.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	rafael@kernel.org, len.brown@intel.com, linux-pm@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the
 suspend sequence
Message-ID: <aG2B3PvCNmI51bqI@duo.ucw.cz>
References: <20250708000215.793090-1-sashal@kernel.org>
 <20250708000215.793090-6-sashal@kernel.org>
 <87ms9esclp.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AJONLeuTvitsawye"
Content-Disposition: inline
In-Reply-To: <87ms9esclp.fsf@email.froward.int.ebiederm.org>


--AJONLeuTvitsawye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
>=20
> Sasha I think an impersonator has gotten into your account, and
> is just making nonsense up.
>=20
> At first glance this reads like an impassioned plea to backport this
> change, from someone who has actually dealt with it.
>=20
> Unfortunately reading the justification in detail is an exercise
> in reading falsehoods.
>=20
> If this does not come from an impersonator then:
> - If this comes from a human being, I recommend you have a talk with
>   them.
> - If this comes from a machine I recommend you take it out of commission
>   and rework it.
>=20
> At best all of this appears to be an effort to get someone else to
> do necessary thinking for you.  As my time for kernel work is very
> limited I expect I will auto-nack any such future attempts to outsource
> someone else's thinking on me.

I'm glad I'm not the only one who finds "lets use LLM to try to waste
other people's time" insulting :-(.
								Pavel
							=09
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--AJONLeuTvitsawye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaG2B3AAKCRAw5/Bqldv6
8jHUAKCBRM9dpSXf/a3kW2TLJphvmrhL2ACffbxa0/7En8c+6ZvpDgJvwb2nW78=
=gVSQ
-----END PGP SIGNATURE-----

--AJONLeuTvitsawye--

