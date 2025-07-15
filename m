Return-Path: <linux-pm+bounces-30850-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C93B0518F
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 08:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3EC4A0DBB
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 06:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3C32D3737;
	Tue, 15 Jul 2025 06:12:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8FC1F4174;
	Tue, 15 Jul 2025 06:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752559973; cv=none; b=RkYSm7h9QyO1jRKew7ScGV2149nQmirbrTxYW9Uaq7dqeVD0BHNLJ4/Q6RZ2s44L4Mh9VmOYUxy5a4690fjPbx/EyNFNinGkspjwoQAISwBUxtgmEzy1MKcg9Q5llU9cxVDH27/rgdEgrtmcEOL57omNDZCzzfQAOdUVBi7nTys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752559973; c=relaxed/simple;
	bh=lcrAtDrkmQZMkOgqSbuOUUoZrgavyxpzniDoTjtYZqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bP5xIf3zi9Ubn++pwk7n+io/SJyf0jYHsMnsAXZfZ9xUxYwTGVTnILxmfEXY4so5xfySP6NNRfv4jtgMLD09gHpT2Xfy8GTK8y1ekL3GkGrDd9hsKqBrg6L7jaJWCdULzPzn7XhPzCtYie3ZSIu+hg30MZYpIovl9Ux4rR5m1j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b7a0f0d0614211f0b29709d653e92f7d-20250715
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:8d0c3b77-18bf-40a7-8298-7c2a2afb2341,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:06ec4b2274f8160b376601a593da985b,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b7a0f0d0614211f0b29709d653e92f7d-20250715
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1432813227; Tue, 15 Jul 2025 14:12:42 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 507FEE008FA3;
	Tue, 15 Jul 2025 14:12:42 +0800 (CST)
X-ns-mid: postfix-6875F15A-240232178
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 83726E008FA2;
	Tue, 15 Jul 2025 14:12:41 +0800 (CST)
Message-ID: <76a87abf-8fc9-445b-83d5-0daa33746014@kylinos.cn>
Date: Tue, 15 Jul 2025 14:12:40 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PM: suspend: clean up redundant
 filesystems_freeze/thaw handling
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250712030824.81474-1-zhangzihuan@kylinos.cn>
 <9d35035d-c63e-4d11-a403-54c50e8b35c1@kylinos.cn>
 <CAJZ5v0g22fMDc21yV2svePf_4BWZRrcy+b3-efpbfAGLpa2=Lw@mail.gmail.com>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <CAJZ5v0g22fMDc21yV2svePf_4BWZRrcy+b3-efpbfAGLpa2=Lw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

=E5=9C=A8 2025/7/15 01:57, Rafael J. Wysocki =E5=86=99=E9=81=93:
> Hi,
>
> On Mon, Jul 14, 2025 at 10:44=E2=80=AFAM Zihuan Zhang <zhangzihuan@kyli=
nos.cn> wrote:
>> Hi Rafael,
>>
>> Just a gentle ping on this patch.
> I've lost track of it for some reason, sorry.
>
>> I realized I forgot to mention an important motivation in the changelo=
g:
>> calling filesystems_freeze() twice (from both suspend_prepare() and
>> enter_state()) lead to a black screen and make the system unable to re=
sume..
>>
>> This patch avoids the duplicate call and resolves that issue.
> Now applied as a fix for 6.16-rc7, thank you!


Thanks for the reply!

Just a quick follow-up question =E2=80=94 we noticed that even when the =E2=
=80=9Cfreeze=20
filesystems=E2=80=9D feature is not enabled, the current code still calls=
=20
filesystems_thaw().

Do you think it would make sense to guard this with a static key (or=20
another mechanism) to avoid unnecessary overhead?



>> =E5=9C=A8 2025/7/12 11:08, Zihuan Zhang =E5=86=99=E9=81=93:
>>> The recently introduced support for freezing filesystems during syste=
m
>>> suspend included calls to filesystems_freeze() in both suspend_prepar=
e()
>>> and enter_state(), as well as calls to filesystems_thaw() in both
>>> suspend_finish() and the Unlock path in enter_state(). These are
>>> redundant.
>>>
>>> - filesystems_freeze() is already called in suspend_prepare(), which =
is
>>>     the proper and consistent place to handle pre-suspend operations.=
 The
>>> second call in enter_state() is unnecessary and removed.
>>>
>>> - filesystems_thaw() is invoked in suspend_finish(), which covers
>>>     successful suspend/resume paths. In the failure case , we add a c=
all
>>> to filesystems_thaw() only when needed, avoiding the duplicate call i=
n
>>> the general Unlock path.
>>>
>>> This change simplifies the suspend code and avoids repeated freeze/th=
aw
>>> calls, while preserving correct ordering and behavior.
>>>
>>> Fixes: eacfbf74196f91e4c26d9f8c78e1576c1225cd8c ("power: freeze files=
ystems during suspend/resume")
>>> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
>>> ---
>>>    kernel/power/suspend.c | 4 +---
>>>    1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
>>> index bb608b68fb30..8f3e4c48d5cd 100644
>>> --- a/kernel/power/suspend.c
>>> +++ b/kernel/power/suspend.c
>>> @@ -384,6 +384,7 @@ static int suspend_prepare(suspend_state_t state)
>>>                return 0;
>>>
>>>        dpm_save_failed_step(SUSPEND_FREEZE);
>>> +     filesystems_thaw();
>>>        pm_notifier_call_chain(PM_POST_SUSPEND);
>>>     Restore:
>>>        pm_restore_console();
>>> @@ -593,8 +594,6 @@ static int enter_state(suspend_state_t state)
>>>                ksys_sync_helper();
>>>                trace_suspend_resume(TPS("sync_filesystems"), 0, false=
);
>>>        }
>>> -     if (filesystem_freeze_enabled)
>>> -             filesystems_freeze();
>>>
>>>        pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_label=
s[state]);
>>>        pm_suspend_clear_flags();
>>> @@ -614,7 +613,6 @@ static int enter_state(suspend_state_t state)
>>>        pm_pr_dbg("Finishing wakeup.\n");
>>>        suspend_finish();
>>>     Unlock:
>>> -     filesystems_thaw();
>>>        mutex_unlock(&system_transition_mutex);
>>>        return error;
>>>    }
>> Thanks,
>> Zihuan Zhang
Best regards,
Zihuan Zhang

