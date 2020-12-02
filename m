Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19912CC17C
	for <lists+linux-pm@lfdr.de>; Wed,  2 Dec 2020 17:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbgLBP7N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Dec 2020 10:59:13 -0500
Received: from cmta20.telus.net ([209.171.16.93]:38583 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbgLBP7N (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Dec 2020 10:59:13 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id kUWSk8U17wL1vkUWTkhgyv; Wed, 02 Dec 2020 08:58:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1606924711; bh=jJP91jaRt61fPYC5PwXm5tEumMc5oKgC4U365JX8rv0=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=MlX7QYwXeTF3CIH9E93wUXaOkfyVsMHQZ/K844pr/voYAd5mPqBF1cPbKhBSDAfbp
         E7+mWOhhTWZa5tMuVlpXf5W4b8ruKsV39CH+ozpWJdIWYe5A7H0vq9o8iuxPh9RTYC
         N7nY3ycx4Ok4QwoSgSHzajHYer4zGdOzU+oF9X+GltTYH4e0snMkkA3G3ATjdjUCPu
         c7OD92IYJGouq5n99+Rt/MlSGZYMuYsHmGMu3cHej0eZRoo3+YguWYXSfLTkzHoU2/
         C7dd7p6wV7fVj878PHdSWJiIupe2424zIUiviJiFsH+LKEv9TuPY2apAN27uQmBJmn
         hUQC7JcSwua3g==
X-Telus-Authed: none
X-Authority-Analysis: v=2.4 cv=cOElDnSN c=1 sm=1 tr=0 ts=5fc7b9a7
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=gu6fZOg2AAAA:8
 a=VtkuwAwbKsm-GJcCPiMA:9 a=CjuIK1q_8ugA:10 a=-FEs8UIgK8oA:10
 a=NWVoK91CQyQA:10 a=2RSlZUUhi9gRBrsHwhhZ:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Viresh Kumar'" <viresh.kumar@linaro.org>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.com>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
References: <1817571.2o5Kk4Ohv2@kreacher> <2174134.tL5yAn4CWt@kreacher>
In-Reply-To: <2174134.tL5yAn4CWt@kreacher>
Subject: RE: [RFC][PATCH 1/2] cpufreq: Add special-purpose fast-switching callback for drivers
Date:   Wed, 2 Dec 2020 07:58:26 -0800
Message-ID: <000901d6c8c3$fa8386f0$ef8a94d0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdbHSBgaza+E6qqTQN6h7OdbOaGzrwBdRQvg
X-CMAE-Envelope: MS4xfNwEOsWZO7NHxqLrAlPmhSEZkmUQxpEBa642tj5Y85mih8Pw6jdZMQkKEVMLuTbrOpZwr3g6NXtekolyff0m/FLoI/ZJbpArexuuXeJ4MN/BcIl5niGh
 vMvVnrn3+LWBORLuxkLM8W/w6OwXFvvPZHmsannqBHc6mvjc1OkcdJBT1Uf8Xj32+/hPfMpRWbPm0HhHEOuuIBdeYxcsxRfPFVKN5s8b5xsnOB0uraGInz+1
 fQ3m9TrxSSK55mFsbzMuuL2NjQBzLls+NC8ytjTknJxN8XB/NvWbiqAieflpPDyXdQWPJNzdsm4LW4Wpid6bB1zgFY0cu8Itrt+t27+vR8JZcWi7EKPVFsRW
 BMuysk9p7NQggqtebW7iD8klyOZkY+WZqlumXt2Sm7wWvnuD0Go=
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On 2020.11.30 10:37 Rafael J. Wysocki wrote:

> First off, some cpufreq drivers (eg. intel_pstate) can pass hints
> beyond the current target frequency to the hardware and there are no
> provisions for doing that in the cpufreq framework.  In particular,
> today the driver has to assume that it should allow the frequency to

Forgot the important "not":

today the driver has to assume that it should allow not the frequency to

> fall below the one requested by the governor (or the required capacity
> may not be provided) which may not be the case and which may lead to
> excessive energy usage in some scenarios.
> 
> Second, the hints passed by these drivers to the hardware neeed not

s/neeed/need

...

O.K. this is good.

The problem with my basic CPU frequency verses load test with the
schedutil governor is that it is always so oscillatory it is pretty
much not possible to conclude anything. So I re-worked the test
to look at Processor Package Power load instead.

In a previous e-mail [1] I had reported the power differences
for one periodic load at one frequency, as a (apparently cherry picked)
example. Quoted:

> schedutil governor:
> acpi-cpufreq: good
> intel_cpufreq hwp: bad    <<<<< Now good, with this patch set.
> intel_cpufreq no hwp: good
> ...
> periodic workflow at 347 hertz.
> ~36% load at 4.60 GHz (where hwp operates)
> ~55% load at 3.2 GHz (where no hwp operates)
>
> intel_cpufreq hwp: 9.6 processor package watts. 45.8 watts on the mains to the computer.
> intel_cpufreq no hwp: ~6 processor package watts. ~41 watts on the mains to the computer. (noisy)

So this time, I only have power/energy data, and a relatively easy way to compress all 12,000
samples into some concise summary is to simply find the average power for the entire experiment:

Legend:
hwp: Kernel 5.10-rc6, HWP enabled; intel_cpufreq; schedutil (always)
rjw: Kernel 5.10-rc6 + this patch set, HWP enabled; intel_cpu-freq; schedutil
no-hwp: Kernel 5.10-rc6, HWP disabled; intel_cpu-freq; schedutil
acpi-cpufreq: Kernel 5.10-rc6, HWP disabled; acpi-cpufreq; schedutil

load work/sleep frequency: 73 Hertz:
hwp: Average: 12.00822 watts
rjw: Average: 10.18089 watts
no-hwp: Average: 10.21947 watts
acpi-cpufreq: Average:  9.06585 watts

load work/sleep frequency: 113 Hertz:

hwp: Average: 12.01056
rjw: Average: 10.12303
no-hwp: Average: 10.08228
acpi-cpufreq: Average:  9.02215

load work/sleep frequency: 211 Hertz:

hwp: Average: 12.16067
rjw: Average: 10.24413
no-hwp: Average: 10.12463
acpi-cpufreq: Average:  9.19175

load work/sleep frequency: 347 Hertz:

hwp: Average: 12.34169
rjw: Average: 10.79980
no-hwp: Average: 10.57296
acpi-cpufreq: Average:  9.84709

load work/sleep frequency: 401 Hertz:

hwp: Average: 12.42562
rjw: Average: 11.12465
no-hwp: Average: 11.24203
acpi-cpufreq: Average: 10.78670

[1] https://marc.info/?l=linux-pm&m=159769839401767&w=2

My tests results graphs:
Note: I have to code the web site, or I get hammered by bots.
Note: it is .com only because it was less expensive than .org
73 Hertz:
Double u double u double u dot smythies dot .com/~doug/linux/s18/hwp/k510-rc6/su73/ 
113 Hertz:
Double u double u double u dot smythies dot .com/~doug/linux/s18/hwp/k510-rc6/su113/
211 Hertz:
Double u double u double u dot smythies dot .com/~doug/linux/s18/hwp/k510-rc6/su211/
347 Hertz:
Double u double u double u dot smythies dot .com/~doug/linux/s18/hwp/k510-rc6/su347/
401 Hertz:
Double u double u double u dot smythies dot .com/~doug/linux/s18/hwp/k510-rc6/su401/

... Doug



