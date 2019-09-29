Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30C07C160C
	for <lists+linux-pm@lfdr.de>; Sun, 29 Sep 2019 18:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfI2QFG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Sep 2019 12:05:06 -0400
Received: from cmta20.telus.net ([209.171.16.93]:54472 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbfI2QFG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 29 Sep 2019 12:05:06 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id Ebgwiliw2N5I9Ebgxinmno; Sun, 29 Sep 2019 10:05:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1569773104; bh=CJQ87ZzpO9IqG72eA+TgWxmbKOsF+7vh52cSQ42MqWs=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=PMzYdUCepAiTqiZov//Ksvi2NGML2+wILAwPLaBdJvo2eNvhdWkan+E9rgDgsnHr6
         VdXMUSMA+Y2ab8rWVS6OEdsh/iwIYYlOtZLFpeTW71q8tEqJ5qnSW6tGZ4jAFZxVfn
         Ti47DSBobw2uikwJAcMTn1BgzZffy5QRI5899hF5uJ7rwlXSqhCKGnw9/9pa6oY7Tq
         c6fdMCTbMWdZf8eVI+GlqqS2dH51QGPSb6y0+N+QDk3ju5OnGI1IUZRsQ10YseFl3i
         m5DMu3Zo/5gx/3++dKPgfGjImPxlWrGbMINXeQPu5gGrX4rubbau5e0CoRqZ9WSWo4
         vH+K5V4yUEd9g==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=K/Fc4BeI c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=I8o6C4CDd1cejXE1t-8A:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
 a=CjuIK1q_8ugA:10
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
References: WgXvgFd5aBdpLWgY0gWTga <001601d57487$e1029ef0$a307dcd0$@net>
In-Reply-To: <001601d57487$e1029ef0$a307dcd0$@net>
Subject: RE: [RFC/RFT][PATCH v8] cpuidle: New timer events oriented governor for tickless systems
Date:   Sun, 29 Sep 2019 09:04:56 -0700
Message-ID: <000f01d576df$a6b87a30$f4296e90$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdSRR6W+nknzDAweSJ6DmHc6MWYLQjjLqLuAAJlpaNA=
Content-Language: en-ca
X-CMAE-Envelope: MS4wfNd4PLcYlWcYTmKMQ0x0mxpaSmVGCF0vsHot2FUBNEc9dQIqHC+IRfibA6ofm8HsHJyzySgJFJguxnbnakarg7/zbJwbYCiTBAG7azFB+lYBfQUfRP8/
 cDcOliEGEz0tcIBrw9KMOaqM/+wqclTQu7a4llPFMZIsNCP5joCtiSR0EcwbpR4t9CEOqClC32vF/ZYwlaQ6q4RIWfXF6Q+DegCk63VWIpIsuduoCwBXUlEa
 yOZM5dS5h/8UjGwOQCmQowd9IKW6e6FWL8wXTT9HbOZHXYmJhxI8S8SvvvCekYIOdVUsQS+kJB+Y4VOAnAmVPFFQGAgYmHpbVGqRvuJIoWU1FCW2UJsvItc/
 XudAcIREMUxewyDV0px+q9AxwuawG9jJeRnuLs1c6SZccgPqTnjyX0b9/XI+zvz7YWHKyUqZiZ3RI8SOuZHoFdcDJ+SgW8Ekk3GSJkBYK6c5I7dzdps0tuUv
 lAYI7hZyK2BdMP/iAmoPyk1bsrogvnZUbBvtIQ==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019.09.26 09:32 Doug Smythies wrote:

> If the deepest idle state is disabled, the system
> can become somewhat unstable, with anywhere between no problem
> at all, to the occasional temporary jump using a lot more
> power for a few seconds, to a permanent jump using a lot more
> power continuously. I have been unable to isolate the exact
> test load conditions under which this will occur. However,
> temporarily disabling and then enabling other idle states
> seems to make for a somewhat repeatable test. It is important
> to note that the issue occurs with only ever disabling the deepest
> idle state, just not reliably.
>
> I want to know how you want to proceed before I do a bunch of
> regression testing.

I did some regression testing anyhow, more to create and debug
a methodology than anything else.

> On 2018.12.11 03:50 Rafael J. Wysocki wrote:
>
>> v7 -> v8:
>>  * Apply the selection rules to the idle deepest state as well as to
>>    the shallower ones (the deepest idle state was treated differently
>>    before by mistake).
>>  * Subtract 1/2 of the exit latency from the measured idle duration
>>    in teo_update() (instead of subtracting the entire exit latency).
>>    This makes the idle state selection be slightly more performance-
>>   oriented.
>
> I have isolated the issue to a subset of the v7 to v8 changes, however
> it was not the exit latency changes.
>
> The partial revert to V7 changes I made were (on top of 5.3):

The further testing showed a problem or two with my partial teo-v7 reversion
(I call it teo-v12) under slightly different testing conditions.

I also have a 5.3 based kernel with the current teo reverted and the entire
teo-v7 put in its place. I have yet to find a idle state disabled related issue
with this kernel.

I'll come back to this thread at a later date with better details and test results.

... Doug


