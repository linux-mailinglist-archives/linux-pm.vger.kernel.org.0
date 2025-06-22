Return-Path: <linux-pm+bounces-29218-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FC8AE2DCA
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 03:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0130D3B4DCC
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 01:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FD954739;
	Sun, 22 Jun 2025 01:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="HokYQEhs"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167E64A28;
	Sun, 22 Jun 2025 01:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750555049; cv=pass; b=ecQ0IEqUTr0uA8iBipPalDBBOG0dWTv06Fb7CzOqvF3HWyCetV6Dql/8z8VC2R1MkOhOgcSkxUbZZLBN1jA+wXxndnJkzRvP5HzltttuK51+oSj7NKmzD9Eos8wBwkeGPGL8fdC+5gxn9ZV1/BZSNC9TCtnUU/uA/dgVL31YQzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750555049; c=relaxed/simple;
	bh=VR5zIJPHX39+KhLmTxXMniZhBEA/ye1iVB6R85Fqv+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NO2KVD7Wh3ou89ZHd81BEZ3AZ45anKG8d6wxVz7IC8S2JDp/4k/v/Z4YWgN0407dHIF3N4/VVj+mWyLcDNh95mlxgOs7mswp/ELPdrxpF985IoQ0fUEK6z38/U9KlxCE0YO/QkIhAXl30iYeTt4ObEpK2/pmoQ7i1s5sl3rKJgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=HokYQEhs; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750555034; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=j/dUddHIw0jw7P+GEG5Kz7K9a6WCeh2eXEbcYWkdTByjgLj5Sw+rVsrvReUEdvQuRFfiOVIVzP4lC54Xgmlr5+/jlaMNG31wPX7fN7dmXpz8uyIeHUJUuRKCRVp0BI6BVkmt565XPJvgYtLY1+PgV+nCK0JdtjReefhOLalZRss=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750555034; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vBOgVKA+bkgjjsEDtSgp2aLlgRdvGODHoSGStyYoeUw=; 
	b=L4/QshycHW5WT2tze9eN4y6BwF1jeDn9M5WR9pZ9fDaNofaoOW6BALNHR1kXEFnVtkDvMTfgC60WAOH6vkwsv/87yX2C+QGnuiswxkB4gqcHNB/GmGHyVG/XKwAAHW6d9WJfHmHIupo2jnz9naBoXzkqocLuzKtkSNlmej0kUuQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750555034;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=vBOgVKA+bkgjjsEDtSgp2aLlgRdvGODHoSGStyYoeUw=;
	b=HokYQEhs1QERq5GWiJ55umSn3s+QNFohkNqukov6k4WwvA7TESCYJwf9MitaFKzw
	X3GpCISExhxTQK4RYXvgN7bNEc2qqsr8QxFIzDcDxaq+8Griflm+wFV4ege/BMDA0iG
	KY9bvH66D74clhhC686H7qL+SWG1sMjf4QEdpvec=
Received: by mx.zohomail.com with SMTPS id 1750555032166530.0212959965429;
	Sat, 21 Jun 2025 18:17:12 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id E9504180692; Sun, 22 Jun 2025 03:17:06 +0200 (CEST)
Date: Sun, 22 Jun 2025 03:17:06 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Dmitry Baryshkov <dmitry.baryshkov@foundries.io>
Cc: Fenglin Wu <fenglin.wu@oss.qualcomm.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, David Collins <david.collins@oss.qualcomm.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	kernel@oss.qualcomm.com, devicetree@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 2/8] power: supply: core: Add state_of_health power
 supply property
Message-ID: <4pxg7acm4nuwo7bhiwrtpxdey7v2hanw2tw6vbgp6i6md4q2zx@pxjuymr6ykwr>
References: <20250530-qcom_battmgr_update-v2-0-9e377193a656@oss.qualcomm.com>
 <20250530-qcom_battmgr_update-v2-2-9e377193a656@oss.qualcomm.com>
 <6oixvnhihgjucqaovkayzm6cpi35jfmtwmm67wa6h4nlmhr6w5@ggb7auvjzos2>
 <cd2964b0-e28e-4ddb-b319-9b65fb78b73c@oss.qualcomm.com>
 <p5nxjuexggzxttislcaum7vomawnq5fncos7itfib6ysvy6a4k@d5ywmfpqyk3s>
 <994cb636-50b3-40f8-baaf-0b1afa2e7f53@oss.qualcomm.com>
 <3ldf7w5cpv4wt63kvewl2a32abx4uohvir7zgefpqly5rytkcn@p5fslnvpnjn3>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k5bidzak4qxq32ub"
Content-Disposition: inline
In-Reply-To: <3ldf7w5cpv4wt63kvewl2a32abx4uohvir7zgefpqly5rytkcn@p5fslnvpnjn3>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/250.540.22
X-ZohoMailClient: External


--k5bidzak4qxq32ub
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/8] power: supply: core: Add state_of_health power
 supply property
MIME-Version: 1.0

Hi,

On Thu, Jun 05, 2025 at 09:34:14AM +0300, Dmitry Baryshkov wrote:
> On Thu, Jun 05, 2025 at 02:08:30PM +0800, Fenglin Wu wrote:
> >=20
> > On 6/3/2025 6:35 PM, Dmitry Baryshkov wrote:
> > > > > > +What:		/sys/class/power_supply/<supply_name>/state_of_health
> > > > > > +Date:		May 2025
> > > > > > +Contact:	linux-arm-msm@vger.kernel.org
> > > > > > +Description:
> > > > > > +		Reports battery power supply state of health in percentage.
> > > > > > +
> > > > > > +		Access: Read
> > > > > > +
> > > > > > +		Valid values: 0 - 100 (percent)
> > > > > What does it mean that battery has 77% of health?
> > > > I will update this to explain it better:
> > > >=20
> > > > Reports battery power supply state of health in percentage, indicat=
ing that the maximum charge capacity has degraded to that percentage of its=
 original designed capacity.
> > > Which basically means that we don't need it in the first place, as we
> > > can read capacity_full and capacity_full_design (or energy_full /
> > > energy_full_design) and divide one onto another.
> >=20
> > Hmm, it is true in general to quantify how the battery performance has
> > degraded over time. However, estimating and calculating for battery sta=
te of
> > health is much more complicated I think. I am not an expert, but as far=
 as I
> > know, different battery management systems might have different algorit=
hms
> > to calculate the battery health and report it in as percentage. For exa=
mple,
> > in Qcom battery management firmware, a "soh" parameter is provided as t=
he
> > battery health percentage based on the real-time calculations from lear=
ning
> > capacity, resistance estimation, etc.
>=20
> Ack, this is more than just full / full_design. Please consider
> expanding ABI description (though in the vendor-neutral way).

No, Dmitry was right. It is exactly the same.

Estimating the battery state of health information is indeed tricky
and complicated. The reason for that is that estimating and
calculating POWER_SUPPLY_PROP_CHARGE_FULL/POWER_SUPPLY_PROP_ENERGY_FULL
(i.e. not the *_FULL_DESIGN) is complicated :)

Greetings,

-- Sebastian

--k5bidzak4qxq32ub
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmhXWZIACgkQ2O7X88g7
+ppQsBAAkxHBnI3p1jkq1eEQMVJLTv1+SxpjFXaFYp1Njt50JEiEh0IHWXAa3g/E
H2MzOmt9v74E5YKRliZP6ji0vrUwr/sCxozqB9RJcQ3OV+/olwiCaXW3CJIerirn
RJTkSzXFEP+b8u/KOdBc2X4+XdDkW98xz8yd7pnojp+w3pKpyh7+GMIvEZQWSQsd
AP2OBqJrdbUaFTnXg1jmwCrijkiJmTpHiYfHnlmJU6gDgkBQKQaAnMQ6vTLBRPRt
iM0w7d+1SJlPNHCZSfMgPP6mRopU4wuGhGa4otPsmY/OWSU4C+hSwqXH/HdeLNV5
vlXn5mdFvnNSV8vagvt3tIGYYF1e7C2kSdrJiLEqGSlpFFwPrZtJH2XpFOsirijY
5XnRGOOSj0hd6QETxNg8KvZmd0z2972sb29rKR7xTFHNzlH2CzMBfDwbq/VONit2
/QN6KIxtWHxIrVpNUbMz8Yg6AvitBcwGLPAidDpmCJPEUQoSXskmyCb4rsJT92Wo
IZKeEKLCHodlF0X6rs5qSZG7FWMx7EBsbfRvxal/LHifjZ9+RTYhOY/KeDpncYYD
8oI19T66Unr/VGVS274Q1zcgbv7FzzFfOf2/eCtzZz73tYoVs95nmVp9T1QaKGW6
ilcWuosw8IL/fCFUJ/+lPabVHuiY57sbODhkBsi8PJ1qABaDISQ=
=hAum
-----END PGP SIGNATURE-----

--k5bidzak4qxq32ub--

