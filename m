Return-Path: <linux-pm+bounces-35191-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 229F9B937AF
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 00:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3BB43BF3AD
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 22:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996442DEA68;
	Mon, 22 Sep 2025 22:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="fq9emhxZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E45325C810;
	Mon, 22 Sep 2025 22:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758580143; cv=pass; b=Vg6Z6mJY+2CXqIknws/9URw5Hsohj2b3leEn5OmSNjAuSMPo+iJTCvaD9RK2IPgD5cskcCjJW7aoW/maxUCe/N/xVoEvpo5GHd9Gu+cm1KauZQa6v2hFc9TYen9Im79KmNXeIhRPGJCVHnKUCEc5Tq1gf/gK/1X9UkK3OTDpe5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758580143; c=relaxed/simple;
	bh=Hni2pb/SWCKrnx1pZrLyZv0XAOBFJ6gEG1PhKYWLPbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jgmsh0VpbhIJIXNa6C3I1AcmnnDsEkUJ9zqYAoKGduLwu/MmMkDOAQwAm5YYoNIWMh5Zx3cR7NCNFRQlKImnEknN9LZUOQEFQgNSNkzZG3CBANsDDLIq0uTq9r+piV261mZqjDHQfkjU9QhxfwQ0llBwto4CkYr31zqLVfPcedM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=fq9emhxZ; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758580122; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DPbNvVlTeHvk4rTzZKxtZIqrCBnffwKyBSn8hOedCksVBKMhnfqpRQGjcbTFOJ7kJV2ex0oDze6zKc974HEQ01cjOhOS/47OEJ+0kbsSa+S8Yldjrlt8fRQHM8dZCAlNCfftFXPNukyxQ/VwIqkf7alSmUybho08RWf3Hh24Elw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758580122; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WGJ9p7ccOI7hAWR8G+9Ww5sw5ElrDPjQ4hRjDgDPqwI=; 
	b=m3amN5ZroATML53DJiqlu7sIB12+Y6CJR2DQN1RPyi9P+D7CPd4Gqddfew4qSpvdiBzPb6R1KSMd+vg0j12aaKNF+auLUAzq6ta4Wz0gK6PB08N+gJO/MxLXE5v9yEhzBMfTeh/9sv1WmWwAlsaY3AUfQEvV+stJeoT1iJS8ZHc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758580122;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=WGJ9p7ccOI7hAWR8G+9Ww5sw5ElrDPjQ4hRjDgDPqwI=;
	b=fq9emhxZaF6tZyCTVA0ZNce4XhGQYY0Kg4RBaDvnn8hBJRcUfCqScUE+et0jxA1Q
	upUntuEvbTe2UoGODPSoXeihyhJWOjG0be9ZGoY4gNW9wItvAEFjjhfRF8GTMaJKQRQ
	0sod+y87/yBZXxcic4vT12xBAT5AAwL2BO+eVE8I=
Received: by mx.zohomail.com with SMTPS id 1758580119097740.5010327230345;
	Mon, 22 Sep 2025 15:28:39 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 67D56180309; Tue, 23 Sep 2025 00:28:33 +0200 (CEST)
Date: Tue, 23 Sep 2025 00:28:33 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5] power: supply: max77705_charger: implement aicl
 feature
Message-ID: <cctdvj7jsf5ng3ab5vyhzjn73u6wqye3kcrgfj4tugpd32zj4f@o5buyuu7mmns>
References: <20250920-max77705_77976_charger_improvement-v5-1-aab0aef82cc4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="apzq35hofjb3hln6"
Content-Disposition: inline
In-Reply-To: <20250920-max77705_77976_charger_improvement-v5-1-aab0aef82cc4@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/258.557.22
X-ZohoMailClient: External


--apzq35hofjb3hln6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5] power: supply: max77705_charger: implement aicl
 feature
MIME-Version: 1.0

Hi,

On Sat, Sep 20, 2025 at 09:42:30PM +0300, Dzmitry Sankouski wrote:
> Adaptive input current allows charger to reduce it's current
> consumption, when source is not able to provide enough power.
>=20
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
> This series consists of:
> - max77705: interrupt handling fix
> - max77705: make input current limit and charge current limit properties
>   writable
> - max77705: add adaptive input current limit feature
> - max77705: switch to regfields
> - max77705: refactoring
> - max77976: change property for current charge limit value
> ---
> Changes in v5:
> - rebase on latest linux-next, dropping already applied patches
> - optimize code to drop is_aicl_irq_disabled variable
> - Link to v4: https://lore.kernel.org/r/20250918-max77705_77976_charger_i=
mprovement-v4-0-11ec9188f489@gmail.com
>=20
> Changes in v4:
> - fix commit message
> - use IRQF_TRIGGER_NONE, because non physical irqs
> - minor rename refactoring
> - rebase on latest linux-next
> - patch reorder: put fixes patch first
> - aicl feature cleanup
> - Link to v3: https://lore.kernel.org/r/20250911-max77705_77976_charger_i=
mprovement-v3-0-35203686fa29@gmail.com
>=20
> Changes in v3:
> - move interrupt request before interrupt handler work initialization
> - Link to v2: https://lore.kernel.org/r/20250909-max77705_77976_charger_i=
mprovement-v2-0-a8d2fba47159@gmail.com
>=20
> Changes in v2:
> - fix charger register protection unlock
> - Link to v1: https://lore.kernel.org/r/20250830-max77705_77976_charger_i=
mprovement-v1-0-e976db3fd432@gmail.com
> ---
> Changes in v5:
> - add _MS suffix to AICL_WORK_DELAY
> - optimize code to drop is_aicl_irq_disabled variable
>=20
> Changes in v4:
> - fix intendation
> - use IRQF_TRIGGER_NONE, because this is not physical irq
> - use dev_err_probe instead of pr_err
> - remove excessive chgin irq request
> - remove pr_infos
> ---
>  drivers/power/supply/max77705_charger.c | 55 +++++++++++++++++++++++++++=
++++++
>  include/linux/power/max77705_charger.h  |  4 +++
>  2 files changed, 59 insertions(+)
>=20
> diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supp=
ly/max77705_charger.c
> index b1a227bf72e2..ff1663b414f5 100644
> --- a/drivers/power/supply/max77705_charger.c
> +++ b/drivers/power/supply/max77705_charger.c
> @@ -40,6 +40,18 @@ static enum power_supply_property max77705_charger_pro=
ps[] =3D {
>  	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
>  };
> =20
> +static irqreturn_t max77705_aicl_irq(int irq, void *irq_drv_data)
> +{
> +	struct max77705_charger_data *chg =3D irq_drv_data;
> +
> +	disable_irq(chg->aicl_irq);
> +
> +	queue_delayed_work(chg->wqueue, &chg->aicl_work,
> +		     msecs_to_jiffies(AICL_WORK_DELAY_MS));
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static irqreturn_t max77705_chgin_irq(int irq, void *irq_drv_data)
>  {
>  	struct max77705_charger_data *chg =3D irq_drv_data;
> @@ -445,6 +457,33 @@ static const struct power_supply_desc max77705_charg=
er_psy_desc =3D {
>  	.set_property =3D max77705_set_property,
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
> +		     msecs_to_jiffies(AICL_WORK_DELAY_MS));
> +	} else {
> +		enable_irq(chg->aicl_irq);
> +	}
> +}

After looking at this again in this simpler version: Why do you
need the delayed work at all? It seems you can simplify to this:

static irqreturn_t max77705_aicl_irq(int irq, void *irq_drv_data)
{
    struct max77705_charger_data *chg =3D irq_drv_data;
    unsigned int regval, irq_status;
    int err;

    do {
        regmap_read(chg->regmap, MAX77705_CHG_REG_INT_OK, &irq_status);
        if (!(irq_status & BIT(MAX77705_AICL_I))) {
            err =3D regmap_field_read(chg->rfield[MAX77705_CHG_CHGIN_LIM], =
&regval);
            if (err < 0)
                continue;

            regval--;

            err =3D regmap_field_write(chg->rfield[MAX77705_CHG_CHGIN_LIM],=
 regval);
            if (err < 0)
                continue;

            msleep(AICL_WORK_DELAY_MS);
        }
    } while(irq_status & BIT(MAX77705_AICL_I));

    return IRQ_HANDLED;
}

Greetings,

-- Sebastian

>  static void max77705_chgin_isr_work(struct work_struct *work)
>  {
>  	struct max77705_charger_data *chg =3D
> @@ -617,6 +656,12 @@ static int max77705_charger_probe(struct i2c_client =
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
> @@ -632,6 +677,16 @@ static int max77705_charger_probe(struct i2c_client =
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
> index 6653abfdf747..031c1dc2485d 100644
> --- a/include/linux/power/max77705_charger.h
> +++ b/include/linux/power/max77705_charger.h
> @@ -123,6 +123,8 @@
>  #define MAX77705_DISABLE_SKIP		1
>  #define MAX77705_AUTO_SKIP		0
> =20
> +#define AICL_WORK_DELAY_MS		100
> +
>  /* uA */
>  #define MAX77705_CURRENT_CHGIN_STEP	25000
>  #define MAX77705_CURRENT_CHG_STEP	50000
> @@ -185,7 +187,9 @@ struct max77705_charger_data {
>  	struct power_supply_battery_info *bat_info;
>  	struct workqueue_struct *wqueue;
>  	struct work_struct	chgin_work;
> +	struct delayed_work	aicl_work;
>  	struct power_supply	*psy_chg;
> +	int			aicl_irq;
>  };
> =20
>  #endif /* __MAX77705_CHARGER_H */
>=20
> ---
> base-commit: 846bd2225ec3cfa8be046655e02b9457ed41973e
> change-id: 20250830-max77705_77976_charger_improvement-e3f417bfaa56
>=20
> Best regards,
> --=20
> Dzmitry Sankouski <dsankouski@gmail.com>
>=20

--apzq35hofjb3hln6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmjRzYkACgkQ2O7X88g7
+pqwkRAAqMCFdV0RLB0wWNB8mejioEGdtJJqmMDWyD2M2+HLPwfqvSYlvKKKFEL8
eU0MOjpKKdYP1Lo6m0ZbYIpJxPiLoXGToOdbwtjr44/y97QPaf9jF71xYSEnN1Gs
rsDeSFncD7dBXX1wayjgjfADznImbMOsjRfioRLLrTD7Xd7AjJDJ+eFOc1u5/f0e
qupMjjF5KkO2mt6X7FSfRwsn3DcEvyHs1lJ1KYwfOnC1i82OfG3QQ1hZ2PtJHUnA
zoHyAM4Q3GPyn6HejdaBZJH8HhxQrgdv2idKpr51S9Wxzh/JfQ6+Boa9pNLq809G
T0tyFr06O1vpGWsNAETFmDpxH2qbmHuHCURVP7hccM+ny4i5pZO7W1ic+Ik2TzNQ
l0jDTD+UjcjATRakHvrCfqA+pLKq1vMs3rFL8YdZTrbqqrweD9FEOtjnAszim1Qg
8GA8RMaE+urnWTg+D73ZLYhJwztxbQjFSSjEb5AP//qA81wocEkSXXUJq6pm9ryn
lKuKyoqKBxWWQ+VlhWWeqqgDOrKIVaf7GhCDauie1OHW8Yhd3TybZ7xA8sHRROc5
u3BNxhizQ/BB6m2OMqF4ZBJxIJjs6N6dqp9EiZy/+Z9GvgklbYBhlHBoUAn4O7cJ
ky1OR0R/ttTzKKwVJ1X2sHbfhdZ7R28tEu1fXJAuxEgscqRVk7M=
=2EFx
-----END PGP SIGNATURE-----

--apzq35hofjb3hln6--

