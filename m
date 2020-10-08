Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD54287EFA
	for <lists+linux-pm@lfdr.de>; Fri,  9 Oct 2020 01:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbgJHXHH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 19:07:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727324AbgJHXHG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Oct 2020 19:07:06 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B979B22248;
        Thu,  8 Oct 2020 23:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602198425;
        bh=1mislZOuz6lxCg/M7FucS7TRkwuOnsVOArrjY2tUUG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QuFehhKvoIhnulWR/snKKIepp7Gg4p0C5fAwxtjCMb+V8atS2ZqJPhqtsV0thQOs7
         dV5Ge4QiR+gDNBDO5JORuNvgZbOKDXHjcNRdlY9dkhbUM5LRwpe5nwMQieijo67ZFs
         ft48Q0wm1i0lFAF61ND3N23hWEGiuG4EJAP0a58g=
Received: by earth.universe (Postfix, from userid 1000)
        id 5216C3C0C87; Fri,  9 Oct 2020 01:07:03 +0200 (CEST)
Date:   Fri, 9 Oct 2020 01:07:03 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     "Harley A.W. Lorenzo" <hl1998@protonmail.com>
Cc:     Joe Perches <joe@perches.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>
Subject: Re: [PATCH] test_power: add missing newlines when printing
 parameters by sysfs
Message-ID: <20201008230703.gjpz2ixngyfbqume@earth.universe>
References: <1599199798-27804-1-git-send-email-wangxiongfeng2@huawei.com>
 <20201003212336.5et7erdf6fihqscu@earth.universe>
 <472008b94f4b20915425db4714fdb505cb0cbe5a.camel@perches.com>
 <20201003215029.jsugcgpgrmcmydr3@earth.universe>
 <9822843f764520e1076a92fd9120294aa393a085.camel@perches.com>
 <20201004221645.nyaf7jhur4jixo6n@earth.universe>
 <1g3ecQ7VLlrgKOSHr6teWgw9xcmVVQx1bFp2KpJD7y35lZpaC8ONb-jrPKapmFttEwVg2uhDwmv6mug9z5-GVZbqPbkOjcqjrSHtaW-k6ts=@protonmail.com>
 <f8fd76b81dab7dcb0e262a62e4d92bdf63ef2cfe.camel@perches.com>
 <XgtK3LuGSChMPtuO5vmpvUY6igXN3_gtLIOHsH7QSWimCXVDsM2j02qDOIrBK-rWMpwidDFxqF7MhOdfc7xfnRgOuDCVHW6XML9RXPujSak=@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2cmkfr7hklhha5yy"
Content-Disposition: inline
In-Reply-To: <XgtK3LuGSChMPtuO5vmpvUY6igXN3_gtLIOHsH7QSWimCXVDsM2j02qDOIrBK-rWMpwidDFxqF7MhOdfc7xfnRgOuDCVHW6XML9RXPujSak=@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--2cmkfr7hklhha5yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 05, 2020 at 04:44:17AM +0000, Harley A.W. Lorenzo wrote:
> On Monday, October 5, 2020 12:19 AM, Joe Perches <joe@perches.com> wrote:
> > I did not suggest this.
>=20
> My apologies. Revised patch (still diffing from Xiongfeng Wang) here.
>=20
> [PATCH v2] test_power: revise parameter printing to use sprintf
>=20
> Signed-off-by: Harley A.W. Lorenzo <hl1998@protonmail.com>
> Suggested-by: Joe Perches <joe@perches.com>
> ---

Thanks, I fixed the commit message and applied this.

-- Sebastian

>  drivers/power/supply/test_power.c | 32 +++++++++++++------------------
>  1 file changed, 13 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/tes=
t_power.c
> index 4895ee5e63a9..5f510ddc946d 100644
> --- a/drivers/power/supply/test_power.c
> +++ b/drivers/power/supply/test_power.c
> @@ -352,9 +352,8 @@ static int param_set_ac_online(const char *key, const=
 struct kernel_param *kp)
>=20
>  static int param_get_ac_online(char *buffer, const struct kernel_param *=
kp)
>  {
> -	strcpy(buffer, map_get_key(map_ac_online, ac_online, "unknown"));
> -	strcat(buffer, "\n");
> -	return strlen(buffer);
> +	return sprintf(buffer, "%s\n",
> +			map_get_key(map_ac_online, ac_online, "unknown"));
>  }
>=20
>  static int param_set_usb_online(const char *key, const struct kernel_par=
am *kp)
> @@ -366,9 +365,8 @@ static int param_set_usb_online(const char *key, cons=
t struct kernel_param *kp)
>=20
>  static int param_get_usb_online(char *buffer, const struct kernel_param =
*kp)
>  {
> -	strcpy(buffer, map_get_key(map_ac_online, usb_online, "unknown"));
> -	strcat(buffer, "\n");
> -	return strlen(buffer);
> +	return sprintf(buffer, "%s\n",
> +			map_get_key(map_ac_online, usb_online, "unknown"));
>  }
>=20
>  static int param_set_battery_status(const char *key,
> @@ -381,9 +379,8 @@ static int param_set_battery_status(const char *key,
>=20
>  static int param_get_battery_status(char *buffer, const struct kernel_pa=
ram *kp)
>  {
> -	strcpy(buffer, map_get_key(map_status, battery_status, "unknown"));
> -	strcat(buffer, "\n");
> -	return strlen(buffer);
> +	return sprintf(buffer, "%s\n",
> +			map_get_key(map_ac_online, battery_status, "unknown"));
>  }
>=20
>  static int param_set_battery_health(const char *key,
> @@ -396,9 +393,8 @@ static int param_set_battery_health(const char *key,
>=20
>  static int param_get_battery_health(char *buffer, const struct kernel_pa=
ram *kp)
>  {
> -	strcpy(buffer, map_get_key(map_health, battery_health, "unknown"));
> -	strcat(buffer, "\n");
> -	return strlen(buffer);
> +	return sprintf(buffer, "%s\n",
> +			map_get_key(map_ac_online, battery_health, "unknown"));
>  }
>=20
>  static int param_set_battery_present(const char *key,
> @@ -412,9 +408,8 @@ static int param_set_battery_present(const char *key,
>  static int param_get_battery_present(char *buffer,
>  					const struct kernel_param *kp)
>  {
> -	strcpy(buffer, map_get_key(map_present, battery_present, "unknown"));
> -	strcat(buffer, "\n");
> -	return strlen(buffer);
> +	return sprintf(buffer, "%s\n",
> +			map_get_key(map_ac_online, battery_present, "unknown"));
>  }
>=20
>  static int param_set_battery_technology(const char *key,
> @@ -429,10 +424,9 @@ static int param_set_battery_technology(const char *=
key,
>  static int param_get_battery_technology(char *buffer,
>  					const struct kernel_param *kp)
>  {
> -	strcpy(buffer,
> -		map_get_key(map_technology, battery_technology, "unknown"));
> -	strcat(buffer, "\n");
> -	return strlen(buffer);
> +	return sprintf(buffer, "%s\n",
> +			map_get_key(map_ac_online, battery_technology,
> +					"unknown"));
>  }
>=20
>  static int param_set_battery_capacity(const char *key,
> --
> 2.28.0

--2cmkfr7hklhha5yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9/m5cACgkQ2O7X88g7
+ppv8BAAoCzWPaz3YoxfnugKS+8QhFly5qC2N2psYypj9ccxTJH7CxVFNtk7g51p
tZcoORGLZyZ6efHbcK73skLpnrWAVQVQ2ZRDzl4HpZfr3yh2uPnW+ni1+o5fokD9
sJYg37+677EnmBSUricd/knHblDW+Qf282J8uLFe0pMaKwOdHpOhnedvbGOqoyn4
uN38Pm/FEkT9O70ppok0VV/NUT38rZsSL/QZ6Q0Gdkicm2jw7ZPukpHQ/9ZPUfd1
gegDGMyfMLkGzEauZdgBYAJ1GfUrw3xkBzEa9bCZAV3RY5+0U2WFqbRFiZPj1Yga
/p7IBTdcQB3ugpWsgLcMZiomfkvUGpLoN7SucvT5T1rdI+rG6kHC92U2xKSlYYJ9
xPzo/6Xoly0ul33e4XiLyhP0ScamMQN0XrsRDpmlOMd62LC0EFzBRw7ID9GUlcyN
aOs/66iuikiBQohD5OHmXFn2jjws//eKg7JVfPAW2imVHd0t4i4vAeKySs+o8xJE
yiAx5ABroywJOnTNtqrrd2/AehOIqqMql56ECIqVaXenN8p6T2YRGlGL7FL7+Aoa
Zs4wTOQtQBgeRDQUZt3qkKFQqDpy/3lMoG1EmZP6jCn4G+K1Eho4XQqWoR9hUufn
MHr/VONfSyZZbgogeaYWtilFBGh3n2MgKt0JXWa9HspES3P0xpc=
=HCei
-----END PGP SIGNATURE-----

--2cmkfr7hklhha5yy--
