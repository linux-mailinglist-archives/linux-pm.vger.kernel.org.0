Return-Path: <linux-pm+bounces-6181-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0818789F1F1
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 14:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B733628222F
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 12:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3D915B14E;
	Wed, 10 Apr 2024 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H27Fotuo"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622A915B135
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 12:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712751862; cv=none; b=c29KZYJWT7m8bOBCxJeC7L0iiu6jNHC78PbYElk5BXlf59Td2RZs4yRtAIZngYtvDMYLm0ZLekR9oL47/oUGu1aWmaJu+vf1dmbo4R9LyM4VisfMh6iru5V/iGAepOOxogDSqodssCFLfu6iFBvPwS/t5oxG5P5VzV1ewIo0gRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712751862; c=relaxed/simple;
	bh=UnmOqMZXlkkNhcT1d85UwBRUeAne0HW/X8tfs2LcQb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=evHUGvwfvWz/qKL2FqdlXpMlrBntmlPIfEVsaIlEQWc/ch7T65uTpApyGRNDcw5xdZ2YaZu2VH6nWmyW87BA/tpnnvTEn50VN7DwX8jK7RGucUHLxabw8lZ7cnwKem/gNufIIGbpyGUNhNhMIezXz2ZdnCGfJqLRwSxO7715q8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H27Fotuo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712751859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=prnpMYvGmfBZVhuyy9WAFJxzoO03O3wrk1EmdwlswVQ=;
	b=H27Fotuo4Z5zz5Czm5svgbC6Iy9c7uLIeAVzn9C8FOzdEDwtRIZaMEUU2PySqeAlGbdNQM
	6ns+4Znv2Tac3KHbQlngP3R3vYd4XHilka1bnC+uXbTBqY/0rS/uKrFC+TIsFpdViFFv5S
	kWIfMJ5qTuChzexcZ/n/SyYusTOMlSU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-4dDVQPAqNnW2UzPa5xIqCQ-1; Wed, 10 Apr 2024 08:24:17 -0400
X-MC-Unique: 4dDVQPAqNnW2UzPa5xIqCQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a51b97efbb8so447411066b.1
        for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 05:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712751856; x=1713356656;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=prnpMYvGmfBZVhuyy9WAFJxzoO03O3wrk1EmdwlswVQ=;
        b=RO5YbhMjE+WdlTUnO8FohQkO18t67h1U3x7BTcgwB5nxeIYLPnpotQlj4kjW2VJgqm
         1Yer5xAR8XXvfSHM7jW8TwyC6X+k9d4bsCokuwNp7Mts37aVfSmOU4R8MjAmIlF96JdQ
         JoGGovk+C27oYtYwPw/VECoFTqMFOZM9ZdOdmb+LadtS8cL3/d5EROhi6Rda8j6zmMSs
         wDUKv04VBHdd0ZfUEK1kD1fdyLHt9IURXm7lZC2rIdQeoeugYcILoAlhh4HrNDOxlCEI
         sElxoikSXFz5IFcK2IINTtrVBHMhTEAlemVdInKlfFIS2RtvZXYAPd4wWRrztZaZqJ+x
         a1zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZK2fFl8DDhjk/QlMQQaPCWd3DIQStWdYOPvxqI/RRgcqntj76KCDONzwKw9JdRU3d67elKtdiZAah4+bxSbMYsD4umi6JYro=
X-Gm-Message-State: AOJu0Yyk2B80LkG06PPNaolecAY6ms3PR54KUx0ERe95IOK1esk+fHW0
	QlNIvSJN4lgMN5Ol5J+g0o89NME/RFJJVhlzVYYWdHJaztIOxyR3KTQ3Ge2pTiuSiE4KV/uN3Kg
	x1svTZgZPIGyw9ACp4DZiNyqwUPhrUO6QbWofz7e6k3fPPwMxs1n8Zaxp
X-Received: by 2002:a17:906:4899:b0:a51:b49e:473e with SMTP id v25-20020a170906489900b00a51b49e473emr2092177ejq.19.1712751856427;
        Wed, 10 Apr 2024 05:24:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+NCPZWeCOkmRpbzUy9LzzQApNIuXHHEWpmzVLAMZf1BHGFYXbO6mOeHd02i/UMhSes9ABoA==
X-Received: by 2002:a17:906:4899:b0:a51:b49e:473e with SMTP id v25-20020a170906489900b00a51b49e473emr2092152ejq.19.1712751856107;
        Wed, 10 Apr 2024 05:24:16 -0700 (PDT)
Received: from [192.168.0.182] (host-79-51-196-100.retail.telecomitalia.it. [79.51.196.100])
        by smtp.gmail.com with ESMTPSA id w19-20020a1709061f1300b00a4e03823107sm6925730ejj.210.2024.04.10.05.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 05:24:15 -0700 (PDT)
Message-ID: <88144494-33f1-4f43-88c0-885ea6b87e07@redhat.com>
Date: Wed, 10 Apr 2024 14:24:14 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] Disable RT-throttling for idle-inject threads
Content-Language: en-US, pt-BR, it-IT
To: Peter Zijlstra <peterz@infradead.org>,
 Atul Kumar Pant <quic_atulpant@quicinc.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, rafael@kernel.org,
 daniel.lezcano@linaro.org, kernel@quicinc.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240410045417.3048209-1-quic_atulpant@quicinc.com>
 <20240410085441.GA21455@noisy.programming.kicks-ass.net>
 <20240410112933.GA3190796@hu-atulpant-hyd.qualcomm.com>
 <20240410114609.GA40213@noisy.programming.kicks-ass.net>
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20240410114609.GA40213@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/24 13:46, Peter Zijlstra wrote:
> Also, we'll be replacing the throttling code with DL servers 'soonish'
> at which point all this will stop working anyway, since DL will preempt
> anything FIFO, including your idle injection crud.

+1

also, given that the code spins with preempt disabled, with dl server it could
even become a non-rt thread...

FIFO RUNNING
	DL_SERVER activates
		their loop
			disables preemption()
			run()
			enable preemption()
	DL_SERVE throttled
FIFO BACK

So, there will be no need for this busy loop to be RT.

Anyways, it breaks RT and DL if it keeps running for too long... It can
also cause complaints like RCU stalls and loong wait on locks, e.g., on
kworkers...

-- Daniel






