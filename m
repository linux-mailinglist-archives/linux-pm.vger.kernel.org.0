Return-Path: <linux-pm+bounces-7427-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B073F8B8915
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2024 13:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41941C20E1F
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2024 11:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AC760BBE;
	Wed,  1 May 2024 11:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QGRzVFwM"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBAE55E5C
	for <linux-pm@vger.kernel.org>; Wed,  1 May 2024 11:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714562106; cv=none; b=VpqKFTcPPJuD5ePDK9QGUiXRg3VIJmmJ5QOuI+1TxfiZdJsHBMZzqmBcIKEoOUv34jpPaIA3ygVoNrODR49YJwQ6CEOZOG8m58XYAfse6nPk8c1PcDNqNFBprJKpvjT2wcSqA4mesihkg+++vigPt5K1coGy9sznKhS5Q6eMaDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714562106; c=relaxed/simple;
	bh=FQodAUfD1JkLmt1uTy5qfN1UspuJsm4imcTHYIOZ1zM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XfJ1x1fVzH9eL70Eml2W22cPA3qknkSxlPiVtHvP+CuOyHx2aweJYwDK4VYZpRXGVWj6Zl+hwEjE0CQqXgC3MbN3wkX/dA9ER7MdU5sUk3brd3zr+BLfMko/g9JckHxVza2TQ0xF0CIsSSpFXVJzdB+1auVk80uCLXLeRyEA5sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QGRzVFwM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714562102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m4zwGvBc/1zudle3Fu3mxvomgwnAp7EzJRWK4hmMCrY=;
	b=QGRzVFwM4PeI30rFlRkRFuZq6UB3Z4zYRNIcS2thKyTFmGdbjiEqDPFrroi6KN2bo7V+3D
	N4xNmBi8cBFgecv6LEnhRhKyLupXOaArDxIuQMREqwsMCtXhZMOdDhMxh/6t8YxRDesXQc
	RZlEsMJbCgdu8r7mfF+LQWsW8vv9uFw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-AWPMfi6rO_Sgcf5mj1CxRQ-1; Wed, 01 May 2024 07:15:01 -0400
X-MC-Unique: AWPMfi6rO_Sgcf5mj1CxRQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2acf6bce4cfso656907a91.0
        for <linux-pm@vger.kernel.org>; Wed, 01 May 2024 04:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714562100; x=1715166900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m4zwGvBc/1zudle3Fu3mxvomgwnAp7EzJRWK4hmMCrY=;
        b=pg7pSBKqCo4lO+9EXDkYbe1EUlJpCYvL2xQJm9WgiZ+NiQ0pBwvEP6G6yprHzMSwYM
         kLuqyH/BxotMps6qatoQQ4WkD/sVKFM9ShSGbCsA2R2QDSOzk4Op9kQslXnvCfXactvO
         jjZYyJCCMudc4GB450QpW7EhKNvj1yTstMH9w5gH2TObHwbd8pksdLXH+aVEPQlXJLEB
         Aqg7pt84yDJ34NSb0pXjpqeqG/76c8OZrvpClJu+P9QR/EyqXJLC53ef1ZC+or16xvqY
         EIWv5awnBuxhfSZ2Z5ah31fW1aS3tYoTr167ZlT5TbI0d4VA0DZcH8eSSa0pr3rizZuP
         e5ug==
X-Forwarded-Encrypted: i=1; AJvYcCUfTYAnL5P8hVtqeqrEAA1XOhjBhZAvCWbwwqPwCUS8mxPFoArDpOf/5HqwZ5Kmk15QwSOxcwjlSiBu0t0iH3REQ1s93hmd7lc=
X-Gm-Message-State: AOJu0YzbpL3TPalooVTsxVL9DLlWS3KNpkrKn9oHG+HCHGjcOOF0WrwB
	hnrr6bi319B9f4xA9s9ZKQGjN2agumNv0apMFvwXuGH2iqgIN5iA7/yf6w1FcRRb92GaYS6p8Ay
	ZvoMj5YQ/TZht3fdeCUR/TChbJp4Yph9E1nVuisn0XngqHvHTXX5amLrt
X-Received: by 2002:a17:90b:3749:b0:2b3:6898:d025 with SMTP id ne9-20020a17090b374900b002b36898d025mr189483pjb.9.1714562100210;
        Wed, 01 May 2024 04:15:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgkwe4UKKc3WldVwMV2boi6I+r208XEIsyNzplTWK4MFoORCuavWHQA0/i+SiniS3enNZ28Q==
X-Received: by 2002:a17:90b:3749:b0:2b3:6898:d025 with SMTP id ne9-20020a17090b374900b002b36898d025mr189419pjb.9.1714562099556;
        Wed, 01 May 2024 04:14:59 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id h9-20020a17090a050900b002a55198259fsm3245338pjh.0.2024.05.01.04.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 04:14:59 -0700 (PDT)
Message-ID: <27e48da5-e1d0-4e4b-978e-954f1766c350@redhat.com>
Date: Wed, 1 May 2024 21:14:50 +1000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 19/19] cpumask: Add enabled cpumask for present CPUs
 that can be brought online
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
 <20240430142434.10471-20-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240430142434.10471-20-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/24 00:24, Jonathan Cameron wrote:
> From: James Morse <james.morse@arm.com>
> 
> The 'offline' file in sysfs shows all offline CPUs, including those
> that aren't present. User-space is expected to remove not-present CPUs
> from this list to learn which CPUs could be brought online.
> 
> CPUs can be present but not-enabled. These CPUs can't be brought online
> until the firmware policy changes, which comes with an ACPI notification
> that will register the CPUs.
> 
> With only the offline and present files, user-space is unable to
> determine which CPUs it can try to bring online. Add a new CPU mask
> that shows this based on all the registered CPUs.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v9: No change
> ---
>   .../ABI/testing/sysfs-devices-system-cpu      |  6 +++++
>   drivers/base/cpu.c                            | 10 ++++++++
>   include/linux/cpumask.h                       | 25 +++++++++++++++++++
>   kernel/cpu.c                                  |  3 +++
>   4 files changed, 44 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


