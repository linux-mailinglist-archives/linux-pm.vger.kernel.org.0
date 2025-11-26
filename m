Return-Path: <linux-pm+bounces-38679-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A974C886FE
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 08:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECF954E87BA
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 07:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B482B2BEFFA;
	Wed, 26 Nov 2025 07:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nFyvzeeW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90843295DBD
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 07:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764142585; cv=none; b=O6uk2m0OMcT8XhqySWmKrhY+e9FAxKQYrcn0WrwCAr892JzTMLtOO0WuwJzZlG9WqsijbMOWHKXRrcP2u3LEV7Al8cF1ptIJxa4W4eCAjAXy5fg+7MN5QD99FMaYsZ2z7sovuQxUGhiKrmXv0Ty9Vf0JlLN630yMAUUeLAvXBAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764142585; c=relaxed/simple;
	bh=+NYZTcPMfQw8EVvM4OhMcZhhk3laGmdMxWTa5PItr74=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cxYW8OUTE3beRuXoH7/88XHcB0G56A3TAT2Kh1Ic0Giuwm3G8SM0QN3YOK0E6yGdhr30w4Gs5jsjMId5e0qQ/OGJW0bcUVV9/+9nwb2HRmXn5mX8eK0Rlip1p1t/V9iR5DtUr0MT4ZVD2eBsWHZqhD2PwG1u/iKFglMWG/iDSvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nFyvzeeW; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b3108f41fso3837454f8f.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 23:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764142581; x=1764747381; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uwb4gEZQsVssNNQKKaHnFD1mEjqfKdCKrDRZhkYlGCU=;
        b=nFyvzeeWb9JDcvgVDAYupEKe6ZHkm4uagrSkxVy2oqcywFoW45d+53JI8Nr5+qYYk5
         E//hPD8GXgnK0x3i/VMddEYgSaHT3RVgkIU99oOD27WsgW2yYMqTfzD5ZCSoPEChDHqx
         bGqRS9VW0ZbCXoIB3PShKO1uljkgYEPFZyVglhtvpNYP6YDL2/oYOL26xBnBB1zeQMk7
         toOfRW7KauApdiCrw7EGdjcPufAEEJvL+bg3gExLqk8LlS+0NgPcDpByO2u3L93zgjhD
         M6qx7s1XLLnoV6Z4k9Nk1LD/mNWQX0EDxBfESv0dTGZ8AkTjN41+5c+GKID4dkZOAFzN
         1r1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764142581; x=1764747381;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uwb4gEZQsVssNNQKKaHnFD1mEjqfKdCKrDRZhkYlGCU=;
        b=nhxQ+28ZoXWoOkgLfhl+R5ux6CrsQFlbWFZx0rwatgj+5tmScZjXz56fzn/OXVN+ZR
         QJglvUERipt9wqgWY0zLulXsHQNWuSjb2S18gXqUkHShOBrPY9FjmdUNCstI0pWFfm8z
         Xmy9Q6PUi+seF/1sLL9SiNzSGEh5RlmlpuxzGESIRYXkLgKXYa4bMA3U/iLXvgk2P4LJ
         6AvBOf5zNDT+qGZzrRDRO+Yqf5XG+ctDJIjxPNUmC0tkW/8uSYbk21weMIBiO1fVOdZy
         2P8lUfDA28TtRtHQY0c8JjYmJgon9EpHMi6ljKWwlFA9nZvQc2K99PGQtu5mmKkXdBUu
         1VBA==
X-Forwarded-Encrypted: i=1; AJvYcCV1mX5fS++XJvYbbk8ldPGQ++Ybiz3EbnwrA7C5FTOdB48dJPiOhpRUyRRMafGMhF8va6eTfedvQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqpAbO0euEIMsACh4Lgvim3pegFkkekzqHJzq0luNJuqZR9/KT
	zs9t9uQ5zAyldjfxBLMejVNAOCGZo/T4wFPLhVHe99y+4y3Ca0clKEzzW4LZ0+7l2DA=
X-Gm-Gg: ASbGncuUmJZ2gklVHzkLPGpP/KL4375pkLApK8U725HKGJfQyc/feoK/HluDOKlve5l
	9ayvzuEjBMYmQX/mqGABip1SYj9xl1MxIi+SSrCwQVCSDnwqqWFan/PI0ufX5rfioCfI6lw1+Cl
	XhRO7KoXU9pB6Q31v5guKNpR/hEUpKzzwaM6OvO7sgUtTJ+J3a1BS6aqt1NDaUJIGp7DiKXFmDW
	Pj4Ps1Vp3L5zqYjW3JONfmDJZatVZcomWr9s/ECHwun6OoRbZCk/L4KrKpqs8mdWg0OSXwNBPBi
	QmZzlqEgvGt+QYPeKLNrVX8wAbGLTyCaeQ9u4McZOWJgCizT+gQtKpAu/MuR3aM5IlG7NdzBYgT
	RdKFYCk+k2XEphQbeGikGVzTf9A4saGpcUSvXPDS5qsKaGa2kQ5XYhBmheXj4s4BLHFJUpg4+2r
	ZM9vrMptEZFdclckFM
X-Google-Smtp-Source: AGHT+IEkJIVmft0K1+fBvK9APlqevDyQqqLhuiwQwAv9PNhWzAVjw6Cn97feu3xnWTKXQ+ps5Ed2JA==
X-Received: by 2002:a5d:5f91:0:b0:42b:3bc4:16e9 with SMTP id ffacd0b85a97d-42cc1abdf6amr18484142f8f.4.1764142580820;
        Tue, 25 Nov 2025 23:36:20 -0800 (PST)
Received: from draszik.lan ([212.129.87.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb919bsm38547158f8f.34.2025.11.25.23.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 23:36:20 -0800 (PST)
Message-ID: <1fafb9117a9faa32222a55efc77794156635d105.camel@linaro.org>
Subject: Re: [PATCH 4/6] mfd: max77759: modify irq configs
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Amit Sunil Dhamne <amitsd@google.com>, Sebastian Reichel
 <sre@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Lee Jones
 <lee@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Badhri
 Jagan Sridharan	 <badhri@google.com>, Heikki Krogerus
 <heikki.krogerus@linux.intel.com>,  Peter Griffin
 <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, Alim
 Akhtar	 <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, RD
 Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>
Date: Wed, 26 Nov 2025 07:36:35 +0000
In-Reply-To: <e25ff0e5ff103433942fc7744eea4a3c61ce1daf.camel@linaro.org>
References: <20251123-max77759-charger-v1-0-6b2e4b8f7f54@google.com>
		 <20251123-max77759-charger-v1-4-6b2e4b8f7f54@google.com>
		 <5c901a6c831775a04924880cc9f783814f75b6aa.camel@linaro.org>
		 <aa7bdeb1-c8a9-4353-af56-869f16a083c2@google.com>
	 <e25ff0e5ff103433942fc7744eea4a3c61ce1daf.camel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2+build3 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-26 at 06:44 +0000, Andr=C3=A9 Draszik wrote:
> Hi Amit,
>=20
> On Tue, 2025-11-25 at 17:10 -0800, Amit Sunil Dhamne wrote:
> > Hi Andr=C3=A9,
> >=20
> > On 11/23/25 10:21 PM, Andr=C3=A9 Draszik wrote:
> > > Hi Amit,
> > >=20
> > > Thanks for your patches to enable the charger!
> >=20
> > Ack!
> >=20
> >=20
> > > > From: Amit Sunil Dhamne <amitsd@google.com>
> > > >=20
> > > > Define specific bit-level masks for charger's registers and modify =
the
> > > > irq mask for charger irq_chip. Also, configure the max77759 interru=
pt
> > > > lines as active low to all interrupt registrations to ensure the
> > > > interrupt controllers are configured with the correct trigger type.
> > > >=20
> > > > Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> > > > ---
> > > > =C2=A0=C2=A0drivers/mfd/max77759.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 24 +++++++++++++++++-------
> > > > =C2=A0=C2=A0include/linux/mfd/max77759.h |=C2=A0 9 +++++++++
> > > > =C2=A0=C2=A02 files changed, 26 insertions(+), 7 deletions(-)
> > > >=20
> > > > diff --git a/drivers/mfd/max77759.c b/drivers/mfd/max77759.c
> > > > index 6cf6306c4a3b..5fe22884f362 100644
> > > > --- a/drivers/mfd/max77759.c
> > > > +++ b/drivers/mfd/max77759.c
> > > > @@ -256,8 +256,17 @@ static const struct regmap_irq max77759_topsys=
_irqs[] =3D {
> > > > =C2=A0=C2=A0};
> > > > =C2=A0=20
> > > > =C2=A0=C2=A0static const struct regmap_irq max77759_chgr_irqs[] =3D=
 {
> > > > -	REGMAP_IRQ_REG(MAX77759_CHARGER_INT_1, 0, GENMASK(7, 0)),
> > > > -	REGMAP_IRQ_REG(MAX77759_CHARGER_INT_2, 1, GENMASK(7, 0)),
> > > > +	REGMAP_IRQ_REG(MAX77759_CHARGER_INT_1, 0,
> > > > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAX77759_CHGR_REG_CHG_INT_A=
ICL |
> > > > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAX77759_CHGR_REG_CHG_INT_C=
HGIN |
> > > > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAX77759_CHGR_REG_CHG_INT_C=
HG |
> > > > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAX77759_CHGR_REG_CHG_INT_I=
NLIM),
> > > > +	REGMAP_IRQ_REG(MAX77759_CHARGER_INT_2, 1,
> > > > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAX77759_CHGR_REG_CHG_INT2_=
BAT_OILO |
> > > > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAX77759_CHGR_REG_CHG_INT2_=
CHG_STA_CC |
> > > > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAX77759_CHGR_REG_CHG_INT2_=
CHG_STA_CV |
> > > > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAX77759_CHGR_REG_CHG_INT2_=
CHG_STA_TO |
> > > > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAX77759_CHGR_REG_CHG_INT2_=
CHG_STA_DONE),
> > > > =C2=A0=C2=A0};
>=20
> You should also add the remaining bits in each register here, so that the
> regulator-irq can mask them when no user exists. It will only touch the
  ^^^^^^^^^^^^^
  regmap-irq

A.

