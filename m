Return-Path: <linux-pm+bounces-7329-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB60F8B6D3F
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2024 10:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46D55B2247E
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2024 08:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E7B1272CA;
	Tue, 30 Apr 2024 08:45:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9CD2BB07
	for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2024 08:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466755; cv=none; b=JT8zF75XhaD156MPvOEkDMuLyevfHVfgjYGMt2WCD/r9YDJvEYE7A8xtEdvPB262mSSwxDEkaHjjXc5WqLYVmU2mfwycwPgGnAE7rkiNHl0tolLOX7qnYuazqUJL/2dtw5jlp0tlc58bPyrjMULMtsXxpJJDcFrVCmOHPrTFHQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466755; c=relaxed/simple;
	bh=U1N12e2eez6KIhLTd7ZZAXJL2S02MTAd803CWp1015s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nsA8dRtwNSBEHdtGaqUHmDbigkaMIWEiXVykH5AOKI9lAbN9YHEsPDynURV1ckAf7ehjfWhAQbKo08KBERFrHRkWIdTSySSXDQXk1O6MeYcJYUJVa14uGxc9O7EwFST6WZbjpOasqPK8giPn37BFGmFXygNdPwhJujCwnWdkVXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0400f92806ce11ef9305a59a3cc225df-20240430
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:d119256f-afbb-4ea5-9ac2-5e9dbe2af564,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:11
X-CID-INFO: VERSION:1.1.37,REQID:d119256f-afbb-4ea5-9ac2-5e9dbe2af564,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:11
X-CID-META: VersionHash:6f543d0,CLOUDID:cd981e8367cfef93562b65892a63a88e,BulkI
	D:2404240053447092KH5R,BulkQuantity:1,Recheck:0,SF:19|44|64|66|38|24|72|10
	2,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 0400f92806ce11ef9305a59a3cc225df-20240430
Received: from node4.com.cn [(39.156.73.12)] by mailgw.kylinos.cn
	(envelope-from <xiongxin@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 779165557; Tue, 30 Apr 2024 16:45:37 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id F0FD416002082;
	Tue, 30 Apr 2024 16:45:36 +0800 (CST)
X-ns-mid: postfix-6630AFB0-900721635
Received: from [10.42.116.201] (unknown [10.42.116.201])
	by node4.com.cn (NSMail) with ESMTPA id 98F7816002082;
	Tue, 30 Apr 2024 08:45:36 +0000 (UTC)
Message-ID: <408bbf09-58ef-4d55-ba89-a64dbce25085@kylinos.cn>
Date: Tue, 30 Apr 2024 16:45:35 +0800
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
Content-Language: en-US
From: xiongxin <xiongxin@kylinos.cn>
In-Reply-To: <2f07ea21-c89b-49dc-a7b6-8c4e207d1af7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2024/4/24 00:52, Mario Limonciello =E5=86=99=E9=81=93:
> On 4/23/2024 03:17, xiongxin wrote:
>> commit cdb8c100d8a4 ("include/linux/suspend.h: Only show pm_pr_dbg
>> messages at suspend/resume"), pm_debug_messages_should_print() is
>> implemented to determine the output of pm_pr_dbg(), using
>> pm_suspend_target_state to identify the suspend process. However, this
>> limits the output range of pm_pr_dbg().
>>
>> In the suspend process, pm_pr_dbg() is called before setting
>> pm_suspend_target_state. As a result, this part of the log cannot be
>> output.
>>
>> pm_pr_dbg() also outputs debug logs for hibernate, but
>> pm_suspend_target_state is not set, resulting in hibernate debug logs
>> can only be output through dynamic debug, which is very inconvenient.
>>
>> Currently, remove pm_suspend_target_state from
>> pm_debug_messages_should_print() to ensure that sleep and hibernate ma=
in
>> logic can output debug normally.
>>
>> Fixes: cdb8c100d8a4 ("include/linux/suspend.h: Only show pm_pr_dbg=20
>> messages at suspend/resume").
>> Signed-off-by: xiongxin <xiongxin@kylinos.cn>
>> ---
>> v2:
>> =C2=A0=C2=A0=C2=A0=C2=A0* Resolve the compilation error and re-submit =
with the fix
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 patch.
>> v1:
>> =C2=A0=C2=A0=C2=A0=C2=A0* Revert the commit cdb8c100d8a4 ("include/lin=
ux/suspend.h: Only
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 show pm_pr_dbg messages at suspend/resu=
me").
>> ---
>>
>> diff --git a/kernel/power/main.c b/kernel/power/main.c
>> index a9e0693aaf69..24693599c0bc 100644
>> --- a/kernel/power/main.c
>> +++ b/kernel/power/main.c
>> @@ -613,7 +613,7 @@ bool pm_debug_messages_on __read_mostly;
>> =C2=A0 =C2=A0 bool pm_debug_messages_should_print(void)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 return pm_debug_messages_on && pm_suspend_target_s=
tate !=3D=20
>> PM_SUSPEND_ON;
>> +=C2=A0=C2=A0=C2=A0 return pm_debug_messages_on;
>> =C2=A0 }
>> =C2=A0 EXPORT_SYMBOL_GPL(pm_debug_messages_should_print);
>
> Did you miss the proposal for fixing this for hibernate by adding the=20
> extra variable to monitor?

Can I change pm_pr_dbg() in amd_pmc_idlemask_read() to pr_debug() based o=
n

pm_debug_messages_on condition?

I suggest not adding a new variable to this.


