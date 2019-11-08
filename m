Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A567FF522A
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 18:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfKHREj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 12:04:39 -0500
Received: from cmta16.telus.net ([209.171.16.89]:48741 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbfKHREi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 Nov 2019 12:04:38 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id T7gYiAcEVFXoiT7gZi2lPR; Fri, 08 Nov 2019 10:04:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1573232677; bh=wC6fXQQ5fyNUky0F/VUsvZ5e9+3RjjFQ4Uok7ILvjc4=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=tbJ2nJ7qcFM4p43E1W/OSprLTFFpgP5FKDiVqvGe+BYF+5h0oPy046ZPjWgU+fvQm
         7sG/tjVb2fwt1AAkbN1t01zZvHYOmacCYa/8F+Rk0zC2b9klFmqpXZsCtyAlrZq/Uu
         lLXVcw5xioIA13la/OUkpEj2bHjOy9p0H3aEpldYMGfG9g5Emkzig/2GOIEfBzAcUl
         YqN18U68id+cpHHQ4cisYlds3sbT+0yR1Y1c001FVLiHDPHkp4IbS43p01RqjsbEK/
         1E9R97JlmeMfT94ScwX6ERXq/4qkes+Ys1osptGVLnT4qSTK/iUMIrdZDT+t4ZEB0H
         IOA//u9QVuruA==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=HoEI5HbS c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=aatUQebYAAAA:8 a=FGbulvE0AAAA:8 a=njq2HdyGrEXifyybg1YA:9
 a=QEXdDO2ut3YA:10 a=7715FyvI7WU-l6oqrZBK:22 a=svzTaB3SJmTkU8mK-ULk:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc:     "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
References: <10494959.bKODIZ00nm@kreacher> <3269796.AzLOQfDnpo@kreacher> <CAJZ5v0jM3+qMvO6dx=FmK-xF0q3YKOwBf-yUPXSBfRjxJ59Cpg@mail.gmail.com> <000701d59610$e0b3caa0$a21b5fe0$@net> <CAJZ5v0gsK0OmqAvw2BVGvajPmCTrRGFVVZ0+Y99ZkbbUcWYGOg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gsK0OmqAvw2BVGvajPmCTrRGFVVZ0+Y99ZkbbUcWYGOg@mail.gmail.com>
Subject: RE: [PATCH v2] cpuidle: Use nanoseconds as the unit of time
Date:   Fri, 8 Nov 2019 09:04:33 -0800
Message-ID: <000a01d59656$99798710$cc6c9530$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdWWGTqsWC7i2bnvR8OiOnG3vd+ivAANZWkQ
X-CMAE-Envelope: MS4wfOUqsbqb5Xx5fl5wUa+35jsFoL8q+N2hsfatLIHH4zhd7m/EkTUcXPvoP4DoJ99usQM2ulQQ52ZcaIGEq73YfYmx8p5HLx2qYW/SYamu2VYnjiHa+U1V
 q7otdmtguwQ9tuBOgauQ7R0O3n1trYY4HTK0N92aGLNPoKB9J+tjc5fZL6Z+53BSkJM9PdSe5VHzpQdmZQAhTmHIU+/bXQ5owIls7aKmbbsxq3YN2a/q8HYg
 8SFpkx4+AGVfRf5a2fwzWe7irx6FLScCL73DJWXFDHGp5QmWW88D2t2hUR+ako9ePnbGFiEGMPLBZWX0m3yOyVlCQMwcfOAtxM2RHRLH22FlZenzvkBhW4zr
 WFNiB0ae
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019.11.08 01:45 Rafael J. Wysocki wrote:
> On Fri, Nov 8, 2019 at 9:45 AM Doug Smythies <dsmythies@telus.net> wrote:
>
...
>> I have been running this v2 today, with both menu and teo
>> governors. Acquiring some baseline reference data to compare
>> to now. The menu governor response seems different (Supporting
>> information/graphs will come later).
>
> That may be good or bad, depending in what way it is different. :-)

My thinking was that the differences should be minimal between
the baseline (linux-next as of 2019.11.07) and plus your two patches.
Because this was a change of units, but not functionality.
Such is the case with the teo governor, but not the menu governor.
I have not tried the ladder or haltpoll governors, and don't intend to.

Now to attempt to isolate the issue in the code, which might take
considerable time.

The test in question was that sweep one developed during the
powernightmare stuff. It is a crude attempt to sweep through
a preference for all idle states. While not a great test, who cares
if it reveals something.

Reference:
http://www.smythies.com/~doug/linux/idle/nano-second-conversion/sweep/index.html

Legend:
teo-base : linux-next 2019.11.07
menu-base: linux-next 2019.11.07
teo-v2   : linux-next 2019.11.07 + cpuidle: Consolidate disabled state checks + this v2
menu-v2  : linux-next 2019.11.07 + cpuidle: Consolidate disabled state checks + this v2

Note: I only tossed the graphs there, without a way to navigate to the location
from the parent web pages.

... Doug


