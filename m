Return-Path: <linux-pm+bounces-21963-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05158A3264F
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 13:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E66327A2E3E
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 12:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DB720CCDA;
	Wed, 12 Feb 2025 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RaqKmOUW"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609A62046B5
	for <linux-pm@vger.kernel.org>; Wed, 12 Feb 2025 12:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739364826; cv=none; b=FFAl4o9Y5xkHwJj2UEsk5Etpsq8kID4Jo8ltJVqL7zui7DB2zM5DAa0QqZ09uXDtfqVgMrTHQNiZ1adQyNxJQg6OOAmNAw1eoi1bEmWv7U5Y/VqrRQ+gb3ofk7kxUxxicibhby5q+7J9ZWPO0xGtz8X6ohWpETmcnGrzq7NriNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739364826; c=relaxed/simple;
	bh=W4vUf1/0kFjyw3Paou9TarghzObDE/bTqGE1At5j+8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JAXhoxJrR9n5ByCnsjSouAfWJVhavPnn1gvU9pECAfTtewO2jnAxLR5kCT2Y4VLAmDCUCC+IzffNjs2gJxhnUNxilsWcS/LiWJc+xNzBBeGZ9Xj1O2TEBlguJUiYPwuh/Nd/mDl71kr7F50WznOAS/jEpmcI7X3o1GTix3eIKSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RaqKmOUW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739364824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=knzBHB+xibELoM9METHHEBNydWfuqJFvfie23B+AtL0=;
	b=RaqKmOUWFrLlx6d4v/DImjxPZE+9bOAJ3dbDx8fAIW0ue50ktyDiFU5XD6bhK95oLFekT6
	wMIT0KHQ1rrJJo6FRNxmAgQl0Fhad+rq6GPf1UQ7IySdIfbWv9tcdGZ2bYJ2HUU16XWIOC
	pD6CSHqLxnHS8fqzLieghZUJXB5++mY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-oAh5qdfNMc2kx2nLivATpw-1; Wed, 12 Feb 2025 07:53:43 -0500
X-MC-Unique: oAh5qdfNMc2kx2nLivATpw-1
X-Mimecast-MFC-AGG-ID: oAh5qdfNMc2kx2nLivATpw
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c0784e9214so19806285a.1
        for <linux-pm@vger.kernel.org>; Wed, 12 Feb 2025 04:53:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739364822; x=1739969622;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=knzBHB+xibELoM9METHHEBNydWfuqJFvfie23B+AtL0=;
        b=ZE6UF17oJd8QVjzAqB9UAGat+ucmbMi1goIpdk6yluvyLosCmJJKAKdBjj+X/69VSV
         eJi10DDn1TlWfHucD9cTbax6T4dxMVXs7Ylqne8K26s9nuaYhLTZWJoOVmjM4YDBnkRM
         46eKrKWedAtnVZEYv9Q2Sw8bHUUsIz94qR+YKqhXfyrhDP9sqhjP5cOyniEb8VizkNgB
         q4pDn6SdmCY1VLZdCHcjSgHK3yWZ98KCmY+GqZ29JApYMirqNsKfijSH9mLOoAahkoOv
         CpmHNr2+5y/eKvgosecRorNy1xqdzCgJCSz0dfLlRQpkR0zJF/NsjsQ2nZdSudE8F6Gn
         Vnfg==
X-Forwarded-Encrypted: i=1; AJvYcCWGarMClmTIgctc/O5Zh25dg9aDyMU2GNkpR9+iRkEjnxa4kzjdnUxYavFIZvYDH1aU4TUVaevkMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbWOuqafYwcyO/2IVS1YK4u451YFsE68XyHocQFXtS7n8b21pl
	GEhVnCyykIAJ/Uhmzp7TF2cPJfSux9yYZS4ehjk4y1t6R+HIHh8eoS+2sJLL3cdr+MZt+of5jI7
	E1CE8zffjc/xNbEaegvGxv9eH12yh2VdDDUSdsPDamDgKzI3RbsFvthDY
X-Gm-Gg: ASbGncu+vQCRfmoDVkNorFXtqThA9EkgL2IrBQX4dLSH95cxfw3yTW8Zo+lIRUXV4Hu
	qL2VAtwJuHKCilDhRuub9vTuiIAAbm0ZPLDCATDdd4qKKEVbDUV1sP7HRwXQJYAXTuLldVdToBW
	Ko0O3ah6z9ijcTDTAZxLVelDnS5GPrJpQ3xFKrhbju4vcWwU/Bu6mehPM0fdCXEhOePhBgBELHt
	invXbqEpuXtCKg7X3ic/f7FIV+YaRRI7RU6KmOid1j3WYpk/n9ii3Zw4nzUhpcEhBZkO5z0m4fW
	dh/q
X-Received: by 2002:a05:620a:3950:b0:7c0:589b:2f3e with SMTP id af79cd13be357-7c06fc88adcmr407301685a.29.1739364822207;
        Wed, 12 Feb 2025 04:53:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7FcO8kuy6Gfi4rIlvRUBrNcSfOrvcVLper0drGWk6xj15NOdU6I+CCP8OX2xjc19cBs0qPg==
X-Received: by 2002:a05:620a:3950:b0:7c0:589b:2f3e with SMTP id af79cd13be357-7c06fc88adcmr407299085a.29.1739364821922;
        Wed, 12 Feb 2025 04:53:41 -0800 (PST)
Received: from [10.26.1.94] ([66.187.232.136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07518e80fsm66396585a.26.2025.02.12.04.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 04:53:41 -0800 (PST)
Message-ID: <1d2c943f-9521-4dc8-b798-06cbb84bb7dc@redhat.com>
Date: Wed, 12 Feb 2025 07:53:40 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] intel_idle: introduce 'no_native' module parameter
To: dedekind1@gmail.com, kernel test robot <lkp@intel.com>,
 linux-pm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Len Brown <lenb@kernel.org>,
 Prarit Bhargava <prarit@redhat.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250211132741.99944-1-darcari@redhat.com>
 <202502121732.P7lZkbhm-lkp@intel.com>
 <21e66060c13c6a3cc33592f71cb08975711a6adb.camel@gmail.com>
 <9416ee48-a68a-465e-85be-89d5a53afcd8@redhat.com>
 <b7ed8d0b07e82a637bfc8a3f4d592f0f15ba9688.camel@gmail.com>
Content-Language: en-US
From: David Arcari <darcari@redhat.com>
In-Reply-To: <b7ed8d0b07e82a637bfc8a3f4d592f0f15ba9688.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/12/25 7:46 AM, Artem Bityutskiy wrote:
> On Wed, 2025-02-12 at 07:41 -0500, David Arcari wrote:
>> - #ifdef the code that doesn't compile
>> - default no_acpi=true in the !CONFIG_ACPI_PROCESSOR_CSTATE case
>>
>> I sort of like the second option better, but I worry about the
>> documentation.  Specifically:
>>
>> "In the case that ACPI is not configured these flags have no impact
>> +on functionality."
>>
>> I guess that is still true.
>>
>> Perhaps there is a better option.  What do you think?
> 
> I've not been involved into kernel that much for long time. In old days
> sprinkling #ifdefs around was an anti-pattern. Most probably nowadays too. So
> the second option sounds better to me.

Another option would be to change the offending code to a function call:

if (ignore_native()) {

And have ignore_native() always return false when ACPI is not configured.

And yes I should have built and tested the kernel with ACPI disabled. 
My apologies.

I will do that for v4.

-DA

> 
> Artem.
> 


