Return-Path: <linux-pm+bounces-4448-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC85869C0D
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 17:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6891C21AFA
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 16:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92911149007;
	Tue, 27 Feb 2024 16:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H+YwJR20"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F93B1487D8
	for <linux-pm@vger.kernel.org>; Tue, 27 Feb 2024 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051171; cv=none; b=GZEP126H5yUzHHWJ46pTZ4HG/ftKlH+PddTgPRirqCMkLkUP/4iK6BPSlDrEsP2skpgVZxCJBRL0mEFulTNqnGdpAc9hvTgyMQXBs9jAteNJ0/BnXj8WNj9XssSKqv49qwCwgZDxmz90gdN3WbaotpXvvTGeyObjnAQqv+UZ4E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051171; c=relaxed/simple;
	bh=6SkUnP9RGBvWR4IoA2E6NHjide+8sSSiyPtcwNOOa3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXd/XuDaUKnIZAmePwYeiMg8YpzTcIyeyWGTaF0nvybcPlULkn7Ntid3D1C2tptT5Axj7tvewD47F/6AgGy/mBHDgcnnLnDOVpkurJ8NycaiDaRLbh0Rxnn/72nOu5Jb6VjlBQBCYPIvl372kQ7knFSIg1MtTMfWsMi0FGYnITw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H+YwJR20; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5e42b4bbfa4so3254924a12.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Feb 2024 08:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709051168; x=1709655968; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hBKFu0Ya5JmP4az7C2cHxRd0awbl84xqh3yGGRws2Po=;
        b=H+YwJR20gWchVIcfBCXZwuWAxloXgT5oo1NRIVfyjvDFEElK5nOIiRzSlAH+0n3zBz
         pwoYmztFdCmuo7Vk2tXzpAqJfQvscjfeG6wvdyTmmL2Se9lFfxoFq38DP0MPRHz0hiFT
         YMzfjIYROGFd23T7Q6aFRO+QubBsf/LOvTZCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709051168; x=1709655968;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hBKFu0Ya5JmP4az7C2cHxRd0awbl84xqh3yGGRws2Po=;
        b=sfSdSaXZYzfhBNEGTobXVpZCA5Ys8ZSHJ/lRvTa8rqRVWXSkswYN4QMCKYe4FnoIHw
         7bCFvxeRjz4xWCrB5U3ENfGDZla5LOiYvhSLwnOI728VGdGLCK/1CMbaXSCo4u96oHrt
         uUrSzPEv0eZVJ0r/xpx4FOyDZWIY4/KcsF3jH1tTVbL7cfWM5FGDAmcKtZQOd1mGMLoh
         FVaO5kY/0miDjiAol+vYL4pBHOHTTxqDxQ3qMi7lsIGRHpug3Mz0wHL2kerLx11cctBo
         mL/6VN+IGACzpynRGFSuEIJH0FpSevHHgOTw5MfshCOjunbbbQfOUMefWWs3DQdvorA4
         mmDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXx2f4TYv4Bl/obWD3ObhjOOLUMzYajOzBvNQWq75L6OEUV5jnVfUG9U4cYi+C6c+PdYwqOQ2klrE7mhWl1JDlUPTJGOW6O10=
X-Gm-Message-State: AOJu0Yzm+OTRbY1FLac/M6dep8SMBVNDMMQb9HoYGsivTzWYkcKIIiQX
	ld3nMxqltp3IBRmLrkOVVYFwh8Iw0+a0qEAenSST73VCs7YQSiLPfzfixLRLTw==
X-Google-Smtp-Source: AGHT+IF5A7otWY6j9n+RuyI5RPoqh6fnGIgjMJzPafRPfezs1JD//wxGP07nyFU8qtveZBY9jAwrNQ==
X-Received: by 2002:a17:90b:804:b0:29a:6436:ed59 with SMTP id bk4-20020a17090b080400b0029a6436ed59mr8967426pjb.2.1709051167889;
        Tue, 27 Feb 2024 08:26:07 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id su6-20020a17090b534600b0029a7951c4a3sm8622065pjb.41.2024.02.27.08.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 08:26:07 -0800 (PST)
Date: Tue, 27 Feb 2024 08:26:06 -0800
From: Kees Cook <keescook@chromium.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, rui.zhang@intel.com,
	lukasz.luba@arm.com, gustavoars@kernel.org, morbo@google.com,
	justinstitt@google.com, stanislaw.gruszka@linux.intel.com,
	linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH] thermal: core: Move initial num_trips assignment before
 memcpy()
Message-ID: <202402270816.0EA3349A76@keescook>
References: <20240226-thermal-fix-fortify-panic-num_trips-v1-1-accc12a341d7@kernel.org>
 <6a6be01d-3453-4268-8b2e-0279cc20835d@linaro.org>
 <CAJZ5v0h87k6xoi-9V0Cfb2rHQcr-STfG_bNWpzfoj4Dy46U0Lw@mail.gmail.com>
 <f81af0ae-7458-47d3-90ae-71d5217ee7dd@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f81af0ae-7458-47d3-90ae-71d5217ee7dd@linaro.org>

On Tue, Feb 27, 2024 at 04:37:36PM +0100, Daniel Lezcano wrote:
> On 27/02/2024 12:09, Rafael J. Wysocki wrote:
> > On Tue, Feb 27, 2024 at 11:14 AM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> > > 
> > > On 27/02/2024 01:54, Nathan Chancellor wrote:
> > > > When booting a CONFIG_FORTIFY_SOURCE=y kernel compiled with a toolchain
> > > > that supports __counted_by() (such as clang-18 and newer), there is a
> > > > panic on boot:
> > > > 
> > > >     [    2.913770] memcpy: detected buffer overflow: 72 byte write of buffer size 0
> > > >     [    2.920834] WARNING: CPU: 2 PID: 1 at lib/string_helpers.c:1027 __fortify_report+0x5c/0x74
> > > >     ...
> > > >     [    3.039208] Call trace:
> > > >     [    3.041643]  __fortify_report+0x5c/0x74
> > > >     [    3.045469]  __fortify_panic+0x18/0x20
> > > >     [    3.049209]  thermal_zone_device_register_with_trips+0x4c8/0x4f8
> > > > 
> > > > This panic occurs because trips is counted by num_trips but num_trips is
> > > > assigned after the call to memcpy(), so the fortify checks think the
> > > > buffer size is zero because tz was allocated with kzalloc().
> > > > 
> > > > Move the num_trips assignment before the memcpy() to resolve the panic
> > > > and ensure that the fortify checks work properly.
> > > > 
> > > > Fixes: 9b0a62758665 ("thermal: core: Store zone trips table in struct thermal_zone_device")
> > > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > > > ---
> > > >    drivers/thermal/thermal_core.c | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> > > > index bb21f78b4bfa..1eabc8ebe27d 100644
> > > > --- a/drivers/thermal/thermal_core.c
> > > > +++ b/drivers/thermal/thermal_core.c
> > > > @@ -1354,8 +1354,8 @@ thermal_zone_device_register_with_trips(const char *type,
> > > > 
> > > >        tz->device.class = thermal_class;
> > > >        tz->devdata = devdata;
> > > > -     memcpy(tz->trips, trips, num_trips * sizeof(*trips));
> > > >        tz->num_trips = num_trips;
> > > > +     memcpy(tz->trips, trips, num_trips * sizeof(*trips));
> > > 
> > > IIUC, clang-18 is used and supports __counted_by().
> > > 
> > > Is it possible sizeof(*trips) returns already the real trips array size
> > > and we are multiplying it again by num_trips ?
> > > 
> > > While with an older compiler, __counted_by() does nothing and we have to
> > > multiply by num_trips ?
> > > 
> > > IOW, the array size arithmetic is different depending if we have
> > > _counted_by supported or not ?
> > 
> > IIUC it is just the instrumentation using the current value of
> > tz->num_trips (which is 0 before the initialization).
> 
> Right, but I am wondering if
> 
> 	memcpy(tz->trips, trips, num_trips * sizeof(*trips));
> 
> 	is still correct with __counted_by because:
> 
>  (1) if the compiler supports it:
> 
> 	sizeof(*trips) == 24 bytes * num_trips

I think you're misunderstanding. The above sizeof() only evaluates a
single instance -- it has no idea how many more there may be.
Specifically:

	sizeof(*trips) == sizeof(struct thermal_trip)

> 	then:
> 
> 	memcpy(tz->trips, trips, num_trips * sizeof(*trips));
> 
> 	memcpy(tz->trips, trips, num_trips * 24 * num_trips);
> 
> 	==> memory size = 24 * num_trips^2

It's not counted twice. Under CONFIG_FORTIFY_SOURCE=y, memcpy is a macro
that expands to a checking routine (see include/linux/fortify-string.h),
which is using __builtin_dynamic_object_size() to determine the
available size of the destination buffer (tz->trips). Specifically:

	__builtin_dynamic_object_size(tz->trips)

When __bdos evaluates a flexible array (i.e. tz->trips), it will see the
associated 'counted_by' attribute, and go look up the value of the
designated struct member (tz->num_trips). It then calculates:

	sizeof(*tz->trips) /* a single instance */
		*
	tz->num_trips

Before the patch, tz->num_trips is 0, so the destination buffer size
appears to be of size 0 bytes. After the patch, it contains the
same value as the "num_trips" function argument, so the destination
buffer appears to be the matching size of "num_trips * sizeof(struct
thermal_trip)".

Hopefully that helps! If not, I can try again. :)

-Kees

-- 
Kees Cook

