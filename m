Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AC250927F
	for <lists+linux-pm@lfdr.de>; Thu, 21 Apr 2022 00:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381829AbiDTWLq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Apr 2022 18:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358846AbiDTWLo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Apr 2022 18:11:44 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D841902E
        for <linux-pm@vger.kernel.org>; Wed, 20 Apr 2022 15:08:57 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mm4-20020a17090b358400b001cb93d8b137so6095186pjb.2
        for <linux-pm@vger.kernel.org>; Wed, 20 Apr 2022 15:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=xgdGh8GWNlsUqnxmBsvBbR7QQ9nwAJN46n7/C5nDfAM=;
        b=MDt7q9ZmbDPa+EfzsSVeUf7uYy2X8cx1P7d3hQa/zvlvaCQ/PAtpKb701m2ZfRC4T0
         IR4+hRj5YpIhXXg5jNOXXGgoA2sczDOzq6Z8W+kZpwoURXulXNt9XdHV5yYbasNcK91h
         BoBjkPCDuA4dKEUSIOgJ1BOqiRr/PI3TxAsAJaUG0fcRgagEQnCV0t1J8M+wm+qkMNVB
         hc4AZ5rg1j6wFZziMDo7tkIj5+F2GgU9pzyWkwsdITKtwRJ25ErQBO4VnS3+R4WWk1QT
         cZNcVZwt3iXM2tzKT71WaWGDwji3EJphotPO2r/O3wAcC6nK39y3Dj5N27P/IR9YZK2K
         F5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=xgdGh8GWNlsUqnxmBsvBbR7QQ9nwAJN46n7/C5nDfAM=;
        b=GgJhHDZkMXAg/9HTsGK4MQM05WvIT797y9WHJBNlIKvKpq0QbyeXOXiHh4P/Gsgzly
         +T88l3OXpb4fX8RwJvbzPa2dFBHt/SBS9N6gb+FjZWxiDwhrG5sBmL3py8gTzYIM4sdD
         tQjMdec52P5VSGkNWZtT7tB2Rk8YORptHFJNqYC9EQlXNixfeE6omADYbsZADkO0oKfF
         i6M/yAi6TkyGuXWPOczb8vDcsC6H5fNnkIx/BXeZpiuTp5Ot2g89fok9+OCLWvvm7II9
         FnS90b6afF7Onh6hhxQ/uz1mXXFiM22E5fOrESEiwjQWa3SbPF7qifYkRfs+pQ2+tVT+
         jgqA==
X-Gm-Message-State: AOAM530xsf5Waw4GJ5g21V0IG2dYzNkn5k+1WyVlc+d+tmgeIq3GNEZ4
        vWfM8dZLVnCsg4AATcUh1oAEAw==
X-Google-Smtp-Source: ABdhPJy3hUG+hjcb1HSjXKwZN/alMVLzz45EZ9LAfspsNEq3Z/ylx/RjZVSN6rePOh2hIJhSuOAS7A==
X-Received: by 2002:a17:902:da91:b0:158:d635:370d with SMTP id j17-20020a170902da9100b00158d635370dmr22182423plx.89.1650492536648;
        Wed, 20 Apr 2022 15:08:56 -0700 (PDT)
Received: from DougS18 (s173-180-45-4.bc.hsia.telus.net. [173.180.45.4])
        by smtp.gmail.com with ESMTPSA id v14-20020a17090a6b0e00b001d2bff34228sm178407pjj.9.2022.04.20.15.08.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Apr 2022 15:08:55 -0700 (PDT)
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc:     "'the arch/x86 maintainers'" <x86@kernel.org>,
        "'Rafael J. Wysocki'" <rafael@kernel.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Eric Dumazet'" <edumazet@google.com>,
        "'Paul E. McKenney'" <paulmck@kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <20220415133356.179706384@linutronix.de> <005001d85413$75e5dce0$61b196a0$@telus.net> <CAJZ5v0jf-NGa4-xaNaxehkLGPVqwhZrUhLXw2cJ1avtjgT5yPA@mail.gmail.com> <87bkwwvkwa.ffs@tglx>
In-Reply-To: <87bkwwvkwa.ffs@tglx>
Subject: RE: [patch 00/10] x86/cpu: Consolidate APERF/MPERF code
Date:   Wed, 20 Apr 2022 15:08:56 -0700
Message-ID: <005501d85503$3b00ca40$b1025ec0$@telus.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQGAX/VhRXMrLxWmZ/QgyAMJbOz0yQJd+9EOAiXqHpwBQQcMx617Gtuw
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Thomas, Rafael,

Thank you for your replies.

On 2022.04.19 14:11 Thomas Gleixner wrote:
> On Tue, Apr 19 2022 at 20:49, Rafael J. Wysocki wrote:
>> On Tue, Apr 19, 2022 at 7:32 PM Doug Smythies <dsmythies@telus.net> wrote:
>>> For intel_pstate (active), both HWP enabled or disabled, the behaviour
>>> of scaling_cur_freq is inconsistent with prior to this patch set and other
>>> scaling driver governor combinations.
>>>
>>> Note there is no issue with " grep MHz /proc/cpuinfo" for any
>>> combination.
>>>
>>> Examples:
>>>
>>> No-HWP:
>>>
>>> active/powersave:
>>> doug@s19:~/freq-scalers/trace$ grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq
>>> /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:2300418
>>> /sys/devices/system/cpu/cpu10/cpufreq/scaling_cur_freq:0
>>> /sys/devices/system/cpu/cpu11/cpufreq/scaling_cur_freq:0
>>> /sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq:0
>>> /sys/devices/system/cpu/cpu2/cpufreq/scaling_cur_freq:0
>>> /sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq:0
>>> /sys/devices/system/cpu/cpu4/cpufreq/scaling_cur_freq:0
>>> /sys/devices/system/cpu/cpu5/cpufreq/scaling_cur_freq:0
>>> /sys/devices/system/cpu/cpu6/cpufreq/scaling_cur_freq:0
>>> /sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq:2300006
>>> /sys/devices/system/cpu/cpu8/cpufreq/scaling_cur_freq:2300005
>>> /sys/devices/system/cpu/cpu9/cpufreq/scaling_cur_freq:0
>>
>> That's because after the changes in this series scaling_cur_freq
>> returns 0 if the given CPU is idle.
>
> Which is sensible IMO as there is really no point in waking an idle CPU
> just to read those MSRs, then wait 20ms wake it up again to read those
> MSRs again.

I totally agree.
It is the inconsistency for what is displayed as a function of driver/governor
that is my concern.

>
>> I guess it could return the last known result, but that wouldn't be
>> more meaningful.
>
> Right.

How about something like this, which I realize might break something else,
but just to demonstrate:

doug@s19:~/kernel/linux$ git diff
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 80f535cc8a75..a161e75794cd 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -710,7 +710,7 @@ static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
        else if (cpufreq_driver->setpolicy && cpufreq_driver->get)
                ret = sprintf(buf, "%u\n", cpufreq_driver->get(policy->cpu));
        else
-               ret = sprintf(buf, "%u\n", policy->cur);
+               ret = sprintf(buf, "%u\n", freq);
        return ret;
 }

Note: I left the other 0 return condition, because I do not know what uses it.

Which gives:

acpi-cpufreq/schedutil
doug@s19:~/kernel/linux$ grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu10/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu11/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu2/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu4/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu5/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu6/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu8/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu9/cpufreq/scaling_cur_freq:4100723

intel_pstate/powersave (no-HWP)
doug@s19:~/kernel/linux$ grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu10/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu11/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu2/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu4/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu5/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu6/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu8/cpufreq/scaling_cur_freq:800295
/sys/devices/system/cpu/cpu9/cpufreq/scaling_cur_freq:800015

intel_cpufreq/schedutil (no-HWP)
doug@s19:~/kernel/linux$ grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu10/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu11/cpufreq/scaling_cur_freq:1971265
/sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu2/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu4/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu5/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu6/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu8/cpufreq/scaling_cur_freq:2785446
/sys/devices/system/cpu/cpu9/cpufreq/scaling_cur_freq:0

Which I suggest is more consistent.

Note: because it was deleted from this thread, 
and just for reference, I'll repost the previous
intel_cpufreq/schedutil (no-HWP) output:

doug@s19:~$ grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:800000
/sys/devices/system/cpu/cpu10/cpufreq/scaling_cur_freq:1067573
/sys/devices/system/cpu/cpu11/cpufreq/scaling_cur_freq:800000
/sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq:800000
/sys/devices/system/cpu/cpu2/cpufreq/scaling_cur_freq:800000
/sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq:800011
/sys/devices/system/cpu/cpu4/cpufreq/scaling_cur_freq:800000
/sys/devices/system/cpu/cpu5/cpufreq/scaling_cur_freq:800109
/sys/devices/system/cpu/cpu6/cpufreq/scaling_cur_freq:800000
/sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq:800000
/sys/devices/system/cpu/cpu8/cpufreq/scaling_cur_freq:800000
/sys/devices/system/cpu/cpu9/cpufreq/scaling_cur_freq:800000

... Doug


