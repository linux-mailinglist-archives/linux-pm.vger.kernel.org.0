Return-Path: <linux-pm+bounces-21325-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D394A2727E
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 14:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26C183A17FB
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 13:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E146A2135AC;
	Tue,  4 Feb 2025 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OC1Bntae"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0882D211A24
	for <linux-pm@vger.kernel.org>; Tue,  4 Feb 2025 12:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738673573; cv=none; b=CWq7i5t6gHRN+84h3uupCYtACyzvnTO0R7XSOrLPnV/wno+fEpW3sNeRLRM9B+tgeuVhEiScq2khLMLKdJMxML6Gx0/431EYfxjPWMYZzpl1mGyqOiFFkc3afi9j2ILW00G3UEO6sUu3qQ18qrIP0USfms67xZtyCaDAmzm6/PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738673573; c=relaxed/simple;
	bh=tdSryqq+nxgkvS3zFFee1YefkpUm59QAMRrn28AGXa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=grkSFS5MEFz/MlrSN2VltUKQNu1+qEFSltE2ARg3sJpUkzDNUQCQFG3/dgh/SSQyhprAiv5+dpMFw28Txj4TrbplUXvueq7+Kcko+53W/A2PU6XKgcTiMbtAasxjAP/B+b7Edqing5/c09GYkp8v/HfKj6wqMZVyMsQ2V6XBtr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OC1Bntae; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738673570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvOSzWz/fXFYgL1SHq0V9p8J5l8O+whyYebMY7GcFOU=;
	b=OC1BntaefQ1eu6vqhk2wvkNON7w7HWBeXGrQsFoC50i9uR677Q7hUxgsPHa9SvFjKBk6bj
	4iK8A/YBk1aTxIRJTtrfoIQ1a9yx0CDCVyZ5afo+j5a6CBbj6mGpDJmRVvwvdye83Ypzkd
	pFbe7hX4O5KT48CkfFVSIIoClafwK5o=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-cAkTo9ZnN_-mGbDNr_j6YA-1; Tue, 04 Feb 2025 07:52:47 -0500
X-MC-Unique: cAkTo9ZnN_-mGbDNr_j6YA-1
X-Mimecast-MFC-AGG-ID: cAkTo9ZnN_-mGbDNr_j6YA
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e42cf312a3so2328106d6.3
        for <linux-pm@vger.kernel.org>; Tue, 04 Feb 2025 04:52:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738673567; x=1739278367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pvOSzWz/fXFYgL1SHq0V9p8J5l8O+whyYebMY7GcFOU=;
        b=ma8SEZj0iUJkrjRng4G2PWgtZGCEEC87LxB4dlw19298zV3C1WFStoYGnP49U17r6L
         UBrBJFg+twXQWGErB+5WcU0E4KDgBDHnthm+WCIc0ea/YCz9PXSbTHvQvQu8tYzpw6ST
         0vKM2a+Qst3DB7eMEl0PbwKIBMMNfvnobwZgMlbUxwOQnLj59OIhbBNPiDvoti651Oz1
         DkKCR7D1Iq1hr2pL4IJlWjhBQonPJQv2HF5V0eVvSe6tNRvLMm+jtLT/rlMM61Xnr3Uu
         IWSAhNKroDzJfamGFS6qoOLzS53c2Q0arnWix4poc6Pu4XfpHjTS1GtNKh7mjaPC2fLm
         wn0w==
X-Forwarded-Encrypted: i=1; AJvYcCWk//S3F2CabzfonrzTA9wC+qW0D1qdfWKzx3k9NBgKTyW4rQDAAMkuc82xl48jhZMJYhwnjuM8UA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz32eNiw09h1/DVCABj+GfbGJkZOZ/bGEF3mxRmZeGUbpQGJ3VI
	cq9icT7pZjYzHU0HZFV6S8FFI8N7TtUh5Mdc6pnV6BnruI2tdMgvIyLUm8sddYttJLNrmQVImDn
	cAyvQg8PKinUCngH2a8kjb/elKVvHR8HDK2WozwW22M3nDjeZBjvrtbzX
X-Gm-Gg: ASbGncuuifoLuIQ8h5eCKZtpVGOjanLlDWSdIXDggbPO9gwqJCN7GoldZN2ghKV2ac3
	78ys6NbYuxGrD7F79I3WTZ6T1KQow9tDnKGfplqwgbhRsh3I6BBIfziep52acUt9xs9A8s8xZS1
	n5REvGw9EYYP/BWvWZM1KIARlqhP/+nzWkgqLqrV1aUouHqZ0LRrfr7uMTCDnyWVT0S63GI/7hH
	ZLbK1iKm5YILUzsG7CrnfMSUMU9nr42siemPyT3m+bW7anmiBjmoYuMWKvtFoHQZPsuMIt82SS2
	NnH+
X-Received: by 2002:a05:6214:48d:b0:6d8:a67e:b2fb with SMTP id 6a1803df08f44-6e243c7bf68mr389612506d6.39.1738673567401;
        Tue, 04 Feb 2025 04:52:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcgbWPNl7P8tA5g1YmE4r9A5UoaGRH3/2GoingbBKNmrPxXra0qeVOzHPtGDTdRQvEw8kNTA==
X-Received: by 2002:a05:6214:48d:b0:6d8:a67e:b2fb with SMTP id 6a1803df08f44-6e243c7bf68mr389612246d6.39.1738673567139;
        Tue, 04 Feb 2025 04:52:47 -0800 (PST)
Received: from [10.26.1.94] ([66.187.232.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e254922a85sm61433486d6.81.2025.02.04.04.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 04:52:46 -0800 (PST)
Message-ID: <afbe2137-398b-4053-93e7-2a03aeb32220@redhat.com>
Date: Tue, 4 Feb 2025 07:52:45 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] intel_idle: introduce 'use_acpi_cst' module parameter
To: dedekind1@gmail.com, linux-pm@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Len Brown <lenb@kernel.org>,
 Prarit Bhargava <prarit@redhat.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250128141139.2033088-1-darcari@redhat.com>
 <e9188365425d2a4c0dfa7cfa2b17ad3d9fcf2735.camel@gmail.com>
Content-Language: en-US
From: David Arcari <darcari@redhat.com>
In-Reply-To: <e9188365425d2a4c0dfa7cfa2b17ad3d9fcf2735.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi Artem,

On 2/4/25 7:23 AM, Artem Bityutskiy wrote:
> Hi David,
> 
> On Tue, 2025-01-28 at 09:11 -0500, David Arcari wrote:
> 
>> +The ``use_acpi_cst`` module parameter (recognized by ``intel_idle`` if the
>> +kernel has been configured with ACPI support) can be set to make the driver
>> +ignore the per cpu idle states in lieu of ACPI idle states. ``use_acpi_cst``
>> +has no effect if ``no_acpi`` is set).
> 
> With this change, there will be three parameters:
> 
> * no_acpi
> * use_acpi
> * use_acpi_cst
> 
> I would like to make the naming as intuitive as possible. We do not rename the
> first 2, but for the 3rd one, I think "force_acpi" would be a better name. Or
> perhaps "no_native"?

The problem with force_acpi is it is very similar to force_use_acpi 
which is what intel_idle.c uses internally:

drivers/idle/intel_idle.c:module_param_named(use_acpi, force_use_acpi, 
bool, 0444);

That said, I am not attached to the 'use_acpi_cst' parameter name.

> 
> * no_acpi - Do not use ACPI at all. Only native mode is available, no ACPI mode.
> * use_acpi - No-op in ACPI mode, consult ACPI tables for C-states on/off
>    status in native mode.
> * force_acpi (or no_native?) - Work only in ACPI mode, no native mode available
>    (ignore all custom tables).
> 
> Additionally, I think we should enhance the documentation for 'no_acpi' and
> 'use_acpi' while we're at it. Otherwise, it is hard to distinguish between these
> three options. Would you consider another patch that improves the documentation
> for 'no_acpi' and 'use_acpi', and then adds the third parameter?

I'm happy to resubmit. I guess I could use 'no_native' for the new 
parameter and then update the documentation as you suggest above.

Does that work?

> 
> Thanks, Artem!
> 

Best,
-DA


