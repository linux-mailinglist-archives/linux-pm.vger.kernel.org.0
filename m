Return-Path: <linux-pm+bounces-42751-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCpAEp1plGlFDgIAu9opvQ
	(envelope-from <linux-pm+bounces-42751-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 14:14:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E80DD14C734
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 14:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ED77302802D
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 13:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF3E36167A;
	Tue, 17 Feb 2026 13:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OAPNoYdu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70029361DC4
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771334040; cv=none; b=gsJrOyb1cajHdDpDZEdNEPfE9Kc1KmyQHmX1FJjXsszh7RH/cFMf3k5mRl4d5KMljha0BrkyB0gZooJpigqQJQXMC1sDhyFITodMagDSVMG24jupnGzGARDbNrjNvI/4q55t7WAxjvc2UeEIX8ks01dCDRCPqTTVeVHmOARxYwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771334040; c=relaxed/simple;
	bh=ghiYn5zctv6YevvmbOXMIchikB5+PZqKiOLbd6hIvi0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aRFRwYjtBAPTVjD3X3XrBIgmR93CReUuo6iTS9K+ph+dqqcv0YwzjIQLDcwHMXe4LLIOjInjmB7hxP2dz1lUFgDct4REaUbN4mT2PPRey0QKzO9TdEjMO/kDGDBTmt4tmDH70uUXIpLH5wFdLaAkNQ8prIyYsqe2oo1A/tV9Oeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OAPNoYdu; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-65a36583ef9so7091226a12.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 05:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771334035; x=1771938835; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x1C0IPnydug6rw3V3fM8YPHePn3LBKfIJJtqgR74b5I=;
        b=OAPNoYduWYQSL32nmW69nrWuR03uaN696N+g+GsecDLfcQGnKikRKlnwjFXm7jZIvC
         VoUbx7IkICPpby2qPD748XaG4VJS0thzOiDW5SBPdgEdPEKLH1Q+W+yf75nnkHf68qN7
         JEQloHR++epOZTLfmKq90FhtXesttZPXg8/S2nFvytEY1oyGxqS1EsW0P3n89H77zDaA
         M+HtcBqQX1L0pNaoiIeMDg00dLoF0r3BhFlL6hmkeqN4bWToklocg6n6hiBKVShGqr+P
         Vsvc0o2lFLkLYbnhoulvgEESi2/EFr5uHYV66j/ChgtXBh+MXCpJDl0XtChzUdEssfOT
         xD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771334035; x=1771938835;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x1C0IPnydug6rw3V3fM8YPHePn3LBKfIJJtqgR74b5I=;
        b=PbZtctM526ZaE/bdg96j1A2qjZ7qUz3fNbxKIjMRhgZAPuvnNrGqUwSOLA4fP4cecV
         xK2TjkgjxMDnt5hZmkTrFBMHR0jsae3RsBfwJcVeXpzlhuofN82dtQIUTqk8ZbtowN8m
         5Gn2yeXL4v9GcDqsIIfiMgcBJuznMLJw63gXJGL3JeXSa4xvsJP6VvEITNx8JqaF3aLq
         LmDT7Z+Icmzl4dNqDWSaKOsxTrn/Ra2r+7j4aV09DZ/sPfs0HVKuD3KOGnnUxTLCgel4
         I7I7mGWC98Y+viKM7JgFU+sXNlVVVLP+hstGPjPdu0GPxmg5LGaAm26vkW3IZjJoBIGW
         lk2A==
X-Forwarded-Encrypted: i=1; AJvYcCWkabgXLqulQN1g5b46WDKFCx4fxl0cHww7v2XttLHDp0c5D5F00fQY1ZqqjGAvKltOgH7vKgyEWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfQ98FlGZxbEtIYXZ/h/LMogtVq0gbmtPXxy61aI9uc++v8RfN
	bWOiMhB7GN0IZz2kmIepHIFyFGFgHpAgJsMKsfPPY/MuWafzjksTPEK3lE5MM4nWml0=
X-Gm-Gg: AZuq6aLqv1WgM+AZlwmCSkxvAZqBduHyo0gSHejltGZY/+iY6hjn6psSM+enkxbowdn
	oYsiPV1Eq1uhAVa/E0KVkT74zLODpywH/0PXexXHHPvcKbqzLElLh4lQCQYizopXaROnF5WHbPZ
	IuDqpoGjdGCjz3pM3hkp7GjyAAM1FamSMiGbN2gw+u+aanTmDx+dF9A+WvOkpggwZK3qmfLln5I
	0duA2HYytI7V2FxHAKQUZ3tbySr2TVysW2aE5QKrMTPwARcgUk0ETBTx9BariJrfu14Olps01JM
	bLAuUuHKLVqWUgk0piLkLU0+2FgHn5XsdXOFfdLDwEgZOKejiHqdrMfv9Yjy8EBAzGxjp0mtoG7
	mPnbQ4hHzl86UO/c35a2yVGRf5jnH/ujPbLyK2biezBTX1aDL6tENIJI69Lpoi+8roCFZjaL9z7
	w3Ho7eGTOTeNV7XKgrRiLjVThCJkE=
X-Received: by 2002:aa7:d719:0:b0:641:88ff:10ad with SMTP id 4fb4d7f45d1cf-65bc4298c44mr4741148a12.14.1771334035506;
        Tue, 17 Feb 2026 05:13:55 -0800 (PST)
Received: from draszik.lan ([212.129.84.5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65bad4fa7c7sm2473768a12.31.2026.02.17.05.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 05:13:55 -0800 (PST)
Message-ID: <0b6e7cb7223e553d9b53df464959e97fd3d1ce43.camel@linaro.org>
Subject: Re: [PATCH v6 5/6] power: supply: max77759: add charger driver
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: amitsd@google.com, Sebastian Reichel <sre@kernel.org>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Peter Griffin
 <peter.griffin@linaro.org>, Tudor Ambarus	 <tudor.ambarus@linaro.org>, Alim
 Akhtar <alim.akhtar@samsung.com>, Mark Brown	 <broonie@kernel.org>, Matti
 Vaittinen <mazziesaccount@gmail.com>, Andrew Morton	
 <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, RD
 Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>
Date: Tue, 17 Feb 2026 13:14:14 +0000
In-Reply-To: <20260214-max77759-charger-v6-5-28c09bda74b4@google.com>
References: <20260214-max77759-charger-v6-0-28c09bda74b4@google.com>
	 <20260214-max77759-charger-v6-5-28c09bda74b4@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2+build4 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42751-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[google.com,kernel.org,linuxfoundation.org,linux.intel.com,linaro.org,samsung.com,gmail.com,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:mid,linaro.org:dkim,linaro.org:email]
X-Rspamd-Queue-Id: E80DD14C734
X-Rspamd-Action: no action

Hi Amit,

All below comments are only minor, feel free to ignore them.

On Sat, 2026-02-14 at 03:12 +0000, Amit Sunil Dhamne via B4 Relay wrote:
> From: Amit Sunil Dhamne <amitsd@google.com>
>=20
> Add support for MAX77759 battery charger driver. This is a 4A 1-Cell
> Li+/LiPoly dual input switch mode charger. While the device can support
> USB & wireless charger inputs, this implementation only supports USB
> input. This implementation supports both buck and boost modes.
>=20
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> ---
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +
> =C2=A0drivers/power/supply/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 11 +
> =C2=A0drivers/power/supply/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/power/supply/max77759_charger.c | 768 +++++++++++++++++++++=
+++++++++++
> =C2=A04 files changed, 786 insertions(+)

[...]

> diff --git a/drivers/power/supply/max77759_charger.c b/drivers/power/supp=
ly/max77759_charger.c
> new file mode 100644
> index 000000000000..d4e02764ba04
> --- /dev/null
> +++ b/drivers/power/supply/max77759_charger.c
> @@ -0,0 +1,768 @@

[...]

> +
> +/* USB input current limits (in uA) */
> +static const struct linear_range chgin_ilim_ranges[] =3D {
> +	LINEAR_RANGE(100000, 0x3, 0x7F, 25000),
> +};

Shouldn't this one also have a entry for 0x00...0x02:
	LINEAR_RANGE(100000, 0x0, 0x2, 0),

Then you can also drop the umax() call in get_input_current_limit().

Ah, I see now there is no linear_range_get_selector_within_array(),
meaning the code is fine as-is, unless you want to add that as
well :-)


[...]

> +static int max77759_charger_init(struct max77759_charger *chg)
> +{
> +	struct power_supply_battery_info *info;
> +	u32 regval, fast_chg_curr, fv;
> +	int ret;
> +
> +	ret =3D regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_00, &regval=
);
> +	if (ret)
> +		return ret;
> +
> +	chg->mode =3D FIELD_GET(MAX77759_CHGR_REG_CHG_CNFG_00_MODE, regval);
> +	ret =3D charger_set_mode(chg, MAX77759_CHGR_MODE_OFF);
> +	if (ret)
> +		return ret;
> +
> +	if (power_supply_get_battery_info(chg->psy, &info)) {
> +		fv =3D CHG_FV_DEFAULT_MV;
> +		fast_chg_curr =3D CHG_CC_DEFAULT_UA;
> +	} else {
> +		fv =3D info->constant_charge_voltage_max_uv / 1000;
> +		fast_chg_curr =3D info->constant_charge_current_max_ua;
> +	}
> +
> +	ret =3D set_fast_charge_current_limit(chg, fast_chg_curr);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D set_float_voltage_limit(chg, fv);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D unlock_prot_regs(chg, true);
> +	if (ret)
> +		return ret;
> +
> +	/* Disable wireless charging input */
> +	ret =3D regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_12,
> +				 MAX77759_CHGR_REG_CHG_CNFG_12_WCINSEL, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_18,
> +				 MAX77759_CHGR_REG_CHG_CNFG_18_WDTEN, 0);
> +	if (ret)
> +		return ret;
> +
> +	return unlock_prot_regs(chg, false);

Should early error returns here try to lock the protection again? Something
like:

+	ret =3D unlock_prot_regs(chg, true);
+	if (ret)
+		return ret;
+
+	/* Disable wireless charging input */
+	ret =3D regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_12,
+				 MAX77759_CHGR_REG_CHG_CNFG_12_WCINSEL, 0);
+	if (ret)
+		goto relock;
+
+	ret =3D regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_18,
+				 MAX77759_CHGR_REG_CHG_CNFG_18_WDTEN, 0);
+	if (ret)
+		goto relock;
+
+	return unlock_prot_regs(chg, false);
+
+relock:
+	(void) unlock_prot_regs(chg, false);
+	return ret;

I guess if one of the regmap_update_bits() failed, then locking the
registers might not work either, so I have no strong opinion on
adding that.

With or without updates:

Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>


Cheers,
Andre'

