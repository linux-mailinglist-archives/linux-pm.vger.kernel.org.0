Return-Path: <linux-pm+bounces-21960-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C1AA32602
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 13:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B887A168E00
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 12:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625C920C497;
	Wed, 12 Feb 2025 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMc9ov/k"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A346320A5E3
	for <linux-pm@vger.kernel.org>; Wed, 12 Feb 2025 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739364079; cv=none; b=GT+U9/Hm/1/kYnUmzrWMrGpLEcjT33rXZV5iRPCwSYnJYR9oAmCG29yRtrfxkybbKnXAPg4VmsTJFmbLLTNm3B3eGbaXLhQadadLwzYq25IMKwqhZDt/psWkVOdj1P6mLqUAnEcYTI9uWNMDGAjrKUMLc3ur82wp0TKWmKdREOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739364079; c=relaxed/simple;
	bh=ME5xsF3un+RPwTZSAF0pplXPAeDr4ydnwfVUmHp8McU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lgyXa9ptBEAQk5h5Lt0eJuTlFy3gJfymWYFrMsgzPRDZ4mvotX+Y3w2f8zHtw3vsuelfynV5BRf+UOg6KyrKRsLwTtnCV18y+Frwx0EI2VjQO/VNBvigtNv0U9TKurJ3Uov7RLvfQexjh7fNxWwAW/yHx8O/ptD8q5L5fepYqZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IMc9ov/k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739364076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IcCcfwfQhYUa1+LUaKcJqa7S3yY7KgRC7fJ6fRDLjdI=;
	b=IMc9ov/kOTB3KB2ZzP/HhuOryZgvCns/3RNzCHQab0SYLIZZxI+Ri09Bv2jul3VS2oI5H/
	sWwbNteHZEj1nQJkHZA6qUTIrxukBB8C/211Tm45f2RXRT5YbF+tjctaVfmYZ8YKX7mf7b
	kTZYLORrWxdQoKHMmDJ5q1IdZGbfbQw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-5QwYzYosNn2bHvif8dxpsg-1; Wed, 12 Feb 2025 07:41:15 -0500
X-MC-Unique: 5QwYzYosNn2bHvif8dxpsg-1
X-Mimecast-MFC-AGG-ID: 5QwYzYosNn2bHvif8dxpsg
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-47189f95eb0so16075221cf.1
        for <linux-pm@vger.kernel.org>; Wed, 12 Feb 2025 04:41:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739364075; x=1739968875;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IcCcfwfQhYUa1+LUaKcJqa7S3yY7KgRC7fJ6fRDLjdI=;
        b=QL+54xuF4MWqyl3K2GPeV42RfVWBnj9GBRV8o8onSMiHZLHPIKKAolDR/euM9WRftZ
         Cecdu/YBhlG8tHpringsmeWQBRAUiGeUAd2RaHmMWOhjUB8fR/oMMhsQNzQJPiy68eDm
         SzS1Z0PhT/880UOsaHAmrEQ6aarHrUTQAhmRHZAr7nrFVvLB9PLXLYrbFicu340joWTK
         w/bOHbJomt1CnXrsRphLaDofecuyaocExp8Q11ajULqP0xflYdBqFYKdh3pZFC9n6A/3
         he8XZJ79YIJ4M0jHu/GV4ZZ5t5MsfLZN6pCJx+9oOapyKRpPlR8ow0oq7qbYoGkhNSVh
         5wEA==
X-Forwarded-Encrypted: i=1; AJvYcCW9QB8dnhJhQqECjhTwFXRIYpLyLGACkGZEUIcny9dXuwdkuLbz53IPwP4VU+ZfwbXv+pd9llcGMg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5nBmd2dyCF5AVtSBLbKfQ5TCmDXzJvlGheQJZis/9VAUXM47O
	AjIhRXD9xAJ2K3juWY87QRM5jBL9SNW7JKpfpyDWtAntBt0iXG83WhMXpoTpPJbl9DZ5px15tIR
	yWchdEGeP8x+30bT0RLB6cqGbtx+Z8c5HzW07M5jXFew8JBX70yZxhUE9Qc9TN0Jf
X-Gm-Gg: ASbGncvDa+7dqzo2wRTMXVJLwh2AIzwh4I2P7c67Dj0J9idAfi0wOE9BeBTVsms6T3k
	4qc6SHP5QiYOUc8iqd149Juw9+LfvaYDegGXR7Q+3DX54A1kn+MsvZ0N5USl5dFZHKRYUe5zJrk
	GSsUaHFbJU5RMtin26noHafDq2nnx05QEfgOYPJjwUsZxkwUdF5TQADMlJ4C/67lqZ0mvr0Lhf9
	EuNV4AdNOAoXkT6m8ca3uHYCoWP5U6j3K/ECX+AxV1xMY45nufjwqdQucQijv9IpMuGe9PlM4GJ
	Vh3n
X-Received: by 2002:ac8:7e90:0:b0:46e:2d0b:e1bf with SMTP id d75a77b69052e-471a1285b1dmr107223531cf.11.1739364074939;
        Wed, 12 Feb 2025 04:41:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEc/5GZoYwqTghTlMDfKo+W14Qj3PAyNsgnM8EOKyze88sNfy/x51BtROYbXMZUOJtzdRgkfg==
X-Received: by 2002:ac8:7e90:0:b0:46e:2d0b:e1bf with SMTP id d75a77b69052e-471a1285b1dmr107223131cf.11.1739364074559;
        Wed, 12 Feb 2025 04:41:14 -0800 (PST)
Received: from [10.26.1.94] ([66.187.232.136])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47180b1ca44sm51284181cf.76.2025.02.12.04.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 04:41:14 -0800 (PST)
Message-ID: <9416ee48-a68a-465e-85be-89d5a53afcd8@redhat.com>
Date: Wed, 12 Feb 2025 07:41:12 -0500
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
Content-Language: en-US
From: David Arcari <darcari@redhat.com>
In-Reply-To: <21e66060c13c6a3cc33592f71cb08975711a6adb.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Artem,

On 2/12/25 6:32 AM, Artem Bityutskiy wrote:
> On Wed, 2025-02-12 at 18:09 +0800, kernel test robot wrote:
>>     drivers/idle/intel_idle.c: In function 'intel_idle_init':
>>>> drivers/idle/intel_idle.c:2289:27: error: 'no_acpi' undeclared (first use
>>>> in this function); did you mean 'no_action'?
>>      2289 |         if (no_native && !no_acpi) {
>>           |                           ^~~~~~~
>>           |                           no_action
>>     drivers/idle/intel_idle.c:2289:27: note: each undeclared identifier is
>> reported only once for each function it appears in
> 
> David, this must be the !CONFIG_ACPI_PROCESSOR_CSTATE case.
> 
> Thanks!

Oh - I see the problem.

After a quick look I see two options:

- #ifdef the code that doesn't compile
- default no_acpi=true in the !CONFIG_ACPI_PROCESSOR_CSTATE case

I sort of like the second option better, but I worry about the 
documentation.  Specifically:

"In the case that ACPI is not configured these flags have no impact
+on functionality."

I guess that is still true.

Perhaps there is a better option.  What do you think?

Thanks,
-DA


