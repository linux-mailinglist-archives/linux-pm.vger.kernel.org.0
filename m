Return-Path: <linux-pm+bounces-14356-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D897297AC5C
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 09:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17BBF1C21121
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 07:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C928149C7A;
	Tue, 17 Sep 2024 07:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="gRFbVweP"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0E2139578
	for <linux-pm@vger.kernel.org>; Tue, 17 Sep 2024 07:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726559188; cv=pass; b=ZTVVze/WI+uiGzl9Oz5homT9/QrcBj4p0ghMDlZPsgMGz9WXfz5BE4fAJW4PDHEMoMNT0p71AS8pfQEQRAjNPinNr/hRp/oawZ+wYnv4/kLLKrDWflxGSSSjru3cP/QQfP2IPbemjPfO5S645wBYlSqhAJ735PFt2K86oNK/raY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726559188; c=relaxed/simple;
	bh=EO+OgocQW00sbc4ESoUILBAfe1+Sj7WgHZ1NIcDuQWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=it6DboPszf9ZRe1kcbNqoOITUj0qcNQ249wfiF227CUgXtRSFBZ6umLGoC/g631RO6DOlxWgSpjdUHK9s+Nm+nc5D1qIlAYAFzPOrU9OeuNXPBJjTF0YUdAv9rR/frWHcUKvyh/9veVbvoDo3CC8pXNRL8balgrLXxQVfDHx2EU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=gRFbVweP; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726559176; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MGZeeyZSlp0Sc0q7tV15ULytSfOafBIztrkZjJZObCO94sde7KKqu8+l0O9PNTyQe9TN8jXXvJ/UDIH00Wc4c+7Wdi98wLcfkvW6Q6S6ulieIDBkCT0a9iXm5hZOiFqbQTFex6w9EH2WF+Q+0NTIqCfcHa6rCV+hXzgT7n8gq0w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726559176; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4T3rERLj5EL/tKmc9QC/uvIzwJf5HzOATwTPzD7UFyc=; 
	b=TbybG6Op+FHvoDv/aQYu696aoE3uSoRfC2vLb6Ak0gmNOyuRSyD8jKdHYrAnWQUyeJ0rc2Z2Hy/lpUGszNFE17ilWMGKTtEOiEuPm/IwDT4II0erpo674IXxozT0+zoqAf4IhJ4iZW1Uh3ULVOEHVHKE1rqv8K8c7jV5AMmjU7s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726559176;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=4T3rERLj5EL/tKmc9QC/uvIzwJf5HzOATwTPzD7UFyc=;
	b=gRFbVwePPKz2oP3ErE5p8e0S2bBKeAOeKUk3vf6gw1Dk0L7zsSkhgzSHQQmbKekx
	5NSspQbsKHyagM1Rjryec33aXxaYZjPHEtV1c6cqQ/1HpeVbEGPVc78YAEfSRoNZLER
	jh90unEv17EvjupIaoOs3BkLpNSc21I1DiTpQJB8=
Received: by mx.zohomail.com with SMTPS id 1726559174831432.7164319017385;
	Tue, 17 Sep 2024 00:46:14 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
	id 35FF9106045D; Tue, 17 Sep 2024 09:46:11 +0200 (CEST)
Date: Tue, 17 Sep 2024 09:46:11 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jelle van der Waa <jelle@vdwaa.nl>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/4] power: supply: core: Add new "charge_types" property
Message-ID: <4riyog2zpwnlp744zx3xlejxtju22qt74zzxrpsfeghkeyuxge@k27wkl372dki>
References: <20240908192303.151562-1-hdegoede@redhat.com>
 <20240908192303.151562-3-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nofucbu3dfof4kcw"
Content-Disposition: inline
In-Reply-To: <20240908192303.151562-3-hdegoede@redhat.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/223.982.64
X-ZohoMailClient: External


--nofucbu3dfof4kcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Sep 08, 2024 at 09:23:01PM GMT, Hans de Goede wrote:
> Add a new "charge_types" property, this is identical to "charge_type" but
> reading returns a list of supported charge-types with the currently active
> type surrounded by square brackets, e.g.:
>=20
> Fast [Standard] "Long Life"
>=20
> This has the advantage over the existing "charge_type" property that this
> allows userspace to find out which charge-types are supported for writable
> charge_type properties.
>=20
> Drivers which already support "charge_type" can easily add support for
> this by setting power_supply_desc.charge_types to a bitmask representing
> valid charge_type values. The existing "charge_type" get_property() and
> set_property() code paths can be re-used for "charge_types".
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  Documentation/ABI/testing/sysfs-class-power | 15 ++++++++++
>  drivers/power/supply/power_supply_sysfs.c   | 32 +++++++++++++++++++++
>  include/linux/power_supply.h                | 23 ++++++++++++++-
>  3 files changed, 69 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/=
ABI/testing/sysfs-class-power
> index 45180b62d426..0173dda8d5ea 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -407,10 +407,25 @@ Description:
> =20
>  		Access: Read, Write
> =20
> +		Reading this returns the current active value, e.g. 'Standard'.
> +

I think something like the following sentence should be added:

Check charge_types to get the valid values for the system.

> [...]

Greetings,

-- Sebastian

--nofucbu3dfof4kcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmbpM8IACgkQ2O7X88g7
+po6Ug/9F0u7nFtFXWjw9YsZOtgTsIVGNm4Hpb8B+aGU0PrPKQQXUbsPbqU3PDjw
XYbFv6eCtH9l2PZDWupB2u1MdJVRyzXKOUQ4gomgm+7YpuMJNha2/jDQACOo41J4
aIeLd9PiIshw5lX8n3BMeaqbOJrn+HUwVTYBe2uR9eNiuvUHuKVGL9rJZMQLXcaR
p6D8HVJHh/ULPcS78p7y9YXn6gdUv/8coJyP9awmfnGIpoUECIntNT8fe683LXDy
0+jxQfSlMaMShDC6timagCT/C7YSWATaq9Of4Q2eV93SuWO/8BHVT7T/LU36m7Gf
jOH62lRVdlSaqtkBC9JGscseDYYhNA1FLDsXAVbmuWK/6dYtBWIyKdDmc/p+E+N2
kn1gI7LalIPv0dmQ5D12JCNQ9lkWcH22l9fH2EN42Y4S9HCEZ7e5zs2sKJ+D02H6
jYGrznqBZp/ObkzcG6cBUxUXXrmsu/lLvUkjE7xmRDJLu5rziFfACG0boiV2TXzZ
tM+CQJiH5a2nn9j5z9LswlRAbqLN9/j2wyRFPSB9KsMiHihDfsaOIN/VoNORpn1d
ZnM+kbjaMjWzP2Vfmr/G+xq8Rf5NyLGaHjxlPVdPS09xwk0TSvw9w/eltUKHY/tj
utsCo+SG+kwwhocu3L5ZSI+cbYveLlikJWGsQEx+pCf+giju130=
=VE/B
-----END PGP SIGNATURE-----

--nofucbu3dfof4kcw--

