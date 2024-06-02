Return-Path: <linux-pm+bounces-8506-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDA18D78E5
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 00:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3801F21227
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jun 2024 22:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F4F53E15;
	Sun,  2 Jun 2024 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="whACvm+5"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD36D3EA7B;
	Sun,  2 Jun 2024 22:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717368025; cv=none; b=SjKeAXdSrE7dzyJuvwFssMPFOxr2V+h5M9m4vws8uZuNFPB2BHrs+g+ds3dfzlW9JJ5JcJwan+s9W9tEFHDOVknhMqO2dZKrRPmYZ/Cx+3p/Iaa3+9k8JNqjFOZdFtLecdIMR0wq7SLyrtBypLunY61KNsuKsDyh+6mlBEkh7ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717368025; c=relaxed/simple;
	bh=To7mGo/owzLvX5xUigMpm7M8kw8jHdspRx1v+79dzYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2ftocTrPDdtwkdTyIn8K0yGcMCuNJVhaB49fOtHHMxRNfAxGtA+tz0wqjANB/M3ssf9QjB65JnLEq701mxq3LlDq5TTPxm1OrIgFX7ztXzRrpJ4xOWw4zsip61jVpJ4kcvh2wjUNAAIowurX87TFFN/Md/HI1N1/ft5ive2dFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=whACvm+5; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717368021;
	bh=To7mGo/owzLvX5xUigMpm7M8kw8jHdspRx1v+79dzYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=whACvm+54yIA2WDMF7neBAFOQrY9Rt16RksWO0h1moCmCqECGlpntwlFPr07mXtfU
	 ELW8QlCqwAhjkQyNMS3JUy0LjOqX2B0yY4Tgv4mJkUErgi9YuRNOIHQdNq0QW92MIL
	 brDyNL9aQAWwtTDd6C33+kWucOlPsgyI6fix4oSZLaE+XfH5ePRiz4jCQqpdoOvDyA
	 5Cs+N8x5Ihf/bZIiS5qDbMvY32F36yJNVoAEk7yirBSIHVJw7qg2CYy/hwri2PiewA
	 jCkoYVsDn9WwQ8KR7mSmIuJ0Ow4AMLA7uq6n9Wv2lpLjMbVXGozrEXZSsl5F7WhyXQ
	 PR9Sap9o8k9LA==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B096D378148F;
	Sun,  2 Jun 2024 22:40:21 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 24CFD10611D2; Mon, 03 Jun 2024 00:40:21 +0200 (CEST)
Date: Mon, 3 Jun 2024 00:40:20 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] power: supply: ltc3350-charger: Add driver
Message-ID: <wqvc3uasq4bzkwuhdpaeu34hyhag2h2trff4ryhecenjvx6nei@bx4sdp66oxew>
References: <20240416121818.543896-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.4a7cccf3-e7cb-4980-be8e-de8bd2795354@emailsignatures365.codetwo.com>
 <20240416121818.543896-5-mike.looijmans@topic.nl>
 <t4avn7fmzw355a73hu3yu4wzdxyc5gkupi5s4yfio5iyiygkx6@5eubzdbqthqx>
 <fb93cdd9-0c9b-4cb1-91c1-ccf832fcba75@topic.nl>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hnayuqdj26rfnhzn"
Content-Disposition: inline
In-Reply-To: <fb93cdd9-0c9b-4cb1-91c1-ccf832fcba75@topic.nl>


--hnayuqdj26rfnhzn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 28, 2024 at 11:41:36AM +0200, Mike Looijmans wrote:
> On 27-05-2024 22:40, Sebastian Reichel wrote:
> > > ...
> > > +static int ltc3350_get_property(struct power_supply *psy, enum power=
_supply_property psp,
> > > +				union power_supply_propval *val)
> > > +{
> > > +	struct ltc3350_info *info =3D power_supply_get_drvdata(psy);
> > > +
> > > +	switch (psp) {
> > > +	case POWER_SUPPLY_PROP_STATUS:
> > > +		return ltc3350_get_status(info, val);
> > > +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> > > +		return ltc3350_get_charge_type(info, val);
> > > +	case POWER_SUPPLY_PROP_ONLINE:
> > > +		return ltc3350_get_online(info, val);
> > > +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> > > +		return ltc3350_get_scaled(info, LTC3350_REG_MEAS_VOUT, 22100, &val=
->intval);
> > > +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> > > +		return ltc3350_get_scaled(info, LTC3350_REG_VOUT_UV_LVL, 22100, &v=
al->intval);
> > > +	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
> > > +		return ltc3350_get_scaled(info, LTC3350_REG_VOUT_OV_LVL, 22100, &v=
al->intval);
> > For USB chargers VOLTAGE_NOW/MIN/MAX refers to VBUS, which is the
> > voltage on the USB lines and thus the input voltage. From my
> > understanding of the LTC3350 this would be VIN and not VOUT. With
> > VOUT being supplied by either VIN or the Capacitors.
> >=20
> > So I think your custom vin/vin_uv/vin_ov should be exposed with the
> > above properties.
>=20
> Yeah, power supplies report their input voltage. So this should
> report VIN.
>=20
> > My understanding for VOUT is, that this is basically the system
> > supply - I would expect more regulators to follow, which convert
> > it to typical voltages like 3.3V or 1.8V. In that case it would
> > make sense to expose VOUT as regulator, so that it can be referenced
> > as vin-supply. You can find a few examples for charger drivers doing
> > that for USB-OTG functionality.
>=20
> Looked at other drivers for that. Significant difference is that those ha=
ve
> something useful to supply to other drivers, e.g. being able to
> enable/disable the output for one thing.
>=20
> For the LTC3350, the output (voltage) is just a measurement and there's
> nothing for the driver to configure. Any regulator_ops would be completely
> empty.

Which is also true for fixed regulators, see fixed_voltage_ops in
drivers/regulator/fixed.c. Not having any control options is not a
problem per se.

Note, that regulators have pre-defined events for the functionality
you are trying to provide for VOUT, e.g.
 - REGULATOR_EVENT_OVER_VOLTAGE_WARN
 - REGULATOR_EVENT_UNDER_VOLTAGE
 - REGULATOR_EVENT_UNDER_VOLTAGE_WARN

> Given that, I think it should get the same treatment as GPI, so either a
> custom property or some other device (IIO). Or maybe add a VOLTAGE_OUT
> property? It's not uncommon for power management devices to report their
> output voltage.

power-supply handles batteries and battery chargers. For both cases
the kernel already has properties for the output voltage (which
would be the charging voltage in case of a charger). Other PM voltage
regulation elements are so far handled via the regulator subsystem
and hwmon is used for monitoring.

Greetings,

-- Sebastian

--hnayuqdj26rfnhzn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmZc9NEACgkQ2O7X88g7
+prK8g/+KrIg6jyostU7AAlJ6XQjuFjR/XRqyoLCaZ9VZvfEudd4volkjse8Oxrp
T95sQd0cJXRP6rzXNAhmKZjY+XmNMW3zJIO99rLArWjsTIc0ryru2K/dc3kyL3OZ
Z1hVyvi9qUqHjXg5Ci1A34etVNOAqbo4n4taAg3Z8PC/crL34zFClUlcshhIgrZ6
qDyGw/ZzFWW3FXlvMxuxpeYQkIxnhnvMzhk08fcDmbOmLxGjvK9INBIDIzt67Xci
TiE+uZemOcvOZA65CiqXIxw1XtHv4IOjA3bZ96YmqP7mdERsXkbYkjlWZKVRR+9K
n9QLdLdexWwK7xr8IxETj894B9JCM3Of9pUkuq6tJzZWu4k4sWL40un0RAZTMDpl
78mIJ3USM0kFrFmLRgJNQWmb5V8v6NCtEKM+yARL3G/x9OPp4yc0c1iCnNgHCoMT
sEVVc1PQy/Jt/TUz0AB7MeNJvS7CcK57/iygHP/Gny5DqmTCbC+rNvuvbp+3CoGs
48oFoazcvsclCNNfUBo+cqr0uEnPt9sCZlb2+aoEkKr4FXDFBIA/j8fCoX6pVeh0
f0VsHj2b/LALV8TLORWjBz9SDptMEFxAigYbhKaAzPF7h/zc+44euj93OkI9vG2E
/Z4idtNcFxvhTMRkedkU3sefOcvIbcAL2Lqg3Hbhp7UmHSE8/PU=
=P2wV
-----END PGP SIGNATURE-----

--hnayuqdj26rfnhzn--

