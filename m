Return-Path: <linux-pm+bounces-40866-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D4DD1F8EC
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 15:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AD5230738B9
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 14:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B7C30C353;
	Wed, 14 Jan 2026 14:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="Mrw29Mkm"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25EF30CD94;
	Wed, 14 Jan 2026 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768402391; cv=pass; b=iQ6ZRETMN/SWunFBiwQZoAgHqEajn9S0Favr0QOcF1Uvy1iTxfO763QdM4gb38tZMEJR0QINTAWo6dh3w5D6WwyWXPDzzTv+NKi40gt2L36/PIZDCODIy0pT6qB/3kg4vlzZUaaUM+l+rAzA0h+0ua7meoc1xYa89jwMtHP5Mgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768402391; c=relaxed/simple;
	bh=b/NvqoTRSBBXd5TxyUJdW1xOdTtjpMRQCvl0VZgazRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StD/1HH5F1UDFGqpRLlRIgAZjVVAXAnHuPsVAGxxDVXGKZk0xpLl9i+4W1QTKaLx3dw+pkm/ze+g0WTUsZTfwS+89ZdIxD/mbJlHYaH3gcD9f1nNFnCJF0x843HxX2LUdjRwQjcDoYcxzhNKDDQTajzzedAC8alf/+t6eWWzG1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=Mrw29Mkm; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1768402379; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gECXeetuZWukOLqMp6t50NzUIVh0EjSBLLwymBbeeJnxDS8pjWzvSRh4/XhlumH/BmB5SmqgRP/a11GyVYnK1ugoZLXjEDibNh7D7gV6AZnbpa+w/BDAL7baj6PSanfz/h7j8syIc6EyNhMcOnAypv6wImx3VrV5OOTXDdErvxE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768402379; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=D01Owa/velr5mOOG55lZuQ9GAjD38Uv7bb1N9qySDm0=; 
	b=nZU3z9vLGFNb3IrDljyR8OuxO1myETs6gv/42hxpoKuLE3L40NPpuZy9NTrmfvwM4CChS7fKTm3+kPIsfU9B+2uMgmxPzm4F31lZDA1Yw4P34T/JBZ6Pmsl7d/1ZFrrnL1nmmN5I1Oijg3VqxbAYY2vBIUg9gpiYyXx9EWADyG0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768402379;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=D01Owa/velr5mOOG55lZuQ9GAjD38Uv7bb1N9qySDm0=;
	b=Mrw29MkmkaO35fVteuVubTHiztBGNXuwZZqrOZRx1FDevnQVjKtSUZkYPL8Kif8E
	nqHaXRxFFmNnOSRZqFuG52QyyrUEfUybpTSTqVYoyD+7TfRrP47xrTxGRUTlKLWf8t+
	FlyIfNYAI2K03PTFHT+k1K8hNyeLauv+fUFuRW08=
Received: by mx.zohomail.com with SMTPS id 1768402377766769.7780210039161;
	Wed, 14 Jan 2026 06:52:57 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 2467A180881; Wed, 14 Jan 2026 15:52:54 +0100 (CET)
Date: Wed, 14 Jan 2026 15:52:54 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Nikita Travkin <nikita@trvn.ru>, kernel@axis.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] power: supply: pm8916_lbc: Fix use-after-free in
 power_supply_changed()
Message-ID: <aWetAuBgUsPfiGCZ@venus>
References: <cover.1766268280.git.waqar.hameed@axis.com>
 <64d8dd3675a4e59fa32c3e0ef451f12d1f7ed18f.1766268280.git.waqar.hameed@axis.com>
 <5f3152f01420823ef8ae2932ed781cf4@trvn.ru>
 <pndtswxebnc.a.out@axis.com>
 <pndo6mwtqqh.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7pliuq26ks6ex23y"
Content-Disposition: inline
In-Reply-To: <pndo6mwtqqh.a.out@axis.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.5.1/268.349.40
X-ZohoMailClient: External


--7pliuq26ks6ex23y
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 09/11] power: supply: pm8916_lbc: Fix use-after-free in
 power_supply_changed()
MIME-Version: 1.0

Hi,

On Wed, Jan 14, 2026 at 11:48:06AM +0100, Waqar Hameed wrote:
> On Wed, Jan 07, 2026 at 15:32 +0100 Waqar Hameed <waqar.hameed@axis.com> =
wrote:
>=20
> > On Sun, Dec 21, 2025 at 10:45 +0500 Nikita Travkin <nikita@trvn.ru> wro=
te:
>=20
> [...]
>=20
> >> As a small note, the interrupt handler also has a call to
> >> extcon_set_state_sync(chg->edev,...) which is allocated right below.
> >> I don't think this is actually a problem since it has a null check for
> >> edev (unlike psy core) so I think this patch is fine as-is. However if
> >> for some reason you'd have to respin this series, perhaps it would be
> >> nice to move irq registration slightly lower, after extcon registratio=
n.
> >
> > Hm, it _is_ actually a problem. During `probe()`, it's fine, due to the
> > NULL check in `extcon_set_state()` (and the interrupt handler doesn't
> > check the return value anyway), as you mention. However, during removal,
> > we have the exact same situation as for `power_supply_changed()` as
> > explained in the commit message; `devm_extcon_dev_release()` runs and
> > frees `struct extcon_dev *edev`, the interrupt handler would now call
> >
> >   `extcon_set_state_sync(chg->edev, ...)` ->
> >   `extcon_set_state(edev, ...)` ->
> >   `find_cable_index_by_id(edev, ...)`
> >  =20
> > with an invalid `edev` triggering a crash/corruption in
> > `find_cable_index_by_id()` (before we get the chance to release the IRQ
> > handler)!
> >
> > Good catch! Let's move the registration a further bit down to fix this.
> > I will send v2 as soon as the other patches in the series also get
> > feedback.
>=20
> Since Sebastian says that he applied the whole series as is, I'll just
> send a new separate patch for that now instead. I couldn't find anything
> in his tree [1] yet so let's chill a bit until things get pushed.

Ah yes, I planed to reply to this and ask for doing exactly that and
then forgot about it :)

FWIW you can find this patch here:

https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/=
commit/?h=3Dfor-next&id=3Db7508129978ae1e2ed9b0410396abc05def9c4eb

Greetings,

-- Sebastian

--7pliuq26ks6ex23y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmlnrcIACgkQ2O7X88g7
+prYMg/+JkmJWiHEVqqYGD884z5AuuyrBVHmyW22urZPKYLesaQf2PUXlL2kzPtE
pLamrw4o9YNkwuKPmCn1XWMZaMBKCdn36qpLFbivGTeMLKf1jhVVbKFOrCDSnaQH
7DtFy+MDdt24xpyDhGuy7aMLKi+KvTCFUfqMu8+qLJEhZfvA33Q3kuodisLiwOh/
dm1RmFRkAQUPL0nYFBDhCy/EItYf0NE0AkMa+9qbHZMyrFxz8VZkniXD9dKyh6VJ
yuq5dnRaqW0D9QWyWReRnYPd1bW3ZQrqTvdym93+j1LMr/Zz41mhWozgg8r3TeO0
AqPDDh55tiwgrBK+jztQ0qvZaENIL3owTMl2mgLdX0L2gHJ1PuZPxSUup+evoF63
qtzG/3CjY1DUqnDUhnyBtFxOz6/77fwYyWweB+mp8BxXPoBdKyy1aB35R5+F+Pfp
46wCaRTYTzbMsWBbSxJCs03/3QsqFfrEk6uAmv0xXGb/85OqTZCACvkSIjSySKCe
AP5Y+FvjBJ2unXucPMjLd2bOmH+uYJZQqUsnN/DN+4tVkYquWzyDqMBQjJ+2f12L
TBbP4O/nt2LbQgagkRX49QV3ONRSgZOIKABliyW9XfNaiJZIzEfJjxpaAC6Xk7UV
NtWEHo/K1LQcoPdYgVkOKMky7xltPHzEA7WteECJRk7sOyKJ3QA=
=8tpf
-----END PGP SIGNATURE-----

--7pliuq26ks6ex23y--

