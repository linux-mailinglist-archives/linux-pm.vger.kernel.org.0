Return-Path: <linux-pm+bounces-30377-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCF7AFCE59
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 16:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B1B518830D7
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 14:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A382E03E2;
	Tue,  8 Jul 2025 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ltm6PWML"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD212D9ED2
	for <linux-pm@vger.kernel.org>; Tue,  8 Jul 2025 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986708; cv=none; b=trROfdLlnjWtwPwxtEvVSqS6FO6oqXs7m67oAqUie++5HZSNCXgyNRIHF1a51wCMtmZnC+AIepDATsLxS0KHzKdMTdWDY0VEkqUIA7N2rff0Giq/U9zYe9LHVZTdb/mXJEqxaRTNNxS6yFMmNH1y3S9GiH4nOswKq+pnhq/OyME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986708; c=relaxed/simple;
	bh=8s0xa7L5BjSxz1JQE/gd29Vqw8ZPITgvO9C8rgWyOmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X1wDWQIEhOPlrNKjoew8VCgFfZ1rrqH2/turvZjv36CoSooMOEVW7j0WDlBMTpVcyoHK6d5E+nS5rsTAgHWE8jo3ASGawYcRgJsGLollAfhz79vig/HaoKEypHBGDAxXNs8I9m6ZWii7OjXk0/MvDlLGn7ihepQ56UJPen0KcQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ltm6PWML; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169bso7275866a12.1
        for <linux-pm@vger.kernel.org>; Tue, 08 Jul 2025 07:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751986705; x=1752591505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B4jT32HA4W2Qzu0z0BHKWxYGrYNQ+ge5ttUU4NoaGyc=;
        b=ltm6PWMLLvzPXSej1/qnr/0tD4n2ONwu0CbcMgOU3gnLVgw8r0n6mcNIB2kVo5Kl5u
         IjCpQL12ruy8RhrIeInMjmwj6MTWxPBVkX2HT6clbQkMZKagDqmgS9FBYGM0nLY9dgit
         7VvjzUsBX32LtCvF/egtwSWaQ1ies0z46gDb10CsjrKOtx6YiDf2lGlfWfxjsszWMT7f
         ZO/CpztCZZh6YKaicfcde+QL+SQ5pHSK87OXW6AKD09qEVGP/icXxd14NWB6Q+iIs65x
         9Z5rS4bN1ojFPqgnaXYdNcGFryjUNvTAz6kUs/cUknWzHG9fgGrjXSdo/qTrxuf4M9RT
         Kbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751986705; x=1752591505;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B4jT32HA4W2Qzu0z0BHKWxYGrYNQ+ge5ttUU4NoaGyc=;
        b=ZeufJiB0WQF6qRpqIB1aEe9RffxzZv39bHtNMw/9X14XWUCvNXI+lCR5eUJ6jhcYOm
         c8cNih4eb86VUtLcsfCxHzZviWMw96fWg7FPiMENADaNX1DgSBc41L1pmqQQgdK8gvKj
         A55DImhvcK1liiAPnoxa2kzsqW7ZxRn6+glqhhRp0SGcr/Wq+CNI16OCtI8cbNy6TlxS
         6M7zvtZkemfDiPUVsuOuO0JYM1tMcK4Vm1wT17zfz06U+DY4IBOLrEU0Da8VriDgxBqq
         4lhY85Hr+9VMUak1mqD6gewLgRSdcj9OpqxG6iJvMSC/8R1+DjRukEIIPPyDsq0Pk/bT
         qBTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdbON2v5FIMooo3KK/HEJ/GGffohT3J9/Lz8JfedQ2SZyiiY4I86+dU+wiJ/O/xqU0DCIk7uUNIg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8wHBPW9tTugPdzXuVqUafqOK4dMPXTqOcmCS0ExuTwaIWd0sz
	31CcKVYepMAZAH0vhsOtZx4evfojKOi7RjfQsJ4uHHF00gD7QEe2hXRtsNstSUYtTFPZVi3fmAN
	XuVeNTkQ=
X-Gm-Gg: ASbGncvqFaFiSWTaEyEF1IMZrIEZLiL36Punb3unLQXA/8q0V3TXTc3WJVB2o6vUSkX
	Kl0x++T5lM4+MiEh02idN6/KPdZLNrGi4gWeu1Sv+MJ98IPr9OzxchSNTjT9lqnAa2XYuI9PFGR
	+NEAVL9X/NbSJv6lVbwiR4xbd2R/n1p8AdmgvqYpH0xIN/H5qfxnNKzL5zTIMQrOhnxfYs04pSb
	6RLaNgmKhMOf+FegKv5Evvqle1+bgrYubh9Vt+wbuztu6Fe0x+Ok20k4jvukOMzSN7GSvoawUkW
	lLzP8Z8yeOEekD+z/P/ndrYHj3Cm9qVneGLI49HLs9ya09y4bYiISeYggB2N7DJFChwGaVk=
X-Google-Smtp-Source: AGHT+IEyVGRav48RsWOQ+IbAhO5COYztnDZYY9ox0Xfv6AASPPJWInKbHNlJUCQb/6Tlb54HYzvLrQ==
X-Received: by 2002:a50:c052:0:b0:610:5794:d83c with SMTP id 4fb4d7f45d1cf-6105794dc39mr1106147a12.19.1751986705123;
        Tue, 08 Jul 2025 07:58:25 -0700 (PDT)
Received: from [192.168.0.251] ([82.76.204.12])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fca66e566sm7314471a12.11.2025.07.08.07.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 07:58:24 -0700 (PDT)
Message-ID: <fae52bad-b78f-4518-989f-9624c6a749d8@linaro.org>
Date: Tue, 8 Jul 2025 15:58:22 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: add kernel parameter to disable asynchronous
 suspend/resume
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@kernel.org>,
 Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 peter.griffin@linaro.org, andre.draszik@linaro.org, willmcvicker@google.com,
 kernel-team@android.com
References: <20250708-pm-async-off-v1-1-1b200cc03d9c@linaro.org>
 <CAJZ5v0gMk+Jt5WBUB=+cvv2YoU+49nRxL4KPRGm9TAdzkUvQhQ@mail.gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAJZ5v0gMk+Jt5WBUB=+cvv2YoU+49nRxL4KPRGm9TAdzkUvQhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/8/25 3:38 PM, Rafael J. Wysocki wrote:
> On Tue, Jul 8, 2025 at 4:28 PM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>
>> On some platforms, device dependencies are not properly represented by
>> device links, which can cause issues when asynchronous power management
>> is enabled. While it is possible to disable this via sysfs, doing so
>> at runtime can race with the first system suspend event.
>>
>> This patch introduces a kernel command-line parameter, "pm_async", which
>> can be set to "off" to globally disable asynchronous suspend and resume
>> operations from early boot. This provides a robust way to fall back to
>> synchronous (sequential) operation, which can stabilize platforms with
>> problematic dependencies and also serve as a useful debugging tool.
>>
>> The default behavior remains unchanged (asynchronous enabled). To disable
>> it, boot the kernel with the "pm_async=off" parameter.
> 
> IIUC, this effectively is a way to change the initial value of the
> existing pm_async sysfs knob.
> 
> Might be worth mentioning in the changelog.
> 

Right. Will update shortly.

>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
>> Dealing with the pixel6 downstream drivers to cope with the changes from
>> https://lore.kernel.org/linux-pm/10629535.nUPlyArG6x@rjwysocki.net/.
>>
>> Similar to what people already reported it seems pixel6 lacks proper
>> device links dependencies downstream causing i2c and spi client drivers
>> to fail to suspend. Add kernel param to disable async suspend/resume.
>> ---
>>  Documentation/admin-guide/kernel-parameters.txt | 9 +++++++++
>>  kernel/power/main.c                             | 9 +++++++++
>>  2 files changed, 18 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index f1f2c0874da9ddfc95058c464fdf5dabaf0de713..55ba3e747d86c09a0696e105a1d9cd99218f0c07 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -5000,6 +5000,15 @@
>>                         that number, otherwise (e.g., 'pmu_override=on'), MMCR1
>>                         remains 0.
>>
>> +       pm_async        [PM]
>> +                       If set to "off", disables asynchronous suspend and
>> +                       resume of devices during system-wide power transitions.
>> +                       This can be useful on platforms where device
>> +                       dependencies are not well-defined, or for debugging
>> +                       power management issues. Defaults to "on" (asynchronous
>> +                       operations enabled).
> 
> And here too because it is now unclear how this relates to the pm_sync
> under /sys/power/.

Sounds good.

