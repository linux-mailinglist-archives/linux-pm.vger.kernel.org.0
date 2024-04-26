Return-Path: <linux-pm+bounces-7162-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0A98B33BB
	for <lists+linux-pm@lfdr.de>; Fri, 26 Apr 2024 11:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E71D0284077
	for <lists+linux-pm@lfdr.de>; Fri, 26 Apr 2024 09:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EDF13DB88;
	Fri, 26 Apr 2024 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O68mexr3"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D3713D621
	for <linux-pm@vger.kernel.org>; Fri, 26 Apr 2024 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714123126; cv=none; b=grSOdmyh44r4OnjZ2vZ1+CnRB+bVk4QFVjWbWRIvBHcYLE4E/6YDk8R+Bml5hEEK07PIQPz/QTDfHIWUithhpYpoCe8/4wvM5fCoBk1HjaiX4vNYZ21G4YPnADqhPhmlhIHJvLLTb1RmeoQ+AjpoO4cmfwcQcMzCx1uyMpv4Pr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714123126; c=relaxed/simple;
	bh=7D3tJqcQV8LkgrErNYvrT2JiTabNaxY0YMn3aq3U2TI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aRoYIYEYNMx/kR9ftQpKe1fRGby9x0pqk/8X+xluuyDI5c0mILI/g8M+Fzj6I7u706A1O6ILSDu9sJGJmFuw90qMsH6/PtR6OoMG46KIBAomJrV1IsDmpbjYBN7khih2t8mFGwu4nvVJ7NfSccJXSevpcyGhbJ4cINThJK9MjYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O68mexr3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714123123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G1NbTRHbQ7U0GF+15RrhvfyGaj1mUIGy4Pli01lUXKI=;
	b=O68mexr3bCB1XiBSbe0z4xRxucIt6ZnBRh17t9QD6j6ys7YWj3tX5Tnku7UuevmNmn/XLn
	m80s41fQ1Iadp13hXdsczhcdk4XB5Q/ijA+BGw+iX8DJ8BwWlpCEzt7ZvdB12n8xEBrDdT
	OC/jqhTZg2xXXA9Ikl8RMBOXWeQeBbs=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-IZx-si4xMzqJrpIUHp4FCA-1; Fri, 26 Apr 2024 05:18:42 -0400
X-MC-Unique: IZx-si4xMzqJrpIUHp4FCA-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6f387e5ce20so1554769b3a.0
        for <linux-pm@vger.kernel.org>; Fri, 26 Apr 2024 02:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714123121; x=1714727921;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G1NbTRHbQ7U0GF+15RrhvfyGaj1mUIGy4Pli01lUXKI=;
        b=FhJQEgCLeAfuliSvFu7Xj0tdc0syqLeR2hVMWRP7s7W/GgzLXlenI6SAPzumtuznlx
         oCLOYvM8AJnx9djEp+7fATAqxk3ukJIB7ANeHNy8YobE230inPHqMPQfgk1LJoUdo63C
         E+ThLPu3qsoWWLlCd4ll7LWVhaBvnVLjHXsPA2DDTYItazDuP0alcskQNHwXfuZAbJWl
         Kt01aqTGTGUrwEpYT3IvKVbMsiZIjNZV2VbI3r2inifP+L8Qujg2W8B8F2EmQHP/UnWA
         qwhl6nF+5qf2t+aYVo1PNUlsJ1u9RmBYzIldMK/u+ax+Mi2sgP4nPj3XgLFSGvutPJ0s
         rPcw==
X-Forwarded-Encrypted: i=1; AJvYcCW3o7UT6w/s/e92GFk8Q1MlOL25lQD23dbSCIEv66hORC2EN2V4E85SoQlW79AzemgBb0yE3OoeG2bc+neURbhocpIxQJMLeCY=
X-Gm-Message-State: AOJu0Yy/wulcY4+wrDRr/egO12UMhtslKmHTuVUEuXyG5+biWt88LbhV
	dMF7+HpkV91c83J4ZTpGfxcb3cz7/7XpjSd85vCw+BjIJ4RcNXvfru1ifIqIzDPG2j5HW26G+w0
	w26JTcli7ELhW1mFPEOmzbjXVnJ/xVO4bkBFvZlQxD9+cUDYq5PQdeL5c
X-Received: by 2002:a05:6a21:168c:b0:1ae:431b:c53b with SMTP id np12-20020a056a21168c00b001ae431bc53bmr323814pzb.35.1714123121587;
        Fri, 26 Apr 2024 02:18:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEStifC6QEJp3sMK/8R6KuO9lazU0QJGymTFO9aPTPCPf5v6oHPNuoPbZcboZcvieVYxOB7Ww==
X-Received: by 2002:a05:6a21:168c:b0:1ae:431b:c53b with SMTP id np12-20020a056a21168c00b001ae431bc53bmr323789pzb.35.1714123121191;
        Fri, 26 Apr 2024 02:18:41 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id n15-20020a170902e54f00b001e512537a5fsm15114388plf.9.2024.04.26.02.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 02:18:40 -0700 (PDT)
Message-ID: <c8f59fd1-cd76-4ac4-a70b-66932170c7c4@redhat.com>
Date: Fri, 26 Apr 2024 19:18:30 +1000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/16] ACPI: processor: Register deferred CPUs from
 acpi_processor_get_info()
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
 <20240418135412.14730-7-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240418135412.14730-7-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/18/24 23:54, Jonathan Cameron wrote:
> From: James Morse <james.morse@arm.com>
> 
> The arm64 specific arch_register_cpu() call may defer CPU registration
> until the ACPI interpreter is available and the _STA method can
> be evaluated.
> 
> If this occurs, then a second attempt is made in
> acpi_processor_get_info(). Note that the arm64 specific call has
> not yet been added so for now this will be called for the original
> hotplug case.
> 
> For architectures that do not defer until the ACPI Processor
> driver loads (e.g. x86), for initially present CPUs there will
> already be a CPU device. If present do not try to register again.
> 
> Systems can still be booted with 'acpi=off', or not include an
> ACPI description at all as in these cases arch_register_cpu()
> will not have deferred registration when first called.
> 
> This moves the CPU register logic back to a subsys_initcall(),
> while the memory nodes will have been registered earlier.
> Note this is where the call was prior to the cleanup series so
> there should be no side effects of moving it back again for this
> specific case.
> 
> [PATCH 00/21] Initial cleanups for vCPU HP.
> https://lore.kernel.org/all/ZVyz%2FVe5pPu8AWoA@shell.armlinux.org.uk/
> commit 5b95f94c3b9f ("x86/topology: Switch over to GENERIC_CPU_DEVICES")
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Joanthan Cameron <Jonathan.Cameron@huawei.com>
> ---

s/Joanthan/Jonathan ?

> v7: Simplify the logic on whether to hotadd the CPU.
>      This path can only be reached either for coldplug in which
>      case all we care about is has register_cpu() already been
>      called (identifying deferred), or hotplug in which case
>      whether register_cpu() has been called is also sufficient.
>      Checks on _STA related elements or the validity of the ID
>      are no longer necessary here due to similar checks having
>      moved elsewhere in the path.
> v6: Squash the two paths for conventional CPU Hotplug and arm64
>      vCPU HP.
> ---
>   drivers/acpi/acpi_processor.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index 127ae8dcb787..4e65011e706c 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -350,14 +350,14 @@ static int acpi_processor_get_info(struct acpi_device *device)
>   	}
>   
>   	/*
> -	 *  Extra Processor objects may be enumerated on MP systems with
> -	 *  less than the max # of CPUs. They should be ignored _iff
> -	 *  they are physically not present.
> -	 *
> -	 *  NOTE: Even if the processor has a cpuid, it may not be present
> -	 *  because cpuid <-> apicid mapping is persistent now.
> +	 *  This code is not called unless we know the CPU is present and
> +	 *  enabled. The two paths are:
> +	 *  a) Initially present CPUs on architectures that do not defer
> +	 *     their arch_register_cpu() calls until this point.
> +	 *  b) Hotplugged CPUs (enabled bit in _STA has transitioned from not
> +	 *     enabled to enabled)
>   	 */
> -	if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
> +	if (!get_cpu_device(pr->id)) {
>   		ret = acpi_processor_hotadd_init(pr, device);
>   
>   		if (ret)

Thanks,
Gavin


