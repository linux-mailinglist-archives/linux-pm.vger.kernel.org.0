Return-Path: <linux-pm+bounces-30007-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F30AF695C
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 07:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E0F47A406F
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 05:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB09428DEF0;
	Thu,  3 Jul 2025 05:14:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20452AE99;
	Thu,  3 Jul 2025 05:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751519684; cv=none; b=S5bMwvyjgVySSSyHebj4m7/X51YyLcNrt+shqp8k1frO4noMgckLwoSDsBU28r7VoBmh0F4wOpSsGKo3+9VQha3Vm4q587eAqXhGqVtgxFsCLj2FS1S8VPt23GERuCRRMFDQvTGF8N38TkT8S2g08Xw1gF8qNptn8u9q8WJnc8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751519684; c=relaxed/simple;
	bh=Bj0TUjVVYrkGFkiDXHNzZs9oAAjx/5DoN5FUsmoPB0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T+hV3lOUYZ0fGFQv3hxNSDzrSzVW1yktfvLKopPqncKGly8xCD7YkqdJTru97JyUCo5GtTmOdXO/Clf/2mMo/1d3Nv7LPkax1TN+QTijBeuy19PYECbwMgJ+zknmRkh4VNTktkuUXqBMBU9dfLhuDarH1y78iBsBuOO9KjI8HQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9b57f74057cc11f0b29709d653e92f7d-20250703
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:ba98264a-1ba8-4481-a040-005e572265bf,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:40c293299c91643a264805fa5bb4a241,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9b57f74057cc11f0b29709d653e92f7d-20250703
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1366317938; Thu, 03 Jul 2025 13:14:33 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id C68DFE008FA2;
	Thu,  3 Jul 2025 13:14:33 +0800 (CST)
X-ns-mid: postfix-686611B8-5402731
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 716CDE008FA1;
	Thu,  3 Jul 2025 13:14:31 +0800 (CST)
Message-ID: <9d7f88da-d8eb-4c2b-9380-30b6a0a46076@kylinos.cn>
Date: Thu, 3 Jul 2025 13:14:30 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PM: hibernate: Avoid redundant resume_device
 assignment in resume_store()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: pavel@kernel.org, len.brown@intel.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250530100036.11954-1-zhangzihuan@kylinos.cn>
 <CAJZ5v0h1xAx7HRRgH_7=D8U71j3yU1qji_5vYyt0ym+Hnrne6g@mail.gmail.com>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <CAJZ5v0h1xAx7HRRgH_7=D8U71j3yU1qji_5vYyt0ym+Hnrne6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

=E5=9C=A8 2025/7/3 02:51, Rafael J. Wysocki =E5=86=99=E9=81=93:
> On Fri, May 30, 2025 at 12:00=E2=80=AFPM Zihuan Zhang <zhangzihuan@kyli=
nos.cn> wrote:
>> In resume_store(), if the device number written to /sys/power/resume
>> is the same as the current swsusp_resume_device, we can skip reassignm=
ent.
>> This avoids unnecessary locking and improves efficiency slightly.
>>
>> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
>> ---
>>   kernel/power/hibernate.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
>> index 519fb09de5e0..504a1c2465ce 100644
>> --- a/kernel/power/hibernate.c
>> +++ b/kernel/power/hibernate.c
>> @@ -1291,6 +1291,9 @@ static ssize_t resume_store(struct kobject *kobj=
, struct kobj_attribute *attr,
>>          if (error)
>>                  return error;
>>
>> +       if (dev =3D=3D swsusp_resume_device)
>> +               return n;
>> +
> The main purpose of this function is to run software_resume(), not to
> set swsusp_resume_device.  You're breaking it with this change.
Thank you for the feedback.

You=E2=80=99re absolutely right =E2=80=94 I misunderstood the primary rol=
e of=20
resume_store() as being only to update swsusp_resume_device, and I=20
overlooked that its main purpose is to trigger software_resume().

I=E2=80=99ll drop this patch accordingly. Thanks again for pointing this =
out.

>>          sleep_flags =3D lock_system_sleep();
>>          swsusp_resume_device =3D dev;
>>          unlock_system_sleep(sleep_flags);
>> --
>> 2.25.1
>>
Best regards,
Zihuan Zhang

