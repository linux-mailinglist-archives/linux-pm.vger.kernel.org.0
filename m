Return-Path: <linux-pm+bounces-34751-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AACB5A0C0
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 20:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0C22586A5F
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 18:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFF02DE6E9;
	Tue, 16 Sep 2025 18:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="LR5V0opg"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F49275B0F;
	Tue, 16 Sep 2025 18:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758048303; cv=pass; b=hnlbVrRyuSZHSoK/+62fFachtvJCXBLEhTBW/WBdCLFZlmBzacq+ajPOlwvSubMKNM2PHHgyWOMyIcBr3pL2T31r687eVI/vE0QCQIj1zLpFouiLl4rh5PZzAoGb2C7qOHm4RmmtxzdiOjxAjpTZ8v2r0zV26TYHyrRRXtUFOFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758048303; c=relaxed/simple;
	bh=kg7Z4AVuzVyDq0Z/9aYlA/WI+AyxXsieVETIb4nuE6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+FZ2x5hg8INlCPDtYoAYFloAcmLceLxLkYDQqBWZXfW6jwjI0Zvu9iklv+DnnfwaVunuhdY+swGDHfRGOPQRTgk+ndki9FV0dCZK7/I/6ok5c6f4xzeqGmm3UgIQVqhkxU01g3sFW1gqymT+nf161X6ewn9PG82pzG9PP67cPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=LR5V0opg; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758048275; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hOCDdnG63dQU7qFtNpQB190B0Huwnk8I20iE5Nk5P4Ltn6woyC2lAy9FFoTofXQmo2aiaieXc8QucJRWJHkle6+PcWdE3HfN8gkjQePqDI+lOd52mW8cC8XNaqCYrk/hTQ52gP8h1zPEBRnLUZwOc3vbIvyAJmXIPOh9eYFPgVA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758048275; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=F8AzxSXiqyaK53ijp2vluA+48cHW4LFRyjsjMYLM0wg=; 
	b=UGoeeqW/9wNW9iI+UIOYEPL1+gVhv+m9P+ikc2lEpy4JjIaMCCkGM7ZXyX3MANvL8f/ZG0uZuPqeC1tg844J0XeG+OnAmlObMS8UlEeYstQb5oezu16aJ7E0qH0WSDbguzkEMdtp7NfF+g6w7GFJXe8EiUyVtQy7vNll9+wFlPc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758048275;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=F8AzxSXiqyaK53ijp2vluA+48cHW4LFRyjsjMYLM0wg=;
	b=LR5V0opgPXLfbdKounrbU2gyC7JnFd9tyB9GieBJItv90Nc864qK6t35RjPVtG5n
	A47RJ+s+UmMFWBl5BXx+50T8zZZwod111orZ4vXH79nmHxgWYzE14J1U/7zzyMOdToh
	nXTc4SthnyTwFlJ86yun7TSGmgVjs3coGQoxo5Uw=
Received: by mx.zohomail.com with SMTPS id 1758048273886940.1781889933253;
	Tue, 16 Sep 2025 11:44:33 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id AE499180733; Tue, 16 Sep 2025 20:44:15 +0200 (CEST)
Date: Tue, 16 Sep 2025 20:44:15 +0200
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
Subject: Re: [PATCH v14 01/10] power: reset: reboot-mode: Synchronize list
 traversal
Message-ID: <7eqa3rs3nvy7htvrkwyh5m7ok34n6c3h2dxn7xm2abdjzav4hp@i275ed4owgru>
References: <20250815-arm-psci-system_reset2-vendor-reboots-v14-0-37d29f59ac9a@oss.qualcomm.com>
 <20250815-arm-psci-system_reset2-vendor-reboots-v14-1-37d29f59ac9a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qa7akznga3nuo6q7"
Content-Disposition: inline
In-Reply-To: <20250815-arm-psci-system_reset2-vendor-reboots-v14-1-37d29f59ac9a@oss.qualcomm.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/258.4.7
X-ZohoMailClient: External


--qa7akznga3nuo6q7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v14 01/10] power: reset: reboot-mode: Synchronize list
 traversal
MIME-Version: 1.0

Hi,

On Fri, Aug 15, 2025 at 08:05:06PM +0530, Shivendra Pratap wrote:
> List traversals must be synchronized to prevent race conditions
> and data corruption. The reboot-mode list is not protected by a
> lock currently, which can lead to concurrent access and race.
>=20
> Introduce a mutex lock to guard all operations on the reboot-mode
> list and ensure thread-safe access. The change prevents unsafe
> concurrent access on reboot-mode list.
>=20
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---

This should use scoped_guard() and a Fixes: tag. Otherwise LGTM.

Greetings,

-- Sebastian

>  drivers/power/reset/reboot-mode.c | 24 ++++++++++++++++++++----
>  include/linux/reboot-mode.h       |  4 ++++
>  2 files changed, 24 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/rebo=
ot-mode.c
> index fba53f638da04655e756b5f8b7d2d666d1379535..42bb99128ed3846d4bff62416=
dc31135ddeaeb90 100644
> --- a/drivers/power/reset/reboot-mode.c
> +++ b/drivers/power/reset/reboot-mode.c
> @@ -29,9 +29,14 @@ static unsigned int get_reboot_mode_magic(struct reboo=
t_mode_driver *reboot,
>  	if (!cmd)
>  		cmd =3D normal;
> =20
> -	list_for_each_entry(info, &reboot->head, list)
> -		if (!strcmp(info->mode, cmd))
> +	mutex_lock(&reboot->rb_lock);
> +	list_for_each_entry(info, &reboot->head, list) {
> +		if (!strcmp(info->mode, cmd)) {
> +			mutex_unlock(&reboot->rb_lock);
>  			return info->magic;
> +		}
> +	}
> +	mutex_unlock(&reboot->rb_lock);
> =20
>  	/* try to match again, replacing characters impossible in DT */
>  	if (strscpy(cmd_, cmd, sizeof(cmd_)) =3D=3D -E2BIG)
> @@ -41,9 +46,14 @@ static unsigned int get_reboot_mode_magic(struct reboo=
t_mode_driver *reboot,
>  	strreplace(cmd_, ',', '-');
>  	strreplace(cmd_, '/', '-');
> =20
> -	list_for_each_entry(info, &reboot->head, list)
> -		if (!strcmp(info->mode, cmd_))
> +	mutex_lock(&reboot->rb_lock);
> +	list_for_each_entry(info, &reboot->head, list) {
> +		if (!strcmp(info->mode, cmd_)) {
> +			mutex_unlock(&reboot->rb_lock);
>  			return info->magic;
> +		}
> +	}
> +	mutex_unlock(&reboot->rb_lock);
> =20
>  	return 0;
>  }
> @@ -77,7 +87,9 @@ int reboot_mode_register(struct reboot_mode_driver *reb=
oot)
>  	int ret;
> =20
>  	INIT_LIST_HEAD(&reboot->head);
> +	mutex_init(&reboot->rb_lock);
> =20
> +	mutex_lock(&reboot->rb_lock);
>  	for_each_property_of_node(np, prop) {
>  		if (strncmp(prop->name, PREFIX, len))
>  			continue;
> @@ -113,12 +125,14 @@ int reboot_mode_register(struct reboot_mode_driver =
*reboot)
>  	reboot->reboot_notifier.notifier_call =3D reboot_mode_notify;
>  	register_reboot_notifier(&reboot->reboot_notifier);
> =20
> +	mutex_unlock(&reboot->rb_lock);
>  	return 0;
> =20
>  error:
>  	list_for_each_entry(info, &reboot->head, list)
>  		kfree_const(info->mode);
> =20
> +	mutex_unlock(&reboot->rb_lock);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(reboot_mode_register);
> @@ -133,8 +147,10 @@ int reboot_mode_unregister(struct reboot_mode_driver=
 *reboot)
> =20
>  	unregister_reboot_notifier(&reboot->reboot_notifier);
> =20
> +	mutex_lock(&reboot->rb_lock);
>  	list_for_each_entry(info, &reboot->head, list)
>  		kfree_const(info->mode);
> +	mutex_unlock(&reboot->rb_lock);
> =20
>  	return 0;
>  }
> diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
> index 4a2abb38d1d612ec0fdf05eb18c98b210f631b7f..b73f80708197677db8dc2e43a=
ffc519782b7146e 100644
> --- a/include/linux/reboot-mode.h
> +++ b/include/linux/reboot-mode.h
> @@ -2,11 +2,15 @@
>  #ifndef __REBOOT_MODE_H__
>  #define __REBOOT_MODE_H__
> =20
> +#include <linux/mutex.h>
> +
>  struct reboot_mode_driver {
>  	struct device *dev;
>  	struct list_head head;
>  	int (*write)(struct reboot_mode_driver *reboot, unsigned int magic);
>  	struct notifier_block reboot_notifier;
> +	/*Protects access to reboot mode list*/
> +	struct mutex rb_lock;
>  };
> =20
>  int reboot_mode_register(struct reboot_mode_driver *reboot);
>=20
> --=20
> 2.34.1
>=20
>=20

--qa7akznga3nuo6q7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmjJr/gACgkQ2O7X88g7
+prrKRAAmEnXJSTUr9zaDNlJyvd/+QFjmEvEdR7ulx2pMArVwOuEh/Icc6UCYXoM
Bdfge4fdpyVtWbQZFyRCnTuFL1A++0EE5w+7yXJIXOr2+6DLy95jqHeA4aOeh4Pw
mxHuq2szqBl6V4iJTRMa40rXuYSjHtfnaKeroobDrDSO+cQj+vk9f9gXuvLwa8Qx
ORwZ/8FEeZRhUDFGuckhr5eYDbFoFvt5xqLcNxGdpRm0Ph6YdeQZhMTu6XRl+BjX
Et2rNFsg4taCnyRZfUQ75yu3rz/tf+CoSzR5U6CF14EXE6Fug8Dv89EL7HEtAssX
ZZ2hhNwPY2MntJRi/RvXVcjYJs5ibANyWTf4HDHZlAuwX7ctOqvJFpVwmqUZOV3u
RpVGu5JfFbSNvx5ec672ffMOf7zfTG7MelUjOYAaEeVhkrlgO87/3Tg7Z6adIDog
91afcQjJBAyGeyIQb+EyBCcEK/Ts52Vhg4wbg/uYFczsLcTphPg9kPi4VunzfieY
pTDJuAKQm7FSgxBACopqbf0K1W0tY6zhQNyA7sMuS4+DhMDrp38W0eQGhl9rD9zx
Qu3GVsrCreplugk8oayxZvX0274cBtpbUW40EXv5hJaAIKzHzSmzhMrKQPna0skT
o0HoXcGldCK7VEIXcjAIBjRNomjqybmvdfAYXoxbEWBaZZci98o=
=hRJY
-----END PGP SIGNATURE-----

--qa7akznga3nuo6q7--

