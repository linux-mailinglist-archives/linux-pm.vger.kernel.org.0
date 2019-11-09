Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE143F604C
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2019 17:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfKIQrS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Nov 2019 11:47:18 -0500
Received: from cmta17.telus.net ([209.171.16.90]:47936 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfKIQrS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 9 Nov 2019 11:47:18 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id TTtGixn7ebg38TTtIilL8W; Sat, 09 Nov 2019 09:47:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1573318037; bh=xYZ5lsp8V4slvD586PMAOXp6jdS3Dieavo9RNH067J4=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=gFdOT+YpwKO9E9t23Gb2I+6tDowIl0vNHsG/TDJ5oMvjxg035bdzORR2pMA6vqJ4e
         OU6om9DvpawD3vJ1mJa+AujFA+CuufTfuoEZSapKSoaMvt8Np/K4vcCOubChpazvsr
         4/ZXUNAncLDqAkc11Dby/1DQmJu0VQvN0/O79kN47UqG279ls2otX4NBdHUYc9lw4n
         GCZm3H2mYfUL/gtHJTTfeeKLJsaSDMqpO+TcWNwlnGjFThUFeR5Ot8YEzPQIV9G8vv
         NdPuHy8ftYHPUrisuPJuUGTMpfHZHeD7asHijXnskBaRjU3rDVXXRg/7PF2oW2ahQ+
         oR1q4iLKPhSLQ==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=O/1HQy1W c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=ZA-plZwTbEW-Z-NLSHsA:9 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Vincent Guittot'" <vincent.guittot@linaro.org>
Cc:     "'linux-kernel'" <linux-kernel@vger.kernel.org>,
        "'open list:THERMAL'" <linux-pm@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Ingo Molnar'" <mingo@kernel.org>,
        "'Linus Torvalds'" <torvalds@linux-foundation.org>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Sargun Dhillon'" <sargun@sargun.me>,
        "'Tejun Heo'" <tj@kernel.org>, "'Xie XiuQi'" <xiexiuqi@huawei.com>,
        <xiezhipeng1@huawei.com>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Rik van Riel'" <riel@surriel.com>
References: <1572018904-5234-1-git-send-email-dsmythies@telus.net> <CAKfTPtDFAS3TiNaaPoEXFZbqdMt_-tfGm9ffVcQAN=Mu_KbRdQ@mail.gmail.com> <000c01d58bca$f5709b30$e051d190$@net> <CAKfTPtDx6nu7YtYN=JLRAseZS3Q6Nt-QdMQuG_XoUtmtR_101A@mail.gmail.com> <001201d58e68$eaa39630$bfeac290$@net> <20191029160210.GA8343@linaro.org> <000001d58f2a$fc593200$f50b9600$@net> <CAKfTPtCjhYKttEuWs9cqicUdJMiJVy5he+=xWofof_4xAWgKAw@mail.gmail.com> <20191108091834.GA24402@linaro.org>
In-Reply-To: <20191108091834.GA24402@linaro.org>
Subject: RE: [PATCH] Revert "sched/fair: Fix O(nr_cgroups) in the load balancing path"
Date:   Sat, 9 Nov 2019 08:47:09 -0800
Message-ID: <000001d5971d$57a90c80$06fb2580$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdWWFYIwQ0QGiY96SSCfUeRMecxwVAA/eo1g
Content-Language: en-ca
X-CMAE-Envelope: MS4wfMniLnRodmxm8Jj+w3x1r/hP2mas/R9Z7BhdhAuMarXSLQGJX4M/BPis61Ooi3fEqmzV4LCdo0IQ4ROZqI2nEayfjQfHXTfw/MuzidwMCPBjvCnowZwZ
 LIGd1MJwQMInzJQnjG7DGi1r9er9N41b/TXoe11QCYyQb1TeKUR4fTorINxROEZSYALUkJra4KYzcjX92a7usH7yRiEJ8iH5x3I2MlbTV17DYSZKn3Nggt1v
 arBdpGh1DyEOVaPyBBLJUONabYQw7Cc8Zbk91baOC0bkW597x0GTPsH9cs4QUNjLyX2P+ihFuaCf0BlQ1J8LELEtkltDU5LOPzPfjuGW8juYw0OPtNuUbduq
 yC4wO1Vqz65WHfQZwWhNeiVoZbIZPRLaKwWREL1lE4J1lWufUIcE0IgJ8rLCpCo/dIRjoo2Mv/UUGsT1hAz+8j3gcTgSmZCy3FJYU2LU8FD0U0qgb03BI/6t
 hyuXNd2T7Ef8M3e3x8DapkAUaZxasBgZ+kRKXFL2FpZrZPa2Q1r63F0+RPdm59OMiDC8hL5LMEiXKcTbTZnDtmvGitbCjDhXB6aNFA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Vincent,

Thank you for your item 2 patch.

On 2019.11.08 01:19 Vincent Guittot wrote:
...
>> I have to prepare a patch for this part which is item 2
>
> I have finally been able to prepared the patch for item 2. Could you check
> that it also fixes your problem ?
...
> We can still have some spurious call to cpufreq_util_change in 
> update_blocked_average() with this patch but at least the value will be
> up to date in both calls, which was not the case before. If this fix
> Doug's problem, I can prepare an additional one to fix the spurious call
> but I wanted to make sure that this fix the problem first.

Yes, the issue is solved with this patch.
I do wonder if I am seeing the effect of the spurious calls.

Details:

Test 1: an 8000 second trace during system idle:
Maximum duration: 4.00015 seconds. Good.
Typically, there would have been about 300 durations
of over 10 seconds in 8000 seconds.
Number of calls to driver: 103168, which is about 8% more than
the previous experimental solution.
(Should be repeated a few times to verify repeatability, but
not going to.)

Test 2: one 8000 second energy sample, for high accuracy idle power:
3.703 watts which is about +0.7% idle power increase.

Test 3: The load-no-load test with only idle state 1 enabled:
There was never an excessive energy sample for the no load samples.
The test ran for about 8 hours.
Maximum: 9.49 watts
Minimum: 9.13 watts
Recall that with the issue, the max would have been about 14 watts

Kernel: 5.4-rc6 + your items 1 and item 2 patches.
Idle governor = menu, because teo fixes are still pending.
Note: some reference data is from kernel 5.4-rc2, and really
should have been re-done with 5.4-rc6 as the baseline.

... Doug


