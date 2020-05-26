Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFAF1E2609
	for <lists+linux-pm@lfdr.de>; Tue, 26 May 2020 17:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgEZPvy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 May 2020 11:51:54 -0400
Received: from cmta18.telus.net ([209.171.16.91]:48810 "EHLO cmta18.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728107AbgEZPvx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 26 May 2020 11:51:53 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id dbrojbJ6MVEJfdbrpjmJc2; Tue, 26 May 2020 09:51:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1590508312; bh=rvRTnl21xY1bE06cPy+n/6GL8pvu7dqzkWh0KRXTCgw=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=IcILxIPHyQAqBA07zd26fJ+SDdIIIj8H3VFVte0eoS0OrZy3eENxW5kgl2k6niPwa
         2ODrLMBAWdYlg18hgOi0JBLulhkBTnC7egAoIKtBqVFqOeFRj+TmrQsa1Rl/5kXfOa
         4YdKP0xiOvHZSlxc7wTeZ2Q6lyY2hFrJWae7gRSHA5uxOPJCCcAF4pOXUJ52VqcY65
         vE8q3WQvJRBQrqxJIhNU0MoGHMNzkgbNKHrLi0hlpQCBcDHgY3OyWmtJopGKu3WgrS
         zv5neatDZgJX1+qN1vagQy74385B3RHHi/nR4J/rYJzpunamTbUvXBr9EFAOfh555U
         CHfvuoVrSg4sg==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=KIck82No c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8
 a=FGbulvE0AAAA:8 a=TkEsygaeObAnKy-4MokA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=svzTaB3SJmTkU8mK-ULk:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        "'Francisco Jerez'" <francisco.jerez.plata@intel.com>
Cc:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Len Brown'" <len.brown@intel.com>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>
References: <3169564.ZRsPWhXyMD@kreacher> <87mu5wre1v.fsf@intel.com> <CAJZ5v0hBiKdDQJjdcuV72+3jCOZPNekmGxdtod-f9Sgwc_7D+g@mail.gmail.com> <87a71vraus.fsf@intel.com> <CAJZ5v0j4EYLej+Xb=huAGTDEH_0mgRShBkjBeib38exmss60Sg@mail.gmail.com>
In-Reply-To: <CAJZ5v0j4EYLej+Xb=huAGTDEH_0mgRShBkjBeib38exmss60Sg@mail.gmail.com>
Subject: RE: [RFC/RFT][PATCH] cpufreq: intel_pstate: Work in passive mode with HWP enabled
Date:   Tue, 26 May 2020 08:51:48 -0700
Message-ID: <000801d63375$927946a0$b76bd3e0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdYzNmRr0lgQYeCwTpGIV0wU6iZXRgALoz3Q
X-CMAE-Envelope: MS4wfMXTJ9StKBHKi6NbuF8/H5aacLAutS9AAM/3BjdeZfjwAlD/+YO/yGGP1H3zVmSzO7IFG/3Q2XG7cKpE1iidsZZxyNw9twBAInuOYvh8+jE1casRbEXD
 2j34mVbcsyng5C4XT6H39bJFgCkXrBQYfr0hfCThpAIoLBdQr1GL7UZxz7J1dwqYLpDqwnBtlpsnATkArCROEyUOGlSZ3PqLxt0LwEo3uq2vvz2blYtNqqYm
 B0pNpQHb5mnAUMjk/D65zmzWteteEYDTMaaS8CMHGRMDVtTCfWNS6/KLz3xYhk0jlvOTh74iDd5umB9ArCtM0Rgt64SeMzcfSGu5CGk7iFGQTMgogFOWzTpi
 mgSpO2eUhIunqU8aS9kRCYnGTELQeCXgByqdKgsjPDzog95SWUGjvW0Qmb4Yd1R3FLrXXa0c3Iy8BI38twSYid8REDx2E2oIs3qiKCzLcNe1JtBxtL0=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020.05.26 01:19 Rafael J. Wysocki wrote:
>  to On Mon, May 25, 2020 at 10:57 PM Francisco Jerez
> > "Rafael J. Wysocki" <rafael@kernel.org> writes:
> > > On Mon, May 25, 2020 at 3:39 AM Francisco Jerez
> >
> > Why not HWP_MIN_PERF?  That would leave the HWP quite some room for
> > maneuvering (the whole HWP_MIN_PERF-HWP_MAX_PERF P-state range, it's not
> > like P-state selection would be entirely driven by the kernel), while
> > avoiding every failure scenario I was describing in my previous reply.

I have re-done my tests.
The problem that I observe seems specific to hwp itself
and not this patch and it's use in passive mode.
I see the exact same thing with intel_pstate/powersave.
[1] detail A.


Test: still simple single threaded load sweep,
at 347 hertz work/sleep frequency.
What do I see?

Unexpected frequency drops at around 70% load.
Example, from trace:

First, the thing has been going for awhile at 4.8 GHz.

Old epp ; new epp ; freq GHz; load % ; duration mS
80	  ; 82      ; 4.57    ; 61.94  ; 20.001
82      ; 80	; 4.57    ; 62.47  ; 40.003
80      ; 44      ; 3.73    ;	68.63  ; 62.009  <<<< What? Why freq down? Why long duration?
44      ;  0      ; 1.96    ; 100.23 ; 19.995  <<<< Even lower freq. load overruns.
 0      ; 73      ; 4.56    ; 82.93  ; 40.07   <<<< O.K. recovered, but damage done.
73      ; 46      ; 2.36    ;	79.19  ; 20.94   <<< now things oscillate a little.
46      ; 0       ; 1.9884  ;	100.24 ; 20.99
 0      ; 75      ; 4.5624  ;	82.1   ; 41.002  <<< Event ends. Next event in 487 milliseconds.

Observation: Events are often, but not always, preceded by a longer than normal duration.
However, long durations are also not out of the ordinary in passive mode.

And yes, the above trace was with DELAY_HWP 20,000, but I do have trace examples
with it at 5,000. This was just a particularly good example.

Observation (from looking at a lot of trace data): There are phase delays
between the two systems, intel_cpufreq and hwp, and sometimes they seem to
oscillate a little and fight each other. There maybe some problematic
work/sleep frequencies where the oscillation builds into a full blown
resonance. 
 
Why does hwp drop the frequency?

This system is otherwise fairly idle,
so maybe because the pll drops down during the non work periods.

Maybe HWP thinks the system is idle and drops the frequency.
I can eliminate the overruns by disabling deep idle states such
that the PLL vote is never relinquished, but it's not a fair test.

Note that the above response can be "tuned".
If we take the conversation algorithm from target frequency to EPP
and introduce and offset, the above can be improved.

At what cost? More sluggishness, for a large positive offset.
So, the overruns just move from the steady state side of the task to
when the task starts. I did not find if there is a "sweet spot"
between offset and system response, and I do not think there is value
added in trying.

Note: With original settings, I rarely observe a problem with the step
function response to a new task.

> 
> Actually, I have been thinking about the HWP min as an alternative
> that may be worth evaluating.
> 
> However, I would rather set the HWP min to something like 80% if the
> cpufreq request.

Yes, this is a good idea and should not suffer from the two servo systems
fighting each other.

I got 0 overruns, verses 2240 overruns with no min limitation (100 second test).

As for INTEL_CPUFREQ_TRANSITION_DELAY_HWP, I'll probably use
10 milliseconds moving forward, because that is what I am most
familiar with from years ago work on the this driver. But, I did
not observe any issue with 5 milliseconds.

[1] http://www.smythies.com/~doug/linux/intel_pstate/passive-hwp/passive-hwp-but-active-powersave.png

Other replaced graphs:

http://www.smythies.com/~doug/linux/intel_pstate/passive-hwp/passive-hwp-ondemand.png
http://www.smythies.com/~doug/linux/intel_pstate/passive-hwp/passive-hwp-schedutil.png
 
... Doug


