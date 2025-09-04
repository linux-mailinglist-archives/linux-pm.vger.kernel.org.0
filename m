Return-Path: <linux-pm+bounces-33831-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2F8B43BA8
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 14:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0330A3B01F9
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 12:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521FE2F1FC4;
	Thu,  4 Sep 2025 12:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="pNDj5LQn"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1580F2E7620
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 12:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756989188; cv=none; b=kuB5Sh9WKYtpypbzA6DPP+s9qjZjnc4icfHU4vVOujsXY/VPWJNm7jbFIib2J58PE4MgfvpZ/eKPKN4pc+lp9E774AjmZRzaBYobjCIrvP2j83GYU8rYC2P2AdhYJT7Ysq3LP7Xq6D8PXToIaebk8m4rU4N0PFxzBPmStoSqLZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756989188; c=relaxed/simple;
	bh=EvgRjlE+UWMAKJNfo2NliYYKTjoNOug9KRxSjsUmWG4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=I3aNtJTKyIy7RjYj89GaxH/GMiLfqfZ6hvgjGyLAa6OqP1KuWl91nPOjv2FbYS1i5by/Eb4PHZLKlCGz7kxYzm+rvsJNINMltFPnmqxh6xOzhSvINlW0aczH6Ng7l25RmzixmOGHfMLruWeGlW28w8g69S5PB5thX0I4BcEz1Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=pNDj5LQn; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1756989172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t2b8f0HG/g1hoFjQFsW6ldfZjYHSPM9qpQZoCdYE2fI=;
	b=pNDj5LQn02gwPbCkqTgYS6OnB71G069FSFeB8Zv8pa+rN1xBDdPLJF1mFYnXsMdxLyBWVZ
	fTwNrgjYreSARsOx7PSvZBYeSv1szZqCT7EtKiaOGP3dCRmlLKYCSARrk1IRnIrNCilDl/
	nxTDX//FzBW34b4q3DQbeKaLOlagL1WhJtKvQVrQ5hqhKoGinRm4xf9or7nQZAaHnInDSo
	GhiOA3qKdn93hAlejWcD9tsASqkNuoFHd0aQSFXbHO1HnkPn1lCeDDsFupe3nGpr8FJ0p9
	FTmo/FrDrr4FwN0+GVKaUiXgQEdKQ9Woi0TDiD8tKxTCsLnGiKLxKUqVQcKsPQ==
Content-Type: multipart/signed;
 boundary=3849e3abccc41c0afb77643d48c9c411b54c55e1791606530e9b10577404;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 04 Sep 2025 14:32:31 +0200
Message-Id: <DCK0O99SYSCF.BMBAEUV24C1G@cknow.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Ulf Hansson" <ulf.hansson@linaro.org>, "Sebin Francis"
 <sebin.francis@ti.com>, "Saravana Kannan" <saravanak@google.com>
Cc: "Stephen Boyd" <sboyd@kernel.org>, <linux-pm@vger.kernel.org>, "Rafael J
 . Wysocki" <rafael@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Michael Grzeschik"
 <m.grzeschik@pengutronix.de>, "Bjorn Andersson" <andersson@kernel.org>,
 "Abel Vesa" <abel.vesa@linaro.org>, "Peng Fan" <peng.fan@oss.nxp.com>,
 "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>, "Johan Hovold"
 <johan@kernel.org>, "Maulik Shah" <maulik.shah@oss.qualcomm.com>, "Michal
 Simek" <michal.simek@amd.com>, "Konrad Dybcio" <konradybcio@kernel.org>,
 "Thierry Reding" <thierry.reding@gmail.com>, "Jonathan Hunter"
 <jonathanh@nvidia.com>, "Hiago De Franco" <hiago.franco@toradex.com>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-rockchip@lists.infradead.org>, "Nicolas Frattaroli"
 <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH v3 00/24] pmdomain: Add generic ->sync_state() support
 to genpd
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
 <97231ac9-5cde-49bf-931b-d5baf6d2d2d1@ti.com>
 <CAPDyKFr8AYuS2aEVs8X2As1NzXnbea4rPLKiF5=fKjq=PAeZgg@mail.gmail.com>
In-Reply-To: <CAPDyKFr8AYuS2aEVs8X2As1NzXnbea4rPLKiF5=fKjq=PAeZgg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

--3849e3abccc41c0afb77643d48c9c411b54c55e1791606530e9b10577404
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Wed Sep 3, 2025 at 12:33 PM CEST, Ulf Hansson wrote:
> On Wed, 3 Sept 2025 at 09:39, Sebin Francis <sebin.francis@ti.com> wrote:
>> On 01/07/25 17:17, Ulf Hansson wrote:
>> >
>> > If a PM domain (genpd) is powered-on during boot, there is probably a =
good
>> > reason for it. Therefore it's known to be a bad idea to allow such gen=
pd to be
>> > powered-off before all of its consumer devices have been probed. This =
series
>> > intends to fix this problem.
>> >
>> > We have been discussing these issues at LKML and at various Linux-conf=
erences
>> > in the past. I have therefore tried to include the people I can recall=
 being
>> > involved, but I may have forgotten some (my apologies), feel free to l=
oop them
>> > in.
>> >
>> > Please help review and test!
>>
>> During testing on a TI platform, I observed new kernel warnings after
>> applying this patch series:
>>
>> ti_sci_pm_domains 44043000.system-controller:power-controller:
>> sync_state() pending due to fd00000.gpu
>>
>> These warnings occur when a device (in this case, the GPU) has no driver
>> bound to it. The fw_devlink_dev_sync_state[0] in the core has a check
>> before printing this warning. It checks whether the device driver has a
>> sync_state handler OR the device bus has a sync_state handler in the
>> dev_has_sync_state[1]. If both conditions are false,
>> fw_devlink_dev_sync_state[0] performs an early return before printing
>> the warning.
>>
>> Before this patch series, both handlers were absent for device driver
>> ti_sci_pm_domains and the device bus, so both conditions failed and no
>> warnings were printed.
>>
>> This patch series adds a sync_state handler for the bus, which now
>> satisfies the second condition. So it doesn't do an early return and
>> proceeds to print the warning.
>
> Thanks for the report and testing!
>
> Indeed this is the new and expected behaviour. I agree that it's
> certainly questionable if those prints should be at the warning level.
>
> We should probably downgrade those to dev_info(), at least. Let me
> send a patch to see what Saravana and others are thinking about it!

I want to report that I see similar warnings on Rock64 (rk3328):

[   16.868033] rockchip-pm-domain ff100000.syscon:power-controller: sync_st=
ate() pending due to ff300000.gpu
[   16.873637] rockchip-pm-domain ff100000.syscon:power-controller: sync_st=
ate() pending due to ff350000.video-codec
[   16.896495] rockchip-pm-domain ff100000.syscon:power-controller: sync_st=
ate() pending due to ff360000.video-codec

This is with a 6.17-rc3 kernel with various rkvdec patches and in dmesg
I later see msgs wrt ff300000.gpu (lima) and ff350000.video-codec
(hantro-vpu), but not ff360000.video-codec (rkvdec). Full dmesg:
https://paste.sr.ht/~diederik/951b54ea8422756e5efaa61d6bcefb575cfe28a4

But there were also USB issues (not sure why), so I rebooted and then I
did see msgs wrt rkvdec. Full dmesg:
https://paste.sr.ht/~diederik/156f65fc6be05d02484568dfd303c46ba76b3a8e

I also have a 6.17-rc4 kernel which is clean upstream, thus without any
media patches. This time no USB issues (also no USB device plugged in)
and I see msgs wrt lima and hantro-vpu, but not rkvdec. Full dmesg:
https://paste.sr.ht/~diederik/4affea034b0c9fb522a8ad5b90e8b59b4bd856ec

What's possibly relevant is that the 6.17-rc3+unreleased kernel also has
this patch added, which adds 'power-domain@RK3328_PD_GPU' to rk3328.dtsi
https://lore.kernel.org/linux-rockchip/20250830115135.3549305-1-christiansh=
ewitt@gmail.com/

I actually found this thread because I too couldn't find the commit ID
Nicolas referenced in this post:
https://lore.kernel.org/linux-rockchip/20250902-rk3576-lockup-regression-v1=
-1-c4a0c9daeb00@collabora.com/

I have no idea whether it's related though (I have no rk3576 device).

I haven't tried (yet) whether the sync_state() msg is also present on
other Rockchip based devices.

Cheers,
  Diederik

--3849e3abccc41c0afb77643d48c9c411b54c55e1791606530e9b10577404
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaLmG7AAKCRDXblvOeH7b
bmNxAP98YqXu31TFsZ7u3hLkIg/dojp3TfbfPSnZQ210fn86QAEA6SRKOyVWiXD5
4U+jLG4fAp2k3YuPI+j23ijX0Oum7QA=
=us0u
-----END PGP SIGNATURE-----

--3849e3abccc41c0afb77643d48c9c411b54c55e1791606530e9b10577404--

