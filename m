Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEA2314ED14
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2020 14:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgAaNQt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jan 2020 08:16:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:59068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728579AbgAaNQt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 Jan 2020 08:16:49 -0500
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B841B214D8;
        Fri, 31 Jan 2020 13:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580476608;
        bh=ggrq9Jgc11j9oBbDNU2WET2SP3MbFbO1y78dajMXLfc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=REGgpnatP7syvTAN13b3NhETyEXsZVzYCcZ9RyVO+h3jGNo2hxi6rsL2y7DhCXW+P
         mIhffXNpcPqw0cDM8/aAidmUwrV74NLYpT/HbvC/aJ/VMjlj3LVZ3L/dPH/2LouKwL
         gi8QvC5LlnYvhbaq/HyIyjLsGtixlWTnrjD3rFrU=
Received: by mail-lj1-f175.google.com with SMTP id v17so7055928ljg.4;
        Fri, 31 Jan 2020 05:16:47 -0800 (PST)
X-Gm-Message-State: APjAAAUTSQoDCZzBRvrHafCY+0Sfn0dJgs/zLicFSuuKVFpoub5zO1nB
        J2dfipeRMA+4KbF1icQWsBGC5/jJLA39OtJQg5I=
X-Google-Smtp-Source: APXvYqyHH1mBNjzJnIDT8ozGRMEfl14lXQUHfdq30KTGdoctW1gTxpv8Cq9HZwZufM6lRyIvRwc5SSMGxFrcr40jDYU=
X-Received: by 2002:a2e:9c85:: with SMTP id x5mr6044390lji.50.1580476605934;
 Fri, 31 Jan 2020 05:16:45 -0800 (PST)
MIME-Version: 1.0
References: <20200127215453.15144-1-lukasz.luba@arm.com> <20200127215453.15144-4-lukasz.luba@arm.com>
In-Reply-To: <20200127215453.15144-4-lukasz.luba@arm.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 31 Jan 2020 14:16:34 +0100
X-Gmail-Original-Message-ID: <CAJKOXPeA=_3zPx6Aq3CAUi7JsXr9AigWGWCTNWo_jkm=oVWe_g@mail.gmail.com>
Message-ID: <CAJKOXPeA=_3zPx6Aq3CAUi7JsXr9AigWGWCTNWo_jkm=oVWe_g@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: exynos_defconfig: Enable Energy Model framework
To:     lukasz.luba@arm.com
Cc:     kgene@kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        Chanwoo Choi <cw00.choi@samsung.com>, robh+dt@kernel.org,
        mark.rutland@arm.com,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, dietmar.eggemann@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 27 Jan 2020 at 22:55, <lukasz.luba@arm.com> wrote:
>
> From: Lukasz Luba <lukasz.luba@arm.com>
>
> Enable the Energy Model (EM) brings possibility to use Energy Aware
> Scheduler (EAS). This compiles the EM but does not enable to run EAS in
> default. The EAS only works with SchedUtil - a CPUFreq governor which
> handles direct requests from the scheduler for the frequency change. Thus,
> to make EAS working in default, the SchedUtil governor should be
> configured as default CPUFreq governor.

Full stop. That's enough of needed explanation of schedutil.

> Although, the EAS might be enabled
> in runtime, when the EM is present for CPUs, the SchedUtil is compiled and
> then set as CPUFreq governor, i.e.:
>
> echo schedutil > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
> echo schedutil > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
>
> To check if EAS is ready to work, the read output from the command below
> should show '1':
> cat /proc/sys/kernel/sched_energy_aware
>
> To disable EAS in runtime simply 'echo 0' to the file above.

Not related to this commit. If you were implemeting here
schedutil/EAS, then it makes sense to post all this. However what's
the point to describe it in every defconfig change?

> Some test results, which stress the scheduler on Odroid-XU3:
> hackbench -l 500 -s 4096
> With mainline code and with this patch set.

Skip the last sentence - duplicated information.

>
> The tests have been made with and without CONFIG_PROVE_LOCKING (PL)
> (which is set to =y in default exynos_defconfig)
>
>                 |               this patch set                  | mainline

The commit will be applied on its own branch so the meaning of "this
patch set" will be lost. Maybe just "before/after"?

>                 |-----------------------------------------------|---------------
>                 | performance   | SchedUtil     | SchedUtil     | performance
>                 | governor      | governor      | governor      | governor
>                 |               | w/o EAS       | w/ EAS        |
> ----------------|---------------|---------------|---------------|---------------
> hackbench w/ PL | 12.7s         | 11.7s         | 12.0s         | 13.0s - 12.2s
> hackbench w/o PL| 9.2s          | 8.1s          | 8.2s          | 9.2s - 8.4s

Why does the performance different before and after this patch?

Mention - lower better (?). Space between number and unit... or better
mention [s] in column title.

And last but not least:
Why this patch is separate from 1/3? I don't get the need of splitting them.

Best regards,
Krzysztof
