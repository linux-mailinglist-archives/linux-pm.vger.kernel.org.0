Return-Path: <linux-pm+bounces-41166-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA7gK3MkcGlRVwAAu9opvQ
	(envelope-from <linux-pm+bounces-41166-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 01:57:23 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5844EC2A
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 01:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5E9BC689EC2
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 12:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E912942B745;
	Tue, 20 Jan 2026 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ee1OxE3i"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D59C42B743;
	Tue, 20 Jan 2026 12:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768913002; cv=none; b=hsMBBDSrw7zu0v5UWHdl47Y9OtIQ1/ah3Am5GTrMNj8tVoROj1frZOZeVvt265k2weWWFzTpjFpZIxywtFeY/gWtIliZgehkZG1604whaXJnkuYFyBpNEFU+bSFo5rsqbUilloExj53wHm9Rmv0YWXMedRbHDPJP8GRWKMbuj0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768913002; c=relaxed/simple;
	bh=uTnWnuT5nZjP1ACUB+50KtGVMlu4ygPFV0GCg/cr8EY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RjSMlapXtWTj1Q3c9Tx1d2qkRBnyMAfn3jUhccNu/0tMjPvAShCbXApumdcEsDi5/Shsi5oWZlQocon0ow6QZHswv1Dp7LQQ81USrgtbawBr36NpzxJZ9WbWhVkKAAe4VBK+Gbbm+UZoTOFKJVUmgFkp0xP/UQT5WXFcAeemY3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ee1OxE3i; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60JMDxiW010632;
	Tue, 20 Jan 2026 12:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ffMlGW
	HI+RqCf98HD/bTdif0iJK1j78ItcOcHVWDDZI=; b=ee1OxE3iltX1dUT+dWt8uq
	CDS2R+Un6yKYG/mL81PmzXxcbpJZtwwwDkbkhNbUpe98SG4I5d/zZZg+/5Zmcr3N
	nXOGW4BErwekCDdfe7fmO/ozIP+O6JZ2yEi+0U5qTpAOw37maRS8aec4N82EDj9b
	br2H2+vT3AAUCatiuUJF540gf8LSd6+PvA64DYDswasxe7kwyXhfjZvpBKgH4Dwv
	mtVdXnjtJSGZJUMHrmUL8NL6d+jOMtQfOqxvAvFgIDh4p60Q6VrB5X8J8aoLQ2NL
	jgYgD4u8VJmVrdaf59KCMWfg3FqvHrwAXd9fv6HLPCKVZSXruPMAaySEgcybaqjg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23rwuu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 12:42:21 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60KCgLRH006897;
	Tue, 20 Jan 2026 12:42:21 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23rwuu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 12:42:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60KBU9I3006424;
	Tue, 20 Jan 2026 12:42:20 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brqf1cj4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 12:42:20 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60KCgGGd56426764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 12:42:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68B3120043;
	Tue, 20 Jan 2026 12:42:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32F752004B;
	Tue, 20 Jan 2026 12:42:09 +0000 (GMT)
Received: from [9.124.220.45] (unknown [9.124.220.45])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Jan 2026 12:42:08 +0000 (GMT)
Message-ID: <a4037857-b161-4536-9a2e-2cf4c168736d@linux.ibm.com>
Date: Tue, 20 Jan 2026 18:12:08 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] tick/sched: Refactor idle cputime accounting
To: Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Kieran Bingham <kbingham@kernel.org>, Ben Segall <bsegall@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
        Xin Zhao <jackzxcui1989@163.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jan Kiszka <jan.kiszka@siemens.com>, linuxppc-dev@lists.ozlabs.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-pm@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Nicholas Piggin <npiggin@gmail.com>, linux-s390@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
References: <20260116145208.87445-1-frederic@kernel.org>
 <aWpRxyt8HuXkSuxs@localhost.localdomain>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <aWpRxyt8HuXkSuxs@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9VV4fpwLWP4PF7lZThEunm4rJxceXtvg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDEwMiBTYWx0ZWRfXx9yKJqyysrW6
 O/oFmXr8RITUzlMs5DnwBfn5ZTKL+8h6NXFtpi2UTke7YxOrw8thQeRvFH1Rqw/buSAqehlaesH
 nHkvyGOjnOPcbxQ0RedRbvPpZErqOlolFyjPwFZuw0OWJkuKqgvLPcqtC4kSS4X+cJxhYzBRkp/
 XnJk0Lypiae2n00EVXJV42JlQ1FJyASmG26LSchKXjRntd6qlJr1c6gSSw5RP+e9WK8va47/EC8
 JiRCrB9ruCncX7lC5AmMr8ff/5fj+3JgzCarsyq+Yj3AtVOG8kHn8SE26/AoSixmgtANzoseJ6E
 vwtwRXROIg8svyoC+arO4xzyzRousjDjafz2VyQ/6ztbnbQBV5mVIHW70HHcgLh0W5FW3oIyVX9
 qPURUSaTIo+rO5pT60kuxPZF0baSr0nQnBThZy6pw6ip5owcY+UTLBqKwIskNeyMtSH6C40GGKu
 Jqvps5z2AAIMS4bCkPg==
X-Authority-Analysis: v=2.4 cv=J9SnLQnS c=1 sm=1 tr=0 ts=696f782e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=if_OGZEsJgfgBzv6FlkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: xGI-wI0OTynA7CpsDBMAgvCg4UMlutJg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_03,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601200102
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,goodmis.org,google.com,ellerman.id.au,redhat.com,linaro.org,163.com,linux.ibm.com,suse.de,siemens.com,lists.ozlabs.org,arm.com,vger.kernel.org,nvidia.com,infradead.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-41166-lists,linux-pm=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[ibm.com,none];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sshegde@linux.ibm.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[13];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linux.ibm.com:mid]
X-Rspamd-Queue-Id: 7C5844EC2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Hi Frederic.

On 1/16/26 8:27 PM, Frederic Weisbecker wrote:
> I forgot to mention I haven't yet tested CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
> (s390 and powerpc).
> 
> Thanks.


tl;dr

I ran this on powerNV(Non virtualized) with 144 CPUs with below config. (default ones)
Patch *breaks* the cpu idle stats most of the time. idle values are wrong.


Detailed info:

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++

In config i have this:
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is not set
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set

+++++++++

When system is fully idle, i see this.

06:44:26 AM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
06:44:27 AM  all    0.01    0.00    0.01    0.00   57.20    0.00    0.00    0.00    0.00   42.79
06:44:28 AM  all    0.02    0.00    0.03    0.00   55.73    0.00    0.00    0.00    0.00   44.22
06:44:29 AM  all    0.01    0.00    0.00    0.00   56.23    0.00    0.00    0.00    0.00   43.77

- Seeing 50%+ in irq time, which is clearly wrong.

+++++++++
When running stress-ng --cpu=72 (expectation is 50% idle time)
06:48:12 AM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
06:48:13 AM  all   49.98    0.00    0.01    0.00   15.81    0.00    0.00    0.00    0.00   34.20
06:48:14 AM  all   49.93    0.00    0.00    0.00   15.15    0.00    0.00    0.00    0.00   34.91
06:48:15 AM  all   49.99    0.00    0.01    0.00   15.29    0.00    0.00    0.00    0.00   34.72

- Wrong values again. 50% is expected idle time.

+++++++++
system is idle again.
06:48:46 AM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
06:48:47 AM  all    0.00    0.00    0.00    0.00   63.93    0.00    0.00    0.00    0.00   36.07
06:48:48 AM  all    0.02    0.00    0.00    0.00   63.78    0.01    0.00    0.00    0.00   36.18
06:48:49 AM  all    0.00    0.00    0.00    0.00   63.77    0.00    0.00    0.00    0.00   36.23

- Wrong values again. irq increased further.

+++++++++

I have seen the below warnings too.
WARNING: kernel/time/tick-sched.c:1353 at tick_nohz_idle_exit
[    T0] WARNING: kernel/time/tick-sched.c:1353 at tick_nohz_idle_exit+0x148/0x150, CPU#4: swapper/4/0
[    T0] Modules linked in: vmx_crypto gf128mul
[    T0] CPU: 4 UID: 0 PID: 0 Comm: swapper/4 Tainted: G        W           6.19.0-rc5-00683-gbe7e8f3d5116 #61 PREEMPT(full)
[    T0] Tainted: [W]=WARN
[    T0] Hardware name: 0000000000000000 POWER9 0x4e1202 opal:v7.1 PowerNV
[    T0] NIP [c0000000002c8210] tick_nohz_idle_exit+0x148/0x150
[    T0] LR [c00000000022f10c] do_idle+0x1dc/0x328


WARNING: kernel/time/tick-sched.c:1274 at tick_nohz_get_sleep_length
     T0] NIP [c0000000002c7fc0] tick_nohz_get_sleep_length+0x108/0x110
[    T0] LR [c000000000ca1548] menu_select+0x3c0/0x7b4
[    T0] Call Trace:
[    T0] [c000000003197e10] [c000000003197e50] 0xc000000003197e50 (unreliable)
[    T0] [c000000003197e50] [c000000000ca1548] menu_select+0x3c0/0x7b4
[    T0] [c000000003197ed0] [c000000000c9f120] cpuidle_select+0x34/0x48
[    T0] [c000000003197ef0] [c00000000022f184] do_idle+0x254/0x328


+++++++++++++++++++++++++++++++++++++++++++++++++++++++++

I went back to baseline to confirm the original behaviour.
(d613f96096e4) Merge timers/vdso into tip/master

07:02:17 AM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
07:02:18 AM  all    0.01    0.00    0.01    0.01    1.19    0.00    0.00    0.00    0.00   98.77
07:02:19 AM  all    0.01    0.00    0.01    0.00    0.84    0.00    0.00    0.00    0.00   99.14
07:02:20 AM  all    0.00    0.00    0.01    0.00    0.99    0.00    0.00    0.00    0.00   99.00
07:02:21 AM  all    0.01    0.00    0.00    0.00    0.83    0.00    0.00    0.00    0.00   99.16

Which is the working as expected.



PS: Initial data. I haven't gone through the series yet.

