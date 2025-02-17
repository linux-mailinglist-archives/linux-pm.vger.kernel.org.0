Return-Path: <linux-pm+bounces-22257-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 106D5A38DAA
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 21:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE1AB7A2D34
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 20:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8CE238D35;
	Mon, 17 Feb 2025 20:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="1HrXNtcE"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DC4236A8E;
	Mon, 17 Feb 2025 20:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739825473; cv=none; b=IgslZPTcL5k8FWrpNh+dKRfIAk7TnkLRhbtL7howw55AzX8lGuc+gqwqCCj+MMX652RgWJuRMH/vSbBi6zFFClfaEo/j3Hz/NgJYo+E1ha9seHRs9CzAzRFsK6p3MA0vMmPy7lXD/xkFquHs5KHF8gdFsJv87NcHZCMLur9XbyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739825473; c=relaxed/simple;
	bh=+Tneczc/gt5KlRww9DciWgCPYL3QAZCwMLLyT/8V2j0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qixh+6E9Yj6yT7Jwm0hdvJ4EiPP3ouz9RPWK4gkVCahr0zwWvcYZ78roZ5Ek9tg3yOMpBu0wCAPuH5y10Il6QbU3/80Ix2r3YZ7Ez/bzNgwl7lxtfBycEJdsbVLcD5XfP22eEU246OED+WKJx3BL/vRczTiZfBDGJ/n4yvpzFfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=1HrXNtcE; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IXt480Abf0JotZYaVu+nX5d1RPwKRi9f0QFxpN31t9o=; b=1HrXNtcEjiR4bI/hrUHfyTpuhJ
	JT2f8Hm5aC5Y/0l7nCoyzBbotkZhQ7OROX38ne58/OFkBnRPaSeXptNjbhwlw1D4o6uqn7Ez0QTwI
	Amcl3Y0SrStBGHHF9206aYqM2BlWfISLru8f6p7nqxKlBKA8TQZZQRA5nsVxe/vruEt3iYDoLECzQ
	0l+zVtVQX07NQT/ev66Ym2F5SXmnt1oL6J6HiCk0SKPICdWg4x+fxBugyxONOFRFv+L22cYjlVgBl
	+xOzIRAWIDC/hT9Z8L59yh79gpowPwq7xVF68zLODFHni7MLvIhhQnFqQCEsOhCsvXQGElyMsf4lk
	+TAGLl9w==;
Received: from i53875bc0.versanet.de ([83.135.91.192] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tk84i-0007CW-1Y; Mon, 17 Feb 2025 21:50:44 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Shawn Lin <shawn.lin@rock-chips.com>, Rob Herring <robh+dt@kernel.org>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Steven Price <steven.price@arm.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>, YiFeng Zhao <zyf@rock-chips.com>,
 Liang Chen <cl@rock-chips.com>, linux-scsi@vger.kernel.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject:
 Re: [PATCH v7 4/7] pmdomain: rockchip: Add smc call to inform firmware
Date: Mon, 17 Feb 2025 21:50:42 +0100
Message-ID: <5649637.F8r316W7xa@diego>
In-Reply-To: <321804ef-f852-47cf-afd7-723666ec8f62@arm.com>
References:
 <1738736156-119203-1-git-send-email-shawn.lin@rock-chips.com>
 <2579724.BzM5BlMlMQ@diego> <321804ef-f852-47cf-afd7-723666ec8f62@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Montag, 17. Februar 2025, 18:10:32 MEZ schrieb Steven Price:
> On 17/02/2025 15:16, Heiko St=C3=BCbner wrote:
> > Hi Steven,
> >=20
> > Am Montag, 17. Februar 2025, 15:47:21 MEZ schrieb Steven Price:
> >> On 05/02/2025 06:15, Shawn Lin wrote:
> >>> Inform firmware to keep the power domain on or off.
> >>>
> >>> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> >>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> >>> ---
> >>
> >> This patch is causing my Firefly RK3288 to fail to boot, it hangs=20
> >> shortly after reaching user space, but the bootup messages include the=
=20
> >> suspicious line "Bad mode in prefetch abort handler detected".
> >> I suspect the firmware on this board doesn't support this new SMC=20
> >> correctly. Reverting this patch on top of linux-next gets everything=20
> >> working again.
> >=20
> > Is your board actually running some trusted firmware?
>=20
> Not as far as I know.
>=20
> > Stock rk3288 never had tf-a / psci [0], I did work on that for a while,
> > but don't think that ever took off.
> >=20
> > I'm wondering who the smcc call is calling, but don't know about
> > about smcc stuff.
>=20
> Good question - it's quite possible things are blowing up just because
> there's nothing there to handle the SMC. My DTB is as upstream:
>=20
>         cpus {
>                 #address-cells =3D <0x01>;
>                 #size-cells =3D <0x00>;
>                 enable-method =3D "rockchip,rk3066-smp";
>                 rockchip,pmu =3D <0x06>;
>=20
> I haven't investigated why this code is attempting to call an SMC on
> this board.

I guess the why is easy, something to do with suspend :-) .

I did go testing a bit, booting a rk3288-veyron produces the same issue
you saw, likely due to the non-existent trusted-firmware.

On the arm64-side, I tried a plethora of socs + tfa-versions,

  rk3328: v2.5 upstream(?)-tf-a
  rk3399: v2.9 upstream-tf-a
  px30: v2.4+v2.9 upstream-tf-a
  rk3568: v2.3 vendor-tf-a
  rk3588: v2.3 vendor-tf-a

and all ran just fine.
So it really looks like the smcc call going to some unset location is
the culprit.

Looking at other users of arm_smcc_smc, most of them seem to be handled
unguarded, but some older(?) arm32 boards actually check their DTs for an
optee node before trying their smc-call.

I guess in the pm-domain case, we could just wrap the call with:
	if(arm_smccc_1_1_get_conduit() !=3D SMCCC_CONDUIT_NONE)

I've checked in my boards now, and all the boards mentioned above seem
to handle this well with smccc-versions of at least 0x10002 .

Heiko



