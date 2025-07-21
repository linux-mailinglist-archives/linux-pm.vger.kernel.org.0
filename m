Return-Path: <linux-pm+bounces-31188-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B883B0C16E
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 12:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60A0F18C1E2C
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 10:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF26428FFDF;
	Mon, 21 Jul 2025 10:39:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3710828FFCF;
	Mon, 21 Jul 2025 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753094379; cv=none; b=Vp4V9QC343MHdUYx8ju4n10OIWUPFRght46fff8q4Hf/cGAdRBIqzy7kJUtkB4q2jZpds9SvvlvFjrt5RXQwZhxkzba5CuvTNXbtxinotvrWGcfl3HB5qv8I5oyBp3otzPUjwJ3uySFZeNTyuhleMgXfHuuVFHVRjJW4c3R9/xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753094379; c=relaxed/simple;
	bh=NMfXEW0darvSk+SHw4P4Bci4H0n6O6pDE7yyhq7TQRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fgw+oAMWoY+1uci5f8AmLE7euKAZ5cHECn3Z9dRJjvRzw2Q4uLu/+C4bh1lBikhe75OgRR3TXRIVAKGmscZ7CgxnrFc77PPYg9b3YGFkwhfCRwxAiXaq4j8qp78rN9E3nXQ+Cr5aytjEl+bJO1/oPTwrBQPay2qSpKfLiAfCo3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: fb8c3242661e11f0b29709d653e92f7d-20250721
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:7b70a50a-c8c5-4af4-8f78-cdd92a44e4c3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:3837259c62051bc1f48edc0c038f409a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fb8c3242661e11f0b29709d653e92f7d-20250721
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1630071012; Mon, 21 Jul 2025 18:39:30 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 271B2E008FA4;
	Mon, 21 Jul 2025 18:39:30 +0800 (CST)
X-ns-mid: postfix-687E18E0-3717542
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 58ECDE008FA3;
	Mon, 21 Jul 2025 18:39:26 +0800 (CST)
Message-ID: <1ca889fd-6ead-4d4f-a3c7-361ea05bb659@kylinos.cn>
Date: Mon, 21 Jul 2025 18:39:25 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/1] PM / Freezer: Skip zombie/dead processes to reduce
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>,
 len brown <len.brown@intel.com>, pavel machek <pavel@kernel.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250716062639.1528066-1-zhangzihuan@kylinos.cn>
 <CAJZ5v0goQ0DcsWAqn__E7CG=YcNAzdxo9bb-21q50V2H5CJ+xA@mail.gmail.com>
 <a664f801-7faf-4a9f-b4b8-365afe0c6f5d@kylinos.cn>
 <CAJZ5v0jvzTupABXQLmTsu7+jEUp14u5XEN4=W7opGi8X2OWorQ@mail.gmail.com>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <CAJZ5v0jvzTupABXQLmTsu7+jEUp14u5XEN4=W7opGi8X2OWorQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/7/17 17:50, Rafael J. Wysocki =E5=86=99=E9=81=93:
> On Thu, Jul 17, 2025 at 3:02=E2=80=AFAM Zihuan Zhang <zhangzihuan@kylin=
os.cn> wrote:
>> HI Rafael,
>>
>> =E5=9C=A8 2025/7/16 20:26, Rafael J. Wysocki =E5=86=99=E9=81=93:
>>> Hi,
>>>
>>> On Wed, Jul 16, 2025 at 8:26=E2=80=AFAM Zihuan Zhang <zhangzihuan@kyl=
inos.cn> wrote:
>>>> Hi all,
>>>>
>>>> This patch series improves the performance of the process freezer by
>>>> skipping zombie tasks during freezing.
>>>>
>>>> In the suspend and hibernation paths, the freezer traverses all task=
s
>>>> and attempts to freeze them. However, zombie tasks (EXIT_ZOMBIE with
>>>> PF_EXITING) are already dead =E2=80=94 they are not schedulable and =
cannot enter
>>>> the refrigerator. Attempting to freeze such tasks is redundant and
>>>> unnecessarily increases freezing time.
>>>>
>>>> In particular, on systems under fork storm conditions (e.g., many
>>>> short-lived processes quickly becoming zombies), the number of zombi=
e tasks
>>>> can spike into the thousands or more. We observed that this causes t=
he
>>>> freezer loop to waste significant time processing tasks that are gua=
ranteed
>>>> to not need freezing.
>>> I think that the discussion with Peter regarding this has not been co=
ncluded.
>>>
>>> I thought that there was an alternative patch proposed during that
>>> discussion.  If I'm not mistaken about this, what happened to that
>>> patch?
>>>
>>> Thanks!
>>>
>> Currently, the general consensus from the discussion is that skipping
>> zombie or dead tasks can help reduce locking overhead during freezing.
> Peter doesn't seem to be convinced that this is the case.
>

Yeah.

>> The remaining question is how best to implement that.
>>
>> Peter suggested skipping all tasks with PF_NOFREEZE, which would make
>> the logic more general and cover all cases. However, as Oleg pointed
>> out, the current implementation based on PF_NOFREEZE might be problema=
tic.
>>
>> My current thought is that exit_state already reliably covers all
>> exiting user processes, and it=E2=80=99s a good fit for skipping user-=
space
>> tasks. For the kernel side, we may safely skip a few kernel threads li=
ke
>> kthreadd that set PF_NOFREEZE and never change it =E2=80=94 we can con=
sider
>> refining this further in the future.
> There is the counter argument of special-casing of p->exit_state and
> the relatively weak justification for it.
>
> You have created a synthetic workload where it matters, but how likely
> is it to be the case in practice?


Our initial thought was that the freezer should primarily focus on tasks=20
that can be frozen. If a task is not freezable and its state will not=20
change (such as kernel threads that have PF_NOFREEZE set permanently),

 =C2=A0it should be safe to skip it during the iteration. This helps to=20
reduce unnecessary overhead when handling a large number of such tasks.

We do not insist that this is the only correct way to implement the=20
optimization =E2=80=94 if there=E2=80=99s a better approach that is equal=
ly safe and=20
more general, we are happy to adopt it.

In practice, the improvement becomes noticeable only when there are a=20
lot of tasks present. So the benefit is scenario-dependent, and we agree=20
that real-world relevance should be considered carefully.

Thanks again for the discussion.


