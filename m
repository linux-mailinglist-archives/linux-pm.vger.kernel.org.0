Return-Path: <linux-pm+bounces-34754-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB19B5A0E0
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 21:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33AF41C04C8E
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 19:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CE92D4806;
	Tue, 16 Sep 2025 19:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="gsW460ix"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E151A2389;
	Tue, 16 Sep 2025 19:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758049406; cv=pass; b=RzmPYzGa7OtQTVdnUQzlBvFDZZ1Q6z8hKnEC6BGUD2Etr62KiUudircAUBpAPmYSwcHartqcSmRjOY6ehlnIf2l8ESQDVdj0W+nF5MGvMK660EXkpJpp27XYVano8UxrUztpmX8b6Jd+YTC+W5M+oRszV/kGZ9f0kc7wHII24OA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758049406; c=relaxed/simple;
	bh=Jz1/U05SCwquRX/JQQZs4ngB0vGf9gKVPSHcX4eRJ6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbite39wpJvZMGUZzWOVHYZRWbfHC/W5LifQSq6H41jzKHO5ziA0wJgYcBIGiX19q0e5UGn6vfZa2fYj8h7w0t/C2zOY1yAlyIUw0Fwf1WGHYKq2H52ROM2iNzwzn+JM/YQ8eFXywp5XuqtSJn159n/T/QDhn7JWLA9+lYOjMuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=gsW460ix; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758049380; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LSLQIrN4wdI567Qx4kfSQGcakSZxqqKWJ95JLo/WRlzYsTYxTudM/nY279cbR7BThDd86gKHoMOoMqVif9eWVV05HIugLmCyqtmMtmPRpv9vhcNlYc9QVAmxzOYRLSCL45cL9KawobAUTg87l7JS/rf7eyq1mFAfvEYh2CO3qao=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758049380; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AmLHLzUeV9VSK4+ZRmRQHJz37kpqz+83jxn06y7PIN0=; 
	b=nA6meiVA5PjXqY8j6DGtpCCFuHXidyQeZKsGw7ZXNXB/tuPey5D5hy59Y/11TQOrNn1oIOspCvfd3G9B9ZlgcGKBdgS8oPm1XTDcUVPj7SflSRkvsfAXRB8p/4hVVenrRV0AU4/tQH1P5VESh9Gd8P9dD10U0bQdS7Ttkiwlx50=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758049380;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=AmLHLzUeV9VSK4+ZRmRQHJz37kpqz+83jxn06y7PIN0=;
	b=gsW460ix/8dOFJPUY4Tsyf/O/owKBsFYUTEfOYVngiD6lXOWjxUWK3q2QHkI7UmG
	kfHM1J3VzZ0o0g6Jog1hxujJFWKWjbO2i23iX5Mg/BZ6jf6RVMjvUOtQxEPVBBFMk6I
	qNlQQQvSrF/Z1BY2As9OIq3QV03ZZ61KQofxASKE=
Received: by mx.zohomail.com with SMTPS id 1758049378526820.4472844737274;
	Tue, 16 Sep 2025 12:02:58 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 8ADE9180733; Tue, 16 Sep 2025 21:02:41 +0200 (CEST)
Date: Tue, 16 Sep 2025 21:02:41 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Souvik Chakravarty <Souvik.Chakravarty@arm.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Yan <andy.yan@rock-chips.com>, Mark Rutland <mark.rutland@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	Vinod Koul <vkoul@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, 
	Stephen Boyd <swboyd@chromium.org>, Andre Draszik <andre.draszik@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	Elliot Berman <quic_eberman@quicinc.com>, Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH v14 05/10] power: reset: reboot-mode: Expose sysfs for
 registered reboot_modes
Message-ID: <lgoahuqgoajuj352h7rnjfyeeyf24x45pj3qmidc6qqrc75vej@3hrblxle7uyk>
References: <20250815-arm-psci-system_reset2-vendor-reboots-v14-0-37d29f59ac9a@oss.qualcomm.com>
 <20250815-arm-psci-system_reset2-vendor-reboots-v14-5-37d29f59ac9a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rvds47h6heygbawa"
Content-Disposition: inline
In-Reply-To: <20250815-arm-psci-system_reset2-vendor-reboots-v14-5-37d29f59ac9a@oss.qualcomm.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/258.4.7
X-ZohoMailClient: External


--rvds47h6heygbawa
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v14 05/10] power: reset: reboot-mode: Expose sysfs for
 registered reboot_modes
MIME-Version: 1.0

Hi,

On Fri, Aug 15, 2025 at 08:05:10PM +0530, Shivendra Pratap wrote:
> Currently, there is no standardized mechanism for userspace to
> discover which reboot-modes are supported on a given platform.
> This limitation forces tools and scripts to rely on hardcoded
> assumptions about the supported reboot-modes.
>=20
> Create a class 'reboot-mode' and a device under it to expose a
> sysfs interface to show the available reboot mode arguments to
> userspace.
>=20
> Provision the register function with an additional parameter to
> get an explicit driver_name. Create the device using this
> driver_name. For platform drivers, use the driver_name configured
> in dev node.
>=20
> This results in the creation of:
>   /sys/class/reboot-mode/<driver>/reboot_modes
>=20
> This read-only sysfs file will exposes the list of supported
> reboot modes arguments provided by the driver, enabling userspace
> to query the list of arguments.
>=20
> Align the clean up path to maintain backward compatibility for
> existing reboot-mode based drivers.
>=20
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  drivers/power/reset/reboot-mode.c | 131 +++++++++++++++++++++++++++++++-=
------
>  include/linux/reboot-mode.h       |   4 +-
>  2 files changed, 110 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/rebo=
ot-mode.c
> index ac81b8b0a9b7fc31f8ef21024333a050087ce90f..7ecab050e496af3e1cc01c1a4=
614787707cb74b4 100644
> --- a/drivers/power/reset/reboot-mode.c
> +++ b/drivers/power/reset/reboot-mode.c
> @@ -6,6 +6,7 @@
>  #define pr_fmt(fmt)	"reboot-mode: " fmt
> =20
>  #include <linux/device.h>
> +#include <linux/err.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
> @@ -23,6 +24,8 @@ struct mode_info {
>  	struct list_head list;
>  };
> =20
> +static struct class *rb_class;
> +
>  static u64 get_reboot_mode_magic(struct reboot_mode_driver *reboot, cons=
t char *cmd)
>  {
>  	const char *normal =3D "normal";
> @@ -75,26 +78,121 @@ static int reboot_mode_notify(struct notifier_block =
*this,
>  	return NOTIFY_DONE;
>  }
> =20
> +static void release_reboot_mode_device(struct device *dev, void *res);
> +
> +static ssize_t reboot_modes_show(struct device *dev, struct device_attri=
bute *attr, char *buf)
> +{
> +	struct reboot_mode_driver **devres_reboot;
> +	struct reboot_mode_driver *reboot;
> +	struct mode_info *info;
> +	ssize_t size =3D 0;
> +
> +	devres_reboot =3D devres_find(dev, release_reboot_mode_device, NULL, NU=
LL);
> +	if (!devres_reboot || !(*devres_reboot))
> +		return -ENODATA;
> +
> +	reboot =3D *devres_reboot;
> +	mutex_lock(&reboot->rb_lock);
> +	list_for_each_entry(info, &reboot->head, list) {
> +		size +=3D sprintf(buf + size, "%s ", info->mode);

sysfs_emit_at

> +	}
> +	mutex_unlock(&reboot->rb_lock);
> +
> +	if (size) {
> +		size +=3D sprintf(buf + size - 1, "\n");

sysfs_emit_at

> +		return size;
> +	}
> +
> +	return -ENODATA;
> +}
> +static DEVICE_ATTR_RO(reboot_modes);
> +
> +static void release_reboot_mode_device(struct device *dev, void *res)
> +{
> +	struct reboot_mode_driver *reboot =3D *(struct reboot_mode_driver **)re=
s;
> +	struct mode_info *info;
> +	struct mode_info *next;
> +
> +	unregister_reboot_notifier(&reboot->reboot_notifier);
> +
> +	mutex_lock(&reboot->rb_lock);
> +	list_for_each_entry_safe(info, next, &reboot->head, list) {
> +		list_del(&info->list);
> +		kfree_const(info->mode);
> +		kfree(info);
> +	}
> +	mutex_unlock(&reboot->rb_lock);
> +
> +	device_remove_file(reboot->reboot_dev, &dev_attr_reboot_modes);
> +}
> +
> +static int create_reboot_mode_device(struct reboot_mode_driver *reboot,
> +				     const char *dev_name)

Instead of adding more and more arguments to this, just add a name
field to struct reboot_mode_driver.

Greetings,

-- Sebastian

> [...]

--rvds47h6heygbawa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmjJtEoACgkQ2O7X88g7
+pqh5RAAiwcRD05/Qi5M1FQ+czBKYt0JywEwWfXl7Vbc0K5fbgDIkTNxJbWT0k7R
aipONT1XttYqVqmIFTeVj9cT/THMn+c6hLvIZZXtCDxscGgmLJAYLP45alzRo//W
55bEIMCJUzQY4xNqMxGtLWdO+DvTyhj3so90UungJV9uJcZB0RdUwWJu5AQqabrj
muJNvAWCn8qJiAThahESDnzLfJOUsXuctNDMXpBU4EsGYyH0CcUtqSxF6hBaYK1j
x6SJ4s6XGisYDoZ4Ao7/ENgM2kJoZELixzf+jSpGUHG+JXmI/yMSJcHXkEco6ID+
DRE8lEJCsJ33sYVgmvav8JURJdP3A8Sl3FIq+03rigqLWOEem61wMG7FR4fQIo1t
078rMHdXKW1B4FGFTxQ3utkbqKGZ3cXyoze52nKue8bJ19huPNf2rg8rCmzFHUEY
dZ6N4cPkgC2ioJNP1kCthHFMHgNtaCJXfBaiz14/gUgpJ8EbR9aVob74LRKBevT2
1usAzDEBQk0R5eqhfbfHY/vGafyzA6G1K9TLB6MK5U8HtNVCra7Zf5Khti0+jkdB
FaG9LWZQLQrLlcNWcAEbkRJUirY7GSbJ9xpefSNKHS2TQPdHrFBfZMkCiXoZlqBR
S/Ou5i+fpjZd5zXerOct4/4DGgJF2vciq4hb79bpcMtBviSawGs=
=JZ25
-----END PGP SIGNATURE-----

--rvds47h6heygbawa--

