Return-Path: <linux-pm+bounces-36763-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBC7C03B30
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 00:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DF40B354AFC
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 22:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB0B26B742;
	Thu, 23 Oct 2025 22:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YmVdb8yk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C2E2BB1D
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 22:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761259620; cv=none; b=P8+gxw/+8ya0gcldAy8CDmLyvW0/PtG0OnArsttQb/HTe8N11S33QP3hmbQpq5vxJY3TvKo4hFwGs7xX4Y4t4Fx/jHNzrKpJpCZ+Yt4rCWpSyFKswi/g6sExq9/yH/2E6y2w7Mbb4R2t85zEjxYsF+3GtZYbspBj0Al7wjzmuBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761259620; c=relaxed/simple;
	bh=Lol0p/1OcEr3XP8rccD/JNpnzjatyofXWIu/y5Mo7yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AkETC57HxORvofz8gqX6SzqCeIxatDYxwXe20lKJTugRfheFqETk+8ntRf9mDn6nYjQd6nYK2PDXEJkDSzMb5tchdUmGREeBxmQb3Akrz79FG0NC2HsXBMQpkZGy1eXgxGJu/6vNErTX64SvERATHd9M6C/0Unqm6Mbfk2MAMOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YmVdb8yk; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-591ea9ccfc2so1782316e87.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 15:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761259617; x=1761864417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Inm/Nl3N+ajXJIRPlgpoAaTOjrjWGkKwCCLc+Xq7Vjk=;
        b=YmVdb8ykJb0KZN/pbJG0ZDrTNRT4h00UeNjbQiJoPcAxAiz3N0AT3wSNt+CasyiRs2
         ubebmuGmzteCXc+GKBTPkQKwj9FaSgum1SedqCKced4iF4o9pvRxJK/W95sPUSDvOmxu
         Fech57iTHXe/oQ/QzhwVYASG1iA0/s71AHYrhHLkTejQ9ryIP9kI+HS6v5oCst+paj9v
         k1024GnX+PzZ9xRwQuw7JgBzQ7ngcanBvHlN+YXsocTBnFePO4I6iaoUJE2Ap/sYAZ8F
         zM/UEqmzT2d2xLKqU7/KzdPtgCrwPZ07AGYzifWZkGqrLJOF5yqXZXlMyCLDTpjxkjjk
         BO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761259617; x=1761864417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Inm/Nl3N+ajXJIRPlgpoAaTOjrjWGkKwCCLc+Xq7Vjk=;
        b=smL+oJ9K4J7IihrleXhZPXi7bCkZy7xEeq4Ag2yfMH5IWXcsc6zqS9nMbstuSTxjDZ
         vVVyDciMsR/8r52ZzAXZ1XMS/IP3NTl8IhNa0blJDFP50VUx6Kz9MUsbK0i0JjlhZaST
         81jM8K2VK0ppLl1+jCknLQl0gTa1WEFcFRr+k16QCsbqW3sqef5hTgQ1qP1S3e+PEqwG
         JKyJ4DaQS99XT2eRzwWHzQtRzidO0agpzdBzrnelNKucDumvSr56gct8Aq9culIY5wiy
         VviCQjSG6cs/QzrmDvafkFC5dDu3Qa4G7bwDLd/luJ7UL2wonR8C/rDAvOf72GJNZZGl
         aDaA==
X-Forwarded-Encrypted: i=1; AJvYcCW3zFPp1YGqErNVbYJ3ryOZiEJgGqExFx9leNJZO8IvPNO/UDZLISb+3haFCFDJdQcvsT1/S3wbHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxP1YOeluIObF9u0tacwhYmmOl7EAYFNbYsPzlL8KJS8N5C+A2b
	w+AViYta4kyViWPvwaVFi6F6oBEvt6WsOWYCkeHzUi5yvnZWWF7s7J68//58mfiGPXjNA/mBmB2
	qv9GjiShWsvCQbyuTfy2Mo61GltsEkFGB0l7l1vpL
X-Gm-Gg: ASbGncsT8n6I/djNuAfKQXD9XsV9y9PidPHamKOEl3BmGESsd0cR5oZHuRt93a0Dksw
	5ZLGHRU/Dt3e0F/WZYKtGBsz22sMha2j9IzpFNsrG0B1QOjCejNVFzIIpDp7maCKS5fScqn5I7C
	FCM9TnHupIp1LRmktP5DGrTa666U/aNMN3TdP9gghufiyuuxyUmNfxw1pGQqSTnVvvoPcrCl0+C
	4qjVpXfhmCof4/ksxwdoO9MBZGAY/C6acO1cVvUt+yowwTd/wN1cfVNmYBX981qVLBr8fEFxPKU
	KihlnqDNrtod2emakxeUF3AD1A==
X-Google-Smtp-Source: AGHT+IHd5CrBHOm5d55EZjNIzsejzp5sHxKL56t5ZuAQBybymQT4Nr1WQQxe6t8K0VMJIG/YeZ2rMVyTq12nuS4YXPY=
X-Received: by 2002:a05:6512:1194:b0:592:f390:1bf0 with SMTP id
 2adb3069b0e04-592fc10c87cmr182196e87.8.1761259616375; Thu, 23 Oct 2025
 15:46:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017233907.2305303-1-wusamuel@google.com> <CAJZ5v0g37NNj3inHcrZG8NHeTAGAncLAY7t9Yj3bTAv7GgAQJQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0g37NNj3inHcrZG8NHeTAGAncLAY7t9Yj3bTAv7GgAQJQ@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 23 Oct 2025 15:46:16 -0700
X-Gm-Features: AS18NWCKhCxcu9rV_fl2epxZCgjuKDm8df8zwWqtPgbmGMJ1K6Tc8s6PbuH5cMU
Message-ID: <CAGETcx8ZL3jAwFRxO1B8SFSWmC2jCitc9_61hBG-N2AvzRQv7w@mail.gmail.com>
Subject: Re: [PATCH v5] PM: Support aborting sleep during filesystem sync
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, tuhaowen@uniontech.com, 
	kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 12:43=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Sat, Oct 18, 2025 at 1:39=E2=80=AFAM Samuel Wu <wusamuel@google.com> w=
rote:
> >
> > At the start of suspend and hibernate, filesystems will sync to save th=
e
> > current state of the device. However, the long tail of the filesystem
> > sync can take upwards of 25 seconds. If during this filesystem sync
> > there is some wakeup or abort signal, it will not be processed until th=
e
> > sync is complete; from a user's perspective, this looks like the device
> > is unresponsive to any form of input.
> >
> > This patch adds functionality to handle a sleep abort signal when in
> > the filesystem sync phase of suspend or hibernate. This topic was first
> > discussed by Saravana Kannan at LPC 2024 [1], where the general
> > consensus was to allow filesystem sync on a parallel thread. In case of
> > abort, the suspend process will stop waiting on an in-progress
> > filesystem sync, and continue by aborting suspend before the filesystem
> > sync is complete.
> >
> > Additionally, there is extra care needed to account for back-to-back
> > sleeps while maintaining functionality to immediately abort during the
> > filesystem sync stage. This patch handles this by serializing the
> > sequence with an invariant; a subsequent sleep's filesystem sync
> > operation will only start when the previous sleep's filesystem sync has
> > finished. While waiting for the previous sleep's filesystem sync to
> > finish, the subsequent sleep will still abort early if a wakeup event i=
s
> > triggered, solving the original issue of filesystem sync blocking abort=
.
>
> It would be good to spell out the rationale for starting another
> filesystem sync when suspend starts while the previous sync is still
> in progress.
>
> > [1]: https://lpc.events/event/18/contributions/1845/
> >
> > Suggested-by: Saravana Kannan <saravanak@google.com>
> > Signed-off-by: Samuel Wu <wusamuel@google.com>
> > ---
> > Changes in v5:
> > - Update spin_lock() to spin_lock_irqsave() since abort can be in IRQ c=
ontext
> > - Updated changelog description to be more precise regarding continuing=
 abort
> >   sleep before fs_sync() is complete
> > - Rename abort_sleep_during_fs_sync() to pm_stop_waiting_for_fs_sync()
> > - Simplify from a goto to do-while in pm_sleep_fs_sync()
> > - v4 link: https://lore.kernel.org/all/20250911185314.2377124-1-wusamue=
l@google.com
> >
> > Changes in v4:
> > - Removed patch 1/3 of v3 as it is already picked up on linux-pm
> > - Squashed patches 2/3 and 3/3 from v3 into this single patch
> > - Added abort during fs_sync functionality to hibernate in addition to =
suspend
> > - Moved variables and functions for abort from power/suspend.c to power=
/main.c
> > - Renamed suspend_fs_sync_with_abort() to pm_sleep_fs_sync()
> > - Renamed suspend_abort_fs_sync() to abort_sleep_during_fs_sync()
> > - v3 link: https://lore.kernel.org/all/20250821004237.2712312-1-wusamue=
l@google.com/
> >
> > Changes in v3:
> > - Split v2 patch into 3 patches
> > - Moved pm_wakeup_clear() outside of if(sync_on_suspend_enabled) condit=
ion
> > - Updated documentation and comments within kernel/power/suspend.c
> > - v2 link: https://lore.kernel.org/all/20250812232126.1814253-1-wusamue=
l@google.com/
> >
> > Changes in v2:
> > - Added documentation for suspend_abort_fs_sync()
> > - Made suspend_fs_sync_lock and suspend_fs_sync_complete declaration st=
atic
> > - v1 link: https://lore.kernel.org/all/20250815004635.3684650-1-wusamue=
l@google.com
> >
> >  drivers/base/power/wakeup.c |  8 ++++
> >  include/linux/suspend.h     |  4 ++
> >  kernel/power/hibernate.c    |  5 ++-
> >  kernel/power/main.c         | 75 +++++++++++++++++++++++++++++++++++++
> >  kernel/power/suspend.c      |  7 +++-
> >  5 files changed, 96 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> > index d1283ff1080b..689c16b08b38 100644
> > --- a/drivers/base/power/wakeup.c
> > +++ b/drivers/base/power/wakeup.c
> > @@ -570,6 +570,13 @@ static void wakeup_source_activate(struct wakeup_s=
ource *ws)
> >
> >         /* Increment the counter of events in progress. */
> >         cec =3D atomic_inc_return(&combined_event_count);
> > +       /*
> > +        * wakeup_source_activate() aborts sleep only if events_check_e=
nabled
> > +        * is set (see pm_wakeup_pending()). Similarly, abort sleep dur=
ing
> > +        * fs_sync only if events_check_enabled is set.
> > +        */
> > +       if (events_check_enabled)
> > +               pm_stop_waiting_for_fs_sync();
> >
> >         trace_wakeup_source_activate(ws->name, cec);
> >  }
> > @@ -899,6 +906,7 @@ EXPORT_SYMBOL_GPL(pm_wakeup_pending);
> >  void pm_system_wakeup(void)
> >  {
> >         atomic_inc(&pm_abort_suspend);
> > +       pm_stop_waiting_for_fs_sync();
> >         s2idle_wake();
> >  }
> >  EXPORT_SYMBOL_GPL(pm_system_wakeup);
> > diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> > index b02876f1ae38..dc6829b3836f 100644
> > --- a/include/linux/suspend.h
> > +++ b/include/linux/suspend.h
> > @@ -450,6 +450,8 @@ void restore_processor_state(void);
> >  extern int register_pm_notifier(struct notifier_block *nb);
> >  extern int unregister_pm_notifier(struct notifier_block *nb);
> >  extern void ksys_sync_helper(void);
> > +extern void pm_stop_waiting_for_fs_sync(void);
> > +extern int pm_sleep_fs_sync(void);
> >  extern void pm_report_hw_sleep_time(u64 t);
> >  extern void pm_report_max_hw_sleep(u64 t);
> >  void pm_restrict_gfp_mask(void);
> > @@ -505,6 +507,8 @@ static inline void pm_restrict_gfp_mask(void) {}
> >  static inline void pm_restore_gfp_mask(void) {}
> >
> >  static inline void ksys_sync_helper(void) {}
> > +static inline pm_stop_waiting_for_fs_sync(void) {}
> > +static inline int pm_sleep_fs_sync(void) {}
> >
> >  #define pm_notifier(fn, pri)   do { (void)(fn); } while (0)
> >
> > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > index 14e85ff23551..9c8db4b3c114 100644
> > --- a/kernel/power/hibernate.c
> > +++ b/kernel/power/hibernate.c
> > @@ -824,7 +824,10 @@ int hibernate(void)
> >         if (error)
> >                 goto Restore;
> >
> > -       ksys_sync_helper();
> > +       error =3D pm_sleep_fs_sync();
> > +       if (error)
> > +               goto Restore;
> > +
> >         if (filesystem_freeze_enabled)
> >                 filesystems_freeze();
> >
> > diff --git a/kernel/power/main.c b/kernel/power/main.c
> > index 3cf2d7e72567..81a53d833358 100644
> > --- a/kernel/power/main.c
> > +++ b/kernel/power/main.c
> > @@ -570,6 +570,81 @@ bool pm_sleep_transition_in_progress(void)
> >  {
> >         return pm_suspend_in_progress() || hibernation_in_progress();
> >  }
> > +
> > +static bool pm_sleep_fs_sync_queued;
> > +static DEFINE_SPINLOCK(pm_sleep_fs_sync_lock);
> > +static DECLARE_COMPLETION(pm_sleep_fs_sync_complete);
> > +
> > +/**
> > + * pm_stop_waiting_for_fs_sync - Abort fs_sync to abort sleep early
> > + *
> > + * This function causes the suspend process to stop waiting on an in-p=
rogress
> > + * filesystem sync, such that the suspend process can be aborted befor=
e the
> > + * filesystem sync is complete.
> > + */
> > +void pm_stop_waiting_for_fs_sync(void)
> > +{
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&pm_sleep_fs_sync_lock, flags);
> > +       complete(&pm_sleep_fs_sync_complete);
> > +       spin_unlock_irqrestore(&pm_sleep_fs_sync_lock, flags);
> > +}
> > +
> > +static void sync_filesystems_fn(struct work_struct *work)
> > +{
> > +       unsigned long flags;
> > +
> > +       ksys_sync_helper();
> > +       spin_lock_irqsave(&pm_sleep_fs_sync_lock, flags);
> > +       pm_sleep_fs_sync_queued =3D false;
> > +       complete(&pm_sleep_fs_sync_complete);
> > +       spin_unlock_irqrestore(&pm_sleep_fs_sync_lock, flags);
> > +}
> > +static DECLARE_WORK(sync_filesystems, sync_filesystems_fn);
> > +
> > +/**
> > + * pm_sleep_fs_sync - Trigger fs_sync with ability to abort
> > + *
> > + * Return 0 on successful file system sync, otherwise returns -EBUSY i=
f file
> > + * system sync was aborted.
> > + */
> > +int pm_sleep_fs_sync(void)
> > +{
> > +       bool need_pm_sleep_fs_sync_requeue;
> > +       unsigned long flags;
> > +
> > +       do {
> > +               spin_lock_irqsave(&pm_sleep_fs_sync_lock, flags);
> > +               reinit_completion(&pm_sleep_fs_sync_complete);
> > +               /*
> > +                * Handle the case where a sleep immediately follows a =
previous
> > +                * sleep that was aborted during fs_sync. In this case,=
 wait for
> > +                * the previous filesystem sync to finish. Then do anot=
her
> > +                * filesystem sync so any subsequent filesystem changes=
 are
> > +                * synced before sleeping.
> > +                */
> > +               if (pm_sleep_fs_sync_queued) {
> > +                       need_pm_sleep_fs_sync_requeue =3D true;
> > +               } else {
> > +                       need_pm_sleep_fs_sync_requeue =3D false;
> > +                       pm_sleep_fs_sync_queued =3D true;
> > +                       schedule_work(&sync_filesystems);
> > +               }
> > +               spin_unlock_irqrestore(&pm_sleep_fs_sync_lock, flags);
> > +
> > +               /*
> > +                * Completion is triggered by fs_sync finishing or an a=
bort sleep
> > +                * signal, whichever comes first
> > +                */
> > +               wait_for_completion(&pm_sleep_fs_sync_complete);
> > +               if (pm_wakeup_pending())
> > +                       return -EBUSY;
> > +       } while (need_pm_sleep_fs_sync_requeue);
> > +
> > +       return 0;
> > +}
>
> If I'm not mistaken, the mechanism by which one more sync is started
> right after completing the previous one (that was in progress when
> suspend started) can be designed differently.
>
> 1. Use a dedicated ordered workqueue for the sync work items.
> 2. Use a counter instead of the two boolean vars for synchronization.
> 3. In pm_sleep_fs_sync(), if the counter is less than 2, increment the
> counter and queue up a sync work item.
> 4. In sync_filesystems_fn(), decrement the counter.

The problem with this is that we can't reuse the same work item. We'll
have to allocate one each time. Otherwise, we'll be queuing one that's
already queued. Right?

-Saravana

