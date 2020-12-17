Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D222DD423
	for <lists+linux-pm@lfdr.de>; Thu, 17 Dec 2020 16:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgLQP1g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Dec 2020 10:27:36 -0500
Received: from cmta19.telus.net ([209.171.16.92]:46044 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgLQP1f (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 17 Dec 2020 10:27:35 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id pvB3kJJksc2CmpvB5kByfT; Thu, 17 Dec 2020 08:26:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1608218814; bh=gn1Ozcf+oE/XsOrDMBv0LVfF/+YtnXFYm4e/X6F1zAw=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=1qsfysUuhVWf/4b6YiFVsos2QN83/rLyLZ0dw0Tob3fuuRZL+1FLY+wo/SIuVdQRF
         cRigyjTy6oJ3LX36STCR7g2uBws7pO/fONnf8DH03OzasCFlf+n8+9L5bm04DtOmyN
         C4uNcfoChj2vO7TBd2AyBQ/ngH/DDlxGqOt0XB81PXummEs7apU08dSKfwsbPL88/c
         iaOGWGz2EXJXjPPRXnJTgO/LQAceK8aSN8YsAMHunwHEqqCx07KQwKwU5iz6AbJeK+
         XAfxm9rzekxEGsObLkKY53Cc/NrWI7eA5/7gLV4SGl3SJ3ifCzToh3yMchqjP5At6s
         wPFwhdOkajLfQ==
X-Telus-Authed: none
X-Authority-Analysis: v=2.4 cv=NMEQR22g c=1 sm=1 tr=0 ts=5fdb78be
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=8MYkT9o3-EtoCmCZqnsA:9
 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Viresh Kumar'" <viresh.kumar@linaro.org>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.com>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
References: <20360841.iInq7taT2Z@kreacher> <3827230.0GnL3RTcl1@kreacher>
In-Reply-To: <3827230.0GnL3RTcl1@kreacher>
Subject: RE: [PATCH v2 0/3] cpufreq: Allow drivers to receive more information from the governor
Date:   Thu, 17 Dec 2020 07:26:49 -0800
Message-ID: <000901d6d489$0c26dd50$247497f0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdbSVRA1dBdX0amaSX+eUEzc0wtxAAAF+Myg
X-CMAE-Envelope: MS4xfGMNTiXTXTj89gw47y4v0BflAT2x3pkJKtIlYplihKOM21/ediYlkECoDDERqDUTsKlfLXZ54a4BgYvlaYdn1lYRJ/CggHJsRXnE793CaCoiExApGz92
 CRdZZxItuloaqyKtG68ZcsBuUj0uS0ZRRdxHo5Rfva/RFcyEXKMmIymzf4HwKPL70Lv6o9k+0ebJzQ4Mdt25oKhPxX77uOhm16tuhmCyD8lcxoY3Rs8n/+ws
 DHUwkr1Hc9NeFJgBocdu/I1Vq3xsE8JKWK80ACsBuYtxeJFRwqePNoG3nxH9mQLPN8yYNlA0k4pRLi6f1ftlfH6ZvshB5qnm/6rGPpMdVwqQPWf6o5G3UZ+q
 rSuzb0zqa/rjItHZ1cZ/JrnLsajFWVdGewlFJKUBHyIkiLhMhno=
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020.12.14 12:02 Rafael J. Wysocki wrote:

> Hi,

Hi Rafael,

V2 test results below are new, other results are partially re-stated:

For readers that do not want to read on, I didn't find anything different than with
the other versions. This was more just due diligence.

Legend:

hwp: Kernel 5.10-rc6, HWP enabled; intel_cpufreq
rfc (or rjw): Kernel 5.10-rc6 + this patch set, HWP enabled; intel_cpu-freq; schedutil
no-hwp: Kernel 5.10-rc6, HWP disabled; intel_cpu-freq
acpi (or acpi-cpufreq): Kernel 5.10-rc6, HWP disabled; acpi-cpufreq; schedutil
patch: Kernel 5.10-rc7 + V1 patch set, HWP enabled; intel_cpu-freq; schedutil
v2: Kernel 5.10-rc7 + V2 patch set, HWP enabled; intel_cpu-freq; schedutil

Fixed work packet, fixed period, periodic workflow, load sweep up/down:

load work/sleep frequency: 73 Hertz:

hwp: Average: 12.00822 watts
rjw: Average: 10.18089 watts
no-hwp: Average: 10.21947 watts
acpi-cpufreq: Average:  9.06585 watts
patch: Average: 10.26060 watts
v2: Average: 10.50444

load work/sleep frequency: 113 Hertz:

hwp: Average: 12.01056
rjw: Average: 10.12303
no-hwp: Average: 10.08228
acpi-cpufreq: Average:  9.02215
patch: Average: 10.27055
v2: Average: 10.31097

load work/sleep frequency: 211 Hertz:

hwp: Average: 12.16067
rjw: Average: 10.24413
no-hwp: Average: 10.12463
acpi-cpufreq: Average:  9.19175
patch: Average: 10.33000
v2: Average: 10.39811

load work/sleep frequency: 347 Hertz:

hwp: Average: 12.34169
rjw: Average: 10.79980
no-hwp: Average: 10.57296
acpi-cpufreq: Average:  9.84709
patch: Average: 10.67029
v2: Average: 10.93143

load work/sleep frequency: 401 Hertz:

hwp: Average: 12.42562
rjw: Average: 11.12465
no-hwp: Average: 11.24203
acpi-cpufreq: Average: 10.78670
patch: Average: 10.94514
v2: Average: 11.50324


Serialized single threaded via PIDs per second method:
A.K.A fixed work packet, variable period
Results:

Execution times (seconds. Less is better):

no-hwp:

performance: Samples: 382  ; Average: 10.54450  ; Stand Deviation:  0.01564 ; Maximum: 10.61000 ; Minimum: 10.50000

schedutil: Samples: 293  ; Average: 13.73416  ; Stand Deviation:  0.73395 ; Maximum: 15.46000 ; Minimum: 11.68000
acpi: Samples: 253  ; Average: 15.94889  ; Stand Deviation:  1.28219 ; Maximum: 18.66000 ; Minimum: 12.04000

hwp:

schedutil: Samples: 380  ; Average: 10.58287  ; Stand Deviation:  0.01864 ; Maximum: 10.64000 ; Minimum: 10.54000
patch: Samples: 276  ; Average: 14.57029 ; Stand Deviation:  0.89771 ; Maximum: 16.04000 ; Minimum: 11.68000
rfc: Samples: 271  ; Average: 14.86037  ; Stand Deviation:  0.84164 ; Maximum: 16.04000 ; Minimum: 12.21000
v2: Samples: 274  ; Average: 14.67978  ; Stand Deviation:  1.03378 ; Maximum: 16.07000 ; Minimum: 11.43000

Power (watts. More indicates higher CPU frequency and better performance. Sample time = 1 second.):

no-hwp:

performance: Samples: 4000  ; Average: 25.41355  ; Stand Deviation:  0.22156 ; Maximum: 26.01996 ; Minimum: 24.08807

schedutil: Samples: 4000  ; Average: 12.58863  ; Stand Deviation:  5.48600 ; Maximum: 25.50934 ; Minimum:  7.54559
acpi: Samples: 4000  ; Average:  9.57924  ; Stand Deviation:  5.41157 ; Maximum: 25.06366 ; Minimum:  5.51129

hwp:

schedutil: Samples: 4000  ; Average: 25.24245  ; Stand Deviation:  0.19539 ; Maximum: 25.93671 ; Minimum: 24.14746
patch: Samples: 4000  ; Average: 11.07225  ; Stand Deviation:  5.63142 ; Maximum: 24.99493 ; Minimum:  3.67548
rfc: Samples: 4000  ; Average: 10.35842  ; Stand Deviation:  4.77915 ; Maximum: 24.95953 ; Minimum:  7.26202
v2: Samples: 4000  ; Average: 10.98284  ; Stand Deviation:  5.48859 ; Maximum: 25.76331 ; Minimum:  7.53790


