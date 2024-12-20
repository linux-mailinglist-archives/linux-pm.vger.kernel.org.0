Return-Path: <linux-pm+bounces-19553-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B130C9F88D0
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 01:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABE271897D7E
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 00:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A345FEC4;
	Fri, 20 Dec 2024 00:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="aOIGtHwo"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6041800;
	Fri, 20 Dec 2024 00:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734653280; cv=pass; b=pyRTEVza14W9SK3mwp6YR4nDj9pGOTJovY9f8I4ZqUb0EJC9+OCdQoNvW3U/7/PeL4PSFUXA0AgkLV+3dniL+7AVb9zWF+7kjnAbJUmWoS0C+cg/GHBEON/kXwWNA6J0+7C8fU9nm2wGmUSmeCUh27lWfFzI4gZ7Ty4p7hLo6oE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734653280; c=relaxed/simple;
	bh=9dhIIHfHcYh5bMd4tpuDoOfufCYlDhgPCe3PPEm1iWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uvl64re1iE6u+ZSxspW+z7T/5J/tzH8/hVwp8RCXDHZj2FbCTAS4DFIxXbQd2u4vkJH33jDplxZBdoMJNHEHUqB2KMu+yhhugy4UVC6nYbFQSt935mOIAiT6u2kf+1ZirYs2HlKAMimxumfBGuiFYrhajQe7U4WDytQPfWbCO1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=aOIGtHwo; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1734653264; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eBXA4uIIkksfy/NdKNMhYjHqWnhKKb0abGD3Q3EZ065tcIR+d0n28rXI1GVSR2vbpzibXApAVioVfCLlhfMBoz1lZ4gIGwJ7ak/xjFRAbocC+HrsYqLyKmgVMXUgidsw1HvP7cmo8I4fCLCO4/ffWjkufnyoJYVlNex1LIL9L+M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1734653264; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9dhIIHfHcYh5bMd4tpuDoOfufCYlDhgPCe3PPEm1iWg=; 
	b=cJ83atTrycUICt3fp64DqmgsG42uNtUz0VQ1iMNmwZ+00wSEMmpaDSayKa9icpaC3uGgvsPhc0zlFhj5EnysKfa/SZq/vyfIRyxd/jMovt+ukhGt8LaCCgC6hfxQk/YjyLh5omGoPXT6y7DsPFP1f2qL/0WSUqCDRcn8wNhelvc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1734653264;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=9dhIIHfHcYh5bMd4tpuDoOfufCYlDhgPCe3PPEm1iWg=;
	b=aOIGtHwo4dXowun3pJOWBIYnHcLpaBo+IibVt0g5TOvERoysuYJ1fcMYUBvqcXg+
	JjjZHUMLlAIgyOhSBz3bwcZmeDCoQiSejzHpSv6oo8X/d2DtLsdzOj4v+I1sqDRs4jk
	T38B5zaSmD0G9gjcdl++1jdVF9ma7jZISpf3ESn8=
Received: by mx.zohomail.com with SMTPS id 1734653261276915.0288078430918;
	Thu, 19 Dec 2024 16:07:41 -0800 (PST)
Received: by mercury (Postfix, from userid 1000)
	id D37711060348; Fri, 20 Dec 2024 01:07:37 +0100 (CET)
Date: Fri, 20 Dec 2024 01:07:37 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Jelle van der Waa <jelle@vdwaa.nl>, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 4/4] platform/x86: dell-laptop: Use
 power_supply_charge_types_show/_parse() helpers
Message-ID: <g4qclyb47aylmjavfd2boidyp77khdc3k5i5ftzhaohawdsdnw@pwmune4y3kn3>
References: <20241211174451.355421-1-hdegoede@redhat.com>
 <20241211174451.355421-5-hdegoede@redhat.com>
 <0030c3dd-c70c-d21b-de2b-ace0aeb4030d@linux.intel.com>
 <6760c9d3-ccf4-47de-bfe5-b59b8b9fca07@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g2ob2suj76dp2zbl"
Content-Disposition: inline
In-Reply-To: <6760c9d3-ccf4-47de-bfe5-b59b8b9fca07@redhat.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/234.551.59
X-ZohoMailClient: External


--g2ob2suj76dp2zbl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 4/4] platform/x86: dell-laptop: Use
 power_supply_charge_types_show/_parse() helpers
MIME-Version: 1.0

Hi,

On Tue, Dec 17, 2024 at 04:18:47PM +0100, Hans de Goede wrote:
> Note that merging this requires the earlier patches from this
> series which have been merged into:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.gi=
t/log/?h=3Dfor-next
>=20
> so this either requires an immutable tag from Sebastian for you to merge,
> or this should be merged through Sebastian's tree.

Unfortunately I cannot easily create an immutable tag, which does
not pull in quite a bit of other clutter from my for-next branch
(or require a big rebase of everything in my for-next branch, which
I usually try to avoid). I noticed too late that it would have been
a good idea to merge all of this through a topic branch.

Greetings,

-- Sebastian

--g2ob2suj76dp2zbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmdktT4ACgkQ2O7X88g7
+pqazA/8DouyIvR78L9UouabSfwPvJsvfA1iHLpbu57sMylUrYXiPenhW+IX1wmw
lwfg8XOGvSqU1lBQMSCfKtY1VrKqnZWIQAHOuXyuDKhv4DvNdKYmfPC4dl8oDE/L
esQTK3RP7F1sJEsVUfrC3WvVLP5WW+Q+vavAVzMtYcjbXSMnKNODTojykwPcOBRA
gar163TMfBs0aoCDzBGofku/L7Xik7dYAzOS4ztp3OjHCwqKZI4US+zthfmKVw2p
8pfxNquZg2GA/aZj3dkHSm31L93MopRHgDpdp7LK7+Q3E0WRJM5YtEeFLoAukGI/
ZwLKngY0TQTwGA3ye6HAB4K62Bo3274OhNFF/lSemhSfEPJkop140fPvNCWue/VL
5XCFVCq7MGjTVG62m1I83ktcnNbE1HeYo/p1R96YtLYdsDDjXOqYqCIN1SyTc9m2
CTpIuuilgLkzaSscJoDInR1KSnojGva0iROpo23vx46V2RnQLA7blCVcJnOZLWar
pkyFfpddUh0ERqHSJ0odfkho67WCTpx5XwpgQtfEB1jZvRpB3GzneZ/lAKFmvS85
GhPNIJJQet36qSPLleUquvKRE0SpjM0gx9CYA/QYd+nSeNPohn/oM/qcf4VwU5EZ
4aL8SGmCWsdqoKgSLZgdls7BTvfoI440uREwB689hfYrbXtGsCA=
=pkQX
-----END PGP SIGNATURE-----

--g2ob2suj76dp2zbl--

