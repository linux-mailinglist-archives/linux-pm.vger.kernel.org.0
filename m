Return-Path: <linux-pm+bounces-34412-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E84B52124
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 21:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 530697BB25F
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 19:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF4F255F31;
	Wed, 10 Sep 2025 19:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="V5rUyYJ4"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11252D7DF2
	for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2025 19:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757532816; cv=none; b=mPnur9BuFnZP34PKxIYpHreBRmIstO4st0uw/MCF0WOM59zdrJI1RFriR2LGnJEZdbz28e+t0EBDdpMyBGjQ5LhWNberwpiNlQ1OkerWmMzn0kxgsmbPYnqOfQHFJ/lQO13xqWLQrDCBPCKfsKbfe7EHepvuQU3VkS+FN5GEVOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757532816; c=relaxed/simple;
	bh=4fQJyf8XdwGlH+pARRvoK6QSK2GPgHW4xntx0t96XT4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=AZVzar4+3mhvPf59vorZ11WOTlhwMlWN4xnjhO3YSr9dGkadSbTHCXpS0mfwjzso99E1JewxZtW6KVMFqydR+fk38fOVsbu/FGHFYTO3qlnS3v9hF6YKQVXOhd50HmT1qss5pDfpufOeaBqSsSwHoYtG2JJ/usux8zseO3ogXJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=V5rUyYJ4; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1757532799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9HNWtay6hchY2bwAXRQNT7mOaORvRgSuIBfEgTNIN2g=;
	b=V5rUyYJ4lRHWcqYqYknEfuZsE8sAXDcMsy0NulpZl4lozkggwbyalaCf3CKTWt/14F9Wrq
	vPe6H8TlA1Iz51DpiISWBmrecDrZPRfFRAsGjjMs53Z6pWg1y60/dyVhP7CjkW4gTpoZTJ
	N6kiToz7MiFr/Z2nfaCDdwJBZcz2WAw/e6O82T2sfCbS5EbUTTDJbm6CO+et6zHtaKcUSJ
	JW+TzEFamJQxbjHAbj8T0hQ0Qaq8QgfR7X9SHBLEwn+ubmgXNopwEjUyq37RKVopNDyqQ3
	K5kuOXq791foXKvLMSjc+cb/7EUa6IA0s+HTrbJ3Q+KtB9pROsni3TlwNds6aQ==
Content-Type: multipart/signed;
 boundary=2d3af1ea26d984980a780563242cbe541c010a2489cc6084c981a9cec8dc;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 10 Sep 2025 21:33:04 +0200
Message-Id: <DCPDDIZ3S1CM.3DJYY5U4T6V4U@cknow.org>
Cc: "Stephen Boyd" <sboyd@kernel.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, "Heiko Stuebner" <heiko@sntech.de>, "Sebastian
 Reichel" <sebastian.reichel@collabora.com>, "Sebin Francis"
 <sebin.francis@ti.com>, "Bjorn Andersson" <andersson@kernel.org>, "Abel
 Vesa" <abel.vesa@linaro.org>, "Peng Fan" <peng.fan@oss.nxp.com>, "Tomi
 Valkeinen" <tomi.valkeinen@ideasonboard.com>, "Johan Hovold"
 <johan@kernel.org>, "Maulik Shah" <maulik.shah@oss.qualcomm.com>, "Michal
 Simek" <michal.simek@amd.com>, "Konrad Dybcio" <konradybcio@kernel.org>,
 "Thierry Reding" <thierry.reding@gmail.com>, "Jonathan Hunter"
 <jonathanh@nvidia.com>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
 "Christian Hewitt" <christianshewitt@gmail.com>
Subject: Re: [PATCH 0/5] pmdomain: Restore behaviour for disabling unused PM
 domains
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Ulf Hansson" <ulf.hansson@linaro.org>, "Geert Uytterhoeven"
 <geert@linux-m68k.org>, "Nicolas Frattaroli"
 <nicolas.frattaroli@collabora.com>, "Saravana Kannan"
 <saravanak@google.com>, <linux-pm@vger.kernel.org>
References: <20250909111130.132976-1-ulf.hansson@linaro.org>
In-Reply-To: <20250909111130.132976-1-ulf.hansson@linaro.org>
X-Migadu-Flow: FLOW_OUT

--2d3af1ea26d984980a780563242cbe541c010a2489cc6084c981a9cec8dc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Tue Sep 9, 2025 at 1:11 PM CEST, Ulf Hansson wrote:
> Recent changes to genpd prevents those PM domains being powered-on during
> initialization from being powered-off during the boot sequence. Based upo=
n
> whether CONFIG_PM_CONFIG_PM_GENERIC_DOMAINS_OF is set of not, genpd relie=
s
> on the sync_state mechanism or the genpd_power_off_unused() (which is a
> late_initcall_sync), to understand when it's okay to allow these PM domai=
ns
> to be powered-off.
>
> This new behaviour in genpd has lead to problems on different platforms [=
1].
>
> In this series, I am therefore suggesting to restore the behavior of
> genpd_power_off_unused() along with introducing a new genpd config flag,
> GENPD_FLAG_NO_STAY_ON, to allow genpd OF providers to opt-out from the ne=
w
> behaviour.

Is it expected that I'm still seeing this on a Rock64 (rk3328), just
like before [1]?

  [   17.124202] rockchip-pm-domain ff100000.syscon:power-controller: sync_=
state() pending due to ff300000.gpu
  [   17.129799] rockchip-pm-domain ff100000.syscon:power-controller: sync_=
state() pending due to ff350000.video-codec
  [   17.140003] rockchip-pm-domain ff100000.syscon:power-controller: sync_=
state() pending due to ff360000.video-codec

This is with a 6.17-rc5 kernel with this patch set applied.
And it also has this patch from Christian Hewitt added, now in v3:
https://lore.kernel.org/linux-rockchip/20250906120810.1833016-1-christiansh=
ewitt@gmail.com/

When I boot into a 6.17-rc5 kernel without any patches applied, I do get
the 2 for ff350000.video-codec and ff360000.video-codec, but not the=20
ff300000.gpu one.

Interestingly:
ff300000.gpu -> power-domains =3D <&power RK3328_PD_GPU>;
ff350000.video-codec -> power-domains =3D <&power RK3328_PD_VPU>;
ff360000.video-codec -> power-domains =3D <&power RK3328_PD_VIDEO>;

I would be surprised if that was a coincidence.

Cheers,
  Diederik

[1] https://lore.kernel.org/all/DCK0O99SYSCF.BMBAEUV24C1G@cknow.org/

>
> Kind regards
> Ulf Hansson
>
> [1]
> https://lore.kernel.org/all/20250701114733.636510-1-ulf.hansson@linaro.or=
g/
> https://lore.kernel.org/all/20250902-rk3576-lockup-regression-v1-1-c4a0c9=
daeb00@collabora.com/
>
> Ulf Hansson (5):
>   pmdomain: core: Restore behaviour for disabling unused PM domains
>   pmdomain: rockchip: Fix regulator dependency with
>     GENPD_FLAG_NO_STAY_ON
>   pmdomain: renesas: rcar-sysc: Don't keep unused PM domains powered-on
>   pmdomain: renesas: rcar-gen4-sysc: Don't keep unused PM domains
>     powered-on
>   pmdomain: renesas: rmobile-sysc: Don't keep unused PM domains
>     powered-on
>
>  drivers/pmdomain/core.c                   | 20 ++++++++++++++------
>  drivers/pmdomain/renesas/rcar-gen4-sysc.c |  1 +
>  drivers/pmdomain/renesas/rcar-sysc.c      |  1 +
>  drivers/pmdomain/renesas/rmobile-sysc.c   |  3 ++-
>  drivers/pmdomain/rockchip/pm-domains.c    |  2 +-
>  include/linux/pm_domain.h                 |  7 +++++++
>  6 files changed, 26 insertions(+), 8 deletions(-)


--2d3af1ea26d984980a780563242cbe541c010a2489cc6084c981a9cec8dc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaMHSdwAKCRDXblvOeH7b
buGpAQDE9QMZtO9TtjXeo5Opuobk+4Tyg/Qx3IH3Sx8Fy3tJrAEAySejAaTzvvJT
jQfSiiJtxvC1FQ2UwrgFl3g6A6Q7fgo=
=+pr9
-----END PGP SIGNATURE-----

--2d3af1ea26d984980a780563242cbe541c010a2489cc6084c981a9cec8dc--

