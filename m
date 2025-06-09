Return-Path: <linux-pm+bounces-28294-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E913AD178C
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 05:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFC3C3A975E
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 03:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037841714B4;
	Mon,  9 Jun 2025 03:46:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCDE15E8B;
	Mon,  9 Jun 2025 03:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749440797; cv=none; b=PiTMtoX9llRjZChCSAnKeNWclwL12SN0tNXQHthrXY0fRA9AhfoZHfGr8lnUdOpkVOknWoBDUiaRw+3S1U4uo4EhlkWxrVXAs0OoaoCbIJRBkECIpOjqig3nYfPEq5s7wre/IOn4/jqr/43GTsl8pdbEjw89g0qqhspirTlhFJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749440797; c=relaxed/simple;
	bh=bWyTulDGvJXASDzALfuve1RBti4/6fTl6mutR7WvwvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bzOgjMZ60kzy/Rub4DlBKyN6xxHL2XHbudv9MJ9PgEFcNUpxxs3o8sU1B48ItbvC3Bj2Eg7PSY23FXnqQ0ULApYO1kH21YdpVakLDb2JJy5w5oQ+HYIctm/pinIbnTeVkU2jUB2UlnZXyCPokCAFS1WEhwG7Lg1qQZk6w9uW8PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 51d2f63844e411f0b29709d653e92f7d-20250609
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:1b480f2b-af7a-4999-bcda-f11ee377a456,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:9e483725f417c604585cbed8794d6973,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 51d2f63844e411f0b29709d653e92f7d-20250609
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1805858340; Mon, 09 Jun 2025 11:46:26 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 261DCE00891C;
	Mon,  9 Jun 2025 11:46:26 +0800 (CST)
X-ns-mid: postfix-68465912-130933
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 94192E008900;
	Mon,  9 Jun 2025 11:46:20 +0800 (CST)
Message-ID: <b161b92e-c290-4a85-adc9-fbc325568e7d@kylinos.cn>
Date: Mon, 9 Jun 2025 11:46:19 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] PM: Optionally block user fork during freeze to
 improve performance
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, rafael@kernel.org,
 len.brown@intel.com, pavel@kernel.org, kees@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250606062502.19607-1-zhangzihuan@kylinos.cn>
 <0030581f-d50a-48f4-86f5-58e7883f705d@redhat.com>
 <6350624c-7293-43de-8788-e52a236d91fb@kylinos.cn>
 <5mj4mc7asiplmgbqyl2uaw5cdpt6dpdrhtapi63dcrowozcwuq@c4cxyaxwe6aw>
From: zhangzihuan <zhangzihuan@kylinos.cn>
In-Reply-To: <5mj4mc7asiplmgbqyl2uaw5cdpt6dpdrhtapi63dcrowozcwuq@c4cxyaxwe6aw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Mateusz,

Thanks again for your detailed input.

You=E2=80=99re absolutely right that try_to_freeze_tasks() holds the=20
tasklist_lock during the main freeze loop, which temporarily blocks=20
kernel_clone() at that stage. However, based on our observations and=20
logs, the problem arises just after this loop, in the short window=20
before the system enters suspend (e.g., around the brief usleep()=20
period), when the lock is released and fork is once again possible.

To illustrate this, I=E2=80=99d like to share some dmesg logs gathered du=
ring a=20
series of S3 suspend attempts. In most suspend cycles, we intentionally=20
run a user-space process that forks rapidly during suspend, and we=20
observe multiple retries during the =E2=80=9Cfreezing user space processe=
s=E2=80=9D=20
phase. Below are selected entries

=E5=9C=A8 2025/6/8 23:50, Mateusz Guzik =E5=86=99=E9=81=93:
> On Sun, Jun 08, 2025 at 03:22:20PM +0800, zhangzihuan wrote:
>> One alternative could be to block in kernel_clone() until freezing end=
s,
>> instead of returning an error. That way, fork() would not fail, just
>> potentially block briefly (similar to memory pressure or cgroup limits=
). Do
>> you think that's more acceptable?
> So I had a look at the freezing loop and it operates with
> tasklist_lock held, meaning it already stalls clone().
>
> try_to_freeze_tasks() in kernel/power/process.c contains:
>
> 	todo =3D 0;
> 	read_lock(&tasklist_lock);
> 	for_each_process_thread(g, p) {
> 		if (p =3D=3D current || !freeze_task(p))
> 			continue;
>
> 		todo++;
> 	}
> 	read_unlock(&tasklist_lock);
>
> I don't get where the assumption that fork itself is a factor is coming
> from.
>
> Looking at freezing itself it seems to me perf trouble starts with tons
> of processes existing to begin with in arbitrary states (not with racin=
g
> against fork), requring a retry with preceeded by a sleep:
>
> 	/*
> 	 * We need to retry, but first give the freezing tasks some
> 	 * time to enter the refrigerator.  Start with an initial
> 	 * 1 ms sleep followed by exponential backoff until 8 ms.
> 	 */
> 	usleep_range(sleep_usecs / 2, sleep_usecs);
> 	if (sleep_usecs < 8 * USEC_PER_MSEC)
> 		sleep_usecs *=3D 2;
>
> For a race against fork to have any effect, the new thread has to be
> linked in to the global list -- otherwise the todo var wont get bumped.
>
> But then if it gets added in a state which is freezable, the racing for=
k
> did not cause any trouble.
>
> If it gets added in a state which is *NOT* freezable by the current
> code, maybe it should be patched to be freezable.
>
> All in all I'm not confident any of this warrants any work -- do you
> have a setup where the above causes a real problem?

Here is the log:

dmesg | grep -E 'elap|Files|retry'

[ 2556.566183] Filesystems sync: 0.012 seconds
[ 2556.570653] Freeing user space processes todo:1181 retry:0
[ 2556.572719] Freeing user space processes todo:0 retry:1
[ 2556.572730] Freezing user space processes completed (elapsed 0.006=20
seconds)
[ 2556.573243] Freeing remaining freezable tasks todo:13 retry:0
[ 2556.574326] Freeing remaining freezable tasks todo:0 retry:1
[ 2556.574333] Freezing remaining freezable tasks completed (elapsed=20
0.001 seconds)
[ 2560.647576] Filesystems sync: 0.018 seconds
[ 2560.656691] Freeing user space processes todo:2656 retry:0
[ 2560.661194] Freeing user space processes todo:327 retry:1
[ 2560.664130] Freeing user space processes todo:0 retry:2
[ 2560.664139] Freezing user space processes completed (elapsed 0.016=20
seconds)
[ 2560.665475] Freeing remaining freezable tasks todo:13 retry:0
[ 2560.667159] Freeing remaining freezable tasks todo:0 retry:1
[ 2560.667170] Freezing remaining freezable tasks completed (elapsed=20
0.003 seconds)
[ 2564.746592] Filesystems sync: 0.013 seconds
[ 2564.761025] Freeing user space processes todo:4192 retry:0
[ 2564.768048] Freeing user space processes todo:252 retry:1
[ 2564.773774] Freeing user space processes todo:0 retry:2
[ 2564.773801] Freezing user space processes completed (elapsed 0.026=20
seconds)
[ 2564.776704] Freeing remaining freezable tasks todo:13 retry:0
[ 2564.781867] Freeing remaining freezable tasks todo:0 retry:1
[ 2564.781887] Freezing remaining freezable tasks completed (elapsed=20
0.008 seconds)
[ 2568.872805] Filesystems sync: 0.010 seconds
[ 2568.893397] Freeing user space processes todo:5897 retry:0
[ 2568.903089] Freeing user space processes todo:0 retry:1
[ 2568.903102] Freezing user space processes completed (elapsed 0.030=20
seconds)
[ 2568.907681] Freeing remaining freezable tasks todo:13 retry:0
[ 2568.914721] Freeing remaining freezable tasks todo:0 retry:1
[ 2568.914743] Freezing remaining freezable tasks completed (elapsed=20
0.011 seconds)
[ 2573.019240] Filesystems sync: 0.018 seconds
[ 2573.044573] Freeing user space processes todo:7536 retry:0
[ 2573.056378] Freeing user space processes todo:261 retry:1
[ 2573.062016] Freeing user space processes todo:0 retry:2
[ 2573.062024] Freezing user space processes completed (elapsed 0.042=20
seconds)
[ 2573.067114] Freeing remaining freezable tasks todo:13 retry:0
[ 2573.072597] Freeing remaining freezable tasks todo:0 retry:1
[ 2573.072604] Freezing remaining freezable tasks completed (elapsed=20
0.010 seconds)
[ 2577.176003] Filesystems sync: 0.013 seconds
[ 2577.210773] Freeing user space processes todo:9042 retry:0
[ 2577.226116] Freeing user space processes todo:637 retry:1
[ 2577.233723] Freeing user space processes todo:0 retry:2
[ 2577.233733] Freezing user space processes completed (elapsed 0.057=20
seconds)
[ 2577.240897] Freeing remaining freezable tasks todo:13 retry:0
[ 2577.250898] Freeing remaining freezable tasks todo:0 retry:1
[ 2577.250928] Freezing remaining freezable tasks completed (elapsed=20
0.017 seconds)
[ 2581.358613] Filesystems sync: 0.014 seconds
[ 2581.397288] Freeing user space processes todo:10397 retry:0
[ 2581.415191] Freeing user space processes todo:107 retry:1
[ 2581.423085] Freeing user space processes todo:0 retry:2
[ 2581.423094] Freezing user space processes completed (elapsed 0.064=20
seconds)
[ 2581.431079] Freeing remaining freezable tasks todo:13 retry:0
[ 2581.441576] Freeing remaining freezable tasks todo:0 retry:1
[ 2581.441596] Freezing remaining freezable tasks completed (elapsed=20
0.018 seconds)
[ 2585.572128] Filesystems sync: 0.016 seconds
[ 2585.617543] Freeing user space processes todo:12330 retry:0
[ 2585.638997] Freeing user space processes todo:1227 retry:1
[ 2585.648592] Freeing user space processes todo:0 retry:2
[ 2585.648602] Freezing user space processes completed (elapsed 0.076=20
seconds)
[ 2585.658063] Freeing remaining freezable tasks todo:13 retry:0
[ 2585.670385] Freeing remaining freezable tasks todo:0 retry:1
[ 2585.670405] Freezing remaining freezable tasks completed (elapsed=20
0.021 seconds)
[ 2589.810371] Filesystems sync: 0.014 seconds
[ 2589.865483] Freeing user space processes todo:14036 retry:0
[ 2589.893513] Freeing user space processes todo:1288 retry:1
[ 2589.904032] Freeing user space processes todo:0 retry:2
[ 2589.904040] Freezing user space processes completed (elapsed 0.093=20
seconds)
[ 2589.914322] Freeing remaining freezable tasks todo:13 retry:0
[ 2589.925185] Freeing remaining freezable tasks todo:0 retry:1
[ 2589.925191] Freezing remaining freezable tasks completed (elapsed=20
0.021 seconds)
[ 2594.088171] Filesystems sync: 0.013 seconds
[ 2594.145012] Freeing user space processes todo:15947 retry:0
[ 2594.175153] Freeing user space processes todo:1521 retry:1
[ 2594.187060] Freeing user space processes todo:0 retry:2
[ 2594.187071] Freezing user space processes completed (elapsed 0.098=20
seconds)
[ 2594.199270] Freeing remaining freezable tasks todo:13 retry:0
[ 2594.215446] Freeing remaining freezable tasks todo:0 retry:1
[ 2594.215468] Freezing remaining freezable tasks completed (elapsed=20
0.028 seconds)

However, in the last suspend cycle, we do not execute the fork script=20
and the result is quite different:

[ 2678.840809] Filesystems sync: 0.010 seconds
[ 2678.928107] Freeing user space processes todo:16673 retry:0
[ 2678.950744] Freeing user space processes todo:0 retry:1
[ 2678.950759] Freezing user space processes completed (elapsed 0.109=20
seconds)
[ 2678.971389] Freeing remaining freezable tasks todo:13 retry:0
[ 2678.996021] Freeing remaining freezable tasks todo:0 retry:1
[ 2678.996043] Freezing remaining freezable tasks completed (elapsed=20
0.045 seconds)

(include the one with only 1 retry, e.g.:

[ 2678.928107] Freeing user space processes todo:16673 retry:0
[ 2678.950744] Freeing user space processes todo:0 retry:1

This pattern is repeatable: when fork is allowed during the=20
freeze/suspend window, we consistently hit multiple retries; when fork=20
is disabled during that time, the freeze proceeds quickly and smoothly=20
with just one retry.

This indicates that new user processes created after the freezing loop=20
begins are interfering with the suspend, which is consistent with a fork=20
escape scenario. Since the current code doesn=E2=80=99t prevent forks onc=
e=20
tasklist_lock is released, a new child process can be created and escape=20
freezing altogether =E2=80=94 leading to the need for retries and sometim=
es=20
suspend failure.

Hope this helps clarify the issue. Happy to provide further logs or=20
testing as needed.


