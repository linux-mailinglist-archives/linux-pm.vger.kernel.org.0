Return-Path: <linux-pm+bounces-16887-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1A39B980D
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 20:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1C91C214C3
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 19:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6FB1CEE80;
	Fri,  1 Nov 2024 19:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="UguSqV4x"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800A41A0B16;
	Fri,  1 Nov 2024 19:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730487926; cv=pass; b=NKVOsPQ4Y3EgPPLC0aggl2XRt/nOQfAEosdF+SpprnPu/yXUiUKiN6Ehe1Lxl0hHBIWRQNoRqXsi4YlVACE8TIWRWUjCsaUjVVSuitaDiMvN+gHBUxTa+4+H8P4dOzkKUvUfltFQrxIRWSeJ9tB4ApXu16gcmJKGYPeUnm5+eNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730487926; c=relaxed/simple;
	bh=pzoJ5fr6Q5GERZ5oaDzhX4m2iyhXQfzYDnP4gVMdNVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMjxizkx47oPCTlO4Ug9BgLK1ln56p5u8Ngw3cHtHtHOy2bGZwuTKun1KnUhcMN4iEKrA6ie9EnZencA/S4lMoeMn2nA84tvi7Sq42xCQP+4X0vz4FP4EJGbjSnxF3VtIulPSXnWMddG6+UcdtCIcCGvf0fhH3icFPubgot3SXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=UguSqV4x; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1730487900; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=d20C6Y3wyw3/8SaY0GwAVhYMHvrXivxlNZuO18r6gr/ZegIhYAyXtqss75WvJKUS8a5SJLObM6nnjF2q5gkeWsHV/t31Fcm0F65WyZu21L8VzwbbO4JOSumNpLMhOXY6ObLqOpY5RSJGRz1C6NJHOPA1dZPeLoWMaREJbvfFMtU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730487900; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pzoJ5fr6Q5GERZ5oaDzhX4m2iyhXQfzYDnP4gVMdNVU=; 
	b=Z0mYTzCYL6nKjVntpGOnNrUTIO23JKlDrF1q5/elaQklnmk2gJGug/vSKnHj4I9ZkDH8hfLz/JWSEKapbDlpDKh53/3PzZyIR+mFE+ej5KCzfQt610MOVme1V3NS0oWC6dsY9WRLSYKwxcdIzKmMTi8xVwH0FUf3CPTdZhezmko=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730487900;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=pzoJ5fr6Q5GERZ5oaDzhX4m2iyhXQfzYDnP4gVMdNVU=;
	b=UguSqV4x+9hrg/V3cytNm2dwqbndRkJLTRaQ/SEMM8w/qbHiDqVOOaaEd4cUiArS
	2hTuGpx67ztYGzAKJA/k1bEpjVPsva2c8iA27GvPDxqxl/3XIyKcgSfuHURJB7cOZtH
	wUGVT0mzS+UcebYPEUCU8e9EBh+RfB4RSGr/gD4Q=
Received: by mx.zohomail.com with SMTPS id 1730487897758168.1618463566807;
	Fri, 1 Nov 2024 12:04:57 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
	id 18AEF10604B0; Fri, 01 Nov 2024 20:04:53 +0100 (CET)
Date: Fri, 1 Nov 2024 20:04:52 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Liam Girdwood <lgirdwood@gmail.com>, Elaine Zhang <zhangqing@rock-chips.com>, 
	=?utf-8?B?QWRyacOhbiBNYXJ0w61uZXo=?= Larumbe <adrian.larumbe@collabora.com>, Boris Brezillon <boris.brezillon@collabora.com>, 
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v3 0/7] Fix RK3588 GPU domain
Message-ID: <27yrptpmhdbugmrgxaxllnbllv3adu3tzgl7e26b3flsvhlf3g@nfqn2fvmktmc>
References: <20241022154508.63563-1-sebastian.reichel@collabora.com>
 <CAPDyKFoAv1jeQitHmTMhvwG9vGzN-vLby0fPzkX1E6+-Qe2dog@mail.gmail.com>
 <CAPDyKFp=sRLVBhW2aK87pYHVGi_6gNw=e3j3AGMnEWP2SVYFpw@mail.gmail.com>
 <9b4c9b61-a2be-465e-a4d9-034951fc862f@sirena.org.uk>
 <CAGb2v65ahUB_Q+HPFV6B-UqWCbCNLdGz58BGo9iHRhVyf1ruZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sd4kvys2evpxroym"
Content-Disposition: inline
In-Reply-To: <CAGb2v65ahUB_Q+HPFV6B-UqWCbCNLdGz58BGo9iHRhVyf1ruZA@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/230.343.48
X-ZohoMailClient: External


--sd4kvys2evpxroym
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/7] Fix RK3588 GPU domain
MIME-Version: 1.0

Hi,

On Fri, Nov 01, 2024 at 10:41:14PM +0800, Chen-Yu Tsai wrote:
> On Fri, Nov 1, 2024 at 10:36=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:
> > On Fri, Nov 01, 2024 at 12:56:16PM +0100, Ulf Hansson wrote:
> > > On Wed, 23 Oct 2024 at 12:05, Ulf Hansson <ulf.hansson@linaro.org> wr=
ote:
> >
> > > > The merge strategy seems reasonable to me. But I am fine with that
> > > > whatever works for Mark.
> >
> > > Mark, any update on this?
> >
> > > If easier, you could also just ack the regulator patch (patch1), and
> > > can just take it all via my tree.
> >
> > I'm still deciding what I think about the regulator patch, I can see why
> > it's wanted in this situation but it's also an invitation to misuse by
> > drivers just blindly requesting all supplies and not caring if things
> > work.
>=20
> I suppose an alternative is to flag which power domains actually need
> a regulator supply. The MediaTek power domain driver does this.

If you look at patch 6/7, which actually makes use of devm_of_regulator_get=
()
you will notice that I did actually flag which power domains have/need a
regulator.

> There's still the issue of backwards compatibility with older device
> trees that are missing said supply though.

Exactly :)

As far as I can see the same misuse potential also exists for the
plain devm_regulator_get() version.

Greetings,

-- Sebastian

--sd4kvys2evpxroym
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmclJk4ACgkQ2O7X88g7
+poVOg/+PaFjJt/IbSqoFt+2B0uc3fK8C3HKt56Y2kbeE0svwnnG8rBkWqbNGP/x
699N+JDv8ZOozhjWXknZBfsGLJUOSvvE1b88xb5WWsZ0FXnQ+uqaOdBu2Ph5iWL2
efopHne/lUiElpPwuHPrGyibqdclrjuF4REkt9IfIG9wCuXwTbmrtXSGV0B1A6El
JF36I3Gb0i1UwsaIdFKm5MgnLeycFyHMnBYNSeQ5ODnK3UXCRySfQa/CJHU0uAKx
hrlQ4S9cP0ndBZTkd9fXAXCVftPfZx/k8ov6eBUtHIk9E0ADCePmQMtjPBvHU33S
KJzVyjsCSR5hOP1TEcD8+3b3T9qOxJAuvJXvycotVFyueWO+RHfJvY46Aye865O7
l6009bUVHnEpod1uRb8GSufiMt38yu5tCyM2fckpCL624YwC/pLEEWqqyJP9Mw4E
oqgpexhSAVHZxI3RnuWxmesclM4xA/cI/wl8PQsNZ7fArS0RWlHCYn4lvlz4i886
TSUvys5m4QxVx8rlADvDS6z1HQd2xXtsjq2aYwwxkqxhK/aK/kef2vIEy1zq02TK
aFs+AtwO1jNofEYAQBRsTTlmz7yES7YJ6wA6ClyjKHme1DhHe6JvjX4lrdAsen9x
Tu9hfY0Gi8fg/k3O2NB/g9L1QyeSosgA2xfc3a1f17mtYX/ZGqA=
=IDSJ
-----END PGP SIGNATURE-----

--sd4kvys2evpxroym--

