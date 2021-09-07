Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA82A402EEA
	for <lists+linux-pm@lfdr.de>; Tue,  7 Sep 2021 21:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346076AbhIGTYV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Sep 2021 15:24:21 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:46970 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346056AbhIGTYR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Sep 2021 15:24:17 -0400
Received: by mail-oi1-f173.google.com with SMTP id w144so214210oie.13;
        Tue, 07 Sep 2021 12:23:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6BJUSy7ZuZKYt9ryvhuAcYMqADTMlcTk8t8PG14IBng=;
        b=eP6G28L09y11NyH9/uCYG/00IkSb0fMlsSZXg3vyHbbVenVT+y6dxef5wVrM98pAe6
         1uSk37OHdbsdPApCrGi6rYu+xjkmhu0735HN9uZUtZhs1zAe5mVqfzkcuyHBVdBxM0pr
         Bkq0LTKYuVKo9A/OSpNOm7kHGE4CdhrVkAD3SYicXxIHcmvWmdIMccebcGfM9gCjx53T
         lGOUAbPh2S/t84rzV0vjd92VktPE3jPxuCV5tOd81YDNcq2wIqD0WOjVBEEIesddZE4V
         FJlyWRjDtXWeNVmXG2vZkN/v8wI7jdWObu5ZdS5O1eanDfGOn0NPm6WpbNmP1FsIuOEl
         dtXQ==
X-Gm-Message-State: AOAM531qmDdtxVTwGKPbLWjm+c+XR5z8wq39T0oAg58tV3mXPmZmMoe3
        ZGZhl+1Urm2N/VbsZuBe2qqMiHdVcsHe2f1f/Y2PDI8K
X-Google-Smtp-Source: ABdhPJwk4TBgNGvld9R9q2flqqzH2YVJpwLNkfZBk8HuP/Q1K3Xl/kA7/xDixPYEi8eNX71pkGsY3CBEQh6GXOINWqs=
X-Received: by 2002:a05:6808:10c1:: with SMTP id s1mr4058235ois.69.1631042590849;
 Tue, 07 Sep 2021 12:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <1631013863-43141-1-git-send-email-psodagud@codeaurora.org>
In-Reply-To: <1631013863-43141-1-git-send-email-psodagud@codeaurora.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Sep 2021 21:22:59 +0200
Message-ID: <CAJZ5v0i1X--QwB1yjZLUCofnx5BQbr_f9d-gNOHSK1m-Bfk8bw@mail.gmail.com>
Subject: Re: [PATCH v5] PM: sleep: core: Avoid setting power.must_resume to false
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

On Tue, Sep 7, 2021 at 1:24 PM Prasad Sodagudi <psodagud@codeaurora.org> wrote:
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
>  V4 -> V5: Fix coding style
>  V3 -> V4: Remove dev->power.usage_count variable check
>  V2 -> V3: Format issues patch posting
>  V1 -> V2: Fixed indentation and commit text to include scenario
>  drivers/base/power/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index d568772..cbea78e 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1642,7 +1642,7 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
>         }
>
>         dev->power.may_skip_resume = true;
> -       dev->power.must_resume = false;
> +       dev->power.must_resume = !dev_pm_test_driver_flags(dev, DPM_FLAG_MAY_SKIP_RESUME);
>
>         dpm_watchdog_set(&wd, dev);
>         device_lock(dev);
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project

Applied as 5.15-rc material, thanks!
