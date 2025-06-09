Return-Path: <linux-pm+bounces-28295-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C7CAD1797
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 06:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF23C16717B
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 04:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D72D192B75;
	Mon,  9 Jun 2025 04:05:30 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221D622339;
	Mon,  9 Jun 2025 04:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749441930; cv=none; b=HVjdQLWdG4p7DH0o2rn4ZtUc2z8+kNSulqnm1B49VKNpuSPoUODXtkOy/d/bs8XxxwGMkNyJaSUcDuA1WQAELiHMUWau/55uXoCjQeaSzDxnz0Uv8jiwVOOwpkhDUPM3yzBiqnuQ/Q3Vk/8uxWPa9pZ82vX04IdLShX9gYPNK00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749441930; c=relaxed/simple;
	bh=SR1lkzbZ7sW0vxs7n8MlXWnQR+u4npJ+xZrJWtOep24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cCFMf1b608KVcuyvNfrINL178a5Rma9sd25JLxbdNT8WdVbeflfq2SNWWknkkMRSCcDvXRjMAXdH+hk7HJbNb8KX9Jnvkrt3MzpfoEV7b/OxP/71p/VJaEW3ZmK3xtswbri62DBzjGASYOuX+T0TXOh0G2mcHBvVmx9jEb/s7QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f4f5d3d844e611f0b29709d653e92f7d-20250609
X-CID-CACHE: Type:Local,Time:202506091146+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:e53a8877-982c-42b4-b057-1024c2ff2634,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:9e483725f417c604585cbed8794d6973,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f4f5d3d844e611f0b29709d653e92f7d-20250609
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1579250139; Mon, 09 Jun 2025 12:05:19 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id B998BE00891C;
	Mon,  9 Jun 2025 12:05:18 +0800 (CST)
X-ns-mid: postfix-68465D7E-5632772
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 94065E008900;
	Mon,  9 Jun 2025 12:05:15 +0800 (CST)
Message-ID: <83513599-e007-4d07-ac28-386bc5c7552d@kylinos.cn>
Date: Mon, 9 Jun 2025 12:05:14 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] PM: Optionally block user fork during freeze to
 improve performance
To: Peter Zijlstra <peterz@infradead.org>
Cc: rafael@kernel.org, len.brown@intel.com, pavel@kernel.org,
 kees@kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20250606062502.19607-1-zhangzihuan@kylinos.cn>
 <20250606082244.GL30486@noisy.programming.kicks-ass.net>
From: zhangzihuan <zhangzihuan@kylinos.cn>
In-Reply-To: <20250606082244.GL30486@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Peter,
Thanks a lot for the feedback!

=E5=9C=A8 2025/6/6 16:22, Peter Zijlstra =E5=86=99=E9=81=93:
> This isn't blocking fork(), this is failing fork(). Huge difference.
> Also problematic, because -EBUSY is not a recognised return value of
> fork(). As such, no existing software will adequately handle it.
> =C2=A0I completely agree there's a significant difference between faili=
ng=20
> and blocking fork().
The intent was to prevent late-created user tasks from interfering with=20
the freezing process, but you're right: returning -EBUSY is not valid=20
for fork(), and existing user-space programs wouldn't expect or handle=20
that properly.
As a next step, I'm considering switching to a blocking mechanism=20
instead =E2=80=94 that is, have user fork() temporarily sleep if it's att=
empted=20
during the freeze window. That should avoid breaking user-space=20
expectations while still helping maintain freeze stability.
Would that be more acceptable?
Thanks again for the insight,
Zihuan Zhang

