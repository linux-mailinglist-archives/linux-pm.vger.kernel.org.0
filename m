Return-Path: <linux-pm+bounces-40708-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAABD17DA9
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 11:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50DC1308BFA8
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 10:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB600389DEE;
	Tue, 13 Jan 2026 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U4fTUND8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30391343D8F
	for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 10:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298500; cv=none; b=k6M7e0nkN19hWtz0e6067pmt6wFUo44GUBr0emD+HqmPJZgRzuuV3aSVHxHye7I5zNvscSDoD4O13bvaTOr2Ql9YdX6mOJw1Y+a8he7mdgofgaVzguVceFHmgbdhuqgh5gxd/rqZD6qfDIsMtsUQ0EkafOAzt9YwO5yThr5zAoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298500; c=relaxed/simple;
	bh=UaxpiPH1Ry8qxmWaByqCNheQFKNXN/xI1ASgwjeZP3o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nlIy1W8HrJBqpSA5pFbCMjOY4ZVLj/F/r8T3Ej4NHXDze2zoi+C3AD3fJYcYrK8Np5rQdOeuAEx+E3wGQ24KfUn/K7Sp7iKE38AlGOkIkur8hQ+SIVC9gsntOcrN1BW5Bg6HkzaWAfFYTX7cxM6Zs/y1SyX7rrfo+Kvg9mivdNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U4fTUND8; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-81f47610542so1125520b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 02:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768298498; x=1768903298; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UaxpiPH1Ry8qxmWaByqCNheQFKNXN/xI1ASgwjeZP3o=;
        b=U4fTUND8p5VKyKnDTesbt0UYPT0ODLWdy+QhQu3vANpepXWrv+B1IvYXQGp1ri0v5v
         5SNLoApJOU5Daa9jkR/cRApPNuIDMjAMeRUo8/w5g//mqZ2wu9cjuWWDUYUGnzMvo0wY
         SVqP5SICmHub6EFaVXjgIm9NNw8mfZeoC36BqWup99tCdCYxqLGm/85Dk0xRvkjg3Agn
         utvoGUljVrMFXkasbp8XKXg1v5zQ4J3j8AeEvzNQkGWA7BwkIxm9BKjTqNJXujxbaIC5
         /f+HoJYh6z4ovl4rKZPGRlIYdQVlGSOgUN7hEYMnwy1p8w8c2PrIiDQEJfPkjo6YDpdk
         uFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768298498; x=1768903298;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UaxpiPH1Ry8qxmWaByqCNheQFKNXN/xI1ASgwjeZP3o=;
        b=hO+ycFMh/c2AepOd5YVWaaeM7AmFhQSPq6+0ZZmR73jSrxePUauaFA87WvD5FVAJxO
         baCiRK6Ey35w+64KGfbVwUpVQPuaPLQ8G6WYmUbQlzSSQJV/crTvFXiGfWeSEN4ikVDt
         D22xnLIp8wbVdarBPU+TCcsfQs68jKtQNqRIuwNXb6BE30booQLpZbpO4zhQeN+hLPTx
         fbblOzqOAgkMBwnhK8+k5AYa8UmV7VKufExksudxgxE5K2QSCab3Z1JX/pWNfdTA0GtT
         j2YQdmS1FnkWL5xA5UezVldJ3sSBBw9xqSZfjH51GF4Ni09e+QES3ZV+VqbeL71njM0J
         DqWg==
X-Forwarded-Encrypted: i=1; AJvYcCXsexwFoXAVBgNm1CUV6Gm49gj06hirqgUxTIMPlbZRuqMzoJkEz+vaAocvMfwlUpEZvFATjh2O4w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1fnlFcylsfD0RFB3vxbmGVvT+BX/Vg03OzTh8UqlcEdPHLUTU
	NJnGgQDpFsCLG62Ve/87jgP3nR83JhEyb4XrzrrHLieDAmiLFFz62hYzvpSStIu6CSM=
X-Gm-Gg: AY/fxX69AL1HXLz/0bjs8hI8amZr/5W8YMNQp7V6f3twZ8kh8ujGFJU6/nuUzxag0Gk
	GBTXFC9kOUvNPtl3ZuoyvTN3w2qVk9wt1CviLTeB5JJ4uvAOuQCqLXR9LcCziheZuixG+oOx7FZ
	lyUZojX5441Pj60Tby8PG5U0Qde5KaDKHz53eXeaxNLLX3dRA5m8oYRs16q1TyzK/8cjn/Ft3dh
	qKXkFy1B+nhHtHyRRcrxvfp0RJqVnKummLpqAjdrA44El5QLgulj4ouFJI+DHl/lsNf4osWStjC
	rFKAOIpfExhzgmhYRfXdMrxhfbr77jsFdV1T02fJYedX6CGN/9/Q2WAXWuX37COfUHNveGaNx22
	u7xOfG8bKhzDWVLACTcWwJyn9kh5W8F6NPGnQOys9dwYLvi6WjhgIb9dBWllY/1aj4D+sabvvuu
	oeiIojqEdxTlYzNKslTif7s35tvH0=
X-Google-Smtp-Source: AGHT+IG1jlL2IQl/5c1/qnegoIWk3ju/Uopj0jVtcW5UNJeC+6ZUILWIKDw/vmbu2uSjRd9kgNDnBw==
X-Received: by 2002:a05:6a20:394a:b0:341:d5f3:f1ac with SMTP id adf61e73a8af0-3898f9f9cb8mr19509318637.41.1768298498309;
        Tue, 13 Jan 2026 02:01:38 -0800 (PST)
Received: from draszik.lan ([212.129.80.26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a2f7sm200689675ad.16.2026.01.13.02.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 02:01:37 -0800 (PST)
Message-ID: <6b37b88e9b7ee57eb1c006916fd995c813ab5e6e.camel@linaro.org>
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
Date: Tue, 13 Jan 2026 10:02:06 +0000
In-Reply-To: <bb9b9afa-0bfa-428e-9372-549d9ba8603c@google.com>
References: <20251227-max77759-charger-v3-0-54e664f5ca92@google.com>
	 <20251227-max77759-charger-v3-4-54e664f5ca92@google.com>
	 <298ca35590d2180fdcf334f94964b6110e17c606.camel@linaro.org>
	 <50c29a62-1fdb-4de2-8887-0d551eee5ec0@google.com>
	 <255d7726-6758-43ed-b35f-db14726bcc9b@google.com>
	 <2869d309358f27652289c40810ca36b2ec155d1d.camel@linaro.org>
	 <bb9b9afa-0bfa-428e-9372-549d9ba8603c@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2+build3 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Amit,

On Mon, 2026-01-12 at 11:37 -0800, Amit Sunil Dhamne wrote:
> Hi Andre',
>=20
> On 1/12/26 5:47 AM, Andr=C3=A9 Draszik wrote:
> > Hi Amit,
> >=20
> > On Tue, 2026-01-06 at 17:14 -0800, Amit Sunil Dhamne wrote:
> > > On 1/6/26 3:41 PM, Amit Sunil Dhamne wrote:
> > > > Hi Andre',
> > > >=20
> > > > On 1/5/26 9:32 AM, Andr=C3=A9 Draszik wrote:
> > > > > Hi Amit,
> > > > >=20
> > > > > I haven't done a full review, but a few things caught my eye.
> > > > >=20
> > > > > On Sat, 2025-12-27 at 00:04 +0000, Amit Sunil Dhamne via B4 Relay=
 wrote:
> > > > > > diff --git a/drivers/power/supply/Makefile
> > > > > > b/drivers/power/supply/Makefile
> > > > > > index 4b79d5abc49a..6af905875ad5 100644
> > > > > > --- a/drivers/power/supply/Makefile
> > > > > > +++ b/drivers/power/supply/Makefile
> > > > > > [...]
> > > > > > +
> > > > > > +static irqreturn_t irq_handler(int irq, void *data)
> > > > > > +{
> > > > > > +=C2=A0=C2=A0=C2=A0 struct max77759_charger *chg =3D data;
> > > > > > +=C2=A0=C2=A0=C2=A0 struct device *dev =3D chg->dev;
> > > > > > +=C2=A0=C2=A0=C2=A0 u32 chgint_ok;
> > > > > > +=C2=A0=C2=A0=C2=A0 int i;
> > > > > > +
> > > > > > +=C2=A0=C2=A0=C2=A0 regmap_read(chg->regmap, MAX77759_CHGR_REG_=
CHG_INT_OK,
> > > > > > &chgint_ok);
> > > > > You might want to check the return value and return IRQ_NONE if i=
t
> > > > > didn't
> > > > > work?
> > > > >=20
> > > > > > +
> > > > > > +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < ARRAY_SIZE(irqs); i++) {
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (irqs[i] =3D=3D =
irq)
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 break;
> > > > > > +=C2=A0=C2=A0=C2=A0 }
> > > > > > +
> > > > > > +=C2=A0=C2=A0=C2=A0 switch (i) {
> > > > > > +=C2=A0=C2=A0=C2=A0 case AICL:
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(dev, "AICL =
mode: %s",
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 str_no_yes(chgint_ok & MAX77759_CHGR_REG_CHG_INT_AICL));
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > > > > +=C2=A0=C2=A0=C2=A0 case CHGIN:
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(dev, "CHGIN=
 input valid: %s",
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 str_yes_no(chgint_ok & MAX77759_CHGR_REG_CHG_INT_CHGIN));
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > > > > +=C2=A0=C2=A0=C2=A0 case CHG:
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(dev, "CHG s=
tatus okay/off: %s",
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 str_yes_no(chgint_ok & MAX77759_CHGR_REG_CHG_INT_CHG));
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > > > > +=C2=A0=C2=A0=C2=A0 case INLIM:
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(dev, "Curre=
nt Limit reached: %s",
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 str_no_yes(chgint_ok & MAX77759_CHGR_REG_CHG_INT_INLIM));
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > > > > +=C2=A0=C2=A0=C2=A0 case BAT_OILO:
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(dev, "Batte=
ry over-current threshold crossed");
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > > > > +=C2=A0=C2=A0=C2=A0 case CHG_STA_CC:
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(dev, "Charg=
er reached CC stage");
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > > > > +=C2=A0=C2=A0=C2=A0 case CHG_STA_CV:
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(dev, "Charg=
er reached CV stage");
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > > > > +=C2=A0=C2=A0=C2=A0 case CHG_STA_TO:
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(dev, "Charg=
er reached TO stage");
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > > > > +=C2=A0=C2=A0=C2=A0 case CHG_STA_DONE:
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(dev, "Charg=
er reached TO stage");
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > > > Are the above debug messages really all needed?
> > > I forgot to respond to this comment in my previous email.
> > >=20
> > > I think we can keep AICL, BAT_OILO, INLIM. They're either special
> > > conditions (AICL) or faulty conditions (like BAT_OILO) and we can in
> > > fact keep them at dev_info level. Rest can be removed and a
> > > power_supply_changed() is sufficient.
> > >=20
> > > Let me know what you think?
> > I don't think dev_info() in an interrupt handler is appropriate. At
> > least it should be ratelimited.
> >=20
> > If it's something special / unexpected that needs attention, having
> > a dev_dbg() message only will usually not be visible to anybody.
>=20
> I agree. I can change the prints to dev_info_ratelimited for the stuff=
=20
> we care about.

If it's an erroneous condition, maybe warn or even err are more appropriate=
?

But then, what is the expectation upon the user observing these messages?
What can or should they do? Who is going to look at these and can do
something sensible based on them?

> >=20
> > Also will the call to power_supply_changed() down below handle the
> > special conditions (e.g. convey to upper levels)? If not, can it be
> > made to do so?
>=20
> Yes it does, as I can see a call to kobject_uevent() inside=20
> power_supply_changed_work(). Also, power_supply_changed() also notifies=
=20
> other subsystems that have registered their notifiers downstream of this=
=20
> power_supply object. So I believe we're good there.

If erroneous conditions are handled by other / upper layers, why print a
message in this interrupt handler in the first place?

Also, I just noticed there is a max77705 charger driver. It seems quite
similar to this one, maybe it can be leveraged / extended?


Cheers,
Andre'

