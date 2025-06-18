Return-Path: <linux-pm+bounces-28946-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C6AADEA14
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 13:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 682EE17B245
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 11:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722DE2DE1F1;
	Wed, 18 Jun 2025 11:30:50 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C567B2DF3D9;
	Wed, 18 Jun 2025 11:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750246250; cv=none; b=Y4zsoOPLOHFdg7sXCC6+BLvRhBPzEBqmcFw/NMUx6N3yHxKUy69VFDJX8vuJ1HX1F60WfYNPtOlbxtBH2JOtYNoKSOSLbEHNKhiD65JaXIdHgitJpHHiNxYqBU2Fyh2IiryQB6MmQ55kMQP1yCnTqopsBQrE/iB+PAqMI4aa/Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750246250; c=relaxed/simple;
	bh=AKzZJsNK3kGCOdfHetbvbaTi98iPP+YfVScP9LEqBA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tvHlHQUBZMja0E2YUi/drYeZ1hMTYgc59WrYyoWKu3Cong02taol2sBrrzlojNPAm5PdTSStCr8FwbS4SheUgWcg4/N8BsdOG4svy20YtNoDIvzu127N03z7tplo+807aAuEDXeIXch+IO0ODfVgEmH/Rdld62kznapaFrBWxWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a781b34e4c3711f0b29709d653e92f7d-20250618
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:c1a1dc15-7e44-4ff4-8265-f2581780a041,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:4fc89cfed55a2a893fbecc6f623ad388,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a781b34e4c3711f0b29709d653e92f7d-20250618
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 20915265; Wed, 18 Jun 2025 19:30:36 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 43CA0E008900;
	Wed, 18 Jun 2025 19:30:36 +0800 (CST)
X-ns-mid: postfix-6852A35C-8396723
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id C637CE008900;
	Wed, 18 Jun 2025 19:30:23 +0800 (CST)
Message-ID: <7d70334a-2e0a-4d1e-b4d0-64d0e3aa5439@kylinos.cn>
Date: Wed, 18 Jun 2025 19:30:23 +0800
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
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <775aaf10-3d19-4d5a-bf2b-703211166be4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi David,

=E5=9C=A8 2025/6/16 15:45, David Hildenbrand =E5=86=99=E9=81=93:
>
>>> [...]
>> In our test scenario, although new processes can indeed be created
>> during the usleep_range() intervals between freeze iterations, it=E2=80=
=99s
>> actually difficult to make the freezer fail outright. This is because
>> user processes are forcibly frozen: when they return to user space and
>> check for pending signals, they enter try_to_freeze() and transition
>> into the refrigerator.
>>
>> However, since the scheduler is fair by design, it gives both newly
>> forked tasks and yet-to-be-frozen tasks a chance to run. This
>> competition for CPU time can slightly delay the overall freeze process=
.
>> While this typically doesn=E2=80=99t lead to failure, it does cause mo=
re retries
>> than necessary, especially under CPU pressure.
>
> I think that goes back to my original comment: why are we even=20
> allowing fork children to run at all when we are currently freezing=20
> all tasks?
>
> I would imagine that try_to_freeze_tasks() should force any new=20
> processes (forked children) to start in the frozen state directly and=20
> not get scheduled in the first place.
>
Thanks again for your comments and suggestion.

We understand the motivation behind your idea: ideally, newly forked=20
tasks during freezing should either be immediately frozen or prevented=20
from running at all, to avoid unnecessary retries and delays. That makes=20
perfect sense.

However, implementing this seems non-trivial under the current freezer=20
model, as it relies on voluntary transitions and lacks a mechanism to=20
block forked children from being scheduled.

Any insights or pointers would be greatly appreciated.

Best regards,
Zihuan Zhang

