Return-Path: <linux-pm+bounces-31352-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A55B0FC10
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 23:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 510F33B221F
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 21:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1394826CE06;
	Wed, 23 Jul 2025 21:18:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-10627.protonmail.ch (mail-10627.protonmail.ch [79.135.106.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37502E630
	for <linux-pm@vger.kernel.org>; Wed, 23 Jul 2025 21:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753305526; cv=none; b=RdCS0t1tIhcxkwAtqdmWunZ0E8R+CkKZaNYBGZ99hJgdangzgHQOwsase/CF9gIcDtkImi1CkMiWzlCXuTjoS2qnrzoOb08lkWd5SACTYJiedKCpdi34yarjk/b87l47X1EzMcYXAzPFGiTdsqZgcWDlXHuZs41ezubSJWmxzis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753305526; c=relaxed/simple;
	bh=J2tpsNAN4YouiCdT8HlOy9Ov2FMrrrnomDYc7jQI7XI=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NbCLUSWkIoKLHFcuTQHtQVpUK1w0ZFdJi8JiiataitJ5A6e1tXv3Ymv8e5jO/gfxWqvMn8zVHvFFFgKjyh5KxN8ffbB3SyRqYZHnD9MeDQ3U200AwHQC38l/3cG83pu4Vsum/Nti2BrJYHaaIDo3RoK3wualFVrhkHhbBLEThSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benis.se; spf=pass smtp.mailfrom=benis.se; arc=none smtp.client-ip=79.135.106.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benis.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benis.se
Date: Wed, 23 Jul 2025 21:18:28 +0000
To: Zhang Rui <rui.zhang@intel.com>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "rb_eddie@gmx.de" <rb_eddie@gmx.de>
From: =?utf-8?Q?Benjamin_Hasselgren-Hall=C3=A9n?= <benjamin@benis.se>
Subject: Re: HP Omnibook Ultra Flip 14 - power profiles
Message-ID: <gdnDL7F3vIUJb30OIR1QyUq62Ay5VuPVacHQqeUkcppX4BW24bZLyoo-MLHZxeqGC5ruRusZXHdSOkqXNCDXN_Hd9IesxQCEeyHDGWg3Ggs=@benis.se>
In-Reply-To: <DqXuw9FIzvFuEW5CDi99thtdm42SH5iuKR5I50--iorP_jQCHWp0oesB906P5h98VBmYupvqGfDiEZ0er2wCYoFib77wDazJOOK0eOk2CZo=@benis.se>
References: <GXa7F-PA_8BE7nlK9r8dkdSv7c-DW52GvOUiyYHQ6RyoZDxIpNAocWDPYQDeS7WEZeUisqQH_bqmgSV-eaRmuw5r68MGKxyU9X_4Erd0RYQ=@benis.se> <c6Eep72y6E7gc-wUMdcIS9JfNN1_OBjlwGUrd4yGvp2R-PW2-OOoQngQt5H5kiZIccxFAPswaN9G6wVpHuewtoEvUkT52UCzHPibVJh7iYY=@benis.se> <65f3a229f70279ab0da7efa878b863c7798d4427.camel@intel.com> <uWQ7r_hhvTbLE0QDEfkt_V2Mf39SRnexnRQCZ8lrUv3hDKfAK1jpr5AeVug8wBfz3cDhu-bYnx9zvCoU5Ch-AMaVlQHwqPmZgn3a4OMRek8=@benis.se> <1e02c8f28200d8e3f27589e0ba75a67f2e99d1a4.camel@intel.com> <Hsi54U41U6V6LB65SJ9b8D_q4OsW-xsvWJSQmvmxo7EfsebwJKc6NnNHLO20CerbcNGL-Q8huoeWtzNuGsCVNrQvJW8ndwTdnIKZJIDbTjg=@benis.se> <4d0e07edfa83653fa8330e08fb4520f07bb38448.camel@intel.com> <tZDJlprhLriFb89pD_hEuI9r5MWf8J43NSBBtSwijh3tXJUCrr0TJxKw3nR3_YvAbvnyxdNP6hktgiEQdQmNH2vv_fFyqbwzWf8gd6w91EM=@benis.se> <DqXuw9FIzvFuEW5CDi99thtdm42SH5iuKR5I50--iorP_jQCHWp0oesB906P5h98VBmYupvqGfDiEZ0er2wCYoFib77wDazJOOK0eOk2CZo=@benis.se>
Feedback-ID: 18592338:user:proton
X-Pm-Message-ID: 3377f325f1517f347267b26f5491c9140ddd9e3a
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I got tips from Eddie (on CC) about https://github.com/horshack-dpreview/se=
tPL and it seems to get the cpu to boost higher, I think. However, the gpu =
still downclocks way more on Linux than Windows.



Best regards,
Benjamin Hasselgren-Hall=C3=A9n


On Saturday, 19 July 2025 at 22:38, Benjamin Hasselgren-Hall=C3=A9n <benjam=
in@benis.se> wrote:

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
> On Saturday, 19 July 2025 at 22:19, Benjamin Hasselgren-Hall=C3=A9n benja=
min@benis.se wrote:
>=20
> > Best regards,
> > Benjamin Hasselgren-Hall=C3=A9n
> >=20
> > On Thursday, 17 July 2025 at 03:15, Zhang, Rui rui.zhang@intel.com wrot=
e:
> >=20
> > > On Mon, 2025-07-07 at 19:55 +0000, Benjamin Hasselgren-Hall=C3=A9n wr=
ote:
> > >=20
> > > > Best regards,
> > > > Benjamin Hasselgren-Hall=C3=A9n
> > > >=20
> > > > On Wednesday, 2 July 2025 at 10:00, Zhang, Rui rui.zhang@intel.com
> > > > wrote:
> > > >=20
> > > > > Remove the list as I want to grab more details.
> > > > >=20
> > > > > On Tue, 2025-07-01 at 07:44 +0000, Benjamin Hasselgren-Hall=C3=
=A9n wrote:
> > > > >=20
> > > > > > with thermald
> > > > > > https://drive.benis.se/s/bF5AfDGBw6DFNZt
> > > > > >=20
> > > > > > without thermald
> > > > > > https://drive.benis.se/s/47xJdg33ayHerDF
> > > > >=20
> > > > > There is no much difference, which is expected.
> > > > >=20
> > > > > > journald
> > > > > > https://drive.benis.se/s/8JdDJG2bFbHeDmz
> > > > >=20
> > > > > The log doesn't have anything useful.
> > > > > It shows your last launch of thermald failed
> > > > >=20
> > > > > Jul 01 09:38:36 computer thermald[10950]: Couldn't get lock file
> > > > > 10950
> > > > > Jul 01 09:38:36 computer thermald[10950]: An instance of thermald=
 is
> > > > > already running, exiting ...
> > > > >=20
> > > > > BTW, when do you start to hear the fan spinning? upon changing
> > > > > platform
> > > > > profile? upon launching thermald?
> > > > > is there anyway to figure out what fan device brings this noise?
> > > >=20
> > > > I can get the fans starting by activating performance and do any wo=
rk
> > > > more or less.
> > > >=20
> > > > I have thermald enabled all the time now. I think that as long as I
> > > > don't have the fans active while suspending - it's fine.
> > >=20
> > > Now I'm confused.
> > > The fan issue is related via platform profile or thermald?
> > >=20
> > > say, after a refresh boot, does the fan spin during suspend when
> > > 1. thermald is NOT activated and platform profile is NOT changed?
> > > 2. thermald is NOT activated and platform profile is changed?
> > > 3. thermald is activated and platform profile is NOT changed?
> > > 4. thermald is activated and platform profile is changed?
> > >=20
> > > Or, what change does it make by switching platform profile only?
> > > what change does it make by activating thermald only?
> >=20
> > The combination of thermald + running the fan while suspending keeps th=
e fan running. Dunno for how long (if it's for ever or just for a while).
> >=20
> > However, thermald helps a bit but the system still under performance qu=
ite a lot.
> >=20
> > I am regulary trying latest kernel + latest linux-firmware but no chang=
es.
> >=20
> > Anything else we can do?
>=20
> I can also add that when thermald is running - the fan i still running wh=
en the cpu is 40c and the power profile is balance. It should not run now.
>=20
> > > thanks,
> > > rui

