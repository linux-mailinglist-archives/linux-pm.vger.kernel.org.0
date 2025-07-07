Return-Path: <linux-pm+bounces-30239-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E64CAFA8BB
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 03:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F1CA1898F00
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 01:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9633633993;
	Mon,  7 Jul 2025 01:05:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859281BC3F;
	Mon,  7 Jul 2025 01:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751850334; cv=none; b=aaSCf3XVbWKXwiexetOJBeSk99tB12rr5kVQwLzrsy+WVLOJmUcYLzXwT3NsXNRJ18shs/uPZ7/DdROJW0dOdkTtfGXYBkfbvrDBcvAa4/1Ae9NloIsT+PlEmimXQFQgxOusMVAqUWmu+MaxNYVrCpfCDXjnA1YO2aMxbGEE9AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751850334; c=relaxed/simple;
	bh=lFtl0/KhCyGQtSvdjpdRV3oo3TI3vyWSr89jtNIGjYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TX0Wy23Za2DOjiGOVqYpuIdH5uaGscpeJc+e0JvkKGX4p+frSzpX3QC/8oGrEInuZLqBCDUojYjvWeFLPSkXdzIdM7iRFz4RxKFwE4kg5+rRDieA83lVQebN8KpYHMGU0UDdFjD/7XhItEClTLf9iplJ19RUOkpnUHg/tOqL3Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: bd5d76905acd11f0b29709d653e92f7d-20250707
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:b540f768-9daa-4551-9621-e99882fbf9a8,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6493067,CLOUDID:721bd41f0dd6331f36630ea02494de61,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102,TC:nil,Content:0|52,EDM:-3,
	IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: bd5d76905acd11f0b29709d653e92f7d-20250707
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 80701485; Mon, 07 Jul 2025 09:00:14 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id CCCECE008FA2;
	Mon,  7 Jul 2025 09:00:13 +0800 (CST)
X-ns-mid: postfix-686B1C1D-73792946
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id AF560E008FAA;
	Mon,  7 Jul 2025 09:00:12 +0800 (CST)
Message-ID: <de7e327a-202c-4b28-b372-2d648c680dbe@kylinos.cn>
Date: Mon, 7 Jul 2025 09:00:12 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] PM / Freezer: Skip zombie/dead processes to
To: Peter Zijlstra <peterz@infradead.org>
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
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250704092144.GH2001818@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/7/4 17:21, Peter Zijlstra =E5=86=99=E9=81=93:
> You're missing the obvious. How about we 'fix' the PF_NOFREEZE handling
> and help all cases that set that and not only zombies?=E3=80=80=E3=80=80=
=E3=80=80 =E3=80=80 =E3=80=80 =E3=80=80=E3=80=80 =E3=80=80 =E3=80=80 =E3=80=
=80 =E3=80=80 =E3=80=80 =E3=80=80 =E3=80=80 =E3=80=80 =E3=80=80 =E3=80=80=
=E3=80=80

It sounds like a good idea, but there=E2=80=99s a potential risk in relyi=
ng=20
solely on PF_NOFREEZE: it=E2=80=99s a mutable flag that can be set or cle=
ared=20
dynamically during runtime, even within the freeze window.
If a task changes its PF_NOFREEZE state after passing the early check in=20
try_to_freeze_task(), we might skip freezing it incorrectly, leading to=20
inconsistent behavior or unexpected task escapes. This is particularly=20
tricky for some kernel threads or exit paths where PF_NOFREEZE is=20
manipulated as part of cleanup or teardown.
In contrast, checking exit_state for EXIT_ZOMBIE or EXIT_DEAD is fully=20
stable and irreversible =E2=80=94 once a task becomes a zombie, it's no l=
onger=20
schedulable and doesn=E2=80=99t require freezing. That makes the conditio=
n both=20
safe and predictable, without risk of races or missed transitions.
Currently, the safest way to skip tasks based on PF_NOFREEZE would be:
*if (!(p->flags & PF_KTHREAD) && (p->flags & PF_NOFREEZE))*
to avoid skipping kernel threads that may dynamically toggle this flag.=20
But this increases code complexity compared to simply checking
*if (p->exit_state)*

which is more straightforward.
Importantly, exit_state is set earlier and more reliably than PF_NOFREEZE=
,
So while improving PF_NOFREEZE handling is a worthwhile direction (and=20
I=E2=80=99d be happy to explore that in a separate patch RFC=20
[1]<https://lore.kernel.org/all/20250624115244.19260-1-zhangzihuan@kylino=
s.cn/>),=20
this small patch keeps the logic minimal and avoids subtle corner cases.=20
It also reduces unnecessary locking for zombie tasks, which can help=20
when there are lots of them around.
[1]:=20
https://lore.kernel.org/all/20250624115244.19260-1-zhangzihuan@kylinos.cn=
/
Thanks again for your insightful feedback =E2=80=94 much appreciated.

Best regards,
Zihuan Zhang


