Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D53252276
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 23:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgHYVHx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 17:07:53 -0400
Received: from cmta18.telus.net ([209.171.16.91]:42278 "EHLO cmta18.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgHYVHv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Aug 2020 17:07:51 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id AgAVkQs0IqUs3AgAWkWBnA; Tue, 25 Aug 2020 15:07:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1598389670; bh=okfs/gSusVf/W8ubFP2qX6KtZJzytKM0afb0qqjR/Eg=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=4zfsWlqxGLKOlEUpukz8dh81lSKCN2RHp4GG2TOj1tlEOJ9WLxtUm7BNJlDFlEgkZ
         9+1aITVhEpyNa3/xjRqkVtzQnZ7oFcgN0StGFJ8AGLmiCkPbiUMc+GGqDvmhBKZjpk
         ZDHVzC13+783zLEHXEnCvc7mAuDB/UNGUPpcdxU28UFH7xff4yZjAmxf+WeAyc38Ei
         DonDDmH8x10J4GE7mjBF1JgszfmNJu08VvfUKBmY0QbrAhN2iNAWnsqwBVWvgT+URN
         /EH5vAyUAd1WjNv4n0dOzTl17LhNVqPyfTAL1u2AemmmdL8eb9I194HLE6xEdrIU+l
         3Yr88rf/CIFxg==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=Mo8sFFSe c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=2s2tET4dTWZ_aRCLoUoA:9
 a=QEXdDO2ut3YA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>
Cc:     "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
References: <4169555.5IIHXK4Dsd@kreacher>        <5cf44a75c9f73740d2a22dbfc5c7a57489b1a3ca.camel@linux.intel.com>        <002001d67a7b$2b46e1c0$81d4a540$@net> <d07cd980439d999b060dccdd16cb44c390cbf66d.camel@linux.intel.com>
In-Reply-To: <d07cd980439d999b060dccdd16cb44c390cbf66d.camel@linux.intel.com>
Subject: RE: [PATCH v2 0/5] cpufreq: intel_pstate: Address some HWP-related oddities
Date:   Tue, 25 Aug 2020 14:07:46 -0700
Message-ID: <004a01d67b23$c9829b60$5c87d220$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdZ68u9Uyt9nR49dTce4yZVhEfzmlQAEGlEQ
X-CMAE-Envelope: MS4wfIDvh/3kq5OxzYmu7kehd7AzqqKrivKj6FoX406cZFn35t6L5jEJJrAy/xmpYMXe5q2D2Frhoe4BywGq9rwxFkvqoHHvaGOyFTDDthzNfhjCzj3UtAWt
 18TIYhyMzVOBRfLgQp7hg/aSqjl6/2UtAnC3WjlWK9v4hqbWP8Q7oYiP8xkkKnizFIYdNStQqpwTwh4AIIvQlQp+jtPa83QTaeeGz3hhZGhRIJ1N+SdFqctD
 Xc+sc09umctwSgWe/LAy8iTkcWQq9Gf5QePERGC3PihgM2D4Max8rLIfqVuxa5w4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Srinivas,

Thanks for your reply.

On 2020.08.25 08:12 Srinivas Pandruvada wrote:
> On Mon, 2020-08-24 at 18:00 -0700, Doug Smythies wrote:
> > I think there is a disconnect between your written
> > description of what is going on and your supporting MSR reads.
> >
> I reproduced again.
> I see the copy paste individual at the first place swapped.

Yes, and that had me confused, initially.

> I pasted the full output by direct copy - paste from the screen.
> 
> But the issues are still there.

Agreed.
I didn't try your offline/online of CPU 1 part previously,
but did now, and get the same results as you.

I did not know that "rdmsr -a 0x774" lists
stuff in the order that CPU were last brought on-line.
I had assumed the list was in CPU order. Weird.

My example (nothing new here, just me catching up.
The offline/online order was cpu1, then cpu3, then cpu2):

root@s18:/sys/devices/system/cpu# grep . cpu*/cpufreq/energy_performance_preference
cpu0/cpufreq/energy_performance_preference:balance_performance
cpu1/cpufreq/energy_performance_preference:127
cpu2/cpufreq/energy_performance_preference:125
cpu3/cpufreq/energy_performance_preference:126
cpu4/cpufreq/energy_performance_preference:balance_performance
cpu5/cpufreq/energy_performance_preference:balance_performance
root@s18:/sys/devices/system/cpu# rdmsr -p 0 0x774
80002e2e
root@s18:/sys/devices/system/cpu# rdmsr -p 1 0x774
7f002e2e
root@s18:/sys/devices/system/cpu# rdmsr -p 2 0x774
7d002e2e
root@s18:/sys/devices/system/cpu# rdmsr -p 3 0x774
7e002e2e
root@s18:/sys/devices/system/cpu# rdmsr -p 4 0x774
80002e2e
root@s18:/sys/devices/system/cpu# rdmsr -p 5 0x774
80002e2e
root@s18:/sys/devices/system/cpu# rdmsr -a 0x774
80002e2e
80002e2e
80002e2e
7f002e2e
7e002e2e
7d002e2e

... Doug


