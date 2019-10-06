Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2E2DCD251
	for <lists+linux-pm@lfdr.de>; Sun,  6 Oct 2019 16:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbfJFOql (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Oct 2019 10:46:41 -0400
Received: from cmta16.telus.net ([209.171.16.89]:51083 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbfJFOql (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 6 Oct 2019 10:46:41 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id H7nuiZSd0FXoiH7nviqxrG; Sun, 06 Oct 2019 08:46:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1570373199; bh=zhiN9/TEQQMAhrEdI04Mweoo96pgSuSYiVmgT7KYVcY=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=YrZNNK5YOVlKE/d1V817uIaBShJjgFlWJG3VJ1BWsOJ3YWAnbdJrrYm3KlNTqZbgh
         vSoeiRKXTcirSyay2IPRQiUuqAdvyJARNiYEfpt66w3pLa9lRCcL1qrVZYdS27Y2nX
         4WUmaX5CbIrH+ifEOV0KX6QfSy0ICtKQnNnahuC2xj94mq58FXuAV7dnCLNbfYuIfg
         rrp+UhMeA42KfrK7GJNOloCz8xUBGFcyr8T5mfsGVKlFGu9dQ1prn22UrfufwizBEo
         yr5ttnJPmFBP6oVTGUDZCzsY9W9WirUuvAgAu2j4ikqT4to/PXpo4YKMnRK/yr0/Oe
         pH3JE0aSRqMHQ==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=HoEI5HbS c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=aatUQebYAAAA:8 a=g0t0pkq594qMvyhE6B4A:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=VAi8dUBDBAXkbsTw:21 a=iXfTAjlW8Ecv3Iz4:21
 a=QEXdDO2ut3YA:10 a=7715FyvI7WU-l6oqrZBK:22
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
References: <001601d57487$e1029ef0$a307dcd0$@net> <000f01d576df$a6b87a30$f4296e90$@net> <CAJZ5v0gu=rALS9ZLNMDT3cw_sT2m8XCKP6+AW3488x2Q9EXM3g@mail.gmail.com>
In-Reply-To: <CAJZ5v0gu=rALS9ZLNMDT3cw_sT2m8XCKP6+AW3488x2Q9EXM3g@mail.gmail.com>
Subject: RE: [RFC/RFT][PATCH v8] cpuidle: New timer events oriented governor for tickless systems
Date:   Sun, 6 Oct 2019 07:46:32 -0700
Message-ID: <000001d57c54$db31f8c0$9195ea40$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdV4Owr8XxahUTRXTIajgh8M33FLzQDhv/DA
Content-Language: en-ca
X-CMAE-Envelope: MS4wfEpcRQlwFM8G1qzSL3Ouzs7S24N0pjKPpzXNneH/LTIHjfryfJs+cn98oGSHqWb1VdbRGQGvX64aJIgLt7byk9mmkkZP1fK9Lji79W5utzXEgy1dX9Q7
 dLNQfXL/eI5oQUhXL8zxBrhbMFmcPZYpAt/KEbGoDW2h1t+aolULVGE30ERZxnzeSM6O6znApfrRUqUNwoZH6l4nwdj3tgEawrtUg5HQbVrLB1Mq8cOk2hSK
 u314XxvY9AtU/U+jEEvcdRjiL7mg2m6vQNkaXDeGYb+3PlMgtYcAfaFPGZOKG0SzFWXzohpQSkjtQwhiHIikbQatfbQWD0vkwVF4jlPzg2nepavhQc3xhlRy
 e05SlKwNyLH3Zc8eqh7CqmxF7NDT/CWOdbxptTu8obhkAPorx+mpz/380l+PorTXD3DTq04Mm3eP/n/V9gBIGjg8qQMx5CZM7Vfsk/C6rIwmn8yydiFZevMV
 +9Qm/IBV+Wh1cpiiDwisF/DiYXHoVLGi73QcnqHZla9bxggflg5pLx0Ty+aRhqGdEFESAMA7rThk3eEs
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019.10.01 02:32 Rafael J. Wysocki wrote:
> On Sun, Sep 29, 2019 at 6:05 PM Doug Smythies <dsmythies@telus.net> wrote:
>> On 2019.09.26 09:32 Doug Smythies wrote:
>>
>>> If the deepest idle state is disabled, the system
>>> can become somewhat unstable, with anywhere between no problem
>>> at all, to the occasional temporary jump using a lot more
>>> power for a few seconds, to a permanent jump using a lot more
>>> power continuously. I have been unable to isolate the exact
>>> test load conditions under which this will occur. However,
>>> temporarily disabling and then enabling other idle states
>>> seems to make for a somewhat repeatable test. It is important
>>> to note that the issue occurs with only ever disabling the deepest
>>> idle state, just not reliably.
>>>
>>> I want to know how you want to proceed before I do a bunch of
>>> regression testing.
>>
>> I did some regression testing anyhow, more to create and debug
>> a methodology than anything else.
>>
>>> On 2018.12.11 03:50 Rafael J. Wysocki wrote:
>>>
>>>> v7 -> v8:
>>>>  * Apply the selection rules to the idle deepest state as well as to
>>>>    the shallower ones (the deepest idle state was treated differently
>>>>    before by mistake).
>>>>  * Subtract 1/2 of the exit latency from the measured idle duration
>>>>    in teo_update() (instead of subtracting the entire exit latency).
>>>>    This makes the idle state selection be slightly more performance-
>>>>   oriented.
>>>
>>> I have isolated the issue to a subset of the v7 to v8 changes, however
>>> it was not the exit latency changes.
>>>
>>> The partial revert to V7 changes I made were (on top of 5.3):
>>
>> The further testing showed a problem or two with my partial teo-v7 reversion
>> (I call it teo-v12) under slightly different testing conditions.

Correction:
There was no problem with my partial reversion kernel (a.k.a. teo-v12). The problem
was confusion over which kernel I was actually running for whatever test.

>>
>> I also have a 5.3 based kernel with the current teo reverted and the entire
>> teo-v7 put in its place. I have yet to find a idle state disabled related issue
>> with this kernel.
>>
>> I'll come back to this thread at a later date with better details and test results.
>
> Thanks for this work!
>
> Please also note that there is a teo patch in 5.4-rc1 that may make a
> difference in principle.

Yes, actually this saga started from somewhere between kernel 5.3 and 5.4-rc1,
and did include those teo patches, which actually significantly increases the
probability of the issue occurring.

When the deepest idle state is disabled, and the all states search loop exits
normally, it might incorrectly re-evaluate a previous idle state previously
deemed not worthy of the check. This was introduced between teo development
versions 7 and 8. The fix is to move the code back inside the loop.
(I'll submit a patch in a day or two).

I do not think I stated it clearly before: The problem here is that some CPUs
seem to get stuck in idle state 0, and when they do power consumption spikes,
often by several hundred % and often indefinitely.

I made a hack job automated test:
Kernel	tests		fail rate
5.4-rc1	 6616		13.45%
5.3		 2376		 4.50%
5.3-teov7	12136		 0.00%  <<< teo.c reverted and teov7 put in its place.
5.4-rc1-ds	11168        0.00%  <<< proposed patch (> 7 hours test time)

Proposed patch (on top of kernel 5.4-rc1):

doug@s15:~/temp-k-git/linux$ git diff
diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index b5a0e49..0502aa9 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -276,8 +276,22 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
                if (idx < 0)
                        idx = i; /* first enabled state */

-               if (s->target_residency > duration_us)
+               if (s->target_residency > duration_us){
+                       /*
+                        * If the "hits" metric of the idle state matching the sleep length is
+                        * greater than its "misses" metric, that is the one to use.  Otherwise,
+                        * it is more likely that one of the shallower states will match the
+                        * idle duration observed after wakeup, so take the one with the maximum
+                        * "early hits" metric, but if that cannot be determined, just use the
+                        * state selected so far.
+                        */
+                       if (cpu_data->states[idx].hits <= cpu_data->states[idx].misses &&
+                           max_early_idx >= 0) {
+                               idx = max_early_idx;
+                               duration_us = drv->states[idx].target_residency;
+                       }
                        break;
+               }

                if (s->exit_latency > latency_req && constraint_idx > i)
                        constraint_idx = i;
@@ -293,20 +307,6 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
        }

        /*
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
-       /*
         * If there is a latency constraint, it may be necessary to use a
         * shallower idle state than the one selected so far.
         */


