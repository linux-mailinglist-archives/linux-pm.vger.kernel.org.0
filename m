Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9614DBF6C3
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2019 18:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfIZQbq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Sep 2019 12:31:46 -0400
Received: from cmta20.telus.net ([209.171.16.93]:47606 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfIZQbp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Sep 2019 12:31:45 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id DWg5iTjjsN5I9DWg6idREM; Thu, 26 Sep 2019 10:31:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1569515503; bh=ruzrGDpCey1oLCTz071JsbgxD25KGWsWXuxA3+QOk60=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=Xf8U2RMft1C414DHJd2LyXhd/OkdpP34jTrj0lzQCJIRMbL0QZ3WiJG+AviBoGpWM
         HLoVl7nzwQ6/O6x5NWenKeB+iIYADDw+hUqKv9V+/DyHLzxwQgfXybrcm8+h8NzAsB
         Kta/X1Z521EXipZRBrStg5vbrmdbh5Z6P4NL3r76yS8iWI9YEATlAooxzKJpN1L6/H
         CnlxJF8uHt5mf6tYE1ZfnSr4nVoP+8/eDorxqx3b+G6jTML/rdKmAYpxYA/WqLWxIG
         3UYY1Nvp6+W+g/2AerjShxrDowywkMokLNL308pFUsJHXzhpXi5dL/9s7vb+nXx5TT
         moykco6vWGnHw==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=K/Fc4BeI c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=RIbJcmsr_iJzxLSSOg0A:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
 a=RhuyYjO7tlwES4IY:21 a=Ulp3AgbovL3s6zND:21 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Frederic Weisbecker'" <frederic@kernel.org>,
        "'Mel Gorman'" <mgorman@suse.de>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Chen, Hu'" <hu1.chen@intel.com>,
        "'Quentin Perret'" <quentin.perret@arm.com>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>
References: WgXvgFd5aBdpLWgY0gWTga
In-Reply-To: WgXvgFd5aBdpLWgY0gWTga
Subject: RE: [RFC/RFT][PATCH v8] cpuidle: New timer events oriented governor for tickless systems
Date:   Thu, 26 Sep 2019 09:31:36 -0700
Message-ID: <001601d57487$e1029ef0$a307dcd0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdSRR6W+nknzDAweSJ6DmHc6MWYLQjjLqLuA
X-CMAE-Envelope: MS4wfKC8LEk+L2v3xXaTPRYMDRNcLYnGna25kYyYfnrrf0QDTcOY6wtCih/1R9Dd2XSxIeuqZ08yW22ccl/gxKQHst648vPX3Xa7Gg25npNJ5muH1XN3XqHi
 1mWl3FlLm22i8o3AQOd6k8jE2BFgbFXYh9s/c2ZZp572NFS65c5fb0XH8NNZFiQlHxaYd7jp/1/8Sj/WClawWCtInAGnHvJoEbzMZ5lBzND+I11k6RC0RtnT
 l66eQXj4fBz7PaLqgGKiXiSrHzZpbOt5iC4orlzxwUDLU0GVCxQqkMReEiWwhPyimGuTe4HYkheJYYlpbjGGNiDyBzNLRqZTi1ef+XVr6eTjgNEi7zOjYa1U
 /cL7e8+dMdLrbJJPzuEoK8jiIrnT1qCiPqCGm9o1Cve1IEozvwNLF1wPOonqzROWh1cMySdIRaV0yMpHQmXVDbcg9an/mn5bQnAqy3bzpgHZttiNl4a3su6E
 KdnN4UvUC6Of0Aw4OfM/MuNsxFdfCYRqA4ndjA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All,

Recall the extensive tests and work done between 2018.10.11 and 2019.01.16
on Rafael's teo governor, versions 1 through 11, noting that versions
9, 10, and 11 did not contain functional changes.

Hi Rafael,

If the deepest idle state is disabled, the system
can become somewhat unstable, with anywhere between no problem
at all, to the occasional temporary jump using a lot more
power for a few seconds, to a permanent jump using a lot more
power continuously. I have been unable to isolate the exact
test load conditions under which this will occur. However,
temporarily disabling and then enabling other idle states
seems to make for a somewhat repeatable test. It is important
to note that the issue occurs with only ever disabling the deepest
idle state, just not reliably.

I want to know how you want to proceed before I do a bunch of
regression testing.

On 2018.12.11 03:50 Rafael J. Wysocki wrote:

> v7 -> v8:
>  * Apply the selection rules to the idle deepest state as well as to
>    the shallower ones (the deepest idle state was treated differently
>    before by mistake).
>  * Subtract 1/2 of the exit latency from the measured idle duration
>    in teo_update() (instead of subtracting the entire exit latency).
>    This makes the idle state selection be slightly more performance-
>   oriented.

I have isolated the issue to a subset of the v7 to v8 changes, however
it was not the exit latency changes.

The partial revert to V7 changes I made were (on top of 5.3):

diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index 7d05efd..d2892bb 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -283,9 +283,28 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
                if (idx < 0)
                        idx = i; /* first enabled state */

-               if (s->target_residency > duration_us)
-                       break;
+               if (s->target_residency > duration_us) {
+                       /*
+                        * If the "hits" metric of the state matching the sleep
+                        * length is greater than its "misses" metric, that is
+                        * the one to use.
+                        */
+                       if (cpu_data->states[idx].hits > cpu_data->states[idx].misses)
+                               break;

+                       /*
+                        * It is more likely that one of the shallower states
+                        * will match the idle duration measured after wakeup,
+                        * so take the one with the maximum "early hits" metric,
+                        * but if that cannot be determined, just use the state
+                        * selected so far.
+                        */
+                       if (max_early_idx >= 0) {
+                               idx = max_early_idx;
+                               duration_us = drv->states[idx].target_residency;
+                       }
+                       break;
+               }
                if (s->exit_latency > latency_req) {
                        /*
                         * If we break out of the loop for latency reasons, use
@@ -294,7 +313,7 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
                         * as long as that target residency is low enough.
                         */
                        duration_us = drv->states[idx].target_residency;
-                       goto refine;
+                       break;
                }

                idx = i;
@@ -307,21 +326,6 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
                }
        }

-       /*
-        * If the "hits" metric of the idle state matching the sleep length is
-        * greater than its "misses" metric, that is the one to use.  Otherwise,
-        * it is more likely that one of the shallower states will match the
-        * idle duration observed after wakeup, so take the one with the maximum
-        * "early hits" metric, but if that cannot be determined, just use the
-        * state selected so far.
-        */
-       if (cpu_data->states[idx].hits <= cpu_data->states[idx].misses &&
-           max_early_idx >= 0) {
-               idx = max_early_idx;
-               duration_us = drv->states[idx].target_residency;
-       }
-
-refine:
        if (idx < 0) {
                idx = 0; /* No states enabled. Must use 0. */
        } else if (idx > 0) {

Test results (note: I use my own monitoring utility, because it feeds my
graphing/html utility, but have used turbostat here in case others
want to repeat the test):

Processor: i7-2600K
Deepest idle state: 4 (C6)
The system is mostly idle for these tests.
turbostat command used:

sudo turbostat --Summary --quiet --hide
IRQ,Avg_MHz,SMI,GFXMHz,TSC_MHz,GFXWatt,CorWatt,CPU%c1,CPU%c7,CoreTmp,GFX%rc6,Pkg%pc2,Pkg%pc3,Pkg%pc6,C1,C1E,,C1%,C1E%,C3%,C6%
--interval 3

Only because it works so reliably, the test involves disabling all idle states
deeper than 0, then enabling all idle states shallower than the deepest.

I have attempted to minimize the number of display columns,
hopefully without hiding useful information.

Kernel 5.3:

Busy%   Bzy_MHz POLL    C3      C6      POLL%   CPU%c3  CPU%c6  PkgTmp  PkgWatt
0.04    1600    0       0       232     0.00    0.00    99.85   28      3.73
0.05    1600    0       3       254     0.00    0.00    99.82   28      3.73
0.04    1600    0       1       264     0.00    0.00    99.82   30      3.73
61.08   3493    14735   16      258     60.84   0.04    38.57   45      31.00
100.00  3500    24057   0       0       99.88   0.00    0.00    46      48.73
100.00  3500    24064   0       0       99.86   0.00    0.00    48      48.87
100.00  3500    24057   0       0       99.88   0.00    0.00    49      49.07
100.00  3500    24070   0       0       99.87   0.00    0.00    50      49.21
100.00  3500    24068   0       0       99.87   0.00    0.00    50      49.29
100.00  3500    24063   0       0       99.88   0.00    0.00    52      49.42
100.00  3500    24060   0       0       99.87   0.00    0.00    53      49.58
100.00  3500    24076   0       0       99.87   0.00    0.00    53      49.70
100.00  3500    24067   0       0       99.87   0.00    0.00    55      49.77
28.89   3575    15138   261     0       28.71   59.97   0.00    48      27.93
10.52   3666    11884   379     0       10.43   75.24   0.00    47      20.72
10.80   3680    12141   558     0       10.65   75.13   0.00    46      21.11
11.51   3742    13016   217     0       11.43   74.93   0.00    47      22.48
10.84   3696    12254   294     0       10.76   74.89   0.00    48      21.26
10.34   3652    11683   243     0       10.25   74.93   0.00    47      20.36
10.67   3681    12065   240     0       10.59   74.94   0.00    48      20.96
10.68   3671    12067   278     0       10.59   74.92   0.00    47      20.85
10.84   3690    12259   236     0       10.76   74.94   0.00    47      21.24
11.51   3735    13023   265     0       11.43   74.93   0.00    48      22.43

Notice how once idle state 3 is enabled again (as were states 1 and 2) and  we
should be at about 5 watts, there is still a ton of time spent in idle state
0 (POLL).

Kernel 5.3 + above patch:

Busy%   Bzy_MHz POLL    C3      C6      POLL%   CPU%c3  CPU%c6  PkgTmp  PkgWatt
0.04    1600    0       3       235     0.00    0.00    99.82   26      3.71
0.04    1600    0       1       252     0.00    0.00    99.79   26      3.71
0.05    1600    0       3       273     0.00    0.00    99.79   26      3.72
0.04    1600    0       3       224     0.00    0.00    99.83   26      3.71
0.05    1600    0       1       252     0.00    0.00    99.81   25      3.71
0.04    1600    0       1       231     0.00    0.00    99.84   26      3.71
0.05    1600    0       3       294     0.00    0.00    99.77   28      3.71
0.04    1600    0       2       259     0.00    0.00    99.81   25      3.70
69.61   3490    16773   15      326     69.33   0.14    29.98   42      34.41
100.00  3500    24079   0       0       99.88   0.00    0.00    45      48.27
100.00  3500    24062   0       0       99.89   0.00    0.00    45      48.41
100.00  3500    24056   0       0       99.88   0.00    0.00    46      48.52
100.00  3500    24064   0       0       99.89   0.00    0.00    47      48.63
27.31   3498    6588    340     0       27.16   72.40   0.00    32      17.13
0.03    1600    1       230     0       0.00    99.91   0.00    30      5.08
0.03    1600    2       234     0       0.00    99.90   0.00    31      5.07
0.03    1600    5       238     0       0.00    99.91   0.00    30      5.07
0.03    1600    3       230     0       0.00    99.91   0.00    30      5.05
0.03    1600    3       246     0       0.00    99.91   0.00    29      5.05
0.03    1600    3       235     0       0.00    99.90   0.00    30      5.04

Notice how once idle state 3 is enabled again (as were states 1 and 2) almost
all time is spent there, as expected, and the power is the expected 5 watts.

... Doug


