Return-Path: <linux-pm+bounces-15478-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CD4999211
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 21:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF5928270F
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 19:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7C61A0AF2;
	Thu, 10 Oct 2024 19:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dGrF0pnz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AFC19D889
	for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2024 19:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728588023; cv=none; b=CvsOJxfRO3slXBKU382tNQcDldVRCZentpYpVWWiZGxe459aHc/7QSIqHyFuNGm9bJHjRb0iQCSE9P4T79NR1HxDOw0wT0pE0RsPi3NrGwanAYuHnZxOqCbSd0QNaapdP8BKElm4+1w8OG0LlEeX5QEs86dDL3vkWZW5PFIszHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728588023; c=relaxed/simple;
	bh=4FoHPAbCWQkvasPbxouUn8uT2zh5Nt/Ba/C2vIIzybU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ceSB1c1VdnZGqDYBXffGOv3kWW1EJjjRLn/iXR1BsXXDcmd17IwqRUy/QgmZPkh8btD5iZ3QE7J40Mgvxbe5JjVYplbVGKj9MKTlGIFeO6xhrKXUX3/bd5j4yd80Dnq48A5kT96e+7WF3EMStOrvObVUhwSTr/FY2Lie9aew8ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dGrF0pnz; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20b86298710so10784655ad.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2024 12:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728588020; x=1729192820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r+BODyIhSqd2pJlE6qPBvKGxEaL6QBZWYFAR1GLNeUI=;
        b=dGrF0pnzVrQsBIUUj3zg5e/G8uqYNkUsT6VDqpK9+yoFoF2yrZgH2g+ttbg2GKbbnk
         qcFYv+zjwE8adFNGe6NutpYKXEhaItX0bEzdoPLFdHO3pQvgwlcuWB706kcvgqfY54CA
         FAGTQzW7rnkMj5k7628tp/Pd2heN9LMuBgG9WXotVGtrxq11lWxJ1H/4qJBX8caqQ6i6
         6/BlT0pfFI7Q5R3x44I/SQIONj9m48dWqMbMqJ03s7vo+nvahzJhCWg9kLBoA6tj8g87
         mGNc8+1YcB3Nyj/ARGoITZ5dGZvk1hjxZWmSRF/K9JJPBtqugJc8fcdM4W+xPmmvQdRv
         yDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728588021; x=1729192821;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+BODyIhSqd2pJlE6qPBvKGxEaL6QBZWYFAR1GLNeUI=;
        b=XRD09hWvT8Xhq0pwZMEOhmOwtNdw5tWgIRyAvPYxBngY+ivYmrrZ2jAr2XTwW8sGFd
         H7cIkmBGWtRj+EU9VcLRTBmARD3Jzhx+bcV6iXNWrQVW2mjvQDPBEEO33CgehJZHI9pn
         +UI26s6RCxLq+jmdWZVAgYtDym05ubRNqC4NSb0qj0jfM6cKdRc8fodDZfX3bmz4JpFO
         smsKYEWNvUyCqqD78wr515EQsjHH409P65/FFX+OpxsIjoALKzYRIS+uG3D9RlDtS2UR
         KDuryoipVzCpKiPRajiRXNt3anvemiNHQFiLOGmVzP7mZmwnmcHiPe9EgJ1AABDniMMw
         YXsg==
X-Forwarded-Encrypted: i=1; AJvYcCXbOKwALjuV9zioXUImsc6ZfNVoLOEw59R3EdK8OiCdokIldWXYJGfOyDuhmTMqqvy6OFs9Aruj2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuLx6XoM14V/0wdzPpsDXplkGPAxKx8ya7Ik3+81heFtz9BcIk
	WdxwQWidd9awW2I/EiZl61Ty/0SqXw6lkfjwlyOyz/GfRBSEjp/RynGFptL3KAQ=
X-Google-Smtp-Source: AGHT+IEmMdpbbpRUGZkO7n+MIvY7dXprg2D8yfwzPJoORV2mbUw48ITf6tv7zxFu1O77ic/6MNw3Nw==
X-Received: by 2002:a17:903:1251:b0:20b:7ed8:3990 with SMTP id d9443c01a7336-20c636eb667mr113868475ad.12.1728588020574;
        Thu, 10 Oct 2024 12:20:20 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0e7750sm12567515ad.131.2024.10.10.12.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 12:20:19 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Saravana Kannan
 <saravanak@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd
 <sboyd@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: arm64 s2idle vs. workqueues
In-Reply-To: <7e22ed71-4e61-4250-a81d-eda4f4647b8b@arm.com>
References: <7ho73shkrw.fsf@baylibre.com>
 <CAJZ5v0hTYkR64x_h5_Qn_J6k=seSZ=eKqdNKEC+UzkQMe1wC1A@mail.gmail.com>
 <7e22ed71-4e61-4250-a81d-eda4f4647b8b@arm.com>
Date: Thu, 10 Oct 2024 12:20:19 -0700
Message-ID: <7hjzefydcc.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Christian Loehle <christian.loehle@arm.com> writes:

> On 10/10/24 11:23, Rafael J. Wysocki wrote:
>> Hi Kevin,
>>=20
>> On Thu, Oct 10, 2024 at 2:19=E2=80=AFAM Kevin Hilman <khilman@baylibre.c=
om> wrote:
>>>
>>> Hello,
>>>
>>> Looking for some pointers/tips on debugging s2idle, and in particular
>>> why it is not staying in an idle state as long as expected.
>>>
>>> I'm attempting to use s2idle on a 4-core, single cluster ARM64 SoC (TI
>>> AM62x), which doesn't (yet) have any DT defined idle-states, so is just
>>> doing a WFI when idle.
>>>
>>> I'm doing an 8-second s2idle with RTC wakeup by using:
>>>
>>>   rtcwake -m freeze -s8
>>>
>>> and what I see is that 3 of the CPUs stay in their idle state for the
>>> full 8 seconds, but one of them keeps waking due to the A53
>>> arm_arch_timer firing, and processing misc. workqueue related activity
>>> (example work listed below[1].)
>>>
>>> I realize that these workqueues are not WQ_FREEZABLE, so I don't expect
>>> the freezer part of suspend to stop/freeze them.  However, I am a bit
>>> surprised to see this non-frozen workqueue activity happening often
>>> enough (few times per second) to prevent all 4 CPUs from being idle for
>>> long periods at the same time, thus preventing a deeper cluster-idle
>>> state.
>>>
>>> Is there something else I'm missing that is needed to keep these
>>> workqueues quiet for longer?  I had assumed that most of this workqueue
>>> work would be deferred, and shouldn't need to wakeup a CPU just to run.
>>>
>>> In case it's helpful I have published a trace.dat from trace-cmd which
>>> captures power, sched, irq, timer and workqueue events.  With
>>> kernelshark, it's pretty obvious to visualize what's happening: CPU0,1,3
>>> are all nicely idle for 8 sec while CPU2 is waking due to the timer and
>>> workqueue activity.
>>>
>>> Any pointers to how to improve this situation, or what else needs to be
>>> tweaked here would be greatly appreciated,
>>=20
>> It looks like tick_freeze() is not called, which only happens in
>> enter_s2idle_proper() that is called from cpuidle_enter_s2idle() if
>> there are any idle states with an .enter_s2idle() callback.
>>=20
>> So does the cpuidle driver for this platform provide .enter_s2idle()
>> callbacks for any of its idle states?
>
> AFAICT there shouldn't be a cpuidle driver that initialized and WFI is
> entered through arch code. The trace.dat indicates that, too.

That's correct.=20=20

> @Kevin
> I assume you can add a state in the DT, disable it and everything works
> as expected?

Thanks for the suggestion.  I tried that quickly, but ran into a couple
problems:

1) If the state is added, but disabled, that leaves only a WFI state,
   and the current PSCI CPUidle driver fails out and defers to arch idle
   if there's only the 1 WFI state[1]

2) The PSCI implementation on this SoC does not implement OSI mode, and
   the PSCI CPUidle driver also doesn't setup the s2idle callbacks
   unless OSI is supported[2]

I'm going to hack a bit around these limitations just to see if I can
get fully idle, but long term, it looks like I have some TF-A work to do
for the PSCI implementation on this SoC.  But at least now I understand
the s2idle callbacks and the missing tick_freeze() path, so it makes
sense why my platform is not fully idle/suspended.  And the good news is
that the TF-A implementation for these TI SoCs is fully upstream, and I
can build & use my own version, so that will be the next step.

Thanks for the pointers!

Kevin

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/cpuidle/cpuidle-psci.c?h=3Dv6.11#n361
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/cpuidle/cpuidle-psci.c?h=3Dv6.11#n221

