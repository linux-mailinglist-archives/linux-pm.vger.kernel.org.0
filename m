Return-Path: <linux-pm+bounces-4813-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC65877739
	for <lists+linux-pm@lfdr.de>; Sun, 10 Mar 2024 14:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02BEC281554
	for <lists+linux-pm@lfdr.de>; Sun, 10 Mar 2024 13:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C1D2C6B2;
	Sun, 10 Mar 2024 13:59:52 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C532D603
	for <linux-pm@vger.kernel.org>; Sun, 10 Mar 2024 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710079192; cv=none; b=oSvFGkrLdQMT0DytJ77Lzq/U0v2jGd44SBTOyNuW2V+h+x6biRKBf9A39dgYzBSmh3UIks3+6CSgHuIPFXKQsKzm04dHJW81P14ALievLfl+ULOTMwRO3WVC/iwAVmk9e1S6vfz7PjPkgUanfDfheoD+YHyovs16iMkvfbfad/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710079192; c=relaxed/simple;
	bh=5QrhwKFauKk0UJ+Wz45JfVbnJ/jrOB5yH8y6rnpGMWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmr0YiChYpU37tHuo/6kP8/lpXdVtnzhnRUp3u0yK1RULCVM0zDdJvjSyP7ZdoD96wsceCBsQvPLXOzqzL0kxhM7eVTVRcukUClAJeXGM6zbR+ZI9B5ORW94hGbVFYqGDC1S4w+dyY2bUXabdtPTyqx0HgEtx7JZ2H4tKFeIfYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjJiK-0004Tw-VL; Sun, 10 Mar 2024 14:59:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjJiK-005Wsk-6l; Sun, 10 Mar 2024 14:59:44 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjJiK-003Sbf-0P;
	Sun, 10 Mar 2024 14:59:44 +0100
Date: Sun, 10 Mar 2024 14:59:43 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "rafael@kernel.org" <rafael@kernel.org>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] powercap: intel_rapl: Convert to platform remove
 callback returning void
Message-ID: <q4sturvyzq6fgy7juycu3tcd4rym6zeyx66jvfy7rtlmdyr5bw@7bvefe24phkr>
References: <98afe4627bcfbddedfa36fb5631bb47913f5fa94.1709886922.git.u.kleine-koenig@pengutronix.de>
 <82b55fc7b94fe96e41e3b907a72c85523f15e745.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n2mf57mr7e4to3c6"
Content-Disposition: inline
In-Reply-To: <82b55fc7b94fe96e41e3b907a72c85523f15e745.camel@intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org


--n2mf57mr7e4to3c6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Mar 10, 2024 at 01:16:03PM +0000, Zhang, Rui wrote:
> On Fri, 2024-03-08 at 09:51 +0100, Uwe Kleine-K=F6nig wrote:
> > base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
>=20
> This "base-commit" is not an upstream commit, which makes it more
> confusing.

FTR, 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd =3D next-20240308.
You're the first to claim having troubles with using next as base in my
career so far.

> Seems that the base support is added by commit 5c5a7680e67b ("platform:
> Provide a remove callback that returns no value"). IMO, it would be
> better to refer that in the changelog. But anyway, the patch LGTM.

Yeah, ok. I normally mention this commit in the cover letter if there
are several drivers to convert in a subsystem.

Given that 5c5a7680e67b is contained in v6.3-rc1 I'd expect that there
is no need to explicitly point it out as a dependency.

> Reviewed-by: Zhang Rui <rui.zhang@intel.com>

Thanks

Best regards,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--n2mf57mr7e4to3c6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXtvM8ACgkQj4D7WH0S
/k65/wf/ZqWL2m0Vf4gN2ZAJkzJW9FWxDHi6Ue7KIJ+kiO4BaHNTD7+NFgSGlh7b
mVymgMkudXgV+/TbC6j96xKzqc73gVQVkXSeDADA9XMEa90femaMFpk8k9WCHhJI
ljayZdXMEjexaSpifUUa4t+GEhhVAvqgjCgt+Q1IwYkf/cCr8Gd2lRXG8a1Hpp9Q
BHENe7uR9IWdaF6hIZmwv0099NzEyFfRXKku4bxVCWj63B01ZiyobckadU+0Q+4W
/3K4rsLZfsCKdVNV8rbuEL7duuW2BoBSAK/VchRQagqpiZd0KcJUT8CAzbUV7FEz
QVEIsLfGStX/3ld94OwJXm3yUW/MRg==
=iRPi
-----END PGP SIGNATURE-----

--n2mf57mr7e4to3c6--

