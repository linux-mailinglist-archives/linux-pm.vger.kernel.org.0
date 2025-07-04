Return-Path: <linux-pm+bounces-30093-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F00CAF84D8
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 02:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1874F1C84792
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 00:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79B9A41;
	Fri,  4 Jul 2025 00:32:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBCE1C69D;
	Fri,  4 Jul 2025 00:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751589162; cv=none; b=kWGeFJmxzfmfoSs1j5txswo7LO9B+EJkl4ietanuhRL2wdHuY4rosYSGmz6Q4ezMO5QAWJ7re3zSuUTt8Yg9mMqT35E7TzopDZN+TvzaaDWGT08eL3tdHIzZOvd6qj5NGgw6ndtLIsxj+Loau83JdWR48jEqKiA9rU4bl+rrt1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751589162; c=relaxed/simple;
	bh=mjIzuotTM/8lBNByhteeckK3OwujC5Ea0Ks3S8vbkNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GCyZzj9iDztO0Tu0ut03L8wi8fZU2474FrbNLC4ekKfKbqOQdmyEGrdJgIIcyositATjZXfnhvUIrvwUtwaoT2eUx2e/WhyUUZE/cXgRT3fbZ7cRcfy25Iifd0aZISDJvIuY1tRX3JOsU7u+CYG3PeMktYXHhzdbn7oBaIvEAUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5d4b141c586e11f0b29709d653e92f7d-20250704
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:4718b050-5990-461f-b8ad-001a4427a038,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:dae3abbb9f43f0162ff80f784db52a8a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5d4b141c586e11f0b29709d653e92f7d-20250704
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1444936576; Fri, 04 Jul 2025 08:32:28 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 21A8CE008FA2;
	Fri,  4 Jul 2025 08:32:28 +0800 (CST)
X-ns-mid: postfix-6867211C-200648
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 5F5B2E008FA1;
	Fri,  4 Jul 2025 08:32:27 +0800 (CST)
Message-ID: <146a072b-53fd-474c-923a-9f5574c55aac@kylinos.cn>
Date: Fri, 4 Jul 2025 08:32:26 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] PM: freezer: Add retry count statistics for freeze
 pass iterations
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: pavel@kernel.org, len.brown@intel.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250619035355.33402-1-zhangzihuan@kylinos.cn>
 <20250619035355.33402-2-zhangzihuan@kylinos.cn>
 <CAJZ5v0gLVTe0a8mTRhiDa_4NuFsYw8gPZF9dnLrZzFh3yt424Q@mail.gmail.com>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <CAJZ5v0gLVTe0a8mTRhiDa_4NuFsYw8gPZF9dnLrZzFh3yt424Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Rafael,
Thanks for the feedback.

=E5=9C=A8 2025/7/3 22:38, Rafael J. Wysocki =E5=86=99=E9=81=93:
> On Thu, Jun 19, 2025 at 5:54=E2=80=AFAM Zihuan Zhang <zhangzihuan@kylin=
os.cn> wrote:
>> Freezer retry loops during suspend are often triggered by tasks enteri=
ng
>> D-state (TASK_UNINTERRUPTIBLE), which cannot be frozen.  This patch ad=
ds
>> a simple retry counter to freeze_processes() to help quantify how many
>> attempts were required before all tasks entered the frozen state. This
>> is useful for performance tuning and debugging unpredictable suspend
>> delays.
>>
>> A new dmesg log is added for visibility:
>>
>> freeze round: xx, tasks to freeze: xx
>>
>> This message allows users to correlate freeze instability with system
>> state.
>>
>> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
>> ---
>>   kernel/power/process.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/kernel/power/process.c b/kernel/power/process.c
>> index dc0dfc349f22..87616ca710ac 100644
>> --- a/kernel/power/process.c
>> +++ b/kernel/power/process.c
>> @@ -32,6 +32,7 @@ static int try_to_freeze_tasks(bool user_only)
>>          struct task_struct *g, *p;
>>          unsigned long end_time;
>>          unsigned int todo;
>> +       unsigned int retry =3D 0;
>>          bool wq_busy =3D false;
>>          ktime_t start, end, elapsed;
>>          unsigned int elapsed_msecs;
>> @@ -63,6 +64,8 @@ static int try_to_freeze_tasks(bool user_only)
>>                          todo +=3D wq_busy;
>>                  }
>>
>> +               pm_pr_dbg("freeze round: %d, task to freeze: %d\n", re=
try, todo);
>> +
> This is kind of fine if it is really needed, but it needs to have a
> separate on/off switch as far as I'm concerned.
>
> Maybe use pr_debug() for it in which case it would be controlled via
> dynamic debug?
I agree with your suggestion =E2=80=94 I=E2=80=99ll switch to pr_debug() =
in the next=20
version so that the message can be controlled via dynamic debug.
>>                  if (!todo || time_after(jiffies, end_time))
>>                          break;
>>
>> @@ -79,6 +82,7 @@ static int try_to_freeze_tasks(bool user_only)
>>                  usleep_range(sleep_usecs / 2, sleep_usecs);
>>                  if (sleep_usecs < 8 * USEC_PER_MSEC)
>>                          sleep_usecs *=3D 2;
>> +               retry++;
>>          }
>>
>>          end =3D ktime_get_boottime();
>> --
>> 2.25.1
>>
Best regards,
Zihuan Zhang

