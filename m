Return-Path: <linux-pm+bounces-6153-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1202889EB5B
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 09:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66546281CF5
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 07:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A59F13C90C;
	Wed, 10 Apr 2024 07:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/ZYnsZJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908CC13C8EE
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 07:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712732433; cv=none; b=T+BbaIFe+qcBE60y3nvGTele4+MkJfhVDFV73eVNO+5cFJs4+jDi04C2U74wh3pEXupVScSqyHMhF6tqW9Sc9R4r4GmCMTG055r1NFY36RsMr+KU0NhyjPhfOqD5CRVJu1aTWEv977AJ9/v/zoufyOH6fujt304gTdzBBgvszKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712732433; c=relaxed/simple;
	bh=FhQsd1boIMChf7oRNrqjPNegG/mXoNr0ok8CFmIDsIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGOv8swyHBjZ/DfsRknTKTzewu5esOlhbDGf69MrgXtIHCOj12weJZW445j/zfec0AWM8Lv699HV3wQpDeIkoQ2YCZG9QJHfdCbROQc/QDWVF5ICg+Vc8zQsVxPogFAvIzva4OfSczAVo7/l47WOZ2TcxTY/q0i+7YDrAtG07RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N/ZYnsZJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712732430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qpbw284sxKVH6lHTnqkMx+addOtGg8WZK0QMSoncDMU=;
	b=N/ZYnsZJpl5Z3Q5zB+z4wnwVBAu2UPxqwocoj+xYwYh0AKBlinojm40w4TuHKIfwtnZcgS
	lW+5Szk6Jjt69porYVFDlTC0EXXvtfpS4yv/Qm4h07SBsbTw5+XQQ3lnPLO6nDz5wr4+D8
	1yWVjrPBha2JO5hCow91d7cuDELskqc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-mYrfhQppOlKlILjjcXp6gA-1; Wed, 10 Apr 2024 03:00:27 -0400
X-MC-Unique: mYrfhQppOlKlILjjcXp6gA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-516c5810897so5099168e87.1
        for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 00:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712732426; x=1713337226;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qpbw284sxKVH6lHTnqkMx+addOtGg8WZK0QMSoncDMU=;
        b=fkOYbkUegz9/umbzlNhwXT5Y58s5ijqqcTDFHmXf3LoTS09vZ92IwovxDd+sKBw811
         5ijJDTD0n7nnVRz2DF2qkludkxlQbZMOcT2lNAzOSauaAhrn4BfSdp9nAkESucsXx3eg
         ulVr18u/qmSiKQhcDzSDwrxA6Bf39sfX3BtpRAngJn7q+jNPibsV0PIziwTkOBbJGCDM
         pUMyyLIExf1ZlCqzJ4hygBpm8yQ6bPzmgDhcxPeQAWuCCCM8Cu5Rb0i3lSpmnk8Qq/3s
         NPXSxq4+V4ZQFX3UcTGDjAixxFHwm2IMNbSivL48EGbed+3kpzoJdubvbZJesJM+Qirr
         zguA==
X-Forwarded-Encrypted: i=1; AJvYcCUQsE4seDvPd8ZOoZYgOvYfUNCKydKWHjCf07I77VLEJjq5AMM2MwbrJp3AAhB2GkTvIl/0Bti/IMnJnE9Z3PXhft5B3BUPXNw=
X-Gm-Message-State: AOJu0YwhCMwxPA0HEYWW3QA2VBaEIPPSfStJJ31CYkfsLkE8PhkfUGF1
	UelFtW9ICxwI0yAzZP+Z6bO/fqK2SOjINntLvbBPxyfjjBc3Rq+F+5KTTZzkp4oPixY5yUysQq/
	7tBIdkc2WrEI4ShXQBp8TwG2r8HH7MzQuJJHSQbg1ix8taPqoh4Xxkgbp
X-Received: by 2002:a19:9117:0:b0:516:d729:5c3a with SMTP id t23-20020a199117000000b00516d7295c3amr1168394lfd.50.1712732426356;
        Wed, 10 Apr 2024 00:00:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZwpgzhlS04wJSv2+6nilTveCTk3jDGldjMnH79vAQfGE3vGSdklHYnK7RIL1Ki2VjBojH5w==
X-Received: by 2002:a19:9117:0:b0:516:d729:5c3a with SMTP id t23-20020a199117000000b00516d7295c3amr1168367lfd.50.1712732425800;
        Wed, 10 Apr 2024 00:00:25 -0700 (PDT)
Received: from [192.168.0.182] (host-79-51-196-100.retail.telecomitalia.it. [79.51.196.100])
        by smtp.gmail.com with ESMTPSA id h21-20020a1709066d9500b00a4dacd6b8b3sm6618742ejt.68.2024.04.10.00.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 00:00:25 -0700 (PDT)
Message-ID: <7578e8f4-03ac-4234-90c3-0585af4eca4d@redhat.com>
Date: Wed, 10 Apr 2024 09:00:23 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] sched/rt: Disable runtime accounting for idle
 threads with SCHED_FIFO policy
To: Atul Pant <quic_atulpant@quicinc.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, rafael@kernel.org,
 daniel.lezcano@linaro.org
Cc: kernel@quicinc.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20240410045417.3048209-1-quic_atulpant@quicinc.com>
 <20240410045417.3048209-2-quic_atulpant@quicinc.com>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20240410045417.3048209-2-quic_atulpant@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/24 06:54, Atul Pant wrote:
> To prevent the throttling of RT idle threads, like the idle-inject
> threads, skip accounting of runtime for these threads.
> 
> Signed-off-by: Atul Pant <quic_atulpant@quicinc.com>
> ---
>  kernel/sched/rt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 4ac36eb4cdee..d20999270e75 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1075,7 +1075,9 @@ static void update_curr_rt(struct rq *rq)
>  		struct rt_rq *rt_rq = rt_rq_of_se(rt_se);
>  		int exceeded;
>  
> -		if (sched_rt_runtime(rt_rq) != RUNTIME_INF) {
> +		if (sched_rt_runtime(rt_rq) != RUNTIME_INF &&
> +				!(curr->policy == SCHED_FIFO &&
> +					curr->flags & PF_IDLE)) {


FYI, this will not be a problem with dl server because play_idle_precise()
disables preemption, so the dl server will not be scheduled until preempt_enable().

with the DL server, the time consumed as an rt task will not change the DL server
behavior because the logic inverts: it provides bandwidth for the fair
scheduler (instead of throttling the RT sched).

-- Daniel

>  			raw_spin_lock(&rt_rq->rt_runtime_lock);
>  			rt_rq->rt_time += delta_exec;
>  			exceeded = sched_rt_runtime_exceeded(rt_rq);


