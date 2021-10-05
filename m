Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF3D422E21
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 18:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236580AbhJEQkg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 12:40:36 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:38862 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbhJEQk3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Oct 2021 12:40:29 -0400
Received: by mail-ot1-f50.google.com with SMTP id c6-20020a9d2786000000b005471981d559so26572610otb.5;
        Tue, 05 Oct 2021 09:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d+ZkMNucCSAmjhQjkCXWJrnM0fx9GaygQ1/j2RoY2S0=;
        b=v6ACl47hct2JGpFhAdN2bVlR2FZsgjtec2x1udSQEe86e836MBihVeCinCPuEr1YWU
         H2veN8WnIKrYIW6PmksiJdxXm2cuinB9chjpGQ/a9x8G8+ETxMfM9bRUtOXRCib1FfJ3
         LOeXebLPPHLn9a7Jn9VPszOY2VPUM0wndzxs9LS0deG+EXH0HnWQmpNH2QuyOwTkLGCw
         qggl6MBv2DkyFoO0R0UxmKJW3JaEK6Tof+1Sp63dipPqkho3zIeV5bmvFP+obFqRU+5S
         5ptic+U6XmebZ8gmfhSxCrUN6igpYNeDqo7w1Kyp9FUcG7AEY/FF+cTqo5KG+tSyvTJA
         +5Fw==
X-Gm-Message-State: AOAM532HhZL6nfIxaDYw4OYJbxBCY2Wc/eQ/VXEkDHfeKh0OxpaqEmtI
        bYjfHexLO0q8z31WfCLdfQVA+gqn/BOgqtN5If8=
X-Google-Smtp-Source: ABdhPJx42OBRJvItVXs9RbS5a0MaddF8SWGRwEYQW92RQAVOyXQnM7auxNhaObBDKIgSMEGbAdELeI1h4XHf+s6V2jQ=
X-Received: by 2002:a05:6830:165a:: with SMTP id h26mr15693238otr.301.1633451918405;
 Tue, 05 Oct 2021 09:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211005155427.1591196-1-john@metanate.com>
In-Reply-To: <20211005155427.1591196-1-john@metanate.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Oct 2021 18:38:27 +0200
Message-ID: <CAJZ5v0gPwUQzGBa2VDeC3xAF9zJVm486BC0eue10-urJ8Xz+iw@mail.gmail.com>
Subject: Re: [RFC PATCH RT] PM: runtime: avoid retry loops on RT
To:     John Keeping <john@metanate.com>
Cc:     linux-rt-users@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 5, 2021 at 6:14 PM John Keeping <john@metanate.com> wrote:
>
> With PREEMPT_RT spin_unlock() is identical to spin_unlock_irq() so there
> is no reason to have a special case using the former.  Furthermore,
> spin_unlock() enables preemption meaning that a task in RESUMING or
> SUSPENDING state may be preempted by a higher priority task running
> pm_runtime_get_sync() leading to a livelock.
>
> Use the non-irq_safe path for all waiting so that the waiting task will
> block.
>
> Note that this changes only the waiting behaviour of irq_safe, other
> uses are left unchanged so that the parent device always remains active
> in the same way as !RT.
>
> Signed-off-by: John Keeping <john@metanate.com>

So basically, the idea is that the irq_safe flag should have no effect
when CONFIG_PREEMPT_RT is set, right?

Wouldn't it be cleaner to make it not present at all in that case?

> ---
>  drivers/base/power/runtime.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 96972d5f6ef3..5e0d349fab4e 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -347,8 +347,9 @@ static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
>  {
>         int retval = 0, idx;
>         bool use_links = dev->power.links_count > 0;
> +       bool irq_safe = dev->power.irq_safe && !IS_ENABLED(CONFIG_PREEMPT_RT);
>
> -       if (dev->power.irq_safe) {
> +       if (irq_safe) {
>                 spin_unlock(&dev->power.lock);
>         } else {
>                 spin_unlock_irq(&dev->power.lock);
> @@ -376,7 +377,7 @@ static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
>         if (cb)
>                 retval = cb(dev);
>
> -       if (dev->power.irq_safe) {
> +       if (irq_safe) {
>                 spin_lock(&dev->power.lock);
>         } else {
>                 /*
> @@ -596,7 +597,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
>                         goto out;
>                 }
>
> -               if (dev->power.irq_safe) {
> +               if (dev->power.irq_safe && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
>                         spin_unlock(&dev->power.lock);
>
>                         cpu_relax();
> @@ -777,7 +778,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
>                         goto out;
>                 }
>
> -               if (dev->power.irq_safe) {
> +               if (dev->power.irq_safe && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
>                         spin_unlock(&dev->power.lock);
>
>                         cpu_relax();
> --
> 2.33.0
>
