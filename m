Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86DA573D42
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 22:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391704AbfGXTwY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jul 2019 15:52:24 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:35156 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388294AbfGXTwX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 15:52:23 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1hqNJ5-0004Yr-16; Wed, 24 Jul 2019 21:52:11 +0200
Message-ID: <7f13681e20034516103a9559d394289a6975aed4.camel@sipsolutions.net>
Subject: Re: [PATCH] drivers: thermal: processor_thermal_device: Export
 sysfs inteface for TCC offset
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rui.zhang@intel.com, edubezval@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 24 Jul 2019 21:52:06 +0200
In-Reply-To: <20190723010302.18048-1-srinivas.pandruvada@linux.intel.com>
References: <20190723010302.18048-1-srinivas.pandruvada@linux.intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Gs75zxF5lC00YPwVB/aa"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-Gs75zxF5lC00YPwVB/aa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Benjamin Berg <bberg@redhat.com>

Hi,

this patch allows performance improvements of some machines. It would
be nice if this could still make 5.3.

Benjamin

On Mon, 2019-07-22 at 18:03 -0700, Srinivas Pandruvada wrote:
> This change exports an interface to read tcc offset and allow writing if
> the platform is not locked.
>=20
> Refer to Intel SDM for details on the MSR: MSR_TEMPERATURE_TARGET.
> Here TCC Activation Offset (R/W) bits allow temperature offset in degrees
> in relation to TjMAX.
>=20
> This change will be useful for improving performance from user space for
> some platforms, if the current offset is not optimal.
>=20
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  .../processor_thermal_device.c                | 91
> ++++++++++++++++++-
>  1 file changed, 87 insertions(+), 4 deletions(-)
>=20
> diff --git
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> index 213ab3cc6b80..a35635129fed 100644
> ---
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> +++
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> @@ -137,6 +137,72 @@ static const struct attribute_group
> power_limit_attribute_group =3D {
>  	.name =3D "power_limits"
>  };
> =20
> +static ssize_t tcc_offset_degree_celsius_show(struct device *dev,
> +			       struct device_attribute *attr, char
> *buf)
> +{
> +	u64 val;
> +	int err;
> +
> +	err =3D rdmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, &val);
> +	if (err)
> +		return err;
> +
> +	val =3D (val >> 24) & 0xff;
> +	return sprintf(buf, "%d\n", (int)val);
> +}
> +
> +static int tcc_offset_update(int tcc)
> +{
> +	u64 val;
> +	int err;
> +
> +	if (!tcc)
> +		return -EINVAL;
> +
> +	err =3D rdmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, &val);
> +	if (err)
> +		return err;
> +
> +	val =3D ~GENMASK_ULL(31, 24);
> +	val =3D (tcc & 0xff) << 24;
> +
> +	err =3D wrmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, val);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static int tcc_offset_save;
> +
> +static ssize_t tcc_offset_degree_celsius_store(struct device *dev,
> +				struct device_attribute *attr, const
> char *buf,
> +				size_t count)
> +{
> +	u64 val;
> +	int tcc, err;
> +
> +	err =3D rdmsrl_safe(MSR_PLATFORM_INFO, &val);
> +	if (err)
> +		return err;
> +
> +	if (!(val & BIT(30)))
> +		return -EACCES;
> +
> +	if (kstrtoint(buf, 0, &tcc))
> +		return -EINVAL;
> +
> +	err =3D tcc_offset_update(tcc);
> +	if (err)
> +		return err;
> +
> +	tcc_offset_save =3D tcc;
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(tcc_offset_degree_celsius);
> +
>  static int stored_tjmax; /* since it is fixed, we can have local
> storage */
> =20
>  static int get_tjmax(void)
> @@ -332,6 +398,7 @@ static void proc_thermal_remove(struct
> proc_thermal_device *proc_priv)
>  	acpi_remove_notify_handler(proc_priv->adev->handle,
>  				   ACPI_DEVICE_NOTIFY,
> proc_thermal_notify);
>  	int340x_thermal_zone_remove(proc_priv->int340x_zone);
> +	sysfs_remove_file(&proc_priv->dev->kobj,
> &dev_attr_tcc_offset_degree_celsius.attr);
>  	sysfs_remove_group(&proc_priv->dev->kobj,
>  			   &power_limit_attribute_group);
>  }
> @@ -355,8 +422,15 @@ static int int3401_add(struct platform_device
> *pdev)
> =20
>  	dev_info(&pdev->dev, "Creating sysfs group for
> PROC_THERMAL_PLATFORM_DEV\n");
> =20
> -	return sysfs_create_group(&pdev->dev.kobj,
> -					 &power_limit_attribute_group);
> +	ret =3D sysfs_create_file(&pdev->dev.kobj,
> &dev_attr_tcc_offset_degree_celsius.attr);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D sysfs_create_group(&pdev->dev.kobj,
> &power_limit_attribute_group);
> +	if (ret)
> +		sysfs_remove_file(&pdev->dev.kobj,
> &dev_attr_tcc_offset_degree_celsius.attr);
> +
> +	return ret;
>  }
> =20
>  static int int3401_remove(struct platform_device *pdev)
> @@ -584,8 +658,15 @@ static int  proc_thermal_pci_probe(struct
> pci_dev *pdev,
> =20
>  	dev_info(&pdev->dev, "Creating sysfs group for
> PROC_THERMAL_PCI\n");
> =20
> -	return sysfs_create_group(&pdev->dev.kobj,
> -					 &power_limit_attribute_group);
> +	ret =3D sysfs_create_file(&pdev->dev.kobj,
> &dev_attr_tcc_offset_degree_celsius.attr);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D sysfs_create_group(&pdev->dev.kobj,
> &power_limit_attribute_group);
> +	if (ret)
> +		sysfs_remove_file(&pdev->dev.kobj,
> &dev_attr_tcc_offset_degree_celsius.attr);
> +
> +	return ret;
>  }
> =20
>  static void  proc_thermal_pci_remove(struct pci_dev *pdev)
> @@ -611,6 +692,8 @@ static int proc_thermal_resume(struct device
> *dev)
>  	proc_dev =3D dev_get_drvdata(dev);
>  	proc_thermal_read_ppcc(proc_dev);
> =20
> +	tcc_offset_update(tcc_offset_save);
> +
>  	return 0;
>  }
>  #else

--=-Gs75zxF5lC00YPwVB/aa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEED2NO4vMS33W8E4AFq6ZWhpmFY3AFAl04tucACgkQq6ZWhpmF
Y3B3WQ//TVtdQypLx4QvRa7Z/y/chYF/Drv92Xz0YIGh4SyxvEY7/6NWsRZnllqc
RG9iQ4HtyEFO5oJK47kGTF86VQFPhAqXLMsG6J90mQTJfaVLhXfee8t2tPTxFwcd
HLmRYbIPea1ImO6joVy9L0TEZdh6mNgxuD6Kh2o5HFhYwA0e78nidHnv+e2oAV+m
ppOWRZnGHPfColTCyCL8yjL5Z1R3lWjtMVJ1tnP8wI9evcoQ7CMs4qJNglsoW6LP
/cfHkUb9O2ALBcmj1UIxJaQWAlmp0gn34g9OBylUq1zfQGGYhPw+f5gUmejl8/3J
71cE3qV0O45/0i+zn97xNC2drGxCB0aDoaSO/03/ssL0j/SIB/WQrax0husFB3LO
ndisfMQQ4wYRZxzz2v7AXzJVDNKrYAYqj3NA/s7eW/4SrZB9zj0hnYzhAcYk4wLT
NdMKzasuPIPMLhNJ9WdnjH9nA9dtP0nlFydh54SZyylH64c8fUxiIW7VI9vrxOwL
dp1DB0Aqz8eTwEwRsu3EVXyGWvlXoE+bHMV+NFlkpw36/+EGWzFuJ/pBlJHHxny/
gBsTJSUJHueIE0XhxM+cIg5jtgzsooO9QCDzwTV8/bSLiDXJkBMlfSOJIWDqyoLL
SALSHulh/zeduG9rNvACWMl1ihxNOwbysRjgn694nfOtwtgbmys=
=QUhc
-----END PGP SIGNATURE-----

--=-Gs75zxF5lC00YPwVB/aa--

