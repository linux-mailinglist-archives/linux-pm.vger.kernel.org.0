Return-Path: <linux-pm+bounces-35928-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC34BCF296
	for <lists+linux-pm@lfdr.de>; Sat, 11 Oct 2025 10:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B4FD4E188B
	for <lists+linux-pm@lfdr.de>; Sat, 11 Oct 2025 08:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2885221FAC;
	Sat, 11 Oct 2025 08:51:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D551EDA03;
	Sat, 11 Oct 2025 08:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760172670; cv=none; b=nO0mBg+xKz0gGNWOG8amd3Zq1DIZzrGAAWPlzOWb28dw8p/1KThaznl2cIt6vyP7FE7d++IioC50wiEXQ+vFDOn5GunMXotZ/Am+AMmxvrtSelbfmpcSKWRO1shda0orQUWhgc+6TVpDuX9DgeQhg++aevgOgXt1uJ2EPgrAuCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760172670; c=relaxed/simple;
	bh=Hw6Igadj8Yo1n7H5dH9l8m5yLVK0NcnEb5yK8vOA4ck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N4xjsy8TfCr7V0YVto5NXmFV7c7UVIfggPTUBY4x4jTwMSU40h9F2Y7lqYL4JRhFa88acdABr1E8O0eA2T1KuXVXGraaVlVL2ghXUNtcs0MT/2h2ldAcFOo4Mj2GG/lSPIr+TP33fCB19iQZOPuKhzU6Qg0pvUrU+anqczeJkbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 660c350ea67f11f0a38c85956e01ac42-20251011
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:7e91a0e9-bcf8-4f80-91ee-712d2927436f,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:7e91a0e9-bcf8-4f80-91ee-712d2927436f,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:28b41d47204e27711ef5f2800134809b,BulkI
	D:25101116505733I1UACO,BulkQuantity:0,Recheck:0,SF:17|19|23|43|64|66|74|78
	|80|81|82|83|102|817|841|850,TC:nil,Content:-10|-8|-5|50,EDM:-3,IP:-2,URL:
	0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR
	:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 660c350ea67f11f0a38c85956e01ac42-20251011
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(175.2.104.100)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1450774204; Sat, 11 Oct 2025 16:50:55 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: rafael@kernel.org
Cc: christian.loehle@arm.com,
	dietmar.eggemann@arm.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	srinivas.pandruvada@linux.intel.com
Subject: Re:[PATCH v1 3/3] cpufreq: intel_pstate: Simplify the energy model for hybrid systems
Date: Sat, 11 Oct 2025 16:50:52 +0800
Message-Id: <20251011085052.1237082-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <3914183.kQq0lBPeGt@rafael.j.wysocki>
References: <3914183.kQq0lBPeGt@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Since em_cpu_energy() computes the cost of using a given CPU to
> do work as a product of the utilization of that CPU and a constant
> positive cost coefficient supplied through an energy model, EAS
> evenly distributes the load among CPUs represented by identical
> one-CPU PDs regardless of what is there in the energy model.
> 
> Namely, two CPUs represented by identical PDs have the same energy
> model data and if the PDs are one-CPU, max_util is always equal to the
> utilization of the given CPU, possibly increased by the utilization
> of a task that is waking up.  The cost coefficient is a monotonically
> increasing (or at least non-decreasing) function of max_util, so the
> CPU with higher utilization will generally get a higher (or at least
> not lower) cost coefficient.  After multiplying that coefficient by
> CPU utilization, the resulting number will always be higher for the
> CPU with higher utilization.  Accordingly, whenever these two CPUs
> are compared, the cost of running a waking task will always be higher
> for the CPU with higher utilization which leads to the even distribution
> of load mentioned above.
> 
> For this reason, the energy model can be adjusted in arbitrary
> ways without disturbing the even distribution of load among CPUs
> represented by indentical one-CPU PDs.  In particular, for all of
> those CPUs, the energy model can provide one cost coefficient that
> does not depend on the performance level.

But if the cost is a constant that does not depend on performance levels, 
then the energy increment for running a waking task on these CPUs would be 
the same. For example, for a task with utilization u, whether it is placed 
on CPU A or CPU B, since the cost is the same, the energy increment generated 
would be identical. In this case, EAS should not perform load balancing 
between them.

> 
> Moreover, if there are two different CPU types, A and B, each having
> a performance-independent cost coefficient in the EM, then these
> cost coefficients determine the utilization levels at which CPUs
> of type A and B will be regarded as equally expensive for running
> a waking task.  For example, if the cost coefficient for CPU type
> A is 1, the cost coefficient for CPU type B is 2, and the utilization
> of the waking task is x, a CPU of type A will be regarded as "cost-
> equivalent" to a CPU of type B if its utilization is the sum of x and
> twice the utilization of the latter.  Similarly, for the cost
> coefficients equal to 2 and 3, respectively, the "cost equivalence"
> utilization of CPU type A will be the sum of x/2 and the CPU type B
> utilization multiplied by 3/2.  In the limit of negligibly small x,
> the "cost equivalence" utilization of CPU type A is just the
> utilization of CPU type B multiplied by the ratio of the cost
> coefficients for B and A.  That ratio can be regarded as an effective
> "cost priority" of CPU type A relative to CPU type B, as it indicates
> how much more on average the former needs to be loaded so it can be
> regarded as cost-equivalent to the latter (for low-utilization tasks).
> 
> Use the above observations for simplifying the default energy model
> for hybrid platforms in intel_pstate as follows:
> 
>  * A performance-independent cost coefficient is introduced for each CPU
>    type.
> 
>  * The number of states in each PD is reduced to 2 (it is not necessary
>    to use more of them because the cost per scale-invariant utilization
>    point does not depend on the performance level any more).
> 
>  * CPUs without L3 cache (LPE-cores) that are expected to be the most
>    energy-efficient ones are prioritized over any other CPUs.
> 
>  * The CPU type value from CPUID (now easliy accessible through
>    cpu_data[]) is used for identifying P-cores and E-cores instead
>    of hybrid scaling factors which are less reliable.
> 
>  * E-cores are preferred to P-cores.
> 
> The cost coefficients for different CPU types that can appear in a
> hybrid system (P-cores, E-cores, and LPE-cores that are effectively
> E-cores without L3 cache and with lower capacity) are chosen in
> accordance with the following rules:
> 
>  * The cost priority of LPE-cores relative to E-cores is 1.5.
> 
>  * The cost priority of E-cores relative to P-cores is 2, which
>    also means that the cost priority of LPE-cores relative to
>    P-cores is 3.

