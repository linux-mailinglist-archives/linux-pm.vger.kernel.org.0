Return-Path: <linux-pm+bounces-30095-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89278AF8547
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 03:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0C141C2842F
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 01:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA39517A318;
	Fri,  4 Jul 2025 01:45:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26897263A;
	Fri,  4 Jul 2025 01:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751593538; cv=none; b=mD8C+2zoZo1XChjTJRg0QcfA5QjIXBIgCcBrnZf4w7C2FiF3v4dNOdzmmOZEWzeV8Nt3VbYjz5wZliGz9T1HgEH3xEMAI87+R7v0UlN+KGhvkPPBBcwdD8sMf20yNvLuixLiG2Fp5Zeu+DjESTuHXxTA9pgBVANpJKoPxPI8+UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751593538; c=relaxed/simple;
	bh=rFLXW549b5mO0GPCQ0k+u5kNNhPy7ldTm3OZwUCv1Qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWJoi7fczqCCqTjY+XO4J/x/Pzw2Mrekkq/czr3xLGIUM4b6NYdLaYbRRZCaepISu7cki3Yld95ZAiLYq1h/8Juy/jl2WuZPCdcW3/m7PJTyoLkXC0QlO/6vy40mEbRIAOSVtSx/oRtpTycBvrhAEpfV1sy4akHkcVSARSoRMt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8a755dd0587811f0b29709d653e92f7d-20250704
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:bcb7889e-9dea-46b0-93a7-97c2fb23ccab,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:fcf40e201173583ad54fa3105ccb763a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8a755dd0587811f0b29709d653e92f7d-20250704
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1367050967; Fri, 04 Jul 2025 09:45:19 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id D5384E008FA2;
	Fri,  4 Jul 2025 09:45:18 +0800 (CST)
X-ns-mid: postfix-6867322E-732463268
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 0F130E008FA1;
	Fri,  4 Jul 2025 09:45:16 +0800 (CST)
Message-ID: <f4fcb703-ba1d-4614-a411-eefbf04ddf45@kylinos.cn>
Date: Fri, 4 Jul 2025 09:45:16 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] PM / Freezer: Skip zombie/dead processes to
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: pavel@kernel.org, len.brown@intel.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
References: <20250611101247.15522-1-zhangzihuan@kylinos.cn>
 <20250611101247.15522-2-zhangzihuan@kylinos.cn>
 <CAJZ5v0jpuUVM73M=Gzq36je=K_7zEkvVd8bxohi6N5OYgxgUug@mail.gmail.com>
 <20250703164021.GY1613200@noisy.programming.kicks-ass.net>
 <CAJZ5v0j29Nu2nitmj6tPhOQYuSaHBtXQVR21ikDtrxpejPdW8A@mail.gmail.com>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <CAJZ5v0j29Nu2nitmj6tPhOQYuSaHBtXQVR21ikDtrxpejPdW8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi=C2=A0Rafael,

=E5=9C=A8 2025/7/4 01:15, Rafael J. Wysocki =E5=86=99=E9=81=93:
> On Thu, Jul 3, 2025 at 6:40=E2=80=AFPM Peter Zijlstra <peterz@infradead=
.org> wrote:
>> On Thu, Jul 03, 2025 at 04:15:10PM +0200, Rafael J. Wysocki wrote:
>>> The patch subject appears to be incomplete.
You=E2=80=99re right =E2=80=94 the patch subject was indeed incomplete. T=
hat was an=20
oversight on my part, and I=E2=80=99ll fix it in the next version.

Thanks for pointing it out.
>>> On Wed, Jun 11, 2025 at 12:13=E2=80=AFPM Zihuan Zhang <zhangzihuan@ky=
linos.cn> wrote:
>>>> When freezing user space during suspend or hibernation, the freezer
>>>> iterates over all tasks and attempts to freeze them via
>>>> try_to_freeze_tasks().
>>>>
>>>> However, zombie processes (i.e., tasks in EXIT_ZOMBIE state) are no
>>>> longer running and will never enter the refrigerator. Trying to free=
ze
>>>> them is meaningless and causes extra overhead, especially when there=
 are
>>>> thousands of zombies created during stress conditions such as fork
>>>> storms.
>>>>
>>>> This patch skips zombie processes during the freezing phase.
>>>>
>>>> In our testing with ~30,000 user processes (including many zombies),=
 the
>>>> average freeze time during suspend (S3) dropped from ~43 ms to ~16 m=
s:
>>>>
>>>>      - Without the patch: ~43 ms average freeze latency
>>>>      - With the patch:    ~16 ms average freeze latency
>>>>      - Improvement:       ~62%
>>> And what's the total suspend time on the system in question?
>>>
We used the sleepgraph tool to measure the full suspend-to-RAM (S3)=20
latency on our test platform. The total suspend time was around 1859.055=20
ms, so the optimization to skip zombie processes =E2=80=94 reducing freez=
e time=20
from ~43 ms to ~16 ms =E2=80=94 accounts for roughly 1% of the total susp=
end=20
latency.

While the absolute gain is relatively small, it helps reduce unnecessary=20
overhead under stress conditions such as fork storms with many zombie=20
tasks, and improves freeze-time predictability.

>>>> This confirms that skipping zombies significantly speeds up the free=
zing
>>>> process when the system is under heavy load with many short-lived ta=
sks.
>>>>
>>>> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
>>>>
>>>> Changes in v3:
>>>> - Added performance test
>>>>
>>>> Changes in v2:
>>>> - Simplified code, added judgment of dead processes
>>>> - Rewrite changelog
>>>> ---
>>>>   kernel/power/process.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/power/process.c b/kernel/power/process.c
>>>> index a6f7ba2d283d..2bbe22610522 100644
>>>> --- a/kernel/power/process.c
>>>> +++ b/kernel/power/process.c
>>>> @@ -51,7 +51,7 @@ static int try_to_freeze_tasks(bool user_only)
>>>>                  todo =3D 0;
>>>>                  read_lock(&tasklist_lock);
>>>>                  for_each_process_thread(g, p) {
>>>> -                       if (p =3D=3D current || !freeze_task(p))
>>>> +                       if (p =3D=3D current || p->exit_state || !fr=
eeze_task(p))
>>>>                                  continue;
>>>>
>>>>                          todo++;
>>>> --
>>> This is basically fine by me, but I wonder what other people think.
>>>
>>> Peter?
>> How realistic is it to have a significant amount of zombies when
>> freezing? This seems like an artificial corner case at best.
>>
>> Zombie tasks are stuck waiting on their parent to consume their exit
>> state or something, right? And those parents being frozen, they pretty
>> much stay there.
>>
>> So I suppose the logic holds, but urgh, do we really need this?
> Unlikely in practice, but the code change is small and it would be
> prudent to get this addressed IMV (at least so we don't need to
> revisit it).
>
> But I would ask for a comment above this check to explain that zombies
> need not be frozen.
Thanks for the suggestion.

Yes, I=E2=80=99ll add a comment to clarify the rationale. Planning to add=
 the=20
following just above the check:
> /*
>   * Zombie and dead tasks are not running anymore and cannot enter
>   * the __refrigerator(). Skipping them avoids unnecessary freeze attem=
pts.
>   */

I=E2=80=99ll include this in the next version of the patch.

Best regards,
Zihuan Zhang


