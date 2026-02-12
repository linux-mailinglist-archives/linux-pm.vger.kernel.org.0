Return-Path: <linux-pm+bounces-42539-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHErILl7jWng3AAAu9opvQ
	(envelope-from <linux-pm+bounces-42539-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 08:05:29 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC4C12ADA5
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 08:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A16D311FDDB
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 07:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9305D2673B7;
	Thu, 12 Feb 2026 07:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HGR7OYn0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5AEBA34;
	Thu, 12 Feb 2026 07:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770879825; cv=none; b=gNprzydN6tjTqqcAgaH2JfIvUizhE1oM1EyusTWKd+YAh7vVUPHeuk2CRraPQ9mG4aQSnKtL+unvIN0Tv8jLdZsqgndRMvy/DMCbaeyaogaZmNfixFVDZcfKZ/u65eVQepO5wtxnheQVODlAFwyLgVYkebmhdkpcpIYLNFNqdF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770879825; c=relaxed/simple;
	bh=0oqIw+Gturzi0rrFtdzfCCRlq7PyGqgLJyjO9ANCyr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O9CXUKho7XW/ooZfjtqErtMQKNP258fIBzn7VAt7WYLxOy8wDLkFDH02kbgXdQTX4gzZh6U1xb5sQ3MyqjjRnCTZLmSbcp8ZltZPSchr9ucCrIIYbYbzBPB/kjbCPLE0Rjo1BmaUgpfo9FfgeM0lA4DjCvfKcpigrQoKQvAXTyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HGR7OYn0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61C1Ose0343472;
	Thu, 12 Feb 2026 07:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=poZjhN
	XE0/uh1v8vuuLiSQGegGURE+K+YLsaDlo9OTg=; b=HGR7OYn0Otva5nK9+YD49W
	hOsn2HBVXfQSpoPiOGcHve93HlE6sAO2IkHNlV24LD70O1wbk/Y5QRfnusrwESDo
	rhgpYH6ImMMQA0rG7Vl3ACyeTxnNs3MreDJYM9TTIBE6VUkd2pVLSgaw9hz0EZg+
	QknFPjOTAtyCJT6I5zp4tywTmLhOqxYIGRJJ34fpAhZ09sddzq1gbM4cbqGPY8YH
	oBDzOAaJwpmJnJRzqBh66oxPIjqsB6Ch4CiPRiKCwjeYrH25/MlVBNJRqMhYBBzL
	8aYPgPLZRJmu7vp4VRJAf+e98ZtHAM1hAWuhRMPeIJbmBxFG4QXEU1poCyfL1COw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696umvdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 07:02:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61C3v4pY012996;
	Thu, 12 Feb 2026 07:02:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6h7kh5p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 07:02:48 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61C72iYG13959476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Feb 2026 07:02:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E66B20040;
	Thu, 12 Feb 2026 07:02:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 259D32004E;
	Thu, 12 Feb 2026 07:02:37 +0000 (GMT)
Received: from [9.109.215.252] (unknown [9.109.215.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Feb 2026 07:02:36 +0000 (GMT)
Message-ID: <3b71bdb1-2dbe-420f-8fae-5cb1ab3a4ba9@linux.ibm.com>
Date: Thu, 12 Feb 2026 12:32:36 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15 v2] tick/sched: Refactor idle cputime accounting
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kieran Bingham <kbingham@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Xin Zhao <jackzxcui1989@163.com>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Michael Ellerman <mpe@ellerman.id.au>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>, linux-s390@vger.kernel.org,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        linux-pm@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
References: <20260206142245.58987-1-frederic@kernel.org>
 <f5f7cc0e-81c1-49c4-9bfa-61b111c69ae2@linux.ibm.com>
 <aYy3GTXDwZFM3VLy@localhost.localdomain>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <aYy3GTXDwZFM3VLy@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=YZiwJgRf c=1 sm=1 tr=0 ts=698d7b1a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=Byx-y9mGAAAA:8 a=jna3-dR-LpdznfkkQtQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ykNMXiJuLMZvY8SHVx1k92NnfL__mZAj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDA0OCBTYWx0ZWRfXwf0I6im/SFoz
 UOZhM4tcMuDmndSC7aO0LIN6Sbg1f18jEaekOgqBBncr3g30fHinniII7kb9tqkFq3dwDbqpa0R
 iQazWnZ1+AcwvTuf8gZQMhXgpGv4dEGT8N55h0QfhCOiW+jU2yAZkMtivl+nRFys0k0iLwIEtYa
 PjICtoUofjQNMwydGqQ8yS+hm1uVNrjk5bSOFneE8/KGySNj4A9Rp9Rj/TxwCCFtjBX9besOB13
 fMIoo0FCrMM3upSaXNejT4ZOyS9GozjE+sJF7a2AE2h3RLQNuac5sGJpKh7+Ws7ETLUCdT56awV
 V2ITTAHZ5B9LC8Xcbq7iUdYQLWJsTZboEoUhgHc+1mq+XliqFe/o1SLUJ4bEUvkezdYQ5XWdRDK
 zx/OO7DBfS6fS09IPkWzH8gwmKWhv3MFhTgycMDvo9MhnJYj0gPttfpTFQaLbFdVq2CfMwQPuf9
 vVmPxM41fwgtNlUTDCQ==
X-Proofpoint-GUID: NCg8jEjEq3HhF8Orr5avhxKfyd3mZDhp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_02,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602120048
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42539-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.ibm.com,linaro.org,kernel.org,redhat.com,163.com,nvidia.com,gmail.com,suse.de,arm.com,google.com,ellerman.id.au,linutronix.de,siemens.com,infradead.org,goodmis.org,lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sshegde@linux.ibm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: DEC4C12ADA5
X-Rspamd-Action: no action



On 2/11/26 10:36 PM, Frederic Weisbecker wrote:
> Le Wed, Feb 11, 2026 at 07:13:45PM +0530, Shrikanth Hegde a écrit :
>> Hi Frederic,
>> Gave this series a spin on the same system as v1.
>>
>> On 2/6/26 7:52 PM, Frederic Weisbecker wrote:
>>> Hi,
>>>
>>> After the issue reported here:
>>>
>>>           https://lore.kernel.org/all/20251210083135.3993562-1-jackzxcui1989@163.com/
>>>
>>> It occurs that the idle cputime accounting is a big mess that
>>> accumulates within two concurrent statistics, each having their own
>>> shortcomings:
>>>
>>> * The accounting for online CPUs which is based on the delta between
>>>     tick_nohz_start_idle() and tick_nohz_stop_idle().
>>>
>>>     Pros:
>>>          - Works when the tick is off
>>>
>>>          - Has nsecs granularity
>>>
>>>     Cons:
>>>          - Account idle steal time but doesn't substract it from idle
>>>            cputime.
>>>
>>>          - Assumes CONFIG_IRQ_TIME_ACCOUNTING by not accounting IRQs but
>>>            the IRQ time is simply ignored when
>>>            CONFIG_IRQ_TIME_ACCOUNTING=n
>>>
>>>          - The windows between 1) idle task scheduling and the first call
>>>            to tick_nohz_start_idle() and 2) idle task between the last
>>>            tick_nohz_stop_idle() and the rest of the idle time are
>>>            blindspots wrt. cputime accounting (though mostly insignificant
>>>            amount)
>>>
>>>          - Relies on private fields outside of kernel stats, with specific
>>>            accessors.
>>>
>>> * The accounting for offline CPUs which is based on ticks and the
>>>     jiffies delta during which the tick was stopped.
>>>
>>>     Pros:
>>>          - Handles steal time correctly
>>>
>>>          - Handle CONFIG_IRQ_TIME_ACCOUNTING=y and
>>>            CONFIG_IRQ_TIME_ACCOUNTING=n correctly.
>>>
>>>          - Handles the whole idle task
>>>
>>>          - Accounts directly to kernel stats, without midlayer accumulator.
>>>
>>>      Cons:
>>>          - Doesn't elapse when the tick is off, which doesn't make it
>>>            suitable for online CPUs.
>>>
>>>          - Has TICK_NSEC granularity (jiffies)
>>>
>>>          - Needs to track the dyntick-idle ticks that were accounted and
>>>            substract them from the total jiffies time spent while the tick
>>>            was stopped. This is an ugly workaround.
>>>
>>> Having two different accounting for a single context is not the only
>>> problem: since those accountings are of different natures, it is
>>> possible to observe the global idle time going backward after a CPU goes
>>> offline, as reported by Xin Zhao.
>>>
>>> Clean up the situation with introducing a hybrid approach that stays
>>> coherent, fixes the backward jumps and works for both online and offline
>>> CPUs:
>>>
>>> * Tick based or native vtime accounting operate before the tick is
>>>     stopped and resumes once the tick is restarted.
>>>
>>> * When the idle loop starts, switch to dynticks-idle accounting as is
>>>     done currently, except that the statistics accumulate directly to the
>>>     relevant kernel stat fields.
>>>
>>> * Private dyntick cputime accounting fields are removed.
>>>
>>> * Works on both online and offline case.
>>>
>>> * Move most of the relevant code to the common sched/cputime subsystem
>>>
>>> * Handle CONFIG_IRQ_TIME_ACCOUNTING=n correctly such that the
>>>     dynticks-idle accounting still elapses while on IRQs.
>>>
>>> * Correctly substract idle steal cputime from idle time
>>>
>>> Changes since v1:
>>>
>>> - Fix deadlock involving double seq count lock on idle
>>>
>>> - Fix build breakage on powerpc
>>>
>>> - Fix build breakage on s390 (Heiko)
>>>
>>> - Fix broken sysfs s390 idle time file (Heiko)
>>>
>>> - Convert most ktime usage here into u64 (Peterz)
>>>
>>> - Add missing (or too implicit) <linux/sched/clock.h> (Peterz)
>>>
>>> - Fix whole idle time acccounting breakage due to missing TS_FLAG_ set
>>>     on idle entry (Shrikanth Hegde)
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
>>> 	timers/core-v2
>>>
>>> HEAD: 21458b98c80a0567d48131240317b7b73ba34c3c
>>> Thanks,
>>> 	Frederic
>>
>> idle and runtime utilization with mpstat while running stress-ng looks
>> correct now.
>>
>> However, when running hackbench I am noticing the below data. hackbench shows
>> severe regressions.
>>
>> base: tip/master at 9c61ebbdb587a3950072700ab74a9310afe3ad73.
>> (nit: patch 7 is already part of tip. so skipped applying it)
>> +-----------------------------------------------+-------+---------+-----------+
>> | Test                                          | base  | +series | % Diff    |
>> +-----------------------------------------------+-------+---------+-----------+
>> | HackBench Process 10 groups                   |  2.23 |  3.05   |   -36.77%  |
>> | HackBench Process 20 groups                   |  4.17 |  5.82   |   -39.57%  |
>> | HackBench Process 30 groups                   |  6.04 |  8.49   |   -40.56%  |
>> | HackBench Process 40 groups                   |  7.90 | 11.10   |   -40.51%  |
>> | HackBench thread 10                           |  2.44 |  3.36   |   -37.70%  |
>> | HackBench thread 20                           |  4.57 |  6.35   |   -38.95%  |
>> | HackBench Process(Pipe) 10                    |  1.76 |  2.29   |   -30.11%  |
>> | HackBench Process(Pipe) 20                    |  3.49 |  4.76   |   -36.39%  |
>> | HackBench Process(Pipe) 30                    |  5.21 |  7.13   |   -36.85%  |
>> | HackBench Process(Pipe) 40                    |  6.89 |  9.31   |   -35.12%  |
>> | HackBench thread(Pipe) 10                     |  1.91 |  2.50   |   -30.89%  |
>> | HackBench thread(Pipe) 20                     |  3.74 |  5.16   |   -37.97%  |
>> +-----------------------------------------------+-------+---------+-----------+
>>
>> I have these in .config and I don't have nohz_full or isolated cpus.
>>
>> CONFIG_TICK_ONESHOT=y
>> CONFIG_NO_HZ_COMMON=y
>> # CONFIG_HZ_PERIODIC is not set
>> # CONFIG_NO_HZ_IDLE is not set
>> CONFIG_NO_HZ_FULL=y
>>
>> # CPU/Task time and stats accounting
>> #
>> CONFIG_VIRT_CPU_ACCOUNTING=y
>> CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
>> CONFIG_IRQ_TIME_ACCOUNTING=y
>> CONFIG_HAVE_SCHED_AVG_IRQ=y
>>
>> I did a git bisect and below is what it says.
>>
>> git bisect start
>> # status: waiting for both good and bad commits
>> # bad: [6821315886a3b5267ea31d29dba26fd34647fbbc] sched/cputime: Handle dyntick-idle steal time correctly
>> git bisect bad 6821315886a3b5267ea31d29dba26fd34647fbbc
>> # status: waiting for good commit(s), bad commit known
>> # good: [9c61ebbdb587a3950072700ab74a9310afe3ad73] Merge branch into tip/master: 'x86/sev'
>> git bisect good 9c61ebbdb587a3950072700ab74a9310afe3ad73
>> # good: [dc8bb3c84d162f7d9aa6becf9f8392474f92655a] tick/sched: Remove nohz disabled special case in cputime fetch
>> git bisect good dc8bb3c84d162f7d9aa6becf9f8392474f92655a
>> # good: [5070a778a581cd668f5d717f85fb22b078d8c20c] tick/sched: Account tickless idle cputime only when tick is stopped
>> git bisect good 5070a778a581cd668f5d717f85fb22b078d8c20c
>> # bad: [1e0ccc25a9a74b188b239c4de716fde279adbf8e] sched/cputime: Provide get_cpu_[idle|iowait]_time_us() off-case
>> git bisect bad 1e0ccc25a9a74b188b239c4de716fde279adbf8e
>> # bad: [ee7c735b76071000d401869fc2883c451ee3fa61] tick/sched: Consolidate idle time fetching APIs
>> git bisect bad ee7c735b76071000d401869fc2883c451ee3fa61
>> # first bad commit: [ee7c735b76071000d401869fc2883c451ee3fa61] tick/sched:
>> Consolidate idle time fetching APIs
> 
> I see. Can you try this? (or fetch timers/core-v3 from my tree)
> Perhaps that mistake had some impact on cpufreq.
> 
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index 057fdc00dbc6..08550a6d9469 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -524,7 +524,7 @@ static u64 get_cpu_sleep_time_us(int cpu, enum cpu_usage_stat idx,
>   	do_div(res, NSEC_PER_USEC);
>   
>   	if (last_update_time)
> -		*last_update_time = res;
> +		*last_update_time = ktime_to_us(now);
>   
>   	return res;
>   }
> 
Yes. This diff helps. Now the data is almost same.

+-----------------------------------------------+-------+-------+-----------+
| Test                                          | base  | series+     | % Diff    |
|                                               |       | +above diff |
+-----------------------------------------------+-------+-------------+-----------+
| HackBench Process 10 groups                   |  2.23 |  2.25       |    -0.90%  |
| HackBench Process 20 groups                   |  4.17 |  4.21       |    -0.96%  |
| HackBench Process 30 groups                   |  6.04 |  6.15       |    -1.82%  |
| HackBench Process 40 groups                   |  7.90 |  8.06       |    -2.03%  |
| HackBench thread 10                           |  2.44 |  2.46       |    -0.82%  |
| HackBench thread 20                           |  4.57 |  4.61       |    -0.88%  |
| HackBench Process(Pipe) 10                    |  1.76 |  1.73       |     1.70%  |
| HackBench Process(Pipe) 20                    |  3.49 |  3.50       |    -0.29%  |
| HackBench Process(Pipe) 30                    |  5.21 |  5.22       |    -0.19%  |
| HackBench Process(Pipe) 40                    |  6.89 |  6.96       |    -1.02%  |
| HackBench thread(Pipe) 10                     |  1.91 |  1.88       |     1.57%  |
| HackBench thread(Pipe) 20                     |  3.74 |  3.81       |    -1.87%  |
+-----------------------------------------------+-------+-------------+-----------+

