Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B692D8FD0
	for <lists+linux-pm@lfdr.de>; Sun, 13 Dec 2020 20:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgLMTNU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Dec 2020 14:13:20 -0500
Received: from cmta16.telus.net ([209.171.16.89]:56639 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbgLMTNN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 13 Dec 2020 14:13:13 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id oWn2kPDi5BcKboWn3kTHAf; Sun, 13 Dec 2020 12:12:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1607886740; bh=YGnR28XRz6AIocs5zleYaD8ns2cZMsbrawYYQ3sxXVk=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=3/V2eNWZQKNBDDQgeg4o/qyQlOx+TkooJCJMOMXzAbNff8ukrfFLZXFoOVyDh4J/u
         Pg5++EjGzcploKPQIcX8bi8ePmUGFukCTeH18fkPimyNIAE6j/Kq00Oj5C+csJJHhL
         cpRvNq8MwtmoTf6K1VbuzzorjBek5ZZOs3yLOWfCUlzR7tU0PSs9/8rGEaTQRScCtD
         fuNdG0QfhifN1YRCGOlqOd/yiBbiJvbXoWm0oeMpdMhtmCOU8Cz9mO8/NQVdIZSjly
         EOq4QU4ABj6MwO8F7cxe7SCDVb3l0JMBwaY97ddPTnKmUeecm1ZVwiO9RUYDw97NCl
         j6tO0yDaWvQ0A==
X-Telus-Authed: none
X-Authority-Analysis: v=2.4 cv=Yd14Wydf c=1 sm=1 tr=0 ts=5fd66794
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=iox4zFpeAAAA:8
 a=anrKu3GmWIPttDA4td8A:9 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.com>
Cc:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Viresh Kumar'" <viresh.kumar@linaro.org>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>
References: <20360841.iInq7taT2Z@kreacher> <1607445035.2673.64.camel@suse.com> <CAJZ5v0j2u7MrO82+ubx01kvyhDUKo11mfyofF-TAqdSLx_i3Ng@mail.gmail.com> <001d01d6cd96$601c8a80$20559f80$@net>
In-Reply-To: <001d01d6cd96$601c8a80$20559f80$@net>
Subject: RE: [PATCH v1 0/4] cpufreq: Allow drivers to receive more information from the governor
Date:   Sun, 13 Dec 2020 11:12:15 -0800
Message-ID: <000401d6d183$e0f434f0$a2dc9ed0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdbNhYnI6l7ez4eQRjiDzyQ3pYiW9QABrdRQAPgdduA=
X-CMAE-Envelope: MS4xfPS6hOm3FlDTVK+dJm8EH9xwsZ5g3NbNlxOtw7QzjHpNgqgsChfKUBlYaU3mRc0FmBt1KOisr3VB2pEw03t4qoI+DA82Mzs8LtQkUGqHLhnKM4FbMaB1
 vopknAzpKsHgnrtqj7dS1XX/G5qdm1v/Vw8imncIDKmZtNBYtPMCAU44jjWsvBij1/IfeyEiDYCsqm7bRAQU0EC3/j+C8v3EI58cOHxp3hfQUBl5iQFAoubf
 ZxisRz53FEgaJVgmuRbOkmCGtjAgICkUMBWX+kVbIes+xUDRjqu3zqALktVZTHZ2lugLUjZu7FLbQGLlqbA9fO79dtPZRWZMoESxZacvdQRxStfZAJEuktLt
 1ImmWjsHsrUJsBKkHLrVHmYqhYQSfDn66ku4/jtaCOrf7O+p44cPNvGp4PvATxS8LjLdp1xTB5HRw/ji4jKu0hzP+c8cSQ==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020.12.08 11:15 Doug wrote:
> On 2020.12.08 09:14 Rafael J. Wysocki wrote:
> > On Tue, Dec 8, 2020 at 5:31 PM Giovanni Gherdovich <ggherdovich@suse.com> wrote:
> >> On Mon, 2020-12-07 at 17:25 +0100, Rafael J. Wysocki wrote:
> >> I'd like to test this patch, as I have concerns on how it performs against the
> >> current intel_pstate passive + HWP + schedutil (which leaves HWP.REQ.DESIRED
> >> untouched).
> >
> >The performance will be worse in some cases, which is to be expected,
> 
> Agreed. More further below.
> 
> >but the point here is to counter the problem that in some cases the
> >frequency is excessive now.
> 
> Agreed.
...
> 
> The "hwp" case is misleading. It is really bouncing around at about 0.2 hertz
> and can't seem to make up its mind. 


> If nothing else, all the other versions
> are a little more deterministic in their response.

Hmmm... I think that statement is backwards, for this particular
workflow. Read on.

> 
> >
> >> I'll get results within a week. Do you mind holding back the merge until then?
> 
> On my system that git "make test" is broken, so I can not do the high PIDs per second test that way.
> My own PIDs per second test also has issues on this computer.
> I am not sure when I'll get these type of tests working, but will try for within a week.

Geovanni: Previously you have reported run to run variability with the git "make test"
serialized single threaded workflow, with a new PID per task. Previously, I had attributed
the variability to disk I/O. For the schedutil governor, there is also a significant variability
in execution time within and around a frequency of 0.2 Hertz. Generally, it would tend to get
averaged out over the long execution time of the "make test".

I have completely re-done everything for my version (no disk I/O) of the PIDs per second test:

Preamble:

As mentioned previously, the issue with attempting to acquire useful debugging
information with the schedutil governor is that it is always so oscillatory.
Sampling processor package energy at too high a frequency and it just looks like
noise, sample at too low a frequency and any useful information is filtered out.
To make a long story shorter, a sample frequency of about 1 hertz, or a sample
period of about 1 second, was revealing. Event periods of between 5 and 35 seconds
are also supported by listening to the fan speed modulation on my test server.
A lot of intel_pstate_tracer.py utility trace data was acquired and reviewed, but
I am unable to make any sense out of it.

Data is presented using the teo idle governor, and a 1000 hertz kernel, but be aware
that the menu governor and a 250 Hertz kernel were also tried, but results not written
up. Data is presented for one set of conditions only, but be aware that all of the
PIDs per second space was searched for any specific anomalies. It is the same
everywhere (tested ~40 - ~3500 PIDs per second) (obviously at some low enough PIDs
per second, the differences will diminish) and the operating point of focus for
further dwell type testing was not cherry picked.

Operating point for the rest of the work:
Fixed work packet per task (PID):
~1780 PIDs per second, performance governor.
~ 308 PIDs per second, powersave governor.

Test computer: i5-9600K

Legend:

hwp: Kernel 5.10-rc6, HWP enabled; intel_cpufreq
rfc: Kernel 5.10-rc6 + this patch set, HWP enabled; intel_cpu-freq; schedutil
no-hwp: Kernel 5.10-rc6, HWP disabled; intel_cpu-freq
acpi: Kernel 5.10-rc6, HWP disabled; acpi-cpufreq; schedutil
patch: Kernel 5.10-rc7 + this patch set, HWP enabled; intel_cpu-freq; schedutil

Results:

Execution times (seconds. Less is better):

no-hwp:

conservative: Samples: 371  ; Average: 10.84296  ; Stand Deviation:  0.07160 ; Maximum: 11.09000 ; Minimum: 10.65000
ondemand: Samples: 342  ; Average: 11.76442  ; Stand Deviation:  0.02640 ; Maximum: 11.85000 ; Minimum: 11.71000
performance: Samples: 382  ; Average: 10.54450  ; Stand Deviation:  0.01564 ; Maximum: 10.61000 ; Minimum: 10.50000
powersave: Samples: 68  ; Average: 59.93897  ; Stand Deviation:  0.11697 ; Maximum: 60.19000 ; Minimum: 59.67000

schedutil: Samples: 293  ; Average: 13.73416  ; Stand Deviation:  0.73395 ; Maximum: 15.46000 ; Minimum: 11.68000
acpi: Samples: 253  ; Average: 15.94889  ; Stand Deviation:  1.28219 ; Maximum: 18.66000 ; Minimum: 12.04000

hwp:

conservative: Samples: 380  ; Average: 10.58518  ; Stand Deviation:  0.01562 ; Maximum: 10.64000 ; Minimum: 10.54000
ondemand: Samples: 380  ; Average: 10.58395  ; Stand Deviation:  0.01509 ; Maximum: 10.62000 ; Minimum: 10.54000
performance: Samples: 381  ; Average: 10.57871 ; Stand Deviation:  0.01870 ; Maximum: 10.63000 ; Minimum: 10.53000
powersave: Samples: 67  ; Average: 60.37075  ; Stand Deviation:  0.20095 ; Maximum: 60.81000 ; Minimum: 59.92000

schedutil: Samples: 380  ; Average: 10.58287  ; Stand Deviation:  0.01864 ; Maximum: 10.64000 ; Minimum: 10.54000
patch: Samples: 276  ; Average: 14.57029 ; Stand Deviation:  0.89771 ; Maximum: 16.04000 ; Minimum: 11.68000
rfc: Samples: 271  ; Average: 14.86037  ; Stand Deviation:  0.84164 ; Maximum: 16.04000 ; Minimum: 12.21000

Power (watts. More indicates higher CPU frequency and better performance. Sample time = 1 second.):

no-hwp:

conservative: Samples: 4000  ; Average: 23.60704  ; Stand Deviation:  1.09529 ; Maximum: 43.88623 ; Minimum: 18.32019
onemand: Samples: 4000  ; Average: 16.95654  ; Stand Deviation:  0.19147 ; Maximum: 17.60266 ; Minimum: 16.03534
performance: Samples: 4000  ; Average: 25.41355  ; Stand Deviation:  0.22156 ; Maximum: 26.01996 ; Minimum: 24.08807
powersave: Samples: 4000  ; Average:  1.93887  ; Stand Deviation:  0.06675 ; Maximum:  2.05737 ; Minimum:  1.26605

schedutil: Samples: 4000  ; Average: 12.58863  ; Stand Deviation:  5.48600 ; Maximum: 25.50934 ; Minimum:  7.54559
acpi: Samples: 4000  ; Average:  9.57924  ; Stand Deviation:  5.41157 ; Maximum: 25.06366 ; Minimum:  5.51129

hwp:

conservative: Samples: 4000  ; Average: 25.16285  ; Stand Deviation:  0.18960 ; Maximum: 25.85553 ; Minimum: 23.62634
ondemand: Samples: 4000  ; Average: 25.27046  ; Stand Deviation:  0.20764 ; Maximum: 25.89624 ; Minimum: 23.97101
performance: Samples: 4000  ; Average: 25.34541  ; Stand Deviation:  0.24076 ; Maximum: 26.01788 ; Minimum: 23.87823
powersave: Samples: 4000  ; Average:  1.90300  ; Stand Deviation:  0.09457 ; Maximum:  2.00519 ; Minimum:  1.27722

schedutil: Samples: 4000  ; Average: 25.24245  ; Stand Deviation:  0.19539 ; Maximum: 25.93671 ; Minimum: 24.14746
patch: Samples: 4000  ; Average: 11.07225  ; Stand Deviation:  5.63142 ; Maximum: 24.99493 ; Minimum:  3.67548
rfc: Samples: 4000  ; Average: 10.35842  ; Stand Deviation:  4.77915 ; Maximum: 24.95953 ; Minimum:  7.26202

Power histogram information is available for every test. For the schedutil governor, typically it reveals two
distributions. In linear time the average power will sometimes be high for a second and sometimes low
for multiple seconds, resulting in the high execution time variability as revealed by the standard deviation
numbers.

I also have mains power data, at 1 sample per second for an overnight run:
(Watts into the computer. ~ = 34 + processor package power).
Samples: 26674  ; Average: 50.39585  ; Stand Deviation:  8.63522 ; Maximum: 69.51000 ; Minimum: 35.30000
with peaks in the 42 and 62 watt regions.

Note 1: this is a never throttle scenario, not even close.
Note 2: this test computer never scales back CPU frequency as a function of active cores.
Note 3: sometimes maximum power includes an outlier data point or 2.
		Standard deviation is the important statistic.
		For example, no-hwp maximum power was really 25.8 watts, not 43.9.

Summary:

hwp enabled intel-cpufreq/schedutil was stable, with execution times comparable to other
governors before this patch set, but it is unstable with longer and variable execution
times after the patch set.

Conclusion:

Yes, the original hwp intel-cpufreq/schedutil (A.K.A intel-pstate passive mode, hwp enabled,
schedutil governor) does much better for this type of fixed work packet but variable period
workflow. However, isn't that the trade-off between fixed period fixed work packet workflow,
which improved considerably with this patch set?

After the patch set it does behave more like the other versions(no-hwp, acpi), which
I don't know if that is a good or bad thing.  As we all know, this type of workflow has
always been a challenge for governors.
   
... Doug

References:
None. 
My objective was to not need pretty graphs to support this e-mail.


