Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90672D2150
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2019 09:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732792AbfJJHFT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Oct 2019 03:05:19 -0400
Received: from cmta18.telus.net ([209.171.16.91]:37657 "EHLO cmta18.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbfJJHFT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Oct 2019 03:05:19 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id ISVciThHlgu2QISVdixnlj; Thu, 10 Oct 2019 01:05:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1570691117; bh=yJAIubNgABwo5FHn45HxGvP11hFlYI+7AOXWX2KntCU=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=n63q47Oi4q9isHW8WZIYigmJPMJsghFIMSvQP74roEYi5UfvRcdSg5Xomw4Q0DmrQ
         fMtiLUGORJXAWyrY2iEBNJOfyHWqYja/agKlt+FeqF5ydZJ0r2UOVLpL7wsE0FxQAb
         MXNi6Z+5R/RcCVPCTZx3TxjuEcOs4a7525MUdw27IhavwR+KZ37Ac0cI4BTyGPyTE2
         l+otz52ja4nuIDjYOdyToEUBIrNIUu8RxhI7FuMDE7UwkH0HepOvL6l0E0L821pqfp
         jHAi3bVkpJgOcIEwz+Va+zhh7p0tisSDGcQqiNZKoVkWDKyS4CmXNQJcUv5sRYLBw8
         6aqPZopvpvxQg==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=QIcWuTDL c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=VwQbUJbxAAAA:8 a=aatUQebYAAAA:8 a=VCGl1-TQkrmU9ILRUbUA:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=B-rJQ6SmICdiGdTV:21 a=MI_Jn2f3h0BHA_FJ:21
 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=7715FyvI7WU-l6oqrZBK:22
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
References: <001601d57487$e1029ef0$a307dcd0$@net> <CAJZ5v0jvusVBcKECBueDHk5KQGda=GGuSGPO3F4wCvk3cro56A@mail.gmail.com> <1574317.FFykgJKpNH@kreacher> <3490479.2dnHFFeJIp@kreacher>
In-Reply-To: <3490479.2dnHFFeJIp@kreacher>
Subject: RE: [RFC/RFT][PATCH v8] cpuidle: New timer events oriented governor for tickless systems
Date:   Thu, 10 Oct 2019 00:05:11 -0700
Message-ID: <000b01d57f39$11868670$34939350$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdV+pp2JiVhEa0slQqie26B61DVX/QAen1OQ
X-CMAE-Envelope: MS4wfHu/z7mA1YA3SYaJTrB79W1+Hvz5mXZEHAV9A0H5Yb2QfZmOXHloVuMAGicA3jv4YKjw5f8LPgM3NASyR9Sx1iMm/gwU+t8YVPcN/1B7/Y/3rUTU86s1
 PbZfXc9ANZBvN3N9PMuNhZoh640kHWAUwzEmrvaWtRQ49kdo1HVse3fZuj67cVZpPs/CQ8umW5O5DKg+6GAipXVdXe0qhBmrk71fMbnZkYHR9PLdLBsiG7LP
 NVTb00xopsaXvDkhmsBdFtpl2W+0Y0LrH1jnacso3k9gwpTi+rYNIVSZbea62oa2NVjuqkhG9WcbONcG8S6+Jv0ChmzTq8Job1H/Va9LyTurtWK46E4Z40+P
 oNdaYnGJKPc9W79vWw7L1ZXSAWa/nY0U5VUSJ9iCdvhsd8745qalIdmZ/DD4tla1UuiP3K7yXoEdMRt7/CIlQMAlW6j+OvIjSOhHBjUbAsZUicqhs1d10T1Q
 PpEbEYEgJygSPDalElqLyAJTglPOtMTHgxwOqA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019.10.09 06:37 Rafael J. Wysocki wrote:
> On Wednesday, October 9, 2019 1:19:51 AM CEST Rafael J. Wysocki wrote:
>> On Tuesday, October 8, 2019 12:49:01 PM CEST Rafael J. Wysocki wrote:
>>> On Tue, Oct 8, 2019 at 11:51 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>> On Tue, Oct 8, 2019 at 8:20 AM Doug Smythies <dsmythies@telus.net> wrote:
>>>>> O.K. Thanks for your quick reply, and insight.
>>>>>
>>>>> I think long durations always need to be counted, but currently if
>>>>> the deepest idle state is disabled, they are not.
...
>>>> AFAICS, adding early_hits to count is not a mistake if there are still
>>>> enabled states deeper than the current one.
>>> 
>>> And the mistake appears to be that the "hits" and "misses" metrics
>>> aren't handled in analogy with the "early_hits" one when the current
>>> state is disabled.

I only know how to exploit and test the "hits" and "misses" path
that should use the deepest available idle state upon transition
to an idle system. Even so, the test has a low probability of
failing, and so needs to be run many times.

I do not know how to demonstrate and/or test any "early_hits" path
to confirm that an issue exists or that it is fixed.

>>> 
>>> Let me try to cut a patch to address that.
>> 
>> Appended below, not tested.

Reference as: rjw1

>> 
>> It is meant to address two problems, one of which is that the "hits" and
>> "misses" metrics of disabled states need to be taken into account too in
>> some cases, and the other is an issue with the handling of "early hits"
>> which may lead to suboptimal state selection if some states are disabled.
>
> Well, it still misses a couple of points.
>
> First, disable states that are too deep should not be taken into consideration
> at all.
>
> Second, the "hits" and "misses" metrics of disabled states need to be used for
> idle duration ranges corresponding to them regardless of whether or not the
> "hits" value is greater than the "misses" one.
>
> Updated patch is below (still not tested), but it tries to do too much in one
> go, so I need to split it into a series of smaller changes.

Thanks for your continued look at this.

Reference as: rjw2

Test 1, hack job statistical test (old tests re-stated):

Kernel  tests  	         fail rate
5.4-rc1		 6616		13.45%
5.3			 2376		 4.50%
5.3-teov7		12136		 0.00%  <<< teo.c reverted and teov7 put in its place.
5.4-rc1-ds		11168		 0.00%  <<< [old] ds proposed patch (> 7 hours test time)
5.4-rc1-ds12	 4224		 0.00% <<< [old] new ds proposed patch
5.4-rc2-rjw1	11280		 0.00%
5.4-rc2-rjw2	  640		 0.00%  <<< Will be run again, for longer.

Test 2: I also looked at every possible enable/disable idle combination,
and they all seemed O.K.

No other tests have been run yet.

System:
Processor: i7-2600K
Deepest idle state: 4 (C6)

... Doug


