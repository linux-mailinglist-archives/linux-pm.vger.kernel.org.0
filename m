Return-Path: <linux-pm+bounces-42824-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOOBDPgBlmlHYAIAu9opvQ
	(envelope-from <linux-pm+bounces-42824-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 19:16:24 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F781589EB
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 19:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E76530226BF
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 18:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99360342503;
	Wed, 18 Feb 2026 18:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f50Mlxtz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0885333BBD4;
	Wed, 18 Feb 2026 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771438370; cv=none; b=qsWR/VCMcJeDhQJ7zL/XN+cZa/vG6yyrFcs6Dq1AnEwScRoJlfG7V/0QZhonb0pYV0BsngAPlhIUoCwG9BZGAlmQihR7QNPsjOoqJsJw50XqmqzWJoHLSItxtUZOTLatara3IyOz8MmZPK6kBoCFXyzS2ITUtvlJEBbmFb5dshQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771438370; c=relaxed/simple;
	bh=pOzcecuk03J1cPmwTBABQAJue2JjuFhfC0dHd6sQ//0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uuqoYORZA534q0IVXy1KFxFU2H5tuPlPHUxV+vKGg5NBf9+wkvaLMm85dM/JPqaYtpOyCPCc2VIm8p3jnlIn+bI3wGQ2KDy/UINvfvwwaDXctFOW9zZTNV7KuciHUO+fcTE7rcVE7ekDPnmc6oPVYM4jTLHgUHaR4oBEYXGoPW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f50Mlxtz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61I9nec83417742;
	Wed, 18 Feb 2026 18:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sfUlV/
	wNefxooluft56yOC+h7KQSYmmCaL4cqn1R+TU=; b=f50Mlxtzm5FCleoG8kfOdS
	yLytip3a1xRuz+1QRiPCJiMT0WIuaDAppmqrNs8US2FHp4Am2Devb+M+AcJfXtZp
	EZRgxbdtBF2gicS7jb3DyEipiP+cXmg/Y1BMEW30sZbYPsseB44+JUcqMuyN/5n4
	p/FtYuPWEIiMoX3NdA9AAzHBD6Sby3dk4v12IJvl8BFJqKf/tgJSrnIRMc5lWjZy
	0qlxjt4j+eaDkn8NinhSipB6UC50ALwh3zEGZRf+WK7iTK2M73h/vhSpUJzfwjeh
	akLPfh/duGUSMjiau7cASvEH3fG4Vfcb78Ov8aBUdVPjZZ8Lp19BDpgPXVO5B6kA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj4khfum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 18:12:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61IHRowm015846;
	Wed, 18 Feb 2026 18:12:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb459070-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 18:12:09 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61IIC5B250331956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 18:12:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08F8C2004F;
	Wed, 18 Feb 2026 18:12:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E63D2004B;
	Wed, 18 Feb 2026 18:11:55 +0000 (GMT)
Received: from [9.111.93.209] (unknown [9.111.93.209])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Feb 2026 18:11:54 +0000 (GMT)
Message-ID: <e3f83ce1-15d7-4b17-9dd3-6f7d12c0060d@linux.ibm.com>
Date: Wed, 18 Feb 2026 23:41:53 +0530
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDE1NSBTYWx0ZWRfX/Z+O37yeSxT0
 0ArN/qMzStecQC6PWbJIopmSxoCNU/Cvu6+FUC4a8qFH4IguGOuBPuD8YJ49xZG2ZxjoArrRuRh
 aVgRfHOhX/3tbUA1vmyi200xmyaVKtan+/olqtTvJl6gFP14Fnqe/aZS1uaWbvsCCDzUOnOo3c4
 VsHIUmu2wkg9JhqKxDTbEwv5u02Te6E5GGR42bPioABeMnMF+j9Dkeq7Wx6i/OYUMSb8gzxz81v
 Um5eXQBcTcff18EbzehQGMXdQ3aXSHOmrWN4bEEK9ep9yCnTHGk7z3CTElBXI8FiFqs5l+P6Xyn
 DmEx89KzMRPCFwhMRGzaQhy49Pi03KidRX2VoTuiuYG12i3CEMUJYVjvoCPLtByEvSGI26JhPrm
 mZ/o6Ct0VTIes9DffW8x7/ob2lSfvf5XVGLtm2ISpQ/yZTzlWrWAuoxncpbusYMFXUYuGLE97c9
 aqRX0EtPnJGARH1mxMQ==
X-Proofpoint-ORIG-GUID: mSHiEHIbbZ6uwb7WfwT2_4csNFB2eLee
X-Proofpoint-GUID: PvR6Ae7132HEIgri66fng2-gFbwTbNap
X-Authority-Analysis: v=2.4 cv=M7hA6iws c=1 sm=1 tr=0 ts=699600fa cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=Byx-y9mGAAAA:8 a=VnNF1IyMAAAA:8 a=jna3-dR-LpdznfkkQtQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_03,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180155
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[35];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42824-lists,linux-pm=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.ibm.com,linaro.org,kernel.org,redhat.com,163.com,nvidia.com,gmail.com,suse.de,arm.com,google.com,ellerman.id.au,linutronix.de,siemens.com,infradead.org,goodmis.org,lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sshegde@linux.ibm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 99F781589EB
X-Rspamd-Action: no action

Hi Frederic.

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
> 
> 

I have done testing in below cases on PowerNV(power9) box.

1. CONFIG_VIRT_CPU_ACCOUNTING_GEN + CONFIG_IRQ_TIME_ACCOUNTING=y.
    This is common case of having VTIME_GEN + IRQ_TIME enabled.

2. CONFIG_VIRT_CPU_ACCOUNTING_GEN only.
    IRQ_TIME is not selected

3. CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y (for this i had to disable CONFIG_NO_HZ_FULL)
    CONFIG_NO_HZ_IDLE=y and CONFIG_NO_HZ_FULL=n and VTIME_GEN=n


4. CONFIG_TICK_CPU_ACCOUNTING=y
    (CONFIG_NO_HZ_FULL=n and CONFIG_NO_HZ_IDLE=y)


In all cases the idle time and iowait time doesn't go backwards.
So that's a clear win.
Without the patches iowait did go backwards.

So, with that for the series.

Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>



---
However, with the series, with NATIVE=y i am seeing one peculiar info.
without series: cpu0 0 0 9    60800 4 2  90 0 0 0  << 608 seconds after boot. That's ok.
with series:    cpu0 1 0 17 9122062 0 3 140 0 0 0  << 91220 seconds?? Strange.

However, i see the time passage looks normal.
If i do like, cat /proc/stat; sleep 5; cat /proc/stat;
then i see same time difference with/without series.
So timekeeping works as expected.

Almost all CPUs have similar stat. I am wondering if there is bug or some kind
of wrapping in mftb which raises an irq and during that particular period the
values go very large. Even without series, I see one or two CPUs have same huge system
time. Maybe since the series handles the irq case now, it might be showing up in all CPUs.

This is a  slightly older system. I will give this a try on power10 when I get the
systems in few weeks time.

