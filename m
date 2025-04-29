Return-Path: <linux-pm+bounces-26422-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F43AA3CCF
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 01:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF5E61BC345C
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 23:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B019C280306;
	Tue, 29 Apr 2025 23:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="PKrsDqqH"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E977280300;
	Tue, 29 Apr 2025 23:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970300; cv=pass; b=mdEH2nr+BPUT1LyZH6/3nhJfpXH0YAZvZbOMQOPW5fwi9PlKEVgSXM3rYoc/LhxY/56tjzdJ/ojVqVRGiVpLr6HTmm3RiJzVBrKK0roGH2d07WaagPVkHoNass23ZL3QbFPubc8DDjvY8Xy6nxJrYk9+Jmx9w41stqRkaDg2JcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970300; c=relaxed/simple;
	bh=cEcBAIE0yrXPOBaVWQgUD5GHDhlvwDYdm6M7T3lpObw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Urkop9PAhMNs438gnSpZK6bD1tft4km60KTOvHbW7/ow8x9CYtDBk54Va1ylTicfkefm1Q4fEY/OOC05kS63waOUfIbE/R0ox/eptOu1seiNAmyzfT17+d38mwI0hzcPagfqJdwprwLhLunz3c8YYY7A2w1y4lMv9oO4Zc4/Ah4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=PKrsDqqH; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1745970292; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=L5RIoZWtf7sqCb890cdGggb67ubtv0TBnIMX3ex8GF3pPmiTjItzYkupUffMDvoDiFk8WRaFvROGHXL8OWfUydM4HOnEult8t5yU9pTKRoOGeRrvPsfC8G7AoHiEy27V3nsCHgxuTsjka6RAwa4gIln+39IklJSXYt2+4SCVW7Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745970292; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=o8jvErP+4m5Tg0vYtqr3UNtNQKaDYl+oueL3rFb9aX0=; 
	b=DB6VZ5G7yfbfGbkFuCq1qcK9UMtrFZ/uj09SgZQWKhYXVdrVQes6+N5/R3K+d/mgfaR4yNZ9l2fn7l9TXhpHrb8rZpXu50XHQuHHFifbB+LuFR0V/IXcxzAwtELTrX9JeeU+5kAVad4cLK6u7qkHa8jADdbC2RN7YKhmQHYYjCY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745970292;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=o8jvErP+4m5Tg0vYtqr3UNtNQKaDYl+oueL3rFb9aX0=;
	b=PKrsDqqHSyDTbAPFrCmo6RThh6aRIJuNl6WZng1pVOXsvCuuX4SqH66rjVCFx0uj
	5d3/W6dBHvGRiZe100qJ2MeW0Gaf8Q5lBstygZKjk0qNVSTnOqsA3oMvHfaAlDhVjUy
	rKWieo1lLavzhiUQJwQkCHcfBx+N7e3O8pp1w+nM=
Received: by mx.zohomail.com with SMTPS id 1745970291377333.3082050353805;
	Tue, 29 Apr 2025 16:44:51 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id DBDEB1805AD; Wed, 30 Apr 2025 01:44:47 +0200 (CEST)
Date: Wed, 30 Apr 2025 01:44:47 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] power: supply: core: Add additional health status
 values
Message-ID: <wla5mfgblecq7tiiangrzxv32yjhiru4h6i7nnmn3qvvl6o3ht@j7rbgete42u7>
References: <20250429003606.303870-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6hue2bnxo5otwymw"
Content-Disposition: inline
In-Reply-To: <20250429003606.303870-1-W_Armin@gmx.de>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/245.962.17
X-ZohoMailClient: External


--6hue2bnxo5otwymw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/4] power: supply: core: Add additional health status
 values
MIME-Version: 1.0

Hi,

On Tue, Apr 29, 2025 at 02:36:03AM +0200, Armin Wolf wrote:
> Some batteries can signal when an internal fuse was blown. In such a
> case POWER_SUPPLY_HEALTH_DEAD is too vague for userspace applications
> to perform meaningful diagnostics.
>=20
> Additionally some batteries can also signal when some of their
> internal cells are imbalanced. In such a case returning
> POWER_SUPPLY_HEALTH_UNSPEC_FAILURE is again too vague for userspace
> applications to perform meaningful diagnostics.
>=20
> Add new health status values for both cases.
>=20
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> ---
> Changes since v1:
>  - rename "Fuse blown" to "Blown fuse"
>  - rename "Cell imbalanced" to "Cell imbalance"
> ---
>  Documentation/ABI/testing/sysfs-class-power | 2 +-
>  drivers/power/supply/power_supply_sysfs.c   | 2 ++
>  include/linux/power_supply.h                | 2 ++
>  3 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/=
ABI/testing/sysfs-class-power
> index 2a5c1a09a28f..be8be54b183d 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -456,7 +456,7 @@ Description:
>  			      "Over voltage", "Under voltage", "Unspecified failure", "Cold",
>  			      "Watchdog timer expire", "Safety timer expire",
>  			      "Over current", "Calibration required", "Warm",
> -			      "Cool", "Hot", "No battery"
> +			      "Cool", "Hot", "No battery", "Blown fuse", "Cell imbalance"
> =20
>  What:		/sys/class/power_supply/<supply_name>/precharge_current
>  Date:		June 2017
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index edb058c19c9c..2703ed1dd943 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -110,6 +110,8 @@ static const char * const POWER_SUPPLY_HEALTH_TEXT[] =
=3D {
>  	[POWER_SUPPLY_HEALTH_COOL]		    =3D "Cool",
>  	[POWER_SUPPLY_HEALTH_HOT]		    =3D "Hot",
>  	[POWER_SUPPLY_HEALTH_NO_BATTERY]	    =3D "No battery",
> +	[POWER_SUPPLY_HEALTH_BLOWN_FUSE]	    =3D "Blown fuse",
> +	[POWER_SUPPLY_HEALTH_CELL_IMBALANCE]	    =3D "Cell imbalance",
>  };
> =20
>  static const char * const POWER_SUPPLY_TECHNOLOGY_TEXT[] =3D {
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 888824592953..69df3a452918 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -71,6 +71,8 @@ enum {
>  	POWER_SUPPLY_HEALTH_COOL,
>  	POWER_SUPPLY_HEALTH_HOT,
>  	POWER_SUPPLY_HEALTH_NO_BATTERY,
> +	POWER_SUPPLY_HEALTH_BLOWN_FUSE,
> +	POWER_SUPPLY_HEALTH_CELL_IMBALANCE,
>  };
> =20
>  enum {
> --=20
> 2.39.5
>=20

--6hue2bnxo5otwymw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmgRZGMACgkQ2O7X88g7
+poyURAAlX74uPfux8cnvLyfE/G0pJ+wYTGdHna19WSsUfvoOdzsIR7s/xMcrVt4
7SdNjWldcVNyU9g0zl3AibB8pTHG3DB1PqV+kNFPLHdXxH63DZIGW9tjOLyHfEc1
yjqkrOTDtFI/oVtEUSmBMRHPbjNu8KpRpqEeZ5/ZoSrti6uCO/u97G8SPdvE8Gj7
w7VSy+imv9BRaHJR72to+IEpS7ekctDYFpUP/iHxsa+hBwVM9/+zU/xKVkugY/j1
qumAay97v4j3aDRNWE+bZxFw8ZFB0cJfRmdxAvOkexQLmtzyGAJB4GSi7bdtlo6i
pY2PgbWWLKBDa8vXFF/cfeUabDP/KIjUvE4MemMMd7xzyNkz/K9iO7e7abxrcVTa
CyFYQiJBjCrFkB8azlLzeeIUFXYRX1jTrnr27u7IrfhBmhFLyxwzE6X3K4ZkGMsj
ghVPu35ZMh1yYK8vbb5q0j+VBefgW/wMOAvgmtKOmUuSNt96i9uJW31xlgb2moLI
5OVXzUp1a7pM401lGC11JOURzZgg2A2G7e3th5BMk8fMMzEnO+oWEyFhoEOxR8x6
j6oN5T7sqt/U2ZBFY0SSD4STOvNd12C2sIKyFJkCEquVbmf9Put/xSE7ITXRdrNc
QPOA+lonxa8ChmMLcimnc2A+1skDyA/ovCaIsCxSpKurZrt5GQw=
=xxxh
-----END PGP SIGNATURE-----

--6hue2bnxo5otwymw--

