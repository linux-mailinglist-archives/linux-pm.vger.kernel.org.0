Return-Path: <linux-pm+bounces-19470-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EE29F7136
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 01:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3E516A266
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 00:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2CF2111;
	Thu, 19 Dec 2024 00:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="eixYD3Bz"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E0E17C;
	Thu, 19 Dec 2024 00:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734566932; cv=pass; b=gW5RgBUbfTDgl6NmP6tL7iHazlbpQupvqN2gv90UP0/M43PE+l0L8DZ1xTEI4l+4sb6nTebc60CpGpknRI2cL8qFz9y9zNkSBpZzeWhalY9CG5StWGlulB/PgXrAnrno0NH0veqPBJYnoglX21cav1cIZiEwpWD5Hxa+B6tnadE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734566932; c=relaxed/simple;
	bh=jXjbqko9OSyBjWLYePsumVTdVcFZJItK57zWbzlK3/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rD7rzIgxP5cqojxZGzu3n7gNebDGUsyMgjPJv0wivvKMvMr9Oyk2A+ztXCpJCyKGjLv0u/0/2U4tsSzCNxwmleHDkjz7JnhXL6xc2ncWzk671K1WgFR9qh8jG6SI9xL5UnUAw/zcYxdoYanZIQkBTqSBBgagU3esgBEX/ZO38RQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=eixYD3Bz; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1734566921; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GUBu8WSoYMXYGTbu5Aw4fugpGEQCs1MUQqGhXsSTgmxgV/1vv8bP2yrCuqaDfq2Fp830NLEZLVVM/Ct3Bc7EJK8qkkhL9J18dNFp1v8UbyWolY6J0pdAsD9a4lUrV68y3hHY2k7NPqc8ulsFOKPvk/veoTXM9UkTdvJ35Ld9WGM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1734566921; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JmSGRbNtiPqFcWvjc0q/ZDfiO1lSzxzab67tDU4HJn8=; 
	b=kaSwGL3xyJh84ZKrJZdPC3qodsSrW/NjKbYl7AMJ24/IcckcACCeX7KbuvYGm4o+b44B/WOWk+mWLqoOGlTz3+6c4lnWiB+NGI2T/rdAWJn+xTIL8BvLPpYOK6Fl01C4zZXjqc6dds6iJQr4zGMMTmOqk4kFBqG9+xTXPWqw+OY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1734566921;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=JmSGRbNtiPqFcWvjc0q/ZDfiO1lSzxzab67tDU4HJn8=;
	b=eixYD3BzKoy326QmU9ApdLDGuH0Pj9N67Ma7oerVz5HXPB8be2PmWMB48+iOOhX0
	8z08GiFQb37P8lI23Cy4BXY/EqylIRLl+0DKru5St+/obhfiIHwykXuLQbpWqwiPxFU
	uZ4O8IEa5oxT5+hRG47QXN2iMIEeQ1gJW0n18wlg=
Received: by mx.zohomail.com with SMTPS id 1734566920018925.8243420274822;
	Wed, 18 Dec 2024 16:08:40 -0800 (PST)
Received: by mercury (Postfix, from userid 1000)
	id 6C70E1060345; Thu, 19 Dec 2024 01:08:35 +0100 (CET)
Date: Thu, 19 Dec 2024 01:08:35 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: "Sicelo A. Mhlongo" <absicsz@gmail.com>
Cc: linux-pm@vger.kernel.org, pali@kernel.org, 
	linux-kernel@vger.kernel.org, maemo-leste@lists.dyne.org, 
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH 1/2] power: supply: bq2415x_charger: Immediately queue
 delayed work on supply change events
Message-ID: <ge6ejhaogzcu3q2d2ijxifxuh7i2fsbviqwvh7pxcqt3acl7nj@uorjb3rnwi5v>
References: <20241128085759.11840-1-absicsz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kns4qiumm6chl2zf"
Content-Disposition: inline
In-Reply-To: <20241128085759.11840-1-absicsz@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/234.432.72
X-ZohoMailClient: External


--kns4qiumm6chl2zf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] power: supply: bq2415x_charger: Immediately queue
 delayed work on supply change events
MIME-Version: 1.0

Hi,

On Thu, Nov 28, 2024 at 10:57:27AM +0200, Sicelo A. Mhlongo wrote:
> bq2415x_notifier_call is called asynchronously, when a change is notified
> from the external notify device. Therefore, reschedule the work item to
> run as soon as possible thereafter.
>=20
> Suggested-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
> ---

The commit message reads quite weird, but the code change makes
sense to me. I think something like this commit message makes
more sense:


When the notifier is called we want to schedule the worker as
soon as possible. Thus it makes sense to reschedule any waiting
work and only queue a new one if there is none.


Greetings,

-- Sebastian

>  drivers/power/supply/bq2415x_charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/bq2415x_charger.c b/drivers/power/suppl=
y/bq2415x_charger.c
> index 25e28dac900d..1a02195769a3 100644
> --- a/drivers/power/supply/bq2415x_charger.c
> +++ b/drivers/power/supply/bq2415x_charger.c
> @@ -839,7 +839,7 @@ static int bq2415x_notifier_call(struct notifier_bloc=
k *nb,
>  	if (bq->automode < 1)
>  		return NOTIFY_OK;
> =20
> -	schedule_delayed_work(&bq->work, 0);
> +	mod_delayed_work(system_wq, &bq->work, 0);
> =20
>  	return NOTIFY_OK;
>  }
> --=20
> 2.45.2
>=20
>=20

--kns4qiumm6chl2zf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmdjY/gACgkQ2O7X88g7
+pqOtQ/+LhaiPhxcc1+zNLz1rr0OdnvnhpjDg8eSe7oFDqviKk1F0VoMH5YGsxXU
zxxCFyQJE1YVQpdpjlOOoTgZvQA+uswKGFnF6zoz1rJ/kCoLfS51cCyrhnaUxRLh
OsnHs4uW8vR/t2nBtE2U1d3+jP58q+cn3W0XBTm9XVozy1c2fJqxqCTtjkYceFh8
JWadMF/o41cnb8opd4RGsDL8tx7Py/CTMVoifwEvwFKotQn5D6RK8gIEjHB56mqk
wfY45JHkv4x9im5pGWlscKjjbOIDcd0v/PaAXZj/6lCZ1tCjni9bfAXSO+AkMZAT
fN8N9xfR3eUBVbWKqtsXn261RoJpCFGm2yW6x/ztm3YazwbsB6alulcjzsM9mhyH
KBxfKtBfhjXHRUwBsOrNKbiTQS+NV0yFRbGrR2kE5WyhzTtFpkz70ep7DhT9teA1
d8LMa2CFOLUDVrLX8DXsexTCMWpyjPH+5kSVDS/MwitChpnj2btlnluxWO0+wkNL
B71S4J56bRCRTf5d181IRp3BQUS2o+LQghj7jagIiI89iSJ8L1RypY6tjjIm+Ijp
GJ8D/oAP+GUJDmsaLa1OwBZ0N2Tv0wy/Ql9Iq/rp1i7Kh9oqf7BLLXASc2sJzVGg
TQWRtoiShuPockQjjCW+CU7P0URpIbFmLDBpMJvwOxd75K4JUjY=
=bZDO
-----END PGP SIGNATURE-----

--kns4qiumm6chl2zf--

