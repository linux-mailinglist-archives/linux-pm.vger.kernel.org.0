Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24416773EDF
	for <lists+linux-pm@lfdr.de>; Tue,  8 Aug 2023 18:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbjHHQiN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Aug 2023 12:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbjHHQhV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Aug 2023 12:37:21 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328F14ED7
        for <linux-pm@vger.kernel.org>; Tue,  8 Aug 2023 08:53:25 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-765a7768f1dso501017085a.0
        for <linux-pm@vger.kernel.org>; Tue, 08 Aug 2023 08:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1691510003; x=1692114803;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=v07+d2PzggtgVVsN4yxpkKD6/5zQhVAjJNvT8W/jvmQ=;
        b=eoC1O+AIXlf4/umRBa7pYJa0JJ1Qh+a7NA9QsPs091y25bFL+qXdfT7iH6PEo0iz3/
         k7UdKRS98Vl5Wo4qSbC4vC6LKhsZRW2MVVubFB+SaJVZsyVxJEltbL5e5qWclvmXMsZ1
         LuqrkTAPaYBaZhfmCZJGbyfGzjp8BPU+FqOJ5YXS3YPLD20TBSUxvVqMbF/vFCJbeKAb
         C0aDuAOaIjTvyeB/dQkEzbgYfHLWYio295WHbr3piM4kDW9l5O1wJxFL807DPpLVEvC4
         NXKYcMtjVLLluc3X15sYW7Ck0nYmjRXGAgcY5SnaJCKiP4ios5S5Wh4v7H0ESAQFHXIK
         EILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510003; x=1692114803;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v07+d2PzggtgVVsN4yxpkKD6/5zQhVAjJNvT8W/jvmQ=;
        b=lKQAVrXwWfkcihC3LDIBYCM7dBtm5YMwzjuTYpTVffBZ156nLpShYXUUuATXJc8KLv
         Mb7jdf00TErIuVvWUhPPlacVVKCpWsaJNxEcMyKictlLiSntPJQhn10hhLGRRrSkMnZ3
         HoN9oRUUOFaN7ADdL+saeCFgsPov9JqRuW0zaq4/rgez8AUQ3Of5RrRnkAwRfDlBOFSp
         ND5G+whGjwigkLqSX5Fa5TkPrNo2KJbYHYCFpxBZtYdNyAi0UdvEXk3og2WtXSZWG84K
         k961F0ENe0ezkzFaPmT/S4Nte9yBVF1X9OBPmHCPRv6IL0Ua9p0hOPYAvgGem9e9Xw8t
         Q/jw==
X-Gm-Message-State: AOJu0YzaKFgjkc4mz7KWCGOPE0BtFP1psx+BYI2UvRlf2BpS2MDuUHGJ
        RtQO8M0U0diUxjIeAb7dNN/LriNEqCLvqj+OAYY=
X-Google-Smtp-Source: AGHT+IFMf50YKyt3KwMWRTcl1M5fifCs5xencal3lddQK6dd/DcKDeYapGb/Ty3izzFayCm0PMXa7g==
X-Received: by 2002:a17:902:f807:b0:1bb:a771:3542 with SMTP id ix7-20020a170902f80700b001bba7713542mr9311431plb.58.1691508151897;
        Tue, 08 Aug 2023 08:22:31 -0700 (PDT)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id w5-20020a1709029a8500b001b8b45b177esm9119875plp.274.2023.08.08.08.22.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Aug 2023 08:22:31 -0700 (PDT)
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc:     "'Peter Zijlstra'" <peterz@infradead.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Frederic Weisbecker'" <frederic@kernel.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Anna-Maria Behnsen'" <anna-maria@linutronix.de>,
        "'Kajetan Puchalski'" <kajetan.puchalski@arm.com>,
        "Doug Smythies" <dsmythies@telus.net>
References: <5712331.DvuYhMxLoT@kreacher> <CAJZ5v0jTG-oqV+misnP-=W5aq0S9X631kW9EhKNEn1VJQqwL2g@mail.gmail.com>
In-Reply-To: <CAJZ5v0jTG-oqV+misnP-=W5aq0S9X631kW9EhKNEn1VJQqwL2g@mail.gmail.com>
Subject: RE: [RFT][PATCH v2 0/3] cpuidle: teo: Do not check timers unconditionally every time
Date:   Tue, 8 Aug 2023 08:22:32 -0700
Message-ID: <002201d9ca0c$27606f70$76214e50$@telus.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ9vwxz9BM2k7TTX/nZoG5XNIBD0gJko9OgroVvOCA=
Content-Language: en-ca
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2023.08.03 14:33 Rafael wrote:
> On Thu, Aug 3, 2023 at 11:12=E2=80=AFPM Rafael J. Wysocki =
<rjw@rjwysocki.net> wrote:
>>
>> Hi Folks,
>>
>> This is the second iteration of:
>>
>> https://lore.kernel.org/linux-pm/4511619.LvFx2qVVIh@kreacher/
>>
>> with an additional patch.
>>
>> There are some small modifications of patch [1/3] and the new
>> patch causes governor statistics to play a role in deciding whether
>> or not to stop the scheduler tick.
>>
>> Testing would be much appreciated!
>
> For convenience, this series is now available in the following git =
branch:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> pm-cpuidle-teo

Hi Rafael,

Thank you for the git branch link.

I did some testing:

Disclaimer: I used areas of focus derived
from the original teo-util work last fall,
and did not check if they were still the best
places to look for issues.

CPU: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz
HWP: enabled
CPU frequency scaling driver: intel_pstate
CPU frequency scaling governor: performance
Kernel 1: 6.5-rc4 (1000 Hz tick rate)
Kernel 2: kernel 1 + this patch series (called "rjw")
System is extremely idle, other than the test work.

All tests were done with all idle governors:
menu, teo, ladder, rjw.

Test 1: 2 core ping pong sweep:

Pass a token between 2 CPUs on 2 different cores.
Do a variable amount of work at each stop.

Purpose: To utilize the shallowest idle states
and observe the transition from using more of 1
idle state to another.

Results:=20
=20
teo and rjw track fairly well, with
rjw reducing its use of idle state 0 before
teo as the work packet increases. The menu governor
does best overall, but performs worse over a greater
range of token loop times.

Details (power and idle stats; times):
http://smythies.com/~doug/linux/idle/teo-util2/ping-sweep/2-1/perf/
http://smythies.com/~doug/linux/idle/teo-util2/ping-sweep/2-1/2-core-ping=
-pong-sweep.png

Test 2: 6 core ping pong sweep:

Pass a token between 6 CPUs on 6 different cores.
Do a variable amount of work at each stop.

Purpose: To utilize the midrange idle states
and observe the transitions from between use of
idle states.

Results: There is some instability in the results
in the early stages.
For unknown reasons, the rjw governor sometimes works
slower and at lower power. The condition is not 100%
repeatable.

Overall teo completed the test fastest (54.9 minutes)
Followed by menu (56.2 minutes), then rjw (56.7 minutes),
then ladder (58.4 minutes). teo is faster throughout the
latter stages of the test, but at the cost of more power.
The differences seem to be in the transition from idle
state 1 to idle state 2 usage.

Details (power and idle stats; times):
http://smythies.com/~doug/linux/idle/teo-util2/ping-sweep/6-2/perf/
http://smythies.com/~doug/linux/idle/teo-util2/ping-sweep/6-2/6-core-ping=
-pong-sweep.png
http://smythies.com/~doug/linux/idle/teo-util2/ping-sweep/6-2/6-core-ping=
-pong-sweep-detail-a.png
http://smythies.com/~doug/linux/idle/teo-util2/ping-sweep/6-2/6-core-ping=
-pong-sweep-detail-b.png
http://smythies.com/~doug/linux/idle/teo-util2/ping-sweep/6-2/6-core-ping=
-pong-sweep-diffs.png

a re-run power and idle stats, showing inconsistent behaviour.
teo and rjw only, and no timing data:
http://smythies.com/~doug/linux/idle/teo-util2/ping-sweep/6-1/perf/

Test 3: sleeping ebizzy - 128 threads.

Purpose: This test has given interesting results in the past.
The test varies the sleep interval between record lookups.
The result is varying usage of idle states.

Results: It can be difficult to see any differences in
the overall timing graph, but a graph of differences
is revealing. teo outperforms rjw in the longer intervals
region of the test, at the cost of more power.

Details: (power and idle stats; times):
http://smythies.com/~doug/linux/idle/teo-util2/ebizzy/perf/
http://smythies.com/~doug/linux/idle/teo-util2/ebizzy/ebizzy-128-perf.png=

http://smythies.com/~doug/linux/idle/teo-util2/ebizzy/ebizzy-128-perf-dif=
fs.png

Test 4: 2 X 2 pair token passing. Dwell test. Fast:

Purpose: Dwell under one set of conditions. Observe
noise and/or any bi-stability.

Results (reference time is menu):
rjw: 3.0723 usecs/loop average. +3.15%
teo: 2.9917 usecs/loop average. +0.44%
menu: 2.97845 usecs/loop average. Reference
ladder: 4.077375 usecs/loop average. +36.9%

Powers are all similar, with ladder a bit lower.

Details: (power and idle stats; times):
http://smythies.com/~doug/linux/idle/teo-util2/many-0-400000000-2/perf/
http://smythies.com/~doug/linux/idle/teo-util2/many-0-400000000-2/times.t=
xt

Test 5: 2 X 2 pair token passing. Dwell test. Medium:

Purpose: Dwell under one set of conditions. Observe
noise and/or any bi-stability.

Results (reference time is menu):
rjw: 11.3406 usecs/loop average. -0.69%
teo: 11.36765 usecs/loop average. -0.45%
menu: 11.41905 usecs/loop average. reference
ladder: 11.9535 usecs/loop average. +4.68%

Powers are all similar.

Details:
http://smythies.com/~doug/linux/idle/teo-util2/many-3000-100000000-2/perf=
/
http://smythies.com/~doug/linux/idle/teo-util2/many-3000-100000000-2/time=
s.txt

Test 6: 2 X 2 pair token passing. Dwell test. Slow:

Purpose: Dwell under one set of conditions. Observe
noise and/or any bi-stability.

Results (reference time is menu):
rjw: 2591.70 usecs/loop average. +0.26%
teo: 2566.34 usecs/loop average. -0.72%
menu: 2585.00 usecs/loop average. reference
ladder: 2635.36 usecs/loop average. +1.95%

Powers are all similar, with ladder a bit lower.=20
Due to the strong temperature to power use curve,
a much longer dwell test would need to be run to
be sure to get to steady state power usage.

Details:
http://smythies.com/~doug/linux/idle/teo-util2/many-1000000-342000-2/perf=
/
http://smythies.com/~doug/linux/idle/teo-util2/many-1000000-342000-2/time=
s.txt

Test 7: 500 low load threads.

Purpose: This test has given interesting results
in the past.

500 threads at approximately 10 hertz work/sleep frequency
and about 0.0163 load per thread, 8.15 total.
CPUs about 32% idle.

Results:
rjw executed 0.01% faster than teo.
rjw used 5% less energy than teo.

Details:
http://smythies.com/~doug/linux/idle/teo-util2/waiter/perf/
http://smythies.com/~doug/linux/idle/teo-util2/waiter/times.txt

Conclusions: Overall, I am not seeing a compelling reason to
proceed with this patch set.

... Doug


