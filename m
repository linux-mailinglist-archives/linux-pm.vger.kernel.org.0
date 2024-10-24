Return-Path: <linux-pm+bounces-16381-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7DC9AE56B
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 14:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13F4FB213F2
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 12:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D511D63CE;
	Thu, 24 Oct 2024 12:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UkPfp5hf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104811D319B
	for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2024 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729774634; cv=none; b=dyxnd0E2KjrQ5TETdGV8g8lsaoWiqvJaheNH6YlnhCBrnFilX6XgBEftJew9pm7ghCyLBNK4Q0ez+YfpFG4x+q0LFgGu/amT98hEdEplJ657bVnZgHitPlGNQZ6aUkcb3i+nUOlREoxVRvjEThw04nmj0YMLCq4VXr1mPVp0amI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729774634; c=relaxed/simple;
	bh=fqEoIh+dgxuIFMBN6cyueAHztwW8N9qpgQuWpBDpkGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uBrudL4FRj34xrdmQbGK/ldnRoaM+mf1x0bu2cCv2D7cQxT1ZvYR7a6NW6z6Muqql1l51cT/7HSlA1/Ch1sHw0zIwWeLw12Z8PKnSdoHavtCCLtk7bc4Cujeynjf8T3R/Csxm9YPMYJoCZJLb8Ylmo+s/v/9WJ4Lvtp/q/jjEV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UkPfp5hf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so8599955e9.0
        for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2024 05:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729774630; x=1730379430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Il7PJErLFSTwbIIob3qN4HBHgXZw+lBDkmE4mAtAfRs=;
        b=UkPfp5hf6WaTkvW59YpE3aoJ91OOWShbeLxAjWJLdNKW0bzejpu9qowgNXAMpoSSCQ
         FCZHdbMLta73Zk8L6Ca2hl9BA171cJFWgTKEsxeMgPuq3Q2dy/NQo2HKnDmHLWWCJCq4
         rkvw1k6ARIlcKyCerjk2x4V9jSFU+3Qz/VnIMoGFw4iEJKQGRz3FtK4rvNuUHraRHm4M
         7GTlZmPCz2zHdvYv3HUVVQDIE7dHE/5soHstNZkJ/xWOco+/3ONI3lM075mQ1keIsGjd
         EJxSvx4Qusg/z6L26QDPz8142kh5JFnElAgcFRfed4kn3Xp+4aY9IQxhLWSPjj6I3igY
         FAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729774630; x=1730379430;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Il7PJErLFSTwbIIob3qN4HBHgXZw+lBDkmE4mAtAfRs=;
        b=uxGygV6LrJ8LVJQA1/0eBrgk1ZHXx1w5L9HtQn1qQjx2TOXSD66h1Eb+e80ew/tY/G
         H0icr7CipMLOXdUTY0i5my49RBdiTh5JInA2x5id0LS3Z79+8wA7FHSsehE1lMFrolNN
         DDiqsONvIQIiS7vI9vKmwl0lP76Pg3L4f9kvej0NuWORGBcGAQTYMuOQrjv1iXfdmS13
         coT1QLV/uGAjMSgxAXDAEVT1ybeAJ1m8/Wao5uYvaLOqS1vFJ90bdL2VEdiWFZfgQ4CF
         sY1hNYVHAgr4S9t0zBr7NQ+JOmUulp6DFWIquL3Sp5nw5BMUGV5iJEm6FBmhTKGiTiK2
         GkxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmNcS71rjlfOKdFV/cF09Xsqi0/lZ4PVqqHCNdhYRWPU5gL28ZQuJulEzgoeeRsNStKTosCmT14w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSDjJc9WSTb+YFd7im/JcAZcDkpPZnRL9DQIhhc9pVsP04Pfb1
	phGYYK40ckKa6MUWF8dWwolEZXif6zzhiC3KkKf6AyKLzLu5lzKQ/X+SzlNl2+jRuwkiiV31s/l
	4
X-Google-Smtp-Source: AGHT+IFcCk4ndxwV1eYGLw1HNaQkSMmcWJhjmwBTuLmOTNWjeZKVSceV3A3F12X0UF///gySqGg5IQ==
X-Received: by 2002:a05:600c:35cd:b0:430:52ec:1e41 with SMTP id 5b1f17b1804b1-4318415c0acmr57933815e9.17.1729774630318;
        Thu, 24 Oct 2024 05:57:10 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4318b5431ecsm17580855e9.5.2024.10.24.05.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 05:57:09 -0700 (PDT)
Message-ID: <9ba3fa17-57c3-41e9-9e19-33fa105a179e@linaro.org>
Date: Thu, 24 Oct 2024 14:57:09 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/lib: Fix memory leak on error in
 thermal_genl_auto()
To: Markus Elfring <Markus.Elfring@web.de>, linux-pm@vger.kernel.org,
 Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>
References: <20241024105938.1095358-1-daniel.lezcano@linaro.org>
 <45265aca-7371-455f-819f-c4d68cbb089b@web.de>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <45265aca-7371-455f-819f-c4d68cbb089b@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/10/2024 14:02, Markus Elfring wrote:
>> The function thermal_genl_auto() does not free the allocated message
>> in the error path. Fix that by putting a out label and jump to it
>> which will free the message instead of directly returning an error.
> 
> Would you like to add any tags (like “Fixes” and “Cc”) accordingly?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.12-rc4#n145
> 
> 
> …
>> +++ b/tools/lib/thermal/commands.c
>> @@ -375,27 +375,30 @@ static thermal_error_t thermal_genl_auto(struct thermal_handler *th, cmd_cb_t cm
>>   					 struct cmd_param *param,
>>   					 int cmd, int flags, void *arg)
>>   {
>> +	thermal_error_t ret = THERMAL_ERROR;
>>   	struct nl_msg *msg;
>>   	void *hdr;
>>
>>   	msg = nlmsg_alloc();
>>   	if (!msg)
>> -		return THERMAL_ERROR;
>> +		goto out;
> …
> 
> Is it really reasonable to pass a null pointer (from a failed function call)
> to a subsequent nlmsg_free() call?

You are right, I should return here :S



> Can it be more appropriate to return directly in such an error case?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v6.12-rc4#n532
> 
> Regards,
> Markus


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

