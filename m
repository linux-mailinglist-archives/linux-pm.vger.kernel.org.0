Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD7E24787F
	for <lists+linux-pm@lfdr.de>; Mon, 17 Aug 2020 23:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgHQVGc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Aug 2020 17:06:32 -0400
Received: from cmta16.telus.net ([209.171.16.89]:55741 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbgHQVGa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Aug 2020 17:06:30 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id 7mKkkX3u85b7l7mKmkHbuV; Mon, 17 Aug 2020 15:06:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1597698387; bh=w1JQC+7BHe1UBg4sceDdsbCzHYwBzcssB/FvTOGriz4=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=rAS9sIp3vV52fD0nNxi+appewT7Nx1CJtgQGGLkOUGrnwyIqaD4EonvFtSh824zgK
         ypvBeJVOGYt8aoc1McGG1UYJDrfXMxa6xWLWVznjTUqofH6kNS878NbYZuYZ6l+rCV
         UJ9V7HofUwjOSrlaTVUczZIYSIDoBSigv4FUvQwfsJfVTh1kjf3k7SzwSl8qUg6woR
         usdwiskAGVRZsEUSALYCTcuvsgVBb4mbf+o+8zPeI59bckLnKxOonhK4sCBKW70lHQ
         JGKoAgDwQohr4aesbwKZ9Dr8ECk7XghPm7fOAScxBmZepgiNGPSsY0jL+O3SaqRGLA
         H3v6YF2ozKEbA==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=YPHhNiOx c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=8RpStYJGi7BMQs3j73kA:9
 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'Linux Documentation'" <linux-doc@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Francisco Jerez'" <francisco.jerez.plata@intel.com>,
        "'Viresh Kumar'" <viresh.kumar@linaro.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
References: <4981405.3kqTVLv5tO@kreacher> <1709487.Bxjb1zNRZM@kreacher> <3226770.pJcYkdRNc2@kreacher> <122847018.uQ7iJ9lzrg@kreacher>
In-Reply-To: <122847018.uQ7iJ9lzrg@kreacher>
Subject: RE: [PATCH v7] cpufreq: intel_pstate: Implement passive mode with HWP enabled
Date:   Mon, 17 Aug 2020 14:06:21 -0700
Message-ID: <000901d674da$4521bda0$cf6538e0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdZsF+Ny9o2RVgG1QuO4ZJYAcV1MWgIFjVRQ
X-CMAE-Envelope: MS4wfFySA2QGM8mG30cHRJd1Wj1kfqMD3F2zODxcj2cwjNO5a/+/SOT2UmVspNrVRiHzRGtJFha2e0jq+KzeCZHm20awAASAP2NRIa73VqlOfD5QPiqfZNgn
 iYNK+tfXZ3Kpz4gBfjVJOSL4GgB0+2pd1LmXGLMkAvcMvaZIKotHdVklR4+fiEDZaRS4PMdmGWgYtHo6ejl3+Rjui9IEc3CS39ZVjT0KzpAwyZKfClS26wAO
 AdrAbvV28Mhv0NWQH0Ta9x2TMH+aAy1Z0gnGjSlj4ooG9JxizfP9b+vE9MvfFbJ6zXehAkiQVP9H7ZV63h18VrQ75WCjtudOzNUkeME3pr48848GiFQXWX05
 g4zfmNN5FW5KeOZ5KkLHtXHi37uMWuGG3VOM+PIjAZhxAv20/SHNhEDF5871fxPlhylBXDRQMUQH8f2s7WT/hvfyTDgqWZPzf7m+Y1Kr1e5MEJmqTJs=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020.08.06 05:04 Rafael J. Wysocki wrote:

> Allow intel_pstate to work in the passive mode with HWP enabled and
> make it set the HWP minimum performance limit (HWP floor) to the
> P-state value given by the target frequency supplied by the cpufreq
> governor, so as to prevent the HWP algorithm and the CPU scheduler
> from working against each other, at least when the schedutil governor
> is in use, and update the intel_pstate documentation accordingly.

...

Hi Rafael,

You may or may not recall, I mentioned my further feedback would be
delayed, as I wanted to work on reducing the labour content of my
most basic CPU frequency scaler test.

I have tested kernel 5.9-rc1 for pretty much every intel_pstate
variant and governor, and also the acpi-cpufreq driver.

Other than changing governors, changes were only made via
grub command line options and re-boot. EPP or EPB were never
modified, they were always whatever default.

performance governor: (left mostly blank, on purpose.)
acpi-cpufreq:
intel_cpufreq hwp: good
intel_cpufreq no hwp:
intel_pstate hwp:
intel_pstate no hwp:

ondemand governor:
acpi-cpufreq: good
intel_cpufreq hwp: bad
intel_cpufreq no hwp: good

conservative governor:
acpi-cpufreq: good
intel_cpufreq hwp: good
intel_cpufreq no hwp: good

schedutil governor:
acpi-cpufreq: good
intel_cpufreq hwp: bad
intel_cpufreq no hwp: good

powersave governor:
acpi-cpufreq: good
intel_cpufreq hwp: bad
intel_cpufreq no hwp: good

active-powersave governor:
intel_pstate hwp: ? not smooth, suffers from the broken HWP issue.
intel_pstate no hwp: good.
Intel_pstate hwp, idle state 2 disabled: Better but still worse for power.

Now, we don't actually care about CPU frequency, we care about power:

ondemand governor:

periodic workflow at 347 hertz.
~58% load at 4.60 GHz (where hwp operates)
~76% load at 3.5 GHz (where no hwp operates)

intel_cpufreq hwp: 14.3 processor package watts. 51.5 watts on the mains to the computer.
intel_cpufreq no hwp: 9.1 processor package watts. 45.5 watts on the mains to the computer. 

schedutil governor:

periodic workflow at 347 hertz.
~36% load at 4.60 GHz (where hwp operates)
~55% load at 3.2 GHz (where no hwp operates)

intel_cpufreq hwp: 9.6 processor package watts. 45.8 watts on the mains to the computer.
intel_cpufreq no hwp: ~6 processor package watts. ~41 watts on the mains to the computer. (noisy)

powersave governor:

periodic workflow at 347 hertz.
~39.8% load at 2.00 GHz (where hwp operates)
~92.5% load at 0.8 GHz (where no hwp operates)

intel_cpufreq hwp: 2.6 processor package watts. 38 watts on the mains to the computer.
intel_cpufreq no hwp: 1.9 processor package watts. 36 watts on the mains to the computer.

active-powersave governor:

periodic workflow at 347 hertz.
~58% load at 4.60 GHz (where hwp operates)
~72% load at 3.88 GHz (where no hwp operates) 

intel_pstate hwp: 14.2 processor package watts. 52 watts on the mains to the computer.
intel_pstate no hwp: 10.1 processor package watts. 48 watts on the mains to the computer.

Link to web page with much of this same content which, in turn, links to various graphs.
Coded, to avoid the barrage of bots:

double u double u double u dot smythies dot com /~doug/linux/s18/hwp/v7/
 
... Doug


