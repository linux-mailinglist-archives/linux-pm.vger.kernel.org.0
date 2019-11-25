Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC7D1089D8
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2019 09:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbfKYIQ0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Nov 2019 03:16:26 -0500
Received: from cmta17.telus.net ([209.171.16.90]:50669 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbfKYIQ0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 Nov 2019 03:16:26 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id Z9XdidPYlbg38Z9XfipV7L; Mon, 25 Nov 2019 01:16:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1574669783; bh=vFOQhePmh6HbgI64DL81DZAEDX3IaEHaCM2hrpYehi8=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=hEpbOAQfGMKyKXwiLXdUIinAVehnoL8CWGaYB0diF4MsT5hCcWKX9UQpOwiLhxSwf
         S000PMU2nT1QoG44b0ZkkDcYWXTNh82hpb0PnNoPGMY8IeDSu8HHkjlNAGrsVS/an9
         0+fq85c3wNNxlq9olHNLJsZB6qqjJB3uLOMGBEb5d7SIvojVk+1ktn/URHeotVPu/5
         gcGD2I1aZd9JG5Vdz9vhAhB6jmLfKZu7xDBkut+e+BDo/7+rI4rgA3Ee2ix0DN4mXR
         AxF3E1Q6KRHo7hstDbgGacDRJTckjeuNTb9jqdS0uLbq5F1DNqgOEB8ohLKgW9R7uX
         xnDUa7KwiZXwg==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=O/1HQy1W c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=JfrnYn6hAAAA:8 a=FGbulvE0AAAA:8 a=ODkfB97YEM3lDChqQvcA:9
 a=I_Xm75vh8Nu1Efj-:21 a=kuUscEa9XYuurKCR:21 a=CjuIK1q_8ugA:10
 a=1CNFftbPRP8L7MoqJWF3:22 a=svzTaB3SJmTkU8mK-ULk:22 a=pHzHmUro8NiASowvMSCR:22
 a=xoEH_sTeL_Rfw54TyV31:22
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
References: <20191113124654.18122-1-ggherdovich@suse.cz> <20191113124654.18122-2-ggherdovich@suse.cz> <000001d5a29b$c944fd70$5bcef850$@net>
In-Reply-To: <000001d5a29b$c944fd70$5bcef850$@net>
Subject: RE: [PATCH v4 1/6] x86,sched: Add support for frequency invariance
Date:   Mon, 25 Nov 2019 00:16:15 -0800
Message-ID: <000001d5a368$9eece830$dcc6b890$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdWaH6kpvI2RPz8IRtKQLXZcAyoYugIIu9uQAEc7qNA=
X-CMAE-Envelope: MS4wfNcpDtGbvHHZvc7IPZn/W/4wq+UdGU+vMUQBthDnyBdWLZshta4WIqM6GCszJ06iYjFAnam1Kz6pSW55qnj1SudvHrcaO9hSfGpJgROvZYqEMV8qURrE
 l9G7wCf3BjiEWo43VldlXE5LOD3sA4WxFrgzJCCWZ/uumK4LkHVWpvoBKjcVLuCLTY37+aBk2Y/xNtS8IlrsvTajxQUUMSSAlZh5HFEslmcq+hOZXAAw1JfG
 icfdDYx5hDt5A5+Ct+h1Hb5RHS6ElS6u5K7vbBWKVZmj66l1ezp2Kt6ODf8nMscJ2W1CK2OdJ+ocAwp9ZO4iRrwMvCgZqnktHeCr5qZ/C8aetto1n9cuCdEu
 Yu+gJkIJbyIWJLdImh9dWMGsySHBe5SLopvbdDMVwMEbqUwnslS89FgE+9nPh3Zy9ubiZgMaF2/1UwLSyEHW9ykWkmMRem29x/l+Z2LViUlD9mWTVmcB37Pu
 hnWrMRnSFGOyM2VgTz8j0pjb6rA05Wl93p4ov/mIRYRuUEN5/nEsmSVvx/+okw0oVyBqJzULeRiKoczTi5ljQksIEVOZhUOXQF3I/S/V/QLzbuI7LRwgrXOe
 wQE2ic9huXX4Ag+59NFi2NPzva1NuEyivgS3noL+yyUXzjOv/fc8r6jx03cxOYjXqpgpoj/Jq7kVWmguR5Dx1RKZ8MgaM6i6U5J+w/Vz6az0kezEGf+hnOq7
 legl8cZ2/NXorBpbrIxOvTyL/AbUcvR0Pqy2si6CP+J9lNQ/7MedEw==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019.11.23 23:50 Doug Smythies wrote:

> Hi all,
>
> The address list here is likely incorrect,
> and this e-mail is really about a kernel 5.4
> bisected regression.
>
> It had been since mid September, and kernel 5.3-rc8 since
> I had tried this, so I wanted to try it again. Call it due diligence.
> I focused on my own version of the "gitsource" test.
>
> Kernel 5.4-rc8 (as a baseline reference).
>
> My results were extremely surprising.
>
> As it turns out, at least on my test computer, both the
> acpi-cpufreq and intel_cpufreq CPU frequency scaling drivers
> using the schedutil governor are broken. For the tests that
> I ran, there is negligible difference between them and the
> performance governor. So, one might argue that they are not
> broken, but rather working incredibly well, which if true
> then this patch is no longer needed.

Should be able to gain better insight here with the 
intel_pstate_tracer.py utility, watching for differences
in rates of rotation between CPUs. Too late tonight.

>
> I bisected the kernel and got:
>
> first bad commit: [04cbfba6208592999d7bfe6609ec01dc3fde73f5]
> Merge tag 'dmaengine-5.4-rc1' of git://git.infradead.org/users/vkoul/slave-dma
>
> Which did not make any sense at all. I don't even know how
> this is being pulled into my kernel compile.
> O.K., I often (usually) make a mistake
> during bisection, so I did it again, and got the same result.
>
> Relevant excerpt from the commit:
>
> diff --cc drivers/dma/Kconfig
> index 413efef,03fa0c5..7c511e3
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@@ -294,8 -294,8 +294,8 @@@ config INTEL_IOATDM
>          If unsure, say N.
>
>  config INTEL_IOP_ADMA
>  -      tristate "Intel IOP ADMA support"
>  -      depends on ARCH_IOP32X || ARCH_IOP33X || ARCH_IOP13XX
>  +      tristate "Intel IOP32x ADMA support"
> -       depends on ARCH_IOP32X
> ++      depends on ARCH_IOP32X || COMPILE_TEST
>         select DMA_ENGINE
>         select ASYNC_TX_ENABLE_CHANNEL_SWITCH
>         help
>
> If I revert the above, manually, then everything behaves
> as expected (minimally tested only, so far).
>
> Are others seeing the schedutil governors not working as
> expected with any of kernels 5.4-rc1 - 5.4-rc8?
>
> I do have a pretty graph of my method of doing the
> "gitsource" test, but am not ready to post it yet.

Graphs and write up (mostly the same as herein) are now
here:

http://www.smythies.com/~doug/linux/single-threaded/k54regression/index.html

The graphs are rather crowded, sorry.

> Here is some gitsource test data, 6 runs of "make test",
> the first run is discarded:
>
> "gg 6" means this 6 patch set.
>
> Kernel 5.4-rc8 + revert, intel_cpufreq/schedutil: 3899 seconds
> Kernel 5.4-rc8 + gg 6 + revert, intel_cpufreq/schedutil: 2740.7 seconds
> Ratio: 0.70 (as expected)

Kernel 5.4-rc8 + gg 6 + revert, forced CPU affinity performance: 2106.5 seconds

> Kernel 5.4-rc8, intel_cpufreq/schedutil: 2334.7 seconds (faster than expected)
> Kernel 5.4-rc8 + gg 6 patch set, intel_cpufreq/schedutil: 2275.0 seconds (faster than expected)
> Ratio: 0.97 (not as expected)
> Kernel 5.4-rc8, intel_cpufreq/performance: 2215.3 seconds
> Kernel 5.4-rc8, intel_cpufreq/ondemand: 3286.3 seconds
> Re-stated from previous e-mail:
> Kernel 5.3-rc8, intel_cpufreq/schedutil: ratio: 0.69 (I don't have the original times)

... Doug


