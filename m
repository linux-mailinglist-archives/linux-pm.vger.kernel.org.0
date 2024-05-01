Return-Path: <linux-pm+bounces-7414-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2068B8516
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2024 06:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EBA01C21ECE
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2024 04:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B22E39AF9;
	Wed,  1 May 2024 04:45:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898062F875
	for <linux-pm@vger.kernel.org>; Wed,  1 May 2024 04:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714538736; cv=none; b=nbB92akXjxwiLpwvZMzDNH0YoN0W5aoEEdmBRyGaEQZrPx3CryR8OjlLFdXGzbOoy6ujdNG8+KsPBRgiU2lH/pmg9cd1GyX/EtCDdv25tCd+qVcpWGM15OdCajh583/BiNG4OsVPvdI6J3IycAtbTtb3WXzPi0Qw9f5KmyFKKog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714538736; c=relaxed/simple;
	bh=ADAvOlLhHB0HyabmgwZEd82BlyvYDGfuL/onf36CyJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPz1PY6Z+5KwG7rYUiwnkn33AVrcnz3As2TmyIdCfVwpa8GDil1QxHT+Uvr9k387epS4RNxRB0uPz6qkptzcfpD/162/YcQMpJLZtmmssY0flA3hvYyqTq//wMg9+5htPHo/gX8bbmBHufjWEXG25ZVHkeL79ukebvTqqHWgBmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9e825c7e077511ef9305a59a3cc225df-20240501
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:06a82fc0-3bb7-4576-ab58-e580f4a81e90,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:11
X-CID-INFO: VERSION:1.1.37,REQID:06a82fc0-3bb7-4576-ab58-e580f4a81e90,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:11
X-CID-META: VersionHash:6f543d0,CLOUDID:483e714d1da3f52ff7b755eeebdac560,BulkI
	D:2404240053447092KH5R,BulkQuantity:3,Recheck:0,SF:64|66|38|24|72|19|44|10
	2,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 9e825c7e077511ef9305a59a3cc225df-20240501
Received: from node4.com.cn [(39.156.73.12)] by mailgw.kylinos.cn
	(envelope-from <xiongxin@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 33441322; Wed, 01 May 2024 12:45:22 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id D829A16002082;
	Wed,  1 May 2024 12:45:11 +0800 (CST)
X-ns-mid: postfix-6631C8D7-7214731
Received: from [10.42.116.201] (unknown [10.42.116.201])
	by node4.com.cn (NSMail) with ESMTPA id 585CF16002082;
	Wed,  1 May 2024 04:45:11 +0000 (UTC)
Message-ID: <e30df16c-1af1-4d66-97cc-c0e6620764a6@kylinos.cn>
Date: Wed, 1 May 2024 12:45:10 +0800
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
Content-Language: en-US
From: xiongxin <xiongxin@kylinos.cn>
In-Reply-To: <2b4930ea-c8c9-4743-aa46-f387056f2a1f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable



=E5=9C=A8 2024/4/30 22:36, Mario Limonciello =E5=86=99=E9=81=93:
> On 4/30/2024 03:45, xiongxin wrote:
>>
>> =E5=9C=A8 2024/4/24 00:52, Mario Limonciello =E5=86=99=E9=81=93:
>>> On 4/23/2024 03:17, xiongxin wrote:
>>>> commit cdb8c100d8a4 ("include/linux/suspend.h: Only show pm_pr_dbg
>>>> messages at suspend/resume"), pm_debug_messages_should_print() is
>>>> implemented to determine the output of pm_pr_dbg(), using
>>>> pm_suspend_target_state to identify the suspend process. However, th=
is
>>>> limits the output range of pm_pr_dbg().
>>>>
>>>> In the suspend process, pm_pr_dbg() is called before setting
>>>> pm_suspend_target_state. As a result, this part of the log cannot be
>>>> output.
>>>>
>>>> pm_pr_dbg() also outputs debug logs for hibernate, but
>>>> pm_suspend_target_state is not set, resulting in hibernate debug log=
s
>>>> can only be output through dynamic debug, which is very inconvenient=
.
>>>>
>>>> Currently, remove pm_suspend_target_state from
>>>> pm_debug_messages_should_print() to ensure that sleep and hibernate=20
>>>> main
>>>> logic can output debug normally.
>>>>
>>>> Fixes: cdb8c100d8a4 ("include/linux/suspend.h: Only show pm_pr_dbg=20
>>>> messages at suspend/resume").
>>>> Signed-off-by: xiongxin <xiongxin@kylinos.cn>
>>>> ---
>>>> v2:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0* Resolve the compilation error and re-submi=
t with the fix
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 patch.
>>>> v1:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0* Revert the commit cdb8c100d8a4 ("include/l=
inux/suspend.h: Only
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 show pm_pr_dbg messages at suspend/re=
sume").
>>>> ---
>>>>
>>>> diff --git a/kernel/power/main.c b/kernel/power/main.c
>>>> index a9e0693aaf69..24693599c0bc 100644
>>>> --- a/kernel/power/main.c
>>>> +++ b/kernel/power/main.c
>>>> @@ -613,7 +613,7 @@ bool pm_debug_messages_on __read_mostly;
>>>> =C2=A0 =C2=A0 bool pm_debug_messages_should_print(void)
>>>> =C2=A0 {
>>>> -=C2=A0=C2=A0=C2=A0 return pm_debug_messages_on && pm_suspend_target=
_state !=3D=20
>>>> PM_SUSPEND_ON;
>>>> +=C2=A0=C2=A0=C2=A0 return pm_debug_messages_on;
>>>> =C2=A0 }
>>>> =C2=A0 EXPORT_SYMBOL_GPL(pm_debug_messages_should_print);
>>>
>>> Did you miss the proposal for fixing this for hibernate by adding the=
=20
>>> extra variable to monitor?
>>
>> Can I change pm_pr_dbg() in amd_pmc_idlemask_read() to pr_debug()=20
>> based on
>>
>> pm_debug_messages_on condition?
>>
>> I suggest not adding a new variable to this.
>>
>=20
> I don't understand the opposition to the new variable.
>=20
> The whole point of /sys/power/pm_debug_messages is so that it's a one=20
> stop shop to turn on power management related debugging at power state=20
> but nothing more.
>=20
> You turn that on and you can get messages from the core and also any=20
> drivers that want to emit messages during that time.
>=20
> If changing drivers back to pr_debug that means that users and software=
=20
> need to manually turn on BOTH /sys/power/pm_debug_messages as well as=20
> dynamic debug for any power management related messages.
>=20
> Whereas if just adding another variable for a condition then just turn=20
> on the sysfs file for any hibernate or suspend debugging.

Your patch makes the output of pm_pr_dbg() based on the values of=20
pm_debug_messages_on and pm_suspend_target_state; However,=20
pm_suspend_target_state's impact domain does not include enter_state()=20
and hibernate processes;

The patch affects the output of the sleep mainline debug log, which is=20
very unfriendly to others developers, and it is even more troublesome
to add a new variable based on your suggestion.

The kernel already has a log output solution based on the value of=20
pm_suspend_target_state. I will issue a repair patch as follows in
amd_pmc_idlemask_read():

if (dev && pm_suspend_target_state !=3D PM_SUSPEND_ON)
	pr_info("SMU idlemask s0i3: 0x%x\n", val);

