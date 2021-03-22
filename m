Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9EC83446C0
	for <lists+linux-pm@lfdr.de>; Mon, 22 Mar 2021 15:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhCVOJF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 10:09:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229879AbhCVOIi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Mar 2021 10:08:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38B5E61931;
        Mon, 22 Mar 2021 14:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616422117;
        bh=7caE9N26jv0l5ZnLHGx7Et17KdeDOuGVZwE3GJ5eC/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=usfo7ArLyujRxLVN0WQM3dLozR/ZOP84SjTA9R6YfVO2xpnK+ZDCIz2ch+Je60Gr3
         eQYkHI8j6lqPynZS7H80CmKLsQwBLd2VAzI6ElAo2aRISKmWbVPhq/azgvNzAIeTkZ
         dqEfoZzl4gJ1UnQ5IymBm3gnNiPO+17s9LndqZGukIzCOmdIjtaBo3MN+gEbwFY2bX
         hxcDstVLdEf0WZTkn1dIvB9uWpy7C7AayiM/9C1tOaDcq0ttXL0v9GKF/YXZkmxZdb
         /16IEjozeZLTZNomMswrcNIlZjpMf5HhoXj39yB1RDG5UZVCzdwfxOUy5Wal0RVD0q
         1cg8bkeEk0wow==
Received: by earth.universe (Postfix, from userid 1000)
        id BE9123C0C96; Mon, 22 Mar 2021 15:08:34 +0100 (CET)
Date:   Mon, 22 Mar 2021 15:08:34 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Jian Dong <dj0227@163.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, dongjian <dongjian@yulong.com>
Subject: Re: [PATCH] power-supply: use kobj_to_dev()
Message-ID: <20210322140834.5tcrgo4n76bdcov4@earth.universe>
References: <1615877652-31829-1-git-send-email-dj0227@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iwzobb3xlpjvnd7l"
Content-Disposition: inline
In-Reply-To: <1615877652-31829-1-git-send-email-dj0227@163.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--iwzobb3xlpjvnd7l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 16, 2021 at 02:54:12PM +0800, Jian Dong wrote:
> From: dongjian <dongjian@yulong.com>
>=20
> Use kobj_to_dev() instead of open-coding it
>=20
> Signed-off-by: dongjian <dongjian@yulong.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/ds2781_battery.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/power/supply/ds2781_battery.c b/drivers/power/supply=
/ds2781_battery.c
> index 3df3c82..05b859b 100644
> --- a/drivers/power/supply/ds2781_battery.c
> +++ b/drivers/power/supply/ds2781_battery.c
> @@ -626,7 +626,7 @@ static ssize_t ds2781_read_param_eeprom_bin(struct fi=
le *filp,
>  				struct bin_attribute *bin_attr,
>  				char *buf, loff_t off, size_t count)
>  {
> -	struct device *dev =3D container_of(kobj, struct device, kobj);
> +	struct device *dev =3D kobj_to_dev(kobj);
>  	struct power_supply *psy =3D to_power_supply(dev);
>  	struct ds2781_device_info *dev_info =3D to_ds2781_device_info(psy);
> =20
> @@ -639,7 +639,7 @@ static ssize_t ds2781_write_param_eeprom_bin(struct f=
ile *filp,
>  				struct bin_attribute *bin_attr,
>  				char *buf, loff_t off, size_t count)
>  {
> -	struct device *dev =3D container_of(kobj, struct device, kobj);
> +	struct device *dev =3D kobj_to_dev(kobj);
>  	struct power_supply *psy =3D to_power_supply(dev);
>  	struct ds2781_device_info *dev_info =3D to_ds2781_device_info(psy);
>  	int ret;
> @@ -671,7 +671,7 @@ static ssize_t ds2781_read_user_eeprom_bin(struct fil=
e *filp,
>  				struct bin_attribute *bin_attr,
>  				char *buf, loff_t off, size_t count)
>  {
> -	struct device *dev =3D container_of(kobj, struct device, kobj);
> +	struct device *dev =3D kobj_to_dev(kobj);
>  	struct power_supply *psy =3D to_power_supply(dev);
>  	struct ds2781_device_info *dev_info =3D to_ds2781_device_info(psy);
> =20
> @@ -685,7 +685,7 @@ static ssize_t ds2781_write_user_eeprom_bin(struct fi=
le *filp,
>  				struct bin_attribute *bin_attr,
>  				char *buf, loff_t off, size_t count)
>  {
> -	struct device *dev =3D container_of(kobj, struct device, kobj);
> +	struct device *dev =3D kobj_to_dev(kobj);
>  	struct power_supply *psy =3D to_power_supply(dev);
>  	struct ds2781_device_info *dev_info =3D to_ds2781_device_info(psy);
>  	int ret;
> --=20
> 1.9.1
>=20

--iwzobb3xlpjvnd7l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBYpOIACgkQ2O7X88g7
+pq2eg//Szgo6OaEduFcKvhuFr2h5C/QHthQMKuGOcrVq0xsnhxIiEO6S+jfJDTv
Y0vzbUekN9x/o2cP6HxxaixWDOK/pVOy+jjWvmbrIAj1viVzEyY4y2Gekw7Rwd42
SWGbGacg8FxytOX9Ngh85ofjFo4Lx8ivqM0tacEXJqNzv8Ojqf6hsSr/Gnt3Y7L9
k36f/LKWi/TEL1Hr9Cmmo8qFYyfpGaLFZzPqOzh5K4ehKJAVa/9H07gJXqX/fXs2
OaeIQgMiFUKMTaomZJmRbGeGV96CzDxOupFYSaAfEnDbQT8ZNdUYxQ8mLGcG3Win
y0NyEA2eWvQ7s/xMLNWtrp6yeoo+GP3ga7k5Db/D6DeIXj27wnZsiGrRtLO2qd2x
CkbUa61vzcLiFIaHv/9bHZzf5qQgZSWmxrx1mb5YtrVlNIg9+MEnNcOMRRMaxcsK
aBicRWFguKnsl9JHnkdHIjUhM8wMeXlUGDFzrgmaVeA916vcOeAjzuZeZqqwOV+w
0k6YSfuPjbM0ltKJRXk8ukLD2iV61Jh8AxsvPFOLUe8Xv6XNwK2w+GfUl9yO3dLa
5ojZ5E5JnvKU7zpcjq4PMpPKNKKg2onOUDu09ncNek2QVpVJQudadDTn/jtpHUD2
b75zEtFpMbw0pI85j4Z+WMFsrUwT4k8Jv81lOPDKwRL2Vzn25yI=
=j5VT
-----END PGP SIGNATURE-----

--iwzobb3xlpjvnd7l--
