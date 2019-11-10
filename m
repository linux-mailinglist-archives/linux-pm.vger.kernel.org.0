Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65D92F6BBA
	for <lists+linux-pm@lfdr.de>; Sun, 10 Nov 2019 23:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfKJWM3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Nov 2019 17:12:29 -0500
Received: from cmta18.telus.net ([209.171.16.91]:43614 "EHLO cmta18.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbfKJWM2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 10 Nov 2019 17:12:28 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id TvRWirqe6gu2QTvRXi1s2y; Sun, 10 Nov 2019 15:12:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1573423946; bh=IrRWFJPtSY5HkxRVhwzCCdZhBAFSSPGzUo2j4mUPGsI=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=qysljIsdmzUuSAgbxrVP75GtZM6kacP8nwrLnvDzybpdY6rpoeo+62xcfZWeH26CK
         YBcIdjr7KO7MwkksOeOikAxtF00/Dmsvv+7jpdGyzwgUAkeHprxuI4k+RmBpmC0dEt
         U2hcYJhKDHGSZXdMdoc+nlVhDYW65DUjn0gFS8dQVxoGh3jTuRNQ+MGco5aoClerg2
         SyBtpe8PASDYgc8cwYoB0/RGRhmrDyA0kK08BNq+M+ST9gS+lF+wbCwRAN3v227ovf
         yYiQ8cGfOq1dQ9HOR4O1qrAqWtengvCdocVB2e0MVn0XRFWLnE+7OnWHYNLbYLr5vT
         xvt+2tUWFgghA==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=QIcWuTDL c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=FGbulvE0AAAA:8 a=aatUQebYAAAA:8 a=fMCjhIpa8ESE6kpPSzQA:9
 a=CjuIK1q_8ugA:10 a=svzTaB3SJmTkU8mK-ULk:22 a=7715FyvI7WU-l6oqrZBK:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
References: <10494959.bKODIZ00nm@kreacher> <000a01d59656$99798710$cc6c9530$@net> <CAJZ5v0gZDJ2=PiiGw2mcCcVKBM2OyM1G9nRvJ+iWLFUQcXqZuw@mail.gmail.com> <6163696.37NBKbymtj@kreacher> <000b01d597f2$06403a50$12c0aef0$@net>
In-Reply-To: <000b01d597f2$06403a50$12c0aef0$@net>
Subject: RE: [PATCH v2] cpuidle: Use nanoseconds as the unit of time
Date:   Sun, 10 Nov 2019 14:12:20 -0800
Message-ID: <002301d59813$ee18c920$ca4a5b60$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdWX66lAJM+ky/tcQb2CPZRo9UbwKwABGLggAANCZjA=
X-CMAE-Envelope: MS4wfOj3gSvmO4SETXWeUa2DWHF24GPWtkFUi+fSgvv0SMd3WPRbh/sK9lzWimKyv8SxMUTqhBaqusQoM7BDxrrZmX0DBfdxP5c5rkZEDHX7w0gx0ajT+QO2
 IaDI+3N47SiNiVGBo4lWB6P6qAv9dqUuo9HC1W8VjvZzcnbZUbHhWVVlW1iJk9/aHOKpyOCHrtqybF13xuLN0qMwqLTUnSMdrCrYu2LEIp5MPUI7kwB6Zjig
 wYGtcqvkeevxCVReGEt4qTGoHQszuZ93cb3Et02itCRkr5vd/Qpx8bkENWi0xVqOzU5pbN2ghgjqk/qegzvXz/woJh8F3bjX5bL9qEu8Gx8=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019.11.10 10:10 Doug Smythies wrote:
> On 2019.11.10 09:24 Rafael J. Wysocki wrote:
>> On Sunday, November 10, 2019 5:48:21 PM CET Rafael J. Wysocki wrote:
>>
>> I have found a bug, which should be addressed by the patch below.
>>
>> If it still doesn't reduce the discrepancy, we'll need to look further.
>>
>> ---
>> drivers/cpuidle/governors/menu.c |    4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> Index: linux-pm/drivers/cpuidle/governors/menu.c
>> ===================================================================
>> --- linux-pm.orig/drivers/cpuidle/governors/menu.c
>> +++ linux-pm/drivers/cpuidle/governors/menu.c
>> @@ -516,8 +516,8 @@ static void menu_update(struct cpuidle_d
>> 	new_factor -= new_factor / DECAY;
>> 
>> 	if (data->next_timer_ns > 0 && measured_ns < MAX_INTERESTING)
>> -		new_factor += RESOLUTION * div64_u64(measured_ns,
>> -						     data->next_timer_ns);
>> +		new_factor += div64_u64(RESOLUTION * measured_ns,
>> +					data->next_timer_ns);
>> 	else
>> 		/*
>> 		 * we were idle so long that we count it as a perfect
>
> Yes, that was the exact bit of code I focused on yesterday.
> However, my attempt to fix was different, and made no difference,
> with the new graph being exactly on top of the old bad one.
> I had defined new_factor as u64 and RESOLUTION as ULL.

Your patch does fix the problem.
I now also understand why my attempt did not.

New data added to previous graphs. For those that don't
want to go to the graphs, the nanosecond menu graphs are now
almost identical to the microsecond based one.

http://www.smythies.com/~doug/linux/idle/nano-second-conversion/sweep/index.html

Legend:
teo-base : linux-next 2019.11.07
menu-base: linux-next 2019.11.07
teo-v2   : linux-next 2019.11.07 + cpuidle: Consolidate disabled state checks + this v2
menu-v2  : linux-next 2019.11.07 + cpuidle: Consolidate disabled state checks + this v2
rjw1     : menu-v2 + above patch.

Acked-by and tested-by Doug Smythies <dsmythies@telus.net>

Disclaimer: Only teo and menu, not ladder or haltpoll governors.

Additional suggestions:

Header comments:

> microseconds provided by drivers.  In addition to that, change
> cpuidle_governor_latency_req() to return the idle state exit
> latency constraint in nanoseconds.

Suggest:

microseconds provided by drivers.  Additionally, change
cpuidle_governor_latency_req() to return the idle state exit
latency constraint in nanoseconds.

> With that, meeasure idle state residency (last_residency_ns in
             ^^^^^^^^
Suggest:

Also measure idle state residency (last_residency_ns in

Code:
Suggest deletion of this note:

/*
 * Please note when changing the tuning values:
 * If (MAX_INTERESTING-1) * RESOLUTION > UINT_MAX, the result of
 * a scaling operation multiplication may overflow on 32 bit platforms.
 * In that case, #define RESOLUTION as ULL to get 64 bit result:
 * #define RESOLUTION 1024ULL
 *
 * The default values do not overflow.
 */

Because you have managed the extra bit requirements as part of the patch.

... Doug


