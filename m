Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41E455D5BA
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2019 19:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfGBRyO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Jul 2019 13:54:14 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44307 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGBRyN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jul 2019 13:54:13 -0400
Received: by mail-ot1-f67.google.com with SMTP id b7so18051284otl.11;
        Tue, 02 Jul 2019 10:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+oP0RH9kwH9LwfnhKPKaz5YexisejvCGK50RlpX1ljc=;
        b=sljMwGXSqp3kbMx6t6jLO2w18e/4j+Q942qsy7RkSXJPiMIvAE5TczY3I+aQy5pmbe
         +9cTUFzvMclGSd7quVdHaKaQGbGeKya/tkuxU7/1ReukSTVs7l5ZwogVOffXRLsiiZrF
         C6EcZoqr43HoTaRKh1b6qWehszk3UGWyrCsVeHZY2wZlL2ZKu5frpTCWgOJooUrUrtcp
         Ej/pngDWNCmxZ7E2zLwC+1/nELvW+skk1ZGuIG5va8k1lgwefoB/Y00GS6iSaOP11r+o
         XnmbIV51EKNEssXPKGTy44n6zHE441VTYTVUa/4ss/dELFjtOjDx/OXPkMx9pWIxSXyf
         nqiQ==
X-Gm-Message-State: APjAAAX645URg+BZVFx/xwUy02bjlNSuPfUkyPMvg0BoSo19qF2zWURf
        RG/yf1eCSzF8o3qGTKBDfb9CAIlFo2j8HSAcb/6/PA==
X-Google-Smtp-Source: APXvYqzJUxyIrdJenoWjzxhItkZ4yvQWo+kbEG93MBNXTEnn+B7KldNdKnGkUL7c1jzrrHM4FV8smCzg4LfaCvUi+dQ=
X-Received: by 2002:a9d:6b96:: with SMTP id b22mr10392785otq.262.1562090052447;
 Tue, 02 Jul 2019 10:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190702163715.12649-1-smuchun@gmail.com>
In-Reply-To: <20190702163715.12649-1-smuchun@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 2 Jul 2019 19:54:01 +0200
Message-ID: <CAJZ5v0jzVG5X8idR7Fy8g6=UPMpZ7eK6A_Uhqrer1aJFY1hX1w@mail.gmail.com>
Subject: Re: [PATCH v2] PM: Move disabling/enabling runtime PM to
 suspend/resume noirq
To:     Muchun Song <smuchun@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 2, 2019 at 6:37 PM Muchun Song <smuchun@gmail.com> wrote:
>
> Currently, the PM core disables runtime PM for all devices right after
> executing subsystem/driver .suspend_late() callbacks for them and
> re-enables it right before executing subsystem/driver .resume_early()
> callbacks for them. This may lead to problems when there are two devices
> such that the irq handler thread function executed for one of them
> depends on runtime PM working for the other. E.g. There are two devices,
> one is i2c slave device depends on another device which can be the i2c
> adapter device. The slave device can generate system wakeup signals and
> is enabled to wake up the system(via call enable_irq_wake()). So, the irq
> of slave device is enabled. If a wakeup signal generate after executing
> subsystem/driver .suspend_late() callbacks. Then, the irq handler thread
> function will be called(The irq is requested via request_threaded_irq())
> and the slave device reads data via i2c adapter device(via i2c_transfer()).
> In that case, it may be failed to read data because of the runtime PM
> disabled.
>
> It is also analogously for resume. If a wakeup signal generate when the
> system is in the sleep state. The irq handler thread function may be
> called before executing subsystem/driver .resume_early(). In that case,
> it also may be failed to read data because of the runtime PM disabled.
>
> To make those issues go away, make the PM core disable runtime PM for
> devices right before executing subsystem/driver .suspend_noirq() callbacks
> for them and enable runtime PM for them right after executing subsystem/
> driver .resume_noirq() callbacks for them.
>
> Signed-off-by: Muchun Song <smuchun@gmail.com>

This has been discussed for a number of times, documented and no, I'm
not going to apply this patch.

PM-runtime cannot be relied on during the "noirq" stages of suspend
and resume, which is why it is disabled by the core in the "late" and
"early" stages, respectively.

> ---
>
> Change in v2:
>        Update subject from:
>            "PM: Move disabling/enabling runtime PM to noirq suspend/early resume"
>        to:
>            "PM: Move disabling/enabling runtime PM to suspend/resume noirq"
>
>  Documentation/power/runtime_pm.txt | 4 ++--
>  drivers/base/power/main.c          | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/runtime_pm.txt
> index 937e33c46211..8cca4df3adc4 100644
> --- a/Documentation/power/runtime_pm.txt
> +++ b/Documentation/power/runtime_pm.txt
> @@ -691,11 +691,11 @@ out the following operations:
>      pm_runtime_barrier() is called for every device right before executing the
>      subsystem-level .suspend() callback for it.  In addition to that the PM core
>      calls  __pm_runtime_disable() with 'false' as the second argument for every
> -    device right before executing the subsystem-level .suspend_late() callback
> +    device right before executing the subsystem-level .suspend_noirq() callback
>      for it.
>
>    * During system resume pm_runtime_enable() and pm_runtime_put() are called for
> -    every device right after executing the subsystem-level .resume_early()
> +    every device right after executing the subsystem-level .resume_noirq()
>      callback and right after executing the subsystem-level .complete() callback
>      for it, respectively.
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index dcfc0a36c8f7..ad0282d637ae 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -693,6 +693,7 @@ static int device_resume_noirq(struct device *dev, pm_message_t state, bool asyn
>         }
>
>  Out:
> +       pm_runtime_enable(dev);
>         complete_all(&dev->power.completion);
>         TRACE_RESUME(error);
>         return error;
> @@ -860,7 +861,6 @@ static int device_resume_early(struct device *dev, pm_message_t state, bool asyn
>   Out:
>         TRACE_RESUME(error);
>
> -       pm_runtime_enable(dev);
>         complete_all(&dev->power.completion);
>         return error;
>  }
> @@ -1299,6 +1299,8 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
>         TRACE_DEVICE(dev);
>         TRACE_SUSPEND(0);
>
> +       __pm_runtime_disable(dev, false);
> +
>         dpm_wait_for_subordinate(dev, async);
>
>         if (async_error)
> @@ -1508,8 +1510,6 @@ static int __device_suspend_late(struct device *dev, pm_message_t state, bool as
>         TRACE_DEVICE(dev);
>         TRACE_SUSPEND(0);
>
> -       __pm_runtime_disable(dev, false);
> -
>         dpm_wait_for_subordinate(dev, async);
>
>         if (async_error)
> --
> 2.17.1
>
