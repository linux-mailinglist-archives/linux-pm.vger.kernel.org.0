Return-Path: <linux-pm+bounces-30006-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2E9AF6902
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 06:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDEBD521D9E
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 04:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64747289819;
	Thu,  3 Jul 2025 04:06:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204BB27CCE7;
	Thu,  3 Jul 2025 04:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751515605; cv=none; b=jIlR3ASD9N8aJwi0fj8uGeD5SNa7REsygsMeWCqoEa/GDwA7hFcfXAfTOcEweAxr+O50i7H2HAGqT/vevS7vJi+qNTjStCPVxVqvqZZiUDaJ1yepumUk/HA74GO9OGBCCdYePcHAXMs6XzsLXNXWM2+XAUl+tYxByalUN3IomJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751515605; c=relaxed/simple;
	bh=iS0wN2Yp0X7jntgoyl3sfkNmwNrYwe5UFBjTK78uceg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FT8UzxdFxqoim2XPYb4gqId30gpn+c4qc0UH4yRTMfvwTrfOVfDrPsb2Z3xc7XNVjnSKAsOFfqy10ceELsi5bMxmeWdZy9/ytXQvMZsqbNVDeVnlTs6Epc4U58h0GHIuVAYAWid7OA3BIh3BnVJIamYC4TvX7UGdYizrbTd3y4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1c89bf4257c311f0b29709d653e92f7d-20250703
X-CID-CACHE: Type:Local,Time:202507031108+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:a8956ad4-1408-452a-aa1d-55176fd265e6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:b40b5519b5e8ef877da3e0894f364ad6,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1c89bf4257c311f0b29709d653e92f7d-20250703
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1294250978; Thu, 03 Jul 2025 12:06:35 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 89623E008FA2;
	Thu,  3 Jul 2025 12:06:35 +0800 (CST)
X-ns-mid: postfix-686601CB-4747671
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id E894AE008FA1;
	Thu,  3 Jul 2025 12:06:34 +0800 (CST)
Message-ID: <c1fd270f-624f-4a63-b54a-d2d98f06cb49@kylinos.cn>
Date: Thu, 3 Jul 2025 12:06:34 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] PM: suspend: Assign pm_suspend_target_state
 earlier for valid debug logs
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: pavel@kernel.org, len.brown@intel.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250619035355.33402-1-zhangzihuan@kylinos.cn>
 <20250619035355.33402-4-zhangzihuan@kylinos.cn>
 <CAJZ5v0hEzTfZZgrgyo4NNnXj+eFrAnJgmP9Ls7kB3GM3c1V2Mw@mail.gmail.com>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <CAJZ5v0hEzTfZZgrgyo4NNnXj+eFrAnJgmP9Ls7kB3GM3c1V2Mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi=C2=A0Rafael,

=E5=9C=A8 2025/7/3 02:58, Rafael J. Wysocki =E5=86=99=E9=81=93:=E3=80=80 =
=E3=80=80 =E3=80=80 =E3=80=80=E3=80=80 =E3=80=80 =E3=80=80 =E3=80=80 =E3=80=
=80 =E3=80=80 =E3=80=80 =E3=80=80=20
=E3=80=80 =E3=80=80 =E3=80=80=E3=80=80
>> On Thu, Jun 19, 2025 at 5:54=E2=80=AFAM Zihuan Zhang <zhangzihuan@kyli=
nos.cn> wrote:
>>
>> pm_suspend_target_state is used in debug logs inside enter_state(), bu=
t
>> it is only assigned inside suspend_devices_and_enter(), which is too l=
ate..
>>
>> This causes early pm_pr_dbg() output to either show incorrect state or
>> nothing at all, making suspend debugging harder.
>>
>> Assign pm_suspend_target_state at the beginning of enter_state() to en=
sure
>> early log output is meaningful.
>>
>> Signed-off-by: Zihuan Zhang
>>   ---
>> kernel/power/suspend.c | 3 +++
>> 1 file changed, 3 insertions(+)
>>
>> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
>> index 76b141b9aac0..16172ca22f21 100644
>> --- a/kernel/power/suspend.c
>> +++ b/kernel/power/suspend.c
>> @@ -584,6 +584,8 @@ static int enter_state(suspend_state_t state)
>> if (!mutex_trylock(&system_transition_mutex))
>> return -EBUSY;
>>
>> + pm_suspend_target_state =3D state;
>> +
>> if (state =3D=3D PM_SUSPEND_TO_IDLE)
>> s2idle_begin();
>>
>> @@ -616,6 +618,7 @@ static int enter_state(suspend_state_t state)
>> suspend_finish();
>> Unlock:
>> filesystems_thaw();
>> + pm_suspend_target_state =3D PM_SUSPEND_ON;
>> mutex_unlock(&system_transition_mutex);
>> return error;
>> }}
>>
>> --
>> =E3=80=80 =E3=80=80 =E3=80=80 =E3=80=80 =E3=80=80 =E3=80=80 =E3=80=80 =
=E3=80=80 =E3=80=80 =E3=80=80=E3=80=80=20
> Good catch, but you should remove the existing assignments at the
> same time. =E3=80=80
Thanks for your review and feedback.

You=E2=80=99re right that ideally pm_suspend_target_state should only be=20
assigned once in enter_state(), and I initially considered removing the=20
original assignment in suspend_devices_and_enter() as well.

However, I noticed that some drivers and subsystems may rely on the=20
value of pm_suspend_target_state later in the suspend path, not just for=20
logging but also for decision-making (e.g. conditional behavior based on=20
suspend state). Because of this, I was cautious about removing the=20
original assignment inside suspend_devices_and_enter() without verifying=20
all potential dependencies.

Would you consider it acceptable to keep both assignments for now =E2=80=94=
 one=20
early for logging purposes, and one later to ensure correctness and=20
compatibility =E2=80=94 or do you think it=E2=80=99s preferable to remove=
 the later one=20
and carefully audit all usage sites?

Happy to adjust accordingly based on your recommendation.

Best regards,
Zihuan Zhang


