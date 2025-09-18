Return-Path: <linux-pm+bounces-35010-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 709AEB8751F
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 01:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F2577AE5E5
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 23:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EEA285404;
	Thu, 18 Sep 2025 23:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="f/44jdJp"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806342F2E;
	Thu, 18 Sep 2025 23:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758236874; cv=pass; b=A61BqXjzr6eRyVCTf20zitTCWEJzQMrAaDoIKiCRd4HoFeC5UHOtGPm82/l4FnbDjYQVvbGLi8a4ajEHc1eFBu9HmSDRzUinnSMrHXqOwjuJJNkUxd21oG4Qo5S2hgx0q2Gsk5JPO9vxTkc6O9xUElYXDz1PV7D/jICEXexmbqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758236874; c=relaxed/simple;
	bh=Di69+3xAurKfacfP8puUgoBd+aL2EAtdQ3uafgJuZSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ik7adueYbqzbCqR6P6t3M0dGebg8UQt4yDnXqusFzoNXkCsjajftJVPXYKjCSRW4rP9EIHEPMIZeh6weA67X6joP4jzdjX7UOR4zjfTmGHQGh2SoTGBV9xhuKAtHj3Wsgw71cHsamqZpb5yDMS96uexmajHlSFjYkTb4wD5Gyls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=f/44jdJp; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758236853; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dqebnjUb2kmT1+WAe/W8RSC3z3MasPZX/nJ8TxGT3ArTBLWktlGBZwZdg+Qy5oToJiXLfjw9Uw+n9t999jfsbRhjeqepeoezmyX5ZeMDAjB/oXxVw5MQZ5be4o86gyaUKGVV6+nKuhYarDak97nzoixYmdw1gweymuDimu59eN0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758236853; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=H4r4kdckYteex6L4AXkP4SeaEi4CQAP9o0saVu48T/E=; 
	b=FPH7OJPd8KLKqZE44Toda/9m+8HEzsletaSBK6iv9WeFm6I1irqSlAvpZIqzSygofX7fKlDNnLa3fIso+rZLKUmQZNlzzlVAKfi3W1GZKVf4oeWns73GZUYXB+om2VU9PTUbkFnb8eF3LKoDKVl5RmbTHrSxavGSnG4qY+e9bU8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758236853;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=H4r4kdckYteex6L4AXkP4SeaEi4CQAP9o0saVu48T/E=;
	b=f/44jdJpZbW33D3WSDM0DChDCjq/CkLL9FZsbC+67V7L6ZXhf9Z2Ab6JMl5PjPM+
	WGi4HkpwRE51OS/RFyrCvqHzr52z1uVWViNS4shqwoIPZKSB5tkwSlP1XiCawqfsku9
	c+w3ugDUverJvZ+Xlz6R56ok37Zj9fciWdG7XHyM=
Received: by mx.zohomail.com with SMTPS id 1758236851024804.9593862824289;
	Thu, 18 Sep 2025 16:07:31 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 4F224180517; Fri, 19 Sep 2025 01:07:18 +0200 (CEST)
Date: Fri, 19 Sep 2025 01:07:18 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 9/9] power: supply: max77705_charger: implement aicl
 feature
Message-ID: <ykyi4qot6nh5nickidkpepwxoeoxey3fdfsybjj4edmldn73no@x3c3cytyzo6n>
References: <20250918-max77705_77976_charger_improvement-v4-0-11ec9188f489@gmail.com>
 <20250918-max77705_77976_charger_improvement-v4-9-11ec9188f489@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pr3ucwdquctonocm"
Content-Disposition: inline
In-Reply-To: <20250918-max77705_77976_charger_improvement-v4-9-11ec9188f489@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/258.211.62
X-ZohoMailClient: External


--pr3ucwdquctonocm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 9/9] power: supply: max77705_charger: implement aicl
 feature
MIME-Version: 1.0

Hi,

On Thu, Sep 18, 2025 at 08:06:53PM +0300, Dzmitry Sankouski wrote:
> Adaptive input current allows charger to reduce it's current
> consumption, when source is not able to provide enough power.
>=20
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
> Changes in v4:
> - fix intendation
> - use IRQF_TRIGGER_NONE, because this is not physical irq
> - use dev_err_probe instead of pr_err
> - remove excessive chgin irq request
> - remove pr_infos
> ---
>  drivers/power/supply/max77705_charger.c | 58 +++++++++++++++++++++++++++=
++++++
>  include/linux/power/max77705_charger.h  |  5 +++
>  2 files changed, 63 insertions(+)
>=20
> diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supp=
ly/max77705_charger.c
> index 8032dfa0c9a2..168a67819a51 100644
> --- a/drivers/power/supply/max77705_charger.c
> +++ b/drivers/power/supply/max77705_charger.c
> @@ -40,6 +40,16 @@ static enum power_supply_property max77705_charger_pro=
ps[] =3D {
>  	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
>  };
> =20
> +static irqreturn_t max77705_aicl_irq(int irq, void *irq_drv_data)
> +{
> +	struct max77705_charger_data *chg =3D irq_drv_data;

If you do this here:

disable_irq(chg->aicl_irq);

[...]

> +	queue_delayed_work(chg->wqueue, &chg->aicl_work,
> +		     msecs_to_jiffies(AICL_WORK_DELAY));
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static irqreturn_t max77705_chgin_irq(int irq, void *irq_drv_data)
>  {
>  	struct max77705_charger_data *chg =3D irq_drv_data;
> @@ -445,6 +455,38 @@ static const struct power_supply_desc max77705_charg=
er_psy_desc =3D {
>  	.set_property		=3D max77705_set_property,
>  };
> =20
> +static void max77705_aicl_isr_work(struct work_struct *work)
> +{
> +	unsigned int regval, irq_status;
> +	int err;
> +	struct max77705_charger_data *chg =3D
> +		container_of(work, struct max77705_charger_data, aicl_work.work);
> +
> +	regmap_read(chg->regmap, MAX77705_CHG_REG_INT_OK, &irq_status);

[...] You can drop the following code block and completley get rid
of the is_aicl_irq_disabled variable.

> +	if (!chg->is_aicl_irq_disabled) {
> +		disable_irq(chg->aicl_irq);
> +		chg->is_aicl_irq_disabled =3D true;
> +	}
> +
> +	if (!(irq_status & BIT(MAX77705_AICL_I))) {
> +		err =3D regmap_field_read(chg->rfield[MAX77705_CHG_CHGIN_LIM], &regval=
);
> +		if (err < 0)
> +			return;
> +
> +		regval--;
> +
> +		err =3D regmap_field_write(chg->rfield[MAX77705_CHG_CHGIN_LIM], regval=
);
> +		if (err < 0)
> +			return;
> +
> +		queue_delayed_work(chg->wqueue, &chg->aicl_work,
> +		     msecs_to_jiffies(AICL_WORK_DELAY));
> +	} else {
> +		enable_irq(chg->aicl_irq);
> +		chg->is_aicl_irq_disabled =3D false;
> +	}
> +}
> +
>  static void max77705_chgin_isr_work(struct work_struct *work)
>  {
>  	struct max77705_charger_data *chg =3D
> @@ -617,6 +659,12 @@ static int max77705_charger_probe(struct i2c_client =
*i2c)
>  		goto destroy_wq;
>  	}
> =20
> +	ret =3D devm_delayed_work_autocancel(dev, &chg->aicl_work, max77705_aic=
l_isr_work);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "failed to initialize interrupt work\n");
> +		goto destroy_wq;
> +	}
> +
>  	ret =3D max77705_charger_initialize(chg);
>  	if (ret) {
>  		dev_err_probe(dev, ret, "failed to initialize charger IC\n");
> @@ -632,6 +680,16 @@ static int max77705_charger_probe(struct i2c_client =
*i2c)
>  		goto destroy_wq;
>  	}
> =20
> +	chg->aicl_irq =3D regmap_irq_get_virq(irq_data, MAX77705_AICL_I);
> +	ret =3D devm_request_threaded_irq(dev, chg->aicl_irq,
> +					NULL, max77705_aicl_irq,
> +					IRQF_TRIGGER_NONE,
> +					"aicl-irq", chg);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Failed to Request aicl IRQ\n");
> +		goto destroy_wq;
> +	}
> +
>  	ret =3D max77705_charger_enable(chg);
>  	if (ret) {
>  		dev_err_probe(dev, ret, "failed to enable charge\n");
> diff --git a/include/linux/power/max77705_charger.h b/include/linux/power=
/max77705_charger.h
> index 6653abfdf747..92fef95e4ac4 100644
> --- a/include/linux/power/max77705_charger.h
> +++ b/include/linux/power/max77705_charger.h
> @@ -123,6 +123,8 @@
>  #define MAX77705_DISABLE_SKIP		1
>  #define MAX77705_AUTO_SKIP		0
> =20
> +#define AICL_WORK_DELAY		100

Add _MS suffix

> +
>  /* uA */
>  #define MAX77705_CURRENT_CHGIN_STEP	25000
>  #define MAX77705_CURRENT_CHG_STEP	50000
> @@ -185,7 +187,10 @@ struct max77705_charger_data {
>  	struct power_supply_battery_info *bat_info;
>  	struct workqueue_struct *wqueue;
>  	struct work_struct	chgin_work;
> +	struct delayed_work	aicl_work;
>  	struct power_supply	*psy_chg;
> +	int			is_aicl_irq_disabled;
> +	int			aicl_irq;
>  };
> =20
>  #endif /* __MAX77705_CHARGER_H */

Otherwise LGTM.

Greetings,

-- Sebastian

--pr3ucwdquctonocm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmjMkJoACgkQ2O7X88g7
+prASxAAmQkPy6v96FCAD8OFFK74FN/koiHT9S7M/Aivj0hHYnjubYlvbrBJFME0
qZnqCo/aek9eLetF3PE3unOH3zKUzeMlKc/W/756ob4l6hME27ecekB/3sgeOsgE
MJ74O1aqeYui8I4YM2zUkRzbOO/evOId8q9+xrY3bl71reulWoL7aM+ZFEgtuYi5
wl4/rWRvvaZTgs/PXAc8bcuzogP4iha7yZsyFpZccFJ81qHZe5fJrCVpvb6kQCcS
PNbH/gj5HIoIlZnhH2gwdv7cHNDEmEiOsn4UsWpua1jgdkukoqxRRoJV7qDwpJHN
rVxzlxFOGuuQWo70ByNLihIHKbYz9EXMvIMV5JCKR7sv63BJ1IcxWYiCzaOSbPbw
EZV3LyMGSIodQlB4/JK1O4zvUBJlQqYs/glqAJO7eZCc6N0bacKopUjXzmbpn/fI
/lxFQnNXAmElYpuIdBIgGONa4hknipHfd3I9gqfTVPSf15IzYi+QsGIy0tbPL9Bs
j6tTYGR9e7hG6c9PCOpM6nIwFYy5msGjnIFJej1rlTRgzQjf7m+KJtnM10rpMUd8
4IdU2FAGm4iUA5Pwzguzm2hyDU2kCksCf/qRV/6Gn3lKzESYeAlUXVMGDkjSBdrB
nkXmmi5qiOhgiwi8ywqAJ2XrXJ2duYPQ51kUvjimr7ArP5AJRr8=
=jSN7
-----END PGP SIGNATURE-----

--pr3ucwdquctonocm--

