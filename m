Return-Path: <linux-pm+bounces-39025-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A1EC99AA8
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 01:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4841E342C4F
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 00:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352FB1684B0;
	Tue,  2 Dec 2025 00:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="i1Aqst7k"
X-Original-To: linux-pm@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C28156678;
	Tue,  2 Dec 2025 00:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764636064; cv=none; b=SeLbsAuARadQDc+1RJilqDs3I67astdzJmcNsnD0Dxgz4K2Y2KJgnJWFA9eTDcOwfhORTVc+Gtf4EjatEjdJ9XBLJVFhoeLtJF8iscECrNmo2lg7fGRtB/P/JOwaWRsGwqyooE1SdHEGFgJlCB+umQ5Gc0OWPCW7ykdt32fXLKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764636064; c=relaxed/simple;
	bh=q/+fMsfxWRQ87BSPOP6wpP7vl7WEoyNT2vbAOXwqPVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oa3d7msE1rz06gKXme4+4PHtQxsJtRlIpgxxIc/IhUOBxKyxOR2qgugcBYVca/mt0uLvGPjyhIKBNQFsWINOCRBZ62+dcjxkJXGBFWAHfWPs5rb/6W6Jd7Ia94KzqCtr4sc0sqGjarsU8x/1OjYlY8suuszWelk8yC8X0IeNzVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=i1Aqst7k; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4dL24s5VXMzlfddm;
	Tue,  2 Dec 2025 00:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1764636059; x=1767228060; bh=jBVYC4OVuyu+P8mAHiBgEsj1
	l45yNzPayXRaJwl4aUs=; b=i1Aqst7kunZj49aH9I4407fo4xVazYmEylhToPt+
	0Sdn1GnHYD6FNFXaTVEaz/WrF0GCsmA5liYI77PkvTqCDCGgLW+M1GS2OQqYzvGB
	AarD+YKR4uNEGyvspuO3K2ZSOFzLqCw4QOWYeaPz+GmtXhfaO0V87kI/ne/UzVnj
	rFVwK/ZW8H+H/GUnFNi6bFpbDn1XCK8hHIOHqqcPWfK7pLHWLI/NRs2Ns4yPPan+
	h/rRp38pnp6cT1crCwWcAEmxfsC8AT+sgTQDg/8xNjdcTgjXEH0NckzabH2yHG8Z
	Ep9jz6nfpZb6RPuoK4Vin8vFRSEo0YHS6iXJ5oKonH1OGQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id P1nxLRS4qXlI; Tue,  2 Dec 2025 00:40:59 +0000 (UTC)
Received: from [100.68.218.127] (syn-076-081-111-208.biz.spectrum.com [76.81.111.208])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4dL24m29hhzlfvpG;
	Tue,  2 Dec 2025 00:40:55 +0000 (UTC)
Message-ID: <09ff685f-a688-4b92-a38f-c58b598b464f@acm.org>
Date: Mon, 1 Dec 2025 16:40:54 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PM: runtime: Fix I/O hang due to race between resume
 and runtime disable
To: "Rafael J. Wysocki" <rafael@kernel.org>, YangYang <yang.yang@vivo.com>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20251126101636.205505-1-yang.yang@vivo.com>
 <CAJZ5v0jiLAgHCQ51cYqUX-xjir7ooAC3xKH9wMbwrebOEuxFdw@mail.gmail.com>
 <CAJZ5v0hKpGbwFmxcH8qe=DPf_5GX=LD=Fqj3dgOApUoE1RmJAQ@mail.gmail.com>
 <4697314.LvFx2qVVIh@rafael.j.wysocki>
 <dc4dba4f-8334-40ea-8c53-6e8d135f1d41@acm.org>
 <CAJZ5v0jV-80kfk-AY70b5pQtyXxUtU_ACBVP_TeTAnaY0Up8Lw@mail.gmail.com>
 <1e7583e8-9ae9-4641-8ec2-7c62a637c9fc@acm.org>
 <CAJZ5v0hKe+2orwKP352dBe_PB1pZqMehMo8tSDv5G+cdaJ=OsQ@mail.gmail.com>
 <82bcdf73-54c5-4220-86c0-540a5cb59bb7@vivo.com>
 <CAJZ5v0hm=jfSyBXF0qMYnpATJf56JTxQ-+4JBy3YMjS0cMUMHg@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAJZ5v0hm=jfSyBXF0qMYnpATJf56JTxQ-+4JBy3YMjS0cMUMHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/25 10:47 AM, Rafael J. Wysocki wrote:
> Generally speaking, if blk_queue_enter() or __bio_queue_enter() may
> run in parallel with device_suspend_late() for q->dev, the driver of
> that device is defective, because it is responsible for preventing
> this situation from happening.  The most straightforward way to
> achieve that is to provide a .suspend() callback for q->dev that will
> runtime-resume it (and, of course, q->dev will need to be prepared for
> system suspend as appropriate after that).

Isn't the suspend / hibernation order such that no block I/O is
submitted while block devices transition to a lower power state? I'm
surprised to read that individual drivers are responsible for preventing
that blk_queue_enter() or __bio_queue_enter() run concurrently with
device_suspend_late().

Regarding the UFSHCI driver: if a UFS controller is already runtime
suspended, we want it to remain suspended during system suspend.

Thanks,

Bart.

