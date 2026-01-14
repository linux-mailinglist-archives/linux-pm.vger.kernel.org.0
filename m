Return-Path: <linux-pm+bounces-40841-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3C5D1E007
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 11:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8376730879AE
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 10:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D4838A280;
	Wed, 14 Jan 2026 10:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UC6xqira"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7796355024
	for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 10:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385987; cv=none; b=vAw9ZlHYPL293IXgPNED5fIwuC9pmeVqcYp6YzyhE1afRp1ES1mkKNCDtgJbNhndipRJ5Dy51mWDvB3v/RuLtFjV8EbzZCuaHZm3jjnEH1lS8yS8ySxizqvUZDc8LPyxLvYoZXmpQJltSXm6cWcZj9RLMj1+phGPMrijRe0joJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385987; c=relaxed/simple;
	bh=8eibjd2N5XiVRRI4N4yeokngezFp8SvzkItH6b1iECM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EdNlUKmUq2Apef2Vn1WqCUTWaQ/wGkEJFDWl1E8pg6mGSUjiHvb0CB1XX3pKyAvgvIvR/i32fmFDU5FEEAvDPTR3CigfpC1tinn7QO/fy45HQpaikfwLDyDVpFGDRXy3iNPzHWaY08wJ7FXiYF7LbfUhEtAU8+rWfZ+Tv2mEY5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UC6xqira; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2ac3d5ab81bso6409255eec.1
        for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 02:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768385984; x=1768990784; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8eibjd2N5XiVRRI4N4yeokngezFp8SvzkItH6b1iECM=;
        b=UC6xqirahJ9gIyGufYimhxLA6Qge3YzR1jHRVEXuZM51fue2fvFOv8G5b9KYJ5bO4c
         BPx99f6iUwAgMmT6Ng9+Dflyc3QW/gdhkF0Tuly113EhLxRKFOkI/cEpN5Ioq5OFqKNq
         rQfAk0MDMTpXeQSJGQ7ZNZUR2BPm1M5jWhPoRKO2TUGNR8g1EprTBwT1g+GiB2wZF0AG
         /LyJjIhtaNqplsPIQVsadRu/wBFgTaIvyJf+LbzedsazhGGn4Ap8caKW4ch6eYC65zkk
         xDKNyBoqfhT1Kb3hXv5BIIdqqeoNNz1Bx4pMljmJtgqyGVE41J0E1qyvGF7X6qvaGW9D
         DFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768385984; x=1768990784;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8eibjd2N5XiVRRI4N4yeokngezFp8SvzkItH6b1iECM=;
        b=mZY08mY2/P3kHIo8zCjCH6niz328eju1cBjblM0II+2IReDz4E8d/UDjW0xCmrA3iY
         9PNUV/dLrAaBfRyvhmpzMFrrf9OjdJ2WKFQ/2yt4DLFbms4FPL2VLl/ev7XIBmekPnXY
         lEOEJuIQKHm7XXFnDOkSE7sPgBWm7ACBupSqTkfjhmHMNuLxLQsvuU+51iqC2U5oW2fo
         z2TFHNMdpntuZn1Omx73t4sOGcDEkUFunU0KNkpH1yCn0ZVqhjYLIFoWk5Le68SM8fEg
         HKO9zLAcst+IVS2UU8yaIXpGIGvM6knTJsk/ldBUWDzC+nkFJKST8vmNNPxADaueDhoV
         xX3A==
X-Forwarded-Encrypted: i=1; AJvYcCXiZ/6fZfFmKX7kzSsqcylLebAlkznjl9erlIldU1PvhKrZlzC5mKVy0Ef3veccMFhAfrEVxPKE2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTO0Ye9PCyc8w1q9cvEXeuoANKrGopD5nzjCCC9gD+VTAAmIuf
	4l3PT4/YshFmGTOT2lj2ibxCt/9rjP3fqQs3Dxu18+7/ejVbj7ETt9Df+LxMOqwmu9k=
X-Gm-Gg: AY/fxX54vmPhJJqjPP9csuB1zePAimL9IgpABpTA0R0yoXQFARfb2Q54tP3bnMTUeV0
	/YC7hzzGcKbZrtT0Iyl6/NEeYbnUhhwSUjT+A40DHTbpaO+f/qYqqXczV6/83k9W1vvBKu68Od+
	+LWRfnMdCcxTggxQJifGWDTNKxIUVhMN93tneHzSH3pmoEkKShDKsatCRUxlKoJUcCiU9wPXCAi
	z6Zb2zxFUSwsbK7egrwTRWn1vvM3Nt1RK5yVkDnLI5lVwfHrocNBO/GKyC88xx+rI3V+L3H27Ot
	695GrtGdvHbN3k4yOVagvDfjwMMeYqRrwknT/wiANmPeHzunE9AaH3EWS30fP10Kg7jv0tElDuR
	AgqJC4GCCxxmTVcBN/XOaumhYeDc7iZ9/SIIKdf3aPprTvyV4Gb1xN4OnNoJ6ykF6NUOhDlqKcB
	ldXIzokUmzKv8M7WXD
X-Received: by 2002:a05:693c:3008:b0:2a4:3593:ddf3 with SMTP id 5a478bee46e88-2b4871d0cc3mr3162205eec.32.1768385983766;
        Wed, 14 Jan 2026 02:19:43 -0800 (PST)
Received: from draszik.lan ([212.129.75.26])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b170673b2esm19824293eec.6.2026.01.14.02.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 02:19:42 -0800 (PST)
Message-ID: <48d52ef389ee0e878c36184efbfaa85071f5549a.camel@linaro.org>
Subject: Re: [PATCH v3 4/5] power: supply: max77759: add charger driver
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
Date: Wed, 14 Jan 2026 10:20:17 +0000
In-Reply-To: <378ee786-2b44-44e7-a3f6-0cd1db3c0481@google.com>
References: <20251227-max77759-charger-v3-0-54e664f5ca92@google.com>
	 <20251227-max77759-charger-v3-4-54e664f5ca92@google.com>
	 <298ca35590d2180fdcf334f94964b6110e17c606.camel@linaro.org>
	 <50c29a62-1fdb-4de2-8887-0d551eee5ec0@google.com>
	 <255d7726-6758-43ed-b35f-db14726bcc9b@google.com>
	 <2869d309358f27652289c40810ca36b2ec155d1d.camel@linaro.org>
	 <bb9b9afa-0bfa-428e-9372-549d9ba8603c@google.com>
	 <6b37b88e9b7ee57eb1c006916fd995c813ab5e6e.camel@linaro.org>
	 <378ee786-2b44-44e7-a3f6-0cd1db3c0481@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2+build3 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-01-13 at 16:47 -0800, Amit Sunil Dhamne wrote:
> Hi Andre',
>=20
> On 1/13/26 2:02 AM, Andr=C3=A9 Draszik wrote:
> > Hi Amit,
> >=20
> > On Mon, 2026-01-12 at 11:37 -0800, Amit Sunil Dhamne wrote:
> > > Hi Andre',
> > >=20
> > > On 1/12/26 5:47 AM, Andr=C3=A9 Draszik wrote:
> > > > Hi Amit,
> > > >=20
> > > > On Tue, 2026-01-06 at 17:14 -0800, Amit Sunil Dhamne wrote:
> > > > > On 1/6/26 3:41 PM, Amit Sunil Dhamne wrote:
> > > > > > Hi Andre',
> > > > > >=20
> > > > > > On 1/5/26 9:32 AM, Andr=C3=A9 Draszik wrote:
> > > > > > > Hi Amit,
> > > > > > >=20
> > > > > > > I haven't done a full review, but a few things caught my eye.
> > > > > > >=20
> > > > > > > On Sat, 2025-12-27 at 00:04 +0000, Amit Sunil Dhamne via B4 R=
elay wrote:
> > > > > > > > diff --git a/drivers/power/supply/Makefile
> > > > > > > > b/drivers/power/supply/Makefile
> > > > > > > > index 4b79d5abc49a..6af905875ad5 100644
> > > > > > > > --- a/drivers/power/supply/Makefile
> > > > > > > > +++ b/drivers/power/supply/Makefile
> > > > > > > > [...]
> > > > > > > > +
> > > > > > > > +static irqreturn_t irq_handler(int irq, void *data)
> > > > > > > > +{
> > > > > > > > +=C2=A0=C2=A0=C2=A0 struct max77759_charger *chg =3D data;
> > > > > > > > +=C2=A0=C2=A0=C2=A0 struct device *dev =3D chg->dev;
> > > > > > > > +=C2=A0=C2=A0=C2=A0 u32 chgint_ok;
> > > > > > > > +=C2=A0=C2=A0=C2=A0 int i;
> > > > > > > > +
> > > > > > > > +=C2=A0=C2=A0=C2=A0 regmap_read(chg->regmap, MAX77759_CHGR_=
REG_CHG_INT_OK,
> > > > > > > > &chgint_ok);
> > > > > > > You might want to check the return value and return IRQ_NONE =
if it
> > > > > > > didn't
> > > > > > > work?
> > > > > > >=20
> > > > > > > > +
> > > > > > > > +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < ARRAY_SIZE(irqs); i++=
) {
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (irqs[i] =3D=
=3D irq)
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 break;
> > > > > > > > +=C2=A0=C2=A0=C2=A0 }
> > > > > > > > +
> > > > > > > > +=C2=A0=C2=A0=C2=A0 switch (i) {
> > > > > > > > +=C2=A0=C2=A0=C2=A0 case AICL:
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(dev, "A=
ICL mode: %s",
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 str_no_yes(chgint_ok & MAX77759_CHGR_REG_CHG_INT_AICL));
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > > > > > > +=C2=A0=C2=A0=C2=A0 case CHGIN:
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(dev, "C=
HGIN input valid: %s",
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 str_yes_no(chgint_ok & MAX77759_CHGR_REG_CHG_INT_CHGIN));
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > > > > > > +=C2=A0=C2=A0=C2=A0 case CHG:
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(dev, "C=
HG status okay/off: %s",
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 str_yes_no(chgint_ok & MAX77759_CHGR_REG_CHG_INT_CHG));
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > > > > > > +=C2=A0=C2=A0=C2=A0 case INLIM:
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(dev, "C=
urrent Limit reached: %s",
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 str_no_yes(chgint_ok & MAX77759_CHGR_REG_CHG_INT_INLIM));
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > > > > > > +=C2=A0=C2=A0=C2=A0 case BAT_OILO:
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(dev, "B=
attery over-current threshold crossed");
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > > > > > > +=C2=A0=C2=A0=C2=A0 case CHG_STA_CC:
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(dev, "C=
harger reached CC stage");
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > > > > > > +=C2=A0=C2=A0=C2=A0 case CHG_STA_CV:
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(dev, "C=
harger reached CV stage");
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > > > > > > +=C2=A0=C2=A0=C2=A0 case CHG_STA_TO:
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(dev, "C=
harger reached TO stage");
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > > > > > > +=C2=A0=C2=A0=C2=A0 case CHG_STA_DONE:
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(dev, "C=
harger reached TO stage");
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > > > > > Are the above debug messages really all needed?
> > > > > I forgot to respond to this comment in my previous email.
> > > > >=20
> > > > > I think we can keep AICL, BAT_OILO, INLIM. They're either special
> > > > > conditions (AICL) or faulty conditions (like BAT_OILO) and we can=
 in
> > > > > fact keep them at dev_info level. Rest can be removed and a
> > > > > power_supply_changed() is sufficient.
> > > > >=20
> > > > > Let me know what you think?
> > > > I don't think dev_info() in an interrupt handler is appropriate. At
> > > > least it should be ratelimited.
> > > >=20
> > > > If it's something special / unexpected that needs attention, having
> > > > a dev_dbg() message only will usually not be visible to anybody.
> > > I agree. I can change the prints to dev_info_ratelimited for the stuf=
f
> > > we care about.
> > If it's an erroneous condition, maybe warn or even err are more appropr=
iate?
> >=20
> > But then, what is the expectation upon the user observing these message=
s?
> > What can or should they do? Who is going to look at these and can do
> > something sensible based on them?
>=20
> The logging will help in postmortem analysis which may or may not=20
> possible with just publishing uevents to userspace hoping that they log=
=20
> the psy properties. Illustrating a situation:
>=20
> 1. Over current situation happened where the Battery to System current=
=20
> exceeds the BAT_OILO threshold. This would also generate an interrupt.
>=20
> 2. The MAX77759 takes protective measures if the condition lasts for a=
=20
> certain specified time and reset. Resetting will cause Vsys to collapse=
=20
> to 0 if the system is only battery powered.
>=20
> 3. It'd be better that the BAT_OILO interrupt is logged in dmesg,=20
> instead of just delegating it to user space as user can debug this=20
> condition by looking at last_kmsg or pstore.
>=20
> 4. This signal can help the user debug conditions such as moisture (this=
=20
> signal + contaminant detection) or indicative of a mechanical failure.
>=20
> I do agree though that this is a hypothetical or very rare situation and=
=20
> if you have a strong opinion against this I am okay with removing the=20
> prints completely.

Thanks for details. OK, they sound useful in this case, but should still
be warn, not dbg.

> > >=20
>=20
>=20
> >=20
> > Also, I just noticed there is a max77705 charger driver. It seems quite
> > similar to this one, maybe it can be leveraged / extended?
>=20
> Thanks for the feedback. I reviewed the max77705 charger driver. .
>=20
> Here is a breakdown of why I believe a separate driver may be a better=
=20
> approach:

[...]

Thanks for the analysis, I agree with your conclusion. Mainly I noticed tha=
t
as part of AICL interrupt handling that driver does a bit of work, while he=
re
we don't. I am wondering if that is applicable here is well.

Cheers,
Andre'

