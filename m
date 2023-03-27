Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E33A6CA9B4
	for <lists+linux-pm@lfdr.de>; Mon, 27 Mar 2023 17:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjC0P5S convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 27 Mar 2023 11:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjC0P5P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Mar 2023 11:57:15 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7452D3AB8
        for <linux-pm@vger.kernel.org>; Mon, 27 Mar 2023 08:57:09 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id t10so38086013edd.12
        for <linux-pm@vger.kernel.org>; Mon, 27 Mar 2023 08:57:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679932628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+vSMUm0wxWKNA9lr25aYdQzLS1yIcwSkXtSPFSh1PU=;
        b=R0eF+SS+IEH3bKby7hqZiKrDWlodIKgGE2IzCaFW2B0PnL/y8L4txmhb4iXWnOEokZ
         JK7O61T02i9XH0TPQCt9sX35awqLe+e4EoVk+npIKd4BgByijfNFRGuk7HfWOM6OOveg
         3lKcgYDb4JFs9H2sOcTGt8VHRP3f+b/zcKjQ0NqB8435aG1AUeEDn4HqvCaBtFBp4lop
         m9JquGrJEC3Bh71qC0JYP16PWIpKFjIqctN/JzkWNZh9oef++bfAM1RbHjiUBbq//abW
         MhJx3PSTPsAfuVav5VI6eCHRVszjlu+nYa/WyAdbPkEXlEnmiEuRMBJZCSnp0rgUB0+2
         1MrQ==
X-Gm-Message-State: AO0yUKUdvc37ObnhgQ2cgCRGfWQj6WfuRnRxVEDDzXVUGVhlqvXmAso+
        stiF3xwkFQPZryUZozv9ng7GsjBD0mfU2o0vcLw=
X-Google-Smtp-Source: AK7set+IAV4XjJch5jmo9HzhIyQ+MrvBBcNxmnOlHCnaiKT2uoK2gLBgE8BwIUwnV00LHr/1x82NH0qGM19jJxf5Q7U=
X-Received: by 2002:a17:906:ca41:b0:939:a51a:dc30 with SMTP id
 jx1-20020a170906ca4100b00939a51adc30mr9942258ejb.2.1679932627863; Mon, 27 Mar
 2023 08:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230227121318.2116638-1-md@chromium.org> <20230227121318.2116638-2-md@chromium.org>
In-Reply-To: <20230227121318.2116638-2-md@chromium.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Mar 2023 17:56:56 +0200
Message-ID: <CAJZ5v0ik2vJ9t24nj0dpUfekvzwacLVkbGpViaBdADrLf6-cvQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kernel/freezer: Add routine to read task's freezing reason
To:     Michal Dubiel <md@chromium.org>
Cc:     linux-pm@vger.kernel.org, rafael@kernel.org, pavel@ucw.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 27, 2023 at 1:14 PM Michal Dubiel <md@chromium.org> wrote:
>
> There are few reasons why a task is freezing. It can be due to system
> suspend, it can be due to explicit user request, etc.

Actually, there are two of them, either it is cgroup freezing, or it
is freezing on system suspend AFAICS.

> For most cases, the actual reason is not important, but there are some that
> it is useful to distinguish between what actually caused the task to
> freeze.
>
> One example is when user requests freezing of tasks belonging to a certain
> cgroup. If for any reason, system goes suspend and resume when the cgroup
> is frozen, the already frozen tasks should not be thawed but remain frozen
> to ensure the suspend/resume cycle transparency. The system should not warn
> about skipping thawing of such processes as it is normal situation.
>
> The proposed function allows to obtain information about the freezing
> reason and let the calling code decide what to do accordingly.

I honestly don't think that this new function is necessary.

Moreover, it would be better to combine this patch with the other one
in the series.

> Signed-off-by: Michal Dubiel <md@chromium.org>
> ---
>  include/linux/freezer.h | 17 +++++++++++++++
>  kernel/freezer.c        | 23 ++++++++++++++------
>  2 files changed, 33 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/freezer.h b/include/linux/freezer.h
> index b303472255b..b936a349e0d 100644
> --- a/include/linux/freezer.h
> +++ b/include/linux/freezer.h
> @@ -28,6 +28,23 @@ extern bool frozen(struct task_struct *p);
>
>  extern bool freezing_slow_path(struct task_struct *p);
>
> +extern enum freezing_reason freezing_reason_slow_path(struct task_struct *p);
> +
> +enum freezing_reason {
> +       FREEZING_NONE     = 0,
> +       FREEZING_CGROUP   = (1 << 0),
> +       FREEZING_PM       = (1 << 1),
> +       FREEZING_PM_NOSIG = (1 << 2),
> +};
> +
> +static inline enum freezing_reason freezing_reason(struct task_struct *p)
> +{
> +       if (static_branch_unlikely(&freezer_active))
> +               return freezing_reason_slow_path(p);
> +
> +       return FREEZING_NONE;
> +}
> +
>  /*
>   * Check if there is a request to freeze a process
>   */
> diff --git a/kernel/freezer.c b/kernel/freezer.c
> index 4fad0e6fca6..2536054db60 100644
> --- a/kernel/freezer.c
> +++ b/kernel/freezer.c
> @@ -26,6 +26,21 @@ bool pm_nosig_freezing;
>  /* protects freezing and frozen transitions */
>  static DEFINE_SPINLOCK(freezer_lock);
>
> +enum freezing_reason freezing_reason_slow_path(struct task_struct *p)
> +{
> +       if (pm_nosig_freezing)
> +               return FREEZING_PM_NOSIG;
> +
> +       if (cgroup_freezing(p))
> +               return FREEZING_CGROUP;
> +
> +       if (pm_freezing && !(p->flags & PF_KTHREAD))
> +               return FREEZING_PM;
> +
> +       return FREEZING_NONE;
> +}
> +EXPORT_SYMBOL(freezing_reason_slow_path);

Why do you need to export this and why is it not EXPORT_SYMBOL_GPL()?

> +
>  /**
>   * freezing_slow_path - slow path for testing whether a task needs to be frozen
>   * @p: task to be tested
> @@ -43,13 +58,7 @@ bool freezing_slow_path(struct task_struct *p)
>         if (test_tsk_thread_flag(p, TIF_MEMDIE))
>                 return false;
>
> -       if (pm_nosig_freezing || cgroup_freezing(p))
> -               return true;
> -
> -       if (pm_freezing && !(p->flags & PF_KTHREAD))
> -               return true;
> -
> -       return false;
> +       return (bool)freezing_reason_slow_path(p);

This is the only call site of this function, so the explicit
conversion to bool like this doesn't make any sense.

It should return bool instead.

>  }
>  EXPORT_SYMBOL(freezing_slow_path);
>
> --
