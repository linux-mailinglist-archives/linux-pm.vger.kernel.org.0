Return-Path: <linux-pm+bounces-30383-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7ABCAFCFE5
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 17:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64B2D7ABC6A
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 15:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E5B2E4254;
	Tue,  8 Jul 2025 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JqQX9nS/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CD32E2644
	for <linux-pm@vger.kernel.org>; Tue,  8 Jul 2025 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990286; cv=none; b=Omied7pF8FumBvwaCcDLudBhOqFmRio6J+uKvohwdsk4ae/9Yk35gX8SxXndVC/iU8ceW7ZbrxbdZnTpnxs7RekSsas7pEvMe+w2oY23/vbV2cLqEC18u9dYcUYae8OdKQcDhn6EaweN2owN+NrCzYfpWC0NZkoSuRcZWip5+nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990286; c=relaxed/simple;
	bh=7gQeCLAZtQEfIyXXcezsvaIrZXV7Qk5Jv0/UhljKckk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6a/Nfa84of5KsK3jS2lpv1e+KGRxtPa/49+vUyAhDqlOxLhDlNy/CwimMwnb85av2h+HlpS81n1yYknlGQECuybYQThldV+I0DZ4KqLiptu5UsyeQnpNiJpGwJyXfXCB5HDJvOAxjmAN/2529DkmzzeVhdKQKgVRrc5O7/DMH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JqQX9nS/; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60702d77c60so8975548a12.3
        for <linux-pm@vger.kernel.org>; Tue, 08 Jul 2025 08:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751990282; x=1752595082; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tiJvxbpJm4ueaILExBT2ruQnafJPKLQnKbXYAJpzmYw=;
        b=JqQX9nS/QiWWJ+Al0rJUSn3Qb3bPIJlfOylkeHvFqOE3KXrEZgyy9SafPhhlAzxaB6
         vcE/O7Bo8K972vCtMf4hJ5AKb6haJ+EgOeJZwR+Ve/gIwXmBpIbfWmIXBo1lCYbm9xpo
         C/o7ve5Ptb5po7C56fKKpKNK1R7x0nelTcstMciGo+27uammt/5hZ2HVY4Ai+DHLJzbw
         PBd0XOx3STzQO9/Wrp6q2pHAne81pMynhU9IHhVBcuWWQNUIGyn0rJIobR9EV7861bNE
         uOGcfgpXuVAUTb0PVfL3tY2WL2qM2a9frAKTiB0wVHJC89N3FVqH6+F76zOwG8tkT7S8
         ANLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751990282; x=1752595082;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tiJvxbpJm4ueaILExBT2ruQnafJPKLQnKbXYAJpzmYw=;
        b=ObBFn3YAtWVVc2ryWk0Uj/6Q4UpPG5wxw8STnzHLVpkCsEfBV+WbfaX+u2QSQdrrYf
         LDqnh3YOgbphE4Ee5d1jhSFVw9S2J+f28z7PNqJWMjYbEQasusH/jzwU86oE66+ckgae
         +kwWwcNVeMrV5t5BOqeOhHZdQ34jRVw70X9yycSM5zLV23v/yUBTdiKQfmlptbdJnUkt
         rryuemWuHkIHDdy7w3hl61q/urfKmdS7ibNJir68PVyDsRd7AkTkKxmNv/DFwc6oXN8R
         Dr4fbA+n91+9CaykNUl0ACiQIZ/fz7zXUfDyslF1APB591RE0qja27b66WdZZ2FRwZOH
         /3Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUsux3vg7abumpGej4L+ZGNMZE8FaBsqKR2gIBPdFG6akSs+tIXXDMcNusfYoWjzBUt9blwoSpt9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkE0IUPiOQ4QlxsxMktkY2IBA24hLWIma6j26dovTmTVOHBa93
	XcBufFgiQLg7xgj2NHlDU024Ddfzz5PBXsa2a+DAja9dYeL/Sq6Y8jZ9BHhj5smf95c=
X-Gm-Gg: ASbGnctYHiFMrRpWAUZOP+J1goVLb3zVqSJx8Ju843N1NOU4y634oh8pYOLScjyjxBK
	qsJcMt1tnfJ5EjImlMRaXTgwJZCdcj2wucpyVLjowhP97Xkq+HHGS75Z2vMo0yajRxHsOELWjVx
	zr7X39KE0wHr2EufY3ap0o1Q4Kzm2qpFG7hr6G3Dk4zU2dZii3rlox5HQqSEkrYtiy+NpK3of0U
	mvD/Hm4ewtP8/M8BHnhkM23DTkz+jCfLL7wMlq51PT3XXBefT6iHhKITZV3n/h+k2Loyv5XDunL
	GaqJwqCCcqZyDudhz4QTH/pmREyCKXEbIj+MK8tUeuu+xRiTgRoyAfiG3qBenut1ytBsOik=
X-Google-Smtp-Source: AGHT+IG00ZItLfvhtpCxt6kkcwqcafrRvWaaK7c0sFOt4CTrsTCYl9LvDHEYPMR0h+/qH0anL1ixPA==
X-Received: by 2002:a17:907:1c9f:b0:ae3:f2a0:459f with SMTP id a640c23a62f3a-ae6b0ebac72mr353922366b.54.1751990281967;
        Tue, 08 Jul 2025 08:58:01 -0700 (PDT)
Received: from [192.168.0.251] ([82.76.204.12])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fcb8c80acsm7396418a12.80.2025.07.08.08.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 08:58:01 -0700 (PDT)
Message-ID: <cabab318-95a4-4e81-a931-458ee6023f3a@linaro.org>
Date: Tue, 8 Jul 2025 16:58:00 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PM: add kernel parameter to disable asynchronous
 suspend/resume
To: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Len Brown <len.brown@intel.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, peter.griffin@linaro.org,
 andre.draszik@linaro.org, willmcvicker@google.com, kernel-team@android.com
References: <20250708-pm-async-off-v2-1-7fada54f01c0@linaro.org>
 <18c12f92-2194-4244-8793-5d916edfd4e8@infradead.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <18c12f92-2194-4244-8793-5d916edfd4e8@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/8/25 4:36 PM, Randy Dunlap wrote:
> Hi,
> 

Hi, Randy!

> On 7/8/25 8:16 AM, Tudor Ambarus wrote:
> 
>> ---
>>  Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++++
>>  kernel/power/main.c                             |  9 +++++++++
>>  2 files changed, 20 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index f1f2c0874da9ddfc95058c464fdf5dabaf0de713..33ca6b881b1d77bdeea765b19291a90b2a82e8a3 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -5000,6 +5000,17 @@
>>  			that number, otherwise (e.g., 'pmu_override=on'), MMCR1
>>  			remains 0.
>>  
> 
> This should be more like:
> 
> 
> 	pm_async=off	[PM]
> 
> or
> 
>> +	pm_async	[PM]
> 
> 	pm_async=	[PM]
> 			Format: off

Indeed. I see this second description, "kernel_param=", largely used in
the existing kernel parameters, so maybe that's what I shall follow.
However, I don't really know which format to choose, I see:

Format: <string>
Format: { off }
Format: {off}
Format: { "off" }
Format: {"off"}
Format: off

Any idea if there's an already agreed string format?
Thanks,
ta

