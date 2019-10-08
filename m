Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A08ECF2AB
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2019 08:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbfJHGUs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Oct 2019 02:20:48 -0400
Received: from cmta17.telus.net ([209.171.16.90]:50900 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729926AbfJHGUq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Oct 2019 02:20:46 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id HirOiQQ9dbg38HirQiboHh; Tue, 08 Oct 2019 00:20:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1570515644; bh=2P6mXez37j9fBdL0Ncl4XJZYmaJobuXHxg4xcKxhvd0=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=YGFrcPqOk2h9+HY5vVYe030T4Fk+rDOPUd0Sso3nBTdNy7efQGWwvUGOe9GXO/4qC
         36XzwX0/S/KfgrThWTN1T4GwygpszTuURjZpPnC/qOqYBb3u6QuTrc7tB9iSmNIGy/
         te/m3Jt1LJTrguRMhmMTqVPfg0fQhKhrJzsG4gVDmL5rhbiyGDOQYMKBKtMCL5YJRF
         TCVpg21491CKdpSO1gcF3wqHpnH/FOHLQNMrR3TFvZnrwGcD9m6R6Pfa0nRuGmAKan
         rwMFBNbwwS3wdP/fXFYfH8C3q4BHkcDHC8B6d9sj7HHn1HgnHaVeS46zgQgfo7A3Ym
         G+A93Zgj2Ie3A==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=O/1HQy1W c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=aatUQebYAAAA:8 a=fr69Sb5xUs4nFW0D-I0A:9
 a=aMOKKf1XJ0u5yb9e:21 a=Ni0zgo4QtVMXVrbw:21 a=QEXdDO2ut3YA:10
 a=7715FyvI7WU-l6oqrZBK:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Frederic Weisbecker'" <frederic@kernel.org>,
        "'Mel Gorman'" <mgorman@suse.de>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Chen, Hu'" <hu1.chen@intel.com>,
        "'Quentin Perret'" <quentin.perret@arm.com>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>
References: <001601d57487$e1029ef0$a307dcd0$@net> <000f01d576df$a6b87a30$f4296e90$@net> <CAJZ5v0gu=rALS9ZLNMDT3cw_sT2m8XCKP6+AW3488x2Q9EXM3g@mail.gmail.com> <000001d57c54$db31f8c0$9195ea40$@net> <CAJZ5v0jo-KQouuE3P51THvU33kViBVtDq1WknBFx+FWUY0e=ag@mail.gmail.com>
In-Reply-To: <CAJZ5v0jo-KQouuE3P51THvU33kViBVtDq1WknBFx+FWUY0e=ag@mail.gmail.com>
Subject: RE: [RFC/RFT][PATCH v8] cpuidle: New timer events oriented governor for tickless systems
Date:   Mon, 7 Oct 2019 23:20:38 -0700
Message-ID: <000d01d57da0$8410f1c0$8c32d540$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdV8W4o2l8nEZTCwSdesKPyubuLfKQBQfELw
X-CMAE-Envelope: MS4wfDOF5X3abzQ968ueihfwD33xGr5m4KG28aeiJS3EjaQNORdv7BL/mOlVEO3pS2hJo+DiAsC1mjGaUcA8+OiIinxbN4x0u+ZOcvcE0q4KXt1SWA1d5/y+
 iBQ/t5RDFjzA0GIdFEpgZozadiMBLDN3266EL38QD5Mme7R2DEaHF5rlg3le5qw+UuOr3Lr3gz0+IKtTVXs3RaMwW4Fh8OzKnVQoRRoXE6mxUVJGrFlAvPT+
 v2fELURZlwduvPhY1tZSw0Urh4qNRJd7aRY0r2hD2ZD26U/bM8ZM97fkEaTJZ6y9l/xNbm46ncvkH82cX1JznbR9MxdSlcqH2FLGG7woo2Uv8jIs+hlRe0nh
 /Mc2yy/PfIxT0eNXOH7oZT1hAXa7ZHa1sONYKE/Qf7efJglEpDH3CKqbCPBASOU5HuBF1SDA+A++6+KnqBpW+0XK9IDrQEM8b/Bgn/RPt0Dd9AZo1JVtl8OZ
 6/4Mc7wIqCOAzYnWwWXJMcM0GFZhRU3Kl3Qx20SL1olJW8+l+4m1ebMJQtUyrrKzVMtHnsUaPXCzIv1D
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019.10.06 08:34 Rafael J. Wysocki wrote:
> On Sun, Oct 6, 2019 at 4:46 PM Doug Smythies <dsmythies@telus.net> wrote:
>> On 2019.10.01 02:32 Rafael J. Wysocki wrote:
>>> On Sun, Sep 29, 2019 at 6:05 PM Doug Smythies <dsmythies@telus.net> wrote:
>>>> On 2019.09.26 09:32 Doug Smythies wrote:
>>>>
>>>>> If the deepest idle state is disabled, the system
>>>>> can become somewhat unstable, with anywhere between no problem
>>>>> at all, to the occasional temporary jump using a lot more
>>>>> power for a few seconds, to a permanent jump using a lot more
>>>>> power continuously. I have been unable to isolate the exact
>>>>> test load conditions under which this will occur. However,
>>>>> temporarily disabling and then enabling other idle states
>>>>> seems to make for a somewhat repeatable test. It is important
>>>>> to note that the issue occurs with only ever disabling the deepest
>>>>> idle state, just not reliably.
>>>>>
>>>>> I want to know how you want to proceed before I do a bunch of
>>>>> regression testing.
>>>>
>> I do not think I stated it clearly before: The problem here is that some CPUs
>> seem to get stuck in idle state 0, and when they do power consumption spikes,
>> often by several hundred % and often indefinitely.
>
> That indeed has not been clear to me, thanks for the clarification!

>
>> I made a hack job automated test:
>> Kernel  tests  	         fail rate
>> 5.4-rc1		  6616           13.45%
>> 5.3              2376            4.50%
>> 5.3-teov7       12136            0.00%  <<< teo.c reverted and teov7 put in its place.
>> 5.4-rc1-ds      11168        0.00%  <<< [old] proposed patch (> 7 hours test time)


   5.4-rc1-ds12	  4224		0.005 <<< new proposed patch

>>
>> [old] Proposed patch (on top of kernel 5.4-rc1): [deleted]

> This change may cause the deepest state to be selected even if its
> "hits" metric is less than the "misses" one AFAICS, in which case the
> max_early_index state should be selected instead.
> 
> It looks like the max_early_index computation is broken when the
> deepest state is disabled.

O.K. Thanks for your quick reply, and insight.

I think long durations always need to be counted, but currently if
the deepest idle state is disabled, they are not.
How about this?:
(test results added above, more tests pending if this might be a path forward.)

diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index b5a0e49..a970d2c 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -155,10 +155,12 @@ static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)

                cpu_data->states[i].early_hits -= early_hits >> DECAY_SHIFT;

-               if (drv->states[i].target_residency <= sleep_length_us) {
-                       idx_timer = i;
-                       if (drv->states[i].target_residency <= measured_us)
-                               idx_hit = i;
+               if (!(drv->states[i].disabled || dev->states_usage[i].disable)){
+                       if (drv->states[i].target_residency <= sleep_length_us) {
+                               idx_timer = i;
+                               if (drv->states[i].target_residency <= measured_us)
+                                       idx_hit = i;
+                       }
                }
        }

@@ -256,39 +258,25 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
                struct cpuidle_state *s = &drv->states[i];
                struct cpuidle_state_usage *su = &dev->states_usage[i];

-               if (s->disabled || su->disable) {
-                       /*
-                        * If the "early hits" metric of a disabled state is
-                        * greater than the current maximum, it should be taken
-                        * into account, because it would be a mistake to select
-                        * a deeper state with lower "early hits" metric.  The
-                        * index cannot be changed to point to it, however, so
-                        * just increase the max count alone and let the index
-                        * still point to a shallower idle state.
-                        */
-                       if (max_early_idx >= 0 &&
-                           count < cpu_data->states[i].early_hits)
-                               count = cpu_data->states[i].early_hits;
-
-                       continue;
-               }

-               if (idx < 0)
-                       idx = i; /* first enabled state */
+               if (!(s->disabled || su->disable)) {
+                       if (idx < 0)
+                               idx = i; /* first enabled state */

-               if (s->target_residency > duration_us)
-                       break;
+                       if (s->target_residency > duration_us)
+                               break;

-               if (s->exit_latency > latency_req && constraint_idx > i)
-                       constraint_idx = i;
+                       if (s->exit_latency > latency_req && constraint_idx > i)
+                               constraint_idx = i;

-               idx = i;
+                       idx = i;

-               if (count < cpu_data->states[i].early_hits &&
-                   !(tick_nohz_tick_stopped() &&
-                     drv->states[i].target_residency < TICK_USEC)) {
-                       count = cpu_data->states[i].early_hits;
-                       max_early_idx = i;
+                       if (count < cpu_data->states[i].early_hits &&
+                           !(tick_nohz_tick_stopped() &&
+                             drv->states[i].target_residency < TICK_USEC)) {
+                               count = cpu_data->states[i].early_hits;
+                               max_early_idx = i;
+                       }
                }
        }


