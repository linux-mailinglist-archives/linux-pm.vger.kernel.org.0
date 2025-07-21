Return-Path: <linux-pm+bounces-31247-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F926B0CCD6
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 23:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DCCE6C3947
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 21:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CE41F2361;
	Mon, 21 Jul 2025 21:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DPVKZKMs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439837DA7F
	for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 21:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753134485; cv=none; b=LuaB8I/z6hrG/QatQ2RIyfq6wJjwm2/XOUKNIi0x01C73btvuMUP+NF/YY2UtvCCBL+wd7XL9V/+3k7petyGwOg08Ue+hUEKo5ux90QHiL4T7pCNWNWRy2T5TBwV8b5umt0DclH9rFAOsC+YqthoVUWklIAbtTkalo1zNQ9jN0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753134485; c=relaxed/simple;
	bh=/cxmrl6M5wjmEIKKkIVgKw4Gt/QtFpcoVq5DLCCLR7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AeyxzL6QGexC3YKwHqo1AILzATouAqSgilhFbq9AEkyPzt0tPuxDUG6YHd3cfHqKkZo+St7pbG+b+/sBR0XZ4fE42GJqdi6WV8UjGDMsWQwp9qRjck4SVkmtp0WAukaW//ufvVPnvwn2CKbpiUUZPKlMDCsQuqjSuusoqImwYfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DPVKZKMs; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-880f92a63c7so2450805241.1
        for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 14:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753134483; x=1753739283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yV4g+i2RgFE+gfGu3rBpzdbN5NSnFxxFd7wCPsNpPqU=;
        b=DPVKZKMsh2VIBePT4TrkY3JeAjNWfO78NMEs/f5Fp7gQlF8kPFmSuEL/BSAKMQOhjJ
         WXBysx2BK3FxqgnLmCrmaPuSAPjyhQlX849X6UZPeXxjdMXoM7MaEJUwhwveFCers1ZW
         L8qsFE6lwc+s5k9FVFxwlZwsYUkqc8OzTmKYBsnrDIOwCQw9rjVoqZZW2BdqCywAddgJ
         cF8VbLyDoTULD4YZGzpm5bgUIRU/6qXhD3jFw83tAkJkKFJrJivZgPbrPp8VkSl/Khl9
         FOXFOR1cQqy0FiMEHZkQwEn0jzRRZ5ZJwNpe8xIK+8cQrVfJfER7H7WKQbMqRF9mHe4V
         VETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753134483; x=1753739283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yV4g+i2RgFE+gfGu3rBpzdbN5NSnFxxFd7wCPsNpPqU=;
        b=hi+1X68ARlihw2qsEohm8+phzjVzZXJPA3q0hNbJIILw2PWjF+PxaUH9TwRuXxeRX6
         b+b54zN7ANx23j/CGoe8Ajbe2IwCNtJD7y+nx8vi6h4Y+SNQxFzws/JG0dD2kCYfkYQz
         WmCh8/ya99OTGSMdYck093HwMwc4NOLurtCZoYndqm+FkMUE4/oH4VX0NN5CTHlomtL6
         AILtKgJVrfuJjLQIMYjfxZ6+WaOzlxr4onV5M9YCrDM303rob/Z0cRSRnbw6YylprUTn
         6IAJnu8En/e2Zrgrzq0q+Sp3kglNFbyGasvuNPZcXKijeQp6P0r3zWGe/QKx+5C8TRx+
         g09A==
X-Forwarded-Encrypted: i=1; AJvYcCUsOVbbw7mBs3iCcKX5SPFwEv5fsVd0gKJapFdSx8iZSXaIrZ3k/bdLGTryhFre3pxV58WJX4tyVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2LVi4VsWflJhUthrH0NKBB0l0gn4NdqtZombCJHuRD2fzIdOl
	hkwudmqNTMdiZ0YAKDrCuWQBvLX/ipg4JMOLucC48/JgFlWvR1fnG479M2y8Jmu0efPxoAM8IK6
	RWplmAhixrG/rQNK/i19DKg2uH1hRbbpFatAdOWLN
X-Gm-Gg: ASbGncuwr4d2n/HJBvcxcsDCEF92ohXAqkl8onSj6qIWgCGkCHLwAaVs46we7BHYlFb
	5azFXzwVurMCCbEg/peHIf8dG5duYAN5TdXoht/+Yk7kbFRkRUKjvufk1IarX6KjsluG0bhaQ+y
	KywicA7epjIm33UxS55MNdYgYGYR1ka2s9lNSzXSfHEdPG+stIm4FG6ErqgxkxRZdAV4Di8Cp6R
	8apPg==
X-Google-Smtp-Source: AGHT+IE9Out0U4eDp0L+lruC6Z3AgfqLk7sBkM4K1tQa/T3sgkadDi0x/cJmpAjNVCV1NmyaxPsujtpuXXtJm76gr64=
X-Received: by 2002:a05:6102:6a83:b0:4bc:82f:b4e0 with SMTP id
 ada2fe7eead31-4f95f456fe8mr10840452137.22.1753134482804; Mon, 21 Jul 2025
 14:48:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718071842.2483378-1-saravanak@google.com> <CAJZ5v0ifsVycSWk24gMrEsGtDn0nVkUJGH8vwBvJdEA1XHbTRQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0ifsVycSWk24gMrEsGtDn0nVkUJGH8vwBvJdEA1XHbTRQ@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 21 Jul 2025 14:47:25 -0700
X-Gm-Features: Ac12FXwwOQTkhHGVCyyAhfFO3bgUo_GCkpiCND0suCVSKQ4yTELFAGmtrUkgzPQ
Message-ID: <CAGETcx830BEJ1Trb5DVQL=m5FuF=qe+9aZbU0J2DiLZ-sz18bA@mail.gmail.com>
Subject: Re: [RFC PATCH v1] PM: wakeup: Provide interface for userspace to
 abort suspend
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 12:51=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:

Thanks for responding to my RFC!

>
> On Fri, Jul 18, 2025 at 9:18=E2=80=AFAM Saravana Kannan <saravanak@google=
.com> wrote:
> >
> > Once suspend starts, it can take a while before file system sync
> > finishes and all the userspace threads are frozen. During this time,
> > there can be events that originate in userspace that would require the
> > suspend to be aborted.
> >
> > The only way to abort suspend from userspace as of today is to grab
> > and release a kernel wakelock using the /sys/power/wake_lock and
> > /sys/power/wake_unlock files. This has the disadvantage of:
> >
> > * Doing the useless work of creating and destroying wakelocks.
> > * If the userspace entity crashes after the wake lock is created, we
> >   get a wake lock/memory leak.
>
> But wakelocks are for this purpose.

Right, wakelocks might be working as intended where they don't go away
if the userspace process crashes.

>
> > To avoid all this and simplify the interface, this patch allows
> > canceling a suspend by writing UINT_MAX value to the
> > /sys/power/wakeup_count that is meant for tracking wakeup events.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >
> > Rafael,
> >
> > If the idea looks good to you, I can also update Documentation and sent
> > it as a non-RFC patch. I'm not too tied on what file we use to trigger
> > an abort from userspace as long as it's possible.
>
> I would rather add an interface based on a special device file for
> wakelocks to address this.

While the device file based approach for creating kernel wakelocks
from userspace might be cleaner, this patch isn't trying to address
that though. We already have a UAPI for that and the userspace suspend
managers use it.

>
> For example, open it to create a wakelock with the name of a calling
> process, write 1 to it to block suspending, write 0 to it to unblock,
> close to remove it.
>
> Then it will go away automatically when the process exits.

The scenario this patch is trying to address is to abort a suspend
that was initiated by userspace (system with CONFIG_PM_AUTOSLEEP
disabled). It's not really a kernel wakelock request asking the kernel
to keep the system from suspending -- it doesn't need to because
CONFIG_PM_AUTOSLEEP is disabled. And we certainly don't want to create
a kernel wakelock for every single user space wakelock. That's a lot
of unnecessary overhead.

Another way to look at this is that we have a way to initiate suspend
by writing "mem" to /sys/power/state, but we don't have any way to
abort it. Another version of this patch that I was considering was to
write "abort" to /sys/power/state to abort an ongoing suspend. Would
that version of the patch make more sense to you?

Thanks,
Saravana


>
> >  drivers/base/power/wakeup.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> > index d1283ff1080b..9316de561bcc 100644
> > --- a/drivers/base/power/wakeup.c
> > +++ b/drivers/base/power/wakeup.c
> > @@ -1008,6 +1008,8 @@ bool pm_save_wakeup_count(unsigned int count)
> >         if (cnt =3D=3D count && inpr =3D=3D 0) {
> >                 saved_count =3D count;
> >                 events_check_enabled =3D true;
> > +       } else if (cnt =3D=3D UINT_MAX) {
> > +               pm_system_wakeup();
> >         }
> >         raw_spin_unlock_irqrestore(&events_lock, flags);
> >         return events_check_enabled;
> > --
> > 2.50.0.727.gbf7dc18ff4-goog
> >
> >

