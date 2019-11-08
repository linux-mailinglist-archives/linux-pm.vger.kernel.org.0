Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4E4BF426F
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 09:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730823AbfKHIpe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 03:45:34 -0500
Received: from cmta20.telus.net ([209.171.16.93]:35446 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730720AbfKHIpd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 Nov 2019 03:45:33 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id SztYi3gdQN5I9SztaiPS24; Fri, 08 Nov 2019 01:45:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1573202731; bh=ie2dbAGhUyWCSpx+oGNevVwBz5QNF8EP99PGBuqPKWI=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=HmP/WZTe3r0+QDUGN4zpkYswbzMu6BPYPSTDUQvY4QG4YFkMD/rPATajQ4uWlyX+E
         RYIQe0/uwpeugUwQaN1xRVa00W/swrET1gNKX9b8YPVaQuiA65Dht60omNcdgbFQkT
         RKhwkAniyDQz/XBmzhA4X9tq6qqvASSkLdRGHxVAS3M0Mj9VaSbUtJgDVlz7deG+n6
         BPYJHIvQyfPdUr8SAy60yaxgAwfriuYyuHd8AWIN6hJfPT/3z380QJYZnSA9PFUljP
         eO18mhZTesprUJHOHvi0JcxUKsXlKsQbAW3dGrRRtLTYTogAHoHwlklDVsKA9Kfpy9
         284fW1Qu98k1g==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=K/Fc4BeI c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=p-nOP-kxAAAA:8 a=QyXUC8HyAAAA:8 a=_hFHagcAZGCVafNjFckA:9
 a=QEXdDO2ut3YA:10 a=XN2wCei03jY4uMu7D0Wg:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc:     "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
References: <10494959.bKODIZ00nm@kreacher> <3269796.AzLOQfDnpo@kreacher> <CAJZ5v0jM3+qMvO6dx=FmK-xF0q3YKOwBf-yUPXSBfRjxJ59Cpg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jM3+qMvO6dx=FmK-xF0q3YKOwBf-yUPXSBfRjxJ59Cpg@mail.gmail.com>
Subject: RE: [PATCH v2] cpuidle: Use nanoseconds as the unit of time
Date:   Fri, 8 Nov 2019 00:45:27 -0800
Message-ID: <000701d59610$e0b3caa0$a21b5fe0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdWV1g4iCCd318waQi+CY9jC+yyrqQADB+KA
X-CMAE-Envelope: MS4wfDzxfM0VkZsRp0A/7IQo1ZXuWE2Mjnz8zSbOPu2O+hUwFwHeJr/uy9KnONeoZpqVhj2SEujJBeiAtoqz5db4kLLU6EAlSINYvtLFdJ5J2Pt6v0ecpHxH
 GQNP55tHSEHCRPf0ugs/pJiRStdStw50qoJx8g8tKKmIw/z4YzX2t4mp/omz9kEusg/XIVfTq1G7uKbGjDRnPv4iJHwzJBz4Pv4x7kA2EkUV6143uQx12EqV
 zpoOu3FAr4FBp+ZFV2yyCQ4BO4xFQJ8AwalWT8kHpzlS2mADANQLJaiYtFWtjoi8YUZS9xgObooesQ5lx0LWPluU67HW4fDpLrT24skEOs9deEWFiuumQZKE
 ppHnBiaZ
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019.11.07 17:44 Rafael J. Wysocki wrote:
> On Thu, Nov 7, 2019 at 3:25 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Currently, the cpuidle subsystem uses microseconds as the unit of
>> time which (among other things) causes the idle loop to incur some
>> integer division overhead for no clear benefit.
>>
>> In order to allow cpuidle to measure time in nanoseconds, add two
>> additional fields, exit_latency_ns and target_residency_ns, to
>> represent the exit latency and target residency of an idle state
>> in nanoseconds, respectively, to struct cpuidle_state_usage and
>> initialize them with the help of the corresponding values in
>> microseconds provided by drivers.  In addition to that, change
>> cpuidle_governor_latency_req() to return the idle state exit
>> latency constraint in nanoseconds.
>>
>> With that, meeasure idle state residency (last_residency_ns in
>> struct cpuidle_device and time_ns in struct cpuidle_driver) in
>> nanoseconds and update the cpuidle core and governors accordingly.
>>
>> However, the menu governor still computes typical intervals in
>> microseconds to avoid integer overflows.
>
> Since this addresses all of the comments received by the RFC version
> that was posted over a month ago and I don't see any more issues with
> it, I'm tempted to simply queue it up for 5.5 unless somebody sees a
> good enough reason why that would be a bad idea.

Could I please have another day or two?

I did try the RFC version, but not much as I went off on those
teo issues and backtracked pretty quickly.

I have been running this v2 today, with both menu and teo
governors. Acquiring some baseline reference data to compare
to now. The menu governor response seems different (Supporting
information/graphs will come later).
teo just started.

I lost a bunch of time due to being somewhat linux-next challenged.

... Doug


