Return-Path: <linux-pm+bounces-15753-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDD39A064D
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 11:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A3DA1C2307D
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 09:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B504206075;
	Wed, 16 Oct 2024 09:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="glgvlEd7"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16ED206069
	for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2024 09:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072794; cv=none; b=uC1kDlQRjzwLOblF3XtzO/TqNF5pzFCeKjEo9MCISO3r4dQvRbX8dh1Tqf53eAf5CAeuKq+B3/Fttf27JXvqgEzvd4zYj8AIrMbHCCbHQbXJVhkOKTU6FRW9AxU+lVVm335qf9escxjB2n57QY/ww0SD2dRhkawt+ffHbCtrlvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072794; c=relaxed/simple;
	bh=2XC6R4guj5S2LQ3efLjxy0pDXaC+7A8Y4fP4r0jXNJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CI8XX13mSHfDTt3w1vg2z4kDn3oU/UR0GBoruJW0rZqL02+xyXb0vN/9FIABsJ8hD4mHkIKPBKJ17i7+WRc1Kt5a9X2WXZge0Lo7uIuBUS7/dlgKXHZ3a/DWCHQvvZxIltq03lAJFcb/XO/JTOQYphSgmEA9u3lfsmY+XtgEo14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=glgvlEd7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729072791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=klkIURfPfIeZWqtniUUVslo0WqVi18vzVEHDUiCNehs=;
	b=glgvlEd7Vqk1eMYdCXBQKlO9mLPRfWCe8+C/5mvC8XYZskxmsxNWfDFV8LDwlUvaeIjYml
	sdi/HAKv+PwUU++6q9ziR3kDeOQ09CcL312IAtD5O28tatuyXQAdbgX5ix6IAcEjdFcjdP
	G3arFFLug+t9uHvjwziDPf1viPa6O0Y=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-LqzYDknWMOmQOGw-iUNHSg-1; Wed, 16 Oct 2024 05:59:50 -0400
X-MC-Unique: LqzYDknWMOmQOGw-iUNHSg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-539ed93e08aso2939531e87.3
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2024 02:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729072789; x=1729677589;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=klkIURfPfIeZWqtniUUVslo0WqVi18vzVEHDUiCNehs=;
        b=RKNjNeOfgEPoPtskyxaxTJznniOpHCIu/w9H0Cf33ZHZeVQDrwASTJvZcBXRPOhcoa
         RQyZQv2+UrN1Uhv9H3j78HPnnSI3a3EJZC7YwBfEei5LfcXnybd0p66iriEjn0IZ82Mf
         2wxdtCJxof6WP8zNIkAhINGPHf8T4D2EpCTq2ph2XHd596H/PeSMnnEO7OQvmEqQha5m
         sZLn9zgi2lac87ekWXAWTK+0HeNQEgcwGu4MMLyWhLX5wRFHWLTAnADMKXiE9K3/k63Z
         HNK7W4r4qa/nybJ2mixzxkvqfOWa8c1jpvpWw6Q6GyBeTwofDJaUYFFx+OlmtgE4clPc
         MsVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaDT/CEDsEq5CY36fRPXWmJAHmQ/9HNvqkdiSiM1ucefM4hgJTQTeNzTqwPC4MZL/0RoO992D2Aw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxriy+335+ThP60qXW6/25JESfmO/Qnxc8XXU54z7tUZqwR+RAG
	qES0d9aVtqwU63uGumOYPdA6fb7N5NyCij19o53laMQ31NAUd1UZW9OMImNDfqYml+LfefP97+j
	68kC5JXLg+zwZgtrLLiqEDKymPxDsADP/LnwM8ZFpWF9QxQIFoS05hbjm
X-Received: by 2002:a05:6512:2245:b0:539:f7de:df6a with SMTP id 2adb3069b0e04-539f7dee23amr5447493e87.52.1729072787279;
        Wed, 16 Oct 2024 02:59:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFekB89aRCErYZDVnkCQyydN+Q4Cis1HQZOYg9npYTESVjqq1XcbpghIXt6aIaMbsNL8W0r7Q==
X-Received: by 2002:a05:6512:2245:b0:539:f7de:df6a with SMTP id 2adb3069b0e04-539f7dee23amr5447479e87.52.1729072786837;
        Wed, 16 Oct 2024 02:59:46 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d4d710csm1545673a12.10.2024.10.16.02.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 02:59:45 -0700 (PDT)
Message-ID: <e385eea0-694d-47d7-9eab-0c2dcda9b0f4@redhat.com>
Date: Wed, 16 Oct 2024 11:59:44 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/13] platform/x86: hfi: Introduce AMD Hardware
 Feedback Interface Driver
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: Borislav Petkov <bp@alien8.de>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 x86@kernel.org, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
References: <20241010193705.10362-1-mario.limonciello@amd.com>
 <20241010193705.10362-6-mario.limonciello@amd.com>
 <4gcjfysohl7qxdfgmxm6j4yd5ps67qpnnwgt776xondsfdwnri@7mde6vfyfiah>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <4gcjfysohl7qxdfgmxm6j4yd5ps67qpnnwgt776xondsfdwnri@7mde6vfyfiah>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 16-Oct-24 11:36 AM, Uwe Kleine-König wrote:
> Hello,
> 
> On Thu, Oct 10, 2024 at 02:36:57PM -0500, Mario Limonciello wrote:
>> +static struct platform_driver amd_hfi_driver = {
>> +	.driver = {
>> +		.name = AMD_HFI_DRIVER,
>> +		.owner = THIS_MODULE,
>> +		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
>> +	},
>> +	.probe = amd_hfi_probe,
>> +	.remove_new = amd_hfi_remove,
>> +};
> 
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers. Please just drop "_new".

Note there is a "[v3,05/14] platform/x86: hfi: Introduce AMD Hardware
Feedback Interface Driver" patch superseding this one now; and that one
has the same issue.

Regards,

Hans


