Return-Path: <linux-pm+bounces-7161-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C6C8B33B0
	for <lists+linux-pm@lfdr.de>; Fri, 26 Apr 2024 11:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BA51282D64
	for <lists+linux-pm@lfdr.de>; Fri, 26 Apr 2024 09:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7763513DDD5;
	Fri, 26 Apr 2024 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bp7zUzNb"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E654B13D8AF
	for <linux-pm@vger.kernel.org>; Fri, 26 Apr 2024 09:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714122932; cv=none; b=TRedp5E1ZcYpo/kKn1gN6I6CxEr1N1l6xkFqS+ooZv7S2CbEXAFDAF12O7SUWZ6mR84RXmHrsFEfwINMCIuY+MWmoDZZzxfDbWJ7g+EIEhAMWyYIOLzvM/fPYuxD8SgGVslLE2URQ9NJuVtxmtZZ5DHkQlcSaLbfj/q0lO95Yn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714122932; c=relaxed/simple;
	bh=+FjPzM84B6BX9czEfRXFDbCKq4ptfl8l7j3daLkKm1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kWeMIdustGmkuAw3fXufsq1Ry8M/V/5KuIIgB79w7d2gDPsT4YbplT4tvLZX0uE7Bv4U+KRNMNdaErB2J07tdZ8Uze0W+c7GxGAx8bySYu+0GohXOwtI6HK9upvCsdrJFuMOPr2wtaWWtL1qQl6L6sthnL+GeTaunSUIRWEcvmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bp7zUzNb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714122929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1jkzt/L+mhv/WzsExsbPIs4x3qKy+eN4N2XWavPkUaM=;
	b=bp7zUzNbGmpZwdfni3O+i0sqI1M6bCH2X8GzV5/GxsU+/gaTOcSfwk95jIACjF8+nAAfXL
	SrvhcmjFicuWkTMCnvnAhhlnuWEWUY046P+O9N9z0anMqv8OaCG3MwQWLyQSZ4YdYpAtzi
	0wOXQIiYrj8k32etxkwD3zTxlFF1PKc=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-DqA58o1tPS6JhoMyYz1N8A-1; Fri, 26 Apr 2024 05:15:28 -0400
X-MC-Unique: DqA58o1tPS6JhoMyYz1N8A-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-601fef07eaeso2179957a12.1
        for <linux-pm@vger.kernel.org>; Fri, 26 Apr 2024 02:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714122927; x=1714727727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1jkzt/L+mhv/WzsExsbPIs4x3qKy+eN4N2XWavPkUaM=;
        b=nidiOWzpTjqEKVH0gq217WyJ+TU7TDLCK6u1jDxjpjfJecJsKrpUPxv2C4odSILurQ
         ejv4keNhtExJipW2b+xjK+QLejEHnHbvr+1IzHRxgpjSnXYnnW81OzAf/zH/9LhgF3VJ
         qcSShUyhSsqEOFH7Sg28NaWsk1VYvbVNfMZrvfTVWXvK9qHZL72MoMx+49tX7UiEUDrs
         b0XVB/zmz4YSxSzJC5oX3UtM5St+gqx3E3/Z9UvvC3hkc3kjna9L9VlbYG1ZNPmEQJZw
         YbTBkFpKxuZFLOePbmjUhrvfQhvM65oTxrrDB5DFZhpscmf2BlvWjAUmQmMRc3VGxNTQ
         9QoA==
X-Forwarded-Encrypted: i=1; AJvYcCXAvzcPxOIsfyB4QhcLQplCw5ZiIDahmnpnxpZTVdpb14bkeDGQGcoMcjza2Uj0PI9SQGCx2RoFOcS7M3sycjEwC8xxIE0YA9A=
X-Gm-Message-State: AOJu0YxHjfJKTgUKAdGNBAOdnHxnX1NTDKjXeQGMZhM5XzMBGDBf5fDM
	k7WXCq+xZet+vNUbX76gSVTNeKwonW3aDhW8zeE85V9HxgCUWBXcoKBE5zxanR1aZ5yH5OePBp5
	LbJPr570/vgolq9kyZo7+8FFePSaVZeHFmHqgpRx9B4u7rkGEPDM27Ifl
X-Received: by 2002:a05:6a20:2713:b0:1a7:5425:3044 with SMTP id u19-20020a056a20271300b001a754253044mr2110996pze.62.1714122927247;
        Fri, 26 Apr 2024 02:15:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGR4IonyI1PkhIL/Wl3B+SXVRCjKsdBxoyZhUJEblO74o+J0ratyZ96kbZ9Bo6ePHW9Uj0s2w==
X-Received: by 2002:a05:6a20:2713:b0:1a7:5425:3044 with SMTP id u19-20020a056a20271300b001a754253044mr2110962pze.62.1714122926856;
        Fri, 26 Apr 2024 02:15:26 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id bm5-20020a056a00320500b006ecf3e302ffsm14955063pfb.174.2024.04.26.02.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 02:15:26 -0700 (PDT)
Message-ID: <4d4f1a85-7aad-4ea1-aaed-1bb744d3ef99@redhat.com>
Date: Fri, 26 Apr 2024 19:15:16 +1000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/16] ACPI: processor: Add acpi_get_processor_handle()
 helper
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
 <20240418135412.14730-6-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240418135412.14730-6-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/18/24 23:54, Jonathan Cameron wrote:
> If CONFIG_ACPI_PROCESSOR provide a helper to retrieve the
> acpi_handle for a given CPU allowing access to methods
> in DSDT.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v7: No change
> v6: New patch
> ---
>   drivers/acpi/acpi_processor.c | 10 ++++++++++
>   include/linux/acpi.h          |  7 +++++++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index ac7ddb30f10e..127ae8dcb787 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -35,6 +35,16 @@ EXPORT_PER_CPU_SYMBOL(processors);
>   struct acpi_processor_errata errata __read_mostly;
>   EXPORT_SYMBOL_GPL(errata);
>   
> +acpi_handle acpi_get_processor_handle(int cpu)
> +{
> +	acpi_handle handle = NULL;
> +	struct acpi_processor *pr = per_cpu(processors, cpu);;
                                                             ^^

                                                             s/;;/;

> +
> +	if (pr)
> +		handle = pr->handle;
> +
> +	return handle;
> +}
>   static int acpi_processor_errata_piix4(struct pci_dev *dev)
>   {
>   	u8 value1 = 0;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 34829f2c517a..9844a3f9c4e5 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -309,6 +309,8 @@ int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id,
>   int acpi_unmap_cpu(int cpu);
>   #endif /* CONFIG_ACPI_HOTPLUG_CPU */
>   
> +acpi_handle acpi_get_processor_handle(int cpu);
> +
>   #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
>   int acpi_get_ioapic_id(acpi_handle handle, u32 gsi_base, u64 *phys_addr);
>   #endif
> @@ -1077,6 +1079,11 @@ static inline bool acpi_sleep_state_supported(u8 sleep_state)
>   	return false;
>   }
>   
> +static inline acpi_handle acpi_get_processor_handle(int cpu)
> +{
> +	return NULL;
> +}
> +
>   #endif	/* !CONFIG_ACPI */
>   
>   extern void arch_post_acpi_subsys_init(void);

Thanks,
Gavin


