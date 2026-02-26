Return-Path: <linux-pm+bounces-43226-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILSBOyPHn2k8dwQAu9opvQ
	(envelope-from <linux-pm+bounces-43226-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 05:08:03 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B2F1A0C51
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 05:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A077A300FED6
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 04:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFE7389E0B;
	Thu, 26 Feb 2026 04:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gTIp8TWN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97FE389DEF;
	Thu, 26 Feb 2026 04:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772078879; cv=none; b=GrtVwEOjJa2BzHGJQ80z3srJf4HkLAGnXNzzbhacah/hLyEero2h34ISiF+rjtHwZvabwpVNhjgeKLKqo/0XPS2KkGQ8S96Cpi4v0+QYmuWNb3EYQiV41Xb1dQIKUUvooyL+OcjEmUYsVNkQvmBm4dr4kTXamHI9HrWISpvjQx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772078879; c=relaxed/simple;
	bh=oUBv2D7n1Y+4a0ZpPyxVesgQ34nl+hYfJJ32/Lsvano=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BUpDdFLyJZ5SzjsUhk75FapEWpPvOJXo1KciqabqqQBv80LAz0RfK1cJt7wV9D7CzFdAwUILJY31w7M1yTNMREcY9jQmj2slrj6uZKrE0Yd49JO1Pf2tYjU3CSI8WxuUDRYI4MYt/djzIlWmwk6OMOK3sJ+07g/DfWI0P2IReXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gTIp8TWN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PNnIwC1020989;
	Thu, 26 Feb 2026 04:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3q0uON
	EEqqqD0xzui33P+JmFnpHAO/xLG4opiuN6MwM=; b=gTIp8TWNrW6AKL34eDJJtR
	ZlJgMti+O/Exc41veLdRdQWP/AakuIAS4l8ox58oQHVweLM9XMjixGyAL0Rgv4og
	/oIdpyPLYDS8x6KgMt/A+nyyWYRE+AcfjCH0Ij/OSX9BXSN67nOtmb1oDaZ4/uOp
	A/RHe6xuRoa4Gm3NLQrJyET9y+OpNaLEIaqIL9IaiKWcVM7R2nRBStoi5GH5TlpP
	dbLhCc1z265CJiLbxz9m5RFPKYdsBvM1D2lOshS/HHTQNdmWH5q8mf4iYd3C2OMD
	+TYpy6Vc9N9wVdCS1XY8GCPJz0OYxqNceV7f4jsZDxfxBmDGBE5U+FO0CV7/a/qA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf47247dr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 04:07:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61Q0YAGE027789;
	Thu, 26 Feb 2026 04:07:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfsr20vn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 04:07:11 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61Q477Ev28115492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 04:07:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8059A20043;
	Thu, 26 Feb 2026 04:07:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9349420040;
	Thu, 26 Feb 2026 04:07:00 +0000 (GMT)
Received: from [9.109.215.252] (unknown [9.109.215.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Feb 2026 04:07:00 +0000 (GMT)
Message-ID: <32cf8732-22e6-4350-9d39-67740ef07b13@linux.ibm.com>
Date: Thu, 26 Feb 2026 09:36:59 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] powerpc/time: Prepare to stop elapsing in
 dynticks-idle
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Kieran Bingham <kbingham@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E . McKenney"
 <paulmck@kernel.org>,
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
References: <20260206142245.58987-1-frederic@kernel.org>
 <20260206142245.58987-5-frederic@kernel.org>
 <9413517d-963b-4e6d-b11b-b440acd7cb5a@linux.ibm.com>
 <9ab1e7d7-57ee-49f9-963c-3a1b96dda684@kernel.org>
 <120884b0-0b09-43a9-b0f6-7dc2affe1ac0@linux.ibm.com>
 <55720b5b-f643-4e67-8841-d81a9e712faf@kernel.org>
 <a20beb34-0e4b-4063-b6b0-6c5886bbb971@linux.ibm.com>
 <a0c6e65c-3331-402a-94eb-14ba7f4b7ba7@kernel.org>
 <729a7e7f-a50e-480c-87ce-c45221fbb326@linux.ibm.com>
 <6c007cf1-46d5-4853-ae2e-90ee5257c6c9@kernel.org>
 <62f50aad-05ce-42ac-bdf6-dcb4af69c1c2@linux.ibm.com>
 <cd10be19-e0bc-4e0c-8dac-4f1c05d0de8f@kernel.org>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <cd10be19-e0bc-4e0c-8dac-4f1c05d0de8f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: f7S2WtsKvlxMvHhq_zwIJuGpP3z4paQL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDAzMCBTYWx0ZWRfX60s+A34+GB0t
 Io80hfX9Jv3eGn0B3TakXFL2ROrvdbblneo6y5ODg4Z86GzA9kmCXtJOfUe11j6BSpzZWDNj7qg
 7XtmGO441AswLe4NoJNJDnuk75XC6YY9Yv/8TfnXsbXaTd27Uz1IQVDdjI4lxigP4Wsc5wUV3dC
 02KdkR5EEdxxBV12vBa55FP3V1vZ2JCx9+uEopP/B4tYCwQqZ9aDXfjff3v0ieKI/RD6BAyClBv
 fqOK3VCJJbKkRKVcRdDGKDIrvgwEkH6JGR+SFfQn/N4Rp12hfB7P6bR9iRe/qrKyGKAwdBxzxHE
 3iyYESt9qF5fzcvFi6EWTMN0HncF7m7/KO+mCSWFxzLzDuqZkROgnWs1a8XqPu1EOjjx9Mnr3WQ
 qJ0+NTI41XOOV8lZHsXW4npk+FKu0ma02LcpPfZDNwDe1NXK8QqBWmA0IWavlUUlF8wuoby04pY
 aJh66yaVdBoI1+0zvHA==
X-Authority-Analysis: v=2.4 cv=R7wO2NRX c=1 sm=1 tr=0 ts=699fc6f1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=mQacKsI2GBFQlb42hPYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mPP8z1pesNQEnkjfaOtnge9F8RPnsGDG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602260030
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
	TAGGED_FROM(0.00)[bounces-43226-lists,linux-pm=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,linutronix.de,google.com,gmail.com,arm.com,redhat.com,siemens.com,nvidia.com,suse.de,ellerman.id.au,infradead.org,goodmis.org,linaro.org,163.com,vger.kernel.org,lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sshegde@linux.ibm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 77B2F1A0C51
X-Rspamd-Action: no action



On 2/25/26 11:29 PM, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 25/02/2026 à 18:47, Shrikanth Hegde a écrit :
>> Hi Christophe.
>>
>>> I think I'm starting to understand now.
>>>
>>> I think the problem is that acct->starttime has an invalid value the 
>>> very first time it is used.
>>>
>>> We are probably lacking an initial value in paca->accounting.starttime.
>>> This should likely be initialised from mftb in head_64.S in 
>>> start_here_common for main CPU and __secondary_start for other CPUs 
>>> or maybe at higher level in C in setup_arch() and start_secondary()
>>>
>>> Christophe
>>
>> How about below? this works too.
> 
> Fine it is works, it means we found the real problem.
> 
> What about using the newly added vtime_reset() ? See below (untested)
> 

Thanks Christophe for helping.

This works too. vtime_reset does the exact same thing.
Let me write a changelog and a comment on vtime_reset and send it.

> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 9b3167274653..f4aef85106ac 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -377,7 +377,6 @@ void vtime_task_switch(struct task_struct *prev)
>       }
>   }
> 
> -#ifdef CONFIG_NO_HZ_COMMON
>   /**
>    * vtime_reset - Fast forward vtime entry clocks
>    *
> @@ -394,6 +393,7 @@ void vtime_reset(void)
>   #endif
>   }
> 
> +#ifdef CONFIG_NO_HZ_COMMON
>   /**
>    * vtime_dyntick_start - Inform vtime about entry to idle-dynticks
>    *
> @@ -931,6 +931,7 @@ static void __init set_decrementer_max(void)
>   static void __init init_decrementer_clockevent(void)
>   {
>       register_decrementer_clockevent(smp_processor_id());
> +    vtime_reset();
>   }
> 
>   void secondary_cpu_time_init(void)
> @@ -946,6 +947,7 @@ void secondary_cpu_time_init(void)
>       /* FIME: Should make unrelated change to move snapshot_timebase
>        * call here ! */
>       register_decrementer_clockevent(smp_processor_id());
> +    vtime_reset();
>   }
> 
>   /*
> 
> 

