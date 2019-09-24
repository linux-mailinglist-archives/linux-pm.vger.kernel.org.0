Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA2BABD0F4
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2019 19:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406705AbfIXRwV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Sep 2019 13:52:21 -0400
Received: from cmta20.telus.net ([209.171.16.93]:47517 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbfIXRwU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Sep 2019 13:52:20 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id CoyziGLdmN5I9Coz0iV9ND; Tue, 24 Sep 2019 11:52:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1569347539; bh=H/XOP2fKipCtKvfVrIfB/bod/HsAwHO9dwoqUJh3Vmw=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=JK8xERefjpCMRSd429miCFrrPAEMqXvG/eOfsrhP21bvGjR7/bTgkx2zBM/slmxrB
         XVupk5r/vRq5mX/5OkaGevz1bbdF9Z9dWm32zfn/mI+t/LCKQh3HiBugU6Li/TpQ6V
         iPL1xRLPly4FCqem7gAPprOWEPZY5E2wOyOnRm5633W0jeQ43VdR73C+Ezgb31TUEd
         FPIMIcpTQPbBZlAr8vaJ1mFztMP6P+sM3qw7jwhZZB0D20FkT/iPQkgry4CVaJ3zRA
         FFMOOwW1C4YCJHrJ0Ps0Ekq11/PeM5VrHZ5s2nd77wNUesc/AWaGTkYxyGMJAx5zK7
         T/2xJmFqRS8JA==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=K/Fc4BeI c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=aatUQebYAAAA:8 a=aCwPpCUuJDWdtZRKGx0A:9 a=CjuIK1q_8ugA:10
 a=7715FyvI7WU-l6oqrZBK:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Mel Gorman'" <mgorman@techsingularity.net>
Cc:     "'Giovanni Gherdovich'" <ggherdovich@suse.cz>, <x86@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <matt@codeblueprint.co.uk>, <viresh.kumar@linaro.org>,
        <juri.lelli@redhat.com>, <pjt@google.com>,
        <vincent.guittot@linaro.org>, <qperret@qperret.net>,
        <dietmar.eggemann@arm.com>, <srinivas.pandruvada@linux.intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <peterz@infradead.org>,
        <bp@suse.de>, <lenb@kernel.org>, <rjw@rjwysocki.net>
References: <20190909024216.5942-1-ggherdovich@suse.cz> <20190909024216.5942-2-ggherdovich@suse.cz> <000e01d568b5$87de9be0$979bd3a0$@net> <000301d56a76$0022e630$0068b290$@net> <1568730313.3329.1.camel@suse.cz> <001a01d56ef8$7abb07c0$70311740$@net> <20190924080608.GA3321@techsingularity.net>
In-Reply-To: <20190924080608.GA3321@techsingularity.net>
Subject: RE: [PATCH 1/2] x86,sched: Add support for frequency invariance
Date:   Tue, 24 Sep 2019 10:52:13 -0700
Message-ID: <000b01d57300$cf611ce0$6e2356a0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdVyrvSM5wisEN5wR+e/x84tTXNN3QAT9lPw
X-CMAE-Envelope: MS4wfCgcBy1c7Po5AHQoWI4xadnUF/6gDYl0DmdDkj0h/8f4Q6rS7PSt42oPKQSlXfJ9s13UoXpUp1M/R616MMHftQmbwg36GhHPFSOnX4fBItc4C39OKmOd
 WhHWONSXcUUwmjncbyI4PSkyKoQ3F2HaXDMIyU5OFnXzGVvlAGWsYEcBVDWk0u48H+yIxb0oI5nHzWYD0ITXVq3vPukQHinPr+XFkuVCWbIkqV1OnADoPFgr
 i1wfnArLathDVIo3TSLlVlHEDPRWuhfIGwdBonbgEhjQZkVTytEgrFQPQLoFws8tsPEPPteNTH+iVkZMxtyFEtV/IuQDmVWKYn35OOuppbpBCwnTDjEPybHK
 Oz/p+kFPqTONaNjcI7SQLqHj9O8kjsi0cCph8O56W38wP13ZL9Ka3N7gfe5q+1q9FHT81skToQB8QN1lTf2uoLmxQFGzYN9xdCARBYat8yIbhXzS6SertJ81
 dtuVNyipLJhKs5cI3vaOkrtktZyg1JtMgL/wxQjcT/K9RLpOVgmrefxrOjM6XyTdF9WHjWRYuFriVeXy5KQq+haxglv4q06f8hl667VWt4go+H6aUkav5dZ8
 X0MEUZrain0CWdhSqqMHl+O7WSL2nnLGk2reA/pHNpAUL4LH4d2X9UU74J0cYRsEVLoZbz/GFmWIY+mD7creLKyPHr1FKuY5R4GU3OqyYTGyoaVeVsEqUwop
 4RZjsyBUDpuTqja3p+3ANNu+ijV3va9/nrqM9qSiXwsCixmdNr652Q==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019.09.24 01:06 Mel Gorman wrote:
> On Thu, Sep 19, 2019 at 07:42:29AM -0700, Doug Smythies wrote:
>> On 2019.09.17 07:25 Giovanni Gherdovich wrote:
>>>On Wed, 2019-09-11 at 08:28 -0700, Doug Smythies wrote:
>>> [...]
> 

> Hence, I think this patchset should be considered on its own merits.

Agree. 

> I think the patch is fine and should be merged with the main caveat being
> that some CPU families may need to use a different calculation to account
> for turbo boost which is a per-arch and per-cpu-family decision.

Agree.

> What, if anything, should change in this patchset before it can be merged?

Nothing, and apologies for the tangential discussion.

> Is that an acked-by?

Absolutely, if I am worthy of ack'ing then:

Acked-by: Doug Smythies <dsmythies@telus.net>

... Doug


