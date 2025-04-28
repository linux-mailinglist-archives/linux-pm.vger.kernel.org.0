Return-Path: <linux-pm+bounces-26336-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6CBA9FDBF
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 01:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295105A6B1E
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 23:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAEC212F94;
	Mon, 28 Apr 2025 23:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="dDJXJJjE"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender3-op-o12.zoho.com (sender3-op-o12.zoho.com [136.143.184.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC811DED48;
	Mon, 28 Apr 2025 23:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745883033; cv=pass; b=CkuGkWgatyfzff10RIpCFkrTzqUk12k32pv9saIH7NGk608czVN81DYtawRU5YD3d81p51Gs104al+U5aVb1Dp1oeqUmVG8A8YLTLbs129SfaSmxkYAUrw9ryUhQQx9yWwzgw7FxR0CcrP1TH/ljn+ZmcDBp0ugvxvJ9FfECsLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745883033; c=relaxed/simple;
	bh=O6TPStm2nOrcDnu+w5Rr+t19zLQeRzy7IwA1STuIHV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUGfYbZPFSWz3Gk6z6tEmCN61vVLX+brJXh7UVMx0/dOQCwJI0rWWtefoQMiyotMbXl4Ra73e5je7HEYMD0ocsxh2Dv2OE99BuX1wyACm1TjfQWx8Ngu00ALJRxnqDEnufGAwcHzaBqEzTeUemtiRRmM/8ySbeG7Z7VwDmhTJeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=dDJXJJjE; arc=pass smtp.client-ip=136.143.184.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1745883021; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QMefSWqrz0WMRpteB/neO3plLuQLnh/7XM/16MzNmK7VnLPiFJDwHL2S0GiBCA1YT11QB/7xNkfNLFlMT9IZKYCrPalxjDFBwpinES8Sc9u9jJfCdtgJ3qgTsVutTGKRACDWXizOCyvI8DrhIrDNXbOKfOVt2/bwByQE4fM1dNM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745883021; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6N8N+l9aBoxIQo5ns2ycjJui7zLY02fuI8jJd3GzBBw=; 
	b=XPmrlYVLDBf0eKhTQfhlof6Awcbpz0xzmkiqYaELxMD3HeW7q1YjrdpP96d4v2IbUPNVqy58AbfEt1x8IsQ55BDbn1gIHuQBoz84an5DRjNF7wVU9bVhMX9s2yiD0p3Aj/ylbHtsmezjU4pCYOzXjXkGMYEWN4pmzFK1wCPCb88=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745883021;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=6N8N+l9aBoxIQo5ns2ycjJui7zLY02fuI8jJd3GzBBw=;
	b=dDJXJJjE7OI1459iHRWwcygIOctA42joWb66KoMAOv1MPWURwetZgCGWxWRitaco
	qEgtt6SC9oinGyWNjYXSr8WWvfV6caRz/DFlNmk61aAHceAPoTaozXYsXyZMe664SCk
	QTxBOqnbFYpAfctOcLDngTQAgrOgJado6hBLj7fk=
Received: by mx.zohomail.com with SMTPS id 17458830184651020.0428225871558;
	Mon, 28 Apr 2025 16:30:18 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 16D6A1806F3; Tue, 29 Apr 2025 01:30:16 +0200 (CEST)
Date: Tue, 29 Apr 2025 01:30:16 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Dzmitry Sankouski <dsankouski@gmail.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH 0/2] power: supply: max77705: Fix two static
 checker issues
Message-ID: <x73k5kkoforly65u7dfdbpqi2miutdierhyta5i2x6l4akijsd@fnxxjjm7m466>
References: <94f55158-1776-4f2f-9296-e307e83d569a@stanley.mountain>
 <174587872324.18440.10820410998197235199.b4-ty@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hhdr2cjoqcsxpcyb"
Content-Disposition: inline
In-Reply-To: <174587872324.18440.10820410998197235199.b4-ty@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/245.863.17
X-ZohoMailClient: External


--hhdr2cjoqcsxpcyb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: (subset) [PATCH 0/2] power: supply: max77705: Fix two static
 checker issues
MIME-Version: 1.0

Hi,

On Tue, Apr 29, 2025 at 12:18:43AM +0200, Sebastian Reichel wrote:
> On Fri, 21 Mar 2025 17:34:00 +0300, Dan Carpenter wrote:
> > Fix some error handling and an error code bug.
> >=20
> > Dan Carpenter (2):
> >   power: supply: max77705: Fix workqueue error handling in probe
> >   power: supply: max77705: Fix error code in max77705_get_health()
> >=20
> > drivers/power/supply/max77705_charger.c | 22 +++++++++++++++-------
> >  1 file changed, 15 insertions(+), 7 deletions(-)
> >=20
> > [...]
>=20
> Applied, thanks!
>=20
> [1/2] power: supply: max77705: Fix workqueue error handling in probe
>       commit: 11741b8e382d34b13277497ab91123d8b0b5c2db

I've queued it, since it improves the driver. But the workqueue also
needs to be released when the module is removed. So I think the
destroy_workqueue() should happen via devm_add_action_or_reset()
instead of what this patch is doing.

Greetings,

-- Sebastian

--hhdr2cjoqcsxpcyb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmgQD4cACgkQ2O7X88g7
+proUA/7BYpCQZd2y0qsMbueYVIhaAHCQ4SNhO1y901Qgjb2a3jkwXPMlm9VDVpk
eC9W/IJzSM0pMnorPYmTBf8Z/94xGH7VPYB54XVzgzVR8ChlphDW7DFjGTcwl79I
o5DyFIOHxFFKVgvxY/MRiS2I6RMDlw63IKHpTs3YiNTFQavCh3XEPOPMsYDI+G/o
Hh9bFQDEqKVvO0fw53zM8jRBcV93Tf18cKa0mpW62CQUOBe+9E8LxbmmMNuZ40pG
p9veUkvA/2MTF5nlt4hQOGLws3FaF3GsTKRULEbjZpPugXNk5ER8mLRqFXBY2W9x
idJWJneaKhVPGj9VSbugzpfpsvnvYJPLtDaNPhRZI1+WkQG2KQS5mHjE/b12PCrp
Ka6iZAWaBSaNTorcUtP6ITooMLIoe4pS1RpQLlVdp13Gq5bE8vtl5nLdWIObd6lZ
VMi0kA33FRvCTWyd4S9fkW9izL/Od0IBMf66tPQnfmMNvH8s6NTVLyMncW2VQf5Y
233tryPifwKqwuDn6SAqe2M7Gc+go0o7xQDPFOIDY1j7WNAm+pDFC3SUqTvvo2pL
E2zrVS8tY5wqmPsA6qN7qdLpbAEf0AQqTCT0wtz3Rg21uMGj8r0AJVRs76ndWgdJ
Em4wnFteblTPKR2MvK2ARrgdenuUlCW0zDm8eJjYzKBGR+0q6go=
=qaI9
-----END PGP SIGNATURE-----

--hhdr2cjoqcsxpcyb--

