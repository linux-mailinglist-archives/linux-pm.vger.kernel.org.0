Return-Path: <linux-pm+bounces-41302-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEl+JL5BcmnpfAAAu9opvQ
	(envelope-from <linux-pm+bounces-41302-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 16:26:54 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0944568C0E
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 16:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0AC686D430
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 14:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A5134AAE2;
	Thu, 22 Jan 2026 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hz/q2RQy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7477315D25;
	Thu, 22 Jan 2026 14:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769092902; cv=none; b=TODOsQiUZid5auD2BkqHHpU1EQONW3jxucakNC84hXjzpt0cESwY0yTfnSzdL6abWdenmAXpbYbeni/w75rxokUZ5nT9qhoE/LPNOJgxtu0fI7yFbU95XfzLPE2P2r97z6Q1OdPNTw2MdunMBLf2sXbFU0OxBn9liqmQKWV/8CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769092902; c=relaxed/simple;
	bh=zG0ILCbJZHZjRnNt+ywYJAScfiKo16BgeNrGUkNybjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIxIFKW97pplqNjvxDzTVCzZXx18gKPpVBwsUrKMVYm8Va3kFvIHiiyBjVo8eKy2M/Mr3ghD4E3DZT2s/feNzPTjp79ZYuBNmXrdkxLi5srkol6ClP9q5HxPfeQFr7cQN7jlMV/Umz2PjYA41Mt1/6j1NsL1LV5wYULMC40letY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hz/q2RQy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60M0x22w010093;
	Thu, 22 Jan 2026 14:40:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=X66k6uCJZ5ko/KQv3KFeFir9muTBP/
	s+7BdrEE2gUT4=; b=hz/q2RQyPn5Dzqkzk/U2F4B+j8cOEeNGwn2IbOqfoaTFd9
	aEYCbCVjmz6/i0z0ZdNj6myQtYBaizWiJrU9q7OTKEX+vpNw4sikty1Y2L4iusgn
	kTFUlX67VCx6NgvE6d7JiaJOUGXWpL2zB6iaXHVMmdQdWPbHXgHfjs2GFVsUv2vz
	/wrnLPtUZx87LvTNN76N0KZWLlY+z4i5Kk/JbPj1Rxcw4FCJBYpSN+KySvQ5Zzhm
	FzZdrlqOBucY7006jd3V0uybg8lv/5dNMBC9q9rTGXLC3dFAMujNikqR6wTRTRJJ
	VH8ECVJvGh7Nl10KZVS8YQ15yqQpTUqjx2tUmMDA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyukh136-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 14:40:53 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60MEebR0009462;
	Thu, 22 Jan 2026 14:40:52 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyukh134-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 14:40:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60MDVv7Z009266;
	Thu, 22 Jan 2026 14:40:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brp8kjmvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 14:40:51 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60MEeloG8782198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 14:40:48 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEDEC20043;
	Thu, 22 Jan 2026 14:40:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49A7E20040;
	Thu, 22 Jan 2026 14:40:47 +0000 (GMT)
Received: from osiris (unknown [9.52.214.206])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 22 Jan 2026 14:40:47 +0000 (GMT)
Date: Thu, 22 Jan 2026 15:40:45 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mel Gorman <mgorman@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
        Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Xin Zhao <jackzxcui1989@163.com>, linux-pm@vger.kernel.org,
        linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 05/15] s390/time: Prepare to stop elapsing in
 dynticks-idle
Message-ID: <20260122144045.38254A3e-hca@linux.ibm.com>
References: <20260116145208.87445-1-frederic@kernel.org>
 <20260116145208.87445-6-frederic@kernel.org>
 <20260121121748.9719Bab-hca@linux.ibm.com>
 <aXEVM-04lj0lntMr@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXEVM-04lj0lntMr@localhost.localdomain>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEwOCBTYWx0ZWRfX8gLINXy+Z9k3
 JUXospF8/2ZiRx312Y+OKWseVZGg87tW/AHi3UlcOjuT+Z1ExuPuMqf1XJENc88uV/QlgzIgZf4
 i9BOxDLnNqkoy1U+F+zL8nKfx/iMZ47ifh+bMF1jASfSP9hUZOW0SvObci+fUL2S6kNuFs2NNCy
 M7gWzPQvuGQ7jkCt3ccOoUyPrHNzmdmR2ZOlLi132uYlRwE4YgDA6y3fwQKLwScwus2fPLRP7QU
 t7q44dK3dIevzpjTIMgpwqQqz2b97Y8miAVV/kV9XhMYiekT97153mrZNtubhE6vGNzuV3+6L99
 KOb/6f0FpqLNyo0XGv02dabyOIq6sNrZ882gNUENb5MCikihkUj8iMli3jkpFzLQdV+RMeaETfa
 pspBiqzdAE3Mjb8l5abEAWTYui9hnRG5KJF80dn71yWAl/GoMOoIjKdgPYkTPjAMzQxvNbLnbBh
 JztBjQeZzudk2cE9YAA==
X-Authority-Analysis: v=2.4 cv=bsBBxUai c=1 sm=1 tr=0 ts=697236f5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tulLadCw3Y6qvbDvsxgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 7VXiPjiK4Lzhma9iWRs041PVpUTj7AwF
X-Proofpoint-GUID: NDKlZuiFLoyGkNxQOUrbSEnRaNfS7StP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601220108
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41302-lists,linux-pm=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linux.ibm.com,linutronix.de,google.com,gmail.com,arm.com,redhat.com,siemens.com,nvidia.com,suse.de,ellerman.id.au,infradead.org,goodmis.org,linaro.org,163.com,lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[ibm.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hca@linux.ibm.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	RCVD_COUNT_TWELVE(0.00)[13];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,linux.ibm.com:mid]
X-Rspamd-Queue-Id: 0944568C0E
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 07:04:35PM +0100, Frederic Weisbecker wrote:
> BTW here is a question for you, does the timer (as in get_cpu_timer()) still
> decrements while in idle? I would assume not, given how lc->system_timer
> is updated in account_idle_time_irq().

It is not decremented while in idle (or when the hypervisor schedules
the virtual cpu away). We use the fact that the cpu timer is not
decremented when the virtual cpu is not running vs the real
time-of-day clock to calculate steal time.

> And another question in this same function is this :
> 
>     lc->steal_timer += idle->clock_idle_enter - lc->last_update_clock;
> 
> clock_idle_enter is updated right before halting the CPU. But when was
> last_update_clock updated last? Could be either task switch to idle, or
> a previous idle tick interrupt or a previous idle IRQ entry. In any case
> I'm not sure the difference is meaningful as steal time.
> 
> I must be missing something.

"It has been like that forever" :) However I do agree that this doesn't seem
to make any sense. At least with the current implementation I cannot see how
that makes sense, since the difference of two time stamps, which do not
include any steal time are added.

Maybe it broke by some of all the changes over the years, or it was always
wrong, or I am missing something too.

Will investigate and address it if required. Thank you for bringing this up!

> > Not sure what to do with this. I thought about removing those sysfs files
> > already in the past, since they are of very limited use; and most likely
> > nothing in user space would miss them.
> 
> Perhaps but this file is a good comparison point against /proc/stat because
> s390 vtime is much closer to measuring the actual CPU halted time than what
> the generic nohz accounting does (which includes more idle code execution).

Yes, while comparing those files I also see an unexpected difference of
several seconds after two days of uptime; that is before your changes.

In theory the sum of idle and iowait in /proc/stat should be the same like the
per-cpu idle_time_us sysfs file. But there is a difference, which shouldn't be
there as far as I can tell. Yet another thing to look into.

> > Guess I need to spend some more time on accounting and see what it would take
> > to convert to VIRT_CPU_ACCOUNTING_GEN, while keeping the current precision and
> > functionality.
> 
> I would expect more overhead with VIRT_CPU_ACCOUNTING_GEN, though that has yet
> to be measured. In any case you'll lose some idle cputime precision (but
> you need to read that through s390 sysfs files) if what we want to measure
> here is the actual halted time.
> 
> Perhaps we could enhance VIRT_CPU_ACCOUNTING_GEN and nohz idle cputime
> accounting to match s390 precision. Though I expect some cost
> accessing the clock inevitably more often on some machines.

Let me experiment with that, but first I want to understand the oddities
pointed out above.

