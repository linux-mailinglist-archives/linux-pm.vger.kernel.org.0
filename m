Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0FAF2E9E
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 13:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfKGM5d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Nov 2019 07:57:33 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44360 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbfKGM5c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Nov 2019 07:57:32 -0500
Received: by mail-ot1-f68.google.com with SMTP id c19so1873744otr.11;
        Thu, 07 Nov 2019 04:57:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Plpva4j/BO0z5MjnaZiRcJzz+2GsRVLk6P6DLNFaGg=;
        b=YU/K4zDKmFjFdaPowpI/0AitNpryua8YeJZ2kx83/UGtYga1qlAcjmQjYCdfGIKXxL
         DotfTghWJH6DkldU7XOvZn9gy4yyfExw+tDyQ3EW15aIZ6LqPgYe8GnAk7FWBkOie8oZ
         p5w5sMboQaLYJjJSI79IJRR3k6wosuju8vLgbw4qGCQgAg2i3YpkOdLv4hRzspUG0z2r
         H0AAHG9xkgYQbz3g/A0ejOfJEcg/vs1ZhDsuktfBTQA271EItx6rglOH39nKXqLIh1K/
         GoJwOK8E0gRafClTI7WTHc3nRPaa8XShFX2YnpMYfj6jbz0ZUE1BeXoqsEFOt/3lbcZ7
         0bZg==
X-Gm-Message-State: APjAAAXWhFW8Luzw4OtpTzndGRbTMAILTuooN7ZXV65Cl5mzfSO8Vg/7
        aPetyESM/M0UywX2r0OtZ7GuQQTf8kGLMVFb3Hk=
X-Google-Smtp-Source: APXvYqxkjW7O5aC2WoH+qPdTkOoNeRrRuRpFiLLCKYxFzP5R3I7ucuE6UqDfbBKskXSaOtYWVHKyqejoSohg6rYvEQo=
X-Received: by 2002:a9d:5a0f:: with SMTP id v15mr3039929oth.266.1573131450699;
 Thu, 07 Nov 2019 04:57:30 -0800 (PST)
MIME-Version: 1.0
References: <CGME20191107035701epcas1p237d69dd23f28fde1f52bfc4def529e92@epcas1p2.samsung.com>
 <dcdea33b-472f-c3e5-ed9e-3fae16591f46@samsung.com>
In-Reply-To: <dcdea33b-472f-c3e5-ed9e-3fae16591f46@samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Nov 2019 13:57:17 +0100
Message-ID: <CAJZ5v0g0zN8bATL6LsVJDq_5tD_m+Uc4LYmeY-8QJHQWMvTRyw@mail.gmail.com>
Subject: Re: [GIT PULL] devfreq next for v5.5
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Chanwoo Choi (samsung.com)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 7, 2019 at 4:57 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> Dear Rafael,
>
> This is devfreq-next pull request for v5.5-rc1. I add detailed description of
> this pull request on the following tag. Please pull devfreq with following updates.
> - tag name : devfreq-next-for-5.5
>
>
> When pull the this pull request to linux-pm, auto-merging will happen.
> Because of the change of the devfreq git information on patch[1] and
> patch[2] add the additional information of exynos_ppmu.h.
> But, when I tested it, the auto merging was completed without problem.
> If the problem happen, I'll resend the pull request rebased on
> the top of 'linux-next' branch instead of Linux 5.4-rc6.
>
> [1] MAINTAINERS: Update myself as maintainer for DEVFREQ subsystem support
> - https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=c389ec67b7f8e028438643c4af4bbff550192187
>
> [2] include: dt-bindings: add Performance Monitoring Unit for Exynos
> - https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?h=devfreq-next&id=fcbd8037f7df694aa7bfb7ce82c0c7f5e53e7b7b
>
> Best Regards,
> Chanwoo Choi
>
>
> The following changes since commit a99d8080aaf358d5d23581244e5da23b35e340b9:
>
>   Linux 5.4-rc6 (2019-11-03 14:07:26 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-5.5
>
> for you to fetch changes up to fee22854c0273569836de2039d9c432ea4df2cfc:
>
>   PM / devfreq: tegra30: Tune up MCCPU boost-down coefficient (2019-11-06 12:04:01 +0900)
>
> ----------------------------------------------------------------
> Update devfreq for 5.5
>
> Detailed description for this pull request:
> 1. Update devfreq core
> - Check NULL governor in available_governors_show sysfs in order to prevent
>   showing the wrong governor information.
> - Fix the race condition between devfreq_update_status() and trans_stat_show()
> - Add new 'interrupt-driven' flag for devfreq goveror. Each devfreq driver can
>   add the their own governor (NIVIDIA Tegra30 ACTMON governor) which is interrupt-driven
>   governor. It needs to use the following sysfs interface to get the new polling
>   interval in order to change the NVIDIA Tegra30 hardware's polling interval.
>   : /sys/class/devfreq/devfreqX/polling_interval
>   So, if 'interrupt-driven' flag of devfreq governor is 1, the devfreq governor
>   is able to use the 'polling_interval' sysfs interface to get the new polling
>   interval value. But, the devfreq core doesn't schedule out the polling work
>   for this governor like NVIDIA Tegra30 ACTMON governor.
>
> 2. Update devfreq driver
> - For exynos-bus.c, remove unused property from dt-binding documentation
> - For tegra30-devfreq.c, update the internal behavior like fixing the overflow
>   integer issue and clean-up code.
>
> 3. Update devfreq-event driver
> - For exynos-ppmu.c, add exynos_ppmu.h dt-binding file for 'event-data-type' filed.
>   and update dt-binging documentation. Also,  Fix minor coding style.

Pulled, and thanks a lot for the nice description of the contents,
much appreciated!

Also it has merged for me cleanly.

Thanks!
