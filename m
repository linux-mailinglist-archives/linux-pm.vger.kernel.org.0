Return-Path: <linux-pm+bounces-30966-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A35B08266
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 03:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E469D1A62B09
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 01:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4DF202962;
	Thu, 17 Jul 2025 01:30:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245B07262E;
	Thu, 17 Jul 2025 01:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752715814; cv=none; b=pRbs6AIhdSxp9iyKeb+jTdGnihcheQ0MEFvDGeXb+xKFBI1WxPloNMbPr27pacegWOqdbKLNDbZ87yxH5//Jf+9hm+v84Jmzl/dTcOHAcqZHXPNGuRnf5KYlGr7bM6u2l9JlBz/IB8GoT5+8mJzSk1c/es6V0zdeWPFYEmsZcaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752715814; c=relaxed/simple;
	bh=MzB9I9m0y64oygB/YRbBxNxm7UiNoDJM/qPYCpCGl18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kVoA2mIstrSo1hVX7OpDrvTu9+vfFvQi3xsB3cykNKGRgOn12Ui7Z8smPgmfZ0NHwB3PKLOr/8YbHEIMWqLqAJD+dMR+ZdgWcD92Wo0jitWmyL1c4TfY7RVNqZV66fPLNNhxCkb6Nx+QYaOF7NsaQYUbGZ7O0Oz9HvSFr1a3Rhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 927c4a8662ad11f0b29709d653e92f7d-20250717
X-CID-CACHE: Type:Local,Time:202507170916+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:52c9ec4a-4064-46cc-b51b-c3b329803b42,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:d087ae556a6abc581ee5bed688074b27,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 927c4a8662ad11f0b29709d653e92f7d-20250717
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1160356816; Thu, 17 Jul 2025 09:30:07 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 9EF96E008FA4;
	Thu, 17 Jul 2025 09:30:05 +0800 (CST)
X-ns-mid: postfix-6878521C-194085130
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 9D683E008FA3;
	Thu, 17 Jul 2025 09:30:03 +0800 (CST)
Message-ID: <f5985910-d175-4c51-90b6-9d087a59936b@kylinos.cn>
Date: Thu, 17 Jul 2025 09:30:02 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] PM / Freezer: Skip zombie/dead processes to reduce
 freeze latency
To: Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>
Cc: "rafael J . wysocki" <rafael@kernel.org>, len brown
 <len.brown@intel.com>, pavel machek <pavel@kernel.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250716062639.1528066-1-zhangzihuan@kylinos.cn>
 <20250716062639.1528066-2-zhangzihuan@kylinos.cn>
 <20250716163854.GE16401@redhat.com>
 <20250716183637.GJ4105545@noisy.programming.kicks-ass.net>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250716183637.GJ4105545@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Peter,

=E5=9C=A8 2025/7/17 02:36, Peter Zijlstra =E5=86=99=E9=81=93:
> On Wed, Jul 16, 2025 at 06:38:55PM +0200, Oleg Nesterov wrote:
>> On 07/16, Zihuan Zhang wrote:
>>> @@ -51,7 +51,15 @@ static int try_to_freeze_tasks(bool user_only)
>>>   		todo =3D 0;
>>>   		read_lock(&tasklist_lock);
>>>   		for_each_process_thread(g, p) {
>>> -			if (p =3D=3D current || !freeze_task(p))
>>> +			/*
>>> +			 * Zombie and dead tasks are not running anymore and cannot enter
>>> +			 * the __refrigerator(). Skipping them avoids unnecessary freeze =
attempts.
>>> +			 *
>>> +			 * TODO: Consider using PF_NOFREEZE instead, which may provide
>>> +			 * a more generic exclusion mechanism for other non-freezable tas=
ks.
>>> +			 * However, for now, exit_state is sufficient to skip user proces=
ses.
>> I don't really understand the comment... The freeze_task() paths alrea=
dy
>> consider PF_NOFREEZE, although we can check it earlier as Peter sugges=
ts.
> Right; I really don't understand why we should special case
> ->exit_state. Why not DTRT and optimize NOFREEZE if all this really
> matters (smalls gains from what ISTR from the previous discussion).

The main reason we didn=E2=80=99t rely directly on PF_NOFREEZE is that it=
=E2=80=99s a=20
mutable flag =E2=80=94 in some cases, it can be cleared later, which make=
s early=20
skipping potentially unsafe.

In contrast, exit_state is stable and skipping tasks based on it is safe.


Also, the previous version of the patch you shared might allow some=20
paths to bypass lock_system_sleep(), which could break the intended=20
protection.

