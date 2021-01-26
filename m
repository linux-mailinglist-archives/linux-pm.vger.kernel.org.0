Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0EB9304E92
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jan 2021 02:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730903AbhA0Aj0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jan 2021 19:39:26 -0500
Received: from cmta19.telus.net ([209.171.16.92]:46512 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391641AbhAZTTu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 26 Jan 2021 14:19:50 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id 4Trel3otJxoDi4TrglPzmk; Tue, 26 Jan 2021 12:19:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1611688742; bh=mVM9TUNdviG2uJpy55sBZj2Z4GWPBhV/qVR7SteJZrE=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=en5TyZY5nVgwPuaBI5ISjA4UwzUGMzqqupeT7+nJwhTY0bbHDjyWCPSZQZZtjJbBB
         NnXTLL7W1ItMoajA/6WZX2XYTD21GiJirzWgZmD7bfycpPQcWGbKszqrp4TEe8mV2o
         xi59IZxHqOSTKWVw3ca1d5v6SWYFhW6sYrN6LLc0bcLviPewHhHCfNHRgGayV3XEnk
         KLP7h86ua43BveCS1Otykw1YvebCyeVXYSBxh8T64T0mXRzRUgmyrxVzig3AYGoICp
         32tEmy3JvfPhqxAsA9s70rpgOHPEQRryVyV5U/ZHe9I7FHgLvFtd+aLEC4YpRXqpa0
         4woloAvflAtMA==
X-Telus-Authed: none
X-Authority-Analysis: v=2.4 cv=ctJeL30i c=1 sm=1 tr=0 ts=60106b26
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=aatUQebYAAAA:8
 a=LH1_UpsVp2e2WysjbTMA:9 a=CjuIK1q_8ugA:10 a=7715FyvI7WU-l6oqrZBK:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Zhang Rui'" <rui.zhang@intel.com>
Cc:     <daniel.lezcano@linaro.org>, <srinivas.pandruvada@linux.intel.com>,
        <linux-pm@vger.kernel.org>
References: <20210115094744.21156-1-rui.zhang@intel.com> <002601d6ec2a$36663da0$a332b8e0$@net>
In-Reply-To: <002601d6ec2a$36663da0$a332b8e0$@net>
Subject: RE: [PATCH] thermal/intel: introduce tcc cooling driver
Date:   Tue, 26 Jan 2021 11:18:58 -0800
Message-ID: <000901d6f418$1a9b34e0$4fd19ea0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdbrIkJv3Xd49VUQTf+fLZID/bj4xQAuumUQAgxOuhA=
Content-Language: en-ca
X-CMAE-Envelope: MS4xfJLeEDMpyASR3PEpqfjkpwohw4zZuGXI6AosB1ds4TEsTY9YT+3u/EeD0JxKQ7bRjYj76/wlNcrsKGS18/9CRKUcAZaeGLFLeMAOQvSduYIs4xaPvxYb
 5emeJVFfBLvNPUaZGsNOfm3meaOlTcFrjyF1dWLzoCg8qgyVxFP7mJHGQRtJHpTAcr+3A3TG0l461x7rltM6qwOh2km4IXLWKYTQEeUfHU8mKjnJRtz2NcwK
 GjlAGowW1sq4N8IbSLKjfQL29No1pjoUgXjsWWJAAnzAVtU8jlHl2Yc9oK4DwDkppf6oK4NRL8qJ33El8s5lKQ==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi, Just a small follow up on this one:

On 2021.01.16 09:08 Doug Smythies wrote:
> On 2021.01.15 Zhang Rui wrote:
...
> Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt
> 67.93   3773    134577  43      54.78
> 
> For unknown reason the processor seems to now
> think it is not heavily loaded. From my MSR decoder:
> 
> 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 200020 AUTO AUTOL
> 
> From the book:
> 
> > Autonomous Utilization-Based Frequency Control
> > Status (R0)
> > When set, frequency is reduced below the operating
> > system request because the processor has detected
> > that utilization is low.
> 
> Which is not true.
> 
> Anyway,
> 
> Acked-by: Doug Smythies <dsmythies@telus.net>

O.K. there were 2 things wrong above:

1.) I used the wrong intel SDM table for those bit definitions.
They should have been: RATL and RATLL.

From the proper page of the book:

> Running Average Thermal Limit Status (R0)
> When set, frequency is reduced below the operating
> system request due to Running Average Thermal Limit
> (RATL).

2.) Due to the already discussed turbostat issue, that was not
the actual temperature and so the RATL bit being set was actually
valid at that time.

I have not been able to find the time window knob for this, if there
even is one, similar to the time window knobs for the package power limits.
I wanted to reduce the time constant, just as a test, in an attempt
to reduce the step function load potential temperature overshoot.

One additional informational follow up note:

There always seems to be a significant turn on transient to using the
TCC offset, appearing as temperature undershoot. I am saying that
an offset of 0 seems to also act as some sort of on/off switch to the
running average.

Example 1 - start with offset 0:

$ sudo ~/turbostat --Summary --quiet --show Busy%,Bzy_MHz,PkgTmp,PkgWatt,IRQ --interval 1
Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt
51.17   4600    3531    71      93.57
51.37   4600    3543    71      93.60
51.37   4600    3590    71      93.63  <<< offset changed from 0 to 24
50.99   3737    3566    52      43.49  <<< trip point = 76 degrees
51.20   3700    3550    51      41.14  <<< TCC offset turn on transient
51.09   3700    3559    51      41.30  <<< There was no need to throttle
51.12   3779    3515    53      43.78
50.95   4064    3553    58      55.57
51.55   4271    3522    63      65.30
51.18   4424    3534    67      76.58
51.27   4500    3532    68      84.12
51.14   4500    3529    68      84.14
51.24   4599    3522    71      93.61
51.14   4600    3523    71      93.71  <<< Eventually it does return to not throttled.

Example 2 - start with offset 1:

Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt
51.14   4600    3554    73      94.73
51.37   4600    3544    73      94.85
51.03   4600    3560    74      94.64 <<< offset changed from 1 to 24
51.33   4600    3508    73      94.88 <<< trip point = 76 degrees
51.14   4600    3526    73      94.69 <<< No TCC offset transient
51.22   4600    3614    73      94.85
51.24   4600    3531    73      94.84
51.50   4600    3578    73      94.92
51.15   4600    3571    73      94.77
51.20   4600    3521    73      94.91
51.19   4600    3550    73      94.76
51.27   4600    3522    74      94.81
51.27   4600    3530    74      94.98

... Doug


