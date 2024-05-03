Return-Path: <linux-pm+bounces-7461-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAC18BA4EE
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2024 03:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7A31C21B9A
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2024 01:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2103C101F2;
	Fri,  3 May 2024 01:29:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD9E101EC
	for <linux-pm@vger.kernel.org>; Fri,  3 May 2024 01:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714699799; cv=none; b=YNYLGzby8qakMSr9N+YNIaPIp8Y57JBcff4p85oYgQ9+vwoF/msKkrt9RNQHWKaSNZ0DlVye4TiTkR4JhMIO5gIv2iTdnlkwUm/vgJdfswMsUWO1ePArD+9jr7ULws9fEsz0WHRhQA88K0MajUkqTVvIlktDUeWTtATqFhkWjJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714699799; c=relaxed/simple;
	bh=dMjeMlM25rxtnU3drusMB38fe3VxHwTgoP0hohfF/WI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j3k9ChbYTNW8zwc3Fc3BLT2jURn4Htka0KrAFsrlbJ4tA12xiuhTIjWVNw69WvoAwoZ7YCFPdQkUSKvfojYrouIiHWTNuznL0aLvRvv4w++4TqRWVm6GroeEv8Ci/9CIFDT0HJw0BgDRoEq1aizSeWINtmtbsQ1zKn5T77ywziQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9cf40c3608ec11ef9305a59a3cc225df-20240503
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:0f95b689-2641-4d0f-a1fb-650f2a262013,IP:30,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:21
X-CID-INFO: VERSION:1.1.37,REQID:0f95b689-2641-4d0f-a1fb-650f2a262013,IP:30,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:21
X-CID-META: VersionHash:6f543d0,CLOUDID:a72b91e9828466f48c0e588ae7ccaaa9,BulkI
	D:2404240053447092KH5R,BulkQuantity:5,Recheck:0,SF:19|44|64|66|38|24|72|10
	2,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: 9cf40c3608ec11ef9305a59a3cc225df-20240503
Received: from node4.com.cn [(39.156.73.12)] by mailgw.kylinos.cn
	(envelope-from <xiongxin@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1657420701; Fri, 03 May 2024 09:29:41 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id CAE8716002083;
	Fri,  3 May 2024 09:29:35 +0800 (CST)
X-ns-mid: postfix-66343DFF-7420412
Received: from [10.42.116.201] (unknown [10.42.116.201])
	by node4.com.cn (NSMail) with ESMTPA id 9A19A16002082;
	Fri,  3 May 2024 01:29:34 +0000 (UTC)
Message-ID: <4b077ec7-d9da-44fc-a083-1c27afff7e72@kylinos.cn>
Date: Fri, 3 May 2024 09:29:34 +0800
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

Please check the patch you submitted: cdb8c100d8a4=20
(include/linux/suspend.h: Only show pm_pr_dbg messages at=20
suspend/resume). The patch you submit and merge limits the scope of what=20
pm_pr_dbg() can output, that is, you modify the original capability of=20
pm_pr_dbg().

All I'm doing is trying to get pm_pr_dbg() back to its original output=20
capacity.This is not an innovative technique, so why consider adding a=20
variable to change the thinking of other developers who have already=20
mastered pm_pr_dbg()?

>=20
>>
>> The kernel already has a log output solution based on the value of=20
>> pm_suspend_target_state. I will issue a repair patch as follows in
>> amd_pmc_idlemask_read():
>>
>> if (dev && pm_suspend_target_state !=3D PM_SUSPEND_ON)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_info("SMU idlemask s0i3: 0x%x\n", val=
);

My previous suggestion was not considered reasonable, so I slightly=20
modified it as follows:

if (dev && pm_suspend_target_state !=3D PM_SUSPEND_ON)
	pm_pr_dbg(SMU idlemask s0i3: 0x%x\n", val)

This is still based on /sys/power/pm_debug_messages, but does not change=20
the original logic of pm_pr_dbg().

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




