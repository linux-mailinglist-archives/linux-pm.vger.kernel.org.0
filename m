Return-Path: <linux-pm+bounces-24071-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE18A61D44
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 21:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11CE619C14E9
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 20:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8121A4B69;
	Fri, 14 Mar 2025 20:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="hm5D51on"
X-Original-To: linux-pm@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5122A18E756;
	Fri, 14 Mar 2025 20:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741985660; cv=none; b=ogB9Bs+M+XLGjsojBbvsfeLB+wm+p8sVBcsn3q6RFDt+/Jwj6wznFtsEDR8g3p4/1MVvm0qAnrKKgof9ixmIqskFckPt0CWy00kNLNIa1a6OQ3pzdWXqwTnFu+H8WLw5SN10pHG6c+ZAvy8w3++2p/0vilzUr+96yGMLQ0pGTnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741985660; c=relaxed/simple;
	bh=PjJZmTos+gOnXtRO1H2qb1M94GtSCP7HJkxn3jLo16k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4GOi+iLUnFTKI+VtVJaiF0dnzxYKRQJ8epJM5vDOwBQZQwu2FOf19VwqEad09fByfqteW/zOg0SAqb7gymEy3bx8qE5qdqiuuy+4bFSyFFHRDwM5the4kwxSrnK3mZMZbG/KpLmfTLxPLBk/DpfJ0p4aqx/4f6LKu5APM6aAuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=hm5D51on; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 746ED1C00B2; Fri, 14 Mar 2025 21:47:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1741985254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5GvRBr53B+OFzVgoUGb1tUNeK0A4mG9GxZ+cA93GAzc=;
	b=hm5D51ontEP8nAAmoP48110PL9POmQhaXNQ4MJAhNrIRivswoEmEYggO7f7WDNdAzFqH1w
	f1ur0UGMlcU1f2D5x2kg0IztkwfUxsdk/kxozKG1aI9c0ajHZ41pQPcWCnbMnpLv02it4B
	HeEckCxqNtiMlk6FQbkwGz9QyKXmPKc=
Date: Fri, 14 Mar 2025 21:47:33 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Saravana Kannan <saravanak@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Marek Vasut <marex@denx.de>, Bird@google.com,
	Tim <Tim.Bird@sony.com>, kernel-team@android.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/5] PM: sleep: Fix runtime PM issue in dpm_resume()
Message-ID: <Z9SV5UymVcuUkSE1@duo.ucw.cz>
References: <20241114220921.2529905-1-saravanak@google.com>
 <20241114220921.2529905-2-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ta7N6fkXw1LCADOj"
Content-Disposition: inline
In-Reply-To: <20241114220921.2529905-2-saravanak@google.com>


--ta7N6fkXw1LCADOj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Some devices might have their is_suspended flag set to false. In these
> cases, dpm_resume() should skip doing anything for those devices.
> However, runtime PM enable and a few others steps are done before
> checking for this flag. Fix it so that we do things in the right order.
>=20
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/power/main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 4a67e83300e1..86e51b9fefab 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -913,6 +913,9 @@ static void device_resume(struct device *dev, pm_mess=
age_t state, bool async)
>  	if (dev->power.syscore)
>  		goto Complete;
> =20
> +	if (!dev->power.is_suspended)
> +		goto Unlock;
> +

This needs to be goto Complete, right?
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--ta7N6fkXw1LCADOj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ9SV5QAKCRAw5/Bqldv6
8pFrAJ0d28+EzZhlI0lLuTyC9PJBmiDECQCgjPZ5quzU+M7vOn4F5mHwDlVR62I=
=meXA
-----END PGP SIGNATURE-----

--ta7N6fkXw1LCADOj--

