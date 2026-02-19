Return-Path: <linux-pm+bounces-42873-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPYqGWUyl2kcvgIAu9opvQ
	(envelope-from <linux-pm+bounces-42873-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 16:55:17 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE951606CA
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 16:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D860300E716
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 15:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BFC34AB03;
	Thu, 19 Feb 2026 15:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yV9ak2c9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F17334A76E
	for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771516349; cv=none; b=lyOtFZFAnAd7CBOtN94ng0M8qGe4Cwrv/i3B4AVHiqbO2JWOXNYKkZdilb0OAWZM5Lbqg4ezMxC33AmwolXe/nCV+8L1wWbIN0UjJKWSSxqwJ7kHledoJsdjYre4ZyclomrwEsOi0lLuc5nt3nqyusJ6OcnbqfHN4Y39dUKsLdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771516349; c=relaxed/simple;
	bh=hUVMfsGdV0aDbsIFOhfMsdPp5kAixuq61G/flR5Alxg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j+Gt46gm+8H+t+C9ecVuhfgIufExotJFpSdwXzCXUBeTg3RtkloPPmGy7WxoYJMclq43TgdZ65i9ayrXDTEOIQqY1NR47N7jJTAA9HkPASEm7cMMENtEqlyUSFolehWJ6GUKpuqDZq0wyd9aNF4iHm1fVmWjYaUhLSCHgdU3t2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yV9ak2c9; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43767807cf3so874535f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 07:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771516346; x=1772121146; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ausNYp9VNOhe1fBHOC525G26Oe60ih9EhrjdJ5sgpHg=;
        b=yV9ak2c9B8AV5lOFP2+ASu81htz4cub/EZEvHYTW6zwjxUR0sbJ3wNLOLEVTKUmniP
         Qg8C9YIASU2HiwGMvPlurEY5c/W3ET39r5gHOJ7kUZ+EdIEmraU0C24ueJM7mACg4PmJ
         ZfaKOqaNq0ptYYVRRMX/2DHWJTvP5sWZtMhaFvPE44b9l5mW1CNB56MV1wLIGMvN3ZCF
         SFryge4s8mXDYNGrOiOCuw+MdBh1Y8yKQFnXe/eIgdyxSV7zBpnVZgUyCFBwgsdcqv/m
         m6kcXoAB49/10DVAJsXRUI1I8nt1XhrdEw8XOexD0Wc8vDpyODntZbRxMsk8939vdZAE
         JvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771516346; x=1772121146;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ausNYp9VNOhe1fBHOC525G26Oe60ih9EhrjdJ5sgpHg=;
        b=WeAciKgWY2hcCZb0Ms88lQl8MWRm5Vs8QggqwpVJWwFGMT8XjlzeveQiku2sE9qgZh
         0DP5BKsBzu81nuZPCW8YIx3F/8wSK0/ZtKqtyu/iZ5Q3P3BX84P9yYj5YD1sXcpGxvNh
         mQ2UiRQf5OSQQwI03s5DCms/3Nuuu8TRuunDOtDlRMJlY3q8+y61602Ol2H4S9jUjlFD
         nZfMbnG12jHzrYxrpPXu5e9m8wpOxvJKUzydIJ7rYV6/4rJehkdIfQ8j2JmJm1r1xTKm
         wJHRFI3e3x3TIPp1pINWXQRlFQG3hCi+oVK7XhTSKP1iFVYpMZT8jWlCVAlIa5Wv5olg
         yNMA==
X-Forwarded-Encrypted: i=1; AJvYcCUefbdSe9+XpDbvN1uY79vuMqzPcihpiNYI2OXyS6+HkgJlfq7MwkzStNlSZKDMdrr7YRo1Xj1hLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy277LfDBkPU7bkqJRfRDuP/uXDEIl7htVnBroRYbjTInAtTDQJ
	a8nnCiPYAk3MWowodSLi+1RNbnoXjfftxxOJSZsCS+IZw5OvxlxwbYJKWyLl3FOXb6A=
X-Gm-Gg: AZuq6aLjW9G1gtmC2VODOso7y1VmRyO7nUktPDXQKeOPyEZW1IxEloHx7daE4KpVgz5
	DX56owjSKp/fmXoYJllHk49E9CwHFGTytNBUf0/f/iWfw84jEyM+C/gezSglFiJEe7Ovh4xxQrk
	bNh1ppqWNL1+d248gDpynsHtXBwJO7In025GGOWX0e8Szy9i8ejeaFcsuvtaiD+tCBzf9uJKbFH
	vjDq9+L+IBhMfASinVhtgUnvGIDVng4j3TiWnlcP/hezh+Xw9B3rr3f9mkkbsV4Jz6m56PfeV2I
	Y1CkkNur9bo5gh46Q+m2DPTg26iMhBHk+KHW0NAQieEPiPUkFEyjN0z57WsERz0pAA7WX76Ix1t
	y8o0M2v1B/Qd0FLyvMi3cVchOLpgUvUJ9QVzmszoPTwWo50aM7zGklmCZ6c78tlhTsOtnURmAO7
	pZ0HSqA+tbmWjk6GLnW6Qi9cn3MEalMQ==
X-Received: by 2002:a05:6000:2001:b0:436:3475:4737 with SMTP id ffacd0b85a97d-4379db8cfddmr32328493f8f.30.1771516346564;
        Thu, 19 Feb 2026 07:52:26 -0800 (PST)
Received: from draszik.lan ([212.129.80.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a5ac7csm47748995f8f.7.2026.02.19.07.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 07:52:26 -0800 (PST)
Message-ID: <f46fa180198ec103aeb1e1c06286c6a2a0fb8b7f.camel@linaro.org>
Subject: Re: [PATCH v7 5/6] power: supply: max77759: add charger driver
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
Date: Thu, 19 Feb 2026 15:52:55 +0000
In-Reply-To: <20260218-max77759-charger-v7-5-e8d907ce69c5@google.com>
References: <20260218-max77759-charger-v7-0-e8d907ce69c5@google.com>
	 <20260218-max77759-charger-v7-5-e8d907ce69c5@google.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42873-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[google.com,kernel.org,linuxfoundation.org,linux.intel.com,linaro.org,samsung.com,gmail.com,linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:mid,linaro.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DDE951606CA
X-Rspamd-Action: no action

Hi Amit,

I was trying out your series and noticed a few things that I didn't before:

On Wed, 2026-02-18 at 21:59 +0000, Amit Sunil Dhamne via B4 Relay wrote:

[...]

>=20
> diff --git a/drivers/power/supply/max77759_charger.c b/drivers/power/supp=
ly/max77759_charger.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..035f16822d85de94c7707ce11=
c49345c714cd559
> --- /dev/null
> +++ b/drivers/power/supply/max77759_charger.c

[...]

> +		dev_err(chg->dev, "Invalid mode transition from %d to %d",
> +			chg->mode, mode);

All your format strings are missing the final \n throughout this patch.

[...]

> +static int max77759_charger_probe(struct platform_device *pdev)
> +{
> +	struct regulator_config chgin_otg_reg_cfg;
> +	struct power_supply_config psy_cfg;
> +	struct device *dev =3D &pdev->dev;
> +	struct max77759_charger *chg;
> +	int ret;
> +
> +	device_set_of_node_from_dev(dev, dev->parent);
> +	chg =3D devm_kzalloc(dev, sizeof(*chg), GFP_KERNEL);
> +	if (!chg)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, chg);
> +	chg->dev =3D dev;
> +	chg->regmap =3D dev_get_regmap(dev->parent, "charger");
> +	if (!chg->regmap)
> +		return dev_err_probe(dev, -ENODEV, "Missing regmap");
> +
> +	ret =3D devm_mutex_init(dev, &chg->lock);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to initialize lock");
> +
> +	ret =3D devm_mutex_init(dev, &chg->retry_lock);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to initialize retry_lock");
> +
> +	psy_cfg.fwnode =3D dev_fwnode(dev);
> +	psy_cfg.drv_data =3D chg;
> +	chg->psy =3D devm_power_supply_register(dev, &max77759_charger_desc,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &psy_cfg);
> +	if (IS_ERR(chg->psy))
> +		return dev_err_probe(dev, -EPROBE_DEFER,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to register psy, ret=3D%ld",
> +				=C2=A0=C2=A0=C2=A0=C2=A0 PTR_ERR(chg->psy));

Why are you returning -EPROBE_DEFER here instead of the original error? Thi=
s
is quite unusual.


Cheers,
Andre'

