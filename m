Return-Path: <linux-pm+bounces-30888-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 441D2B0687D
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 23:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847671AA2DFB
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 21:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AA82C08CA;
	Tue, 15 Jul 2025 21:22:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch [79.135.106.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A908E29B8FE;
	Tue, 15 Jul 2025 21:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752614526; cv=none; b=aYPBqzxBJwN2ZHfeNjvjvlDuygLa/YX3PoimFMpeE1Q50kJcSBgsizvwkEHESLU6coUm/LpIeK6MFQiRl6j+mfC1t00gldGy83bk4Ac8oZ/85OGFV8CsQE44hdkP9jo13yNQ/5VSX9SX/z548g6DafUtYL5y6fAFn2o9MbH+d6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752614526; c=relaxed/simple;
	bh=ccihsU7z/I3o3Tj/GXVuFzsMa+uleE0LoTZ4FzZJG+E=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S2CL5fP1S54225G+8G4Ld6AcKguzdi6stZjOHFi75LhZQtF0Mazbj7i7IUmbw/lIFLpsbqSratf7aRDO2IXG7frT/qtowZQLUMJ7dQbUbvRA2mFIBzreLTPE7rJnzAd3QV4zf4Zzhe6wwfVrrVtHSSYxeyBRsCPnBVFj4gQghWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benis.se; spf=pass smtp.mailfrom=benis.se; arc=none smtp.client-ip=79.135.106.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benis.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benis.se
Date: Tue, 15 Jul 2025 21:21:47 +0000
To: "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "rb_eddie@gmx.de" <rb_eddie@gmx.de>
From: =?utf-8?Q?Benjamin_Hasselgren-Hall=C3=A9n?= <benjamin@benis.se>
Subject: Re: HP Omnibook Ultra Flip 14 - power profiles
Message-ID: <uMaym4_Ormig3mc0gI68IC_FG-RmlbVjPBw5DziE3oJdvE9uQrbc-YEOz07Ex095ire8qERne3oNb8Vq1hyKkggKqQP5TIEfIkvJZiycw7w=@benis.se>
In-Reply-To: <Hsi54U41U6V6LB65SJ9b8D_q4OsW-xsvWJSQmvmxo7EfsebwJKc6NnNHLO20CerbcNGL-Q8huoeWtzNuGsCVNrQvJW8ndwTdnIKZJIDbTjg=@benis.se>
References: <GXa7F-PA_8BE7nlK9r8dkdSv7c-DW52GvOUiyYHQ6RyoZDxIpNAocWDPYQDeS7WEZeUisqQH_bqmgSV-eaRmuw5r68MGKxyU9X_4Erd0RYQ=@benis.se> <X-40AqXfdmQw5shUOk3VSaHSXmwJYWHPmDDMLyGUH6GpMt56ty5SbNg8EVfyI_uC9J07uqZ2TtGJmmpB_x8-xpcVOw29fnKzJZ4n9L0x78A=@benis.se> <9439ec38-aadd-4aac-ba51-a8786ba50239@gmx.de> <3b25e59bc1b162ee8f43ffbd3c50589a52d540af.camel@intel.com> <rFJU7KbF6iq0CxJtSjPu4vLVjWata5hY1Kl-wOv253p0C2W7egJQQrkUnkSqmr1vXDXeTwwtwp0u5ZnQU6pZmPuJ7TnNBVgudMG-q5MRHyM=@benis.se> <c6Eep72y6E7gc-wUMdcIS9JfNN1_OBjlwGUrd4yGvp2R-PW2-OOoQngQt5H5kiZIccxFAPswaN9G6wVpHuewtoEvUkT52UCzHPibVJh7iYY=@benis.se> <65f3a229f70279ab0da7efa878b863c7798d4427.camel@intel.com> <uWQ7r_hhvTbLE0QDEfkt_V2Mf39SRnexnRQCZ8lrUv3hDKfAK1jpr5AeVug8wBfz3cDhu-bYnx9zvCoU5Ch-AMaVlQHwqPmZgn3a4OMRek8=@benis.se> <1e02c8f28200d8e3f27589e0ba75a67f2e99d1a4.camel@intel.com> <Hsi54U41U6V6LB65SJ9b8D_q4OsW-xsvWJSQmvmxo7EfsebwJKc6NnNHLO20CerbcNGL-Q8huoeWtzNuGsCVNrQvJW8ndwTdnIKZJIDbTjg=@benis.se>
Feedback-ID: 18592338:user:proton
X-Pm-Message-ID: 5c3e45ea066e31fafe991ee0d7c029aa07952345
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Looping in another Omnibook Ultra Flip user.



Best regards,
Benjamin Hasselgren-Hall=C3=A9n


On Monday, 7 July 2025 at 21:55, Benjamin Hasselgren-Hall=C3=A9n <benjamin@=
benis.se> wrote:

>=20
>=20
>=20
>=20
> Best regards,
> Benjamin Hasselgren-Hall=C3=A9n
>=20
>=20
>=20
>=20
> On Wednesday, 2 July 2025 at 10:00, Zhang, Rui rui.zhang@intel.com wrote:
>=20
> > Remove the list as I want to grab more details.
> >=20
> > On Tue, 2025-07-01 at 07:44 +0000, Benjamin Hasselgren-Hall=C3=A9n wrot=
e:
> >=20
> > > with thermald
> > > https://drive.benis.se/s/bF5AfDGBw6DFNZt
> > >=20
> > > without thermald
> > > https://drive.benis.se/s/47xJdg33ayHerDF
> >=20
> > There is no much difference, which is expected.
> >=20
> > > journald
> > > https://drive.benis.se/s/8JdDJG2bFbHeDmz
> >=20
> > The log doesn't have anything useful.
> > It shows your last launch of thermald failed
> >=20
> > Jul 01 09:38:36 computer thermald[10950]: Couldn't get lock file 10950
> > Jul 01 09:38:36 computer thermald[10950]: An instance of thermald is
> > already running, exiting ...
> >=20
> > BTW, when do you start to hear the fan spinning? upon changing platform
> > profile? upon launching thermald?
> > is there anyway to figure out what fan device brings this noise?
>=20
>=20
> I can get the fans starting by activating performance and do any work mor=
e or less.
>=20
> I have thermald enabled all the time now. I think that as long as I don't=
 have the fans active while suspending - it's fine.
>=20
> > -rui

