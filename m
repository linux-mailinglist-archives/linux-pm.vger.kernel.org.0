Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1A6221662
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 22:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgGOUji (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 16:39:38 -0400
Received: from cmta20.telus.net ([209.171.16.93]:53941 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbgGOUjh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Jul 2020 16:39:37 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id voBejhx9xljNxvoBgjp2il; Wed, 15 Jul 2020 14:39:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1594845575; bh=9fRULD8XlrgndUg5eFygGTTDWcJ/HwRXNiPujg/A/Qc=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=1fvtETkLR13imU+Vlzy1L7GOkj7CLH2z21fXJ9DDEaoqv6sxI7WRhSXOJw5fTuyT8
         WoRFqST6TtfEllXl68MlT8KKs1qY9O9E27x87xXsanipAZ1QpcslVOcZCgybhqCL7i
         05hY8TaopCbN43WaPsjj99Xdx/U5/0UI32Gfnkdy0lSXEfYpKOJ5yYH5dUh8HJlLry
         WWLIFLA4M75+0zZyk9cQim6qdEAnrcvBbrvB2ycHQQYl0QItLwO/0HmF8B66Swu+sW
         vitp5pvvbLC0KpmQ5EqaxfSup+4u/jqIFrYIMq/E+nCG0aupBu6Fb6vFUf9xoKNTRF
         G+dhlq58AesXA==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=Z8aS40ZA c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=QyXUC8HyAAAA:8
 a=gu6fZOg2AAAA:8 a=oGXUH_wexJK_5aFMPiMA:9 a=CjuIK1q_8ugA:10 a=-FEs8UIgK8oA:10
 a=NWVoK91CQyQA:10 a=2RSlZUUhi9gRBrsHwhhZ:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'Linux Documentation'" <linux-doc@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Francisco Jerez'" <francisco.jerez.plata@intel.com>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
References: <3955470.QvD6XneCf3@kreacher>
In-Reply-To: <3955470.QvD6XneCf3@kreacher>
Subject: RE: [PATCH] cpufreq: intel_pstate: Implement passive mode with HWP enabled
Date:   Wed, 15 Jul 2020 13:39:29 -0700
Message-ID: <000f01d65ae8$0c607990$25216cb0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdZaCuFLSnPOiWVOTIG1A3EnWVHa7QApTu8Q
X-CMAE-Envelope: MS4wfEv3zAJX+Q5FKLqV55u0UjRRufhzfTzlTepfJsLiSoJWGqbw8G/MQ22qOAH6ryMIj4EApSXZNOoxIM3vu/LpAhtmjiuJ3Nlg9oPXDkVvj8H+g//WH7lV
 vLLp4hl4TIMSuRJLG7JXKiI3RMVZ3sY5v+cPWtimZGTorfLZ6CqGTfb4kMwIOa0p+n9V+9/8qpmrKJ/OtxZF7G5lYOc5PIRbFJt5rRTOo9Ek0kFPXfOmQ3+R
 MfBQA1vgqC82NbdXeX0JCWvKWMweqd05DuWNpYC64+0gbd2vIXYzrSlzvICQ3xxKAWO5XElfi7rvVZ6YflwlAyXVDyD/e+Gg7PuMQ/MqADph4qNUN6yD/A6C
 5WYvxSp+zL2ekinuJuOQXZCWUwf4fWQDp3oKGaeAB0y3b1lFOS2XHffWPor5PIPAnDTZRx8SoY0LV4HEjzpEZ09kWd/gSQ==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020.07.14 11:16 Rafael J. Wysocki wrote:
> 
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
...
> Since the passive mode hasn't worked with HWP at all, and it is not going to
> the default for HWP systems anyway, I don't see any drawbacks related to making
> this change, so I would consider this as 5.9 material unless there are any
> serious objections.

Good point.
Some of the tests I do involve labour intensive post processing of data.
I want to automate some of that work, and it will take time.
We might be into the 5.9-rc series before I have detailed feedback.

However, so far:

Inverse impulse response test [1]:

High level test, i5-9600K, HWP-passive (this patch), ondemand:
3101 tests. 0 failures. (GOOD)

From [1], re-stated:
> . High level: i5-9600K: 2453 tests, 60 failures, 2.45% fail rate. (HWP-active - powersave)
> . Verify acpi-cpufreq/ondemand works fine: i5-9600K: 8975 tests. 0 failures.

My version of that cool Alexander named pipe test [2] serialized workflow:

HWP-passive (this patch), performance: PASS.

From [2], re-stated, and also re-tested.
HWP-disabled passive - performance: FAIL.
Although, I believe the issue to be EPB management, [3].

And yes, I did see the reply to [3] that came earlier,
And have now re-done the test, with the referenced patch added.
It still is FAIL. I reply to the [3] thread, eventually.

[1] https://marc.info/?l=linux-pm&m=159354421400342&w=2
[2] https://marc.info/?l=linux-pm&m=159155067328641&w=2
[3] https://marc.info/?l=linux-pm&m=159438804230744&w=2

Kernel:

b08284a541ad (HEAD -> k58rc5-doug) cpufreq: intel_pstate: Avoid enabling HWP if EPP is not supported
063fd7ccabfe cpufreq: intel_pstate: Implement passive mode with HWP enabled
730ccf5054e9 cpufreq: intel_pstate: Allow raw energy performance preference value
bee36df01c68 cpufreq: intel_pstate: Allow enable/disable energy efficiency
199629d8200e cpufreq: intel_pstate: Fix active mode setting from command line
11ba468877bb (tag: v5.8-rc5, origin/master, origin/HEAD, master) Linux 5.8-rc5

Rules for this work:

. never use x86_energy_perf_policy.
. For HWP disabled: never change from active to passive or via versa, but rather do it via boot.
. after boot always check and reset the various power limit log bits that are set.
. never compile the kernel (well, until after any tests), which will set those bits again.
. never run prime95 high heat torture test, which will set those bits again.
. try to never do anything else that will set those bits again.

To be clear, I do allow changing governors within the context of the above rules.

... Doug


