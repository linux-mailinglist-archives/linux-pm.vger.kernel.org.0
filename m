Return-Path: <linux-pm+bounces-43203-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMvFAg7anmkTXgQAu9opvQ
	(envelope-from <linux-pm+bounces-43203-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 12:16:30 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6868E196548
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 12:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F38563044093
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 11:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498A73939D2;
	Wed, 25 Feb 2026 11:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glkmO39J"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26476329C6D;
	Wed, 25 Feb 2026 11:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772018144; cv=none; b=OSFmf8i7koD6dJcDL4dBsrAgu7pO7j1Mn4cLMEL0Hr/dEB1wbnA+wjEC6k3nRDfLDg4DelE2a6sEDEES8ctTh4TOMuazGPQQU8LF+6pmSkVUHRJN2hgE3/rNakOs/dsotl57a8lGrfVAypGjssLiXpGkbhfblGq/y1PxX3hq36o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772018144; c=relaxed/simple;
	bh=bQpUX9iESFZR79pF0V6kpKQNgWEfKF3IUuiMBPbrNgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eppbRC1HTfCWBkk3euivQ6qiQu74tVndcYumFrtKa3lRZt1Fd9/GG5L8rNRWqbWoqVYiDytANwb6qFlZvCMgiJ8RpZT5Mkd83D6/KwkDmd2KXBc8Yzeh4LAXReXEKqAO9G4XS6ieSyEoOk4aTOWehJYJCWorBQGzaAClDX2CnDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glkmO39J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A061C19423;
	Wed, 25 Feb 2026 11:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772018143;
	bh=bQpUX9iESFZR79pF0V6kpKQNgWEfKF3IUuiMBPbrNgY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=glkmO39JGsJMFCHHzK2xRPLw4dlCOyTH5mgj5Q9vk6Zk7TByZ7LEpSWTzYGIjL0mK
	 U+B/jmw1j1Ds6/2/I+WscMESWXrpHEOJvEuqzzikYZeEYd3rU9+f6FT4U6M2KHJ6ko
	 LV3O8PezUudPfjHW4yNU7EoRqmFH6lGK5Dly13vOvrXfyqAt01v63kCQns//79aNad
	 IW0wfZ7Ywvu1KVT9170lo8SZ5wFcsCeHkHD9elO+bEPSs61OygkXTUln5RA48o4b+L
	 9+0tcrvFmg1LVDcIQtXLsJycvs81SHxMTSJI9QjbNwy0Nbe6yFfGPh79mWQkzbQwHq
	 Ean2jR2uiNoBQ==
Message-ID: <a0c6e65c-3331-402a-94eb-14ba7f4b7ba7@kernel.org>
Date: Wed, 25 Feb 2026 12:14:35 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] powerpc/time: Prepare to stop elapsing in
 dynticks-idle
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
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
 Jan Kiszka <jan.kiszka@siemens.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 Juri Lelli <juri.lelli@redhat.com>, Kieran Bingham <kbingham@kernel.org>,
 Mel Gorman <mgorman@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, "Paul E . McKenney"
 <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>, Sven Schnelle <svens@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>,
 Valentin Schneider <vschneid@redhat.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Xin Zhao <jackzxcui1989@163.com>,
 linux-pm@vger.kernel.org, linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <20260206142245.58987-1-frederic@kernel.org>
 <20260206142245.58987-5-frederic@kernel.org>
 <9413517d-963b-4e6d-b11b-b440acd7cb5a@linux.ibm.com>
 <9ab1e7d7-57ee-49f9-963c-3a1b96dda684@kernel.org>
 <120884b0-0b09-43a9-b0f6-7dc2affe1ac0@linux.ibm.com>
 <55720b5b-f643-4e67-8841-d81a9e712faf@kernel.org>
 <a20beb34-0e4b-4063-b6b0-6c5886bbb971@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <a20beb34-0e4b-4063-b6b0-6c5886bbb971@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43203-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,linutronix.de,google.com,gmail.com,arm.com,redhat.com,siemens.com,nvidia.com,suse.de,ellerman.id.au,infradead.org,goodmis.org,linaro.org,163.com,vger.kernel.org,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6868E196548
X-Rspamd-Action: no action

Hi Hegde,

Le 25/02/2026 à 11:34, Shrikanth Hegde a écrit :
> Hi Christophe.
> 
> On 2/25/26 3:15 PM, Christophe Leroy (CS GROUP) wrote:
>>
>> Hope it is more explicit now.
>>
> 
> Got it. The main concern was around with additional computation that 
> sched_clock,
> not any additional paths per se.
> 
> yes, that would be possible,
> 
> 
> How about we do below? This adds only one subtraction.
> This achieves the same outcome.

It adds a bit more than just a substration. It adds a call to an extern 
fonction.

00000164 <my_account_cpu_user_entry>:
  164:	94 21 ff f0 	stwu    r1,-16(r1)
  168:	7c 08 02 a6 	mflr    r0
  16c:	90 01 00 14 	stw     r0,20(r1)
  170:	93 e1 00 0c 	stw     r31,12(r1)
  174:	7f ec 42 e6 	mftb    r31
  178:	48 00 00 01 	bl      178 <my_account_cpu_user_entry+0x14>
			178: R_PPC_REL24	get_boot_tb
  17c:	81 02 00 08 	lwz     r8,8(r2)
  180:	81 22 00 28 	lwz     r9,40(r2)
  184:	7c 84 f8 50 	subf    r4,r4,r31
  188:	7d 29 40 50 	subf    r9,r9,r8
  18c:	7d 29 22 14 	add     r9,r9,r4
  190:	90 82 00 24 	stw     r4,36(r2)
  194:	91 22 00 08 	stw     r9,8(r2)
  198:	80 01 00 14 	lwz     r0,20(r1)
  19c:	83 e1 00 0c 	lwz     r31,12(r1)
  1a0:	7c 08 03 a6 	mtlr    r0
  1a4:	38 21 00 10 	addi    r1,r1,16
  1a8:	4e 80 00 20 	blr

000001ac <my_account_cpu_user_exit>:
  1ac:	94 21 ff f0 	stwu    r1,-16(r1)
  1b0:	7c 08 02 a6 	mflr    r0
  1b4:	90 01 00 14 	stw     r0,20(r1)
  1b8:	93 e1 00 0c 	stw     r31,12(r1)
  1bc:	7f ec 42 e6 	mftb    r31
  1c0:	48 00 00 01 	bl      1c0 <my_account_cpu_user_exit+0x14>
			1c0: R_PPC_REL24	get_boot_tb
  1c4:	81 02 00 0c 	lwz     r8,12(r2)
  1c8:	81 22 00 24 	lwz     r9,36(r2)
  1cc:	7c 84 f8 50 	subf    r4,r4,r31
  1d0:	7d 29 40 50 	subf    r9,r9,r8
  1d4:	7d 29 22 14 	add     r9,r9,r4
  1d8:	90 82 00 28 	stw     r4,40(r2)
  1dc:	91 22 00 0c 	stw     r9,12(r2)
  1e0:	80 01 00 14 	lwz     r0,20(r1)
  1e4:	83 e1 00 0c 	lwz     r31,12(r1)
  1e8:	7c 08 03 a6 	mtlr    r0
  1ec:	38 21 00 10 	addi    r1,r1,16
  1f0:	4e 80 00 20 	blr


I really still can't see the point of this substraction.

At one place we do

	tb1 = mftb1;

	acct->utime += (tb1 - acct->starttime_user);
	acct->starttime = tb1;

At the other place we do

	tb2 = mftb2;

	acct->stime += (tb2 - acct->starttime);
	acct->starttime_user = tb2;

So at the end we have

	acct->utime += mftb1 - mftb2;
	acct->stime += mftb2 - mftb1;

You want to change to
	tb1 = mftb1 - boot_tb;
	tb2 = mftb2 - boot_tb;

At the end we would get

	acct->utime += mftb1 - boot_tb - mftb2 + boot_tb = mftb1 - mftb2;
	acct->stime += mftb2 - boot_tb - mftb1 + boot_tb = mftb2 - mftb1;

So what's the point in doing such a useless substract that disappears at 
the end ? What am I missing ?

Christophe

