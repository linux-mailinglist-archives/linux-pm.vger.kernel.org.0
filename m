Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B02210827C
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2019 08:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfKXHuJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 Nov 2019 02:50:09 -0500
Received: from cmta16.telus.net ([209.171.16.89]:40844 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbfKXHuJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 24 Nov 2019 02:50:09 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id YmedirLl6FXoiYmeei80Cx; Sun, 24 Nov 2019 00:50:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1574581807; bh=h0LBhE0iQuKPr/tUZesX5007Cm2XS3vVFYqAWfewTQo=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=Yx8+tMKrUUSfV0lMcDOWqcpp3isBKLAj5EGXseY0mMyWQB3zgzZDRHnVeBQygRcH6
         QsRvtbvsgQTNJNK/Y8s2NOvF6vt9OOe5NutbM5tI148CaJBqJvw+fILwgw6dP+Ybf0
         /Vule9beZyfSzSpYIiefghVvjk3QQ0tHYqGgQ5pBDsdOItDOwF9ZB87wcn4iNpcrOn
         PDGC8mWNDnuTTmPfiFK6OUAP6whv6LBf9LJJMT9z5C5TFnVuMaQuxC0GftqnmhfyiG
         IaRscugbHLkQnGo1+DVt4xHv2U37oEdDogQfGIiNmw9X6HDFrJ0TKDgUG1lqUdjEJM
         Ayjp9zDncJInQ==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=HoEI5HbS c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=JfrnYn6hAAAA:8 a=dyyLcSohDm2E6IqdOvAA:9 a=CjuIK1q_8ugA:10
 a=1CNFftbPRP8L7MoqJWF3:22 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
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
References: <20191113124654.18122-1-ggherdovich@suse.cz> <20191113124654.18122-2-ggherdovich@suse.cz>
In-Reply-To: <20191113124654.18122-2-ggherdovich@suse.cz>
Subject: RE: [PATCH v4 1/6] x86,sched: Add support for frequency invariance
Date:   Sat, 23 Nov 2019 23:49:57 -0800
Message-ID: <000001d5a29b$c944fd70$5bcef850$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdWaH6kpvI2RPz8IRtKQLXZcAyoYugIIu9uQ
Content-Language: en-ca
X-CMAE-Envelope: MS4wfN/Lu7m5KE5yhuHdppXc/me+VKZjdiQs2pJ7JaSn+Kt5AJUl0qFJRkFcdIu6vYdqbQ7gCE6Q5G7in/rSUSLVh7EI+SuWH4RBz2reEwFFcUAz3Op/azXq
 GokWLqVZGsIHriQBqsLsmxx74TD1rMTkNC1DYCnMk0KDO4wdS1Cfirhufd/hNKQrQubwAcsgAC5fQ/uAg4aO3wy4QgX5c01GY+j48qYjhowRzmJ8fmuL8y5q
 WOjQQrZvmZklo7wZCYT4gmsc4EF7A8Op7DhepXsTEDgPRSYQRQUSO+/kRv7juyihOnL9UDmqc2BZjlFmH0QK3VTJbqpiciaqNvaQFoM+uScmZgSHysHNV1l8
 C8B76rh/1m0+FPaQm90owXmtliB9Y1rsjSDoRHor9FS0cL2PVOy1mChobVthcO6/2H83IFBMi5wC1CyMflZkQlHcu3XROGwDpDrOJGf6GkqgsynphM92FADY
 /M4c4h9uSmPOfxTjsomCeXkaB1vEGTxvvR5RuqX5MOwg/dhXVrXiazdBb2amwa3y9b5/KJ/dB9BQx+jtcSwTWwW/LwlAItVSPtfMkylwrIL1BJtX+CCXzVwB
 1tn9Au0I9FHbyGHQmg8DCYmFvCZPgT9U9cn2j5FxfcAkcO9C2lgvdEddANH0HyqEySJYFu/WJ6I5ud2LspKAjaYC/3G7/XAVFryauaQ7je2rRxgUEoWZx36+
 rIJ+xojuqVoO9wHQirjhrAqbGgf1kutjo39Jdj+pG8HIYDHJMo30OA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

The address list here is likely incorrect,
and this e-mail is really about a kernel 5.4
bisected regression.

It had been since mid September, and kernel 5.3-rc8 since
I had tried this, so I wanted to try it again. Call it due diligence.
I focused on my own version of the "gitsource" test.

Kernel 5.4-rc8 (as a baseline reference).

My results were extremely surprising.

As it turns out, at least on my test computer, both the
acpi-cpufreq and intel_cpufreq CPU frequency scaling drivers
using the schedutil governor are broken. For the tests that
I ran, there is negligible difference between them and the
performance governor. So, one might argue that they are not
broken, but rather working incredibly well, which if true
then this patch is no longer needed.

I bisected the kernel and got:

first bad commit: [04cbfba6208592999d7bfe6609ec01dc3fde73f5]
Merge tag 'dmaengine-5.4-rc1' of git://git.infradead.org/users/vkoul/slave-dma

Which did not make any sense at all. I don't even know how
this is being pulled into my kernel compile.
O.K., I often (usually) make a mistake
during bisection, so I did it again, and got the same result.

Relevant excerpt from the commit:

diff --cc drivers/dma/Kconfig
index 413efef,03fa0c5..7c511e3
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@@ -294,8 -294,8 +294,8 @@@ config INTEL_IOATDM
          If unsure, say N.

  config INTEL_IOP_ADMA
 -      tristate "Intel IOP ADMA support"
 -      depends on ARCH_IOP32X || ARCH_IOP33X || ARCH_IOP13XX
 +      tristate "Intel IOP32x ADMA support"
-       depends on ARCH_IOP32X
++      depends on ARCH_IOP32X || COMPILE_TEST
        select DMA_ENGINE
        select ASYNC_TX_ENABLE_CHANNEL_SWITCH
        help

If I revert the above, manually, then everything behaves
as expected (minimally tested only, so far).

Are others seeing the schedutil governors not working as
expected with any of kernels 5.4-rc1 - 5.4-rc8?

I do have a pretty graph of my method of doing the
"gitsource" test, but am not ready to post it yet.
Here is some gitsource test data, 6 runs of "make test",
the first run is discarded:

"gg 6" means this 6 patch set.

Kernel 5.4-rc8 + revert, intel_cpufreq/schedutil: 3899 seconds
Kernel 5.4-rc8 + gg 6 + revert, intel_cpufreq/schedutil: 2740.7 seconds
Ratio: 0.70 (as expected)
Kernel 5.4-rc8, intel_cpufreq/schedutil: 2334.7 seconds (faster than expected)
Kernel 5.4-rc8 + gg 6 patch set, intel_cpufreq/schedutil: 2275.0 seconds (faster than expected)
Ratio: 0.97 (not as expected)
Kernel 5.4-rc8, intel_cpufreq/performance: 2215.3 seconds
Kernel 5.4-rc8, intel_cpufreq/ondemand: 3286.3 seconds
Re-stated from previous e-mail:
Kernel 5.3-rc8, intel_cpufreq/schedutil: ratio: 0.69 (I don't have the original times)

... Doug


