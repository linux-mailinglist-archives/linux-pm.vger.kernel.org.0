Return-Path: <linux-pm+bounces-30965-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC039B08234
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 03:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797833AB688
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 01:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8227E0FF;
	Thu, 17 Jul 2025 01:16:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC0A70825;
	Thu, 17 Jul 2025 01:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752714999; cv=none; b=bh1FsGYrJnegWX5uNgAz/iSRcxnnxD8Rmmjhgax5SvG9t0Uj8r16b3+84Ifwz1ZYMIYF4vFdjdoBRoFH+EQuhbTukTK8iwsPfqEW6S0a6lTMhlk5rf3Jz3UFqKdDcOLhOeXRv5sDzPx2/qzhTvRNdh6Gd62U6kDhxBM007iVw7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752714999; c=relaxed/simple;
	bh=6GTPF95YSeIO+89mmJsH1xpq74nNUfpyTzJbkwuBMS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bX7z14Edqe2nxSS5zeLqDW8NOACD8tnYvU81m+7/6PBtE8zP9AT29mz1v2bTnyAFTyTcjeKenZ3mxbb0SriSrGeduz1ha61DyhMEyt+9LssRF01ZhtjKLWZJ73Nc3ZS3EznM5nwIJTRq86PxyP/s3xCmnCoENoQiYfK8FMxmkJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ab13c02662ab11f0b29709d653e92f7d-20250717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:81c48115-d847-4f16-82a7-c73dc92b8043,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:d087ae556a6abc581ee5bed688074b27,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ab13c02662ab11f0b29709d653e92f7d-20250717
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1967794073; Thu, 17 Jul 2025 09:16:29 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 7C2BBE008FA3;
	Thu, 17 Jul 2025 09:16:29 +0800 (CST)
X-ns-mid: postfix-68784EED-42262796
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id A9C51E008FA2;
	Thu, 17 Jul 2025 09:16:28 +0800 (CST)
Message-ID: <c6c7e8b5-430b-4616-b9e8-46500621bb84@kylinos.cn>
Date: Thu, 17 Jul 2025 09:16:27 +0800
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
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250716163854.GE16401@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

=E5=9C=A8 2025/7/17 00:38, Oleg Nesterov =E5=86=99=E9=81=93:
> On 07/16, Zihuan Zhang wrote:
>> @@ -51,7 +51,15 @@ static int try_to_freeze_tasks(bool user_only)
>>   		todo =3D 0;
>>   		read_lock(&tasklist_lock);
>>   		for_each_process_thread(g, p) {
>> -			if (p =3D=3D current || !freeze_task(p))
>> +			/*
>> +			 * Zombie and dead tasks are not running anymore and cannot enter
>> +			 * the __refrigerator(). Skipping them avoids unnecessary freeze a=
ttempts.
>> +			 *
>> +			 * TODO: Consider using PF_NOFREEZE instead, which may provide
>> +			 * a more generic exclusion mechanism for other non-freezable task=
s.
>> +			 * However, for now, exit_state is sufficient to skip user process=
es.
> I don't really understand the comment... The freeze_task() paths alread=
y
> consider PF_NOFREEZE, although we can check it earlier as Peter suggest=
s.


You=E2=80=99re right =E2=80=94 freeze_task() already takes PF_NOFREEZE in=
to account.
Our intention here is to skip zombie and dead tasks earlier to avoid=20
calling freeze_task() unnecessarily, especially when the number of such=20
tasks is large.

The comment is meant to highlight a possible future direction: while=20
exit_state already allows us to skip all exiting user-space tasks=20
safely, we may later extend the logic to skip certain kernel threads=20
that set PF_NOFREEZE and never clear it (e.g., kthreadd), as suggested=20
by Peter


>> +			 */
>> +			if (p =3D=3D current || p->exit_state || !freeze_task(p))
>>   				continue;
> I leave this to you and Rafael, but this change doesn't look safe to me=
.
> What if the exiting task does some IO after exit_notify() ?


Tasks that have passed exit_notify() and entered EXIT_ZOMBIE are no=20
longer schedulable, so they cannot do I/O anymore. Skipping them during=20
freezing should be safe


> Oleg.
>

