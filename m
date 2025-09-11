Return-Path: <linux-pm+bounces-34445-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 694CAB52B94
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 10:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BD4D7BBEEB
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 08:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E832C2DFF18;
	Thu, 11 Sep 2025 08:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="UvYXYB38"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AA52DF158
	for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 08:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757579182; cv=none; b=PaC8FMloFZgsd8VJ3YunZdoMCsgPlcE76q7/3FVw5jOmnH1ggsgWKt1Zgvujpx5ZugVxK9JVOpUPfMcgH4d2nitpKWA4IiXyqnIBIPyrLptOjjJY0rfHYT8KPJGmTeEtXEA4MCOZYMzQnodw+z18UsQ8AQl+oce/LXlE22nxZKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757579182; c=relaxed/simple;
	bh=sGlO0xzqKsKudQJzHT8W9TExdYgCpxAuexAQoa1dev4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lm1rbhyxfRkMcBImgD26rwJTB28kN6sDGrKiJ6f7+pVv3JwMzC3Usv1VFcGRGVpJD3J2bwhlmIJSydwsbCPeYj4+l7Ni2jcH5hH9MRbm1TCeYpwD1fjhDdjbJzPsj+PFMj1aC/IusD5Djx+9i51o1nyOFy3FWoYnxLyY5bDpysE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=UvYXYB38; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1757579176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E0lBJocEKP3lSk1wr86/mwJVJDEiyUS7mBzgQ49GMVs=;
	b=UvYXYB38THPhssZVA2dz5yQ7+FZptseAx24L6CpmC6aXfLG+i0gREKXUGr1xLnswZ8BFK3
	9qg9d9RV//SzyO141pSwtZgScqbmc7WjBjxO7XnI5SeIM3yVgvcdIFtj/tf7L9Vpp25go/
	ZS/NM/lk6h/aF250h9ERX+LRkFGSU05LOoJRp6BLWKhLszqWGMqSvVT+h7zTfEAkrAGTwa
	6l0BnycrBvwtpak1skf2bPZijXAMlDdPUp8ZK+/LNzDdHbnxGcvjHsAY+D1EN8sPrccYE2
	G6H8mURCIog9lY4PcjcXYBenx9rg91c0A626gPvm98UM+QISf/KvEorWpUma2A==
Content-Type: multipart/signed;
 boundary=c4d98de91abd6d1006b609cb4621827d77940c66045ae6e96f5d64cd32ef;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 11 Sep 2025 10:26:03 +0200
Message-Id: <DCPTTD0NKOE6.1HKQ87ESFOT6D@cknow.org>
Cc: "Ulf Hansson" <ulf.hansson@linaro.org>, "Heiko Stuebner"
 <heiko@sntech.de>, "Rafael J . Wysocki" <rafael@kernel.org>, "Tomi
 Valkeinen" <tomi.valkeinen@ideasonboard.com>, "Thierry Reding"
 <thierry.reding@gmail.com>, "Saravana Kannan" <saravanak@google.com>,
 "Sebastian Reichel" <sebastian.reichel@collabora.com>, "Jonathan Hunter"
 <jonathanh@nvidia.com>, <linux-rockchip@lists.infradead.org>, "Konrad
 Dybcio" <konradybcio@kernel.org>, "Peng Fan" <peng.fan@oss.nxp.com>,
 <linux-pm@vger.kernel.org>, "Johan Hovold" <johan@kernel.org>, "Sebin
 Francis" <sebin.francis@ti.com>, "Michal Simek" <michal.simek@amd.com>,
 <linux-arm-kernel@lists.infradead.org>, "Maulik Shah"
 <maulik.shah@oss.qualcomm.com>, "Stephen Boyd" <sboyd@kernel.org>, "Bjorn
 Andersson" <andersson@kernel.org>, "Christian Hewitt"
 <christianshewitt@gmail.com>, <linux-kernel@vger.kernel.org>, "Abel Vesa"
 <abel.vesa@linaro.org>, "Nicolas Frattaroli"
 <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH 0/5] pmdomain: Restore behaviour for disabling unused PM
 domains
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
References: <20250909111130.132976-1-ulf.hansson@linaro.org>
 <DCPDDIZ3S1CM.3DJYY5U4T6V4U@cknow.org>
 <CAMuHMdVxjOLZsas4+nmAkZjbJsQjxdkZvZ8tTY9pq2zz3gvFNQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVxjOLZsas4+nmAkZjbJsQjxdkZvZ8tTY9pq2zz3gvFNQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

--c4d98de91abd6d1006b609cb4621827d77940c66045ae6e96f5d64cd32ef
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Geert,

On Thu Sep 11, 2025 at 9:18 AM CEST, Geert Uytterhoeven wrote:
> On Wed, 10 Sept 2025 at 21:33, Diederik de Haas <didi.debian@cknow.org> w=
rote:
>> On Tue Sep 9, 2025 at 1:11 PM CEST, Ulf Hansson wrote:
>> > Recent changes to genpd prevents those PM domains being powered-on dur=
ing
>> > initialization from being powered-off during the boot sequence. Based =
upon
>> > whether CONFIG_PM_CONFIG_PM_GENERIC_DOMAINS_OF is set of not, genpd re=
lies
>> > on the sync_state mechanism or the genpd_power_off_unused() (which is =
a
>> > late_initcall_sync), to understand when it's okay to allow these PM do=
mains
>> > to be powered-off.
>> >
>> > This new behaviour in genpd has lead to problems on different platform=
s [1].
>> >
>> > In this series, I am therefore suggesting to restore the behavior of
>> > genpd_power_off_unused() along with introducing a new genpd config fla=
g,
>> > GENPD_FLAG_NO_STAY_ON, to allow genpd OF providers to opt-out from the=
 new
>> > behaviour.
>>
>> Is it expected that I'm still seeing this on a Rock64 (rk3328), just
>> like before [1]?
>>
>>   [   17.124202] rockchip-pm-domain ff100000.syscon:power-controller: sy=
nc_state() pending due to ff300000.gpu
>>   [   17.129799] rockchip-pm-domain ff100000.syscon:power-controller: sy=
nc_state() pending due to ff350000.video-codec
>>   [   17.140003] rockchip-pm-domain ff100000.syscon:power-controller: sy=
nc_state() pending due to ff360000.video-codec
>
> Yes, as the sync state is still blocked on them.
> Disabling unused PM Domains is done independently of sync state.
>
>> This is with a 6.17-rc5 kernel with this patch set applied.
>> And it also has this patch from Christian Hewitt added, now in v3:
>> https://lore.kernel.org/linux-rockchip/20250906120810.1833016-1-christia=
nshewitt@gmail.com/
>>
>> When I boot into a 6.17-rc5 kernel without any patches applied, I do get
>> the 2 for ff350000.video-codec and ff360000.video-codec, but not the
>> ff300000.gpu one.
>>
>> Interestingly:
>> ff300000.gpu -> power-domains =3D <&power RK3328_PD_GPU>;
>> ff350000.video-codec -> power-domains =3D <&power RK3328_PD_VPU>;
>> ff360000.video-codec -> power-domains =3D <&power RK3328_PD_VIDEO>;
>>
>> I would be surprised if that was a coincidence.
>
> Fw_devlinks ignores the index cell (RK3328_PD_*), hence all links are
> created pointing to the pmdomain controller (in case it has a platform
> driver) or the first pmdomain (in case it has not). thus blocking the
> sync state call and power-down for _all_ pmdomains managed by the
> controller.

I don't think I fully understand this (not your problem due to lack of
knowledge on my part), but you mentioning 'fw_devlink' rang a bell.

Some time ago Nicolas Frattaroli and I worked on an image for PINE64's
*Quartz* devices and that added ``fw_devlink=3Doff`` to cmdline.
I've been using it on all my Rockchip based devices, without
understanding that parameter ... but (apparently) on my 'rock64-test'
device, where I tested it with, I had removed that parameter.
Putting that parameter back ... and those warnings are gone!

Thanks a LOT for that hint!

Groetjes,
  Diederik

--c4d98de91abd6d1006b609cb4621827d77940c66045ae6e96f5d64cd32ef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaMKHoQAKCRDXblvOeH7b
bo6/AQDBs8RXL9MZybJJhHinLOCxYw9QduO4Nxl/I3V6lRVjfgD/cp0KvoFONOMG
zBh0Hr6do6+m3BaFnV2rsF15IgfvlAg=
=3jJl
-----END PGP SIGNATURE-----

--c4d98de91abd6d1006b609cb4621827d77940c66045ae6e96f5d64cd32ef--

