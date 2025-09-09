Return-Path: <linux-pm+bounces-34191-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D267B49EE8
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 04:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32803BFC38
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 02:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7764223DC6;
	Tue,  9 Sep 2025 02:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vBIjEix3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0472B19047A
	for <linux-pm@vger.kernel.org>; Tue,  9 Sep 2025 02:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757383244; cv=none; b=SjJan2JCInviIjY0rhMzdFI1kJhReLKTjMqmpKh9ow3VRvxdlZyvpNO1IR4lt3nu7EsBNlGb5tuVDjpxRdPcybMr06CPEs3OWPU9xm8ivoxbTmlWEiqod0tWy9jgl/px0a6BNSM9IQjRPu985z6DE8GcYbtGa/doid454PhMcE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757383244; c=relaxed/simple;
	bh=zuPqNZ68u2af28bwGLbv9fPu7FYHqhaAoDVube2UhAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpznaaTBxrbk+Ux8vwet0GqjbOMETsdHsi8i4ynvGXuck5kCyzYd4C+CziLfi1Yur4JwLVsLM21R656241hXTKnydVGfmpZECi+r9qmQmvT/v43QlGpC23gf0heMhN5buP1ihcBspBo8GIYPL2B4arOsjCsPqFnRnymFm7gbwYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vBIjEix3; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-51d14932f27so2111738137.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Sep 2025 19:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757383242; x=1757988042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKxpPZtTTWrTIR4CV5+v50JEvpPOByN97qUkciEVdus=;
        b=vBIjEix3cxI/7iaeBH7sY587ifZKcWmFr9tyVNOZYSSl0aFKXSdCAtjCYZEYvussaJ
         jkFOWJfEB5NuKZzPogmRoyoIGM5GD+UrJRMdQIZG46N+zq8oGfZOuKSQom+HetbfBDuG
         oUMljqJW5yyFPXqqdqqNSZ43SWwiZGqQZ5Ucg5GHrQHEM0vBCnELYVuA2THgM1lgWopF
         WvdvXOl+2ulr3cnciwXvEX8K4xOLkUwiN3CP+rY8VKWnVmmPCoRVlb1Q7wD1R9BFc6sA
         HknFvWAuTurFaj0Jl4Vykv6GMUgYM4qgcCtkWaN1SbpIwkEC7qex0FuQQrzDOqXCFDL9
         mekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757383242; x=1757988042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKxpPZtTTWrTIR4CV5+v50JEvpPOByN97qUkciEVdus=;
        b=tVKPo5A3ssdXmsOT/tdm62R6Y8v/I9Irh71bRMpJ6N9bgxG0LgNPm+K1wq+0yj+nkc
         OO5vAcOjO8Wo8KyjlJHsDkhOXFE3EeQcgOAtDrDLznfLmL2hk78Xuk3mFCeM0G87y3zm
         T9SpYY4nCB6JEgJzDmQAvsQToqmFwApeKWTuqkUWVkwuik4T1G58IWDbAMNfcrZ5gNRV
         jZUu1pTltVuYIo82uCCT6fIp2WJnWHIdNln0P92s9zyo/lIWbo4em20RFPdJ8uskqxiW
         yjI8GEWYMKRmRwLPOe1MMtJSWwTOHQ44rg+V1URwdEuxV6kXKolGzIdTVUO1hU+Pe/oZ
         wU3w==
X-Forwarded-Encrypted: i=1; AJvYcCUANBuJqyYzqTQwamerVvCLFZ57QHmXAuiP7r1Fn/C2XceYYFfjHSuLKEyooCXLHugo9kdpXFI8Pg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxiOk3sUFEk26toQKRgJaJZbuj8rj2Rsk1KKoPz30cq6cbFuBg6
	ylOyUBFCrSx/IPO0TrgxW8wbGZlIbXptwfQnuQ3yiy18bP7wYmyE4L5UGqj/BCcszWwik1LFajX
	wGvoj6AammXXRUM/mgNpYPyjaUWxrgIswTZMjEjrG
X-Gm-Gg: ASbGnctJ65YlSbsWlpdm6g2LCd8lSYkRN3kIeVhaKs08XYiq9m8IrTHmcsSsJ44Z1WO
	cbpoGskBJ3TNql/syksw2LHBRb4gsDBCzPFL2wNVmGgbSBUvDFuFDsCBbW7+p7EVvTrdi2/6O3n
	ipTrHqWp2+aTgi8EXQ4QtPcD/T2bJAL+2F97AV9H1udlk9/NjE+qiPVf6BoHSB5JKoB8zYI4rjD
	+i6EWFAlVSPFu7Kue8J3QU=
X-Google-Smtp-Source: AGHT+IGiepV4XCQUslSf+DLHz+/0zREsNdtYn9EqALZmfzKcyWhrUuodghQm+NSHjnZvI3OjP141hvYtybM5qLVfJTU=
X-Received: by 2002:a05:6102:5cc2:b0:52e:90c:847b with SMTP id
 ada2fe7eead31-53d1c0f5f1cmr2817973137.13.1757383241035; Mon, 08 Sep 2025
 19:00:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908024655.14636-1-tuhaowen@uniontech.com>
In-Reply-To: <20250908024655.14636-1-tuhaowen@uniontech.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 8 Sep 2025 19:00:04 -0700
X-Gm-Features: AS18NWDjtLmKoTswqPSUWvrH4poKVV6NVpJQwJlSuCGxxoMX3mhzXvWd2taXJTo
Message-ID: <CAGETcx_C_UcjjPOfUip=L28P3PWjMvmSc4nZJ5ML=tScUXfk2w@mail.gmail.com>
Subject: Re: Sync timeout mechanisms - Request for coordination
To: tuhaowen <tuhaowen@uniontech.com>
Cc: wusamuel@google.com, rafael@kernel.org, len.brown@intel.com, 
	pavel@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	huangbibo@uniontech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Haowen,

On Sun, Sep 7, 2025 at 7:47=E2=80=AFPM tuhaowen <tuhaowen@uniontech.com> wr=
ote:
>
> Hi Samuel and Saravana,
>
> I hope this email finds you well. I'm reaching out regarding the sync
> timeout mechanisms for suspend/hibernation that we've both been working o=
n.

I hope you are well too and thanks for reaching out to us.

> Rafael from the upstream kernel has indicated that he would prefer us to
> coordinate our approaches rather than having two separate implementations=
.
> He mentioned your patch series "PM: Support aborting suspend during
> filesystem sync" and suggested we work together on a unified solution.
>
> I would like to discuss how we can merge our approaches. Below is a
> summary of my current implementation:
>
> **My approach - Time-based timeout mechanism:**
> - Introduces a configurable timeout for sync operations during both
>   suspend and hibernation
> - Uses kthread with wait_for_completion_timeout() to implement timeout
> - Provides sysfs interface /sys/power/sleep_sync_timeout for runtime
>   configuration
> - Default behavior unchanged (timeout disabled by default)
> - Addresses scenarios where sync is excessively slow without wakeup event=
s

This doesn't really fix our issue where we want to abort suspend only
if we have to stay awake. If there's no need to abort the suspend (to
deal with some user/wake source request), then it's okay to take the
time to sync and then suspend. If you abort the suspend, it's just
going to get attempted again and in fact waste power.

I also don't understand how your patch fixes anything. If anything
this makes things worse because the user might have expected their
device to have hibernated only to come back hours later to see their
battery dead. And even if the user is actively monitoring it, you
still need to sync the file system fully before you eventually
suspend. So, this doesn't really save any time or the need to sync.

>
> You can see the detailed implementation and Rafael's feedback at:
> https://lore.kernel.org/linux-pm/CAJZ5v0jBRy=3DCvZiWQQaorvc-zT+kkaB6+S2TE=
rGmkaPAGmHLOQ@mail.gmail.com/
>
> **Key differences I see between our approaches:**
> 1. Your solution focuses on aborting sync when wakeup events occur
> 2. My solution addresses cases where there are no wakeup events but sync
>    is excessively slow (e.g., slow/faulty storage)
> 3. Your approach uses workqueue + completion, mine uses kthread + timeout

I don't think the workqueue vs kthread matters -- trivial
implementation detail. The important point is when we want to abort.

> 4. Both aim to prevent indefinite hangs but cover different scenarios

I don't see the point of your change though. Why abort a suspend if
there's no need to wake up? I think whatever use case issue you are
hitting, it's more of an issue of not grabbing a wake source when it's
needed.

Can you explain the actual real world issue you are trying to fix? If
it's the UI hanging and not responding to keypress/mouse move, then to
me it looks like those should be marked as wake sources.

>
> **Potential unified approach:**
> I believe both mechanisms could complement each other:
> - Event-driven abort (your approach) for responsive wakeup handling
> - Time-based timeout (my approach) for proactive protection against
>   slow storage
> - Single, unified implementation in kernel/power/main.c
>
> Would you be interested in discussing how we can combine these approaches=
?
> I'm open to:
> 1. Merging the implementations into a single solution
> 2. Adopting your workqueue approach with added timeout functionality
> 3. Any other technical approach you think would work better

I'm not convinced adding a timeout is the right solution. It just adds
another point of failure and the need for a retry mechanism.

However, if you are really set on proving the need for a timeout and
implementing it, you can always add it as a separate patch after our
patch lands. You can set up a timer to call pm_system_wakeup(). Or
just grab a wake source after a time period.

In fact, thinking more about this, you are generally having a problem
with suspend taking too long to complete. Doesn't matter if it's due
to file system sync or anything else. In which case, you should just
use a timer to call pm_system_wakeup() and not fix just file system
sync (which happens to be the current long pole).

> Looking forward to your thoughts and collaboration.

Hope my response helps.

-Saravana

