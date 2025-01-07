Return-Path: <linux-pm+bounces-20005-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BDDA03D28
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 12:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1266E3A14E1
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 11:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70C01E5713;
	Tue,  7 Jan 2025 11:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xRbHwSUK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89031E9B06
	for <linux-pm@vger.kernel.org>; Tue,  7 Jan 2025 11:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736247623; cv=none; b=Rp82XrPcZ0XU3HT/ffhijp4QutWEm2ZMz2GnVXbBCRzcERnqrhrQwcvcG13Bc+v1nEbCudM6oAs9weBMblNGFl8iexBjz7QpNQEOiSsEC6l3tY6DX0TGiEZBNifwrAcWaceGTGIQfZSU74XVf16hPjbHpq1LrvXdhGEe+Fc28w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736247623; c=relaxed/simple;
	bh=h3VqLLJkYSL/Yzsi2h/Imjy/edDJq9YgtMjCyL5BxQA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LQn36YfUUrKLT36LbGPwJwHhu6lRcuDeM4YDPxO6TiS79hbLcX5mPDjXfO8Gl+XXhuU8q3B9o+ilV+rtaM+6dPoqUaWW9sAa7d66ksfTrrZJdpIAZUFOR+CwVeuycy4ffVI13eQ7mpMXQNbGYL5L/au5eYeWop+s99LEz2TfJZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xRbHwSUK; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4362f61757fso152636705e9.2
        for <linux-pm@vger.kernel.org>; Tue, 07 Jan 2025 03:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736247618; x=1736852418; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GgermC1KnnvFeBi+HFB4kuvSBtuR8pO8/HIDUgPUHKg=;
        b=xRbHwSUKHEHi4z/VmtwsoqSfzgQ4PMCJ6PwRwJ2c6V+n+tzbPKouW85zkIhGQBmFjQ
         n951oxUWVBn6R5wKXdiVOziud3Tx6EECDmTnzc3yX5IdTjC/V12YeWfuhrdbvq6d1wju
         SGmLmwktar4mmE4MU4NHpFWzAlAovf+0VM4V7Fa0PbgtrY3KDFUq4LtNDuT2TYc6ABHN
         hWfsVLzd+1l5Gb7G7pjHFOFMyaE6F0At7RNjqIGZEd4HZIUSFr04ooydJX4Crc/XP2jy
         YeP3wt5VL7T72ZRyBZjaS9/a+pkagVyA9vNUy9bMgEGvLyMWX9CufvXqh5xR5ttGD06F
         LljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736247618; x=1736852418;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GgermC1KnnvFeBi+HFB4kuvSBtuR8pO8/HIDUgPUHKg=;
        b=pS6Ucbiv1viQORMp/L4lp9fWYK4RjfIzij42vaaynqh7mV+83vlVKQyqqaTZJIJE+Y
         ngLTktv7GzLJBwGiX0XAhLbJX691hELlkoRS8ELLGW9N5xUPJAzbOszpzw+9rbh0n08N
         f56OHHr1IqoZl/inUVRDd8B4EHuTc5lTNWqX+qilIZDwPDshKuOXNBfU824go6zfn5Dh
         3LGKJoQ6tAiX2/QT0BR0Lo6fZXq0exLDryYX8R4Zjn1JDJSUQNPSSPNTl7ASaI0TrJ8z
         oRYH9AymTay0M3LMz6GTty4q0ncN3USsjtHkBw6kcj+pzZDb3Lkzkm5qF7Kul8oYNHRz
         198A==
X-Gm-Message-State: AOJu0Yw6M2/ty18Q+cRKcenoOzGB/cLx/Of9UErn9hKwRPwYwis5hMAD
	/SmF62ryuIiCK89Idg8zKLRX57+RMRKqU+dnwF3yBwMPodV6ZeddzpbCanmbZSo=
X-Gm-Gg: ASbGncvU/DD3UxOh5+07Umoc7Oz3aKT/ft0Xi/AEpnHssK+NVo7hRCG9AxDfydcVlYu
	FDP/Ongh8WzMeiN3+vbeP1XEnQR3ME/vO6ugGhcDoaDHsWhCO6pyriws2Iwie+ZNdwdcT8kFbwT
	COwu8pauG8pwMtlF1aFBThF6AxAqfgVAYAgrsGtdhfhxreqkHYPH3j9JJMLTVs3d3gGPXl1zmIg
	jRNMTISyUlbiWYhHQp0J+kTvi0TIizHGmvlOOX/9AElGDZf48XX4y4WnB5J
X-Google-Smtp-Source: AGHT+IFbec8gno5r3txZurFgpWnFa2Tw0B1U6ohzIg8oPkTeYV0R3Aylb3f7FAu8YsrgrAe4AIIpRA==
X-Received: by 2002:a05:600c:4f03:b0:435:1a2:2633 with SMTP id 5b1f17b1804b1-43668645cf5mr573322825e9.15.1736247617728;
        Tue, 07 Jan 2025 03:00:17 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436611ea387sm599851945e9.6.2025.01.07.03.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 03:00:17 -0800 (PST)
Message-ID: <7178eb322fafaf0fbcdc4b91d9f9a65d996e4e6b.camel@linaro.org>
Subject: Re: [PATCH v2 1/4] power: supply: add support for max77759 fuel
 gauge
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: t.antoine@uclouvain.be, Sebastian Reichel <sre@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Peter
 Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Date: Tue, 07 Jan 2025 11:00:16 +0000
In-Reply-To: <20250102-b4-gs101_max77759_fg-v2-1-87959abeb7ff@uclouvain.be>
References: <20250102-b4-gs101_max77759_fg-v2-0-87959abeb7ff@uclouvain.be>
	 <20250102-b4-gs101_max77759_fg-v2-1-87959abeb7ff@uclouvain.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Thomas,

Thanks for your patch!

On Thu, 2025-01-02 at 12:15 +0100, Thomas Antoine via B4 Relay wrote:
> From: Thomas Antoine <t.antoine@uclouvain.be>
>=20
> The interface of the Maxim max77759 fuel gauge has a lot of common with t=
he
> Maxim max1720x. The major difference is the lack of non-volatile memory
> slave address. No slave is available at address 0xb of the i2c bus, which
> is coherent with the following driver from google: line 5836 disables
> non-volatile memory for m5 gauge.
>=20
> Link: https://android.googlesource.com/kernel/google-modules/bms/+/1a68c3=
6bef474573cc8629cc1d121eb6a81ab68c/max1720x_battery.c
>=20
> Other differences include the lack of V_BATT register to read the battery
> level and a difference in the way to identify the chip (the same register
> is used but not the same mask).

It also seems the reported POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN is
quite a bit off - on my Pixel 6, it reports ca. 1131mAh, but the downstream
stack reports a more reasonable 4524mAh. Interestingly, this is an exact
multiple of four.

POWER_SUPPLY_PROP_CHARGE_FULL is off in a similar way, and I suspect that
related properties like charge_avg, time_to_empty, time_to_full are
reported incorrectly as well.

[...]

> @@ -483,14 +608,27 @@ static int max1720x_probe(struct i2c_client *client=
)
> =C2=A0	psy_cfg.drv_data =3D info;
> =C2=A0	psy_cfg.fwnode =3D dev_fwnode(dev);
> =C2=A0	i2c_set_clientdata(client, info);
> -	info->regmap =3D devm_regmap_init_i2c(client, &max1720x_regmap_cfg);
> +
> +	data =3D device_get_match_data(dev);
> +	if (!data)
> +		return dev_err_probe(dev, ret, "Failed to get chip data\n");
                                          ^^^
This should be -EINVAL.


Cheers,
Andre'


