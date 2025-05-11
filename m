Return-Path: <linux-pm+bounces-27029-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA75AB2BE6
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 00:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0FCF1896EE1
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 22:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BABC261393;
	Sun, 11 May 2025 22:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="Atm2U0qW"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD494C8E;
	Sun, 11 May 2025 22:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747002169; cv=pass; b=PJsbO/+Gj6PjGx121imzZjG1/9BqTNZGwjXEyNtN5U0xf/y74rS+n8SNG2c36g5ksYMOtuyaa9ZQ6AQucq7RVlvvoSx2Pz1vAeGnzxF7o9V+W1e8PE2WQOTy454PnIKVzgO4dGO8Niozrz0qelLfidxod0EsXJV26kanYx5BiG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747002169; c=relaxed/simple;
	bh=Lnv7Ii66XLDfqZjaLvjsjqQQoy1W95pJ1h+qOWBMaKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrLoP0nmPenXg6R00XqNCMWL8NAFLMtlI5i2O2Y4r/SXWAdqqb5ujEkf4lYOXGUi7vhQdhqS205BnO04GX6l+JM1TFkai32BWW/DjpvQ+WLXNGMNBX2uNgT3ezOvEBvlS9i2PKMpPuYMkdIR9uRLhZmI9lLZieSI6rIbqGH8fK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=Atm2U0qW; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1747002160; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eGDHNjd9Lpfif0ygVD3a/FTJD/BqaGGzqvVpn4gUWN4WZXk3bl44UR05Bz9N2lFd5I5nDA34ie2Av4zEAhpbiVkOqN8IozS18aKiLYgIXDI+sqZb9OrnNsUrh5ZGkOfLyO2zzrV3lU6+l4OmsWrGYnG5rP4BwLjcJow6cubt8UA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1747002160; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vqRqYKU3RZaLR6DMMKinx3g8T5EaSf1Z2YtoAYXORL8=; 
	b=gG8T9l21fKmA8m1PEVW5W2QXcSxmS4KTLyE2bf4CDXqrPx05rG91sfmnpjZB7jU4g+K50B3N4ZB0ofJrL0Bo6rBHUJo6C87G7eNGV6gA9vwwh0bw2LiZnMU0+HWvAVXIUAAqu2CDiVFZVH5GvzOjnzLOb7CZq03H35iV6mDAz9E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747002160;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=vqRqYKU3RZaLR6DMMKinx3g8T5EaSf1Z2YtoAYXORL8=;
	b=Atm2U0qWXzKMgQ+Ugi1d9G74Pp8ku4RWH5DOBcQP/s0rGJpGtpKCMiKtIxYC47vJ
	LoTOYW0z0pV7YbuStBFmnem5klYkwzvxEWFDUlMD6O+2CeK4ga+qDiset5NABM9oF4V
	yOVaYhUXqE8yHiS6RAVWmr0DBAk0ljaiQKP6iJvc=
Received: by mx.zohomail.com with SMTPS id 1747002158118403.54880199775755;
	Sun, 11 May 2025 15:22:38 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id F073E180949; Mon, 12 May 2025 00:22:34 +0200 (CEST)
Date: Mon, 12 May 2025 00:22:34 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] power: supply: core: Add additional health status
 values
Message-ID: <lxcnbavgjikjm5tfrspioi4h5x5owpy6awoeo5zjqu3sn6drja@lzgeipo5rahn>
References: <20250429003606.303870-1-W_Armin@gmx.de>
 <wla5mfgblecq7tiiangrzxv32yjhiru4h6i7nnmn3qvvl6o3ht@j7rbgete42u7>
 <8cb0e0f7-a48e-5770-0c82-f0a75ed23d66@linux.intel.com>
 <ff044893-04bd-84e1-cfc6-842787a8ba54@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ff044893-04bd-84e1-cfc6-842787a8ba54@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

Hi,

On Fri, May 09, 2025 at 01:09:43PM +0300, Ilpo J=E4rvinen wrote:
> On Mon, 5 May 2025, Ilpo J=E4rvinen wrote:
> > On Wed, 30 Apr 2025, Sebastian Reichel wrote:
> > > On Tue, Apr 29, 2025 at 02:36:03AM +0200, Armin Wolf wrote:
> > > > Some batteries can signal when an internal fuse was blown. In suc=
h a
> > > > case POWER_SUPPLY_HEALTH_DEAD is too vague for userspace applicat=
ions
> > > > to perform meaningful diagnostics.
> > > >=20
> > > > Additionally some batteries can also signal when some of their
> > > > internal cells are imbalanced. In such a case returning
> > > > POWER_SUPPLY_HEALTH_UNSPEC_FAILURE is again too vague for userspa=
ce
> > > > applications to perform meaningful diagnostics.
> > > >=20
> > > > Add new health status values for both cases.
> > > >=20
> > > > Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> > >=20
> > > Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> >=20
> > Hi Sebastian,
> >=20
> > Is it okay with you I take this through pdx86 tree?
>=20
> Ping?

I just checked and that's fine. I don't expect any merge issues.

Greetings,

-- Sebastian

>=20
> --=20
>  i.
>=20
> >=20
> > --
> >  i.
> >=20
> > >=20
> > > -- Sebastian
> > >=20
> > > > ---
> > > > Changes since v1:
> > > >  - rename "Fuse blown" to "Blown fuse"
> > > >  - rename "Cell imbalanced" to "Cell imbalance"
> > > > ---
> > > >  Documentation/ABI/testing/sysfs-class-power | 2 +-
> > > >  drivers/power/supply/power_supply_sysfs.c   | 2 ++
> > > >  include/linux/power_supply.h                | 2 ++
> > > >  3 files changed, 5 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/Documentation/ABI/testing/sysfs-class-power b/Docume=
ntation/ABI/testing/sysfs-class-power
> > > > index 2a5c1a09a28f..be8be54b183d 100644
> > > > --- a/Documentation/ABI/testing/sysfs-class-power
> > > > +++ b/Documentation/ABI/testing/sysfs-class-power
> > > > @@ -456,7 +456,7 @@ Description:
> > > >  			      "Over voltage", "Under voltage", "Unspecified failure",=
 "Cold",
> > > >  			      "Watchdog timer expire", "Safety timer expire",
> > > >  			      "Over current", "Calibration required", "Warm",
> > > > -			      "Cool", "Hot", "No battery"
> > > > +			      "Cool", "Hot", "No battery", "Blown fuse", "Cell imbala=
nce"
> > > > =20
> > > >  What:		/sys/class/power_supply/<supply_name>/precharge_current
> > > >  Date:		June 2017
> > > > diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/=
power/supply/power_supply_sysfs.c
> > > > index edb058c19c9c..2703ed1dd943 100644
> > > > --- a/drivers/power/supply/power_supply_sysfs.c
> > > > +++ b/drivers/power/supply/power_supply_sysfs.c
> > > > @@ -110,6 +110,8 @@ static const char * const POWER_SUPPLY_HEALTH=
_TEXT[] =3D {
> > > >  	[POWER_SUPPLY_HEALTH_COOL]		    =3D "Cool",
> > > >  	[POWER_SUPPLY_HEALTH_HOT]		    =3D "Hot",
> > > >  	[POWER_SUPPLY_HEALTH_NO_BATTERY]	    =3D "No battery",
> > > > +	[POWER_SUPPLY_HEALTH_BLOWN_FUSE]	    =3D "Blown fuse",
> > > > +	[POWER_SUPPLY_HEALTH_CELL_IMBALANCE]	    =3D "Cell imbalance",
> > > >  };
> > > > =20
> > > >  static const char * const POWER_SUPPLY_TECHNOLOGY_TEXT[] =3D {
> > > > diff --git a/include/linux/power_supply.h b/include/linux/power_s=
upply.h
> > > > index 888824592953..69df3a452918 100644
> > > > --- a/include/linux/power_supply.h
> > > > +++ b/include/linux/power_supply.h
> > > > @@ -71,6 +71,8 @@ enum {
> > > >  	POWER_SUPPLY_HEALTH_COOL,
> > > >  	POWER_SUPPLY_HEALTH_HOT,
> > > >  	POWER_SUPPLY_HEALTH_NO_BATTERY,
> > > > +	POWER_SUPPLY_HEALTH_BLOWN_FUSE,
> > > > +	POWER_SUPPLY_HEALTH_CELL_IMBALANCE,
> > > >  };
> > > > =20
> > > >  enum {
> > > > --=20
> > > > 2.39.5
> > > >=20
> > >=20
> >=20


