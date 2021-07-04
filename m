Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CA43BAF1F
	for <lists+linux-pm@lfdr.de>; Sun,  4 Jul 2021 23:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhGDVDo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jul 2021 17:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhGDVDl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jul 2021 17:03:41 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BF0C061574
        for <linux-pm@vger.kernel.org>; Sun,  4 Jul 2021 14:01:04 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id f17so3380041pfj.8
        for <linux-pm@vger.kernel.org>; Sun, 04 Jul 2021 14:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-language:thread-index;
        bh=iI3uF1bDUo4egivepLtXroEvyEa4YutDZwgnKojquc0=;
        b=OtN4kjkNivn7m/5NuvmBft08BmiJDPlULpP++N7bVsTAWb7XrrpcvsU4zIqaOQgNNJ
         mDG6zp2b5SxqGSDY//QaPv4FuzjHY0H9+q8TRZDJQn5FcW4uTOnkD3NxC44b7hSpZZiI
         w9Z86JBIi8AObCwWK4oayQbBLDz+cN9oiTjmHc7goV+HjinT/kAB2q8jzrnixVCJiNSp
         +sdsKcikEFiZC8N9f3t5lu/3FwUYDmJU6LeGPK6qHs9PMUpxbCt3kjeVoPEbU/yakzAc
         00nhdeaZ0HBDlclytE8ThwRwecYE9j7ypMjdZSe08FV/MWw1kqU7eHruUCYt8cBUBJxL
         pPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-language:thread-index;
        bh=iI3uF1bDUo4egivepLtXroEvyEa4YutDZwgnKojquc0=;
        b=Qb6zfOUrukQ2Dts2ZuC7nYoXAecAVma/wPI3lQR+a9WVYCQBqe86+K+K9p6m8Bz5MR
         T8OABvm9DzFLKVEl7MM6xwrVz94GcfKSuQR23Kopr4njFwlnwgQ7xCMUMemtAOANfff8
         e5qQF2nOQWy2qv9OHs/kbm2dEgxJFW27zjvwi4XgvNn0ZO+ZKI61PVGwUBIu32n6nA7C
         Y2xDG/0GvXDaHzVDPWhsywVkVxUqVocrIJLvc817sE6hSx/M13w15BzpKIeUW1gHg9Kl
         937c4zYDatGWbPkt1POhqJsj6AYYAAlNU2fzDwRuDfabxB889KkBIf2js4UOmN9NwWeF
         oCQg==
X-Gm-Message-State: AOAM532VUkEqOi4COWcgBqHVHZcIUEHnxz3quv+Fw8YSGoC5F0GFEcSf
        IIZRuvQpCB3LbHgrbCNnPuYnJw==
X-Google-Smtp-Source: ABdhPJxRtLiuaegnonLXfVUOSlaK02kjuZO0STvEQcAm6S60ObmdXj0crJVCd9OjQu5kPXwwP5eVUQ==
X-Received: by 2002:a05:6a00:d5b:b029:315:339c:343f with SMTP id n27-20020a056a000d5bb0290315339c343fmr11240931pfv.67.1625432463810;
        Sun, 04 Jul 2021 14:01:03 -0700 (PDT)
Received: from DougS18 (s173-180-45-4.bc.hsia.telus.net. [173.180.45.4])
        by smtp.gmail.com with ESMTPSA id q24sm11608727pgk.32.2021.07.04.14.01.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Jul 2021 14:01:03 -0700 (PDT)
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <1867445.PYKUYFuaPT@kreacher>
In-Reply-To: <1867445.PYKUYFuaPT@kreacher>
Subject: RE: [PATCH v1 0/5] cpuidle: teo: Rework the idle state selection logic
Date:   Sun, 4 Jul 2021 14:01:03 -0700
Message-ID: <007101d77117$b3b837a0$1b28a6e0$@telus.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="----=_NextPart_000_0072_01D770DD.075BD0A0"
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJWv5LtWSG8O5a4tG6eLIHdXBOua6oyGFTw
X-MS-TNEF-Correlator: 00000000F612BA434C3BD1459CD08FACC813FD560700C3B68E10F77511CEB4CD00AA00BBB6E600000000000D0000594B38924B34934DBE4E673D978C4FD9000000002ED90000
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a multipart message in MIME format.

------=_NextPart_000_0072_01D770DD.075BD0A0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi Rafael,

On 2021.06.02 11:14 Rafael J. Wysocki wrote:

> Hi All,
>
> This series of patches addresses some theoretical shortcoming in the
> TEO (Timer Events Oriented) cpuidle governor by reworking its idle
> state selection logic to some extent.
>
> Patches [1-2/5] are introductory cleanups and the substantial changes are
> made in patches [3-4/5] (please refer to the changelogs of these two
> patches for details).  The last patch only deals with documentation.
>
> Even though this work is mostly based on theoretical considerations, it
> shows a measurable reduction of the number of cases in which the
shallowest
> idle state is selected while it would be more beneficial to select a
deeper
> one or the deepest idle state is selected while it would be more
beneficial to
> select a shallower one, which should be a noticeable improvement.

Do you have any test results to share? Or test methods that I can try?
I have done a few tests, and generally don't notice much difference.
Perhaps an increase in idle state 2 below (was to shallow) numbers.
I am searching for some results that would offset the below:

The difficulty I am having with this patch set is the additional overhead
which becomes significant at the extremes, where idle state 0 is dominant.
Throughout the history of teo, I have used multiple one core pipe-tests
for this particular test. Some results:

CPU: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz
HWP: disabled
CPU frequency scaling driver: intel_pstate, active, powersave
Pipe-tests are run forever, printing average loop time for the
Last 2.5 million loops. 1021 of those are again averaged.
Total = 2.5525e9 loops
The power and idle data is sampled for 100 minutes.

Note 1: other tests were also done and also with passive,
schedutil, but it isn't relevant for this test because the
CPU frequency stays pinned at maximum.

Note 2: I use TCC offset for thermal throttling, but I disabled it
for these tests, because the temperature needed to go higher
than my normal throttling point.

Idle configuration 1: As a COMETLAKE processor, with 4 idle states.
Kernel 5.13-RC4.

Before patch set average:
2.8014 uSec/loop
113.9 watts
Idle state 0 residency: 9.450%
Idle state 0 entries per minute: 256,812,896.6

After patch set average:
2.8264 uSec/loop, 0.89% slower
114.0 watts
Idle state 0 residency: 8.677% 
Idle state 0 entries per minute: 254,560,049.9

Menu governor:
2.8051 uSec/loop, 0.13% slower
113.9 watts
Idle state 0 residency: 8.437% 
Idle state 0 entries per minute: 256,436,417.2

O.K., perhaps not so bad, but also not many idle states.

Idle configuration 2: As a SKYLAKE processor, with 9 idle states.
i.e.:
/drivers/idle/intel_idle.c
static const struct x86_cpu_id intel_idle_ids[] __initconst
...
   X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X, &idle_cpu_skx),
+ X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE, &idle_cpu_skl),

Purpose: To demonstrate increasing overhead as a function of number
of idle states.
Kernel 5.13.

Before patch set average:
2.8394 uSec/loop
114.2 watts
Idle state 0 residency: 7.212%
Idle state 0 entries per minute: 253,391,954.3

After patch set average:
2.9103 uSec/loop, 2.5% slower
114.4 watts, 0.18% more
Idle state 0 residency: 6.152%, 14.7% less.
Idle state 0 entries per minute: 244,024,752.1

Menu governor:
2.8141 uSec/loop, 0.89% faster
113.9 watts,  0.26% less
Idle state 0 residency: 7.167%, 0.6% less
Idle state 0 entries per minute: 255,650,610.7

Another potentially interesting test was the ebizzy test:
Records per second, averaged over many tests, varying
threads and intervals:

passive, schedutil:
Before: 6771.977
After: 5502.643, -18.7%
Menu: 10728.89, +58.4%

Active, powersave:
Before: 8361.82
After: 8463.31, +1.2%
Menu: 8225.58, -1.6%

I think it has more to do with CPU scaling governors
than this patch set, so:

performance:
Before: 12137.33
After: 12083.26, -0.4%
Menu: 11983.73, -1.3%

These and other test results available here:
(encoded to prevent a barrage of bots)

double u double u double u dot smythies dot com
/~doug/linux/idle/teo-2021-06/

... a day later ...

I might have an answer to my own question.
By switching to cross core pipe-tests, and only loading down one
CPU per core, I was able to get a lot more activity in other idle states.
The test runs for 100 minutes, and the results change with time, but
I'll leave that investigation for another day (there is no throttling):

1st 50 tests:
Before: 3.888 uSec/loop
After: 3.764 uSec/loop
Menu: 3.464 uSec/loop

Tests 50 to 100:
Before: 4.329 uSec/loop
After: 3.919 uSec/loop
Menu: 3.514 uSec/loop

Tests 200 to 250:
Before: 5.089 uSec/loop
After: 4.364 uSec/loop
Menu: 4.619 uSec/loop
 
Tests 280 to 330:
Before: 5.142 uSec/loop
After: 4.464 uSec/loop
Menu: 4.619 uSec/loop

Notice that the "after" this patch set is applied eventually does
better than using the menu governor. Its processor package power
always remains less, than the menu governor.

The results can be viewed graphically at the above link, but the
most dramatic results are:

Idle state 3 above % goes from 70% to 5%.
Idle state 2 below % goes from 13% to less than 1%.
 
... Doug


------=_NextPart_000_0072_01D770DD.075BD0A0
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="winmail.dat"

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
fvACIPlrVsGUcoUA/y8yNBE8wYOiJXGH81nzZQNhcjJiaXp6WdQhhVL/cMEbsM4En5BCwdHhjTZv
Y//S1F7VmYAyUCdxpyZjMVwx/5CDE/KZgDtQIYuW5oKRl+XvIYXv5AFhwbAxyaDBsPnJ/32AjsAF
YLnwzCBDoH7gwYDPzEAGWH2AEaA3MsGAucD5Q6ArNcwB9hX5xYSeHY2P8fARkLzBHvs4NDbJkP4z
+PAiEB6g9gYhJLzQ+JC9ipA4IEIOIdP7QCJuQLH/imBccEDijKEukT2gPUR/Yr+CpgcGebWng21s
HNFvG5z/ruCSEdLhVwAdjfXwyHDPgO4z+VUfVfXwMPHwCyEgQae90CJmISUxOTLBNyAz//lAIns7
sYxiX1GUWFo3WXDvOzFXI3MS2WUoYaFcIKY0b1eQh1FxwkFhcohzdsFi2RMwcynnyj2gdVcyWUD/
PD90UdFxp9Ap4UdxPeJw0WggL348wWezMASxeDvaVHbxLTKgi9AzMDYv/+fK3+FNspzAAlAPcZBg
3+e/XVYEoKbgKlJZg1mhc1US/ysBp9FIwI0QgjEUQatAZnX+QoKBrUFndCsBYyCMUKuw/3jdXySr
QF/xZLAagILjRZL/TsGbaLiCeNJ3IhTyVyOmYv/68oixW8FSkoSDlqATwjaF/+1Pa1NZ9Ibwq7CS
HV8kpPL/WkaX0HGwiJFtFIkhmFNdVf4niuACUVlyXGN0kBhwFEG/jODr05IScbCUVEIyKBLS1+nh
0TKoaSl8izE3Ebag917EHY3JkDhbsPI+H1U0gf+8+iDKyZAmkF2fawWGU1oi7ytAklEdjfkxMo8Q
W/9dBf/44GLfXqbHcF9PYFoyoGEj//iQYZ6vQDKwZJ8fVfkxXz//IRV/wBGQae/MZWe1sqCmUvcx
oGivf9A083BqD2sVXy8/bJ9mn5PC3BBVRaTyImH9+jIiLa1X8tEQkcAQEKZA/TnzdROTlbAEMOAU
pHCosP+UgqeSmvAUY6UBiTAG2YuQzkmGcayX+nFja4iChQP/4BSCwEwgnNGZQKgw6gCrsP8CYtCw
LWV7njU9UninoaRwrxlgEBBE8KZAZ6WAcJog/ywBE7F2dUxgGGECUCoBmFT/mzfpYDcR2eCRoNvz
N0c4h/8Or/xQhQT9UAcABDGcAD8B/je2sKZS/UACrwUQpGHIwd+KG8hyKwF/onq0MYtmzGUtQdJE
P2Hnyn2RMAADABYQAAAAAAMADTT9P60OAwAPNP0/rQ4CARQ0AQAAABAAAADpL+t1llBEhoO4feUi
qklIAgHiZQEAAAAUAAAAo8ZOEXWSL0eLchsak/4ZuwAA8MQCAeNlAQAAABUAAAAUo8ZOEXWSL0eL
chsak/4ZuwAA8MQAAAACAX8AAQAAAI0AAAAwMDAwMDAwMEY2MTJCQTQzNEMzQkQxNDU5Q0QwOEZB
Q0M4MTNGRDU2MDcwMEMzQjY4RTEwRjc3NTExQ0VCNENEMDBBQTAwQkJCNkU2MDAwMDAwMDAwMDBE
MDAwMDU5NEIzODkyNEIzNDkzNERCRTRFNjczRDk3OEM0RkQ5MDAwMDAwMDAyRUQ5MDAwMAAAAAAD
AAYQHaqPdgMABxAHEAAAAwAQEAAAAAADABEQAAAAAB4ACBABAAAAZQAAAEhJUkFGQUVMLE9OMjAy
MTA2MDIxMToxNFJBRkFFTEpXWVNPQ0tJV1JPVEU6SElBTEwsVEhJU1NFUklFU09GUEFUQ0hFU0FE
RFJFU1NFU1NPTUVUSEVPUkVUSUNBTFNIT1JUQ08AAAAAr18=

------=_NextPart_000_0072_01D770DD.075BD0A0--

