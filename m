Return-Path: <linux-pm+bounces-21300-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B963DA25908
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2025 13:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FAC17A10D6
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2025 12:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D97C2040A6;
	Mon,  3 Feb 2025 12:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RwpBMjvh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC07620409A
	for <linux-pm@vger.kernel.org>; Mon,  3 Feb 2025 12:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738584774; cv=none; b=fmqDX5CN4uEbpYJTJMxOYxpS6CWyveLvW6Chd0ClolQHP5di+JngrUVa6u8/PvrTgB3VWGFf9ekA/rIybblbz5ioGitPZ5J6Fau3VG0X8oFi6m831HoIuBUGXTv3NjEyk3qDlh/BbCKAIErqLZpwpv93xPa+Mr7uguMTJEB25zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738584774; c=relaxed/simple;
	bh=Al5nN7+VVsS+6jTXW2BhemO8tZMv7evAKrd72FfIn8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wr5dx9X2r5CNaB94bJNTKGI5yojrKzFXJuHk1XmLeJcrlxicqQr3lGfc5ip840M6wSKMXVtbfrYPMj/QICFceU6qc+2BbOXVRNaQ9ijdEc6C9T08ahNtCLfB+UyJqhNbRkDynG65nNsFNkkJOi587NA0zrSHlCtJvFj4cnJ480E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RwpBMjvh; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6f973c0808dso509577b3.0
        for <linux-pm@vger.kernel.org>; Mon, 03 Feb 2025 04:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738584771; x=1739189571; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G1fCnNO9BE+pRYsCkXAChxvPSR83W+kvApJS3N7O428=;
        b=RwpBMjvhc76XSBYuCALvMc+iK/K0mSKq9fTFPQuu4KEfONDzTIpNXTCg29fgHyM00n
         XQKKqulzsIDmkae2zkOS6vWIaqOpiy59T1lSdIKsNn9GHw79qD03dNuTuYoPPuk4WGPo
         GaVV+O+Zs0NdVT7YuFx2peo3K1TzshxVobFyYIWZUxwbO/zaWofvsgO3pgjDBP1FBz9G
         ZFu4jAr6oZepExmSKJOWTUpNmp5mnnPmMGMBs6Mad3o9b9/i83/jNRpqJMdC0C3uvKTq
         xPYGDfXKd+7ROUyQYN6wuJxIELzCvM/JHzzMtUv6koW/qtXSkKKmUvgr8eX6hQXf4iqK
         0UQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738584771; x=1739189571;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1fCnNO9BE+pRYsCkXAChxvPSR83W+kvApJS3N7O428=;
        b=WPJNLPwKBIQcW2CnwqBYekmKCy4x6SsPo56m4g85cDN56SAiuRrcze6Yluf36BcWPf
         NpKs8kFMrY/yWBwbuTvJczz/4Fa6wIn2Mn5rQ1xDctAfHOgMybPznGB/KI+Q4Cd2AsBm
         ghUdbi3M1FL7i+xzXORaYqiqW7cHG/ro0ACFvZ/j6wxjgZKgb6VW2cVOtQGKSIlS2dMo
         UIZ/U/ebF2GmPBtjXCWWgyo1UA0Xut/M4UdkRpswDif/Q8ZDF+GvV4RjMIfLU/WQrgqc
         DM89EwMRl7IIWbCGr12HBwcj60GF5qUWLzZObFlgKU2js5srxW900kAXhn0QN3cRE1PA
         sf1w==
X-Forwarded-Encrypted: i=1; AJvYcCULtYau5YXVth3DRBzax3fa0/DPElXE7UTMhULQR+0m9vcndgNSDCu80iPZTTHHAAuG1Urq5gecTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzG6/JVn8f0GmIhrsbhpiuPZuALFuJ8x4z4oizisl7RdVyd/Hii
	WvMyEw4/QJNPvJz99Kt16+RZT2M1N766KeB9afl3wfT5JrtF6RajesRBt2XAX97T5Ae00xv8cqE
	j3NC3mvLD1IiYFMxP4MzWhtjJfQVAS6MJ3mCZ5Q==
X-Gm-Gg: ASbGnct56Jy5OSS7GgTf7wxdLu0cuK7pJWo+YImUBIsv3J54Lpy5MgPnI/y2YzRq/q4
	ZJxcG8lkhOQfiALpp3PrWv/yMl189dLoJc5LIjUPVaFwo7tWE1cF4LG88eoZDDW3Q5x/XhkQ8XQ
	==
X-Google-Smtp-Source: AGHT+IFRUR8JbA29f5mpJGLTtBTaacsV+IGEaozqrnO9adT6XC3/4NobaMzzaIo2HNZrmPqrTbZHo5WN9mGkT+rdHeQ=
X-Received: by 2002:a05:690c:3581:b0:6f6:7b02:2568 with SMTP id
 00721157ae682-6f7a8423943mr162561157b3.32.1738584771686; Mon, 03 Feb 2025
 04:12:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12619233.O9o76ZdvQC@rjwysocki.net> <CAPDyKFpc5p3sXZ6LfdVgt8jR5ZbsQExTgeyMNA-PzcWs5A9U0A@mail.gmail.com>
 <CAJZ5v0gvQjp_P-5Ww7iN1cGiiMJ6tvLLnPpkTQNk++KhoRe=GA@mail.gmail.com>
 <CAPDyKFrBO+r8qYRrhoFZN21__8RuR61ofbsGQZbA=pyQbti5CA@mail.gmail.com>
 <CAJZ5v0jTutgKeXtg3YLR1Onw9gOmvHudHamVVgMxEsieNDXViw@mail.gmail.com>
 <CAPDyKFpmNPhyV3YoBFu7KnW04550DQgqzGHAbGLLqp7=TggVtw@mail.gmail.com>
 <CAJZ5v0iYHBeMra_ba-1Ht4xoPGsyt7gg05RtGxoa_gG91s1xEA@mail.gmail.com>
 <CAPDyKFqkqOXD0oVZoOFR4O6ucqLS4n85_S4SNPvPAc6hfaELgw@mail.gmail.com> <CAJZ5v0jAEJ7DPS4yarwL5Nx_8EVNR0XepjnsCdNuM4pF=Cw9bg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jAEJ7DPS4yarwL5Nx_8EVNR0XepjnsCdNuM4pF=Cw9bg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 3 Feb 2025 13:12:15 +0100
X-Gm-Features: AWEUYZntgiPQgKGhnRjLHhrJxgceqb9ss7gC4Ai8-DSdXsy0Am7_yZUV7wpNkTU
Message-ID: <CAPDyKFp9RGFAGjChF6jLqy9GttbJm06BGAfOLdZaXUrcagfCgg@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: core: Synchronize runtime PM status of
 parents and children
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Bjorn Helgaas <helgaas@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Kevin Xie <kevin.xie@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"

[...]

> >
> > The problem with $subject patch is that drivers/buses are required to
> > check the runtime PM status, with pm_runtime_suspended(),
> > pm_runtime_status_suspended() or pm_runtime_active() in one of its
> > system suspend/resume callbacks , to synchronize it with the HW state
> > for its device (turn on/off clocks for example).
>
> Well, I'm kind of unaware of this requirement.
>
> It clearly is not even followed by the code without the $subject patch.
>
> The real requirement is that the runtime PM status at the point when
> runtime PM is re-enabled, that is in device_resume_early(), must
> reflect the current actual HW state.

Right. Seems like we are in agreement, just that there seems to be
multiple ways to describe the similar problem.

>
> > Certainly, we can not rely on drivers to conform to this behaviour and
> > there are plenty of cases where they really don't. For example, we
> > have drivers that only implements runtime PM support or simply don't
> > care about the runtime PM status during system resume, but just leaves
> > the device in the state it is already in.
>
> Drivers that only support runtime PM are broken with respect to system
> sleep ATM.  They need to be made to support system sleep or they
> cannot be used on systems that use system sleep.  There may be a way
> around this for system suspend/resume (see below), but not for
> hibernation.

I think calling them broken may be to take this a step too far.

While I certainly agree that these drivers have room for some
improvements, it looks to me that these drivers work today, but may
not with $subject patch.

>
> > Moreover, we have the users of pm_runtime_force_suspend|resume(),
> > which we also know *not* to work with DPM_FLAG_SMART_SUSPEND and thus
> > $subject patch too. I am less worried about these cases though, as I
> > believe we should be able to fix them, by taking into account the
> > suggested "->power.set_active flag", or something along those lines.
>
> Yes, and that's what I'm going to do.
>
> > That said, it seems like we need another way forward.
>
> I still don't see why, sorry.
>
> I guess the concern is that if a device suddenly needs to be resumed
> during system resume even though it was runtime-suspended before the
> preceding system suspend, there is no way to tell its driver/bus
> type/etc that this is the case if they all decide to leave the device
> as is, but as I have said for multiple times in this thread, leaving a
> device as is during system resume may not be an option unless it is a
> leaf device without any subordinates.  This has always been the case.
>
> We'll see if there is any damage resulting from the $subject change
> and we'll fix it if so.
>
> In the future, though, I'd like to integrate system resume with
> runtime PM more than it is now.  Namely, it should be possible to move
> the re-enabling of runtime PM to the front of device_resume_early()
> and then use pm_runtime_resume() for resuming devices whose drivers
> support runtime PM (I don't see any fundamental obstacles to this).
> One benefit of doing this would be that pm_runtime_resume() would
> automatically trigger a runtime resume for all of the "superior"
> devices, so they could be left in whatever state they had been in
> before the preceding system suspend regardless of what happens to
> their "subordinates".  It is likely that some kind of driver opt-in
> will be needed for this or maybe the core can figure it out by itself.

Right, I am certainly interested to discuss this topic too. It's not
an easy thing and the biggest problem is that we can't really just
change the behaviour without a big risk of breaking things.

Some kind of opt-in behaviour is the only thing that can work, in my
opinion. Anyway, I am here to review and discuss. :-)

>
> It can look at what callbacks are implemented etc.  For example, if a
> driver only implements :runtime_suspend() and :runtime_resume() and no
> other PM callbacks, it is reasonable to assume that the devices
> handled by it should be suspended and resumed with the help of the
> runtime PM infrastructure even during system-wide suspend/resume (that
> doesn't apply to hibernation, though).

Maybe this can work in some opt-in/out way, but certainly not as a
solution for all.

For example, we have subsystems that deal with system suspend/resume
quite differently, where drivers instead implement some subsystem
specific callbacks, rather than the common system suspend/resume ops.

Kind regards
Uffe

