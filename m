Return-Path: <linux-pm+bounces-40904-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0C3D22925
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 07:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80218301EFCC
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 06:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736592882AA;
	Thu, 15 Jan 2026 06:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BD/1vP9h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DE225742F
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 06:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768458934; cv=none; b=UV9fo2w766FLRmPDw0Ps5c3u3lbZljoB+2XZhUaif4jO5baCgWA8GoXuBvR2gkW0hqonDyEEbsPLiCg1HxwWs1Utl+4LooxFMAzbzS6FEkwodnbXpDrkB5ahS+w1uaTl0suhFEP66O/FyPNmiLPp3gyJxBL+jtljvddPcv2AKVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768458934; c=relaxed/simple;
	bh=if/lSj3JKx8MPnoKYvi9HyDPFLO/Aa3jzUwJxjRuWVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2kB1pzuoZnwEe9REp5fc5KCOes7wsAivS86O90LIAJo/X5BDLbusdtIvLy+KOBAT4kvIPlkFK0/ZVN+6H3R5duCjoMzJD600K3mG+aY421gadX41UYtiVdqfP+zqFr/HMyFt0WAFYdlrZ0Yz3ZkmvfgQK7E5rTKk6WI3t923jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BD/1vP9h; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6467ac59e16so396132d50.1
        for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 22:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768458932; x=1769063732; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sDL2VEo1K40CbIHkD6w0yhETsm2brUV92i2ZA2PzHJw=;
        b=BD/1vP9hutShSgvlUTfq7LS02h1nrCgiPbmgMpcaogL+0geQ6LCOT898259gEt2uN5
         bKt9iazK9CuyCK6P2XIgJYp2aQEy/ftt78m1V92/6Ie0mWQBm0d8TrVBm8r28QevhzA1
         c5zrUiAuq2pzdICijndsSyNhU4VhJ9zrSz4AThK1eifoG9TsN4Btt5f1kGfAmdX1T+0k
         75sDCPdB43M2zE9irn7fZhBT18ICqccuhQGns1aSQCCFcq+039fYcwRryYf92ydJCrKh
         4mLFUvQMOkNrfUChzUJY19otcv2lCgM9O5tBnNTr0nJBrGsAKeIPi6mdgXoYCJG6cvXn
         TwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768458932; x=1769063732;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDL2VEo1K40CbIHkD6w0yhETsm2brUV92i2ZA2PzHJw=;
        b=VuGLvNuCXfRu8DipZznlsNsMG2nz8hoV8ku+6b/6x6vnK2n1Lye5HQIDmi8+bXeKRB
         UDva0umDnkn8EjVtizePEVxyqjr3Kj9xero9aORrOiXPcN7mVeBlXIJYHijcE1GqvSZT
         G3oQJTMa1yozq+a8am9DVXnC4uQLXUhjz2UR/2zb00D/A6AiT2+YrokYeMEDF4OeAj23
         nPg11Se961oC5Jyo3TzwIsz4kYhhXn3GAOuemOIOAC/zNZMwXLMhJ2VUzpccFCbUp4Rf
         8a1EryYfONa8naHa5tqUDlpqz3tZvadGRP0kE4gECucLZ5oM7wVMVhPneyEdn9A2U9hs
         MrMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvGytGnBLW4rjpDtKKrJM5ouYGIYR/kAL14CD73Af0A6//jJa1hftogBH7F9Che8eRU+xlJ+/w/w==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqw+PW80fGzgdvEX3DHgYPAQwb/qOvMfGn89qGZX3wwMhIFN/9
	4qGM0ZIcUEyc25EI7P1rrvy8+L7I0qmReZtD13uqKDkjESKK/PdwuMDiKXIsDhTSlW7nMViRh8u
	wcDIktVcpGxFjrOLQM8ppjMFDpJJu55uAMf6Sh7XpVA==
X-Gm-Gg: AY/fxX7HWXHF6Jsd19tKroo0TgnXNr62Bhz9VMUmkmnz0Oie9BjP+CZCQjn5RHPvi8z
	IS0UVU1/7UiFODpmFcJdGGw3WiYsCRyVWMQmD5ug1QW4aVVJvwueyS8ZWqkG3zqCPuCswmM0G9H
	GA1nKVMIBCV+B6SSplbHJ9tOA4WLDqlXt64mZh2gCJqXXcX/2kmMQ2ieDB6ZnAmnogo3PUsJAGg
	gkqbp6DwFb7NR38a8wtN4Kehlz17SquB4IdaXbrAHg2aVwZeQjOr/MuZrv2zWXRhWpW/9jW
X-Received: by 2002:a05:690e:1883:b0:644:45ca:7bfd with SMTP id
 956f58d0204a3-64901aaebb3mr3938691d50.36.1768458931647; Wed, 14 Jan 2026
 22:35:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109-b4-macsmc-power-v2-0-93818f1e7d62@gmail.com>
 <20260109-b4-macsmc-power-v2-1-93818f1e7d62@gmail.com> <aWbq2pgTJlOWC07w@venus>
In-Reply-To: <aWbq2pgTJlOWC07w@venus>
From: Michael Reeves <michael.reeves077@gmail.com>
Date: Thu, 15 Jan 2026 17:35:20 +1100
X-Gm-Features: AZwV_Qj589lgXQNeagebL0kthy66zD-IRnj2VDG_vPH0jpjOKd17rg1RUVEIdJs
Message-ID: <CANpmGNvBvasft9U3_=G2=B9VF1Q0P7aG8QsdLF7H+NJH9oTfKw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] power: supply: Add macsmc-power driver for Apple Silicon
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Hector Martin <marcan@marcan.st>
Content-Type: text/plain; charset="UTF-8"

Hi Sebastian,

Thanks for the review.

On Wed, Jan 14, 2026 at 1:10 PM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
> > +     case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE:
> > +             if (power->has_chte)
> > +                     return apple_smc_write_u32(power->smc, SMC_KEY(CHTE), 1);
> > +             else if (power->has_ch0c)
> > +                     return apple_smc_write_u8(power->smc, SMC_KEY(CH0C), 1);
> > +             else
> > +                     return -EOPNOTSUPP;
> > +     break;
>
> Indentation?

Fixed.

> > +     case POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE:
> > +             if (!power->has_ch0i)
> > +                     return -EOPNOTSUPP;
> > +     return apple_smc_write_u8(power->smc, SMC_KEY(CH0I), 1);
>
> Indentation?

Fixed.

> > +     case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> > +             /* Calculate total max design voltage from per-cell nominal voltage */
>
> Using the nominal voltage here doesn't make much sense. As the
> comment above mentions not having nominal voltage data for the
> battery, I suppose the comment is wrong and this uses the per-cell
> **maximum** voltage?

You are correct. I've checked again just to confirm the comment is
definitely incorrect, and not the code, and the key reports ~4.4V.
Updated now to reflect that it is using the per-cell maximum voltage,
I think I got my words mixed up when writing the comment.

> > +     case POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD:
> > +             /*
> > +              * Read-only reflection of end threshold logic.
> > +              * Allowed to be written to avoid userspace confusion, but ignored.
> > +              */
> > +             return 0;
>
> I think it's better to fix userspace and expose the value read-only.
> In any case this creates an ABI and requires proper documentation in
> Documentation/ABI/testing/sysfs-class-power. My suggestion would be
> to drop this for now and handle it in a separate patchset, so that
> ABI discussion don't block the remaining driver.

Agreed. I have dropped the threshold properties for now to avoid ABI churn.

> > +static int macsmc_power_probe(struct platform_device *pdev)
> > +{
> > +     struct apple_smc *smc = dev_get_drvdata(pdev->dev.parent);
>
> You have a bunch of &pdev->dev further ahead, so I think it's
> sensible to create 'struct dev = &pdev->dev;' and use it everywhere
> in the probe function.

Done.

> > +             power->batt_desc.properties = power->batt_props;
>
> It seems 'power->batt_props' is not used anywhere and you can just
> use 'power->batt_desc.properties' directly?

Fixed. I've removed the struct members and assigned directly to desc.properties.

> > +             power->batt = devm_power_supply_register(&pdev->dev, &power->batt_desc, &psy_cfg);
> > +             if (IS_ERR(power->batt)) {
> > +                     ret = dev_err_probe(&pdev->dev, PTR_ERR(power->batt),
> > +                                         "Failed to register battery\n");
>
> No need to assign ret; it is unused. But it becomes necessary with
> a follow-up suggestion from me.

Fixed.

> > +             power->ac_desc.properties = power->ac_props;
>
> Just like 'power->batt_props': You can drop power->ac_props and use
> power->ac_desc.properties directly.

Done.

> > +                     /* If battery also failed or didn't exist, this is a fatal error */
> > +                     if (!power->batt)
> > +                             return ret;
>
> You can just drop this check and instead rely on the "Final check"

Done.

> > +     /* Final check: did we register anything? */
> > +     if (!power->batt && !power->ac)
> > +             return -ENODEV;
>
> You can just return ret here, if you assign -ENODEV as initial
> value. In that case the correct error code will be returned in all
> cases.

Done. I initialised ret to -ENODEV and updated the flow to return it.

> > +     power->nb.notifier_call = macsmc_power_event;
> > +     blocking_notifier_chain_register(&smc->event_handlers, &power->nb);
> > +
> > +     INIT_WORK(&power->critical_work, macsmc_power_critical_work);
>
> This must happen before registering the event handler, which in
> theory might instant-trigger an event creating a race condition. You
> already have the correct order in the remove handler (which also
> hints about this problem :)). After reordering you can further
> simplify by just using devm_work_autocancel().

Fixed. Moved INIT_WORK to the top of probe and switched to devm_work_autocancel.

> > +static struct platform_driver macsmc_power_driver = {
> > +     .driver = {
> > +             .name = "macsmc-power",
> > +             .owner = THIS_MODULE,
>
> There is no need to set platform_driver.driver.owner manually. It is
> handled automatically, so please drop.

Dropped.

> > +MODULE_ALIAS("platform:macsmc-power");
>
> Drop MODULE_ALIAS and instead add a platform_device_id table with
> MODULE_DEVICE_TABLE(platform, <NAME>);

Done.

I will send v3 shortly.

Best regards,
Michael

