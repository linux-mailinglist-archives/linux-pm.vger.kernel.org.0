Return-Path: <linux-pm+bounces-33223-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6C4B395D5
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 09:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D556716B0D5
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 07:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17AC27A130;
	Thu, 28 Aug 2025 07:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jr1RWHk/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F10EEBB
	for <linux-pm@vger.kernel.org>; Thu, 28 Aug 2025 07:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756367140; cv=none; b=iWDpgoJfXf+dRACCpwMWTmJG6PPiyFVutJACUYyPXglFi9tMn0O0TroraUbdCQhR2wu+m5/vv+QMO+N3f0P1ddv/Ff193t+4Jbwn7MK19Xpo9MA6WSYSbVbdIxGjmS5D0RatABD6UKJ6rXTuINCi4wGhF4/j0/iK1cgdv39JQiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756367140; c=relaxed/simple;
	bh=d6URorS8Ctbh/ZUWzTxG+lzVaLNoJbOyrHYl+13IuP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNcgrS/3G+79V2e4lt6Dyh0HxgR2CUL5mfYn7pQzVAt6MutP5TmTsX74fVG12kdcrlmE/6iwRiZGB6qQKqOdRZ50NeQ14x930L1m2qbeJc91Rs9KxFZEvrUodXzasH9iUbPOrbjBWAcI2XS+ESymIz9x4JsJYoiK3xstLldR5Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jr1RWHk/; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55f3ec52a42so722280e87.1
        for <linux-pm@vger.kernel.org>; Thu, 28 Aug 2025 00:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756367136; x=1756971936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6URorS8Ctbh/ZUWzTxG+lzVaLNoJbOyrHYl+13IuP0=;
        b=Jr1RWHk/6OX1gNYfHtbfL1GyesRGwnqcq+GJJVfs/0LUtwW5Bk5EdHqfclapE8yFFU
         gLqYXQXhjY7cf8wHulCZA27/5nHAS4FFNeSk/P1M1qA19nZagBc4tRalBGWKhSo1fAgp
         pPG6fdT5fS64eIPpjCbVWJlHJcZw9WCILo4xrBLvTdDY52GP56E+M65bMRbdrQ8RcJZH
         XrYb3cW2Viu8vPW+QZhm2GepVO7UyuZT7gSqTaKwaJYlJptSGHrXUfNuXs72scOh7uOo
         IjJWAKDDz0xVt+JKhqeKp8qQ8u6RbzXIjt2YpAdTuHoPTDq1ZJ5mKTsRbC9n2tdiVuYq
         G/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756367136; x=1756971936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6URorS8Ctbh/ZUWzTxG+lzVaLNoJbOyrHYl+13IuP0=;
        b=sDga3821PphPvDKQaukEdYHYGpW275AWDpnH/j/glRDd+4heBdw1fBM6kpREDXYRBa
         ojM4Z0bITqPy3pWKOQSwDyqsczratn8uwMnBEq/0LQ5MPd6wW03pEIM42VyYkG2KdBrt
         sZ0OpOmyv+SjbVL8v0GECQ3COGC+38KbkRq7rNGWJPfJn5p0KsOU7FJRLu77MBppKVD7
         0iQe2tFYSTanKaCJvSR0NnbejkDLxYDC9GAuf6KkS8NWg7VNAEOBukJWfeHQndXFoW0E
         is1kRXwdsLWodhu1oKBHAodfYwUWAGY1POl8cRMd5nuBoVFX2s1Yz9v+kWzkfOLvyaVz
         Np8w==
X-Forwarded-Encrypted: i=1; AJvYcCWKvUSf9XfimSWIhPoJ40ZLSq9zUMRMPDc7MIMylKXyfhzQUg0mEXkt1PTaIJCfEDj1AWE11F6PTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YymIF8GJZS7e2eqMdN4RGxW5eFYSRE9FAQhg60BZlboVavz4lBf
	522/wkJQEzLE124sJJWOOfUmFKA19YdKzX0+K1QmmTVDW9YHmGc5p4+l+r3RJOB+6lWW5nQzUIF
	baQVMhpf5qJVvb3xWb1OWume5AVdc6NUSh9P3S69SJA==
X-Gm-Gg: ASbGncsnBOGLknUgtekCHs0T+rZH+Nv2VuZKMMX8O1LFjUqWG6ZXCsPbIiz8CQtZBCs
	qh7HJPt+2kp3yjMBP6v9ARTVn1ZBi+VQFs9gcxw28CcvZLgpPdS0wZZu8b5KiezBlg/nv9spWFl
	PkTrBDxVbiIGtCyzlL3vsjJs106NtTgj3qJLEVp2wa0jgqxI/mBxrIh50Xnnk/l/jJ3Zpet3ccz
	LGeZqI=
X-Google-Smtp-Source: AGHT+IFftTrIY6bCE6OtZayt949qe/q6qpTCMtVf6BhO45T2/KJM0hnT2AQlOn522Ry83IkX62e2TWjFWZKIbMsMhW0=
X-Received: by 2002:a05:6512:10cb:b0:55f:4f90:ae92 with SMTP id
 2adb3069b0e04-55f4f90b43cmr2339130e87.49.1756367135695; Thu, 28 Aug 2025
 00:45:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821-bd71828-charger-v3-0-cc74ac4e0fb9@kemnade.info> <20250821-bd71828-charger-v3-2-cc74ac4e0fb9@kemnade.info>
In-Reply-To: <20250821-bd71828-charger-v3-2-cc74ac4e0fb9@kemnade.info>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Aug 2025 09:45:24 +0200
X-Gm-Features: Ac12FXxbdreYabmxFFN7GBPIh4QCMqR6aFu8YJ4gdcAYQ741WzjOEF_7UVjYtrg
Message-ID: <CACRpkdbZN3LB=iVwL0YLEoUOiPMSePdOF_NEGWuCncDAjWY4XA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] power: supply: Add bd718(15/28/78) charger driver
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Lee Jones <lee@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andreas / Cong,

On Thu, Aug 21, 2025 at 8:25=E2=80=AFPM Andreas Kemnade <andreas@kemnade.in=
fo> wrote:

> Add charger driver for ROHM BD718(15/28/78) PMIC charger block.
> It is a stripped down version of the driver here:
> https://lore.kernel.org/lkml/dbd97c1b0d715aa35a8b4d79741e433d97c562aa.163=
7061794.git.matti.vaittinen@fi.rohmeurope.com/
>
> For the ease of review and to do a step-by-step approach remove all the
> coloumb counter related stuff and do not sneak in BD71827 support. That
> also avoids non-trivial rebasing of the above series.
>
> Changes besides that:
> Replace the custom property by a standard one and do not use megaohms
> for the current sense resistor.
>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

I think it looks good to merge:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

It contains some interesting pointers for future work:

> +/* TODO: Verify the meaning of these interrupts */
> +BD_ISR_BAT(rechg_det, "Recharging", true)
> +BD_ISR_BAT(rechg_res, "Recharge ending", true)
> +BD_ISR_DUMMY(temp_transit, "Temperature transition")
> +BD_ISR_BAT(therm_rmv, "bd71815-therm-rmv", false)
> +BD_ISR_BAT(therm_det, "bd71815-therm-det", true)
> +BD_ISR_BAT(bat_dead, "bd71815-bat-dead", false)
> +BD_ISR_BAT(bat_short_res, "bd71815-bat-short-res", true)
> +BD_ISR_BAT(bat_short, "bd71815-bat-short-det", false)
> +BD_ISR_BAT(bat_low_res, "bd71815-bat-low-res", true)
> +BD_ISR_BAT(bat_low, "bd71815-bat-low-det", true)
> +BD_ISR_BAT(bat_ov_res, "bd71815-bat-over-res", true)

Some of these look like they should immediately shut down the
system, I suppose the battery charger does this autonomously
but it should probably also trigger an emergency shutdown
of Linux, right?

> +/* What should we do here? */
> +BD_ISR_BAT(bat_ov, "bd71815-bat-over-det", false)

At overvoltage all charging should stop, I guess the hardware
does that autonomouslyd and this is just to inform us that
this has happened.

> +BD_ISR_BAT(bat_mon_res, "bd71815-bat-mon-res", true)
> +BD_ISR_BAT(bat_mon, "bd71815-bat-mon-det", true)
> +BD_ISR_BAT(bat_cc_mon, "bd71815-bat-cc-mon2", false)
> +BD_ISR_BAT(bat_oc1_res, "bd71815-bat-oc1-res", true)
> +BD_ISR_BAT(bat_oc1, "bd71815-bat-oc1-det", false)
> +BD_ISR_BAT(bat_oc2_res, "bd71815-bat-oc2-res", true)
> +BD_ISR_BAT(bat_oc2, "bd71815-bat-oc2-det", false)
> +BD_ISR_BAT(bat_oc3_res, "bd71815-bat-oc3-res", true)
> +BD_ISR_BAT(bat_oc3, "bd71815-bat-oc3-det", false)
> +BD_ISR_BAT(temp_bat_low_res, "bd71815-temp-bat-low-res", true)
> +BD_ISR_BAT(temp_bat_low, "bd71815-temp-bat-low-det", true)
> +BD_ISR_BAT(temp_bat_hi_res, "bd71815-temp-bat-hi-res", true)
> +BD_ISR_BAT(temp_bat_hi, "bd71815-temp-bat-hi-det", true)

The "oc" stuff is "open circuit" and probably different interrupts
to indicate that a measurement of the open circuit voltage
is available in some register, which enables you do do more
precise capacity estimation, right?

If it is useful depends on if the device is e.g. flashed with
capacity tables vs OC voltage in the factory, and the charger
then has "deep knowledge" of the battery it is handling, I guess
this is how it works? Then this again is just informational, it
informs you of what the device-internal charging algorithm
is doing.

As for the temperature these are probably also just informational
if all these states are already handled by the hardware itself.

They all seem to be intended so that you can essentially put
these into custom sysfs or debugfs entries and then get out
a graphical state machine of the battery charger. That requires
deep knowledge of how the charger works (a datasheet)
and has limited use for a normal user.

Yours,
Linus Walleij

