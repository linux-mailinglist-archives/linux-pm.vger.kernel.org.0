Return-Path: <linux-pm+bounces-38751-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E86C8BFB2
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 22:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3D2E635656A
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 21:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92587231858;
	Wed, 26 Nov 2025 21:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ZaXwlZd0"
X-Original-To: linux-pm@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FA545BE3;
	Wed, 26 Nov 2025 21:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764191461; cv=none; b=m9f8DNM49JtKCjwEC/rCVf2oNYye5soxPkWo4aXD0KYYNSkn5UFdCQgJNvTPn5nvUC/8sz8LSczjgFW6ffJ/aPapnCgdiyLP1paG8wqkWgiCKZFyXLPnhebJB1g/tugnZEyqGWHV/jGc5ZomBfbV/74QfgP5Q0qG99Vu3zI8d9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764191461; c=relaxed/simple;
	bh=6jZ2UjY6CdyDRO7VbKwwRYo8BI5Ykkbi3FfuqFwAO4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ji/T6ZvngUOlAqzQvWOPs38kxqncUhwANPPNDJ3mDX2JpOhev1AshARx7vAKHQqIRc2VcbbjNoWhZjR317ZU3V5fbSZUFUuGfJPJbfHB3kmVrdxkqsoWK1WWAnTET3nrFhg03E3XTNoF0Fvt1PY7/1VGS839Jgxf1LfKz28DClc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ZaXwlZd0; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4dGsfp3j70zm1LJR;
	Wed, 26 Nov 2025 21:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1764191456; x=1766783457; bh=4eKSvwSTrdgaIITxMvr6DUjr
	XDaM2duNCkPlaoOCYGY=; b=ZaXwlZd054vlfSvNYjBeQptiLli1Vfwej8e3bG6O
	rQkceSJwlfKPO1swHq1S/2+jqP9Y+xItGO4V/JyJQF+e2Ei6cSiCrwHUE3/u91HA
	agx/q3s3mdJIm7arzU4DJUPnhc85Z93B4QC97wQkqi/5NMkosyI2thEuqxrcRTlb
	zW36G5MrBGDGJy+oALaS2eRTGe7AisozJv/pNxguZ/stHoMQtsr9ZijagFDXQJ6Z
	eZ/KX6KLhpYVpgjPjGI/1lNx1aGdqVD3OlKtFeX6rTH6ZmgNU80B6k3eg//NNekR
	JB7S9hzxEvPLeQwgYB2kR7CNQy08lEVK1AU8fqyS+qyysg==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id yk1xAddWqc_q; Wed, 26 Nov 2025 21:10:56 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4dGsfc13QMzm0N9y;
	Wed, 26 Nov 2025 21:10:47 +0000 (UTC)
Message-ID: <dc4dba4f-8334-40ea-8c53-6e8d135f1d41@acm.org>
Date: Wed, 26 Nov 2025 13:10:46 -0800
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
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <4697314.LvFx2qVVIh@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/26/25 12:17 PM, Rafael J. Wysocki wrote:
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -309,6 +309,8 @@ int blk_queue_enter(struct request_queue
>   		if (flags & BLK_MQ_REQ_NOWAIT)
>   			return -EAGAIN;
>   
> +		/* if necessary, resume .dev (assume success). */
> +		blk_pm_resume_queue(pm, q);
>   		/*
>   		 * read pair of barrier in blk_freeze_queue_start(), we need to
>   		 * order reading __PERCPU_REF_DEAD flag of .q_usage_counter and

blk_queue_enter() may be called from the suspend path so I don't think
that the above change will work. As an example, the UFS driver submits a
SCSI START STOP UNIT command from its runtime suspend callback. The call
chain is as follows:

   ufshcd_wl_runtime_suspend()
     __ufshcd_wl_suspend()
       ufshcd_set_dev_pwr_mode()
         ufshcd_execute_start_stop()
           scsi_execute_cmd()
             scsi_alloc_request()
               blk_queue_enter()
             blk_execute_rq()
             blk_mq_free_request()
               blk_queue_exit()

Thanks,

Bart.

