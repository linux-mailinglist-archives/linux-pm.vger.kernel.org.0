Return-Path: <linux-pm+bounces-29215-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF60AE2DB2
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 02:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A41189516A
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 00:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5224222094;
	Sun, 22 Jun 2025 00:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="S2+dtMtS"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEEA72600;
	Sun, 22 Jun 2025 00:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750553904; cv=pass; b=RGBjGd+m+e6YaGC98+Pb3ijYk2baMrQnRoZPYaMFeRh7tF/UOYkly5VDf2lQU2jvF7CKr2zVQ1QJqmINPiI0G1gvENaRmRMgH1LC66Les2zy8HcS8soqJ32yqPiHzvNJkr+o0ByxnbVZoL7XSIaedbz/nhNnr7kkMBTJYI8Nges=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750553904; c=relaxed/simple;
	bh=JiD/4fsbX+nc0i6h2LSR8zFKhgtbgMX1306LRG/F5lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dT41r6Hao9FFdzj5GD59h+AdUl+guDmfMdWCHAtRkaRiejKvBbRQxdmyjvDu33Ge69uoQQ+7NkoN0Ng/VcYqfq98W4t9QX0kMzuH6tBfpz4L0bSrIwPt2/p+6D0Sx/4tBCtz/9XxVxBVNVxPiWDzKBXvvj9mWkKem8IpYy4elyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=S2+dtMtS; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750553897; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jTKbCRVdL/uByHykFpoPCEE+6VqiWWtxQ4t9EwZQ1GdnEiO9Gq8L02x/IFp61Ol4Vde8tj75QupXphxUqz8P6Mid48QDMHweYcCtRsTRoK8/AutXe6FosO2goXEnbXe8Z5rs32zQZXlwfOLxp2GtFnEcsUpyH/ibgsUX7A0IPfs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750553897; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cnLPZYSrkAmzgIkCI0OUW1f2jLh2HotLFc4epF2woS4=; 
	b=S73s9Te9dM65+V77PXpklghQZmYj0YGLXgHbWrFmzg+bl9VZ1mmIVwHhisTxPo+LeiEFuPI+9GgvwnwnHP+hjvSUvqyIKLLDJFLx3zk86tLwpjlFY8zWfzm825a4GuqYSrfsioHMdK7AekigZkCUydUKssgDbRkG1STaJOJYJkY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750553897;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=cnLPZYSrkAmzgIkCI0OUW1f2jLh2HotLFc4epF2woS4=;
	b=S2+dtMtSe71EXtMRJX0WlyJ2d+UAGGkZO20kXJMMRlJco/7yv66F1d+axd51uXJ/
	Cacy/TzGdkkgY2PVdmx5KWPJybyAYXgGrVnQ/rd85MTxxHtP9a1Dgl3VU7FNnzD/Q5x
	qCRpDQ5ooxDLwUHl9qELwQp/x3GFqxPVVn7D9pCc=
Received: by mx.zohomail.com with SMTPS id 1750553895358175.3380157650372;
	Sat, 21 Jun 2025 17:58:15 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id A1AFA1806CD; Sun, 22 Jun 2025 02:58:12 +0200 (CEST)
Date: Sun, 22 Jun 2025 02:58:12 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: qcom_battmgr: Add lithium-polymer entry
Message-ID: <bje4frydn6bw4qwu4s3di4uxppx3tvqidsl2gmyb7tlqihi63o@5v24ta3wpl54>
References: <20250523-psy-qcom-battmgr-add-lipo-entry-v1-1-938c20a43a25@linaro.org>
 <xwr5xiwbiyl27x3uhe5z2kvyqdkwdp3nnwzcbufr3fgmkqa3gz@oacrb7zk7dyp>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="te3mzzurlxggejvu"
Content-Disposition: inline
In-Reply-To: <xwr5xiwbiyl27x3uhe5z2kvyqdkwdp3nnwzcbufr3fgmkqa3gz@oacrb7zk7dyp>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/250.540.22
X-ZohoMailClient: External


--te3mzzurlxggejvu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] power: supply: qcom_battmgr: Add lithium-polymer entry
MIME-Version: 1.0

Hi,

On Fri, May 23, 2025 at 01:44:09PM +0300, Dmitry Baryshkov wrote:
> On Fri, May 23, 2025 at 01:14:22PM +0300, Abel Vesa wrote:
> > On some Dell XPS 13 (9345) variants, the battery used is lithium-polymer
> > based. Currently, this is reported as unknown technology due to the ent=
ry
> > missing.
> >=20
> > [ 4083.135325] Unknown battery technology 'LIP'
> >=20
> > Add another check for lithium-polymer in the technology parsing callback
> > and return that instead of unknown.
> >=20
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  drivers/power/supply/qcom_battmgr.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply=
/qcom_battmgr.c
> > index fe27676fbc7cd12292caa6fb3b5b46a18c426e6d..32c85939b8973422ee417c3=
f1552f2355658cf06 100644
> > --- a/drivers/power/supply/qcom_battmgr.c
> > +++ b/drivers/power/supply/qcom_battmgr.c
> > @@ -981,6 +981,8 @@ static unsigned int qcom_battmgr_sc8280xp_parse_tec=
hnology(const char *chemistry
> >  {
> >  	if (!strncmp(chemistry, "LIO", BATTMGR_CHEMISTRY_LEN))
> >  		return POWER_SUPPLY_TECHNOLOGY_LION;
> > +	else if (!strncmp(chemistry, "LIP", BATTMGR_CHEMISTRY_LEN))
>=20
> no need for 'else'.

I fixed that up while applying.

Greetings,

-- Sebastian

>=20
> With that fixed:
>=20
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>=20
>=20
> > +		return POWER_SUPPLY_TECHNOLOGY_LIPO;
> > =20
> >  	pr_err("Unknown battery technology '%s'\n", chemistry);
> >  	return POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
> >=20
> > ---
> > base-commit: 176e917e010cb7dcc605f11d2bc33f304292482b
> > change-id: 20250523-psy-qcom-battmgr-add-lipo-entry-e75b3be303b6
> >=20
> > Best regards,
> > --=20
> > Abel Vesa <abel.vesa@linaro.org>
> >=20
>=20
> --=20
> With best wishes
> Dmitry

--te3mzzurlxggejvu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmhXVSQACgkQ2O7X88g7
+ppUOBAAoRo9ZijUijLW10KKlKpsPTLGj+Fxe0bySdWKF+6ll12aKzSe/oBVBWz9
RWESMnN8UG+ZiVAtqTRW9Tor/vagAp8qypIqWuIrQVLj2GbFAnm2DQrz6TNf8Nuh
9QrktKPWyyjmBau1tP01/27nmovS2hOsyiZJVFt7/djreMlIOxSCtv51UpfSHerx
ibap1JrzT8qgY0e6bszETBhG2OiT29dCYtr37pTl3r/pbhgj0k3iQkS/KlOLFCos
b0KjZcV5I8BLYyKK3RbJVMB1pP4M/hZT6OerEosMF1ltIVuMlW9/1cea77gme0Zb
fpDwyrPZ0OxXo1gJS5b9OYC5P7otanDJMw6/sYTe4J00e02OVPODyDDKGVCX8+HG
jYXd3cKWGF7m6u30M4ktuFFn40sZmhlyMYPniMiFD3DpCTBQ3yvkFEIYXn5Fsj1q
Dqa3GgpO1DTHDbFdU9/+R22NPgHHaLSvLTL/XlJzny4hSAFMj9vrzdf8r+0X5WT5
HKs/r0FS29gGMfqAzufMFPOY4LaCYBwHai9akXyTjhguhU4Y3naDT206GLVCTbmR
blV9fS/mb2m6ZWIX+HNwu4y4UCWzOgM3ekh7bU3er3S5MWdoSrpfa08/rGkCNhrr
fUBIuwpyBiUrW5GaATJYPEvzwzNcYDjaLkf3vQFI+vFnMG2Ibj8=
=bJri
-----END PGP SIGNATURE-----

--te3mzzurlxggejvu--

