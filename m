Return-Path: <linux-pm+bounces-28624-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2699AD8113
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 04:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F097B1898908
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 02:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3497D245008;
	Fri, 13 Jun 2025 02:38:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B62239E6E;
	Fri, 13 Jun 2025 02:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749782289; cv=none; b=oRL4aIZrAHIF/d73o6wQgihmHdz07xyX2FO1YyDYsD+xCqZvJ1q6oGHfjx1ktxtcwA8cFpsvIJOfhkVRo/uvwesQf47X6b5gubqodU7x0OYmlnwqABgi+q0pVwY8Sh1wibT/rpKIrgKPczQexlsUSTWUNjrPfeeAJCeCLU+/J3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749782289; c=relaxed/simple;
	bh=WwvWPbmRlKpBLtPTxWYGuaOrIli0utmN4BBRuQsSjlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lg9H/BB5ssgDLtx1YdnR8L8u6wApkFy3JO1BcpQ8Wi22ggXyH8rCS7VlXSwcfyBuzR2osjRYzDEOViwMMQSMm45TFXk+y6I4bYbisZPzI9O3fzFXJtu4y740cGOxDN1bRHIDcxTtCJj4F+EVb78FMmCbwWwuyMG1g4hdDY+dIOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6828249e47ff11f0b29709d653e92f7d-20250613
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:f3e38a24-9ea0-4bae-80a1-0c1b6296ae74,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:a6f9af147292666a12ddb0af02a6babc,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6828249e47ff11f0b29709d653e92f7d-20250613
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1247614276; Fri, 13 Jun 2025 10:37:53 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 85FA6E0097F9;
	Fri, 13 Jun 2025 10:37:53 +0800 (CST)
X-ns-mid: postfix-684B8F00-992813246
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 2FA8EE0097F7;
	Fri, 13 Jun 2025 10:37:43 +0800 (CST)
Message-ID: <a4370ebc-b1ce-46ba-b3a4-cb628125d7d0@kylinos.cn>
Date: Fri, 13 Jun 2025 10:37:42 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] PM: Optionally block user fork during freeze to
 improve performance
To: David Hildenbrand <david@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: rafael@kernel.org, len.brown@intel.com, pavel@kernel.org,
 kees@kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20250606062502.19607-1-zhangzihuan@kylinos.cn>
 <20250606082244.GL30486@noisy.programming.kicks-ass.net>
 <83513599-e007-4d07-ac28-386bc5c7552d@kylinos.cn>
 <cd548b13-620e-4df5-9901-1702f904d470@redhat.com>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <cd548b13-620e-4df5-9901-1702f904d470@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi David,
Thanks for your advice!

=E5=9C=A8 2025/6/10 18:50, David Hildenbrand =E5=86=99=E9=81=93:
> =E3=80=80=E3=80=80=E3=80=80 =E3=80=80 =E3=80=80 =E3=80=80=E3=80=80 =E3=80=
=80 =E3=80=80 =E3=80=80 =E3=80=80 =E3=80=80 =E3=80=80 =E3=80=80 =E3=80=80=
 =E3=80=80 =E3=80=80=E3=80=80
> Can't this problem be mitigated by simply not scheduling the new fork'e=
d
> process while the system is frozen?
>
> Or what exact scenario are you worried about?

Let me revisit the core issue for clarity. Under normal conditions, most=20
processes in the system are in a sleep state, and only a few are=20
runnable. So even with thousands of processes, the freezer generally=20
works reliably and completes within a reasonable time
However, in our fork-based test scenario, we observed repeated freeze=20
retries. This is not due to process count directly, but rather due to a=20
scheduling behavior during the freeze phase. Specifically, the freezer=20
logic contains the following snippet:
Here is the relevant freezer code that introduces the yield:
* We need to retry, but first give the freezing tasks some * time to=20
enter the refrigerator. Start with an initial * 1 ms sleep followed by=20
exponential backoff until 8 ms. */ usleep_range(sleep_usecs / 2,=20
sleep_usecs); if (sleep_usecs < 8 * USEC_PER_MSEC) sleep_usecs *=3D 2;
This mechanism is usually effective because most tasks are sleeping and=20
quickly enter the frozen state. But with concurrent fork() bombs, we=20
observed that this CPU relinquish gives new child processes a chance to=20
run, delaying or blocking the freezer's progress.
When only a single fork loop is running, it=E2=80=99s often frozen before=
 the=20
next retry. But when multiple forkers compete for CPU, we observed an=20
increase in the todo count and repeated retries.
So while preventing the scheduling of newly forked processes would solve=20
the problem at its root, it would require deeper architectural changes=20
(e.g., task-level flags or restrictions at the scheduler level).
We initially considered whether replacing usleep_range() with a=20
non-yielding wait might reduce this contention window. However, this=20
approach turned out to be counterproductive =E2=80=94 it starves other no=
rmal=20
user tasks that need CPU time to reach their try_to_freeze() checkpoint,=20
ultimately making the freeze process slower .
You=E2=80=99re right =E2=80=94 blocking fork() is quite intrusive, so it=E2=
=80=99s worth=20
exploring alternatives. We=E2=80=99ll try implementing your idea of preve=
nting=20
the newly forked process from being scheduled while the system is=20
freezing, rather than failing the fork() call outright.

This may allow us to maintain compatibility with existing userspace=20
while avoiding interference with the freezer traversal. We=E2=80=99ll eva=
luate=20
whether this approach can reliably mitigate the issue (especially the=20
scheduling race window between copy_process() and freeze_task()), and=20
report back with results.

Best regards,
Zihuan Zhang



