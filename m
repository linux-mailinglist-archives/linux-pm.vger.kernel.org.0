Return-Path: <linux-pm+bounces-14627-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6427C984B61
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 21:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A29F1C229BB
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 19:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3148C1A;
	Tue, 24 Sep 2024 19:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWWWtsGc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A138BF0;
	Tue, 24 Sep 2024 19:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727204528; cv=none; b=q+tRiwxs/KQvvuBXZjW1BZcKTfcsFQRrPVHlS14zCgZQBHKQIbpaCZoTbSRv0BULafrq7SGO9nqVhdRhz/Yw8Yk0LwV/a4aOedR4CjBdo8ewyx9DjY9uOTkJruDzMCfmGWBOVTEVsYvw6+Bhtnz2PZK3P1TyEW4U4i7MsF8nRMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727204528; c=relaxed/simple;
	bh=va5K5ZlrShpJ/LFW7p1UG1Pzj1oE+NuW9y7UG7YpXb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMyKHRbJ7c+BxuoZgB6SSUL8Rn6pH5gAwLoygz0to6E8GqOx3yGklCo92FV8ybxc/OdFa7uyKsZWl/GXCZh9GoZnSqYwGsuyEjf40VKUewp8kUz3NMfp8+UGBMr2p5SXXP58PlwcPGnU6bV3eofJq5SSBGaL9BY/2dDwwHkL5Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWWWtsGc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C516FC4CEC5;
	Tue, 24 Sep 2024 19:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727204528;
	bh=va5K5ZlrShpJ/LFW7p1UG1Pzj1oE+NuW9y7UG7YpXb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pWWWtsGcyrXIp0jVOs8hr4P8l+0r3VHQbvGYoLxWGYFUlrda7Hg8rnO/mVerU/4SE
	 y8DQ+BwSO8z6W7CorsWMc9G3sM4VaRrGBNZaluf9W+yMyFwM4+eLsEK2Fj1nJVzc+r
	 4FvmWM3VF+j0JTi0WNDN/Vf7ExXaJYSi4fJ3H4webPEUCS/H7a5KFdqfbfqFYPB5Re
	 EqwkNU7Zx5QRg1shZukmErLERMY1IvTO/ZD9y7KqK0pA3u17mhvWtSVnyURqE7I4kn
	 4w0kQa/1rwvqOZzxwSKbhvFh2jzcYdD/X+3sH1vtUj2osUg6cpg6QbOyaDlf1KO5OI
	 tfI5jUul0Wh1Q==
Received: by pali.im (Postfix)
	id DC03A818; Tue, 24 Sep 2024 21:02:01 +0200 (CEST)
Date: Tue, 24 Sep 2024 21:02:01 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Jerry Lv <Jerry.Lv@axis.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Kernel <Kernel@axis.com>
Subject: Re: [PATCH] power: supply: bq27xxx_battery: Do not return ENODEV
 when busy
Message-ID: <20240924190201.xvxf5ugpmrveyo5r@pali>
References: <20240913-foo-fix2-v1-1-a0f499404f3a@axis.com>
 <20240913212715.gmchsmmaqrhksmhx@pali>
 <VI1PR02MB1007663D83495B0594DE794C7F4662@VI1PR02MB10076.eurprd02.prod.outlook.com>
 <20240914082447.mrxtfgazkpaeqetu@pali>
 <VI1PR02MB1007675ED9E1F1DBC6A915680F46F2@VI1PR02MB10076.eurprd02.prod.outlook.com>
 <20240923181631.3plimohmg4vnjwtb@pali>
 <VI1PR02MB10076AC00A9D65BEBBC1A0DC8F4682@VI1PR02MB10076.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR02MB10076AC00A9D65BEBBC1A0DC8F4682@VI1PR02MB10076.eurprd02.prod.outlook.com>
User-Agent: NeoMutt/20180716

Hello, as I do not have HW which is affected by this issue, I think that
you would better know how to handle it. If you think that one retry is
enough for normal usage then go ahead with it. I'm fine with it.

Maybe if we want to be super precise we can measure probability how
often gauge is busy and then calculate number of retries to have device
driver working in usual conditions over one or two years. But this is
overkill...

On Tuesday 24 September 2024 03:34:11 Jerry Lv wrote:
> Hi Pali,
> 
> Just as you mentioned, when the gauge is busy, the other devices
> connected to the same I2C will not response too. We rarely see
> this in the normal use case, but sometimes see it in our stress test.
> 
> Since the gauge usually recovers from busy status very quickly, and
> too many retry may affect other devices too. So could we just retry
> one time, do you think is it enough?
> 
> Best Regards
> Jerry Lv
> 
> ________________________________________
> From: Pali Rohár <pali@kernel.org>
> Sent: Tuesday, September 24, 2024 2:16 AM
> To: Jerry Lv
> Cc: Sebastian Reichel; linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; Kernel
> Subject: Re: [PATCH] power: supply: bq27xxx_battery: Do not return ENODEV when busy
> 
> Thank you for detailed information about i2c NAK. In this case try to
> consider if it would not be better to add retry logic in the
> bq27xxx_battery_i2c_read() function.
> 
> If it is common that bq chipset itself returns i2c NAKs during normal
> operations then this affects any i2c read operation done by
> bq27xxx_battery_i2c_read() function.
> 
> So this issue is not related just to reading "flags", but to anything.
> That is why I think that retry should be handled at lower layer.
> 
> On Monday 23 September 2024 08:14:13 Jerry Lv wrote:
> > Hi Pali,
> >
> > Thanks for your excellent suggestion, I will change the code accordingly.
> >
> > About the question:
> > Anyway, which bus is BQ27Z561-R2 using (i2c?)? And how is EBUSY indicated or transferred over wire?
> > --- Yes, we connect the gauge BQ27Z561 to I2C. When it's busy, the feedback we got from the logic analyser is "NAK".
> >
> >
> > Best Regards,
> > Jerry Lv
> >
> > ________________________________________
> > From: Pali Rohár <pali@kernel.org>
> > Sent: Saturday, September 14, 2024 4:24 PM
> > To: Jerry Lv
> > Cc: Sebastian Reichel; linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; Kernel
> > Subject: Re: [PATCH] power: supply: bq27xxx_battery: Do not return ENODEV when busy
> >
> > Hello Jerry,
> >
> > I think that this issue should be handled in different way.
> >
> > First thing is to propagate error and not change it to -ENODEV. This is
> > really confusing and makes debugging harder.
> >
> > Second thing, if bq27xxx_read() returns -EBUSY, sleep few milliseconds
> > and call bq27xxx_read() again.
> >
> > This should cover the issue which you are observing and also fixing the
> > problem which you introduced in your change (interpreting error code as
> > bogus cache data).
> >
> > Anyway, which bus is BQ27Z561-R2 using (i2c?)? And how is EBUSY
> > indicated or transferred over wire?
> >
> > Pali
> >
> > On Saturday 14 September 2024 02:57:39 Jerry Lv wrote:
> > > Hi Pali,
> > >
> > > (Sorry for inconvineient! previous email was rejected by some email list for some HTML part, so I edit it and send it again.)
> > >
> > > Yes, bq27xxx_read() will return -EBUSY, and bq27xxx_read() will be called in many functions.
> > >
> > > In our product, some different applications may access the gauge BQ27Z561-R2, and we see many times the returned error code is -ENODEV.
> > > After debugging it by oscillograph and adding some debug info, we found the device is busy sometimes, and it will recover very soon(a few milliseconds).
> > > So, we want to exclude the busy case before return -ENODEV.
> > >
> > > Best Regards,
> > > Jerry
> > >
> > > On Friday 13 September 2024 16:45:37 Jerry Lv wrote:
> > > > Multiple applications may access the device gauge at the same time, so the
> > > > gauge may be busy and EBUSY will be returned. The driver will set a flag to
> > > > record the EBUSY state, and this flag will be kept until the next periodic
> > > > update. When this flag is set, bq27xxx_battery_get_property() will just
> > > > return ENODEV until the flag is updated.
> > >
> > > I did not find any evidence of EBUSY. Which function and to which caller
> > > it returns? Do you mean that bq27xxx_read() returns -EBUSY?
> > >
> > > > Even if the gauge was busy during the last accessing attempt, returning
> > > > ENODEV is not ideal, and can cause confusion in the applications layer.
> > >
> > > It would be better to either propagate correct error or return old value
> > > from cache...
> > >
> > > > Instead, retry accessing the gauge to update the properties is as expected.
> > > > The gauge typically recovers from busy state within a few milliseconds, and
> > > > the cached flag will not cause issues while updating the properties.
> > > >
> > > > Signed-off-by: Jerry Lv <Jerry.Lv@axis.com>
> > > > ---
> > > >  drivers/power/supply/bq27xxx_battery.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> > > > index 750fda543308..eefbb5029a3b 100644
> > > > --- a/drivers/power/supply/bq27xxx_battery.c
> > > > +++ b/drivers/power/supply/bq27xxx_battery.c
> > > > @@ -2029,7 +2029,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
> > > >                bq27xxx_battery_update_unlocked(di);
> > > >        mutex_unlock(&di->lock);
> > > >
> > > > -     if (psp != POWER_SUPPLY_PROP_PRESENT && di->cache.flags < 0)
> > > > +     if (psp != POWER_SUPPLY_PROP_PRESENT && di->cache.flags < 0 && di->cache.flags != -EBUSY)
> > > >                return -ENODEV;
> > >
> > > ... but ignoring error and re-using the error return value as flags in
> > > code later in this function is bad idea.
> > >
> > > >
> > > >        switch (psp) {
> > > >
> > > > ---
> > > > base-commit: da3ea35007d0af457a0afc87e84fddaebc4e0b63
> > > > change-id: 20240913-foo-fix2-a0d79db86a0b
> > > >
> > > > Best regards,
> > > > --
> > > > Jerry Lv <Jerry.Lv@axis.com>
> > > >
> > >

