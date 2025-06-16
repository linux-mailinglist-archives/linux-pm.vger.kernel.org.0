Return-Path: <linux-pm+bounces-28770-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CA1ADA6F1
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 05:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9B5188FF2A
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 03:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FAA3594C;
	Mon, 16 Jun 2025 03:46:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E5063CB;
	Mon, 16 Jun 2025 03:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750045615; cv=none; b=nmI2KXtfwPibJkg/7QnM2Pg3hKcVqyP4UoTqga9v9s+PfVtrcvYCIyXLrx7GyR3A5o1akh/r31O6cnpbWDpFi/hLbii0KdeKMuagyp50IqvKydPrVOMewjhNQDHJM3JJQ+uQGb9esU5/ur1SuE0c9/UuTSvMchwFTZfAeFx7Y6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750045615; c=relaxed/simple;
	bh=LDtNMiH8SuKNPezVBkxwDxKKq8DGchl8pwBx2uQky6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+qTRGGk6PlHg28MqqhEnDvdJcdZIq76JwZlNT4HK0rP8ysr5bwIjmvkTJcNkNKUKPu2xLGsLtH74+yVj4vs0cps7vlKErkUNLEYVwSpwX29N2YeRaGMsG1wge5wN2uhafN6nXW4shjBLKyAiKDggkH6OvRptrGIB6A7MjuMLeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 845e65da4a6411f0b29709d653e92f7d-20250616
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:c53be892-6c29-4028-8e9f-2ddfdc43491b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:3830bdf148845bb9a5025001a0e6403e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 845e65da4a6411f0b29709d653e92f7d-20250616
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1857386657; Mon, 16 Jun 2025 11:46:42 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 4684FE00891C;
	Mon, 16 Jun 2025 11:46:42 +0800 (CST)
X-ns-mid: postfix-684F93A2-171212898
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 04533E008900;
	Mon, 16 Jun 2025 11:46:34 +0800 (CST)
Message-ID: <ee1de994-e59f-4c6c-96f3-66056b002889@kylinos.cn>
Date: Mon, 16 Jun 2025 11:46:34 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] PM: Optionally block user fork during freeze to
 improve performance
To: Michal Hocko <mhocko@suse.com>
Cc: David Hildenbrand <david@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, rafael@kernel.org,
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
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <aEvNqY5piB02l20T@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi=C2=A0=C2=A0Michal,

Thanks for the question.

=E5=9C=A8 2025/6/13 15:05, Michal Hocko =E5=86=99=E9=81=93:
> On Fri 13-06-25 10:37:42, Zihuan Zhang wrote:
>> Hi David,
>> Thanks for your advice!
>>
>> =E5=9C=A8 2025/6/10 18:50, David Hildenbrand =E5=86=99=E9=81=93:
>>> =E3=80=80=E3=80=80=E3=80=80 =E3=80=80 =E3=80=80 =E3=80=80=E3=80=80 =E3=
=80=80 =E3=80=80 =E3=80=80 =E3=80=80 =E3=80=80 =E3=80=80 =E3=80=80 =E3=80=
=80 =E3=80=80 =E3=80=80=E3=80=80
>>> Can't this problem be mitigated by simply not scheduling the new fork=
'ed
>>> process while the system is frozen?
>>>
>>> Or what exact scenario are you worried about?
>> Let me revisit the core issue for clarity. Under normal conditions, mo=
st
>> processes in the system are in a sleep state, and only a few are runna=
ble.
>> So even with thousands of processes, the freezer generally works relia=
bly
>> and completes within a reasonable time
> How do you define reasonable time?
>

To clarify: freezing a process typically takes only a few dozen=20
microseconds. In our tests, the freezer includes a usleep_range() delay=20
between retries, which is about 1ms in the first round and doubles in=20
subsequent rounds. Despite this delay, we observed that around 10% of=20
the processes were not frozen during the first pass and had to be retried=
.

This suggests that even with a reasonably sufficient delay, some newly=20
forked processes do not get frozen in time during the first iteration,=20
simply due to timing. The freeze latency itself remains small, but not=20
all processes are caught on the first try.
>> However, in our fork-based test scenario, we observed repeated freeze
>> retries.
> Does this represent any real life scenario that happens on your system?
> In other words how often do you miss your "reasonable time" treshold
> while running a regular workload. Does the freezer ever fail?
>
> [...]
In our test scenario, although new processes can indeed be created=20
during the usleep_range() intervals between freeze iterations, it=E2=80=99=
s=20
actually difficult to make the freezer fail outright. This is because=20
user processes are forcibly frozen: when they return to user space and=20
check for pending signals, they enter try_to_freeze() and transition=20
into the refrigerator.

However, since the scheduler is fair by design, it gives both newly=20
forked tasks and yet-to-be-frozen tasks a chance to run. This=20
competition for CPU time can slightly delay the overall freeze process.=20
While this typically doesn=E2=80=99t lead to failure, it does cause more =
retries=20
than necessary, especially under CPU pressure.

Given that freezing is a clearly defined and semantically critical state=20
transition, we believe it makes sense to prioritize the execution of=20
tasks that are pending freezing over newly forked ones=E2=80=94particular=
ly in=20
resource-constrained environments
>> You=E2=80=99re right =E2=80=94 blocking fork() is quite intrusive, so =
it=E2=80=99s worth exploring
>> alternatives. We=E2=80=99ll try implementing your idea of preventing t=
he newly
>> forked process from being scheduled while the system is freezing, rath=
er
>> than failing the fork() call outright.
> Just curious, are you interested in global freezer only or is the cgrou=
p
> freezer involved as well?
>
At this stage, our focus is mainly on the global freezer during system=20
suspend and hibernate (S3/S4). However, the patch itself is based on the=20
generic freezing() and freeze_task() logic, so it should also work with=20
the cgroup freezer as well.

