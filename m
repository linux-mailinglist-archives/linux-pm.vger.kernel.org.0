Return-Path: <linux-pm+bounces-31482-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D6CB13AFA
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 15:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626EC3ABC83
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 13:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B336E257AF0;
	Mon, 28 Jul 2025 13:06:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C4816DEB1;
	Mon, 28 Jul 2025 13:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753708002; cv=none; b=kuRu/UItJTEhzHj2eehOPLjS9yfty96UTdgUbzayJ6zX1pKTB/BUzN9lDVupN4jBzTbtMkiRQsdIriKvzaCTFsbMOJ87Gi7a+/y+kudimt9OZJ7MKaWwa+E4gV1zt1mXr59VZwEPdHu6XqMpPcg/3GST8ldcqDMu5RldMg/t5Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753708002; c=relaxed/simple;
	bh=/QC5Uml2RzEUPlWKdwR99j7fu1LpzpTRb5ePH6MzOdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZUUX8qExFcUQqTcii9jlXxMW6hbKCyepOtw+J+3E2u2nexmaS0peb/ofzr7ua6LkKoE5m50Ja8EoniDCL1KMByA+k9cdV0XyfU1atSdyxtlOZVe0uO4BohzxuLLY2DTEd+8FW+mKdFnyPVjRt/x1bIDOIPIU+Ton5v7CTOCquU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: aff7d8466bb311f0b29709d653e92f7d-20250728
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:65580000-cbad-4731-8dc5-6e4149e6dd64,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:7a757c635182a2bde344434a80c9e0fe,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: aff7d8466bb311f0b29709d653e92f7d-20250728
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1996137064; Mon, 28 Jul 2025 21:06:34 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 1F3B3E008FA4;
	Mon, 28 Jul 2025 21:06:34 +0800 (CST)
X-ns-mid: postfix-688775D9-9540941
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 70404E008FA2;
	Mon, 28 Jul 2025 21:06:28 +0800 (CST)
Message-ID: <fa7485e4-a3d9-45ef-a0f5-6a3b9dd12f93@kylinos.cn>
Date: Mon, 28 Jul 2025 21:06:27 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] PM: Optionally block user fork during freeze to
 improve performance
To: David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>, rafael@kernel.org,
 len.brown@intel.com, pavel@kernel.org, kees@kernel.org, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250606062502.19607-1-zhangzihuan@kylinos.cn>
 <20250606082244.GL30486@noisy.programming.kicks-ass.net>
 <83513599-e007-4d07-ac28-386bc5c7552d@kylinos.cn>
 <cd548b13-620e-4df5-9901-1702f904d470@redhat.com>
 <a4370ebc-b1ce-46ba-b3a4-cb628125d7d0@kylinos.cn>
 <aEvNqY5piB02l20T@tiehlicka>
 <ee1de994-e59f-4c6c-96f3-66056b002889@kylinos.cn>
 <775aaf10-3d19-4d5a-bf2b-703211166be4@redhat.com>
 <7d70334a-2e0a-4d1e-b4d0-64d0e3aa5439@kylinos.cn>
 <345a04ad-cf25-4af5-802a-bc8826d37b19@redhat.com>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <345a04ad-cf25-4af5-802a-bc8826d37b19@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

=E5=9C=A8 2025/6/18 19:54, David Hildenbrand =E5=86=99=E9=81=93:
> On 18.06.25 13:30, Zihuan Zhang wrote:
>> Hi David,
>>
>> =E5=9C=A8 2025/6/16 15:45, David Hildenbrand =E5=86=99=E9=81=93:
>>>
>>>>> [...]
>>>> In our test scenario, although new processes can indeed be created
>>>> during the usleep_range() intervals between freeze iterations, it=E2=
=80=99s
>>>> actually difficult to make the freezer fail outright. This is becaus=
e
>>>> user processes are forcibly frozen: when they return to user space a=
nd
>>>> check for pending signals, they enter try_to_freeze() and transition
>>>> into the refrigerator.
>>>>
>>>> However, since the scheduler is fair by design, it gives both newly
>>>> forked tasks and yet-to-be-frozen tasks a chance to run. This
>>>> competition for CPU time can slightly delay the overall freeze=20
>>>> process.
>>>> While this typically doesn=E2=80=99t lead to failure, it does cause =
more=20
>>>> retries
>>>> than necessary, especially under CPU pressure.
>>>
>>> I think that goes back to my original comment: why are we even
>>> allowing fork children to run at all when we are currently freezing
>>> all tasks?
>>>
>>> I would imagine that try_to_freeze_tasks() should force any new
>>> processes (forked children) to start in the frozen state directly and
>>> not get scheduled in the first place.
>>>
>> Thanks again for your comments and suggestion.
>>
>> We understand the motivation behind your idea: ideally, newly forked
>> tasks during freezing should either be immediately frozen or prevented
>> from running at all, to avoid unnecessary retries and delays. That mak=
es
>> perfect sense.
>>
>> However, implementing this seems non-trivial under the current freezer
>> model, as it relies on voluntary transitions and lacks a mechanism to
>> block forked children from being scheduled.
>>
>> Any insights or pointers would be greatly appreciated.
>
> I'm afraid I can't provide too much guidance on scheduler logic.
>
> Apparently we have this freezer_active global that forces existing=20
> frozen pages to enter the freezing_slow_path().
>
> There, we perform multiple checks, including "pm_freezing &&=20
> !(p->flags & PF_KTHREAD)".
>
> I would have thought that we would want to make fork()/clone()=20
> children while freezing also result in freezing_slow_path()=3D=3Dtrue, =
and=20
> stop them from getting scheduled in the first place.
>
> Again, no scheduler expert, but that's something I would look into.
>
We=E2=80=99re currently working on a new freeze priority mechanism, which=
 allows=20
the freezer to freeze user processes in layers rather than treating all=20
tasks equally.

With our priority-based model, we can ensure that key processes are=20
frozen in the correct order to avoid this class of problems entirely. I=20
believe this approach will address the issue in a more robust and=20
general way.

I=E2=80=99ll share the patchset soon for feedback after serval weeks.




