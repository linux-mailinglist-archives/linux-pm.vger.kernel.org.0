Return-Path: <linux-pm+bounces-38739-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C2DC8B605
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 19:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7613B2BE2
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 18:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57236306486;
	Wed, 26 Nov 2025 18:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="NzjIMmTO"
X-Original-To: linux-pm@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A2E2777FC;
	Wed, 26 Nov 2025 18:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764180407; cv=none; b=IiVcWVgFMTDuNsLJesYFilY1oXsr1VXY5LlOGV3w8F96kYkKTxjZmqMCE9liP+dZRGZx1bGCSp5KUtOmHiD34oiVI4ckXnOeA6HrTG5r8m98wkC1D9sICw4rsS/dCr0KrABpXGU9euML+bstclWGftq2TJEhxXRAljlXv+uv+bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764180407; c=relaxed/simple;
	bh=qiAEPo6bUlTbnEwSxlQZOcEid+NdlVZAsk/GSoGNkoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FMEIKBV0eZL3C3QIpRgVAi25Mtr3Fs4WMV7TJ02lDIkDEZDSYd92GS0WgRWnSzvC2Sn05Il8zrUUFV4oENL2iTuuXpeTgzhCEmf1NllX8tm2k7kBxl7yqda2R6JSDm9QVwwYRWulB/MXWFX7eQcsz0dF9ye8pIYKNrtSPWUWmGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=NzjIMmTO; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4dGnZD2zBTzlgqjZ;
	Wed, 26 Nov 2025 18:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1764180402; x=1766772403; bh=aVK2hHm1cgb3RtYqbaZmKtmo
	Yt+aEzoWqlX5VZ43Uss=; b=NzjIMmTOQ6LPu75TeB4gL0+GxukzAIW1TdslrDLb
	taf74Hr3tMzXAmYxJk07Pg6bsGTKt1E4EVJcH3BLiC235y46u2E6zTrNJGkZmGTT
	/1vgMtqFhizLkXDTfuBkVG0Ra2NmZq0SF7wMlhHfE8cKYEa+S6eax/7pofnhWXMI
	nMP5/vxc8nGXuJBlpApj863hdoLy2tp5LOcO2Vi9pXel7sotZ7Rn9tw5yQYdp6cE
	vvJE2FS5Rlw0NNl36Go9Ycd79sy4YFz3JpC3qle+p36L5PCH8Hu913uD6noyMHTA
	ZXXaUgxSaVUYY9YJBR3g/BTXsnFuisxT4Zh9oPsrYxjwFg==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id tQqhY0iQRbrZ; Wed, 26 Nov 2025 18:06:42 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4dGnYz44MgzlgqjW;
	Wed, 26 Nov 2025 18:06:30 +0000 (UTC)
Message-ID: <6373a999-f19a-450c-9e83-7448fb70a772@acm.org>
Date: Wed, 26 Nov 2025 10:06:29 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PM: runtime: Fix I/O hang due to race between resume
 and runtime disable
To: "Rafael J. Wysocki" <rafael@kernel.org>, Yang Yang <yang.yang@vivo.com>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20251126101636.205505-1-yang.yang@vivo.com>
 <20251126101636.205505-2-yang.yang@vivo.com>
 <CAJZ5v0i1YLiri9oiiq2W6_KSbqGuWOqdrMPrOf=do-DdW=_rfA@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAJZ5v0i1YLiri9oiiq2W6_KSbqGuWOqdrMPrOf=do-DdW=_rfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 11/26/25 3:30 AM, Rafael J. Wysocki wrote:
> On Wed, Nov 26, 2025 at 11:17=E2=80=AFAM Yang Yang <yang.yang@vivo.com>=
 wrote:
>>   T1:                                   T2:
>>   blk_queue_enter
>>   blk_pm_resume_queue
>>   pm_request_resume
>=20
> Shouldn't this be pm_runtime_resume() rather?

I tried to make that change on an Android device. As a result, the
kernel complaint shown below appeared. My understanding is that sleeping
in atomic context can trigger a deadlock and hence is not allowed.

[   13.728890][    T1] WARNING: CPU: 6 PID: 1 at=20
kernel/sched/core.c:9714 __might_sleep+0x78/0x84
[   13.758800][    T1] Call trace:
[   13.759027][    T1]  __might_sleep+0x78/0x84
[   13.759340][    T1]  __pm_runtime_resume+0x40/0xb8
[   13.759781][    T1]  __bio_queue_enter+0xc0/0x1cc
[   13.760153][    T1]  blk_mq_submit_bio+0x884/0xadc
[   13.760548][    T1]  __submit_bio+0x2c8/0x49c
[   13.760879][    T1]  __submit_bio_noacct_mq+0x38/0x88
[   13.761242][    T1]  submit_bio_noacct_nocheck+0x4fc/0x7b8
[   13.761631][    T1]  submit_bio+0x214/0x4c0
[   13.761941][    T1]  mpage_readahead+0x1b8/0x1fc
[   13.762284][    T1]  blkdev_readahead+0x18/0x28
[   13.762660][    T1]  page_cache_ra_unbounded+0x310/0x4d8
[   13.763072][    T1]  page_cache_ra_order+0xc0/0x5b0
[   13.763434][    T1]  page_cache_sync_ra+0x17c/0x268
[   13.763782][    T1]  filemap_read+0x4c4/0x12f4
[   13.764125][    T1]  blkdev_read_iter+0x100/0x164
[   13.764475][    T1]  vfs_read+0x188/0x348
[   13.764789][    T1]  __se_sys_pread64+0x84/0xc8
[   13.765180][    T1]  __arm64_sys_pread64+0x1c/0x2c
[   13.765556][    T1]  invoke_syscall+0x58/0xf0
[   13.765876][    T1]  do_el0_svc+0x8c/0xe0
[   13.766172][    T1]  el0_svc+0x50/0xd4
[   13.766583][    T1]  el0t_64_sync_handler+0x20/0xf4
[   13.766932][    T1]  el0t_64_sync+0x1bc/0x1c0
[   13.767294][    T1] irq event stamp: 2589614
[   13.767592][    T1] hardirqs last  enabled at (2589613):=20
[<ffffffc0800eaf24>] finish_lock_switch+0x70/0x108
[   13.768283][    T1] hardirqs last disabled at (2589614):=20
[<ffffffc0814b66f4>] el1_dbg+0x24/0x80
[   13.768875][    T1] softirqs last  enabled at (2589370):=20
[<ffffffc080082a7c>] ____do_softirq+0x10/0x20
[   13.769529][    T1] softirqs last disabled at (2589349):=20
[<ffffffc080082a7c>] ____do_softirq+0x10/0x20

I think that the filemap_invalidate_lock_shared() call in
page_cache_ra_unbounded() forbids sleeping in submit_bio().

Thanks,

Bart.


