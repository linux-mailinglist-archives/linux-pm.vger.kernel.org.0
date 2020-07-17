Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17E5223CD9
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jul 2020 15:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgGQNhk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jul 2020 09:37:40 -0400
Received: from cmta20.telus.net ([209.171.16.93]:45910 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbgGQNhi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 17 Jul 2020 09:37:38 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id wQYOju31CljNxwQYPjxByj; Fri, 17 Jul 2020 07:37:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1594993056; bh=MHXW2IkggcW3wyGFCI6PVWf/41xrTYo5/J9/J/sF8i0=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=1MgR/8V8KEFb7XBAbEGVVmYawYE5LVGWAiA9NYtugoJW8xyY9SURGb02IusXo+s4o
         FEu0b3n6zewUewiyTkbh/Rp6ZCC7XScu42Arze2Ha29s3FFTU7wC8Ab5I8Qqq53Sks
         o+//CdtcPdoiqQJxPYJcE+DaI0wkSxqLvP9gs+QYTLLuOpe00uvH4BQBdQw8pVEGEc
         ko14uSLPxfQzjT2Z86CIElh7m8glpROQURE39qVuWPBnhaGcC7BzjRJDlSL0gVMPUQ
         Kxwpu++5LpU6i+8PNfJVSje/K7a8EeQWOlVaQ1q4Z95/XioU7HPyzKcr/nxsYYJqZZ
         3qqYoPYbmGCIw==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=Z8aS40ZA c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=aatUQebYAAAA:8
 a=QyXUC8HyAAAA:8 a=gu6fZOg2AAAA:8 a=TWNXCyI2drZUM-DjKuIA:9 a=QEXdDO2ut3YA:10
 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10 a=7715FyvI7WU-l6oqrZBK:22
 a=2RSlZUUhi9gRBrsHwhhZ:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Linux Documentation'" <linux-doc@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Francisco Jerez'" <francisco.jerez.plata@intel.com>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
References: <3955470.QvD6XneCf3@kreacher> <000f01d65ae8$0c607990$25216cb0$@net> <CAJZ5v0jGbfqfqqoPLjneFD5HLb20Yv9p25juNTzaumL70iFogg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jGbfqfqqoPLjneFD5HLb20Yv9p25juNTzaumL70iFogg@mail.gmail.com>
Subject: RE: [PATCH] cpufreq: intel_pstate: Implement passive mode with HWP enabled
Date:   Fri, 17 Jul 2020 06:37:32 -0700
Message-ID: <001201d65c3f$6e2371c0$4a6a5540$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdZbagHesCkVLO4tQcG7gYoT0bjwUwA0cV5w
X-CMAE-Envelope: MS4wfOK9zJc8oTgw2q9HjxJyxrpliJRW0gTNup0SyBgPhQWTnu8gx/4AE2Ux4uI5fD09J4B26pOiuLd8QhzkXNzl6y5eTBArY0Wrx4xPdbkbtlUe1QatubJ3
 t+vS6i1hK3AGIUzmWBJLKsnBgXKuK6RhAfcdgrtK/kgb0UfE5czIT8xpTbfOipfaaUoQXX9lkBW75ctL3ZfxtdmlnLkYqpF70bkgqmSqmkbQIBqyeuHbD2mH
 TtDWG4NFfaJN5vqbEMi18AS+sBQ3PoCISPjpCrYBaorRzAlMNYp3KQY57FYiY+QfeX/kiCRfDZEZY7wB8dwRaY9fOMMm/LwUF3lzV3+ZceBRPapJ27IKRQTO
 Ih6WPFL9kontzv4pECaV6bYeG61eyrhJX5twcoyRdaAwnDa9Yt530fxyl8VNfKwZHPASNV7LQLBOEO728Nbb5eVhTFcnS2HTxmDcDPo0Sz9tV9g8Lfk=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

Thank you for your reply.

On 2020.07.16 05:08 Rafael J. Wysocki wrote:
> On Wed, Jul 15, 2020 at 10:39 PM Doug Smythies <dsmythies@telus.net> wrote:
>> On 2020.07.14 11:16 Rafael J. Wysocki wrote:
>> >
>> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ...
>> > Since the passive mode hasn't worked with HWP at all, and it is not going to
>> > the default for HWP systems anyway, I don't see any drawbacks related to making
>> > this change, so I would consider this as 5.9 material unless there are any
>> > serious objections.
>>
>> Good point.

Actually, for those users that default to passive mode upon boot,
this would mean they would find themselves using this.
Also, it isn't obvious, from the typical "what driver and what governor"
inquiry.

>> Some of the tests I do involve labour intensive post processing of data.
>> I want to automate some of that work, and it will take time.
>> We might be into the 5.9-rc series before I have detailed feedback.
>>
>> However, so far:
>>
>> Inverse impulse response test [1]:
>>
>> High level test, i5-9600K, HWP-passive (this patch), ondemand:
>> 3101 tests. 0 failures. (GOOD)
>>
>> From [1], re-stated:
>> > . High level: i5-9600K: 2453 tests, 60 failures, 2.45% fail rate. (HWP-active - powersave)
>> > . Verify acpi-cpufreq/ondemand works fine: i5-9600K: 8975 tests. 0 failures.
>>
>> My version of that cool Alexander named pipe test [2] serialized workflow:
>>
>> HWP-passive (this patch), performance: PASS.
>>
>> From [2], re-stated, and also re-tested.
>> HWP-disabled passive - performance: FAIL.
> 
> But I'm not quite sure how this is related to this patch?

It isn't. The point being that it is different.
But yes, that failure is because of our other discussion [3].

> 
> This test would still fail without the patch if the kernel was started
> with intel_pstate=passive in the kernel command line, wouldn't it.

Yes.

> 
> > Although, I believe the issue to be EPB management, [3].
> 
> Well, that's kind of unexpected.
> 
> If this really is the case, then it looks like the effect of the EPB
> setting on the processor is different depending on whether or not HWP
> is enabled.
> 
>> And yes, I did see the reply to [3] that came earlier,
>> And have now re-done the test, with the referenced patch added.
>> It still is FAIL. I reply to the [3] thread, eventually.
>>
>> [1] https://marc.info/?l=linux-pm&m=159354421400342&w=2
>> [2] https://marc.info/?l=linux-pm&m=159155067328641&w=2
>> [3] https://marc.info/?l=linux-pm&m=159438804230744&w=2
>>
>> Kernel:
>>
>> b08284a541ad (HEAD -> k58rc5-doug) cpufreq: intel_pstate: Avoid enabling HWP if EPP is not supported
>> 063fd7ccabfe cpufreq: intel_pstate: Implement passive mode with HWP enabled
>> 730ccf5054e9 cpufreq: intel_pstate: Allow raw energy performance preference value
>> bee36df01c68 cpufreq: intel_pstate: Allow enable/disable energy efficiency
>> 199629d8200e cpufreq: intel_pstate: Fix active mode setting from command line
>> 11ba468877bb (tag: v5.8-rc5, origin/master, origin/HEAD, master) Linux 5.8-rc5
>>
>> Rules for this work:
>>
>> . never use x86_energy_perf_policy.
>> . For HWP disabled: never change from active to passive or via versa, but rather do it via boot.
>> . after boot always check and reset the various power limit log bits that are set.
>> . never compile the kernel (well, until after any tests), which will set those bits again.
>> . never run prime95 high heat torture test, which will set those bits again.
>> . try to never do anything else that will set those bits again.
>>
>> To be clear, I do allow changing governors within the context of the above rules.
> 
> Thanks for the feedback!

