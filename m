Return-Path: <linux-pm+bounces-15227-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BA2991DE0
	for <lists+linux-pm@lfdr.de>; Sun,  6 Oct 2024 12:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 309641F21AE8
	for <lists+linux-pm@lfdr.de>; Sun,  6 Oct 2024 10:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2431171E65;
	Sun,  6 Oct 2024 10:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pg3Zmx7E"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500D67F6
	for <linux-pm@vger.kernel.org>; Sun,  6 Oct 2024 10:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728211087; cv=none; b=tMZbarZW0NR60wS4T3kUu9wVUADZDvb0UYmxRal8hWPHieIsNQuqzlFMQew2e+bK/oIb9VPijpTXp3a6GNyNZ2AaJKWMIik/3FAC1h/XEJpPjyjR0oFa0bJKvsMnA8Wgw7xW8oU5r6RJEIcEZgle1mVY7FdSUi0vuuH2Gy+MXrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728211087; c=relaxed/simple;
	bh=Bq7Tz41q+fa0j+3ZQeIlm1+u4L9RWU0OmleWy7EWtKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NeQErl2rVxD2E+hZ4DLjMfqBYuv4RYLTqvhKPwXQqZzBSxOAS8Yn5bM6TYbhWvmGj8AnDSaac/5C0r8qeyhVLZ8ztTyqRnUjYrSBv8K8cPVEQwpA/BzP+DP1aHqB8RR1nYDLbekT/A6+jGlhx+s4Knrvj5+d1lQmBzomxK5OYn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pg3Zmx7E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728211085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ItPi/oOw2IPhVtK1a1NEvIYqd7WVKNv5sJgtuuovmM=;
	b=Pg3Zmx7E6ivGHNO4qEBNzMfmnQIBvDRdErfBHDXCE2FKNJ0JokRLk6Bo4wLmIzmiBCLy2c
	v05oEV2kGVJdZiYMzB/hBorlBzV04jm5UrIr/QrL7GpG8ET9dizvhzLcn6nmw2q+bGkVIY
	gkAVHe0QPrSwspk5K1MGcQ6LB2akBek=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-BdeedVRtM1uZRM6X94sneA-1; Sun, 06 Oct 2024 06:38:04 -0400
X-MC-Unique: BdeedVRtM1uZRM6X94sneA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a7d2d414949so324092166b.0
        for <linux-pm@vger.kernel.org>; Sun, 06 Oct 2024 03:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728211083; x=1728815883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ItPi/oOw2IPhVtK1a1NEvIYqd7WVKNv5sJgtuuovmM=;
        b=nFxSWCDlfzjJS1lmNBSILVfvYkQfXvFYYatgCDOkx1AeacmlhW5wsbHAw9McNGx0dM
         AXypm6qfgXkJIrKnTu0V9Axje5XTKWDNJAYgMDAR+0iVfJ2EC0x+GJn2rK8c7sHML7fB
         OTHo8STfKrnlq2/1WHPB9ZNOOPDe3+/2PAXz1njhvQIq5d+tTSdA8q7a/vWLNuR48BBx
         nkKdn/kz4CEIqaDz3GKUEtBMUnMyF80+iaKwhvJhgeHgYC+/oSEcRV1FhDyPqMS8bFR2
         ssNWI2s3ZxpCZhZCQeyEClKD3hu0gB3T1cVraVTDqVpjElr0/npkNdwFKJZKEvC1m8gp
         JqYw==
X-Forwarded-Encrypted: i=1; AJvYcCX1ZbUrZ8v5IISfN+iJiSjgGIHGo81GRo4xN+Xee3VwKzKHQ5dM5ZdXCoK0iO8Wrz13ryrc7iJviw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ToBtunko866MHa/RklLBtfyKgFiHccBkSa6Oqlu8Jp9KIyZK
	WR7TaC0uT2mBBkTbl9WwR0tF2k164Z0zuNz99IUNHOVTVM69Sjra/HHRg8Lw42Ag9mZkqLQyKd1
	Kpgk7ziVdNv0Lq1ZAVUMoikGzASHQ2hCKs5TdzXPVawU1AiHRcah7foRK
X-Received: by 2002:a17:907:980a:b0:a99:4152:1cb4 with SMTP id a640c23a62f3a-a99415220a5mr372218466b.42.1728211082683;
        Sun, 06 Oct 2024 03:38:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMr8aLIFGNj6c7j0ibRW7YvJlcGsorT3VikyA0OZXv+aCTbD1uwOyPVfMak4HF5NdQnAho6g==
X-Received: by 2002:a17:907:980a:b0:a99:4152:1cb4 with SMTP id a640c23a62f3a-a99415220a5mr372216966b.42.1728211082275;
        Sun, 06 Oct 2024 03:38:02 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9944839974sm125210766b.218.2024.10.06.03.38.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2024 03:38:01 -0700 (PDT)
Message-ID: <7deea96e-61bd-4bb1-b478-d908ff735d70@redhat.com>
Date: Sun, 6 Oct 2024 12:38:00 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86:intel/pmc: Disable ACPI PM Timer disabling
 on Sky and Kabe Lake
To: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 David E Box <david.e.box@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Todd Brandt
 <todd.e.brandt@intel.com>, Marek Maslanka <mmaslanka@google.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, regressions@lists.linux.dev,
 linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20241003202614.17181-1-hdegoede@redhat.com>
 <20241003202614.17181-2-hdegoede@redhat.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241003202614.17181-2-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3-Oct-24 10:26 PM, Hans de Goede wrote:
> There have been multiple reports that the ACPI PM Timer disabling is
> causing Sky and Kabe Lake systems to hang on all suspend (s2idle, s3,
> hibernate) methods.
> 
> Remove the acpi_pm_tmr_ctl_offset and acpi_pm_tmr_disable_bit settings from
> spt_reg_map to disable the ACPI PM Timer disabling on Sky and Kabe Lake to
> fix the hang on suspend.
> 
> Fixes: e86c8186d03a ("platform/x86:intel/pmc: Enable the ACPI PM Timer to be turned off when suspended")
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Closes: https://lore.kernel.org/linux-pm/18784f62-91ff-4d88-9621-6c88eb0af2b5@molgen.mpg.de/
> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219346
> Cc: Marek Maslanka <mmaslanka@google.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

I've now applied this patch to my review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans




> ---
>  drivers/platform/x86/intel/pmc/spt.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/spt.c b/drivers/platform/x86/intel/pmc/spt.c
> index 2cd2b3c68e46..ab993a69e33e 100644
> --- a/drivers/platform/x86/intel/pmc/spt.c
> +++ b/drivers/platform/x86/intel/pmc/spt.c
> @@ -130,8 +130,6 @@ const struct pmc_reg_map spt_reg_map = {
>  	.ppfear_buckets = SPT_PPFEAR_NUM_ENTRIES,
>  	.pm_cfg_offset = SPT_PMC_PM_CFG_OFFSET,
>  	.pm_read_disable_bit = SPT_PMC_READ_DISABLE_BIT,
> -	.acpi_pm_tmr_ctl_offset = SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
> -	.acpi_pm_tmr_disable_bit = SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
>  	.ltr_ignore_max = SPT_NUM_IP_IGN_ALLOWED,
>  	.pm_vric1_offset = SPT_PMC_VRIC1_OFFSET,
>  };


