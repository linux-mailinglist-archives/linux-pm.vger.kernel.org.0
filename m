Return-Path: <linux-pm+bounces-30329-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7229FAFBF8D
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 02:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DAF51889721
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 00:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0D715C15F;
	Tue,  8 Jul 2025 00:56:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1BA1C8611;
	Tue,  8 Jul 2025 00:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751936201; cv=none; b=POBhHtpX/bzAz4SHMiS0vjsh2WsEqImqmRMuBGpoS4JASAh2xEnjNYu7Z4LHtypd6auskShHfmOrlgL0TYHQZjNUTfHAP1Ol33551xOIH+9I1SJ+4ZgbgOIn6WvAtT7kRJv9PJRXkNrGGnsFRGou+dFU4C9CrpITXJ91J/mVHGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751936201; c=relaxed/simple;
	bh=+/F1bGbjjKvu1Uo6Wdq5/ZVs3WqOf6ln3yLQ6I089zE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ufXxKOEgcR0lHPVOmr+pY1mEnsOIDtKAnG7qeUkK89uBUvqoKXPmqAjWVXrkz7E7tGvrpjZaC+BdG8sJgVeLxsXKhf3x1rJV6WQH6beKBzjIdqtI5ZOBFVDSyU4NEXt0i19TH5RVhu06sAJb3DMKDS6eYfDpijKXhSLgl+ngUEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 63057f3e5b9611f0b29709d653e92f7d-20250708
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:54a55555-2426-4274-a88c-e24e906d6a63,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:339e88bba938cd16ff2c540091de5e7f,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 63057f3e5b9611f0b29709d653e92f7d-20250708
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 451992315; Tue, 08 Jul 2025 08:56:31 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 17B48E008FA2;
	Tue,  8 Jul 2025 08:56:31 +0800 (CST)
X-ns-mid: postfix-686C6CBE-6398994
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id A62AFE008FA1;
	Tue,  8 Jul 2025 08:56:28 +0800 (CST)
Message-ID: <6b28003b-58ee-4870-ade6-c488148a7b4f@kylinos.cn>
Date: Tue, 8 Jul 2025 08:56:27 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] PM / Freezer: Skip zombie/dead processes to
To: Peter Zijlstra <peterz@infradead.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, pavel@kernel.org,
 len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Oleg Nesterov <oleg@redhat.com>
References: <20250611101247.15522-1-zhangzihuan@kylinos.cn>
 <20250611101247.15522-2-zhangzihuan@kylinos.cn>
 <CAJZ5v0jpuUVM73M=Gzq36je=K_7zEkvVd8bxohi6N5OYgxgUug@mail.gmail.com>
 <20250703164021.GY1613200@noisy.programming.kicks-ass.net>
 <CAJZ5v0j29Nu2nitmj6tPhOQYuSaHBtXQVR21ikDtrxpejPdW8A@mail.gmail.com>
 <20250704081941.GC2001818@noisy.programming.kicks-ass.net>
 <67997bdd-d00a-413a-a565-188c4b06f385@kylinos.cn>
 <20250704092144.GH2001818@noisy.programming.kicks-ass.net>
 <de7e327a-202c-4b28-b372-2d648c680dbe@kylinos.cn>
 <20250707084214.GD1613200@noisy.programming.kicks-ass.net>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250707084214.GD1613200@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/7/7 16:42, Peter Zijlstra =E5=86=99=E9=81=93:
> A quick browse through the code seems to suggest that for user tasks,
> PF_NOFREEZE is set just like exit_state, once at death.
>
I couldn=E2=80=99t agree more =E2=80=94 for user tasks, PF_NOFREEZE is in=
deed set at the=20
same time as exit_state, right at death.
> For kernel threads the situation is a little more complex; but typicall=
y
> a kthread is spawned with PF_NOFREEZE set, and then some will clear it
> again, but always before then calling a TASK_FREEZABLE wait.=E3=80=80=E3=
=80=80 =E3=80=80 =E3=80=80

While that=E2=80=99s generally the expected pattern, it depends on each k=
thread=20
correctly managing the PF_NOFREEZE flag before entering a TASK_FREEZABLE=20
wait.

This assumption can be fragile in practice =E2=80=94 a missed update or=20
unconventional usage could lead to inconsistent freezing behavior.

> The only thing I didn't fully investigate is this
> {,un}lock_system_sleep() thing. But that would appear to need at least
> the below fixlet.
>
> diff --git a/kernel/power/main.c b/kernel/power/main.c index=20
> 3d484630505a..a415e7d30a2c 100644 --- a/kernel/power/main.c +++=20
> b/kernel/power/main.c @@ -52,8 +52,8 @@ void pm_restrict_gfp_mask(void)=
  unsigned int lock_system_sleep(void)
>   {
>   	unsigned int flags =3D current->flags;
> - current->flags |=3D PF_NOFREEZE;  	mutex_lock(&system_transition_mute=
x);
> + current->flags |=3D PF_NOFREEZE;  	return flags;
>   }
>   EXPORT_SYMBOL_GPL(lock_system_sleep); =E3=80=80 =E3=80=80 =E3=80=80
It seems to me that setting PF_NOFREEZE before acquiring=20
system_transition_mutex might be intentional =E2=80=94 possibly to preven=
t=20
deadlocks.

If the task were to be frozen while holding or waiting for the mutex, it=20
could block suspend or resume paths. So changing the order may risk=20
breaking that protection.

So, although PF_NOFREEZE could be the better long-term solution, right=20
now depending exclusively on it might cause issues.

It would require further standardization and guarantees about the flag=E2=
=80=99s=20
stability during the freezing process before we can fully rely on it.

I=E2=80=99m looking forward to your thoughts on this.

>   =E3=80=80 =E3=80=80 =E3=80=80 =E3=80=80 =E3=80=80=E3=80=80
> Anyway, this seems to suggest something relatively simple like this her=
e
> should do:
>
> diff --git a/kernel/freezer.c b/kernel/freezer.c index=20
> 8d530d0949ff..8b7cecd17564 100644 --- a/kernel/freezer.c +++=20
> b/kernel/freezer.c @@ -162,20 +162,22 @@ static bool=20
> __freeze_task(struct task_struct *p)   */
>   bool freeze_task(struct task_struct *p)
>   {
> - unsigned long flags; - - spin_lock_irqsave(&freezer_lock, flags); -=20
> if (!freezing(p) || frozen(p) || __freeze_task(p)) { -=20
> spin_unlock_irqrestore(&freezer_lock, flags); + /* + * User tasks get=20
> NOFREEZE in do_task_dead(). + */ + if ((p->flags & (PF_NOFREEZE |=20
> PF_KTHREAD)) =3D=3D PF_NOFREEZE)  		return false;
> - } =20
> - if (!(p->flags & PF_KTHREAD)) - fake_signal_wake_up(p); - else -=20
> wake_up_state(p, TASK_NORMAL); + scoped_guard (spinlock_irqsave,=20
> &freezer_lock) { + if (!freezing(p) || frozen(p) || __freeze_task(p))=20
> + return false; + + if (!(p->flags & PF_KTHREAD)) +=20
> fake_signal_wake_up(p); + else + wake_up_state(p, TASK_NORMAL); + } =20
> - spin_unlock_irqrestore(&freezer_lock, flags);  	return true;
>   }

Thanks for the suggestion =E2=80=94 this looks really clean and simplifie=
s the=20
logic nicely! The use of a scoped spinlock and the early return based on=20
PF_NOFREEZE | PF_KTHREAD makes the flow easier to follow.

By the way, in the code above, since for user tasks the PF_NOFREEZE flag=20
is only set once at death (similar to how exit_state is handled), would=20
it make sense to check p->exit_state directly here instead?

It seems semantically equivalent for user tasks, and exit_state might be=20
more explicit in conveying the task's lifecycle state. I'm curious if=20
there's a specific reason to prefer PF_NOFREEZE over exit_state in this=20
case.

Best regards,
Zihuan Zhang



