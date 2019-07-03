Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 621195E60A
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 16:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfGCOGn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jul 2019 10:06:43 -0400
Received: from cmta17.telus.net ([209.171.16.90]:43076 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfGCOGn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Jul 2019 10:06:43 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id ifuBhTEEDzEP4ifuChmkRq; Wed, 03 Jul 2019 08:06:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1562162801; bh=7AK3lAbPF9IfZtK/nk2VLf17bp+n2IvH1EnM0vORmP0=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=IaL+27ZfIqBmuii6sZ3okVn3xSxjweag474KxqDBMa1FgBhv3K1rSE7CQsgC2taXC
         q1ScbRrWclDFN6C0E15Nw0iFDCUvYCEscxYVmuGf3Uwdei/qzr4iz/H7e5lW53o0EA
         IelIl0UsWuYk1UitJDSMzdTM09DZ/YrONwPDxbcnBRp7XpcWCCNbIJQhdiwuDgnZ1+
         FJJDBOgYBEL+OT0erv1JyxiqAU5VcDABAFTMPfgfJbWIgKq/KoWtzrBltT/SDJ9eg8
         usKMsHfjkJC5ZaYkeIoibnRYHto825gsy119vpkVC+yC2Du7TwlgovUz38mMHm+2A4
         1TCMuFTAPN7qQ==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=cYmsUULM c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=Ye9q-bpsAAAA:8 a=_UL-ih6NGSuCdm9YO5gA:9 a=QEXdDO2ut3YA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Alan Jenkins'" <alan.christopher.jenkins@gmail.com>
Cc:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <2ff025f1-9a3e-3eae-452b-ef84824009b4@gmail.com>
In-Reply-To: <2ff025f1-9a3e-3eae-452b-ef84824009b4@gmail.com>
Subject: RE: NO_HZ_IDLE causes consistently low cpu "iowait" time (and higher cpu "idle" time)
Date:   Wed, 3 Jul 2019 07:06:38 -0700
Message-ID: <000001d531a8$8931b2a0$9b9517e0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdUwImbbpKczS7J+QT6mtzDQSlV++wBga9sA
X-CMAE-Envelope: MS4wfLfa/TsVw7qsXoaZUNI35eH5/9QXw8OFOcVUuyGy7kGEXi8HE4vcaj5OKz54NsHJWEe/KYMubp1CqxycGXUfs5oX3M914iOWRqu6t+EqpnbdvBrzcYWZ
 F/aK1XZGYY+Fh0UiXrhTC8fvPTUxIPWeTjBYT6TAYM5q0Qb03V9xDtMO8Lt+v3PyLiQz06Y79b7+bhpGAJ4s7N/CNejp4c1+HGgr+c3sum0bi7kSa1Re+Apq
 vFO9qF0KRddNfey7QNWUCw==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019.07.01 08:34 Alan Jenkins wrote:

> Hi

Hi,

> I tried running a simple test:
>
>     dd if=testfile iflag=direct bs=1M of=/dev/null
>
> With my default settings, `vmstat 10` shows something like 85% idle time 
> to 15% iowait time. I have 4 CPUs, so this is much less than one CPU 
> worth of iowait time.
>
> If I boot with "nohz=off", I see idle time fall to 75% or below, and 
> iowait rise to about 25%, equivalent to one CPU.  That is what I had 
> originally expected.
>
> (I can also see my expected numbers, if I disable *all* C-states and 
> force polling using `pm_qos_resume_latency_us` in sysfs).
>
> The numbers above are from a kernel somewhere around v5.2-rc5.  I saw 
> the "wrong" results on some previous kernels as well.  I just now 
> realized the link to NO_HZ_IDLE.[1]
>
> [1] 
> https://unix.stackexchange.com/questions/517757/my-basic-assumption-about-system-iowait-does-not-hold/527836#527836
>
> I did not find any information about this high level of inaccuracy. Can 
> anyone explain, is this behaviour expected?

I'm not commenting on expected behaviour or not, just that it is
inconsistent.

>
> I found several patches that mentioned "iowait" and NO_HZ_IDLE. But if 
> they described this problem, it was not clear to me.
>
> I thought this might also be affecting the "IO pressure" values from the 
> new "pressure stall information"... but I am too confused already, so I 
> am only asking about iowait at the moment :-).

Using your workload, I confirm inconsistent behaviour for /proc/stat
(which vmstat uses) between kernels 4.15, 4.16, and 4.17:
4.15 does what you expect, no matter idle states enabled or disabled.
4.16 doesn't do what you expect regardless. (although a little erratic.)
>= 4.17 does what you expect with only idle state 0 enabled, and doesn't otherwise.

Actual test data vmstat (/proc/stat) (8 CPUs, 12.5% = 1 CPU)):
Kernel	idle/iowait %	Idle states >= 1
4.15		88/12			enabled
4.15		88/12			disabled
4.16		99/1			enabled
4.16		99/1			disabled
4.17		98/2			enabled
4.17		88/12			disabled

Note 1: I never booted with "nohz=off" because the tick never turns off for
idle state 0, which is good enough for testing.

Note 2: Myself, I don't use /proc/stat for idle time statistics. I use:
/sys/devices/system/cpu/cpu*/cpuidle/state*/time
And they seem to always be consistent at the higher idle percentage number.

Unless someone has some insight, the next step is kernel bisection,
once for between kernel 4.15 and 4.16, then again between 4.16 and 4.17.
The second bisection might go faster with knowledge gained from the first.
Alan: Can you do kernel bisection? I can only do it starting maybe Friday.

... Doug


