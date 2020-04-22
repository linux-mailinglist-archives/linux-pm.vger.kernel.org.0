Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5351B3ABC
	for <lists+linux-pm@lfdr.de>; Wed, 22 Apr 2020 11:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgDVJFR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Apr 2020 05:05:17 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42612 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgDVJFQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2020 05:05:16 -0400
Received: by mail-ot1-f67.google.com with SMTP id m18so1413015otq.9;
        Wed, 22 Apr 2020 02:05:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B5vud3pf8Y69anGfFBmw7nwGjrVBjnFCZosReDIIX64=;
        b=HhZ9zwwCZJ0VSex3qIBfOASl5dC63rr1q+leZv0RRI6JjRFB0UkOdI0zezTffNQOdO
         ajNBkS5UdAob3u1vxnrVDd14SUQGGVq7914MyD+I2cwHBJzjQiGVAkqOIBtbsfMKhY5Y
         pm1jxidgkkZ7TlDDb9e598ogee9+NDMBo/TovfLAVsVtMVbh5kJUbS4bI+USvbZtufJp
         sqYbgHCPoaUfn/2/eJEAnn0nLbLFqCHqSNXb/YuzrX9dEWlEplP99whW1xyjwWd9F6Rs
         TIYtX/yCWhwET+wepZTi+3dSo+DO9JG/gF3tNrbN1Ljk3+gjLMDj6BQNm9Vei2q3+g2F
         orJw==
X-Gm-Message-State: AGi0PubbDlI+1GGjozwCpgZbHNThy2JKDMlv2AsW2aDcYxOI7Z5lTr6r
        akVhUqsmc0l8t2kVG6/fmJOIos9nf/iay1Xk/Uc=
X-Google-Smtp-Source: APiQypJUxZX+VI/95qmujC40IKjXMF96E9hSjeeyFG1Ok5dU9Nkee09qE9cnSpVt/T0Km+isZ++7cDGWO/GG7Rxxlh8=
X-Received: by 2002:a05:6830:18d0:: with SMTP id v16mr16109926ote.118.1587546315616;
 Wed, 22 Apr 2020 02:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200422051529.30757-1-zhang.lyra@gmail.com>
In-Reply-To: <20200422051529.30757-1-zhang.lyra@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Apr 2020 11:05:04 +0200
Message-ID: <CAJZ5v0ikL3avFomZVqtBhfEjeauN-5ZUm9kZwzG=Vo+Ks0AiyA@mail.gmail.com>
Subject: Re: [PATCH] PM: sleep: call devfreq_suspend/resume and
 cpufreq_suspend/resume in pairs.
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Vincent Wang <vincent.wang@unisoc.com>,
        Samer Xie <samer.xie@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 22, 2020 at 7:15 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> From: Vincent Wang <vincent.wang@unisoc.com>
>
> If dpm_prepare() fails in dpm_suspend_start(), dpm_suspend() can't be
> called.

That's correct.

> And then, devfreq_suspend() and cpufreq_suspend() will not be
> called in the suspend flow.

Right.

> But in the resiume flow, devfreq_resume() and cpufreq_resume() will
> be called.

Right, and they are expected to cope with the situation.

> This patch will ensure that devfreq_suspend/devfreq_resume and
> cpufreq_suspend/cpufreq_resume are called in pairs.

So why is it better to do this than to make devfreq_resume() meet the
expectations?

> Signed-off-by: Vincent Wang <vincent.wang@unisoc.com>
> Signed-off-by: Samer Xie <samer.xie@unisoc.com>
> Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
> ---
>  drivers/base/power/main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index fdd508a78ffd..eb3d987d43e0 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1866,9 +1866,6 @@ int dpm_suspend(pm_message_t state)
>         trace_suspend_resume(TPS("dpm_suspend"), state.event, true);
>         might_sleep();
>
> -       devfreq_suspend();
> -       cpufreq_suspend();
> -
>         mutex_lock(&dpm_list_mtx);
>         pm_transition = state;
>         async_error = 0;
> @@ -1988,6 +1985,9 @@ int dpm_prepare(pm_message_t state)
>         trace_suspend_resume(TPS("dpm_prepare"), state.event, true);
>         might_sleep();
>
> +       devfreq_suspend();
> +       cpufreq_suspend();
> +
>         /*
>          * Give a chance for the known devices to complete their probes, before
>          * disable probing of devices. This sync point is important at least
> --
> 2.20.1
>
