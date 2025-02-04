Return-Path: <linux-pm+bounces-21326-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DAAA272C1
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 14:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D29118873A6
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 13:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92184213E6C;
	Tue,  4 Feb 2025 13:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dEvTrqcc"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4BB212FB9
	for <linux-pm@vger.kernel.org>; Tue,  4 Feb 2025 13:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738674277; cv=none; b=E1Gaf/pk9Ld44AESWEaM6w6rR3NFVXgKHU4fcX4VlkzYDdLrdvsZacTIrdnSgaedoXXEt03pFBfY93rD5WWZ/yMw8UUZ06ctRUqQwLfIeqTNtfpen02JNqlS0p2VtCD82ZixjQ5mkmgbAC3zqs4AdcRnoChQiVPvTQesEMYKVS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738674277; c=relaxed/simple;
	bh=Rgc/f+Wcmo8qz72B+3oz5Ap1lo4OkJi0UE2cbc/5xAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e8UYwmekavJv1e6rgoRTJlzp8OXNEkZ9a3BNS5wWWr3ti7E4Qi8/1v9/bANRVQSQsRRE0o8e4/37nEnzDIhIZVTzXMSZMdADB0x5eYH5aP4k2cxz+wGXKUT/7bRfGzk8iqRWnyICfAd4N9AHMi1f59+GOFWL8U9vUtGCK5vabS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dEvTrqcc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738674274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pppECrInPH/W14Lxcxk1t62QVheAxKn/rN+YSPe7sKs=;
	b=dEvTrqcckQRFVK6KMcEXldTzB5pKMLx6TZaELjkJy4aamDXdYh+GDjU/aLXWK2JWjIdjUl
	3B8K13cEUSYoVfaCDbFGKZQMjLFjYjAKfz4N2qd1FJVTaZsxKnXw3FNU5fD4l8ZSrpYhhD
	lvCU2SSx2uOgOL7LZatAxb8NSvT2Brc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-Mgkr70IUNeWEHL3_JX17Ig-1; Tue, 04 Feb 2025 08:04:31 -0500
X-MC-Unique: Mgkr70IUNeWEHL3_JX17Ig-1
X-Mimecast-MFC-AGG-ID: Mgkr70IUNeWEHL3_JX17Ig
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b6e9fb0436so1734857485a.0
        for <linux-pm@vger.kernel.org>; Tue, 04 Feb 2025 05:04:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738674270; x=1739279070;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pppECrInPH/W14Lxcxk1t62QVheAxKn/rN+YSPe7sKs=;
        b=pgKbuvuzJOAU1+O4AWcE0jznBHvWwc42hW7IOhtt6kniYQnYNCinJwCNP6USwZb9hP
         24T3n8c/XyIkAejNgYQ9gTV3SueunSF8QFkOuXdJvQ9Wpwvot6i0RHEQDfO+cDZIcowC
         dWtukNmxEKwbtVmi9LsK4oLtQw7qNgw9CB5VSmFC0jThRQ37sUIwpD7Ltne/ApLcctvw
         2oi6QvCyfnNRChVQ0bnq3VbFTN1NmNShFyzFkZCsuTtyU5M8jYuMlXFt117Dg/fPWWyG
         aOOBMkKfHuUzbemW4YmLS2K+rO8v9L5VSKMCVQRZLlCKD/wMyygX/wd6wxqIgV86lbZp
         Pngg==
X-Forwarded-Encrypted: i=1; AJvYcCWGtia7eHgz+wlZQgrk1vfQ8uXeBE/2rdmTYn6z44+unOoLR0PThNeg7UbqGMmafjY91HPxrGtyaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwekB7fYTNXufEU8CLJYdzd73zONwp4zi5I/WrzGD+/4nnwBuoK
	Z4mYr70LD57CeCwvsMw+nTSMDmcMZbpElcbEww+Yt3HAX0AIEOTEphLi+Pfi5AA3PicvLZ84s4R
	hecU4k5Nw9/8fyUn98G5mlJlGT+tLfKsqp2zb+4vzG2CFr9tp6u3GEM84
X-Gm-Gg: ASbGncsU6bI8zz7BCoXkPneI4mCjVksbK0f5ltJW4u7ybemkCXTs/iPcl5WqwkG944d
	yiA6WUFqo6OgQRmVvVCP7XFjlL/+F1hhVMOmmNMjQnkLB5giHymjQ3g1w8z5FAHWexs8cHKL265
	Xt2MAX9GqF+6lKpVJSZCz5prf/FeRxtHLga3obA7T3+mSI4pGLlEEZ/uIbDQoOwwTSY2jxLo86K
	pGWLHnl5I4RsqQlMMt6f6tggdH18Umep3Bvn0Aw8Chhznfmd+e6ol4Eox7906bgDRKy4KiQ0vw5
	w5M=
X-Received: by 2002:a05:620a:488f:b0:7bf:f916:faf3 with SMTP id af79cd13be357-7bffccbfe12mr4155344585a.8.1738674270545;
        Tue, 04 Feb 2025 05:04:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtDnf7KDOCUoIHnD6D3YYqYvSaIGGXyxEBh30BXHxvtFSgHTGtciLQnkmGdYC3a2+SLIAjBg==
X-Received: by 2002:a05:620a:488f:b0:7bf:f916:faf3 with SMTP id af79cd13be357-7bffccbfe12mr4155328385a.8.1738674269355;
        Tue, 04 Feb 2025 05:04:29 -0800 (PST)
Received: from [10.26.1.93] ([66.187.232.136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a8c8fafsm634050085a.26.2025.02.04.05.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 05:04:28 -0800 (PST)
Message-ID: <b50ade64-21ea-4420-a7ec-5e17ea7f6af7@redhat.com>
Date: Tue, 4 Feb 2025 08:04:27 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] intel_idle: introduce 'use_acpi_cst' module parameter
To: David Arcari <darcari@redhat.com>, dedekind1@gmail.com,
 linux-pm@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Len Brown <lenb@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250128141139.2033088-1-darcari@redhat.com>
 <e9188365425d2a4c0dfa7cfa2b17ad3d9fcf2735.camel@gmail.com>
 <afbe2137-398b-4053-93e7-2a03aeb32220@redhat.com>
Content-Language: en-US
From: Prarit Bhargava <prarit@redhat.com>
In-Reply-To: <afbe2137-398b-4053-93e7-2a03aeb32220@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/4/25 7:52 AM, David Arcari wrote:
> 
> Hi Artem,
> 
> On 2/4/25 7:23 AM, Artem Bityutskiy wrote:
>> Hi David,
>>
>> On Tue, 2025-01-28 at 09:11 -0500, David Arcari wrote:
>>
>>> +The ``use_acpi_cst`` module parameter (recognized by ``intel_idle`` 
>>> if the
>>> +kernel has been configured with ACPI support) can be set to make the 
>>> driver
>>> +ignore the per cpu idle states in lieu of ACPI idle states. 
>>> ``use_acpi_cst``
>>> +has no effect if ``no_acpi`` is set).
>>
>> With this change, there will be three parameters:
>>
>> * no_acpi
>> * use_acpi
>> * use_acpi_cst
>>
>> I would like to make the naming as intuitive as possible. We do not 
>> rename the
>> first 2, but for the 3rd one, I think "force_acpi" would be a better 
>> name. Or
>> perhaps "no_native"?
> 
> The problem with force_acpi is it is very similar to force_use_acpi 
> which is what intel_idle.c uses internally:
> 

Given that @Artem is suggesting we change the names of things -- perhaps 
we should fix "force_use_acpi" as well?

P.

> drivers/idle/intel_idle.c:module_param_named(use_acpi, force_use_acpi, 
> bool, 0444);
> 
> That said, I am not attached to the 'use_acpi_cst' parameter name.
> 
>>
>> * no_acpi - Do not use ACPI at all. Only native mode is available, no 
>> ACPI mode.
>> * use_acpi - No-op in ACPI mode, consult ACPI tables for C-states on/off
>>    status in native mode.
>> * force_acpi (or no_native?) - Work only in ACPI mode, no native mode 
>> available
>>    (ignore all custom tables).
>>
>> Additionally, I think we should enhance the documentation for 
>> 'no_acpi' and
>> 'use_acpi' while we're at it. Otherwise, it is hard to distinguish 
>> between these
>> three options. Would you consider another patch that improves the 
>> documentation
>> for 'no_acpi' and 'use_acpi', and then adds the third parameter?
> 
> I'm happy to resubmit. I guess I could use 'no_native' for the new 
> parameter and then update the documentation as you suggest above.
> 
> Does that work?
> 
>>
>> Thanks, Artem!
>>
> 
> Best,
> -DA
> 


