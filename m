Return-Path: <linux-pm+bounces-30094-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83813AF8506
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 02:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 015441C86CBD
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 00:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83361E89C;
	Fri,  4 Jul 2025 00:49:51 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3059101FF;
	Fri,  4 Jul 2025 00:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751590191; cv=none; b=DjVvrVFWnheR4AjHRJgDEJyV2efwnL4PTHEBxX4tuLym5Y/qAQ0mHsSgjzvWpBJLsl8nJwK2R4HNW4zJRaz+TFPG57Uqqx+OWsOJpaL3k61sqv+tlPWh/1Mh1ieRymJrwsyIETaUoYeDVwNZpmLI50DC+EttczfaERxpADxRxa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751590191; c=relaxed/simple;
	bh=5F907ZyFEux2K1To8HaYnR98NR61E4isDCST+c/aslE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gb8nBLv78gx/oDVHkZODVs/Zh70mqeCHxi8G/frWKyFx2a+RBrDYrCVSmKt8E67BJUeY6hyuqwtWyaGTnS6iN3d4FCZV7I50afIZ9DoJ5vNJfCByu9mBSJ4fkYPNQ9U/rwelXb2jC0xYW46agZAQGIOHfRW7qff4SJ8TKeMJnh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c5460f3e587011f0b29709d653e92f7d-20250704
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:af34f8ec-cead-4cff-8f15-48635f4ddbbb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:ff0f69d7ae8fb705f0c75159692fc8d1,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c5460f3e587011f0b29709d653e92f7d-20250704
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1353150857; Fri, 04 Jul 2025 08:49:41 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 919F3E008FA2;
	Fri,  4 Jul 2025 08:49:41 +0800 (CST)
X-ns-mid: postfix-68672525-50253432
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id D3C93E008FA1;
	Fri,  4 Jul 2025 08:49:40 +0800 (CST)
Message-ID: <7f6b7ea9-8fb5-466c-b92b-fe2c20e64b0b@kylinos.cn>
Date: Fri, 4 Jul 2025 08:49:40 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] PM: freezer: Print tasks stuck in D-state during
 freeze
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: pavel@kernel.org, len.brown@intel.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250619035355.33402-1-zhangzihuan@kylinos.cn>
 <20250619035355.33402-3-zhangzihuan@kylinos.cn>
 <CAJZ5v0hyBg3mVhfERkTLUnARLrsGarvtKOnL=RrL9VGF5DNLsg@mail.gmail.com>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <CAJZ5v0hyBg3mVhfERkTLUnARLrsGarvtKOnL=RrL9VGF5DNLsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

=E5=9C=A8 2025/7/3 22:40, Rafael J. Wysocki =E5=86=99=E9=81=93:
> On Thu, Jun 19, 2025 at 5:54=E2=80=AFAM Zihuan Zhang <zhangzihuan@kylin=
os.cn> wrote:
>> To help diagnose freezing delays caused by tasks stuck in D-state, thi=
s
>> patch adds logging for tasks that are stuck in D-state during each ret=
ry
>> of the freezer loop.  Such tasks are not killable and cannot be frozen=
,
>> which can cause the system suspend process to retry many times
>> before aborting.  This message can help developers identify which
>> user-space or kernel tasks are blocking the freeze process.
>>
>> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
>> ---
>>   kernel/power/process.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/kernel/power/process.c b/kernel/power/process.c
>> index 87616ca710ac..4007f621c2ad 100644
>> --- a/kernel/power/process.c
>> +++ b/kernel/power/process.c
>> @@ -55,6 +55,9 @@ static int try_to_freeze_tasks(bool user_only)
>>                          if (p =3D=3D current || !freeze_task(p))
>>                                  continue;
>>
>> +                       if (retry > 1 && READ_ONCE(p->__state) =3D=3D =
TASK_UNINTERRUPTIBLE)
>> +                               sched_show_task(p);
>> +
> This is going to be too noisy IMV.  Any chance to rate limit it somehow=
?
Thanks for pointing this out.

To avoid excessive verbosity, I=E2=80=99ll make the D-state task logging=20
conditional on pm_debug_messages_on() being true. Additionally, I=E2=80=99=
ll=20
limit the logging to only occur during retry rounds 1=E2=80=94 that shoul=
d be=20
enough to catch problematic tasks early without spamming the logs in=20
prolonged freeze attempts.

+                       if (pm_debug_messages_on && retry =3D=3D 1 && REA=
D_ONCE(p->__state) =3D=3D TASK_UNINTERRUPTIBLE)
+                               sched_show_task(p);
+


>>                          todo++;
>>                  }
>>                  read_unlock(&tasklist_lock);
>> --
>> 2.25.1
>>
Best regards,
Zihuan Zhang

