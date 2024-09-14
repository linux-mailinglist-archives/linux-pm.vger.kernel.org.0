Return-Path: <linux-pm+bounces-14243-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD99978F19
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 10:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 586812876FF
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 08:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C90145A17;
	Sat, 14 Sep 2024 08:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HypYNKwI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9C3143725;
	Sat, 14 Sep 2024 08:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726302293; cv=none; b=TJGbVscA0jJr78QlqJ++85nscGXIPogtNPYRMFoZRWsynHA8TBSHYK2WWPvtLP1owNFdFkvvhi+RlZ747O+6rLJ0UVQ0K8vBpPRh8mig65QLzyGWCL8uRyzOhDfu/3umgvaVHKJcXqyB5DC0kxj8R2PKdvMO9IzcPKMfIXYQvS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726302293; c=relaxed/simple;
	bh=1ZS6djcgdTckT02XiWs3uy8KNjfnYiSpZEOuyEkNhrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ck9DZTOHG6rDpUMmfjbFCEMdqBcZTIxebgxU9V+rC5Xhok62b2IzZxdqgycFOfGlUFNDu00Y2UL1Ln0yIrYqQAN7/1TtbXHOCLO/mng2nnUE2sIYqCfhOvHqK70U8wyUU/VvCawgsQXbr7sDUcb1cDW1Q//ONKSzxnLHmJEQYgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HypYNKwI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0848CC4CEC0;
	Sat, 14 Sep 2024 08:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726302293;
	bh=1ZS6djcgdTckT02XiWs3uy8KNjfnYiSpZEOuyEkNhrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HypYNKwIktI0acVDz8W2z46/09zkdbnYu2qGo6/8g2HUJlaVr/eVb47t7/WwPJmsa
	 QTlh23skiRgh1vMwqNUF0MqdRMqv28jTWcinFsPZaz01ndAhmlORM1oAe9Nxmo7kZ4
	 +GlRFQTMFi5m71QA3hfTjcQNpjABlDoSrModGCjmwMkhT2645j2YVNql0ffTK67xlB
	 xDQ0pHSBfpEnu87aAh7AqklYqwmVvR3vKDPx42bv1/v4/ldoK1YXJ5DxNz+apq6xTX
	 RuuaZp20gFF5ax4MXjyCQx5fhwWdvMm56kCyACli6sF2dcYA9wwyZCiT8/pZL0IG0m
	 S5MVHKXnAgKIA==
Received: by pali.im (Postfix)
	id D6857758; Sat, 14 Sep 2024 10:24:47 +0200 (CEST)
Date: Sat, 14 Sep 2024 10:24:47 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Jerry Lv <Jerry.Lv@axis.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Kernel <Kernel@axis.com>
Subject: Re: [PATCH] power: supply: bq27xxx_battery: Do not return ENODEV
 when busy
Message-ID: <20240914082447.mrxtfgazkpaeqetu@pali>
References: <20240913-foo-fix2-v1-1-a0f499404f3a@axis.com>
 <20240913212715.gmchsmmaqrhksmhx@pali>
 <VI1PR02MB1007663D83495B0594DE794C7F4662@VI1PR02MB10076.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR02MB1007663D83495B0594DE794C7F4662@VI1PR02MB10076.eurprd02.prod.outlook.com>
User-Agent: NeoMutt/20180716

Hello Jerry,

I think that this issue should be handled in different way.

First thing is to propagate error and not change it to -ENODEV. This is
really confusing and makes debugging harder.

Second thing, if bq27xxx_read() returns -EBUSY, sleep few milliseconds
and call bq27xxx_read() again.

This should cover the issue which you are observing and also fixing the
problem which you introduced in your change (interpreting error code as
bogus cache data).

Anyway, which bus is BQ27Z561-R2 using (i2c?)? And how is EBUSY
indicated or transferred over wire?

Pali

On Saturday 14 September 2024 02:57:39 Jerry Lv wrote:
> Hi Pali,
> 
> (Sorry for inconvineient! previous email was rejected by some email list for some HTML part, so I edit it and send it again.)
> 
> Yes, bq27xxx_read() will return -EBUSY, and bq27xxx_read() will be called in many functions.
> 
> In our product, some different applications may access the gauge BQ27Z561-R2, and we see many times the returned error code is -ENODEV.
> After debugging it by oscillograph and adding some debug info, we found the device is busy sometimes, and it will recover very soon(a few milliseconds).
> So, we want to exclude the busy case before return -ENODEV.
> 
> Best Regards,
> Jerry
> 
> On Friday 13 September 2024 16:45:37 Jerry Lv wrote:
> > Multiple applications may access the device gauge at the same time, so the
> > gauge may be busy and EBUSY will be returned. The driver will set a flag to
> > record the EBUSY state, and this flag will be kept until the next periodic
> > update. When this flag is set, bq27xxx_battery_get_property() will just
> > return ENODEV until the flag is updated.
> 
> I did not find any evidence of EBUSY. Which function and to which caller
> it returns? Do you mean that bq27xxx_read() returns -EBUSY?
> 
> > Even if the gauge was busy during the last accessing attempt, returning
> > ENODEV is not ideal, and can cause confusion in the applications layer.
> 
> It would be better to either propagate correct error or return old value
> from cache...
> 
> > Instead, retry accessing the gauge to update the properties is as expected.
> > The gauge typically recovers from busy state within a few milliseconds, and
> > the cached flag will not cause issues while updating the properties.
> >
> > Signed-off-by: Jerry Lv <Jerry.Lv@axis.com>
> > ---
> >  drivers/power/supply/bq27xxx_battery.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> > index 750fda543308..eefbb5029a3b 100644
> > --- a/drivers/power/supply/bq27xxx_battery.c
> > +++ b/drivers/power/supply/bq27xxx_battery.c
> > @@ -2029,7 +2029,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
> >                bq27xxx_battery_update_unlocked(di);
> >        mutex_unlock(&di->lock);
> >
> > -     if (psp != POWER_SUPPLY_PROP_PRESENT && di->cache.flags < 0)
> > +     if (psp != POWER_SUPPLY_PROP_PRESENT && di->cache.flags < 0 && di->cache.flags != -EBUSY)
> >                return -ENODEV;
> 
> ... but ignoring error and re-using the error return value as flags in
> code later in this function is bad idea.
> 
> >
> >        switch (psp) {
> >
> > ---
> > base-commit: da3ea35007d0af457a0afc87e84fddaebc4e0b63
> > change-id: 20240913-foo-fix2-a0d79db86a0b
> >
> > Best regards,
> > --
> > Jerry Lv <Jerry.Lv@axis.com>
> >
> 

