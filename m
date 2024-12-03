Return-Path: <linux-pm+bounces-18447-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFA49E1A3C
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 12:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6192C1604D6
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 11:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC581E3777;
	Tue,  3 Dec 2024 11:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ceAdjcHw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDC11E32D0
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733223745; cv=none; b=s4/SDMkKNOHA2IXG6dWaXg6oJljmcT0f0k7qPMadtgBpd1uWMMkiWcgOw1DRCLzFwVrF8deykeGGDzRFgb1mTpzkc6f/uqrgOO+lkzCdPdtjB/KR4g+5VSUjRaF4qqngka+UE6Q96Vi72v4aNdCWlPNfP3+sesj/UHgfP2pl1og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733223745; c=relaxed/simple;
	bh=S7MzIWIrLWAbVF89l+Uf6tn+k9bQS3/RiimZVSw8N/c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b9hbOkSGHZity91O1QVzpyiNHlxlGaufKLf816KVtF1LvXg6lGlCvwDu8qJ3ImQvpZULsR1x5XF2lhOiZHErk2hPUfEe7TldZdwozerdRaH1m+5z6M793+ln1/O3JHJiJ9/GNLZ/0ucM43qkPP1XkBD5bb3XsgR8LVcKERrhfEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ceAdjcHw; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385de59c1a0so3933958f8f.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Dec 2024 03:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733223742; x=1733828542; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S7MzIWIrLWAbVF89l+Uf6tn+k9bQS3/RiimZVSw8N/c=;
        b=ceAdjcHwfjffVfcCZsVMRK/A1cVsLHxzmwTaVEQvw66v0uswrpr9oaf2I4o/cjr5Nf
         ny7PKInr0DxKITyZU2vSr2UpDjORLu1neNrjy/2DeXJpx/fAMW/hlqgswAw3uA0d9HYp
         VWh+APDkJrVy/b3VkrihZbQs7YL/X+bk2o5h4RulgLhC35O93d8eoj/Kby1cJSo0LIAk
         +40QlpqnLY+D+cfCJDcV3HI/teTKhQd4BoPfrtSST3B+BA4vK7N9aBKPjU69xZRtPgP4
         rwvqirbD6g09anoF4Jvn5cHm7GNCXjq3BpIwmN8o2VqbRpPbbLapQRak1jxpJk89dAF0
         8SzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733223742; x=1733828542;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S7MzIWIrLWAbVF89l+Uf6tn+k9bQS3/RiimZVSw8N/c=;
        b=buozppPtdyqRNjKdMqTl5ahlPqpGf8rfAM8mhKEO9uZzzVjAyht+zqOdhsXT2UMHV7
         wSDtD9bdWyBAq+JQlflSXdV7pY4IQBkMVAqZMEsMR/UrcfJb9pY/FMQ7N6RNmU8QUYUc
         G8M8SrdFZJZsqKokGMPVFGSHua2H4WurJa+ELBC/XdHfRfUG5JZFpiTyipRfWfC6qIrN
         VspLuFR8ea+f8HPYYBmWzT2M6j/Cr2CWttz2t5HeHKsoug/KdjLKZ586JMRKUc4QFsD0
         n1C7Uv10uXdW47TxxhT0hzDNttOGucCZLMEEefxji8z7JeCfwGvsTD+d6h+aUQSNq3Vn
         ZFKg==
X-Gm-Message-State: AOJu0YzVOvHGDWwPakjianFOP9bAFwfBs3rCOGKlj2cRASis1Y4a6xJu
	g9i2I48sAH7Pd/2UuEbN244yvnAul4jzpJz+QlogQxT6IbIo/eDKRHCFcrx7zUs=
X-Gm-Gg: ASbGncu2d2G0kVOWcE2TwvWNIZj1KUZ7HqdGapBxH0armH2pPdl11OQzG4sugN+KN+L
	Q7z57lbpbwzF701CnzKmW3BcvV+rRF3EqmGsRkFndq6gB0QPlKG4YfsrsD4ql6i298K2MbFbYfL
	hvT52UbzJgjsHdIuLBhiwyve6lPrpSmqFG089ExuvXlPJrp9iA6oYbHTriANhI7aR1avxFkajkx
	ReicVW6oufldFo15R4nj6X3DeZ2AnN7nVJnAJUAKYpc5F0ZC3VHcww=
X-Google-Smtp-Source: AGHT+IE4z37Or9yADOv+O39FGI70uwdrH1eoqOGhO/GGECRsdGCnHKNhwdQTcxVdHXzjgp6xkbp4Tg==
X-Received: by 2002:a05:6000:23c2:b0:385:e1e8:40db with SMTP id ffacd0b85a97d-385fd3e9195mr1279542f8f.24.1733223741934;
        Tue, 03 Dec 2024 03:02:21 -0800 (PST)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e49cd788sm9516997f8f.6.2024.12.03.03.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 03:02:21 -0800 (PST)
Message-ID: <16f9b5f8aed79e9313b4638512896743fa5a8d6d.camel@linaro.org>
Subject: Re: [PATCH 1/4] power: supply: add support for max77759 fuel gauge
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Thomas Antoine <t.antoine@uclouvain.be>, Sebastian Reichel
 <sre@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Dimitri Fedrau
 <dima.fedrau@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>,  Peter Griffin <peter.griffin@linaro.org>, Alim
 Akhtar <alim.akhtar@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Date: Tue, 03 Dec 2024 11:02:20 +0000
In-Reply-To: <bce22ca8-aed2-41ae-b2ef-fdc71266709a@uclouvain.be>
References: <20241202-b4-gs101_max77759_fg-v1-0-98d2fa7bfe30@uclouvain.be>
	 <20241202-b4-gs101_max77759_fg-v1-1-98d2fa7bfe30@uclouvain.be>
	 <c377f3302c6c282ad826211c859e2b65bb1222cb.camel@linaro.org>
	 <9387c0cf-d291-485a-8cd1-1aced7eba14e@uclouvain.be>
	 <2883fb0dd22312d5da9039d4fef869276a0bd430.camel@linaro.org>
	 <bce22ca8-aed2-41ae-b2ef-fdc71266709a@uclouvain.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-12-03 at 11:11 +0100, Thomas Antoine wrote:
> On 12/3/24 10:31, Andr=C3=A9 Draszik wrote:
> > On Tue, 2024-12-03 at 10:08 +0100, Thomas Antoine wrote:
> > > On 12/3/24 07:47, Andr=C3=A9 Draszik wrote:
> > > > > From: Thomas Antoine <t.antoine@uclouvain.be>
> > > > >=20
[...]

> > > > > =C2=A0/*
> > > > > =C2=A0 * Model Gauge M5 Algorithm output register
> > > > > =C2=A0 * Volatile data (must not be cached)
> > > > > @@ -369,6 +387,8 @@ static int max1720x_battery_get_property(stru=
ct
> > > > > power_supply *psy,
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val->strval=
 =3D max17201_model;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 else if (reg_val =3D=3D MAX172XX_DEV_NAME_TYPE_MAX17205)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val->strval=
 =3D max17205_model;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 else if (reg_val =3D=3D MAX172XX_DEV_NAME_TYPE_MAX77759)
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val->strval =3D m=
ax77759_model;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 else
> > > >=20
> > > > This is a 16 bit register, and while yes, MAX172XX_DEV_NAME_TYPE_MA=
SK only
> > > > cares about the bottom 4 bits, the register is described as 'Firmwa=
re
> > > > Version Information'.
> > > >=20
> > > > But maybe it's ok to do it like that, at least for now.
> > >=20
> > > I thought this method would be ok as long as there is no collision on
> > > values. I hesitated to change the model evaluation method based on ch=
ip
> > > model, where the max77759 would thus have an hard-coded value and the
> > > max1720x would still evaluate the register value. I did not do it bec=
ause
> > > it led to a lot more changes for no difference.
> >=20
> > Downstream uses the upper bits for max77759:
> > https://android.googlesource.com/kernel/google-modules/bms/+/refs/heads=
/android-gs-raviole-mainline/max_m5.h#135
> >=20
> > I don't know what the original max17201/5 report in this register
> > for those bits, though. Given for max77759 this register returns
> > the firmware version, I assume the lower bits can change.
>=20
> Based on this datasheet of the max1720x, the upper bits are the revision
> and the four lower bits are device. So it could change.
> https://www.analog.com/media/en/technical-documentation/data-sheets/MAX17=
201-MAX17215.pdf#MAX17201%20DS.indd%3A.213504%3A15892
>=20
> If the four lower bits are not always 0 for the max77759 then I guess it
> is necessary to change this as it wouldn't work with all max77759.

Maybe the best way forward is to go by the compatible (from DT), and
if max77759 to then print a warning if the upper bits are !=3D 0x62 and
!=3D 0x63. And maybe even refuse to load in that case.

Cheers,
Andre'


