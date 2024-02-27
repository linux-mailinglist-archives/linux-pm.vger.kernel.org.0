Return-Path: <linux-pm+bounces-4449-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AFD869C5C
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 17:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EC69B33116
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 16:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F861487D3;
	Tue, 27 Feb 2024 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlBgnWT7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424651487C7;
	Tue, 27 Feb 2024 16:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051222; cv=none; b=mnTMbB3wf5YGZrxvk0z8m+MZ+K2iP/DzJyf4mACe2c9fVGRB5O5AgXR97dfks2eev1pjj5AsHCYDS9c7y8qPAW7CgMQJdaSWvq8NUTBae+C/WLDzQzRj8kMiqOT4p+pSZUK5xpSLdXV49MZPwznnH64WUcEhOpDrWGiXcm77+/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051222; c=relaxed/simple;
	bh=8jFZAo+3Rlkk8YpfU62JRB7rR92Dw98Vakvf43eEjpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLn91P5KaegznosU1HgXT/ohOvp9VKDIhd44SJ9QjWZs6yHIB0sgDx9h1VOkPccAN1FG4ITHlwyrip0hV00bsgOx6tKpVh37N0ElU7FI4nHtxOPGKWqK23O+YEdOh2NrQhdP3BSD05cBKdK8OZqqbgteHt66DnfoSTjut3XAfNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlBgnWT7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B4AC43390;
	Tue, 27 Feb 2024 16:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709051221;
	bh=8jFZAo+3Rlkk8YpfU62JRB7rR92Dw98Vakvf43eEjpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VlBgnWT7rsdBa5BM/FJZpKlHcUnBmWUo8v2UFXJi+QII9XK2wfAucQGOFk2dwt3Vw
	 ekdluhlkh1VRWuNBkd6QLak3InKZhPX4gd4WQV+8q86+Dt0b39ion8OFRfMXd+7rOS
	 fi+wQRfo4Cd8mbHs9o79L+z+OvRIFpBaZG6YIuWydzUl4vHKuzanK4nP6HDc+g0baO
	 /bYfL7LJxrqwnuBGeY0/SrQPcuuA4YIiTrDq8SyLSOzzfKld8KGcCpr4QoNDRF3YJu
	 DSaAydna3XbLQKZWjaeacWazGaTNRmHm3NHsV6Xv1tBWWn0lY2vcBxJxKr2tDGoPq/
	 gofkM6v5kYCTQ==
Date: Tue, 27 Feb 2024 09:26:59 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, lukasz.luba@arm.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, rui.zhang@intel.com,
	keescook@chromium.org, gustavoars@kernel.org, morbo@google.com,
	justinstitt@google.com, stanislaw.gruszka@linux.intel.com,
	linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH] thermal: core: Move initial num_trips assignment before
 memcpy()
Message-ID: <20240227162659.GB819789@dev-arch.thelio-3990X>
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

Hi Daniel and Lukasz,

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

No, this is incorrect. sizeof(*trips) == sizeof(struct thermal_trip),
which is never affected by __counted_by. As far as I am aware,
sizeof() in general is never affected by __counted_by because calling
sizeof() on a flexible array member (which are the only things currently
allowed to have __counted_by) is invalid because a FAM is by definition
an unknown size at compile time.

> 	then:
> 
> 	memcpy(tz->trips, trips, num_trips * sizeof(*trips));
> 
> 	memcpy(tz->trips, trips, num_trips * 24 * num_trips);
> 
> 	==> memory size = 24 * num_trips^2
> 
>  (2) if the compiler does not support it:
> 
> 	sizeof(*trips) == 24 bytes
> 
> 	then:
> 
> 	memcpy(tz->trips, trips, num_trips * sizeof(*trips));
> 
> 	memcpy(tz->trips, trips, num_trips * 24);
> 
> 	==> memory size = 24 * num_trips
> 
> Or did I misunderstand __counted_by ?

I see there has been some confusion around this change from both
yourself and Lukasz, so I will try to make things as clear and concise
as I can.

The fortify routines in the kernel rely on __builtin_dynamic_object_size
to get the size of flexible array members (see the macro soup around
memcpy() in include/linux/fortify-string.h). Before __counted_by,
__builtin_dynamic_object_size() on a FAM would return -1. With
__counted_by, __builtin_dynamic_object_size() will be able to return the
correct size of the FAM by looking at the counted by member.

In this case, memcpy() was called with tz->num_trips (the counted by
member) == 0 (meaning that __bdos() will return 0) while trying to copy
'sizeof(*trips) * num_trips' bytes into it, triggering the fortify panic
routine. Moving the tz->num_trips assignment before the memcpy() call
ensures that __bdos() returns the correct amount for checking in the
fortify routines.

Hope that helps clear things up, I will make sure to write a clearer
commit message next time.

Cheers,
Nathan

