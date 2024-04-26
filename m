Return-Path: <linux-pm+bounces-7164-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BC18B33C8
	for <lists+linux-pm@lfdr.de>; Fri, 26 Apr 2024 11:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0632C1C21CA6
	for <lists+linux-pm@lfdr.de>; Fri, 26 Apr 2024 09:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724D613E886;
	Fri, 26 Apr 2024 09:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RoZwsoQD"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EEE13DB88
	for <linux-pm@vger.kernel.org>; Fri, 26 Apr 2024 09:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714123246; cv=none; b=si7r7jMLyGBb54Aa5EwKyL2HBSKVf/Ties7kV6OBLwBOrORZq5cq0LRGMbmAofScg8Mvsc++cITyxeYvzk1bzxwyp5ZAuLuLsqvELuTM4ZHuZT7i/ZyVedZonfV6in4cXHCbjytU5oBnH5TRS/4o9wt9D6brlH812TDv76BItQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714123246; c=relaxed/simple;
	bh=C3rHTvF9PHfzdrgv16HQit9eIpwFV1aeMPWDWLSjEDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XQQfw/AQUIpjtAQ45FAHHiZU2so/uYZTUNSeTIrrcvUuNu2aZWEt7joy5tQmFOjqD0G+HglhpXWupdjKZ9bN1dHXvKshxXfHfpWmJz2PLx3+lF/MgiUmy/rh7ezun2hLvWV+TUsd/6JyeWmR1jmYTSQXh+Vqa54pdf2LkhJaRXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RoZwsoQD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714123242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Dmcns0FZ9CNJhWQ+HJ61vRnl0WhR0+EUECBc2kBET0=;
	b=RoZwsoQDjkBe/Wt/TY1lLYa34TMdhU9v3nrlwKpwR9WCXo61/5nI5jCuzyQzJsFplo6f7P
	BslR8V3oR/N6gqBCfnON4AzH90Py3mFMDHQi2msooTXimtlNSQenAv68lcDbnnsRzD1IRr
	y3xQpjRnb4pQPUmrqNpKVNNf/Sp9ODU=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-lAzPIXDwMXaIWSUgE7QaMg-1; Fri, 26 Apr 2024 05:20:41 -0400
X-MC-Unique: lAzPIXDwMXaIWSUgE7QaMg-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3c700dc69a9so2375426b6e.1
        for <linux-pm@vger.kernel.org>; Fri, 26 Apr 2024 02:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714123240; x=1714728040;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Dmcns0FZ9CNJhWQ+HJ61vRnl0WhR0+EUECBc2kBET0=;
        b=DE3O8BZ1oJRIWhXEGz/U/5KHwuDsb4PBnfRXuuylfPli+nj/J285l99TcbUda89YoC
         G9yhop/n9jA+ytrdZZ0E2spoDuTvpx23W+INicV8kpi5auz3NQCGBmlNiyVTRdL6+8GP
         PjfSLptaG3AeWzhxloOZ+T1EYxDS1cpxODEn8OYWlbJAFIYhAqAoB+Kozfs2tU6SPK4f
         npLkBK9Xwb3RViIM2Zu9UZ0YhK92/jpDwoQ/ES+ffpizYYv6ZOGQpD7ligBFzBBkGG/z
         buCbdhdxVhd19CbUTOn4Qt1bVsM0sqVK3ddUH28RSSbR4RkZsGc+W2vc5vuMx7RDDFcu
         s8kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDCjaPmlqARjJL8UzkVT0IHIlHUj+jzMmZ/6C/3bp1cAjKMfWHd4vFRBx2XRHkJJq6ai4dIud+vkfOz25JGWmcyr0uCroPP5A=
X-Gm-Message-State: AOJu0YwOSNA5MrGYehg0KArScA8RwLXbJeVMI4ICvUpqI0i05l5zNPlO
	vMAlNG+fmM0Kp4mpyquBccDtbEKtQ5Uz4bZ34XDQ6byDZMWVQEVP+tqu/LdrUFg0QUvNn6nHh5b
	I4Mi7kXC6WVo3CePgl2VudsNHXABMgiE+hqFxEVpdrnhiHkZ6Hq/F/Om4
X-Received: by 2002:a05:6808:1528:b0:3c7:dfb:a295 with SMTP id u40-20020a056808152800b003c70dfba295mr2563892oiw.55.1714123240494;
        Fri, 26 Apr 2024 02:20:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkmQHR4xd5DGzRLvfFnAFgkLJtQPF1g3QWZiwSfctnEJmyqeJV0jASxLHf/gm5VeDDfBboyg==
X-Received: by 2002:a05:6808:1528:b0:3c7:dfb:a295 with SMTP id u40-20020a056808152800b003c70dfba295mr2563855oiw.55.1714123239985;
        Fri, 26 Apr 2024 02:20:39 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id u9-20020a637909000000b006047eb9c7fcsm5263952pgc.34.2024.04.26.02.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 02:20:39 -0700 (PDT)
Message-ID: <0cf50b2f-999f-4aab-bc32-15549d48af2c@redhat.com>
Date: Fri, 26 Apr 2024 19:20:29 +1000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/16] cpu: Do not warn on arch_register_cpu()
 returning -EPROBE_DEFER
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
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, linuxarm@huawei.com,
 justin.he@arm.com, jianyong.wu@arm.com
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
 <20240418135412.14730-3-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240418135412.14730-3-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/18/24 23:53, Jonathan Cameron wrote:
> For arm64 the CPU registration cannot complete until the ACPI
> interpreter us up and running so in those cases the arch specific
               ^^
I guess it's a typo? s/us/is

> arch_register_cpu() will return -EPROBE_DEFER at this stage and the
> registration will be attempted later.
> 
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v7: Fix condition to not print the error message of success (thanks Russell!)
> ---
>   drivers/base/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 56fba44ba391..7b83e9c87d7c 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -558,7 +558,7 @@ static void __init cpu_dev_register_generic(void)
>   
>   	for_each_present_cpu(i) {
>   		ret = arch_register_cpu(i);
> -		if (ret)
> +		if (ret && ret != -EPROBE_DEFER)
>   			pr_warn("register_cpu %d failed (%d)\n", i, ret);
>   	}
>   }


