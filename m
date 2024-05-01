Return-Path: <linux-pm+bounces-7423-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7D98B8879
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2024 12:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16D41F2412C
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2024 10:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EC853392;
	Wed,  1 May 2024 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjQsWqm7"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5A7524DC
	for <linux-pm@vger.kernel.org>; Wed,  1 May 2024 10:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714558777; cv=none; b=eivegnh3zTdzaAzQClznsh7mHczq2nft0afh/Dm7vjC+Fu6TuV5OQch2XWN3BkvWX+vfzFLk2Un/SgZt+Iv7u+A/Krp6hl60j/It6wjTwLd3ADh95Ta+9Io8YXNPvG97F6FNCNlvMTnvNF/BkF+UFz6wQnOjZY2AiEFEg0OX2z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714558777; c=relaxed/simple;
	bh=DXhxznU9JjmpSNzg1wHRqUCO05ryVh2E1hgdKVJ0r/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iLBsaZtnUknS35gLAdfEq3JEIU7H4/B1oHiMkWvxzVTlIBD6sLJMueYIqPNgPA+Rkwb1NwiPTFAFCeCnGTT9S6o5cRn859uglqCLk05fTLFPR0MXiWiS898cr/FTaIrwQUaLxJPpz5QkLYjrDnsK7KFnKCphajNeBPHgaSO9a9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TjQsWqm7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714558774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mmEGz0tj7kIblBaqJ9h8gJzxXs1BObonWK5NXhTXy2g=;
	b=TjQsWqm7PNZyWJsg/b4LWCit2noY+wSUq7qJGstNobpVfXuwKyTBw0PuZndtPGM6/opIDf
	oZuiVybVcDxt8K4Q3O0widHYBpHkCIaauJM/SmCs5utPPJNcC5fjkpAZ0uBbM4x5n/hVGt
	k4FfTgx+CfEaRWvhuZg2bvfSfhlE1cI=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-Vd8DuyurNkyf-0n5yKcTrg-1; Wed, 01 May 2024 06:19:33 -0400
X-MC-Unique: Vd8DuyurNkyf-0n5yKcTrg-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5ad0529f9c5so8971948eaf.1
        for <linux-pm@vger.kernel.org>; Wed, 01 May 2024 03:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714558773; x=1715163573;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mmEGz0tj7kIblBaqJ9h8gJzxXs1BObonWK5NXhTXy2g=;
        b=qpz2LAPoGk6oyuHiHOFHpBJyhv5pItEoJ9mW3+VUfrSsa5YWd1PAaZHm4lfU91UApV
         CF1ZG2FTlKrtwhIh4+HVtlPGKeYKolqJEoptX4ujXa77MkU4WLupRfiJxiiJRYc31gR1
         bj7vfnppmqDSsZld/2709kjmxCeMPUU9W9Rt+z3wL5Nv6zW/3jLwu8Ys4zKPlb3cGPHE
         cJpzbBuZwUqFmqto8My7//LyuTzfJxvaaMFhLvaRuHch5tAvAtq+lePimo1Tp9fc33TZ
         sxFyuQwEwELZRKXWH9Lw6HrNhdlk8nF+9dPcPzkNm+OTDDSYpG83x0MsDQ0N+KkkeIdg
         6ZVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsSRRl6LKAqjKBAZgh5GdvFdlja/r9qPCL1LS8IC+mQIrh+stX6zwycdNjB8MWovdJyCr5lNPFE/kgBkiLg8XA3xlBJfaYVos=
X-Gm-Message-State: AOJu0Yzu1qnRMXwgd5JYnY0JgKlHseAiEqLyzUk5hee5OMLzeUrPfdCR
	aI+aN2ba4b5eSfYCsxookRg1FFl9N4bjws1D+us2CR9lsffFljzzaNwxhFEyiA6zJxGr94rM+aO
	b5HHaP4gn7oxZFqqDBm+bnEtY0sdmwZxxFFIh2jYnvnPhhCxQaeRFI+KE
X-Received: by 2002:a05:6358:b3c2:b0:186:d3c9:fc0b with SMTP id pb2-20020a056358b3c200b00186d3c9fc0bmr2565164rwc.30.1714558772899;
        Wed, 01 May 2024 03:19:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH109ZEmrs8b6zIYcwGCPZVYbwoFohFQfuWKsDp3G4uwsHjXJPYYLUDItsMWRt9l+MVNm+LjQ==
X-Received: by 2002:a05:6358:b3c2:b0:186:d3c9:fc0b with SMTP id pb2-20020a056358b3c200b00186d3c9fc0bmr2565125rwc.30.1714558772433;
        Wed, 01 May 2024 03:19:32 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id x71-20020a63864a000000b00606dd49d3b8sm12183225pgd.57.2024.05.01.03.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 03:19:31 -0700 (PDT)
Message-ID: <02922d47-6bb9-4865-b13f-b3a6972853a6@redhat.com>
Date: Wed, 1 May 2024 20:19:23 +1000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 05/19] ACPI: processor: Fix memory leaks in error paths
 of processor_add()
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, x86@kernel.org, Russell King
 <linux@armlinux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Miguel Luis <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>,
 Salil Mehta <salil.mehta@huawei.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Hanjun Guo <guohanjun@huawei.com>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, linuxarm@huawei.com,
 justin.he@arm.com, jianyong.wu@arm.com
References: <20240430142434.10471-1-Jonathan.Cameron@huawei.com>
 <20240430142434.10471-6-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240430142434.10471-6-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/24 00:24, Jonathan Cameron wrote:
> If acpi_processor_get_info() returned an error, pr and the associated
> pr->throttling.shared_cpu_map were leaked.
> 
> The unwind code was in the wrong order wrt to setup, relying on
> some unwind actions having no affect (clearing variables that were
> never set etc).  That makes it harder to reason about so reorder
> and add appropriate labels to only undo what was actually set up
> in the first place.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v9: New patch in response to Gavin noticing a memory leak later in the
>      series.
> ---
>   drivers/acpi/acpi_processor.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


