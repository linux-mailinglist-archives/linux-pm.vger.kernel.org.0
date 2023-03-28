Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6DE6CBC62
	for <lists+linux-pm@lfdr.de>; Tue, 28 Mar 2023 12:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjC1KR1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Mar 2023 06:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjC1KR0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Mar 2023 06:17:26 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872E249D7
        for <linux-pm@vger.kernel.org>; Tue, 28 Mar 2023 03:17:17 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x3so47315757edb.10
        for <linux-pm@vger.kernel.org>; Tue, 28 Mar 2023 03:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679998635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNLT5+oHFXOacJzceFxr6eKivsdkixlMlAuR8QNdsfE=;
        b=SQXMZjWzqiYx4WyfjOKPIYgcNqy9lzlQivjk7Fl7bHvgdbHz/llSdJSbYdYcImc0R8
         YPKLKWUHz67TMbMX8q7jJ1ovZRjwH3eh7g3StZSA/PLZ31adYExAcPfduJrDFzC8CbUZ
         qYKyYwVsd6ehlLcwOJAWoUIIIXQad4Qc/goiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679998635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNLT5+oHFXOacJzceFxr6eKivsdkixlMlAuR8QNdsfE=;
        b=eobqXrukTJk1gfYkthz2BvI0EanLaG6N7BTN68EsgKtiXWFIRv7CqRF6R0bJ2YYM2N
         crPQpo00qSBOtFHG5KoIAx/hIVQWoY4ujwT/boYXDdKLzeeyV5gHPIF7Z5LvN+Tanal1
         FzwcasYgR3wTebJwEhA9nd/HIBk61nAoBNuD1xF5tQX2zSKIOMUW3hDswACOUeJGWGiC
         209xkVTOwRqyroRD8oxXE03KlX/32D8tkDa0zzjOwNSNqS9Rz3w83ELe/t+v8gMzyHxa
         9gixA6Mlt4RyElGvoazy7BRylQXv3m95rLl7Tab26OjT8/m84Pbqlh/PRtgs12ibqSzj
         Z1uQ==
X-Gm-Message-State: AAQBX9c6HiHqlrMn/TjtKZL/I/6AyInkDdwo5YdlRBNqMQPD/k9rg6Uf
        Djj8uZGKep8A+WznoKayvbVnr5MOpYhs5jfnpUw=
X-Google-Smtp-Source: AKy350Yvh85oCOUY+Zj6EtraT8lUtOalyKikURLp5AMJ4C7rV8tsA/zln87kiP7W3k1xR9hv+fqUaQ==
X-Received: by 2002:a05:6402:4c3:b0:4fb:fd9f:737a with SMTP id n3-20020a05640204c300b004fbfd9f737amr15799869edw.4.1679998635691;
        Tue, 28 Mar 2023 03:17:15 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id ec21-20020a0564020d5500b004fc01b0aa55sm15600510edb.4.2023.03.28.03.17.14
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 03:17:15 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id x3so47315408edb.10
        for <linux-pm@vger.kernel.org>; Tue, 28 Mar 2023 03:17:14 -0700 (PDT)
X-Received: by 2002:a17:906:524b:b0:877:747d:4a90 with SMTP id
 y11-20020a170906524b00b00877747d4a90mr7793742ejm.14.1679998634021; Tue, 28
 Mar 2023 03:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230227121318.2116638-1-md@chromium.org> <20230227121318.2116638-2-md@chromium.org>
 <CAJZ5v0ik2vJ9t24nj0dpUfekvzwacLVkbGpViaBdADrLf6-cvQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0ik2vJ9t24nj0dpUfekvzwacLVkbGpViaBdADrLf6-cvQ@mail.gmail.com>
From:   Michal Dubiel <md@chromium.org>
Date:   Tue, 28 Mar 2023 12:17:02 +0200
X-Gmail-Original-Message-ID: <CAPxDTA_v__C=PGTfduu1GbwcECvx=LsVjFtqTAAcEEVN2o2Geg@mail.gmail.com>
Message-ID: <CAPxDTA_v__C=PGTfduu1GbwcECvx=LsVjFtqTAAcEEVN2o2Geg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kernel/freezer: Add routine to read task's freezing reason
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, pavel@ucw.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 27, 2023 at 5:57=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Mon, Feb 27, 2023 at 1:14=E2=80=AFPM Michal Dubiel <md@chromium.org> w=
rote:
> >
> > There are few reasons why a task is freezing. It can be due to system
> > suspend, it can be due to explicit user request, etc.
>
> Actually, there are two of them, either it is cgroup freezing, or it
> is freezing on system suspend AFAICS.
>
> > For most cases, the actual reason is not important, but there are some =
that
> > it is useful to distinguish between what actually caused the task to
> > freeze.
> >
> > One example is when user requests freezing of tasks belonging to a cert=
ain
> > cgroup. If for any reason, system goes suspend and resume when the cgro=
up
> > is frozen, the already frozen tasks should not be thawed but remain fro=
zen
> > to ensure the suspend/resume cycle transparency. The system should not =
warn
> > about skipping thawing of such processes as it is normal situation.
> >
> > The proposed function allows to obtain information about the freezing
> > reason and let the calling code decide what to do accordingly.
>
> I honestly don't think that this new function is necessary.

This function (freezing_reason) is used in the second patch to
differentiate between the freezing reason and suppress warnings for
the tasks explicitly requested for freezing by the user.

> Moreover, it would be better to combine this patch with the other one
> in the series.

I thought that separation into two patches makes sense as the first
introduces a new, generic function in the kernel/freezer and the
second one suppresses unnecessary warnings. The second patch is doing
that by using the function introduced in the first patch, but that
function is more generic and can potentially be used elsewhere so I
thought there is a functional separation here, thus 2 patches.
Nevertheless, if you prefer a single patch that is perfectly fine,
just let me know I will squash the patches.

> > Signed-off-by: Michal Dubiel <md@chromium.org>
> > ---
> >  include/linux/freezer.h | 17 +++++++++++++++
> >  kernel/freezer.c        | 23 ++++++++++++++------
> >  2 files changed, 33 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/freezer.h b/include/linux/freezer.h
> > index b303472255b..b936a349e0d 100644
> > --- a/include/linux/freezer.h
> > +++ b/include/linux/freezer.h
> > @@ -28,6 +28,23 @@ extern bool frozen(struct task_struct *p);
> >
> >  extern bool freezing_slow_path(struct task_struct *p);
> >
> > +extern enum freezing_reason freezing_reason_slow_path(struct task_stru=
ct *p);
> > +
> > +enum freezing_reason {
> > +       FREEZING_NONE     =3D 0,
> > +       FREEZING_CGROUP   =3D (1 << 0),
> > +       FREEZING_PM       =3D (1 << 1),
> > +       FREEZING_PM_NOSIG =3D (1 << 2),
> > +};
> > +
> > +static inline enum freezing_reason freezing_reason(struct task_struct =
*p)
> > +{
> > +       if (static_branch_unlikely(&freezer_active))
> > +               return freezing_reason_slow_path(p);
> > +
> > +       return FREEZING_NONE;
> > +}
> > +
> >  /*
> >   * Check if there is a request to freeze a process
> >   */
> > diff --git a/kernel/freezer.c b/kernel/freezer.c
> > index 4fad0e6fca6..2536054db60 100644
> > --- a/kernel/freezer.c
> > +++ b/kernel/freezer.c
> > @@ -26,6 +26,21 @@ bool pm_nosig_freezing;
> >  /* protects freezing and frozen transitions */
> >  static DEFINE_SPINLOCK(freezer_lock);
> >
> > +enum freezing_reason freezing_reason_slow_path(struct task_struct *p)
> > +{
> > +       if (pm_nosig_freezing)
> > +               return FREEZING_PM_NOSIG;
> > +
> > +       if (cgroup_freezing(p))
> > +               return FREEZING_CGROUP;
> > +
> > +       if (pm_freezing && !(p->flags & PF_KTHREAD))
> > +               return FREEZING_PM;
> > +
> > +       return FREEZING_NONE;
> > +}
> > +EXPORT_SYMBOL(freezing_reason_slow_path);
>
> Why do you need to export this and why is it not EXPORT_SYMBOL_GPL()?

I considered that function a part of the kernel/freezer external
interface, similarly as the existing freezing_slow_path() is. Both the
existing freezing_slow_path() and the newly introduced
freezing_reason_slow_path() are currently not used outside of
kernel/freezer.c by any intree modules, but they potentially could be
and since the existing freezing_slow_path() already had been exported
I opted for being consistent and export (using the same
EXPORT_SYMBOL() as the rest of the entire file)
freezing_reason_slow_path() as well. However, if you think that's not
necessary or wrong I am happy to remove that. Please let me know.

> > +
> >  /**
> >   * freezing_slow_path - slow path for testing whether a task needs to =
be frozen
> >   * @p: task to be tested
> > @@ -43,13 +58,7 @@ bool freezing_slow_path(struct task_struct *p)
> >         if (test_tsk_thread_flag(p, TIF_MEMDIE))
> >                 return false;
> >
> > -       if (pm_nosig_freezing || cgroup_freezing(p))
> > -               return true;
> > -
> > -       if (pm_freezing && !(p->flags & PF_KTHREAD))
> > -               return true;
> > -
> > -       return false;
> > +       return (bool)freezing_reason_slow_path(p);
>
> This is the only call site of this function, so the explicit
> conversion to bool like this doesn't make any sense.
>
> It should return bool instead.

I am not sure if I got the comment right, please correct me if that's
the case. I introduced freezeing_reason_slow_path() explicitly to
return more information than just bool (freezing, not freezing) in
order to be able to differentiate between the causes of freeze (please
note there is another call site of the function in freezeing_reason()
which uses that additional information). This call of the function
here in freezing_slow_path() indeed does not need that additional
info. However, in order to not duplicate identical code that checks
for freezing we can call the freezing_reason_slow_path() and just
return whether it is freezing or not regardless of the actual reason.
That way the freezing_slow_path() functionality is not altered in any
way and we don't introduce code duplication.

> >  }
> >  EXPORT_SYMBOL(freezing_slow_path);
> >
> > --
