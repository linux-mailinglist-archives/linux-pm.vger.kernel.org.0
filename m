Return-Path: <linux-pm+bounces-43345-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPuhHbrNoWn3wQQAu9opvQ
	(envelope-from <linux-pm+bounces-43345-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 18:00:42 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 648051BB217
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 18:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D74193019808
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 17:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DF3356A2B;
	Fri, 27 Feb 2026 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HpsN0kU0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85B035A39F
	for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772211633; cv=pass; b=b5bDVIFyMY85BffWB2oIkbgcH77dD1Y+kXFsqWUiRsrJDXdjv57WUYFv6iJN+eNj+VNLtVNpXGUAVRBWghcn6Pt+fpqx4Lv2e1hYI1YB3z76WSW4igZn3aAzQTu/nidy9ZJcQbPt4YgcK3a2PmtFpNXMlX6qO+Db9pNH3/6/UGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772211633; c=relaxed/simple;
	bh=I4x6DOk2cPSVl5wi5wU4uIp+LHt0Dmmaq3gwfuy85kU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FViLZueldSwE9aNvwUJztAcWwcwRtWcwKWSqADMePrtRdD1Y+1FGWdH3EQHE2r2mfa3VVRU0FgdzBkyNXvd8D6/H9dBQoSwnRtSAxcwtsMhthxvX1c7/D7Z9lNRhnl+EvWmQU4YIE/wQbGQMsbBFOVR2qFXhORdMMvV7Xahxv1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HpsN0kU0; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-65f73d68faeso3692950a12.3
        for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 09:00:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772211629; cv=none;
        d=google.com; s=arc-20240605;
        b=feiZtihoDnTpP4u4wijaB3qdezXEqo6XlGoQjywv1lt9h8xExFL8sDrYb6N0zMjeaf
         YzJiPyVPlm/exoQU3B6DThFwHg7wgWuNJOUCyuOl4gZipKisCkCYbmG8eB/tPdyaldvq
         UKe39owoqu7NwURxIsEGNcsbmcHo9rsq7MHNOTX9fPWl6m5ESbaxjFxwFn0JYvLJb+6j
         lHJjqgFAfXN9fxBr5RavRiTzpiyToQApiX+yO9ItDYKgBFQUPYpJ4lqTa1a2VJEDKkdR
         9FSvYc/84tbu3iFgAXHfzpyMfaMo/XBpmo9HhUBp0IS20we4MYjQsiqsBB7tP36ZeCdk
         bo8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hLWMlnv2U7TOk00daGoljagYqYJc1c1eO9SPI/R+a/4=;
        fh=frow23kIK1P/MFK1ehRNCkqvqetsB73Ms1jWHOSgoJY=;
        b=cTG6GAqaHf/zJid0uW75LnTCvzSgl4qlb28KDiKb/juNaS8VJRTuyQmFDkz7AGenAw
         haITeOIrK9ZZlvpxMKGGQc+gatjhhzHtQt/FE8olxfA/o5rmoNBRJ5SgllK/S4QgO2Do
         VC1sItkDWc4naM0AGrVJe9LWiUwLuZB2H0RiJLOx/xO3xkCTVrAINoTCsHaXrqOqmMgB
         mCwmtTWg4SFgniweiF3b+NAyZpo9Pgyb+TU//rt1f7Mkj1CfKK93eMJr7Y2F9BBsC1YG
         25YOdybVqUeePjJh8Vvs7R0+Y0vCuArgFn0MPNkSEG7Q2EXW0Imeudn7Gtxu2pMOzWVk
         rhmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772211629; x=1772816429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLWMlnv2U7TOk00daGoljagYqYJc1c1eO9SPI/R+a/4=;
        b=HpsN0kU087m9Xadit0IMPsvIRTD6UWJvZPU+dlPVDgfpBRZ/A/R0RaCwbXxqrQbSxM
         m16n3bo+1Z+JYz8XXNDHta0PFMc5k0gcS909oCpz757jm9Pr8OHeXmXVnyXj7r9yP7Us
         1SlYwZnVw9eIrRXdmIKtckn9siLharOJsyCrPpmZhvGpjI0oj4IHse8bRawlM20GAfDS
         4wTt5HcMrB4uXYAZODMKAo8uyZF9QkdMcUn1pQN0bZ5rpUWMrbDkolik0hKTaiMGPlVD
         R+60z2o1lJtcbrBZcOh1BAXJ5sVRZaw5DpQImCqxe1+6rwS2mU04KmnFHQ+DHvZN3zOJ
         gB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772211629; x=1772816429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hLWMlnv2U7TOk00daGoljagYqYJc1c1eO9SPI/R+a/4=;
        b=bOvVtapdd5z61ZOYuuvbmk326yFx7XoDWFr6kG8EdFkTwX/vH0eycN/WiN9FssXGlH
         UXw5jC3Ap6UV8KZwV4nDFQObGD7O4YQzdlZBLm5cFq9Q+BxBfzXMjTnAbPoEOtDtE/4b
         5e0nNNHij2X6uL5BIGuUXa9Z833kRyYR724xqW/4dcVXSiuAnWrRL2JrFLLaim7lUSM8
         LdMcHSgk87KiQdadNaoxJFdSUHiOYl6R7E702etKTpCxMgjv/DBf6srKaG3yM3jOGIZW
         /C78VPjdxaBIaJslrYCj60Q9XTv1AAuER3DHHNkRDcAwT52qaGBg39bgJM22hvtz3KTd
         /2ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUMnmd+d9jSXfaLnGkhuur8jRTm3qrWU01tl24SfUfuYw7AvEzUkPN/MMbMSDWNtuUwRrc8ofDLuA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKPYVvj1UteDO6KLevzv1IV/0llWXebQbNSIoEJ6LHB14/M9DH
	rClevrzdH5zp139EhQl4KIONsZdBLphKdws2U5DjsuTBzoMGGXLQBr1iEqHF4V1Vj4prw73lp3Y
	aC59SB1H0JUUumnuiZWco8MesA8p4XqM0uZ5UjHY89w==
X-Gm-Gg: ATEYQzwz3gOMCasExE9DvWW9/gju/e2Moyza0KIMZObS8YTZNpefHzGfDWQIVlA+2pR
	BwdOqSB8Gxieg+qVECjzzNau017ZCmaPmuaOwjfFkwiXVD6PFbs6Dg1aB1Caehkd20mDOt4VrOm
	DI1EqY7PwzuU2IBDLfiUsoap9z+m3BDRXVxONSbBc/LVc/FLD8PiF7w1FDZR09aRL/jAFJcAYvi
	mbzsu5J1vVNXGDorQf1sGNMFYkVTU22cm8EShAS03g1KWSwu4nJvSF38KGCkal08V2CeFfU65z+
	gSb6D2zZfndL7ZMvhf9hAGohtrSiGXyr
X-Received: by 2002:a05:6402:1e8e:b0:658:d18e:e8 with SMTP id
 4fb4d7f45d1cf-65fde4c92e6mr2188556a12.27.1772211628966; Fri, 27 Feb 2026
 09:00:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227-max77759-fg-v2-0-e50be5f191f0@linaro.org> <20260227-max77759-fg-v2-9-e50be5f191f0@linaro.org>
In-Reply-To: <20260227-max77759-fg-v2-9-e50be5f191f0@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 27 Feb 2026 17:00:17 +0000
X-Gm-Features: AaiRm51_hTA37XjdCfno31Y5GnQDl6D_8iR_DXyKyfcVXTMh4GcfcDJcYSRKYgY
Message-ID: <CADrjBPqo0+=GrVSxv_sg5=sCGXZiK9uHjr1FgwXuy-g8FzhJKg@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] power: supply: max17042: initial support for
 Maxim MAX77759
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, 
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, Purism Kernel Team <kernel@puri.sm>, 
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
	Amit Sunil Dhamne <amitsd@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43345-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[andre.draszik.linaro.org:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.griffin@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linaro.org:email,linaro.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 648051BB217
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 at 07:15, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> The Maxim MAX77759 is a companion PMIC intended for use in mobile
> phones and tablets. It is used on Google Pixel 6 and 6 Pro (oriole and
> raven). Amongst others, it contains a fuel gauge that is similar to the
> ones supported by this driver.
>
> The fuel gauge can measure battery charge and discharge current,
> battery voltage, battery temperature, and the Type C connector's
> temperature.
>
> The MAX77759 incorporates the Maxim ModelGauge m5 algorithm. It, as
> well as previous generations like m3 on max17047/max17050, requires
> the host to save/restore some register values across power cycles to
> maintain full accuracy. Extending the driver for such support is out of
> scope in this initial commit.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

> v2: fix typo MAX77759_T_convert -> MAX77759_Tconvert
> ---
>  drivers/power/supply/max17042_battery.c | 59 +++++++++++++++++++++++++++=
+++---
>  include/linux/power/max17042_battery.h  | 24 ++++++++++++--
>  2 files changed, 77 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supp=
ly/max17042_battery.c
> index 823533ea5a17..44626abdab34 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -654,7 +654,8 @@ static void max17042_write_config_regs(struct max1704=
2_chip *chip)
>         regmap_write(map, MAX17042_RelaxCFG, config->relax_cfg);
>         if (chip->chip_type =3D=3D MAXIM_DEVICE_TYPE_MAX17047 ||
>                         chip->chip_type =3D=3D MAXIM_DEVICE_TYPE_MAX17050=
 ||
> -                       chip->chip_type =3D=3D MAXIM_DEVICE_TYPE_MAX17055=
)
> +                       chip->chip_type =3D=3D MAXIM_DEVICE_TYPE_MAX17055=
 ||
> +                       chip->chip_type =3D=3D MAXIM_DEVICE_TYPE_MAX77759=
)
>                 regmap_write(map, MAX17047_FullSOCThr,
>                                                 config->full_soc_thresh);
>  }
> @@ -791,7 +792,8 @@ static inline void max17042_override_por_values(struc=
t max17042_chip *chip)
>
>         if ((chip->chip_type =3D=3D MAXIM_DEVICE_TYPE_MAX17042) ||
>             (chip->chip_type =3D=3D MAXIM_DEVICE_TYPE_MAX17047) ||
> -           (chip->chip_type =3D=3D MAXIM_DEVICE_TYPE_MAX17050)) {
> +           (chip->chip_type =3D=3D MAXIM_DEVICE_TYPE_MAX17050) ||
> +           (chip->chip_type =3D=3D MAXIM_DEVICE_TYPE_MAX77759)) {
>                 max17042_override_por(map, MAX17042_IAvg_empty, config->i=
avg_empty);
>                 max17042_override_por(map, MAX17042_TempNom, config->temp=
_nom);
>                 max17042_override_por(map, MAX17042_TempLim, config->temp=
_lim);
> @@ -800,7 +802,8 @@ static inline void max17042_override_por_values(struc=
t max17042_chip *chip)
>
>         if ((chip->chip_type =3D=3D MAXIM_DEVICE_TYPE_MAX17047) ||
>             (chip->chip_type =3D=3D MAXIM_DEVICE_TYPE_MAX17050) ||
> -           (chip->chip_type =3D=3D MAXIM_DEVICE_TYPE_MAX17055)) {
> +           (chip->chip_type =3D=3D MAXIM_DEVICE_TYPE_MAX17055) ||
> +           (chip->chip_type =3D=3D MAXIM_DEVICE_TYPE_MAX77759)) {
>                 max17042_override_por(map, MAX17047_V_empty, config->vemp=
ty);
>         }
>  }
> @@ -1023,6 +1026,45 @@ static const struct regmap_config max17042_regmap_=
config =3D {
>         .val_format_endian =3D REGMAP_ENDIAN_NATIVE,
>  };
>
> +static const struct regmap_range max77759_fg_registers[] =3D {
> +       regmap_reg_range(MAX17042_STATUS, MAX77759_MixAtFull),
> +       regmap_reg_range(MAX17042_VFSOC0Enable, MAX17042_VFSOC0Enable),
> +       regmap_reg_range(MAX17042_MLOCKReg1, MAX17042_MLOCKReg2),
> +       regmap_reg_range(MAX17042_MODELChrTbl, MAX17055_TimerH),
> +       regmap_reg_range(MAX77759_IIn, MAX77759_IIn),
> +       regmap_reg_range(MAX17055_AtQResidual, MAX17055_AtAvCap),
> +       regmap_reg_range(MAX17042_OCVInternal, MAX17042_OCVInternal),
> +       regmap_reg_range(MAX17042_VFSOC, MAX17042_VFSOC),
> +};
> +
> +static const struct regmap_range max77759_fg_ro_registers[] =3D {
> +       regmap_reg_range(MAX17042_FSTAT, MAX17042_FSTAT),
> +       regmap_reg_range(MAX17042_OCVInternal, MAX17042_OCVInternal),
> +       regmap_reg_range(MAX17042_VFSOC, MAX17042_VFSOC),
> +};
> +
> +static const struct regmap_access_table max77759_fg_write_table =3D {
> +       .yes_ranges =3D max77759_fg_registers,
> +       .n_yes_ranges =3D ARRAY_SIZE(max77759_fg_registers),
> +       .no_ranges =3D max77759_fg_ro_registers,
> +       .n_no_ranges =3D ARRAY_SIZE(max77759_fg_ro_registers),
> +};
> +
> +static const struct regmap_access_table max77759_fg_rd_table =3D {
> +       .yes_ranges =3D max77759_fg_registers,
> +       .n_yes_ranges =3D ARRAY_SIZE(max77759_fg_registers),
> +};
> +
> +static const struct regmap_config max77759_fg_regmap_cfg =3D {
> +       .reg_bits =3D 8,
> +       .val_bits =3D 16,
> +       .max_register =3D 0xff,
> +       .wr_table =3D &max77759_fg_write_table,
> +       .rd_table =3D &max77759_fg_rd_table,
> +       .val_format_endian =3D REGMAP_ENDIAN_NATIVE,
> +       .cache_type =3D REGCACHE_NONE,
> +};
> +
>  static const struct power_supply_desc max17042_psy_desc =3D {
>         .name           =3D "max170xx_battery",
>         .type           =3D POWER_SUPPLY_TYPE_BATTERY,
> @@ -1049,6 +1091,7 @@ static int max17042_probe(struct i2c_client *client=
, struct device *dev, int irq
>  {
>         struct i2c_adapter *adapter =3D client->adapter;
>         const struct power_supply_desc *max17042_desc =3D &max17042_psy_d=
esc;
> +       const struct regmap_config *regmap_config;
>         struct power_supply_config psy_cfg =3D {};
>         struct max17042_chip *chip;
>         int ret;
> @@ -1064,7 +1107,12 @@ static int max17042_probe(struct i2c_client *clien=
t, struct device *dev, int irq
>
>         chip->dev =3D dev;
>         chip->chip_type =3D chip_type;
> -       chip->regmap =3D devm_regmap_init_i2c(client, &max17042_regmap_co=
nfig);
> +
> +       if (chip->chip_type =3D=3D MAXIM_DEVICE_TYPE_MAX77759)
> +               regmap_config =3D &max77759_fg_regmap_cfg;
> +       else
> +               regmap_config =3D &max17042_regmap_config;
> +       chip->regmap =3D devm_regmap_init_i2c(client, regmap_config);
>         if (IS_ERR(chip->regmap))
>                 return dev_err_probe(dev, PTR_ERR(chip->regmap),
>                                      "Failed to initialize regmap\n");
> @@ -1245,6 +1293,8 @@ static const struct of_device_id max17042_dt_match[=
] __used =3D {
>                 .data =3D (void *) MAXIM_DEVICE_TYPE_MAX17055 },
>         { .compatible =3D "maxim,max77705-battery",
>                 .data =3D (void *) MAXIM_DEVICE_TYPE_MAX17047 },
> +       { .compatible =3D "maxim,max77759-fg",
> +               .data =3D (void *) MAXIM_DEVICE_TYPE_MAX77759 },
>         { .compatible =3D "maxim,max77849-battery",
>                 .data =3D (void *) MAXIM_DEVICE_TYPE_MAX17047 },
>         { },
> @@ -1257,6 +1307,7 @@ static const struct i2c_device_id max17042_id[] =3D=
 {
>         { "max17047", MAXIM_DEVICE_TYPE_MAX17047 },
>         { "max17050", MAXIM_DEVICE_TYPE_MAX17050 },
>         { "max17055", MAXIM_DEVICE_TYPE_MAX17055 },
> +       { "max77759-fg", MAXIM_DEVICE_TYPE_MAX77759 },
>         { "max77849-battery", MAXIM_DEVICE_TYPE_MAX17047 },
>         { }
>  };
> diff --git a/include/linux/power/max17042_battery.h b/include/linux/power=
/max17042_battery.h
> index c417abd2ab70..05097f08ea36 100644
> --- a/include/linux/power/max17042_battery.h
> +++ b/include/linux/power/max17042_battery.h
> @@ -105,7 +105,7 @@ enum max17042_register {
>
>         MAX17042_OCV            =3D 0xEE,
>
> -       MAX17042_OCVInternal    =3D 0xFB,  /* MAX17055 VFOCV */
> +       MAX17042_OCVInternal    =3D 0xFB, /* MAX17055/77759 VFOCV */
>
>         MAX17042_VFSOC          =3D 0xFF,
>  };
> @@ -156,7 +156,7 @@ enum max17055_register {
>         MAX17055_AtAvCap        =3D 0xDF,
>  };
>
> -/* Registers specific to max17047/50/55 */
> +/* Registers specific to max17047/50/55/77759 */
>  enum max17047_register {
>         MAX17047_QRTbl00        =3D 0x12,
>         MAX17047_FullSOCThr     =3D 0x13,
> @@ -167,12 +167,32 @@ enum max17047_register {
>         MAX17047_QRTbl30        =3D 0x42,
>  };
>
> +enum max77759_register {
> +       MAX77759_AvgTA0         =3D 0x26,
> +       MAX77759_AtTTF          =3D 0x33,
> +       MAX77759_Tconvert       =3D 0x34,
> +       MAX77759_AvgCurrent0    =3D 0x3B,
> +       MAX77759_THMHOT         =3D 0x40,
> +       MAX77759_CTESample      =3D 0x41,
> +       MAX77759_ISys           =3D 0x43,
> +       MAX77759_AvgVCell0      =3D 0x44,
> +       MAX77759_RlxSOC         =3D 0x47,
> +       MAX77759_AvgISys        =3D 0x4B,
> +       MAX77759_QH0            =3D 0x4C,
> +       MAX77759_MixAtFull      =3D 0x4F,
> +       MAX77759_VSys           =3D 0xB1,
> +       MAX77759_TAlrtTh2       =3D 0xB2,
> +       MAX77759_VByp           =3D 0xB3,
> +       MAX77759_IIn            =3D 0xD0,
> +};
> +
>  enum max170xx_chip_type {
>         MAXIM_DEVICE_TYPE_UNKNOWN       =3D 0,
>         MAXIM_DEVICE_TYPE_MAX17042,
>         MAXIM_DEVICE_TYPE_MAX17047,
>         MAXIM_DEVICE_TYPE_MAX17050,
>         MAXIM_DEVICE_TYPE_MAX17055,
> +       MAXIM_DEVICE_TYPE_MAX77759,
>
>         MAXIM_DEVICE_TYPE_NUM
>  };
>
> --
> 2.53.0.473.g4a7958ca14-goog
>

