Return-Path: <linux-pm+bounces-35912-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 879BFBCCD72
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 14:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B1C64EC825
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 12:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30420288C3B;
	Fri, 10 Oct 2025 12:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="e++32knt"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DDB28935C;
	Fri, 10 Oct 2025 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760098170; cv=pass; b=V4tyzUnViXDG3qezY/RCyMj/5ZHfCh5KB2gFa/g+VUwE3khAUUI/V1kJ4XmIxbLw45G4zzwwYVFFBDjivRDKWw4YSEX/tSCdofzzCFsjHa6RonP6gVFbxzWuj7G48/xfSJsMG4uJixreuLcaJOTNcuiJ2hhK9WkhSJr+g/KZ8z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760098170; c=relaxed/simple;
	bh=4w3kqGVJTLViAam56F8blcy40H7IF16KUIpTWyq6UcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyPmSzdc1Xq4FFIq2XQAERS/BBpb0qzmKxCVC2gEYc/MF+zBmvJH8ocr0uHA0iNL9OwlaQ4x5rjMdTTpgHqV0DxQ2vJCEY2BCiJw/4qC/St6xBhIwnxBiu6Ug7GauAGIis4kVgoe/9xfPwjXAZQUgbMWBSH/s3lDd8xICo81DtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=e++32knt; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760098144; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dA7yAX/vP+3sun5ZXeCK2uinkx7VxnyIrLK/qFVhnYkyIFMtM7d0mDDrS+TVtokDdKLyrYnAAwSizRXhvpbRLgf2TDGGByKbFmsqPa6nviQqfy4lrZk6kcd0Ae7HWo39fKmeIXVQXcXiYB37IGKBh2MKy+Z7YhgN03NwLj9wa0Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760098144; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5TVVAycESmEEhj5tXHazMG2YgT7j35yrk8K3ETkT928=; 
	b=LrRKByWE0juU2zdLzyEYdDD1mp9eVTrWVGP1NeYLCrsE0o38GKgbGP08xo0GlCT8Cc1Cofa+1c2eId5d3DQtwywqTNOjUuWeTQx4F7dsZJ62uZjwLStFKhuEdDXO2nVowLYnkS5SGG9WHyYd5Szo6DqN3gpyDQhcAanBlNNLICg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760098144;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=5TVVAycESmEEhj5tXHazMG2YgT7j35yrk8K3ETkT928=;
	b=e++32knteoigBVHQgzqdtxzmswEgQW44+hGhNEU0OeQ+GmGQTqbxF29o9ndVlZw3
	q+VPMupP2hE/k9JBfai0xY/xICZijegXN+IN+7AcgZrFIMxvzzRnoLEmnPD5oHubILE
	q0ozm8UE6yix73c5DQeKYJY4j46i0QaDOJzImgw0=
Received: by mx.zohomail.com with SMTPS id 1760098141718220.0272880217807;
	Fri, 10 Oct 2025 05:09:01 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 8F261181905; Fri, 10 Oct 2025 14:08:53 +0200 (CEST)
Date: Fri, 10 Oct 2025 14:08:53 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-pm@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Heiko Stuebner <heiko@sntech.de>, 
	Sebin Francis <sebin.francis@ti.com>, Diederik de Haas <didi.debian@cknow.org>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Jon Hunter <jonathanh@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] driver core: fw_devlink: Don't warn about
 sync_state() pending
Message-ID: <f7zspguplzerupaorr4ex4xnpeyrcdcid473u3tx3ekbvcj233@wgle5id5z5on>
References: <20251007094312.590819-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o7l652o277il7yvz"
Content-Disposition: inline
In-Reply-To: <20251007094312.590819-1-ulf.hansson@linaro.org>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/260.58.11
X-ZohoMailClient: External


--o7l652o277il7yvz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] driver core: fw_devlink: Don't warn about
 sync_state() pending
MIME-Version: 1.0

Hi,

On Tue, Oct 07, 2025 at 11:43:12AM +0200, Ulf Hansson wrote:
> Due to the wider deployment of the ->sync_state() support, for PM domains
> for example, we are receiving reports about the sync_state() pending
> message that is being logged in fw_devlink_dev_sync_state(). In particular
> as it's printed at the warning level, which is questionable.
>=20
> Even if it certainly is useful to know that the ->sync_state() condition
> could not be met, there may be nothing wrong with it. For example, a driv=
er
> may be built as module and are still waiting to be initialized/probed. For
> this reason let's move to the info level for now.
>=20
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reported-by: Sebin Francis <sebin.francis@ti.com>
> Reported-by: Diederik de Haas <didi.debian@cknow.org>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> ---
>=20
> Changes in v2:
> 	- Due to discussions on v1 and because the default Kconfig is to use the
> 	FW_DEVLINK_SYNC_STATE_STRICT, I suggest that for now it may be best to
> 	keep the warning level for the "Timed out.." print and only change the
> 	"sync_state pending..." message.
>=20
> ---
>  drivers/base/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index d22d6b23e758..c62e428b95b0 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1784,7 +1784,7 @@ static int fw_devlink_dev_sync_state(struct device =
*dev, void *data)
>  		return 0;
> =20
>  	if (fw_devlink_sync_state =3D=3D FW_DEVLINK_SYNC_STATE_STRICT) {
> -		dev_warn(sup, "sync_state() pending due to %s\n",
> +		dev_info(sup, "sync_state() pending due to %s\n",
>  			 dev_name(link->consumer));
>  		return 0;
>  	}
> --=20
> 2.43.0
>=20

--o7l652o277il7yvz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmjo91EACgkQ2O7X88g7
+pomMhAAgIOiXn/XY2FB+L5+3ENCR0BvsBVlK+rVbqoS/fUE/D7K/rUt4yv/2O+p
bt9dweSC0hd9Z0Zb11SMW9Txh1ChIxByF0g+OuoqvG2BtoQhdNVqkhATO9hDT6yX
P7h0znsMPWh3BqxBn7r/kEyTY2fnUb8GPAD0LUx4ueKZtDBXBrGX/5P9idorPLkY
lclBxSg6VAFOIgcFW8SEAMn1ZCvCF+5stTLuR7Mou68+M2Qfd61t+Yj0drYzCgAG
joUXON246lHT8zLcSTKpkNro6KTMlL8SHtM5SPdJDnO7pS9dNI+B3MqD7TK9link
s5j7Xyr8crIcpb9+iqcnIRcWe3h6VxJVNTf3TkPFz2svNmjrLOzH2Wdpy2V9zeGz
rTI7ZuG74S/OiDI6TpVu7Hk+VKDfevhos/vyV1IgXU9LdCUHDisytirZc0j3t0tE
DYdQQpCA83ZIFz6imfBJaTg+stf9FAwcFKpzpPe7w1w0RxXqt+3Sut8kUb3lLo3l
H2F/q6mFL7Cemwo90QXtrDK6PKLa/WVS3IQB0/pyWqEHMGnsvXqT7lXwzRhiCc7L
4kToIWU3haS2yG8vB+of3kOl6hPYhUJSMBy6Q/49qKn8ktDriMDC5+HeOUrPL7kl
5He8aqTNVKGgRSzNLF0oVO9FyyKCQPcQCUKOcunDvPXD4f6y9Rw=
=iRpS
-----END PGP SIGNATURE-----

--o7l652o277il7yvz--

