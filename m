Return-Path: <linux-pm+bounces-9291-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA5F90A679
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 09:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94E961F2448A
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 07:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FAD1862B4;
	Mon, 17 Jun 2024 07:05:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E5B69D31
	for <linux-pm@vger.kernel.org>; Mon, 17 Jun 2024 07:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718607925; cv=none; b=uv43biYIF6SZ1qs98lZbDs0vq/VlkSiCpjrtCwQnpVgbWD0/pjV40stuCeLrlTy+en7oKa/o1cUpRdrumsIu5qZfyc03BqYOc2kAjaI5h1jSJ/qypBZWe75ueJ55AFMTkLOBPr/0PUPXTLTL6yGM+MS0h8zP8J4e/b6byh+6iV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718607925; c=relaxed/simple;
	bh=V68FWbPBGLT2wuq2J9n6nHZkUz98CobWvg0eAsq/r5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rs7YHZRqVQGiT313uyjH/yTW2qOpOirlVa4zMvNUkdZ289LxPGaBWgexOceUlLwkkc4idY5xTP96P5sV2+mPGhK/9/yoVvHq4E43YOjQ+ActdlqczxRJD+/aP1TV1uTOIAeLHpBC1wA+hyuLTgfK12hl1zK1MTvggWFDzPGQHoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 74ce1d662c7611ef9305a59a3cc225df-20240617
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:82bfb657-58ea-4380-94f6-48b397b72933,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:5
X-CID-INFO: VERSION:1.1.38,REQID:82bfb657-58ea-4380-94f6-48b397b72933,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-META: VersionHash:82c5f88,CLOUDID:317974d0b8ac6e5d771e1385d7407c4e,BulkI
	D:240617145436OFKZLWQO,BulkQuantity:0,Recheck:0,SF:24|17|19|44|64|66|38|10
	2,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 74ce1d662c7611ef9305a59a3cc225df-20240617
Received: from node4.com.cn [(39.156.73.12)] by mailgw.kylinos.cn
	(envelope-from <xiongxin@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1010945154; Mon, 17 Jun 2024 14:54:34 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 7676C16002082;
	Mon, 17 Jun 2024 14:54:34 +0800 (CST)
X-ns-mid: postfix-666FDDAA-401713378
Received: from [10.42.116.201] (unknown [10.42.116.201])
	by node4.com.cn (NSMail) with ESMTPA id 14A3316002082;
	Mon, 17 Jun 2024 06:54:33 +0000 (UTC)
Message-ID: <d30cb05e-63cb-4ad4-ae2a-4359e89d48e1@kylinos.cn>
Date: Mon, 17 Jun 2024 14:54:33 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: sleep: Optimize the pm_debug_messages_should_print()
 function
To: Mario Limonciello <mario.limonciello@amd.com>, rafael@kernel.org
Cc: linux-pm@vger.kernel.org
References: <20240422093619.118278-1-xiongxin@kylinos.cn>
 <20240423081723.412237-1-xiongxin@kylinos.cn>
 <2f07ea21-c89b-49dc-a7b6-8c4e207d1af7@amd.com>
 <408bbf09-58ef-4d55-ba89-a64dbce25085@kylinos.cn>
 <2b4930ea-c8c9-4743-aa46-f387056f2a1f@amd.com>
 <e30df16c-1af1-4d66-97cc-c0e6620764a6@kylinos.cn>
 <1714698149088349.0.seg@mailgw.kylinos.cn>
Content-Language: en-US
From: xiongxin <xiongxin@kylinos.cn>
In-Reply-To: <1714698149088349.0.seg@mailgw.kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2024/5/3 03:04, Mario Limonciello wrote:
>=20
>>>> Can I change pm_pr_dbg() in amd_pmc_idlemask_read() to pr_debug()=20
>>>> based on
>>>>
>>>> pm_debug_messages_on condition?
>>>>
>>>> I suggest not adding a new variable to this.
>>>>
>>>
>>> I don't understand the opposition to the new variable.
>>>
>>> The whole point of /sys/power/pm_debug_messages is so that it's a one=
=20
>>> stop shop to turn on power management related debugging at power=20
>>> state but nothing more.
>>>
>>> You turn that on and you can get messages from the core and also any=20
>>> drivers that want to emit messages during that time.
>>>
>>> If changing drivers back to pr_debug that means that users and=20
>>> software need to manually turn on BOTH /sys/power/pm_debug_messages=20
>>> as well as dynamic debug for any power management related messages.
>>>
>>> Whereas if just adding another variable for a condition then just=20
>>> turn on the sysfs file for any hibernate or suspend debugging.
>>
>> Your patch makes the output of pm_pr_dbg() based on the values of=20
>> pm_debug_messages_on and pm_suspend_target_state; However,=20
>> pm_suspend_target_state's impact domain does not include enter_state()=
=20
>> and hibernate processes;
>>
>> The patch affects the output of the sleep mainline debug log, which is=
=20
>> very unfriendly to others developers, and it is even more troublesome
>> to add a new variable based on your suggestion.
>=20
> Why is adding a new variable more troublesome?=C2=A0 We're talking abou=
t a=20
> one line change and then it can run in more power management situations=
.
>=20
>>
>> The kernel already has a log output solution based on the value of=20
>> pm_suspend_target_state. I will issue a repair patch as follows in
>> amd_pmc_idlemask_read():
>>
>> if (dev && pm_suspend_target_state !=3D PM_SUSPEND_ON)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_info("SMU idlemask s0i3: 0x%x\n", val=
);
>=20
> But then this is going to be really noisy still for the general purpose=
=20
> users.
>=20
> The point of pm_pr_dbg() is that it only outputs the debugging message=20
> when /sys/power/pm_debug_messages is set.
>=20
> 99% of people don't need this message, but when someone comes to say "i=
t=20
> doesn't work!" changing one sysfs file gets me a lot more data about=20
> /why/ it doesn't work without compromising everyone else's logs.

Hi Rafael.

Can pm_suspend_target_state be extended to the state_store() function?=20
Change the value of the variable as soon as suspend or hibernate=20
processes begin. For the invoke process in kernel/power/user.c, ensure=20
that pm_suspend_target_state is set before invoking=20
suspend_devices_and_enter().

However, many drivers do some operations based on the=20
pm_suspend_target_state variable, and it is not clear whether expanding=20
the scope of the variable will cause other exceptions.

Or re-implement a local variable based on state_store() and judge the=20
variable in pm_debug_messages_should_print(), so that pm_pr_dbg() can be=20
called directly by other drivers. And only suspend or hibernate=20
processes print logs.



