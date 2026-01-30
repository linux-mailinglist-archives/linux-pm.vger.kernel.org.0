Return-Path: <linux-pm+bounces-41802-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id w0B7D6kkfWnxQQIAu9opvQ
	(envelope-from <linux-pm+bounces-41802-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 22:37:45 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 50650BED12
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 22:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC782300251B
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 21:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4955F3126A0;
	Fri, 30 Jan 2026 21:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="eSwJ+ztv"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3F015E8B;
	Fri, 30 Jan 2026 21:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769809058; cv=pass; b=J2/vF1+CulbbvwosG7i2dvaC4Lr3BvOBPPFwiYmGMewHyAD8ytqSts7pCR5Clg4G+aFefr/6ELAQKHAqHp6BMY5DN1zqMcmjrhvOEpPwV131opx47V1zHYQluUj/y+8qkQwJjyNKZQXC4pYjCvryyT8yCx/Q+oDILQICE1J6F+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769809058; c=relaxed/simple;
	bh=ti0AwGRqfqjcDodK53M0e0fnQxO3uAo9uYAujMxy6bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKYv0I3U8X7rPOEkdFHbeI01sJnTy4NAz18kmV13gKwCOrOCVv9QtKuEKzQem1BFrcOLKTT7hQ9PILolgHhjiIIUvWmO+vpndU97p6IdGzr1w0mHZSr1GPpGCTEwzz1M6F1TC823zMTzJBtH2OiJeCBwPww94mBK4BUSr08n1fE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=eSwJ+ztv; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1769809049; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PGjgB9LpHig3HuoSy6KJZV2fbSk0XScM9wzH3btt8kROXb7Ln8vdOfYEbdXYL5P8zUt+wL1iRhEs1YTJCmGBdAms2/kzoKpYIAoXj8ZiLJEzNVbNzlNv/gk8lqfGvph9x6zmuPuXpJ/eCuMdt+c7oeB+qWHVPLYNycpjgB69ptc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769809049; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FK5EaXUFSPRzSsXqwWQRPrBDkjU3iyVGiuxceDb11e0=; 
	b=nEyjPna+37RMEZaxk1pL+c2dw7P9m4sc/cdaVCTjHvE3ODGWub/QCLva3s0ubmio/bJPpQcNUeaGLltey4V0lr4caXJJCq9ruXIqp14/B6vxesdMlr27RPE86qOXbG/uAwL7wqmXyZDkfAVgJxNAxssFzXMfEbB4YE2VtUykcj4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769809049;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=FK5EaXUFSPRzSsXqwWQRPrBDkjU3iyVGiuxceDb11e0=;
	b=eSwJ+ztvItZywWfiGnMAmunR++/PazIlDs11lSU+OnujzqqDWsQVyn8gExo7CkY7
	HSAUQlPoKeoDg/GWeMC+Roixi50EqKlXXrdPtqh5yKsUc8RIQg9FVr1jHQL+pQaChMJ
	iHt7oZr5mgCtmToKiCivg3OkEaPZGoHUmITWmGtQ=
Received: by mx.zohomail.com with SMTPS id 1769809047503108.0165741299976;
	Fri, 30 Jan 2026 13:37:27 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id B88F818050E; Fri, 30 Jan 2026 22:37:24 +0100 (CET)
Date: Fri, 30 Jan 2026 22:37:24 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH 2/2] power: supply: sbs-battery: Add support for polling
 battery status
Message-ID: <aX0iNMcKh_HhswSr@venus>
References: <20251231093152.2817579-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20251231093152.2817579-2-Qing-wu.Li@leica-geosystems.com.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d3bugel2kv2btcoa"
Content-Disposition: inline
In-Reply-To: <20251231093152.2817579-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.1.1.4.3/269.789.21
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41802-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[collabora.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastian.reichel@collabora.com,linux-pm@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[leica-geosystems.com.cn:email,collabora.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 50650BED12
X-Rspamd-Action: no action


--d3bugel2kv2btcoa
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] power: supply: sbs-battery: Add support for polling
 battery status
MIME-Version: 1.0

Hi,

On Wed, Dec 31, 2025 at 09:31:52AM +0000, LI Qingwu wrote:
> Enable periodic polling of SBS battery status on systems where the
> battery interrupt line is not connected. Polling is configured via
> the poll_interval parameter (ms, default 0/disabled) and automatically
> disabled when a working GPIO interrupt is available.
>=20
> Example usage:
>   echo 5000 > /sys/module/sbs_battery/parameters/poll_interval
>=20
> Tested on i.MX 8M Plus platform with SBS-compliant battery.

This is messed up. You are calling the delayed work intended to be
used when the state of the charger supplying the battery changes.
The detection should instead call sbs_supply_changed(). Also I
wonder why you need this in the first place. Isn't force_load
enough? The battery detection status should be updated when you
read any property from userspace.

If we need to add a detection poll feature, let's just use sensible
timings and enable it by default if there is no detection gpio.

Greetings,

-- Sebastian

> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---
>  drivers/power/supply/sbs-battery.c | 84 +++++++++++++++++++++++++++++-
>  1 file changed, 83 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sb=
s-battery.c
> index 0b9ecfc1f3f7..f4f1189fec3c 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -14,6 +14,7 @@
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> +#include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/property.h>
>  #include <linux/of.h>
> @@ -214,8 +215,10 @@ struct sbs_info {
>  	u32				poll_retry_count;
>  	struct delayed_work		work;
>  	struct mutex			mode_lock;
> +	u32				poll_interval;
>  	u32				flags;
>  	int				technology;
> +	struct list_head		list;
>  	char				strings[NR_STRING_BUFFERS][I2C_SMBUS_BLOCK_MAX + 1];
>  };
> =20
> @@ -242,6 +245,52 @@ static void sbs_invalidate_cached_props(struct sbs_i=
nfo *chip)
>  }
> =20
>  static bool force_load;
> +static DEFINE_MUTEX(sbs_list_lock);
> +static LIST_HEAD(sbs_battery_devices);
> +static unsigned int poll_interval;
> +
> +static int poll_interval_param_set(const char *val,
> +				   const struct kernel_param *kp)
> +{
> +	struct sbs_info *chip;
> +	unsigned int prev_val =3D *(unsigned int *)kp->arg;
> +	int ret;
> +
> +	ret =3D param_set_uint(val, kp);
> +	if (ret < 0 || prev_val =3D=3D *(unsigned int *)kp->arg)
> +		return ret;
> +
> +	mutex_lock(&sbs_list_lock);
> +	list_for_each_entry(chip, &sbs_battery_devices, list) {
> +		if (!chip->gpio_detect) {
> +			chip->poll_interval =3D poll_interval;
> +			if (chip->poll_interval)
> +				mod_delayed_work(system_wq, &chip->work, 0);
> +		}
> +	}
> +	mutex_unlock(&sbs_list_lock);
> +
> +	return 0;
> +}
> +
> +static const struct kernel_param_ops param_ops_poll_interval =3D {
> +	.set =3D poll_interval_param_set,
> +	.get =3D param_get_uint,
> +};
> +
> +static void sbs_list_remove(void *data)
> +{
> +	struct sbs_info *chip =3D data;
> +
> +	mutex_lock(&sbs_list_lock);
> +	list_del(&chip->list);
> +	mutex_unlock(&sbs_list_lock);
> +}
> +
> +module_param_cb(poll_interval, &param_ops_poll_interval, &poll_interval,=
 0644);
> +MODULE_PARM_DESC(
> +	poll_interval,
> +	"Polling interval in milliseconds for devices without GPIO interrupt (0=
=3Ddisabled)");
> =20
>  static int sbs_read_word_data(struct i2c_client *client, u8 address);
>  static int sbs_write_word_data(struct i2c_client *client, u8 address, u1=
6 value);
> @@ -1091,6 +1140,10 @@ static void sbs_delayed_work(struct work_struct *w=
ork)
>  	/* if the read failed, give up on this work */
>  	if (ret < 0) {
>  		chip->poll_time =3D 0;
> +		if (chip->poll_interval)
> +			schedule_delayed_work(
> +				&chip->work,
> +				msecs_to_jiffies(chip->poll_interval));
>  		return;
>  	}
> =20
> @@ -1106,6 +1159,11 @@ static void sbs_delayed_work(struct work_struct *w=
ork)
>  	if (chip->last_state !=3D ret) {
>  		chip->poll_time =3D 0;
>  		power_supply_changed(chip->power_supply);
> +	}
> +
> +	if (chip->poll_interval) {
> +		schedule_delayed_work(&chip->work,
> +				      msecs_to_jiffies(chip->poll_interval));
>  		return;
>  	}
>  	if (chip->poll_time > 0) {
> @@ -1173,6 +1231,8 @@ static int sbs_probe(struct i2c_client *client)
>  	}
>  	chip->i2c_retry_count =3D chip->i2c_retry_count + 1;
> =20
> +	chip->poll_interval =3D poll_interval;
> +
>  	chip->charger_broadcasts =3D !device_property_read_bool(&client->dev,
>  					"sbs,disable-charger-broadcasts");
> =20
> @@ -1201,12 +1261,18 @@ static int sbs_probe(struct i2c_client *client)
>  		goto skip_gpio;
>  	}
> =20
> +	if (chip->poll_interval) {
> +		dev_dbg(&client->dev,
> +			"GPIO-based IRQ configured, polling disabled\n");
> +		chip->poll_interval =3D 0;
> +	}
> +
>  skip_gpio:
>  	/*
>  	 * Before we register, we might need to make sure we can actually talk
>  	 * to the battery.
>  	 */
> -	if (!(force_load || chip->gpio_detect)) {
> +	if (!(force_load || chip->gpio_detect || chip->poll_interval)) {
>  		union power_supply_propval val;
> =20
>  		rc =3D sbs_get_battery_presence_and_health(
> @@ -1230,6 +1296,22 @@ static int sbs_probe(struct i2c_client *client)
>  	dev_info(&client->dev,
>  		"%s: battery gas gauge device registered\n", client->name);
> =20
> +	mutex_lock(&sbs_list_lock);
> +	list_add(&chip->list, &sbs_battery_devices);
> +	mutex_unlock(&sbs_list_lock);
> +
> +	rc =3D devm_add_action(&client->dev, sbs_list_remove, chip);
> +	if (rc) {
> +		mutex_lock(&sbs_list_lock);
> +		list_del(&chip->list);
> +		mutex_unlock(&sbs_list_lock);
> +		return rc;
> +	}
> +
> +	if (chip->poll_interval > 0)
> +		schedule_delayed_work(&chip->work,
> +				      msecs_to_jiffies(chip->poll_interval));
> +
>  	return 0;
>  }
> =20
> --=20
> 2.43.0
>=20
>=20

--d3bugel2kv2btcoa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAml9JI4ACgkQ2O7X88g7
+pp93A//aQpezVPiM17P0r4Phb+T1/nYpyCvfAi0BmdVuOGHgyoEm/vLpwIIMD30
i7YjIOyUnRYevb12rGw1ZN/UdaQZe404YuggLK8oxXV757OTvBDMGwFJfHB2N4l3
1bumObH5CKAo0qfFyIMzotOW6oSP42dzRVpgpMkH+xrQ/eTHtj42YI0RutP17pLR
FrK1QEujkcXdgSTox/RfCWfkP6Stym0l6+tvGPc4RlsZYE6uuS30MGrQtj4mEQGU
DbhLu2zhpYO0iQyqjiOi2MRSpAmm85cdYXPjTxRREyDahkJCYkvvR4SKlgUwjB14
74Zoj5xpRv074sVKTuHlozq3mMIlzANB7P2uCPzJoMA3uUl7lL5QydRLSfOagCpn
jYDsawc1ZuhqCJftxv1C3lbEUgoahbLngf3/rULkAahZ7lcnLlnqPlVMJQhXxMKz
00ZtTyCXl9unRJawu3EIpvkM59g5mtaXjPmotPfSpFYlJygD4o5tETCSWtjAHNOT
rv80p++r1Ns4w8ANbYvth3lzNuHw/m4xsK+yvUYP3PxGQFkX68i4wAEbYkxzEOYp
oZoGhuN44bDEPqORSj0CojUIKEuPJ4WVXW+LSM1jhsHLUPOj5YX/n5F3My/1AaBW
go54z/7EZ7qkGwFFMYy82HVqzxEPgiRpt4jGHEltBYOsE9x1Xlc=
=5527
-----END PGP SIGNATURE-----

--d3bugel2kv2btcoa--

