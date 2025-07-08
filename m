Return-Path: <linux-pm+bounces-30407-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD686AFD9D7
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 23:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0D071C27253
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 21:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDE2241CA2;
	Tue,  8 Jul 2025 21:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="Zv84NmEP"
X-Original-To: linux-pm@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1022472AC;
	Tue,  8 Jul 2025 21:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752009968; cv=none; b=O0D+ekT14/NCZ9HmRS6jytkYdWYPYhAkYJA4LuDpQpkgmjDqF3K16CrdBX9OjluHG6xm03pqngY7uIZbIAc0jhOXI+6YnIQ5G+tw5iQRfHVmazCM/nk6nff4jdv2CXkXeK8lEOO02uU0SjQT1xvTs0cQ455Blyje1gaGkR7tM/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752009968; c=relaxed/simple;
	bh=8P8IF4V93/LGE6cK9wIVDi+sh1sxcwgtfbhFn+IaGYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqLZ+E4yvKRHjEReJum5ynXmtguHxnMJBsSn/28EW8BPRwjw5XmeCsc5hb0huA3OnzKWOVtfcAhPv5UCBlFMgiJ/xII39xnYt6XGz89lFS+66yGgpS9U7QgBQAPRh5EUY0gNZom+lxKxFBfbDW2rg09q4Y705dSVC4kquZIcnUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=Zv84NmEP; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 05F791C008E; Tue,  8 Jul 2025 23:26:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1752009963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LD0jV/9ETPDQjueVoxO1J46hQbXvI3qr0F5qgo1rUzo=;
	b=Zv84NmEP5bfltdOq3XEN/eXdbg0FvJCc/LZpS56h+bEs8887Iv5R2048NDz8WLn8d78I4c
	Zc9O9iDl6jhYjOXACo1cXjl8Unddaqq2WY705WKskpHTxrgdnb8B7Pq85ir8bYGs61RkyA
	bHBSv6MtZlfCuDQOCj++FDbuah82SM0=
Date: Tue, 8 Jul 2025 23:26:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>, "Eric W. Biederman" <ebiederm@xmission.com>,
	patches@lists.linux.dev, stable@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Nat Wittstock <nat@fardog.io>, Lucian Langa <lucilanga@7pot.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	rafael@kernel.org, len.brown@intel.com, linux-pm@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the
 suspend sequence
Message-ID: <aG2M6rmyLqsub8/8@duo.ucw.cz>
References: <20250708000215.793090-1-sashal@kernel.org>
 <20250708000215.793090-6-sashal@kernel.org>
 <87ms9esclp.fsf@email.froward.int.ebiederm.org>
 <aG2AcbhWmFwaHT6C@lappy>
 <aG2BjYoCUYUaLGsJ@duo.ucw.cz>
 <20250708204607.GA5648@1wt.eu>
 <aG2JzsVKuBkFcXj9@lappy>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TYDyTl+a+81TEOKE"
Content-Disposition: inline
In-Reply-To: <aG2JzsVKuBkFcXj9@lappy>


--TYDyTl+a+81TEOKE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2025-07-08 17:12:46, Sasha Levin wrote:
> On Tue, Jul 08, 2025 at 10:46:07PM +0200, Willy Tarreau wrote:
> > On Tue, Jul 08, 2025 at 10:37:33PM +0200, Pavel Machek wrote:
> > > On Tue 2025-07-08 16:32:49, Sasha Levin wrote:
> > > > I've gone ahead and added you to the list of people who AUTOSEL will
> > > > skip, so no need to worry about wasting your time here.
> > >=20
> > > Can you read?
> > >=20
> > > Your stupid robot is sending junk to the list. And you simply
> > > blacklist people who complain? Resulting in more junk in autosel?
> >=20
> > No, he said autosel will now skip patches from you, not ignore your
> > complaint. So eventually only those who are fine with autosel's job
> > will have their patches selected and the other ones not. This will
> > result in less patches there.
>=20
> The only one on my blacklist here is Pavel.
>=20
> We have a list of folks who have requested that either their own or the
> subsystem they maintain would not be reviewed by AUTOSEL. I've added Eric=
's name
> to that list as he has indicated he's not interested in receiving these
> patches. It's not a blacklist (nor did I use the word blacklist).

Can you please clearly separate emails you wrote, from emails some
kind of LLM generate? Word "bot" in the From: would be enough.

Also, can you please clearly mark patches you checked, by
Signed-off-by: and distinguish them from patches only some kind of
halucinating autocomplete checked, perhaps, again, by the word "bot"
in the Signed-off-by: line?

Thank you.

Hopefully I'm taking to human this time.
								Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--TYDyTl+a+81TEOKE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaG2M6gAKCRAw5/Bqldv6
8uWXAJ9iwtaQ4B9BUZoI/jwJndhFnx3B5gCfY34DANR721Opp073dZHhyFfrv4E=
=dg3Q
-----END PGP SIGNATURE-----

--TYDyTl+a+81TEOKE--

