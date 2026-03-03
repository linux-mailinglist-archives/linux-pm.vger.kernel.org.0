Return-Path: <linux-pm+bounces-43482-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHQRBQnFpml4TgAAu9opvQ
	(envelope-from <linux-pm+bounces-43482-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 12:24:57 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B202E1EDB5F
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 12:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CF863105608
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 11:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE543B95FF;
	Tue,  3 Mar 2026 11:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XOzAjF+E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C1D421F16;
	Tue,  3 Mar 2026 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772536772; cv=none; b=dixR6TytaG8jptfIyTH5YyafBNJCXY7NXa7YRmRl6CTHr9kwJLF0wiCW11aRZELfLksDYeR2Jy4u+YlrzhfzYBEd92t8h16sZgYFWAczotjsuprpMVnym5IPfhHJEjIV+KoYvA0/Xn0rR4KmlfCk+Kc50XHrv6pwAObCZU42IN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772536772; c=relaxed/simple;
	bh=y4tJpQJGapw5Taf4zWnX2UW9wPHcdF3WN734qjMu7Io=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IpusDEA+sHCZ3p9CvRNi9ahy71qbEPr6MpaVeBLnUfaKSeRRpHxdBJfkcqrCyv5BasuRYssah7WSeFt1YmmOOGxq8SJg8OOqKhycWHJeJx+r8LXAqeoZBWVWyJWvC8krbuzj8YXCeCbM0J6J5mvsrvb4zWVoIBEKdJoxPaVoVCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XOzAjF+E; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6237c0sP2459770;
	Tue, 3 Mar 2026 11:17:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=58Gi1B
	PEW+NhDXk+xEQWqKkDA5EIat7IWlQuy8hDA2g=; b=XOzAjF+Es70FI80cfcEf+B
	fah1NPhLCnmW8etxVT+6tx3qyCwMVEgO+uBTJJDzI56zu0LqIevzF6cOSXK5EYTP
	rymdtckQK0JKQIoMBV99Ixk3w+5HzrnIimQk8FKrOsZ2aMZHpdumg69e/9F8JOQH
	J5aeDN2g90zZ0ispJ6r6AKQr3SLrqgBI3ctH6R4rB1raTiVRY5gxcTB+RWP/wwB6
	S4Y4mpPecPp8skwz6eMdhIzBjdHXR4d1O+qDyNjTQqTTDRTozCOQAL6fcnH3BhQE
	GWsftk2v7eBrypjMp32cVPcmqGmVsAPx4flWN2TPlRJ5dDnlzWdUmAwgNdJ7wLoA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckssmje0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 11:17:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6239aBUH003275;
	Tue, 3 Mar 2026 11:17:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmb2y22vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 11:17:56 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 623BHqaV50004294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Mar 2026 11:17:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C868F2004B;
	Tue,  3 Mar 2026 11:17:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04E5D20043;
	Tue,  3 Mar 2026 11:17:46 +0000 (GMT)
Received: from [9.124.210.250] (unknown [9.124.210.250])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Mar 2026 11:17:45 +0000 (GMT)
Message-ID: <be30e259-a690-4530-996c-0c092833bb66@linux.ibm.com>
Date: Tue, 3 Mar 2026 16:47:45 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/15] sched/cputime: Handle dyntick-idle steal time
 correctly
To: Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mel Gorman <mgorman@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
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
 <20260206142245.58987-16-frederic@kernel.org>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260206142245.58987-16-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA4NiBTYWx0ZWRfX9fy6pZQ8rl2U
 4JvSsUo8us4RFr+87x9HHqKuttkP4YFNr4o9dbZQ4JjvWNEmfVRS0g5h/xwci4zrWoFHJGYYHPL
 E7OC7KLmE8eU0eBgJu5raasJw/4Q5omRn237tfeRboTDr5jtblnz7OrwSeTgWx5bTIVLr3eKCv9
 oOY0jDa7w6DouUUTJoZhfy4l0K7K0rFUwFO9P8UIJgH3ETXQDgX0TZZHksIqEDRinQK4sOMqtZC
 tSEmgyOsJFDTZGW1YcteipRi/KlL0bhbVe6VcqujpcvVaXmq+6BIgrD+S9rEHkrw+Vlge6A65lx
 OjY9yqwtPx9yFyDY9sOAUEgfr07pf7wHoSYotmMYIg31aVi+jlPBhoRRDsuREunOfCP2qBjm+yS
 pIB7jIJNd4pKVEtRTqetk5LCJ4YDTPPQUpxGC9sBi3RqdMmMChwmlEEektjlwAkF0yloiMDzDoZ
 06jY+9gFfs0fuB1A7mw==
X-Proofpoint-ORIG-GUID: _t3s3NyLA8LzJG1-lGM_QRzy4Zn7pHmn
X-Proofpoint-GUID: eLgjsOmzuOTxGRUDfGjOCD-0P5c5EUkr
X-Authority-Analysis: v=2.4 cv=AobjHe9P c=1 sm=1 tr=0 ts=69a6c366 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=Y8yXDIHhMlYSrwm1qnwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030086
X-Rspamd-Queue-Id: B202E1EDB5F
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[35];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43482-lists,linux-pm=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,linutronix.de,google.com,gmail.com,arm.com,redhat.com,siemens.com,nvidia.com,suse.de,ellerman.id.au,infradead.org,goodmis.org,linaro.org,163.com,vger.kernel.org,lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.ibm.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sshegde@linux.ibm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action



On 2/6/26 7:52 PM, Frederic Weisbecker wrote:
> The dyntick-idle steal time is currently accounted when the tick
> restarts but the stolen idle time is not substracted from the idle time
> that was already accounted. This is to avoid observing the idle time
> going backward as the dyntick-idle cputime accessors can't reliably know
> in advance the stolen idle time.
> 
> In order to maintain a forward progressing idle cputime while
> substracting idle steal time from it, keep track of the previously
> accounted idle stolen time and substract it from _later_ idle cputime
> accounting.
> 

s/substract/subtract ?

> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   include/linux/kernel_stat.h |  1 +
>   kernel/sched/cputime.c      | 21 +++++++++++++++------
>   2 files changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
> index 512104b0ff49..24a54a6151ba 100644
> --- a/include/linux/kernel_stat.h
> +++ b/include/linux/kernel_stat.h
> @@ -39,6 +39,7 @@ struct kernel_cpustat {
>   	bool		idle_elapse;
>   	seqcount_t	idle_sleeptime_seq;
>   	u64		idle_entrytime;
> +	u64		idle_stealtime;
>   #endif
>   	u64		cpustat[NR_STATS];
>   };
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index 92fa2f037b6e..7e79288eb327 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -424,19 +424,25 @@ static inline void irqtime_account_process_tick(struct task_struct *p, int user_
>   static void kcpustat_idle_stop(struct kernel_cpustat *kc, u64 now)
>   {
>   	u64 *cpustat = kc->cpustat;
> -	u64 delta;
> +	u64 delta, steal, steal_delta;
>   
>   	if (!kc->idle_elapse)
>   		return;
>   
>   	delta = now - kc->idle_entrytime;
> +	steal = steal_account_process_time(delta);
>   
>   	write_seqcount_begin(&kc->idle_sleeptime_seq);
> +	steal_delta = min_t(u64, kc->idle_stealtime, delta);
> +	delta -= steal_delta;

I didn;t get this logic. Why do we need idle_stealtime?

Lets say 10ms was steal time and 50ms was delta. but idle_stealtime is
sum of past accumulated steal time. we only need to subtract steal time there no?

Shouldn't this be delta -= steal ?


> +	kc->idle_stealtime -= steal_delta;
> +
>   	if (nr_iowait_cpu(smp_processor_id()) > 0)
>   		cpustat[CPUTIME_IOWAIT] += delta;
>   	else
>   		cpustat[CPUTIME_IDLE] += delta;
>   
> +	kc->idle_stealtime += steal;
>   	kc->idle_entrytime = now;
>   	kc->idle_elapse = false;
>   	write_seqcount_end(&kc->idle_sleeptime_seq);
> @@ -460,7 +466,6 @@ void kcpustat_dyntick_stop(u64 now)
>   		kc->idle_dyntick = false;
>   		irqtime_dyntick_stop();
>   		vtime_dyntick_stop();
> -		steal_account_process_time(ULONG_MAX);
>   	}
>   }
>   
> @@ -505,10 +510,14 @@ static u64 kcpustat_field_dyntick(int cpu, enum cpu_usage_stat idx,
>   	do {
>   		seq = read_seqcount_begin(&kc->idle_sleeptime_seq);
>   
> -		if (kc->idle_elapse && compute_delta)
> -			idle = cpustat[idx] + (now - kc->idle_entrytime);
> -		else
> -			idle = cpustat[idx];
> +		idle = cpustat[idx];
> +
> +		if (kc->idle_elapse && compute_delta) {
> +			u64 delta = now - kc->idle_entrytime;
> +
> +			delta -= min_t(u64, kc->idle_stealtime, delta);
> +			idle += delta;
> +		}
>   	} while (read_seqcount_retry(&kc->idle_sleeptime_seq, seq));
>   
>   	return idle;


