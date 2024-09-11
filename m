Return-Path: <linux-pm+bounces-13979-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A31974860
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 04:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182A31C25969
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 02:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12A1161;
	Wed, 11 Sep 2024 02:55:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4B229CFB
	for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 02:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726023306; cv=none; b=BYLd4VFsojqFostbk9Ul5BlZfhIdRKknfA0jReilbv6HEk7UTlj02atySgUDE2zDNDUPjvRoxv95V1EBDiR2kDC99ojFfZw4yzdyGcr461SgnVHS1KHBODC7ENsiJxFCWyY8ETAQzVrg5xb0TLQ0CAXom8QqukCmhsK5mwt+jsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726023306; c=relaxed/simple;
	bh=2m+rfA9cd5zx7m0qi1SE3hKVTjfkNf+XhUl48O5h/iY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iF/iSqDZmCmLwtlUJRWHK+saMLyuFSh0Wj1JfQ8aMhbSxkxHKmG6WXPxQwSLpMvbN/uxNDciv5GGlKwMtP7sY2cRgqpa8iY2YqC+nvWxs25IBGTdR8IeKLK+GrypucXRZ3wchP5XfTB11+YUlG/wmzOASbvfvnYDN+abe7Xjzkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3adce9b46fe911efa216b1d71e6e1362-20240911
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:7c54451c-d553-42a5-bbec-2ec26d9b85c2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:03bebc893093e6be7ccae2d7dfe2d623,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1|-5,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3adce9b46fe911efa216b1d71e6e1362-20240911
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <xiongxin@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1653146205; Wed, 11 Sep 2024 10:54:57 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id DC78D16002082;
	Wed, 11 Sep 2024 10:54:56 +0800 (CST)
X-ns-mid: postfix-66E10680-816975631
Received: from [10.42.12.201] (unknown [10.42.12.201])
	by node4.com.cn (NSMail) with ESMTPA id BFC1816002082;
	Wed, 11 Sep 2024 02:54:55 +0000 (UTC)
Message-ID: <8c03f407-646a-40dd-a8c6-deeb663b2032@kylinos.cn>
Date: Wed, 11 Sep 2024 10:54:55 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PM: sleep: Optimize the
 pm_debug_messages_should_print() condition
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: mario.limonciello@amd.com, len.brown@intel.com, pavel@ucw.cz,
 linux-pm@vger.kernel.org
References: <20240909080726.16811-1-xiongxin@kylinos.cn>
 <CAJZ5v0iJ+cTj1OOZZ7iGEgzEtovk5VAOkw8C5E8VPPyp=WUasg@mail.gmail.com>
Content-Language: en-US
From: XiongXin <xiongxin@kylinos.cn>
In-Reply-To: <CAJZ5v0iJ+cTj1OOZZ7iGEgzEtovk5VAOkw8C5E8VPPyp=WUasg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

=E5=9C=A8 2024/9/11 02:08, Rafael J. Wysocki =E5=86=99=E9=81=93:
> On Mon, Sep 9, 2024 at 10:07=E2=80=AFAM Xiong Xin <xiongxin@kylinos.cn>=
 wrote:
>>
>> From: xiongxin <xiongxin@kylinos.cn>
>>
>> pm_pr_dbg() is useful when debugging suspend and hibernate processes. =
In
>> commit cdb8c100d8a4 ("include/linux/suspend.h: Only show pm_pr_dbg
>> messages at suspend/resume") using pm_suspend_target_state to limits t=
he
>> output range of pm_pr_dbg(), causes the original pm_pr_dbg() output
>> range to change.
>>
>> In the suspend process, pm_pr_dbg() is called before setting
>> pm_suspend_target_state. As a result, this part of the log cannot be
>> output.
>>
>> pm_pr_dbg() also outputs debug logs for hibernate, but
>> pm_suspend_target_state is not set, resulting in hibernate debug logs
>> can only be output through dynamic debug, which is very inconvenient.
>>
>> Expand the scope of the state variable in state_store() and add judgme=
nt
>> on it in pm_debug_messages_should_print() to extend the debugging outp=
ut
>> of pm_pr_dbg() to suspend and hibernate processes.
>>
>> Fixes: cdb8c100d8a4 ("include/linux/suspend.h: Only show pm_pr_dbg mes=
sages at suspend/resume").
>> Signed-off-by: xiongxin <xiongxin@kylinos.cn>
>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   kernel/power/main.c | 21 +++++++++++++--------
>>   1 file changed, 13 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/power/main.c b/kernel/power/main.c
>> index a9e0693aaf69..a376107efbb4 100644
>> --- a/kernel/power/main.c
>> +++ b/kernel/power/main.c
>> @@ -559,6 +559,8 @@ late_initcall(pm_debugfs_init);
>>
>>   #endif /* CONFIG_PM_SLEEP */
>>
>> +static suspend_state_t pm_state =3D PM_SUSPEND_ON;
>> +
>>   #ifdef CONFIG_PM_SLEEP_DEBUG
>>   /*
>>    * pm_print_times: print time taken by devices to suspend and resume=
.
>> @@ -613,7 +615,9 @@ bool pm_debug_messages_on __read_mostly;
>>
>>   bool pm_debug_messages_should_print(void)
>>   {
>> -       return pm_debug_messages_on && pm_suspend_target_state !=3D PM=
_SUSPEND_ON;
>> +       return pm_debug_messages_on &&
>> +              (pm_suspend_target_state !=3D PM_SUSPEND_ON ||
>> +               pm_state !=3D PM_SUSPEND_ON);
>>   }
>>   EXPORT_SYMBOL_GPL(pm_debug_messages_should_print);
>>
>> @@ -715,7 +719,6 @@ static suspend_state_t decode_state(const char *bu=
f, size_t n)
>>   static ssize_t state_store(struct kobject *kobj, struct kobj_attribu=
te *attr,
>>                             const char *buf, size_t n)
>>   {
>> -       suspend_state_t state;
>>          int error;
>>
>>          error =3D pm_autosleep_lock();
>> @@ -727,18 +730,20 @@ static ssize_t state_store(struct kobject *kobj,=
 struct kobj_attribute *attr,
>>                  goto out;
>>          }
>>
>> -       state =3D decode_state(buf, n);
>> -       if (state < PM_SUSPEND_MAX) {
>> -               if (state =3D=3D PM_SUSPEND_MEM)
>> -                       state =3D mem_sleep_current;
>> +       pm_state =3D decode_state(buf, n);
>> +       if (pm_state < PM_SUSPEND_MAX) {
>> +               if (pm_state =3D=3D PM_SUSPEND_MEM)
>> +                       pm_state =3D mem_sleep_current;
>>
>> -               error =3D pm_suspend(state);
>> -       } else if (state =3D=3D PM_SUSPEND_MAX) {
>> +               error =3D pm_suspend(pm_state);
>> +       } else if (pm_state =3D=3D PM_SUSPEND_MAX) {
>>                  error =3D hibernate();
>>          } else {
>>                  error =3D -EINVAL;
>>          }
>>
>> +       pm_state =3D PM_SUSPEND_ON;
>> +
>>    out:
>>          pm_autosleep_unlock();
>>          return error ? error : n;
>> --
>=20
> This would only work for transitions started via /sys/power/state
> AFAICS, but there are other ways to start them (eg. autosleep).

Yes, the current patch does not yet control the resume process in=20
kernel/power/hibernate.c

As suggested earlier, to define a global variable, such as bool=20
is_pm_process, to determin whether in the suspend, hibernate, resume=20
process?

