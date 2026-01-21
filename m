Return-Path: <linux-pm+bounces-41226-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SI2WAtvEcGkNZwAAu9opvQ
	(envelope-from <linux-pm+bounces-41226-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 13:21:47 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB4256AD1
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 13:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 286303871BF
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 12:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0FE433A0;
	Wed, 21 Jan 2026 12:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CIUNl8BE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86C9319601;
	Wed, 21 Jan 2026 12:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768997921; cv=none; b=JbcpYW3BolY6B2enC0R2HhQ965lxzdn2rxtVgCA53MOmmQX93iJTNHEpCbejCC6oEZuVCKV/XfRCh3oQvig1U6u6C7SCulpffoIf8ZR2rE55TC5EhJSw806r5jCtN6OBhblGJdousmZmZAUcx4+7Gy8nL6IAo4E0cy4yxvHcIqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768997921; c=relaxed/simple;
	bh=4J8C208lhtdnbSKD4dwcKgpUgJEkAIK3vGL/Ry359e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEcgXimch1ctNyTbIbZG9RXT+OAU1cejPdYYdR8TTWUziJv7TsPcTrOiTUGCWj5Hf69S3DPFuxvDT7mu4g9ATWt9jQv1c82yba0a9fWI7fEhtUSv9aYCpL6kifwlxcamk8GTl/MaZDeLgqQjaKriTATj2b00o/bkQEUYLyMIKVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CIUNl8BE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60L0VbIW020940;
	Wed, 21 Jan 2026 12:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=SSHc8rNHSFQIqufuQ00BO+yiuuLDn3
	Q7FpAC5GvBRfI=; b=CIUNl8BEsPFbzX+lw6/2mACDxBDifX+KbzA2rEdGVb9ASC
	0X27EQdynzSa3jBd/CfUpzZoCJDOOOWJuV//lUYTyg/1TRxx5majL39LXNezeDJ8
	kQcFXDop0PLEW126UG/NmLu+HJl29A2QwNwCz+YbpM7MS80DBtjAhXMZFT3IbYK7
	a+TiB6ntpNWbEGoGdAlFGg8v19tTvAp5g2fL9wX3J4HDZr1lKPjIs5L0Hl467T1j
	3hI2MOgez+UltHPpmuX4yps7IZ5u9xTa4S+umRghz6bTAAOET1hbOywIbO22sgGu
	WuS2YEaBurnzXgWDVqXb8FjqeNofZSBwHUfF+jww==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br0ufjvr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 12:17:56 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60LCFvs2031972;
	Wed, 21 Jan 2026 12:17:55 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br0ufjvr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 12:17:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60LB52Zo009295;
	Wed, 21 Jan 2026 12:17:54 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brp8kbqtd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 12:17:54 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60LCHo6f51708412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Jan 2026 12:17:50 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 529B120043;
	Wed, 21 Jan 2026 12:17:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D127720040;
	Wed, 21 Jan 2026 12:17:49 +0000 (GMT)
Received: from osiris (unknown [9.52.214.206])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 21 Jan 2026 12:17:49 +0000 (GMT)
Date: Wed, 21 Jan 2026 13:17:48 +0100
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
Message-ID: <20260121121748.9719Bab-hca@linux.ibm.com>
References: <20260116145208.87445-1-frederic@kernel.org>
 <20260116145208.87445-6-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116145208.87445-6-frederic@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4dp3fud74MN0mKdk4Vb2hrDyxWmL7L-f
X-Proofpoint-ORIG-GUID: uWfZYWtb_gOtkqw0ik-_HqLB8BLcrAKJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDEwMyBTYWx0ZWRfX4z/dW1y0Q/Hd
 EFIZs+4cm6/dy3v0Odb0kj5kmHTUZTltobqWC9UybC2DocWdzHfttH0iyqFOk/VsjYKaZng0Aaa
 HPEgeEzFGCLiVQhsUwQb+O8Gk95ol4S55n7EY89gvXyRw0dkK+IPZTM8CXpqfphb3Rjm8RZSoNb
 3h83Kawj1VeypKnpJcnPuWyak2coszL8WCgpJ/fzM19i3In3R6ErJkO1qEh9OABDLLW64qB3Yn8
 OAfAaQwkAIZqB5Q6JxC0p4PEbaqMzrZPIlb+f3V8k6YymA1h7/sWfzPMoFsY0JMPc2zJ0f9Il90
 Bf/OmORw5AaE87qhmayZVR0j/c1p+AEt5eavs/1AyuIxm4Rrl0prDah+NpZQ6z+4tWwwvp0eErJ
 JjLZV3Qa3wcA7B+0f0AAcWE0FaEtGFiTNuRgKmFDgZUySeSjU2VuEb/WVkMgQNuNSARf7p6g3Tg
 ulW9/72BDr/n6XWV3CQ==
X-Authority-Analysis: v=2.4 cv=bopBxUai c=1 sm=1 tr=0 ts=6970c3f4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=hVwK31ck3tplLBhVBggA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601210103
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41226-lists,linux-pm=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linux.ibm.com,linutronix.de,google.com,gmail.com,arm.com,redhat.com,siemens.com,nvidia.com,suse.de,ellerman.id.au,infradead.org,goodmis.org,linaro.org,163.com,lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[ibm.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hca@linux.ibm.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	RCVD_COUNT_TWELVE(0.00)[13];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid]
X-Rspamd-Queue-Id: 9EB4256AD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Jan 16, 2026 at 03:51:58PM +0100, Frederic Weisbecker wrote:
> diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
> index 39cb8d0ae348..54bb932184dd 100644
> --- a/arch/s390/kernel/idle.c
> +++ b/arch/s390/kernel/idle.c
> @@ -35,6 +35,12 @@ void account_idle_time_irq(void)
>  			this_cpu_add(mt_cycles[i], cycles_new[i] - idle->mt_cycles_enter[i]);
>  	}
>  
> +	WRITE_ONCE(idle->idle_count, READ_ONCE(idle->idle_count) + 1);
> +
> +	/* Dyntick idle time accounted by nohz/scheduler */
> +	if (idle->idle_dyntick)
> +		return;
> +
>  	idle_time = lc->int_clock - idle->clock_idle_enter;
>  
>  	lc->steal_timer += idle->clock_idle_enter - lc->last_update_clock;
> @@ -45,7 +51,6 @@ void account_idle_time_irq(void)
>  
>  	/* Account time spent with enabled wait psw loaded as idle time. */
>  	WRITE_ONCE(idle->idle_time, READ_ONCE(idle->idle_time) + idle_time);
> -	WRITE_ONCE(idle->idle_count, READ_ONCE(idle->idle_count) + 1);
>  	account_idle_time(cputime_to_nsecs(idle_time));
>  }

This breaks idle time reporting (aka enabled wait psw time) via the per-cpu
sysfs files (see show_idle_time()). That is: the second WRITE_ONCE() should
also go above the early return statement; but of course this leads to other
dependencies...

Not sure what to do with this. I thought about removing those sysfs files
already in the past, since they are of very limited use; and most likely
nothing in user space would miss them.

Anyway, you need to integrate the trivial patch below, so everything compiles
for s390. It also _seems_ to work.

Guess I need to spend some more time on accounting and see what it would take
to convert to VIRT_CPU_ACCOUNTING_GEN, while keeping the current precision and
functionality.

diff --git a/arch/s390/include/asm/idle.h b/arch/s390/include/asm/idle.h
index 2770c4f761e1..285b3da318d6 100644
--- a/arch/s390/include/asm/idle.h
+++ b/arch/s390/include/asm/idle.h
@@ -8,6 +8,7 @@
 #ifndef _S390_IDLE_H
 #define _S390_IDLE_H
 
+#include <linux/percpu-defs.h>
 #include <linux/types.h>
 #include <linux/device.h>
 
@@ -20,6 +21,8 @@ struct s390_idle_data {
 	unsigned long	mt_cycles_enter[8];
 };
 
+DECLARE_PER_CPU(struct s390_idle_data, s390_idle);
+
 extern struct device_attribute dev_attr_idle_count;
 extern struct device_attribute dev_attr_idle_time_us;
 
diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index 54bb932184dd..e3fe64e7adbe 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -19,7 +19,7 @@
 #include <asm/smp.h>
 #include "entry.h"
 
-static DEFINE_PER_CPU(struct s390_idle_data, s390_idle);
+DEFINE_PER_CPU(struct s390_idle_data, s390_idle);
 
 void account_idle_time_irq(void)
 {

