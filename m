Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22D73109907
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 06:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKZF7a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 00:59:30 -0500
Received: from cmta19.telus.net ([209.171.16.92]:59850 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbfKZF73 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 26 Nov 2019 00:59:29 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id ZTsgi5W0bhFQMZTshiLxqh; Mon, 25 Nov 2019 22:59:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1574747967; bh=z8K/VrFh+Mh+HHkwgWhGVWNDyBSRROvGxEQPmJ/967I=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=sCCZcTBW2BMiJWxHG+31qUiS8xoOOxA3Rs9G5zJZw8Dal6ujQ/ma8xWDjNcsmQ5Cr
         wnhoI1/VLFGMkPWdQZKjfz6v+CIc7+II6RlrWfO58nWSvlairt9prGEO6WRvwp/l2a
         eqeLT09Sntw/V8/Zi/g52Dhkiihc8uGLToMGFyz72eBL61h+gb5yMnz9TopxqdF+rj
         RD73LskYr1EEGG6i2oGEF4xNJgh9he+/OfGad3bZujgpTUMi4ftyNPyubQ3rRJiSo5
         owq+gdT5pYveQowNp+0FupqQD3NQMbkWn2yPG9D2B76pXpjVh3cI2ljUTHCJv4X+Ed
         FgcXCH0NXW/Cw==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=ZPWpZkzb c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=JFpEMq-k8J54Cn6rv2oA:9 a=QEXdDO2ut3YA:10
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Ingo Molnar'" <mingo@redhat.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Borislav Petkov'" <bp@suse.de>, "'Len Brown'" <lenb@kernel.org>,
        "'Rafael J . Wysocki'" <rjw@rjwysocki.net>
Cc:     <x86@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "'Mel Gorman'" <mgorman@techsingularity.net>,
        "'Matt Fleming'" <matt@codeblueprint.co.uk>,
        "'Viresh Kumar'" <viresh.kumar@linaro.org>,
        "'Juri Lelli'" <juri.lelli@redhat.com>,
        "'Paul Turner'" <pjt@google.com>,
        "'Vincent Guittot'" <vincent.guittot@linaro.org>,
        "'Quentin Perret'" <qperret@qperret.net>,
        "'Dietmar Eggemann'" <dietmar.eggemann@arm.com>
References: <20191113124654.18122-1-ggherdovich@suse.cz>         <20191113124654.18122-2-ggherdovich@suse.cz>    <000001d5a29b$c944fd70$5bcef850$@net> <1574697961.16378.5.camel@suse.cz>
In-Reply-To: <1574697961.16378.5.camel@suse.cz>
Subject: RE: [PATCH v4 1/6] x86,sched: Add support for frequency invariance
Date:   Mon, 25 Nov 2019 21:59:19 -0800
Message-ID: <000801d5a41e$a7fce2c0$f7f6a840$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdWjqXhG/2FkhiwgRMuiczjnDuyRDAAcWJdQ
Content-Language: en-ca
X-CMAE-Envelope: MS4wfInqMyosb61dzHgkCKzooGPz79WDnaXBPCmUSZDIwyZ5LmcPMdmWp44zLZREww2ABFfDRsT+z8Bgb6nk5mhKfDYozE8wV31XBvSJrTGlvGaCUEyO45Nm
 ATKnDQWFQYihptyBVYWzlUx6dE/qeohbR2bjHUu/L3NipUmb/r1zLITY27BGqlwMVGcaDCHr3kVjLAE5fKX/cBg7Zl7To46YJn8Pji4L2JTKNWm1OSQaQoo9
 1Eg6kLlG3apyrkB6WoXltwHQQFvc8o058qggz40RXX2q7xys/KoYmXrfuHA+nKj+bypSPCzXs7Fhq8D30Xw1bIQQlLSUuHWOyvhyomfCvBmnZchiTuyLGRrN
 YVvUBWqikuOPIAFT3SjmewJZqGJZ39T7E4qPvVZNNMHNeYniOYK29gb5+vHW56yaOXeMorj7rGGREntvD4r/az0kT0aMEzOTUmMa/DIGkVXvFVVunG3Wi11z
 IbEHZeTxqdp8AbcLqw8v2X2kf3VN7O4o/CCTI9h8Vy0WisgXni9O5+oRpnvnKtQ9nmZPg2W+HQiXTfAUD978fTetQqJFv4aRGCfXki4zKiN/mJfZZmSjppSK
 1aj/0KNZh1UAeT07CoJNmK9lSkjxfsI7kBPKNpY3lyhkyu3Ds4r72CJVygeV8mBQZUQbitq/gPklx/hhbBBRgPkSxG5o1DlDXOaDwL18On8J4KepLw/S75zG
 Fy62+K/DIgEU/E+yNwAotg2DGBPDBlV8vYs95DAXw07dA+gUCArEEQ==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019.11.25 08:06 Giovanni Gherdovich wrote:
> On Sat, 2019-11-23 at 23:49 -0800, Doug Smythies wrote:
>> ...
>> Kernel 5.4-rc8 + revert, intel_cpufreq/schedutil: 3899 seconds
>> Kernel 5.4-rc8 + gg 6 + revert, intel_cpufreq/schedutil: 2740.7 seconds
>> Ratio: 0.70 (as expected)
>> Kernel 5.4-rc8, intel_cpufreq/schedutil: 2334.7 seconds (faster than expected)
>> Kernel 5.4-rc8 + gg 6 patch set, intel_cpufreq/schedutil: 2275.0 seconds (faster than expected)
>> Ratio: 0.97 (not as expected)
>> Kernel 5.4-rc8, intel_cpufreq/performance: 2215.3 seconds
>> Kernel 5.4-rc8, intel_cpufreq/ondemand: 3286.3 seconds
>> Re-stated from previous e-mail:
>> Kernel 5.3-rc8, intel_cpufreq/schedutil: ratio: 0.69 (I don't have the original times)
>
> Hello Doug,
>
> schedutil in 5.4 going a lot faster than in 5.3 would be a surprise. I'm
> running that same test too to check if I can see it as well.

Great, thanks. But see below.

>
> Besides, as it's already been said this patchset adds frequency
> scale-invariance to scheduler metrics such as load and utilization and that's
> useful also in areas other than frequency scaling (most notably the scheduler
> load balancer).

The issue with the schedutil governor not working properly in the 5.4 RC series
appears to be hardware dependant.

My test computer is Intel(R) Core(TM) i7-2600K CPU @ 3.40GHz., Sandy Bridge.
On a temporary basis, I acquired a computer with an
Intel(R) Core(TM) i5-4460 CPU @ 3.20GHz, Haswell,
and schedutil governor behaviour with the exact same kernels is fine:

That "gitsource" test, "make test" 6 times, first run thrown out:

Kernel 5.4 intel_cpufreq/schedutil: 3411.8 seconds
Kernel 5.4 + gg 6 intel_cpufreq/schedutil: 1696.7 seconds
Ratio: 0.49
Recall you got a ratio of 0.49 with 5th generation, Broadwell.

... Doug


