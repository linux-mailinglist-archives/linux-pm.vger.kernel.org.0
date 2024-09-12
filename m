Return-Path: <linux-pm+bounces-14109-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E352097728C
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 22:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A3DCB21A31
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 20:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C65D1C173B;
	Thu, 12 Sep 2024 20:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ERdrurjv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011521BFDE3
	for <linux-pm@vger.kernel.org>; Thu, 12 Sep 2024 20:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726171435; cv=none; b=lHhnb+blFItimnk8UJw9Eo8wJs6b7RvIEXsCuPz0l1smt10V3xKGJqF2+C/j6Men/bGUZJJrF54Zw8tDsLs8+927RHjmsduXr0UKXoh/uW4QpSC08sUmQ7EBGlM5l8iMQx9ExxP4lkpVw37GE3jur5gYi+b+yu5TYLahkj21rto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726171435; c=relaxed/simple;
	bh=Z5N0iDAv7oS2kzYBkNiUHqo7E1DaTd02v/B+mHVEyBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=niskdaC1o0EpnvP2kBf3cF/uNusXoA0uGigrrfGZj245zoB6e6Aiy1NJ12zqiNzE+yUJuC7tZZGhmtrdXkczIgNZ85fPOLAGhHxZxmR270mjDibyC3kTFPpkGRxfG/uwhYG4iMELy0BKueRg2O01FdteJru0w0dSjC5Gn93FzgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ERdrurjv; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-82521c46feaso7262039f.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Sep 2024 13:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726171431; x=1726776231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ZUw7ImOz/xW0/vF8QPIU2FDaMoIZ6FEl1tTbL5Zu9c=;
        b=ERdrurjvJQOd9bLbI3Z66F985Yj+84zy50A5qvxTumF8efXTbCQA85XxMD0LruEewI
         SY2clBeNfVCD5N4+1PUOMMYDNJxmCz4HJ/NLTD6Sn7rc+jKO5eZR7ctP9R5i9ZZFthgI
         UwXO0brYLo50wgrAXRup86LHuhIiNpTUv7cVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726171431; x=1726776231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZUw7ImOz/xW0/vF8QPIU2FDaMoIZ6FEl1tTbL5Zu9c=;
        b=bmPBZlpK7INLsMz0rHJXRM6V6nuiCUEzsLkLJ6N87zV2LA7nQKHC553l24lIojW+SX
         uNGUmNwCR9qXKjUBezAwG4yTm0o1HczvfDRR6wwFGHkiGqOUAoMNJGbVYxolF2FXTy/r
         AHBfVyUnK10QUY0HEJHtv7IJkrJMHIBCCNeVaxOvVtE0kqrvJXmq1MusVBPZElrEeOZs
         yuPymqop7UMHzdgpyjamu0iPDUmLxopGF1kSgrbQo0619IP2k19KA/sIgYpmZ4AY4vkA
         uUgGEp0qqi0KI+cf+5AOQNwD921hl9afF75FsrrrxApSq8169izn2lWzmng2HNLBqEVX
         p5CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlp4hu5lwG2oVvO6CBPhlf1i3EujFXmgOtZ3ngjU5BG2hYYuoXqHW1t7rh53huNpoeaNu8ImpMAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzteaM5fmn/JumnYvG75nSVzao2KWc8lUgCwoROBE2CHP3pwN9e
	6AxUeL5OTRKpOVTiKmfKyo1iu0kh2Iz6zDRW90QvRTk8+IdJ86L4TQpHFFxa2MWjUBvGDDCuMh4
	y
X-Google-Smtp-Source: AGHT+IHroUZ0nDZDhbbhK4odPskHEvFmnGVJNutX2nw+ZRszt1sOQ+0M+D/Yf225WpVv4rad/FDvxg==
X-Received: by 2002:a05:6602:6c13:b0:82a:a76a:1779 with SMTP id ca18e2360f4ac-82d376d86a4mr91464739f.8.1726171430823;
        Thu, 12 Sep 2024 13:03:50 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d35f433d4asm774136173.17.2024.09.12.13.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 13:03:49 -0700 (PDT)
Message-ID: <b64402ad-4c0d-4f5f-939b-4be1a7855e4a@linuxfoundation.org>
Date: Thu, 12 Sep 2024 14:03:49 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH for-next] pm: cpupower: rename raw_pylibcpupower.i
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: Min-Hua Chen <minhuadotchen@gmail.com>, Thomas Renninger
 <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 John Kacur <jkacur@redhat.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240912125030.19809-1-minhuadotchen@gmail.com>
 <5785527a-b259-42ba-989e-978d2e72ff35@linuxfoundation.org>
 <ZuMmqAmr62ErjqHc@rhfedora>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZuMmqAmr62ErjqHc@rhfedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/24 11:36, John B. Wyatt IV wrote:
> On Thu, Sep 12, 2024 at 10:31:19AM -0600, Shuah Khan wrote:
>> On 9/12/24 06:50, Min-Hua Chen wrote:
>>> This RFC patch is actually bug report. All *.i file will be
>>> removed by 'make mrproper', including raw_pylibcpupower.i, added
>>> by commit: 338f490e07bc ("pm:cpupower: Add SWIG bindings files for libcpupower")
>>>
>>> We can reproduce the error by performing the following command:
>>> cd linux-next
>>> make mrproper
>>> cd tools/power/cpupower/bindings/python
>>> make
>>>
>>> We will get an error message:
>>> make: *** No rule to make target 'raw_pylibcpupower.i', needed by 'raw_pylibcpupower_wrap.c'.  Stop.
>>>
>>> Renaming the raw_pylibcpupower.i is just a workaround to fix the
>>> issue above.
>>
>> I need a non-rfc patch for this. Please send a proper patch
>> I can pull in once John has a chance to review this.
> 

How and when is raw_pylibcpupower.i generated? This looks
like a pre-processor output.


> I have reviewed and tested and this. I am good with it being a stopgap.

I am okay with the stopgap, but I do want i explore other solutions.
> 
> Please send the non-rfc patch.
> 
> Thank you for reporting and sending a patch for this Min-Hua.
> 
> Reviewed-by: John B. Wyatt IV <jwyatt@redhat.com>
> Reviewed-by: John B. Wyatt IV <sageofredondo@gmail.com>
> Tested-by: John B. Wyatt IV <jwyatt@redhat.com>
> Tested-by: John B. Wyatt IV <sageofredondo@gmail.com>
> 

thanks,
-- Shuah


