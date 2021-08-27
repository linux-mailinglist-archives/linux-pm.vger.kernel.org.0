Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBEA83F98F2
	for <lists+linux-pm@lfdr.de>; Fri, 27 Aug 2021 14:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245084AbhH0MU6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Aug 2021 08:20:58 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:42702 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbhH0MU6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Aug 2021 08:20:58 -0400
Received: by mail-ot1-f42.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so7569261otk.9;
        Fri, 27 Aug 2021 05:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B3od3vyvcuge7BK5/FxXd+T+mQcTApP8RCdRnptyqb0=;
        b=mVWaBICFn4TiL0Q5a95VQ04nqixa92ObxGnP/BVLPP/2mqHL0ucDR8FWeSDAVA/sOL
         w81UEXcM4LZCme5BBdHPh/NllXGAj+pcFCvzhO6fkl+fY1V5Prbre+3+pzv12DkS0Lgv
         bsW8ezCi+igf1a+gPpTowgkpCovWRw0b9mSlkio1OpZyUVPPNAzNhxmP7cYP1+tqxE6f
         LIHxYC2ajNHWVDctW4JUPkWV5OrtyfC9AVzBh6IvQHCdGcKA9bgEsL1iy/nqNaDwdUMc
         1L4DyuHQiuOisog7ePUKh+G6dPCZBoOFLXSOyMtToZ6wBjYXOYkNa+ZdhZZVWpekIOC+
         a2FQ==
X-Gm-Message-State: AOAM533pJb/kA4baam4MZ3I2ex19FUpPevuPA53oVFpcZrDoXgBlEBDa
        +Wm7GrGBmnmmDLB+zUb50sOcGQhORaITizvy0NzMyf/DV1rOpg==
X-Google-Smtp-Source: ABdhPJx0Z9rGHhnrH+t026SA3axXHuRKaF5tAuDWKrLQrR1VycWqPfvXzgLcuuV89QuqOoocZQgEJvCOE9UJNQ57IYQ=
X-Received: by 2002:a9d:7115:: with SMTP id n21mr2067521otj.321.1630066809238;
 Fri, 27 Aug 2021 05:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <1629732470-155444-1-git-send-email-psodagud@codeaurora.org>
In-Reply-To: <1629732470-155444-1-git-send-email-psodagud@codeaurora.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 27 Aug 2021 14:19:58 +0200
Message-ID: <CAJZ5v0hAuZmaB6j4qA7P43J4TshBrYa8UsX3KtH7hkxWZPU2wA@mail.gmail.com>
Subject: Re: [PATCH v4] PM: sleep: core: Avoid setting power.must_resume to false
To:     Prasad Sodagudi <psodagud@codeaurora.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 23, 2021 at 5:28 PM Prasad Sodagudi <psodagud@codeaurora.org> wrote:
>
> There are variables(power.may_skip_resume and dev->power.must_resume)
> and DPM_FLAG_MAY_SKIP_RESUME flags to control the resume of devices after
> a system wide suspend transition.
>
> Setting the DPM_FLAG_MAY_SKIP_RESUME flag means that the driver allows
> its "noirq" and "early" resume callbacks to be skipped if the device
> can be left in suspend after a system-wide transition into the working
> state. PM core determines that the driver's "noirq" and "early" resume
> callbacks should be skipped or not with dev_pm_skip_resume() function by
> checking power.may_skip_resume variable.
>
> power.must_resume variable is getting set to false in __device_suspend()
> function without checking device's DPM_FLAG_MAY_SKIP_RESUME settings.
> In problematic scenario, where all the devices in the suspend_late
> stage are successful and some device can fail to suspend in
> suspend_noirq phase. So some devices successfully suspended in suspend_late
> stage are not getting chance to execute __device_suspend_noirq()
> to set dev->power.must_resume variable to true and not getting
> resumed in early_resume phase.
>
> Add a check for device's DPM_FLAG_MAY_SKIP_RESUME flag before
> setting power.must_resume variable in __device_suspend function.
>
> Fixes: 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in the resume phase")
> Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
> ---
>  V3 -> V4: Remove dev->power.usage_count variable check
>  V2 -> V3: Format issues patch posting
>  V1 -> V2: Fixed indentation and commit text to include scenario
>  drivers/base/power/main.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index d568772..50e8ea3 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1642,7 +1642,10 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
>         }
>
>         dev->power.may_skip_resume = true;
> -       dev->power.must_resume = false;
> +       if (dev_pm_test_driver_flags(dev, DPM_FLAG_MAY_SKIP_RESUME))
> +               dev->power.must_resume = false;
> +       else
> +               dev->power.must_resume = true;

Why don't you write it as

dev->power.must_resume = !dev_pm_test_driver_flags(dev,
DPM_FLAG_MAY_SKIP_RESUME);

>
>         dpm_watchdog_set(&wd, dev);
>         device_lock(dev);
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
