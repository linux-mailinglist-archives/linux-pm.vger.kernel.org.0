Return-Path: <linux-pm+bounces-30110-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0E9AF8DCA
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 11:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B77CEB64F7F
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 08:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E6928C02E;
	Fri,  4 Jul 2025 08:48:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00462882A9;
	Fri,  4 Jul 2025 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751618911; cv=none; b=fIab01SvuOQWibI5KcPP4ZXfKgvlWr2AmjGUz52gJ9CWl/I4bT9AHWWxB2g2QMFEN0LkpEuqaW071UDtz3Wkro4Amq9nVww1fi4gMk9Rgie3TboHuLF/zbNSsqXO96Liu+CaPIhhgcg8nEo42+Xk24EZQA6dXVT+yr6tJ2K0Mws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751618911; c=relaxed/simple;
	bh=9c1/n9u5apM1Vt0+8SET65XN0ovmups73fCT2CzcPOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aNH/XXsGWjdjcAFDQaOtbArdSMYiq+H0sBgVwyQ61QITSpMLgqFj3NOUV7yzmvMXYH/yEX6MVX3Iqkos4NVvoCZfJpW7bkizxlhaSwUPUiXr4FTdFURtq2coJtf5B1O25Jw2Xm7Ty0eddcMlQTaePSQF3+6cbY0xM/lWKuNKFv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a436fb0858b311f0b29709d653e92f7d-20250704
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:339b74d9-8120-4eeb-b0e5-f7c48230ba07,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:0dbd8aee02da0d227be7b481bf494ec9,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a436fb0858b311f0b29709d653e92f7d-20250704
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1311471061; Fri, 04 Jul 2025 16:48:22 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 5BAC2E008FA3;
	Fri,  4 Jul 2025 16:48:22 +0800 (CST)
X-ns-mid: postfix-68679556-278304758
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 4A653E008FA1;
	Fri,  4 Jul 2025 16:48:21 +0800 (CST)
Message-ID: <67997bdd-d00a-413a-a565-188c4b06f385@kylinos.cn>
Date: Fri, 4 Jul 2025 16:48:20 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] PM / Freezer: Skip zombie/dead processes to
To: Peter Zijlstra <peterz@infradead.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: pavel@kernel.org, len.brown@intel.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
References: <20250611101247.15522-1-zhangzihuan@kylinos.cn>
 <20250611101247.15522-2-zhangzihuan@kylinos.cn>
 <CAJZ5v0jpuUVM73M=Gzq36je=K_7zEkvVd8bxohi6N5OYgxgUug@mail.gmail.com>
 <20250703164021.GY1613200@noisy.programming.kicks-ass.net>
 <CAJZ5v0j29Nu2nitmj6tPhOQYuSaHBtXQVR21ikDtrxpejPdW8A@mail.gmail.com>
 <20250704081941.GC2001818@noisy.programming.kicks-ass.net>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250704081941.GC2001818@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Peter,

Thanks for the feedback.

=E5=9C=A8 2025/7/4 16:19, Peter Zijlstra =E5=86=99=E9=81=93:
> =E3=80=80=E3=80=80=E3=80=80 =E3=80=80 =E3=80=80 =E3=80=80=E3=80=80 =E3=80=
=80 =E3=80=80 =E3=80=80 =E3=80=80 =E3=80=80 =E3=80=80 =E3=80=80 =E3=80=80=
 =E3=80=80 =E3=80=80=E3=80=80
> Depending on where they wait (I can't seem to find in a hurry) it might
> make sense to make that wait FREEZABLE anyway.
>
> For example, AFAICT it wouldn't hurt, and might even help some, to make
> kernel/exit.c:do_wait() TASK_FREEZABLE.
>
> So where do ZOMBIEs sleep? Don't they simply pass through do_task_dead(=
)
> and never get scheduled again? Notably, do_task_dead() already marks th=
e
> tasks as PF_NOFREEZE.
>
> Anyway, yes, the condition it adds is relatively simple, but I really
> don't see why we should complicate things *at*all*.

You=E2=80=99re absolutely right =E2=80=94 zombie processes won=E2=80=99t =
be frozen in practice,=20
since PF_NOFREEZE is already set in do_task_dead(). However, if we don=E2=
=80=99t=20
explicitly skip them early in try_to_freeze_task(), they still go=20
through the freezer logic path, including calls like freeze_task() =E2=86=
=92=20
freezing() before eventually returning without freezing.

This not only introduces unnecessary code path traversal, but also=20
involves locking (e.g., spin_lock_irqsave/restore()), which could be=20
avoided altogether if we bail out earlier.

Additionally, skipping zombies directly helps reduce the list traversal=20
overhead in freeze_processes(), especially on systems with a large=20
number of tasks, where zombies can account for a non-trivial fraction.

So while the practical effect might be small, the gain is low-risk and=20
helps streamline the freezer logic a bit more.

