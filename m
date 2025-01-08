Return-Path: <linux-pm+bounces-20075-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D65EA0557D
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 09:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C6E31661C9
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 08:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654981DFE0A;
	Wed,  8 Jan 2025 08:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtGouxt0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D8F1ACECC;
	Wed,  8 Jan 2025 08:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736325346; cv=none; b=bvUDHQW46oB4YJ9SSiy9LEqcOKOiRUQ7ybPD2u0r1I2U7HZeDdikLbDpGbWIzCkyBuj7B3L6qmH2/mMZdU8XqO4c51ki1+5AIxR7JQD+aW/bvXjfBCYZKlBLc9HZ8IVIZiOcz+1r5pFoqCF8C5HvBtUsz1TfT/Gj3ZfzVjDtu64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736325346; c=relaxed/simple;
	bh=2WzHc1fGFOk1Qgk1Z7HmCNfBh2avZWwPmnHlfNCerkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzDpEYfhoWtMObRS+gMFo7c6YAMrNovWBbshSd1GVD0hNnMoCPNewRqq+nZSem/6moX+0CQF1RekzD0CAbvAvRtG/3pFKxg+ZyWhYcn2ycAcAgHDrnRXoYT1/zN0QoQfYufmOPFUuDpWQWGZ+Iduh4SAqLF8zUjRcopCVstlE6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtGouxt0; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aab6fa3e20eso2731231866b.2;
        Wed, 08 Jan 2025 00:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736325343; x=1736930143; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZpZvZ0LS+IQx8m8gmJE75LARezkcjEUQaeBsyIVLcbg=;
        b=PtGouxt0grOTYENEuyOyg/Fng8Ub5VQJRMLTFbvWyfTz8aanMQY49Fl3pPBmj1JGSq
         E5DDGFCw8/MgI2pLJQaXdFMra06iBkVL7WmJZttAeE+P73xaEbXwUSsTOOZL9Mf2lHVe
         QmkI1BstfWpqcgbQ9K51Lb89rcR/oVNx4YDj9ukmP+cvFnY6gElyn9bOiko3vzMvuA5y
         QpAkFErSg807GhqMX9BIe/igrObEwsv5zce4HkWVqsDaG81934wGxfA7LlgYPx+Hk5hy
         JVt4ixpLXHBIWhUhaf5e3LSHbQBGTTGr7gOQMsP8xnbPTW8kIanKVrAA9Nx7OhIDkqND
         YtDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736325343; x=1736930143;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpZvZ0LS+IQx8m8gmJE75LARezkcjEUQaeBsyIVLcbg=;
        b=apLgeXXv7KSr8lA2puia738bFN1iF7TjeiYpByaRoHMjXuVqYyucUhF1sQqur8lX90
         fqEBRYNPr49lHmeQTvNHoO+EVni69oFYQ+gjg0+tGkssa7DO0pm/SCvxStBUZMFa8rti
         jVi4ChNdXTLdj3f4YVl9f2WxwocQRm9ufQ3d45Ds+HwSrYS+8OwdDoTTjKuIRGsOfXTH
         0WIwD4QxXYqVDPBYp1vSHn6Hco53UkIXQ+M8ZkUorKiE9xrY6cG5MCS6AQeKAzBqtopR
         HZGn7Ovw2FROeLyUXjFQTSghJd3kkvrgQVx3XLy40RxlO/u/QL/yWj8nJbQTxeaI5eEq
         0xLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJj9c6wU4f/rFq1Zx6JZSpP8GRz0LArGWIdQDTrFZX7tdcJCRnq0VsIoqJ1wkEFWT3ZLdO1pzTUXELnaE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv0ZJknrj2SniB9JYo0OjQfdTiOHVjWwTVwVIy2XkMrxFbeCwM
	NV7unC4kPLnXFsetftvcXnurkRNur6fhS4ToL74mFifJVdd35Fr3ZgnyICL0yI+7Mg==
X-Gm-Gg: ASbGncussDcVQmMKjBCxTj7Gc4JbW7WBZVqEL4MA+Rs9rjRGvFjo8Jg++EkxIvwTili
	tQfQPvpz84h9sISZT35dgmNCtOWj9nOrx9CV3PF7zyft5PKZ5zf6HOX0+FLCKe0irvNgs6+M+H3
	0XLccfobypL1v6nzLzLuxUOjvvt/yAz9mP1qXGaUvZRSgBfCqQJQzgYOiIKt6d+X5v1uOJLlgF1
	juvi4ihSBB9f1o4nK8oWpE/VUM/l6X5+5I8L7h29WTvdHM5lAYyAmbZeW1vQSY7Iwc=
X-Google-Smtp-Source: AGHT+IEfQPbiFlJzXqu8DbDVGu5YrZyZPf1Y9VIys8y1qeHi7XBaNr+vxm6jeAm6D2dpTJJmG22afg==
X-Received: by 2002:a17:906:f582:b0:aa6:7165:5044 with SMTP id a640c23a62f3a-ab2abc789c7mr143166366b.44.1736325342493;
        Wed, 08 Jan 2025 00:35:42 -0800 (PST)
Received: from tp440p.steeds.sam ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f0159b8sm2477701966b.157.2025.01.08.00.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 00:35:42 -0800 (PST)
Date: Wed, 8 Jan 2025 10:35:28 +0200
From: Sicelo <absicsz@gmail.com>
To: linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc: linux-pm@vger.kernel.org, sre@kernel.org, linux-kernel@vger.kernel.org,
	maemo-leste@lists.dyne.org
Subject: Re: [PATCH] power: supply: bq27xxx_battery: do not update cached
 flags prematurely
Message-ID: <Z3440OtztmLUv7HA@tp440p.steeds.sam>
References: <20241125152945.47937-1-absicsz@gmail.com>
 <20241125175957.rulndmny536pd5c6@pali>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241125175957.rulndmny536pd5c6@pali>

Hi 

On Mon, Nov 25, 2024 at 06:59:57PM +0100, Pali Rohár wrote:
> cc Krzysztof, author of the mentioned commit.

Yes, apologies for overlooking to cc him.

> On Monday 25 November 2024 17:29:30 Sicelo A. Mhlongo wrote:
> > Commit 243f8ffc883a1 ("power: supply: bq27xxx_battery: Notify also about
> > status changes") intended to notify userspace when the status changes,
> > based on the flags register. However, the cached state is updated too
> > early, before the flags are tested for any changes. Remove the premature
> > update.
> > 
> > Fixes: 243f8ffc883a1 ("power: supply: bq27xxx_battery: Notify also about status changes")
> > Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
> > ---
> >  drivers/power/supply/bq27xxx_battery.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> > index 40c5ac7a1118..b2c65fe43d5c 100644
> > --- a/drivers/power/supply/bq27xxx_battery.c
> > +++ b/drivers/power/supply/bq27xxx_battery.c
> > @@ -1913,7 +1913,6 @@ static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
> >  		cache.flags = -1; /* read error */
> >  	if (cache.flags >= 0) {
> >  		cache.capacity = bq27xxx_battery_read_soc(di);
> > -		di->cache.flags = cache.flags;
> >  
> >  		/*
> >  		 * On gauges with signed current reporting the current must be
> > -- 
> > 2.45.2

Is there anything that still needs to be done to move this patch along?

Perhaps for clarification, in the middle of bq27xxx_battery_update_unlocked,
there is:

	if ((di->cache.capacity != cache.capacity) ||
	    (di->cache.flags != cache.flags) ||
	    (di->last_status.intval != status.intval)) {
		di->last_status.intval = status.intval;
		power_supply_changed(di->bat);
	}

	if (memcmp(&di->cache, &cache, sizeof(cache)) != 0)
		di->cache = cache;

which compares the new value of cache.flags with the previously cached
values in di->cache, and calls power_supply_changed() if they are
different. For the flags, this test is currently not working, because by
the time it is run, di->cache.flags has already been updated with the
value in cache.flags, so the flags condition is always short-circuited
in the test. Hence my patch ensures di->cache.flags is not updated
before the test.

The flags are correctly updated after the test, in the 

        di->cache = cache;

line, so the removed line is simply not needed.

If there is any adjustment necessary, I will happily do so.

Kind Regards
Sicelo A. Mhlongo

