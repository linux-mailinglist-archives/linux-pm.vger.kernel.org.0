Return-Path: <linux-pm+bounces-30987-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59495B08824
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 10:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F7294A7B8E
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 08:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81AC283128;
	Thu, 17 Jul 2025 08:46:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8151C1D7984;
	Thu, 17 Jul 2025 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752741962; cv=none; b=KgAmJT85VMpf3Og0hHFWuxBYfYxOfpK+1pXiMdVjueBKG92zlorbnNf1gFle8r97kOSX2Zxg39/yggFXVzWtQZT/1Es/dzGgrbUoHTDyzDze+ZHyMuEhH3BnU0KYhL9cbvM48LNAJxH/bcJu6h9UQxyzcNXxyUv5eZKGamXLLKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752741962; c=relaxed/simple;
	bh=SpCr1wY1nWMBDF/jcIen/XcUs4WWiwoXCVsFiT4+rOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b+8noUaZ0k5At416jrDOcFKc0pGTtk/Qz3v1ZffusjVxQDnBQwW8/SbmD6SzPFdEC+ug7mIA38kMclTuRS2BxkQTW2JGQHVl5AMkMPi+Df5yl1ek/i4rkDKC79K8Hhg1RkaGx6ZuKL0WP9nzkcURN9N8iePdd6GFfK5rE4DfapM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 71bcb7c662ea11f0b29709d653e92f7d-20250717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:5b400d1e-93d1-4470-9488-307bbdf30090,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:375b463e6296087dc82d2f9d9e64701d,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 71bcb7c662ea11f0b29709d653e92f7d-20250717
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 857520807; Thu, 17 Jul 2025 16:45:51 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 6D0EBE008FA5;
	Thu, 17 Jul 2025 16:45:51 +0800 (CST)
X-ns-mid: postfix-6878B83E-628209128
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 9F292E008FA3;
	Thu, 17 Jul 2025 16:45:49 +0800 (CST)
Message-ID: <6ab5e858-c0bd-4cb0-b1f8-b95c452c6b6b@kylinos.cn>
Date: Thu, 17 Jul 2025 16:45:48 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] PM / Freezer: Skip zombie/dead processes to reduce
 freeze latency
To: Oleg Nesterov <oleg@redhat.com>
Cc: "rafael J . wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, len brown <len.brown@intel.com>,
 pavel machek <pavel@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250716062639.1528066-1-zhangzihuan@kylinos.cn>
 <20250716062639.1528066-2-zhangzihuan@kylinos.cn>
 <20250716163854.GE16401@redhat.com>
 <c6c7e8b5-430b-4616-b9e8-46500621bb84@kylinos.cn>
 <20250717013158.GF16401@redhat.com>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250717013158.GF16401@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

=E5=9C=A8 2025/7/17 09:31, Oleg Nesterov =E5=86=99=E9=81=93:
> Hi Zihuan,
>
> On 07/17, Zihuan Zhang wrote:
>>>> +			 */
>>>> +			if (p =3D=3D current || p->exit_state || !freeze_task(p))
>>>>   				continue;
>>> I leave this to you and Rafael, but this change doesn't look safe to =
me.
>>> What if the exiting task does some IO after exit_notify() ?
>> Tasks that have passed exit_notify() and entered EXIT_ZOMBIE are no lo=
nger
>> schedulable,
> How so? please look at do_exit(). The exiting task is still running
> until it does its last __schedule() in do_task_dead().
>
To verify the potential presence of EXIT_DEAD tasks during the freezing=20
stage, I added some logging in try_to_freeze_tasks() to print out any=20
task with exit_state =3D=3D EXIT_DEAD. Then I created a fork storm scenar=
io=20
to ensure a large number of tasks are exiting during the freeze window.

In practice, even after running hundreds of iterations under heavy load,=20
I wasn=E2=80=99t able to capture any such task being printed. Since the e=
xit=20
phase is very fast, it seems unlikely that an EXIT_DEAD task stays in=20
the process list long enough to be observed during the freeze loop.

So I believe it's safe to skip tasks with exit_state=C2=A0 in this contex=
t.

diff --git a/kernel/power/process.c b/kernel/power/process.c
index c1d6c5150033..054fad43ed31 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -59,6 +59,8 @@ static int try_to_freeze_tasks(bool user_only)
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0* a more generic exclusion mechanism for other=20
non-freezable tasks.
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0* However, for now, exit_state is sufficient=20
to skip user processes.
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*/
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (p->exit_state =3D=3D EXIT_DEAD)
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_info("current process is going t=
o=20
dead name:%s pid:%d=C2=A0 \n", p->comm, p->pid);
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (p =3D=3D current || p->exit_state ||=20
!freeze_task(p))
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;

>> so they cannot do I/O anymore. Skipping them during freezing
>> should be safe
> Oleg.
>

