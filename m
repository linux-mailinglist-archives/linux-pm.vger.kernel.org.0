Return-Path: <linux-pm+bounces-24873-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C215AA7DC44
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 13:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEEE016FAAB
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 11:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4D423C8A1;
	Mon,  7 Apr 2025 11:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VdRiM1KN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FADD23BCF4
	for <linux-pm@vger.kernel.org>; Mon,  7 Apr 2025 11:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744025355; cv=none; b=pBkiE7OM3qVzE6SI+VZ2NAcJ8eL/k2j4LCqDw3cFVF1Hrc2L52WuPTssVkDD/ra9ZzxvLAEOvT8mlDNdsnEWUXmppAZ8D293n1072fOpnNX9v+YpmoF0L9mPWa3BUwMmBUfGByioDyNh82RJxzghWyvtrtQtHJFx4IVDssa2YcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744025355; c=relaxed/simple;
	bh=H2FKZXIS+hwA9vu7ou/PvLDYV8ymkbl31adVzvN6naI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QtXvspexrWswPjD1xgTrNPMxTb8nJd4Kf/rPId2pv37GiOtMnOuYe/C/fXTbZHwmtzyLk21XfrRI0sBiD7LyixXbPfLb+a2yZjgnxLY16c25Q//jTMhWp+zz5sKXZKaJ72lVxz2MxrOiHbzlwRqZWmSuxhZeN8gncHUJusDmShc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VdRiM1KN; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cfe574976so28596995e9.1
        for <linux-pm@vger.kernel.org>; Mon, 07 Apr 2025 04:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744025351; x=1744630151; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3ERzJBk8IPAt2EVC29UOPORnzeO9/Agn8egECrfbp4E=;
        b=VdRiM1KN3k56gGv/Zn79b5fCDlcQnSqwuAhYuoSvXBRIu6mnFsgKHzQ9kEmZmIc5An
         4njIiXTw+v+rksLV9lmeVw4YJefwPUVP3fsBg8Rnk6gE/WrYz39iuzXTUBqc+O5wKeco
         qEM/sm5CxxLpuewRsjDZfFIYyNnbZacJbcFIt5NlkVltPvCsQZAWBahAZMGeoNq5ox3R
         9F6EsKzj0KXcj7s+NsHGAqUtCDWx+jKjVqtfRqHOartUyR31qFdGR+ty4ZdnfKrgVj+i
         yozKtOON4+el+vX50KES/fgGIktrZLzduPXMfMRzYtS/YGdXmFDAsOby2gz25nwTwli+
         R9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744025351; x=1744630151;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ERzJBk8IPAt2EVC29UOPORnzeO9/Agn8egECrfbp4E=;
        b=aQ6lyC4PfWQHMEfccdYh+42I+7eYHxM2mzTiMeEtmTWcvbZZyvUPcreqUFAHaDblRh
         P6GNy/vgvTbdsd2LD7Td1vIzSPCMaNywPMlN+0O2Zi5Lnvdr8OT23Ijyff1CWcuYPwzd
         yjvL2IblNYsqlgSoODK8lW4uswwxzdaQaG60Zc8IjV/MmAJLMnr4JmemQIbEVjiUa6GG
         2tHpdWuE+SuYYeaz5Sj3poZJ3uWCdZBejh/NZH8pbbk9xg8j4MXxPcglD7vePkrw3d45
         7xrAaiENgyXcA5wVuj2GBnV16qt7AsLSSyMuGB4BLPCwuK0OgRDqsZRC+P4FWbgtSBeU
         TM4w==
X-Forwarded-Encrypted: i=1; AJvYcCViWDun/mWPPHZiGJNSkJWMURx/T+CyDAWRjuO+CHFyi7khATIk5R+9fbRxV5AqCSgArkoR+CHshg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCDaWiRk2dMzuGZqfRv+ECga1n7cDjmzNJpVVdZQcMxLcRbFXP
	XOlgbVjHsBYC8Y1OYLAgm/yjp29BOjRboc9OwPxuVhR+oNQHZA7Ncal6BhWOsDI=
X-Gm-Gg: ASbGnct0bTpTqlWo8pY6WlAQn7Ug3cYMFi0edf2JK+3rT590hcfKeMaXu2JaMAEHBy0
	M6BMmdIBUeEXdXgKAn7rOteIMK8qS9hVKz5Yq2TEZSAqMzV2o3iBP0F+nCDNMP7fEUAjTzG7vbM
	H0z5+2TYj2xMV8tAKlLZns3GmYHyLicoWh3Jbjywgp3pkl8gIH3SwVqT+iEgIJHiD53nvb/QOpv
	QgWIFG85E9scbo2RF81iAsazSIG1EM7TDiME8UTzqnilLlrvAITFRMy4lJd9+DcEntwH2RSsZ57
	Zl3Hm6mbL6IMI2mqxN2uJI/Gncgb0FEzG32T9aHUkksWwff74Q==
X-Google-Smtp-Source: AGHT+IHtEoJKmUalkAqnYfLWQZZGYmoLGxJQg28JsvyBQ+EeaUcWAKIPYLpm04Je/UzWyzE9mqSY3Q==
X-Received: by 2002:a05:600c:4e8f:b0:43b:cb12:ba6d with SMTP id 5b1f17b1804b1-43ecf81be20mr130447345e9.3.1744025350842;
        Mon, 07 Apr 2025 04:29:10 -0700 (PDT)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301a79bfsm12098345f8f.36.2025.04.07.04.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 04:29:10 -0700 (PDT)
Message-ID: <9264729152cb70ec910b391ab4ced82dc62f953c.camel@linaro.org>
Subject: Re: [PATCH v2 1/4] power: supply: add support for max77759 fuel
 gauge
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>, 
	t.antoine@uclouvain.be
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Dimitri Fedrau
 <dima.fedrau@gmail.com>, Catalin Marinas	 <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Peter Griffin	 <peter.griffin@linaro.org>, Alim
 Akhtar <alim.akhtar@samsung.com>, 	linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, 	linux-samsung-soc@vger.kernel.org
Date: Mon, 07 Apr 2025 12:29:09 +0100
In-Reply-To: <ocx5n42h25ztwo5twlir5zoajavpcxce2ra5jjyl6ae4qg6c3e@akhc3dylsprm>
References: <20250102-b4-gs101_max77759_fg-v2-0-87959abeb7ff@uclouvain.be>
	 <20250102-b4-gs101_max77759_fg-v2-1-87959abeb7ff@uclouvain.be>
	 <ocx5n42h25ztwo5twlir5zoajavpcxce2ra5jjyl6ae4qg6c3e@akhc3dylsprm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2-1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Sebastian,

On Wed, 2025-01-15 at 22:30 +0100, Sebastian Reichel wrote:
> Hi,
>=20
> On Thu, Jan 02, 2025 at 12:15:03PM +0100, Thomas Antoine via B4 Relay wro=
te:
> > From: Thomas Antoine <t.antoine@uclouvain.be>
> >=20
> > The interface of the Maxim max77759 fuel gauge has a lot of common with=
 the
> > Maxim max1720x. The major difference is the lack of non-volatile memory
> > slave address. No slave is available at address 0xb of the i2c bus, whi=
ch
> > is coherent with the following driver from google: line 5836 disables
> > non-volatile memory for m5 gauge.
> >=20
> > Link: https://android.googlesource.com/kernel/google-modules/bms/+/1a68=
c36bef474573cc8629cc1d121eb6a81ab68c/max1720x_battery.c
> >=20
> > Other differences include the lack of V_BATT register to read the batte=
ry
> > level and a difference in the way to identify the chip (the same regist=
er
> > is used but not the same mask).
> >=20
> > Add support for the max77759 by allowing to use the non-volatile
> > memory or not based on the chip. Also add the V_CELL regsister as a
> > fallback to read voltage value in the case where read of V_BATT fails.
> >=20
> > The cast is necessary to avoid an overflow when the value of the regist=
er
> > is above 54975 (equivalent to a voltage around 4.29 V).
> >=20
> > The regmap of the max77759 will lead the read to fail for V_BATT and to
> > correctly use V_CELL instead. This regmap was proposed by Andr=C3=A9 Dr=
aszik in
> >=20
> > Link: https://lore.kernel.org/all/d1bade77b5281c1de6b2ddcb4dbbd033e455a=
116.camel@linaro.org/
> >=20
> > Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
> > ---
>=20
> Please add output from to the cover letter to allow easily verifying
> that all values are correctly scaled.
>=20
> ./tools/testing/selftests/power_supply/test_power_supply_properties.sh
>=20
> > +static const struct regmap_access_table max77759_write_table =3D {
> > +	.yes_ranges =3D max77759_registers,
> > +	.n_yes_ranges =3D ARRAY_SIZE(max77759_registers),
> > +	.no_ranges =3D max77759_ro_registers,
> > +	.n_no_ranges =3D ARRAY_SIZE(max77759_ro_registers),
> > +};
>=20
> Drop the yes_range from the write table. It is wrong and confusing.

Can you please clarify why having yes_ranges is wrong? Without yes_ranges,
all registers not in no_ranges are allowed to be written to.

Here, max77759_registers already specifies all the registers that exist
(and is also used in the max77759_read_table), and for write-access this is
further limited by the read-only registers in no_ranges.

As an example, register 0x50 doesn't exist, and without yes_ranges this
would allow write access to it.

If yes_ranges was dropped, all the information about non-existing registers
would have to be duplicated into no_ranges by inversing max77759_registers.
We already know the non-existing registers, and inversing that list just to
add to no_ranges seems non-ideal, error-prone, and just duplicated informat=
ion.


Cheers,
Andre'


