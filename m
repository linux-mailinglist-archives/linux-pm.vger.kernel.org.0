Return-Path: <linux-pm+bounces-19211-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E36D9F155F
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 20:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D31F3283FEC
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 19:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1951EC4F3;
	Fri, 13 Dec 2024 19:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="IiQJDRk9"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36031EB9F8;
	Fri, 13 Dec 2024 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734116432; cv=pass; b=KJOCJIZWxDRRVAYpYg67rRv5A33A/rnaP7QImCbifxbrG2/eMPfe+T464ZZPwuTgekS5V1lv0EIwjstjRY9JncyF+RzoiCbQ8HAe5NwVK2SdE/1ngoSgC0vBmi9rUUonnVrLEkFrnFMoATM7do5Po6yS3rP9jB/d3sa3FhvUPE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734116432; c=relaxed/simple;
	bh=2QLIMmXwq0PC90DcHTuI1EJV9YDPCuFvlKGVyMw45Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HglxtzScNigufTsimmNO5UTMwyvhXBs4FQgkoUO0I3G0b2JkYv+6T5TN5VkPkOa7QUYalJCy4L1wshT8rxvmakkgaXdTBMxeZGvdQaSw6uvvQcorvPsH9GCb1xXKDpy05oT4cHaJp9UI2YzLbshqBqvjcRqg4LkNKxloFqxS0AU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=IiQJDRk9; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1734116412; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MFblYMimd0gGPr2HXq9BRBOoZP7EfNJ6KiDCC2SX0s/nPI1wQTXGWD1g/AUoV++6bFO9sZUnOqQqKAnmhInQVFHqWV02QBu9W5yfpTJPArsGT17NokaFuPhDCkQBd+wDd/OhMfDwZAu4xPtwNd2s0jtKIGyLs7ijMa+NLK1fCek=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1734116412; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2fQYeZnIEuXaZlLvcxerDjDSXLZNHqNtUkzd6tb+dXs=; 
	b=LOnNDThME+fROHYnLlRRDIka09DYS+3/PBidnNXLwpoOA2uHwPu2epbqqu8xrwCuplrO/3IlKH2BdvGCzNvtCtDNRfpadKlQZA4DXrRlxyYp1xcJFdDaWW6tnPu6ZGPggZTooqodOfkFHEh1bIp+pGAcRc+oLUi+UtmwvdiY/Ws=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1734116412;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=2fQYeZnIEuXaZlLvcxerDjDSXLZNHqNtUkzd6tb+dXs=;
	b=IiQJDRk9R7OM5mhE4R2KulWaxHilo2bKAn2doQGiVR6h2JhFlfXoDkrDgpg0a/SL
	zrHB8eKRxw6njrlAGMeo3UPDHSiQf9OsXP70LNiLa/ZWycyE8xumgJ91y9hIUqCGeip
	1aSnAYe85B65ROzLa8S777tmTZOA1iMMFOYaX5vM=
Received: by mx.zohomail.com with SMTPS id 1734116409928313.33760806040016;
	Fri, 13 Dec 2024 11:00:09 -0800 (PST)
Received: by mercury (Postfix, from userid 1000)
	id D7B2610604D3; Fri, 13 Dec 2024 20:00:04 +0100 (CET)
Date: Fri, 13 Dec 2024 20:00:04 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
Cc: christophe.jaillet@wanadoo.fr, 
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/2] power: supply: Add STC3117 fuel gauge unit driver
Message-ID: <45rho3eswmyqf2ufnbzfbogftqhm7xxe5ylfvs3a4yvu3hrdhi@ljwxpgzzvkge>
References: <20241213063813.32371-1-bhavin.sharma@siliconsignals.io>
 <20241213063813.32371-3-bhavin.sharma@siliconsignals.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d52vomtdu3j4esp6"
Content-Disposition: inline
In-Reply-To: <20241213063813.32371-3-bhavin.sharma@siliconsignals.io>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/233.960.20
X-ZohoMailClient: External


--d52vomtdu3j4esp6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v9 2/2] power: supply: Add STC3117 fuel gauge unit driver
MIME-Version: 1.0

Hi,

Thanks for including the test output. Looks like everything is
returned with the correct units now :)

On Fri, Dec 13, 2024 at 12:08:10PM +0530, Bhavin Sharma wrote:
> Adds initial support for the STC3117 fuel gauge.
>=20
> The driver provides functionality to monitor key parameters including:
> - Voltage
> - Current
> - State of Charge (SOC)
> - Temperature
> - Status
>=20
> Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
> Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
> ---

You probably want to document Co-authorship? In that case you should
also add

Co-developed-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>

in addition to the Signed-off-by. See Documentation/process/submitting-patc=
hes.rst
for details.

> [...]
> +#define INVALID_TEMPERATURE		250
> [...]
> +	/* INIT state, wait for batt_current & temperature value available: */
> +	if (ram_data.reg.state =3D=3D STC3117_INIT && count_m > 4) {
> +		data->avg_voltage =3D data->voltage;
> +		data->avg_current =3D data->batt_current;
> +		ram_data.reg.state =3D STC3117_RUNNING;
> +	}
> +
> +	if (ram_data.reg.state !=3D STC3117_RUNNING) {
> +		data->batt_current =3D 0;
> +		data->temp =3D INVALID_TEMPERATURE;

Please don't return arbitrary values when there is no data
available. We have error codes for this. I suppose in your case
-ENODATA makes most sense.

> +	} else {
> +		if (data->voltage < APP_CUTOFF_VOLTAGE)
> +			data->soc =3D 0;
> +
> +		if (mode & STC3117_VMODE) {
> +			data->avg_current =3D 0;
> +			data->batt_current =3D 0;
> +		}
> +	}
> [...]

Otherwise looks good to me.

Thanks,

-- Sebastian

--d52vomtdu3j4esp6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmdchCkACgkQ2O7X88g7
+pqsqw/+N1Z6Xi+hiucuvTQmAmfWE2R/Y51VSSmXoKd5uQvZnFCRrsQeROUnpNGe
4pUqHi+bACY9+vMBHYk5pSKLrfbrYg9BGoF+KevwL+XHCgA7KHZNwrZCAEpAZRJV
rL0yOA4eP6UHcdSq24+3zZ0fKZQt0Zh6N9/nG9HTIFB+W14cKxpDyy1Y1is16EIs
7d6PYBlTF3pdi5f2ccmpkaoDUEn80rcOEvJXyLzr9BCn6nm5MW6ZYBO/Qw6Ujgs5
uib+cqYt+Lb7caO350C3e5+LjAuez/iRYoYpjbrPKmn516eIJhnPo/+qyiu+aJEV
pemKQ03TO5AAfawXzd7smRfKfpuL7jh1AM4tYuhu2OjFfTKLrohkByxIlPMx6v6z
FceDLesbXeVmT+PTDcuUrYWpWaVI0tAbIzub+EdneWpewox9CaRfg5RzyXJEmxCL
h4+fliRW6t2aav16KhaYbYfsg5fwQJ76B471bswQtlJCx8W+r7fvfzVJQBUD6Abs
VCKbgJP3EDVv/xCESnNJRao9D7p0IWuBF2SS4Iav8+nsXjujv9iguN+5pD+DKSl+
WFw13/TGWm8faWyl3KINsBiNpXFCBNKa/vXvsICerLrWn/pxaTAv+TnxMrgFy776
Frc8SyfvTk9/lbOpDv2CyOC27J2trErWGxyPNbtWW4jk/ebcJSk=
=LtuL
-----END PGP SIGNATURE-----

--d52vomtdu3j4esp6--

