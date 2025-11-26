Return-Path: <linux-pm+bounces-38756-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF64C8C402
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 23:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B04C24E024F
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 22:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7702D73BC;
	Wed, 26 Nov 2025 22:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="1tsNxD1K"
X-Original-To: linux-pm@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D4C188713;
	Wed, 26 Nov 2025 22:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764197238; cv=none; b=WX2/10ziwnKH1PUBTcKzyCpFW09w5wfsY5D36Wjvl9wGOrJRDbk6rKSc3yM6hyvjSBzesmcQfqJ66X+f636mt5P9Qj2T8lkazsR6V+e4+acGJBcqNcj05ZGo8dvBWUnZPMJcg+rC3qvU+nz7J6N8HeYZV0WI1irYRthubt2kb6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764197238; c=relaxed/simple;
	bh=l9m56dnY9zEKhVS6I5N8OD52DaGq3RpUKZC/EnB4wag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fvxr0wIzaGg0iGma8kt0tCtiDDOzuiWry/p7HnGSQ2LVuugzwlFxgMxNvL3l/Bpl7oVDgjOE9qSgUQydvQGrk6l0KFZ16IjihyTVP4wTFNYcTbeNlmn8CIHT858ahcRS2vHBxJENfqcSJuOH8escC9dR/bpOCpdaFP9XzQbDBeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=1tsNxD1K; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4dGvnv3jcyzlgqjf;
	Wed, 26 Nov 2025 22:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1764197233; x=1766789234; bh=Mp/cEDtWWtAcdcao4aqwN7nq
	8Or7ohIFJ9e1ToUKxPE=; b=1tsNxD1K6fkcY/dCnnG1RhLd4G9RDcYBxuVs6bGJ
	Z7UpJRB5F5eCIc9Ac4dOlVLhuMyVr5v6408tbulPbyX3+0PfYzQTPWQKVNoizdye
	C+aCsbCD1K5VMU68VG5/nuvt3iSxlqmdzQzWV03a4kVrS0ddPu1wbmnYuARZvs26
	fMpD3NHYSoA+y2uHLEZAzxN7xjFMFv3xpSVQQpdaKtGNE0FhmWYs9+z55Xo3FbBC
	cPBvyEFCrIw2V59Bd171SsvEyaIhONdmb4m8IEPVxAB9M+2QRC0cwito9kgoFQUu
	uDvJdYLhPGI6SGFWi7em5nRO75eib7ZxrtiPtamwxlwS+w==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id B6KlyphCrugl; Wed, 26 Nov 2025 22:47:13 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4dGvnh3PHSzlgqjY;
	Wed, 26 Nov 2025 22:47:03 +0000 (UTC)
Message-ID: <1e7583e8-9ae9-4641-8ec2-7c62a637c9fc@acm.org>
Date: Wed, 26 Nov 2025 14:47:01 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PM: runtime: Fix I/O hang due to race between resume
 and runtime disable
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Yang Yang <yang.yang@vivo.com>, Jens Axboe <axboe@kernel.dk>,
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20251126101636.205505-1-yang.yang@vivo.com>
 <CAJZ5v0jiLAgHCQ51cYqUX-xjir7ooAC3xKH9wMbwrebOEuxFdw@mail.gmail.com>
 <CAJZ5v0hKpGbwFmxcH8qe=DPf_5GX=LD=Fqj3dgOApUoE1RmJAQ@mail.gmail.com>
 <4697314.LvFx2qVVIh@rafael.j.wysocki>
 <dc4dba4f-8334-40ea-8c53-6e8d135f1d41@acm.org>
 <CAJZ5v0jV-80kfk-AY70b5pQtyXxUtU_ACBVP_TeTAnaY0Up8Lw@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAJZ5v0jV-80kfk-AY70b5pQtyXxUtU_ACBVP_TeTAnaY0Up8Lw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 11/26/25 1:30 PM, Rafael J. Wysocki wrote:
> On Wed, Nov 26, 2025 at 10:11=E2=80=AFPM Bart Van Assche <bvanassche@ac=
m.org> wrote:
>>
>> On 11/26/25 12:17 PM, Rafael J. Wysocki wrote:
>>> --- a/block/blk-core.c
>>> +++ b/block/blk-core.c
>>> @@ -309,6 +309,8 @@ int blk_queue_enter(struct request_queue
>>>                if (flags & BLK_MQ_REQ_NOWAIT)
>>>                        return -EAGAIN;
>>>
>>> +             /* if necessary, resume .dev (assume success). */
>>> +             blk_pm_resume_queue(pm, q);
>>>                /*
>>>                 * read pair of barrier in blk_freeze_queue_start(), w=
e need to
>>>                 * order reading __PERCPU_REF_DEAD flag of .q_usage_co=
unter and
>>
>> blk_queue_enter() may be called from the suspend path so I don't think
>> that the above change will work.
>=20
> Why would the existing code work then?

The existing code works reliably on a very large number of devices.
Maybe there is a misunderstanding? RQF_PM / BLK_MQ_REQ_PM are set for
requests that should be processed even if the power status is changing
(RPM_SUSPENDING or RPM_RESUMING). The meaning of the 'pm' variable is
as follows: process this request even if a power state change is
ongoing.
> Are you suggesting that q->rpm_status should still be checked before
> calling pm_runtime_resume() or do you mean something else?
The purpose of the code changes from a previous email is not entirely
clear to me so I'm not sure what the code should look like. But to
answer your question, calling blk_pm_resume_queue() if the runtime
status is RPM_SUSPENDED should be safe.
>> As an example, the UFS driver submits a
>> SCSI START STOP UNIT command from its runtime suspend callback. The ca=
ll
>> chain is as follows:
>>
>>     ufshcd_wl_runtime_suspend()
>>       __ufshcd_wl_suspend()
>>         ufshcd_set_dev_pwr_mode()
>>           ufshcd_execute_start_stop()
>>             scsi_execute_cmd()
>>               scsi_alloc_request()
>>                 blk_queue_enter()
>>               blk_execute_rq()
>>               blk_mq_free_request()
>>                 blk_queue_exit()
>=20
> In any case, calling pm_request_resume() from blk_pm_resume_queue() in
> the !pm case is a mistake.
  Hmm ... we may disagree about this. Does what I wrote above make clear
why blk_pm_resume_queue() is called if pm =3D=3D false?

Thanks,

Bart.

