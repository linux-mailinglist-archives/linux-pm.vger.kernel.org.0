Return-Path: <linux-pm+bounces-34175-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2433B49AB2
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 22:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8DF91BC536B
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 20:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D6D2D7D30;
	Mon,  8 Sep 2025 20:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="bzhLdmNe"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C72726E711;
	Mon,  8 Sep 2025 20:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757362149; cv=pass; b=rFUh/GkESTeAGwXEGFIfGRLmHRE9LMxBddNduaSo+Vjs1Pe7DIjdn1lj9UbQ5CVievq/k6jhXG0GtgzHZ+R4gJxlmHpSL116dVU9OQzuHtswQY8gpUuUMg882u5BqwdkkFeBXPyqyVTKWJZ5xPxw2gdx/irGcYz7nWIdhMcY8+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757362149; c=relaxed/simple;
	bh=ZVHLGUJZLSkdI8nNXcaoalwzWkaiHSFvSSx0MmfhHLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkz3sZPsWLX3OHOsnvacMjYX2ziUf6tS1boI6ohzfHKEh48vMwyHx832TzmH3s6AcVZBTR4H/LhxGD5aAmq63UAPqTF1bHQtc32JaMFwQkyPJr0yGm7cN83mEwZ1jnHmU8mZvJ9XGNfO4MXdqWa7dk5Vp1h2ED3u/oT8RAkPn7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=bzhLdmNe; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757362128; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=E1mI5O+BDwsYYpSLAByTqShmsSFPlSYjA0QQG11arz0JIb3l0hXMKZswHsKy6q6pZ0xJqFQs9ZiKcFFaZvUulJqUav1h5cnAXEhRucURC+3xI7XurBiTddAVdJ14lzIUuvQW/8yjGHVr2iJrwbaUHIy6iOiowe6sZzgOOytlhHc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757362128; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZVHLGUJZLSkdI8nNXcaoalwzWkaiHSFvSSx0MmfhHLY=; 
	b=Ri6vHzbBorDOsfQYgge4VSpSZQaD0JucXQjQnv5bzhkwCuW3WQdaBhJjVWEUpETh3cy0+xpYhSaFNwKg4lVtlHm8zXSUPrrQGTRialWdBOQuRQV5/lruGlwQWXOut0pLTnehEZ0uREXKpnWYuGV0Zo2D9kTjNJt8s6rX7c9YhkI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757362128;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=ZVHLGUJZLSkdI8nNXcaoalwzWkaiHSFvSSx0MmfhHLY=;
	b=bzhLdmNeSoKiUCCs+h3HRUTeksAj05YUsr2VX04toyCYMTy/TbaoVB+S5OklYhvS
	QGKRfqt8MuXyrFuhLiICxnLP56psSav6qle5AARsAZ8jZwdFNfPzAwsSKX8rKK2imua
	Ixcw1adB75NrB4EP8gE1xT8u3ikXDLeSJhCy5RCM=
Received: by mx.zohomail.com with SMTPS id 17573621245361.8411634081112425;
	Mon, 8 Sep 2025 13:08:44 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 2E84F180B26; Mon, 08 Sep 2025 22:08:41 +0200 (CEST)
Date: Mon, 8 Sep 2025 22:08:41 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, 
	linux-rockchip@lists.infradead.org, Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
	Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] pmdomian: core: don't unset stay_on during sync_state
Message-ID: <dr5qspjhwxaxutiilgx4rvfbrho4bijoll6lciv2bc7c7e7r7m@pgmxztqje5ux>
References: <20250902-rk3576-lockup-regression-v1-1-c4a0c9daeb00@collabora.com>
 <3556261.BddDVKsqQX@workhorse>
 <CAPDyKFpSY+FeKh7ocjQ_nGNZA5+3tWAL8e7ZNKXKNFP-yoiu_g@mail.gmail.com>
 <1953725.CQOukoFCf9@workhorse>
 <CAPDyKFofhy5wiNsHUgdtzFwGtO3QPqhVuu1KsPLBWHF08JzqyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pjwce7oem4hc2zyx"
Content-Disposition: inline
In-Reply-To: <CAPDyKFofhy5wiNsHUgdtzFwGtO3QPqhVuu1KsPLBWHF08JzqyA@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/257.348.87
X-ZohoMailClient: External


--pjwce7oem4hc2zyx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pmdomian: core: don't unset stay_on during sync_state
MIME-Version: 1.0

Hi,

On Mon, Sep 08, 2025 at 03:40:24PM +0200, Ulf Hansson wrote:
> On Mon, 8 Sept 2025 at 15:14, Nicolas Frattaroli wrote:
> > On Friday, 5 September 2025 16:27:27 CEST Ulf Hansson wrote:
> > > I would suggest implementing an auxiliary driver, along with the
> > > rockchip_pm_domain_driver. The main job for the auxiliary driver would
> > > be to get the regulator in its ->probe() - and if it fails because the
> > > regulator isn't available yet, it should keep trying by returning
> > > -EPROBE_DEFER. See more about the auxiliary bus/device/driver in
> > > include/linux/auxiliary_bus.h and module_auxiliary_driver().
> > >
> > > Moreover, when the rockchip_pm_domain_driver probes, it becomes
> > > responsible for pre-parsing the OF nodes for the domain-supply DT
> > > property, for each of the specified power-domains. If it finds a
> > > domain-supply, it should register an auxiliary device that corresponds
> > > to that particular power-domain. This can be done by using
> > > platform-data that is shared with the auxiliary device/driver. See
> > > devm_auxiliary_device_create().
> > >
> > > Furthermore we would need some kind of synchronization mechanism
> > > between the rockchip_pm_domain_driver and the auxiliary driver, to
> > > manage the regulator get/enable/disable. I think that should be rather
> > > easy to work out.
> > >
> > > Do you think this can work?
> >
> > This sounds similar to something Heiko suggested to me, and I agree
> > it could work. It does seem like a pretty painful solution though,
> > in terms of needed additional code and complexity to basically just
> > tell Linux "hey you can't get this regulator yet but please try
> > again later without our involvement".
>=20
> Well, I would give this a go and see what you end up with. The nice
> thing with this approach, I think, is that we get a driver and can use
> the -EPROBE_DEFER mechanism.
>=20
> Another option would be to explore using fw_devlink/device_links, to
> somehow get a notification as soon as the regulator gets registered.

I think the main pain issue with this is fw_devlink actually. The
power domain consumers are all referencing the main DT node. So once
it has been marked as initialized (of_genpd_add_provider_onecell()
calls fwnode_dev_initialized() at some point), fw_devlink allows the
consumers to be probed. As the DT node must be usable for processing
after the normal pmdomains are registered, this means the consumers
for pmdomains with "domain-supply" will potentially be probed too
early resulting in some extra -EPROBE_DEFER. OTOH that should be the
status quo, so probably it does not matter.

> I think those kinds of dependencies are better solved by using
> fw_devlink/device_links.

I think the regulator dependency tracking would happen automatically
when the auxillary sub-device uses the power-domain sub-node as its
device fwnode.

Greetings,

-- Sebastian

--pjwce7oem4hc2zyx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmi/N8UACgkQ2O7X88g7
+ppCahAAqkRqtVsC2durQTJGemBzq0yjG7dqCWIVfUIy4528VeNzKUM68rhTEM3Q
DDCirmiWqQAa0loyj8c1BClUDHE1GYlLPZlFhJYT5X3riH0O9tvS9vqk89BlCqUw
vV3iXxgnaB3Lf5otlZzGW7cIdh5NfOEDtl4uAB+oTdDhPtGSOIqVTyK2lez/qgyi
J0ECOTVmc0XbvI6/nWgyj6WMVqpq8rJxsd/TBS2PmAfW0V4dFhr9BTOoeYOZowNB
PPm4y0UOzS6YaprDF2F9jpPqY9yb/cSQJwZpteZaeNGdqlBucS22AvnmBTGQpmH3
gCDj+ThQfm3kvTASarp/i4kv7KXBZFsecdbw8MnFu8rzryVC9SKRPIaKzKVqNdgk
/ddMfYkWdoGp31DXc9EowBSNXBipYYpz7R/OInML/c1Q6/OAFeeys2qUy1iI/3zz
IjOpu795St7XHwIYyLMNAzjP0AckJRm55+lUnxS7CpOTJGPYDELz55dM6YT9e+0Q
xX8jmJwa79pffiCVV6BcMscMwxji7OMhoS0pbJ4S+BHuvdrEN+MmgJUNBDOeDG7a
vvOpc8/6+y4LjZhV/zxRMGTKdTVQDnHuchg3uKaImghIplGEDkXsghrST5cAT4Aa
zJpy1DDzDeUG/XWypyoRrnW+UlQ8SgIBPKv8shYELogchijmi7w=
=o5Sb
-----END PGP SIGNATURE-----

--pjwce7oem4hc2zyx--

