Return-Path: <linux-pm+bounces-1614-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD30381EFCD
	for <lists+linux-pm@lfdr.de>; Wed, 27 Dec 2023 16:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D745B21371
	for <lists+linux-pm@lfdr.de>; Wed, 27 Dec 2023 15:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1640F45965;
	Wed, 27 Dec 2023 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YWOsUoAT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444BA45962
	for <linux-pm@vger.kernel.org>; Wed, 27 Dec 2023 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40d4a7f0c4dso44095425e9.1
        for <linux-pm@vger.kernel.org>; Wed, 27 Dec 2023 07:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703691635; x=1704296435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5iaazPbNeX9lIRi0dUK+dnvlpiUbhW1yUnog/cZM3t8=;
        b=YWOsUoATGJ2qqUu2eMqfVwCKz59c3t8aYStwia2t8yjLNjHL9z4i4Ce5Gx8LIgRtZt
         ZPvEEkHjB5n8YWLiOMV/zged5f3Q7nA4ckzN3V5ihA9vpWmsryXCubk72LzdQUZaRDJc
         yI+T0yWhqimcNGSmlX2Ya6U49jxdAj6b13ua6cvIHForlwbAeDjl1WCz0z1moVbNjSpf
         2x8BPq8Swf67gOledz6oNf5FQ2NGUeNp0UFJKCLtrauY8xHh5sEbvXQWI8/N/IeMiGiF
         ewTS7006ojpLbmwZEpjU7hFudSYZIQk3bM6Uw19ay99XANL0SsUVmfPvdXXcJYod/9ZC
         WkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703691635; x=1704296435;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5iaazPbNeX9lIRi0dUK+dnvlpiUbhW1yUnog/cZM3t8=;
        b=joSFNZ5a9DdYr9IDxNnTu/Uwrw6E/uNQ3TbENejvtTSHG9nJ/3EbIhJscSPe0xOWI1
         ZTs/lr/TjVg58eyPX2EZYH+lwQYvTajYBZk177m5mheAVKBt+AbQsqZagyJ7dpGfjxlq
         +xtZQMB06TLQQmFZaLEjjpOGUS28Z4r0Rfg9j2IAVmNLd1r5E3hQISn4I7V1b0UDyN1a
         SkjJbixuUzOMchJjci4zKMQWYmkrvXovgIZtMY2lcmcUzZFkjEFS3rmYCfScoVJM/vBa
         oUrhMPgwF+XVmjIDnbFbEIvmisvO8CXAgMqeZaWowcy13R85Q5n/ahApKfg5OZmWJ4AB
         I28Q==
X-Gm-Message-State: AOJu0Yxvm1SqjdUoZtDIL5/PRg6nzfkAmYMSBy0j220tNfuEJj7/5SWG
	yHUpeUUGPKil77UDjvmXod9TMuogN7TLow==
X-Google-Smtp-Source: AGHT+IGLR7THaG2DKMS357zpqg+DdG14CQz5w/y83Roker2fj+XpV0TmoKSv1XuKFJC2sfdIQC+QjA==
X-Received: by 2002:a05:600c:4981:b0:40c:486d:6cb4 with SMTP id h1-20020a05600c498100b0040c486d6cb4mr4664871wmp.83.1703691635432;
        Wed, 27 Dec 2023 07:40:35 -0800 (PST)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id q11-20020a05600c46cb00b0040d2d33312csm24313310wmo.2.2023.12.27.07.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Dec 2023 07:40:34 -0800 (PST)
Message-ID: <7f1d54e4-5f33-41b2-8f85-b18c3abc84e9@linaro.org>
Date: Wed, 27 Dec 2023 16:40:31 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] thermal: netlink: Add thermal_group_has_listeners()
 helper
Content-Language: en-US
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-pm@vger.kernel.org
References: <20231227140057.174314-1-stanislaw.gruszka@linux.intel.com>
 <20231227140057.174314-2-stanislaw.gruszka@linux.intel.com>
 <ZYwwdz2XabAuCv4y@mai.linaro.org> <ZYxDV3QV4gGHoT/W@linux.intel.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <ZYxDV3QV4gGHoT/W@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/12/2023 16:31, Stanislaw Gruszka wrote:
> Hi Daniel,
> 
> On Wed, Dec 27, 2023 at 03:11:03PM +0100, Daniel Lezcano wrote:
>>> +static int thermal_group_has_listeners(enum thermal_genl_multicast_groups group)
>>> +{
>>> +	return genl_has_listeners(&thermal_gnl_family, &init_net, group);
>>> +}
>>> +
>>>   /************************** Sampling encoding *******************************/
>>>   
>>>   int thermal_genl_sampling_temp(int id, int temp)
>>> @@ -83,6 +88,9 @@ int thermal_genl_sampling_temp(int id, int temp)
>>>   	struct sk_buff *skb;
>>>   	void *hdr;
>>>   
>>> +	if (!thermal_group_has_listeners(THERMAL_GENL_SAMPLING_GROUP))
>>> +		return -ESRCH;
>>> +
>>
>> Do really want to return an error ? Shall we just bail out instead ?
> 
> I decided for error because thermal_notify_* are int functions and we
> return error code for some other cases when the messages can not be
> sent (i.e. alloc error).
> Event if currently return value is ignored by all callers (FWICT),
> error information could be used theoretically.
> 
> If returning 0 is preferable/better, I can change that.

The caller will have to handle the specific case if there is no 
listeners. There is an error if the message can not be sent but here 
there is no error related to that, just we don't send it. So having an 
error when there is nothing to do is not really an error.




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


