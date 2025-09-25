Return-Path: <linux-pm+bounces-35405-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B350BA0F53
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 19:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120EF17D572
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 17:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4708030FC0C;
	Thu, 25 Sep 2025 17:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="EMq1VUNs"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DB51DE3DC
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758822755; cv=none; b=BHl2Ze8OIY3DNdL9MWTN5h5oW5iAyYQIh6V66iwvyk+a8rKBb65+tBsbW2M+uM7tbMGXbalwHRjSu2LHVdrTp7gvPQ4ad+S6S58hf6ko15iVuQunb+VK4XOeJT1t5HkQI1G5Jig4SCoSCj9aSMaToo4UIfw9i3gtX912JHCC0Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758822755; c=relaxed/simple;
	bh=149LhYTDHLpLp8554BrUviuksAp+figbNKDZxF/5+IM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=I5l+8U9Bvi0ktLazCoMNrOnTTsXHx4xrjx/BWhvBtp0hdDGLenXc+BDFhfLw08QrzQqfx5XrdXOtgSJP7RwxtwuRppjaWX9ytBfWGpevzsaFjl6i/NIbjYO/gk64Bm+iIOcULsbEMhGRZFqZ5AnnQ4ZUgCnOnKyd/WyBHDUKkIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=EMq1VUNs; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1758822747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IB9yQNRgVuz8m2m/oI2qa6ls/IWIUCOFdQtE6J/rfIA=;
	b=EMq1VUNsJcP9snVahb7nKoWpXIaDE41gqDWsbAG4yWY8Rnu1rMo2FDoiKi/9dfZarIh/+m
	LL+7sHuW/hw2dFQgEiTMq8vIfTKXyby5P9trym8R8wVkzGXGV+/2ggIAG+J8T2nqPOeWCx
	I9ulU++zscOBm+xM54yiJckom9/K9rvw6go4Wjs40pw0Q66AUVt3DsUEhXU5UnpNatT2sH
	qew11Tjar4NMmOBj2Ro8RcgCmPRTE9RYc+st28XVeUMh4kruDtkgh0Xjzs/qFt1sWHCd8Z
	zDJY9AO0tox9pwPXH+P2KTHVOaFxbGFCWZyv0V/fjzMbVfcJrR+53XJ2McAOEg==
Content-Type: multipart/signed;
 boundary=a357dd026792ca33492dc6fb0c6b8bf0ccfe6b9c80285818675682e9f5be;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 25 Sep 2025 19:52:11 +0200
Message-Id: <DD22MGF3HNLM.Q7S70RX4NZXS@cknow.org>
Cc: "Saravana Kannan" <saravanak@google.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <linux-pm@vger.kernel.org>, "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>, "Heiko Stuebner"
 <heiko@sntech.de>, "Sebastian Reichel" <sebastian.reichel@collabora.com>,
 "Sebin Francis" <sebin.francis@ti.com>, "Tomi Valkeinen"
 <tomi.valkeinen@ideasonboard.com>, "Jon Hunter" <jonathanh@nvidia.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] driver core: fw_devlink: Don't warn in
 fw_devlink_dev_sync_state()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Ulf Hansson" <ulf.hansson@linaro.org>
References: <20250925115924.188257-1-ulf.hansson@linaro.org>
 <DD1XOHE6P5OC.2JUQRAGAE1KTU@cknow.org>
 <CAPDyKFrKP2bdpKTHzqDdhEpRAjYu+PFd2Bst=-WPddByxcAX_w@mail.gmail.com>
In-Reply-To: <CAPDyKFrKP2bdpKTHzqDdhEpRAjYu+PFd2Bst=-WPddByxcAX_w@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

--a357dd026792ca33492dc6fb0c6b8bf0ccfe6b9c80285818675682e9f5be
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Sep 25, 2025 at 4:26 PM CEST, Ulf Hansson wrote:
> On Thu, 25 Sept 2025 at 15:59, Diederik de Haas <didi.debian@cknow.org> w=
rote:
>> On Thu Sep 25, 2025 at 1:59 PM CEST, Ulf Hansson wrote:
>> > Due to the wider deployment of the ->sync_state() support, for PM doma=
ins
>> > for example, we are receiving reports about the messages that are bein=
g
>> > logged in fw_devlink_dev_sync_state(). In particular as they are at th=
e
>> > warning level, which doesn't seem correct.
>> >
>> > Even if it certainly is useful to know that the ->sync_state() conditi=
on
>> > could not be met, there may be nothing wrong with it. For example, a d=
river
>> > may be built as module and are still waiting to be initialized/probed.
>>
>> "there may be nothing wrong with it" doesn't sound very convincing.
>> So there *can* be something wrong with it, so warning sounds
>> appropriate? If there is (certainly) something wrong with it, I expect
>> an error.
>
> Sorry if I was too vague. See more below.
>
>> FWIW: most of my drivers/modules are built as modules.
>> I do seem to run into 'problems' more then average because of that, but
>> to me it just signals there is something wrong ... which should be
>> fixed. Not silenced.
>
> Well, why is it wrong to have drivers being built as modules? They

Nothing wrong with it at all. It just means I notice issues (like [1])
that others may not who have modules built-in.

[1] a52dffaa46c2 ("drm/rockchip: vop2: make vp registers nonvolatile")

> just happen to be probed at some point later, then why should we have
> warnings printed in the log due to this?

I thought the failure of the check was more important then it apparently
is. Then warning about it does seem excessive.

Cheers,
  Diederik

--a357dd026792ca33492dc6fb0c6b8bf0ccfe6b9c80285818675682e9f5be
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaNWBUwAKCRDXblvOeH7b
bhxxAQCeedjuz7MzbGyk41Q/ap7bH+8LHheMRHyOxpn9SezY7AD+KZApBH0xFnE/
3+O2yoRG+dre2ZIK4DMmnaaZXvwd8QM=
=3Rfs
-----END PGP SIGNATURE-----

--a357dd026792ca33492dc6fb0c6b8bf0ccfe6b9c80285818675682e9f5be--

