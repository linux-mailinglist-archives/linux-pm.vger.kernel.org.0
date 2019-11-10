Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 141F3F6AAF
	for <lists+linux-pm@lfdr.de>; Sun, 10 Nov 2019 19:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKJSJp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Nov 2019 13:09:45 -0500
Received: from cmta19.telus.net ([209.171.16.92]:50888 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbfKJSJp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 10 Nov 2019 13:09:45 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id TrediPHO2hFQMTreeiGfM1; Sun, 10 Nov 2019 11:09:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1573409383; bh=gj08HGEqmkT/0cGDv2qmCQ//pYLBwSO+2JKJf+eW4U4=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=07Cyvr+iMNj5MCuegNCNNHwQjdSHOa1zff5t/Y58vhrewsSwVGjeeGldkpb8jPa23
         T6ChU/09f4Q50tO6DU6eot7HSf0WFF28N0JZQSRqgadeKfs/PMAF9tq9yb9M5Bjss4
         R7xc5cWTDd9d69g9YBBMUxarX+H3zF9agfeS4ze16zVm+MzNryjVsx1x/4rtTNN+s4
         HB8WpsAo8a07YGegyOuBs2KTjWG+gK/Cy76v4FBelzk6btiDAKXJWVwh8cjol4C4pn
         ltW3oqn0FO5qLsxY3aH//Oz/OyuySo5WBrMkvgjEzBo1+Bpr1CuHtapo7jXkinB8Qm
         Kvx+BK0IDr5lQ==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=ZPWpZkzb c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=aatUQebYAAAA:8 a=SOqZnydbTP_Q-9HgpewA:9 a=CjuIK1q_8ugA:10
 a=7715FyvI7WU-l6oqrZBK:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
References: <10494959.bKODIZ00nm@kreacher> <000a01d59656$99798710$cc6c9530$@net> <CAJZ5v0gZDJ2=PiiGw2mcCcVKBM2OyM1G9nRvJ+iWLFUQcXqZuw@mail.gmail.com> <6163696.37NBKbymtj@kreacher>
In-Reply-To: <6163696.37NBKbymtj@kreacher>
Subject: RE: [PATCH v2] cpuidle: Use nanoseconds as the unit of time
Date:   Sun, 10 Nov 2019 10:09:37 -0800
Message-ID: <000b01d597f2$06403a50$12c0aef0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdWX66lAJM+ky/tcQb2CPZRo9UbwKwABGLgg
X-CMAE-Envelope: MS4wfH0yeQTuFgCuT2lePGLlPVHJwEhh7Z0xA0QQHd7DmhZJCDnoiLU32O3K2kU28f3KDj7iVfgmpyBHvRM4DgdTweCbxSZPp/OIW9ZfZEZBfr1sq03hXNu5
 vlSiKKWGpZB+gLQILsEpGc8pWfWfbuDoquEov7+KndXRux+I5eLR9TKYSME5fXfxa+gSFn/F3cePTNl/MzyyVI6uxAjHk+16wAAl7Fxr26HpsUw8fx3PxcAp
 SPC1j3DnBTUWtpji5J56O75lZ6LOvCRrlOYq0jbaasjden87eKS91kJt+LmeqJr+U16BvOJuVrznqhX9x3oV1935rDLRAIkhdfTf76mH6Uc=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019.11.10 09:24 Rafael J. Wysocki wrote:
> On Sunday, November 10, 2019 5:48:21 PM CET Rafael J. Wysocki wrote:
>> On Fri, Nov 8, 2019 at 6:04 PM Doug Smythies <dsmythies@telus.net> wrote:
>>>
>>> On 2019.11.08 01:45 Rafael J. Wysocki wrote:
>>>> On Fri, Nov 8, 2019 at 9:45 AM Doug Smythies <dsmythies@telus.net> wrote:
>>>>
>>> ...
>>>>> I have been running this v2 today, with both menu and teo
>>>>> governors. Acquiring some baseline reference data to compare
>>>>> to now. The menu governor response seems different (Supporting
>>>>> information/graphs will come later).
>>>>
>>>> That may be good or bad, depending in what way it is different. :-)
>>>
>>> My thinking was that the differences should be minimal between
>>> the baseline (linux-next as of 2019.11.07) and plus your two patches.
>>> Because this was a change of units, but not functionality.
>>> Such is the case with the teo governor, but not the menu governor.
>>> I have not tried the ladder or haltpoll governors, and don't intend to.
>>>
>>> Now to attempt to isolate the issue in the code, which might take
>>> considerable time.
>> 
>> Thanks!
>> 
>> It looks like I have overlooked a unit conversion in menu or done a
>> unit conversion twice somewhere.
>
> I have found a bug, which should be addressed by the patch below.
>
> If it still doesn't reduce the discrepancy, we'll need to look further.
>
> ---
> drivers/cpuidle/governors/menu.c |    4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> Index: linux-pm/drivers/cpuidle/governors/menu.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> +++ linux-pm/drivers/cpuidle/governors/menu.c
> @@ -516,8 +516,8 @@ static void menu_update(struct cpuidle_d
> 	new_factor -= new_factor / DECAY;
> 
> 	if (data->next_timer_ns > 0 && measured_ns < MAX_INTERESTING)
> -		new_factor += RESOLUTION * div64_u64(measured_ns,
> -						     data->next_timer_ns);
> +		new_factor += div64_u64(RESOLUTION * measured_ns,
> +					data->next_timer_ns);
> 	else
> 		/*
> 		 * we were idle so long that we count it as a perfect

Yes, that was the exact bit of code I focused on yesterday.
However, my attempt to fix was different, and made no difference,
with the new graph being exactly on top of the old bad one.
I had defined new_factor as u64 and RESOLUTION as ULL.
Note: I didn't care about the most efficient code, in these attempts
to just get to the answer.

I'll try yours and report back.

... Doug


