Return-Path: <linux-pm+bounces-1383-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B63D7819139
	for <lists+linux-pm@lfdr.de>; Tue, 19 Dec 2023 21:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6441C235B9
	for <lists+linux-pm@lfdr.de>; Tue, 19 Dec 2023 20:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1144914AAA;
	Tue, 19 Dec 2023 20:16:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655CD39AC1
	for <linux-pm@vger.kernel.org>; Tue, 19 Dec 2023 20:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-593f182f263so141976eaf.0
        for <linux-pm@vger.kernel.org>; Tue, 19 Dec 2023 12:16:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703017005; x=1703621805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VpltIBnT66ZsgjtFpSCtrp5wL9F2st9PYDV5+4HKeSk=;
        b=F1hOSPjXIxBxy7nbZHuU1LybWEnVsmOd+VeMF5UAimZ6WMclTqlzrj0VF84d4AYsqU
         POThiw93PaUbjgpZoDnAjLRZa8jFhu1mWap/7anuif3fHzdBUw3Yo52v8v21TZvLvnkH
         ESz9oGsdr6i0XizDwIj4/f0Cw5SeJZ2BJ9uSCTw1/nBgYwJzggIW/YFHTRvB7Q5UhscZ
         A5SzqcMF2FsCgDCCZ26NEp7w7JZCMT0uvgvD07mrExUBxEFD5oOPF6ndY27StJy9gld1
         kJ+5KqGA2ZdX8DayqaRHgHh5Gm3gAEGzqu5Gr69dTrQZ2Cy+XTAhukn/R6TGlNOQ+8Bs
         RVAA==
X-Gm-Message-State: AOJu0Yz3P/rVOOvJKP9s9e+a1PNAir+uCFs1aEv7a2qmDrX245898KkL
	Dc3a90Qp2gTxwKapPSdbD8KGk0sbknANv+h1kbs=
X-Google-Smtp-Source: AGHT+IEvFlQ8xeHxottuWfdS/ljrjHAkhyeDa3dOBd+3q8wEGptwm2HNB/jtQl970+ddHnLeBWoeUS9mHVsxOpEuFR8=
X-Received: by 2002:a05:6820:2a18:b0:590:9027:7ab0 with SMTP id
 dr24-20020a0568202a1800b0059090277ab0mr27502211oob.0.1703017005472; Tue, 19
 Dec 2023 12:16:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212140043.714303-1-haokexin@gmail.com>
In-Reply-To: <20231212140043.714303-1-haokexin@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 19 Dec 2023 21:16:34 +0100
Message-ID: <CAJZ5v0iOjL5sMt9SYT2BS-TyWgNiJgW_ghqaEVR=r0genrSyOg@mail.gmail.com>
Subject: Re: [PATCH] docs: power: Adjust freezing-of-tasks.rst due to the
 freezer logic changes
To: Kevin Hao <haokexin@gmail.com>
Cc: linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 3:01=E2=80=AFPM Kevin Hao <haokexin@gmail.com> wrot=
e:
>
> Peter has rewritten core freezer logic in commit f5d39b020809
> ("freezer,sched: Rewrite core freezer logic"), adjust the
> freezing-of-tasks.rst according to this commit. The main changes
> include:
> - Drop the mention of PF_FROZEN and PF_FREEZER_SKIP
> - Introduce TASK_FROZEN, TASK_FREEZABLE and __TASK_FREEZABLE_UNSAFE
> - Replace system_freezing_cnt with freezer_active
> - Use another example for the loop of a freezable kernel thread since
>   the old codes are already gone
>
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> ---
>  Documentation/power/freezing-of-tasks.rst | 83 +++++++++++++----------
>  1 file changed, 47 insertions(+), 36 deletions(-)
>
> diff --git a/Documentation/power/freezing-of-tasks.rst b/Documentation/po=
wer/freezing-of-tasks.rst
> index 53b6a56c4635..8969ed244b20 100644
> --- a/Documentation/power/freezing-of-tasks.rst
> +++ b/Documentation/power/freezing-of-tasks.rst
> @@ -14,27 +14,28 @@ architectures).
>  II. How does it work?
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -There are three per-task flags used for that, PF_NOFREEZE, PF_FROZEN
> -and PF_FREEZER_SKIP (the last one is auxiliary).  The tasks that have
> -PF_NOFREEZE unset (all user space processes and some kernel threads) are
> -regarded as 'freezable' and treated in a special way before the system e=
nters a
> -suspend state as well as before a hibernation image is created (in what =
follows
> -we only consider hibernation, but the description also applies to suspen=
d).
> +There are one per-task flag (PF_NOFREEZE) and three per-task states
> +(TASK_FROZEN, TASK_FREEZABLE and __TASK_FREEZABLE_UNSAFE) used for that.
> +The tasks that have PF_NOFREEZE unset (all user space processes and some=
 kernel
> +threads) are regarded as 'freezable' and treated in a special way before=
 the
> +system enters a suspend state as well as before a hibernation image is c=
reated
> +(in what follows we only consider hibernation, but the description also =
applies
> +to suspend).
>
>  Namely, as the first step of the hibernation procedure the function
>  freeze_processes() (defined in kernel/power/process.c) is called.  A sys=
tem-wide
> -variable system_freezing_cnt (as opposed to a per-task flag) is used to =
indicate
> -whether the system is to undergo a freezing operation. And freeze_proces=
ses()
> -sets this variable.  After this, it executes try_to_freeze_tasks() that =
sends a
> -fake signal to all user space processes, and wakes up all the kernel thr=
eads.
> -All freezable tasks must react to that by calling try_to_freeze(), which
> -results in a call to __refrigerator() (defined in kernel/freezer.c), whi=
ch sets
> -the task's PF_FROZEN flag, changes its state to TASK_UNINTERRUPTIBLE and=
 makes
> -it loop until PF_FROZEN is cleared for it. Then, we say that the task is
> -'frozen' and therefore the set of functions handling this mechanism is r=
eferred
> -to as 'the freezer' (these functions are defined in kernel/power/process=
.c,
> -kernel/freezer.c & include/linux/freezer.h). User space processes are ge=
nerally
> -frozen before kernel threads.
> +static key freezer_active (as opposed to a per-task flag or state) is us=
ed to
> +indicate whether the system is to undergo a freezing operation. And
> +freeze_processes() sets this variable.  After this, it executes
> +try_to_freeze_tasks() that sends a fake signal to all user space process=
es, and
> +wakes up all the kernel threads. All freezable tasks must react to that =
by
> +calling try_to_freeze(), which results in a call to __refrigerator() (de=
fined
> +in kernel/freezer.c), which sets the task's state to TASK_FROZEN, and ma=
kes it
> +loop until it is woken by an explicit TASK_FROZEN wakeup. Then, we say t=
hat the
> +task is 'frozen' and therefore the set of functions handling this mechan=
ism is
> +referred to as 'the freezer' (these functions are defined in
> +kernel/power/process.c, kernel/freezer.c & include/linux/freezer.h). Use=
r space
> +processes are generally frozen before kernel threads.
>
>  __refrigerator() must not be called directly.  Instead, use the
>  try_to_freeze() function (defined in include/linux/freezer.h), that chec=
ks
> @@ -43,31 +44,40 @@ if the task is to be frozen and makes the task enter =
__refrigerator().
>  For user space processes try_to_freeze() is called automatically from th=
e
>  signal-handling code, but the freezable kernel threads need to call it
>  explicitly in suitable places or use the wait_event_freezable() or
> -wait_event_freezable_timeout() macros (defined in include/linux/freezer.=
h)
> -that combine interruptible sleep with checking if the task is to be froz=
en and
> -calling try_to_freeze().  The main loop of a freezable kernel thread may=
 look
> -like the following one::
> +wait_event_freezable_timeout() macros (defined in include/linux/wait.h)
> +that puts the task to sleep (TASK_INTERRUPTIBLE) or frozen (TASK_FROZEN)=
 if the
> +task is freezing. The main loop of a freezable kernel thread may look li=
ke the
> +following one::
>
>         set_freezable();
> -       do {
> -               hub_events();
> -               wait_event_freezable(khubd_wait,
> -                               !list_empty(&hub_event_list) ||
> -                               kthread_should_stop());
> -       } while (!kthread_should_stop() || !list_empty(&hub_event_list));
>
> -(from drivers/usb/core/hub.c::hub_thread()).
> +       while (true) {
> +               struct task_struct *tsk =3D NULL;
>
> -If a freezable kernel thread fails to call try_to_freeze() after the fre=
ezer has
> -initiated a freezing operation, the freezing of tasks will fail and the =
entire
> -hibernation operation will be cancelled.  For this reason, freezable ker=
nel
> -threads must call try_to_freeze() somewhere or use one of the
> +               wait_event_freezable(oom_reaper_wait, oom_reaper_list !=
=3D NULL);
> +               spin_lock_irq(&oom_reaper_lock);
> +               if (oom_reaper_list !=3D NULL) {
> +                       tsk =3D oom_reaper_list;
> +                       oom_reaper_list =3D tsk->oom_reaper_list;
> +               }
> +               spin_unlock_irq(&oom_reaper_lock);
> +
> +               if (tsk)
> +                       oom_reap_task(tsk);
> +       }
> +
> +(from mm/oom_kill.c::oom_reaper()).
> +
> +If a freezable kernel thread fails to be put to frozen state after the f=
reezer
> +has initiated a freezing operation, the freezing of tasks will fail and =
the
> +entire hibernation operation will be cancelled.  For this reason, freeza=
ble
> +kernel threads must call try_to_freeze() somewhere or use one of the
>  wait_event_freezable() and wait_event_freezable_timeout() macros.
>
>  After the system memory state has been restored from a hibernation image=
 and
>  devices have been reinitialized, the function thaw_processes() is called=
 in
> -order to clear the PF_FROZEN flag for each frozen task.  Then, the tasks=
 that
> -have been frozen leave __refrigerator() and continue running.
> +order to wake up each frozen task.  Then, the tasks that have been froze=
n leave
> +__refrigerator() and continue running.
>
>
>  Rationale behind the functions dealing with freezing and thawing of task=
s
> @@ -96,7 +106,8 @@ III. Which kernel threads are freezable?
>  Kernel threads are not freezable by default.  However, a kernel thread m=
ay clear
>  PF_NOFREEZE for itself by calling set_freezable() (the resetting of PF_N=
OFREEZE
>  directly is not allowed).  From this point it is regarded as freezable
> -and must call try_to_freeze() in a suitable place.
> +and must call try_to_freeze() or variants of wait_event_freezable() in a
> +suitable place.
>
>  IV. Why do we do that?
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --

Applied as 6.8 material with some edits in the subject and changelog.

I have also edited some new documentation language added by the patch
for clarity etc.

Thanks!

