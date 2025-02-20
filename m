Return-Path: <linux-pm+bounces-22542-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C831A3DA19
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 13:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CB7A7009AE
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 12:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2FA1F582D;
	Thu, 20 Feb 2025 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b96N/Iy9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6703A1F540C;
	Thu, 20 Feb 2025 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740054520; cv=none; b=l3J5emjfQ8XzI7SVg6UxsELG+I8GgsQeEWV/2U8Xb67ymDMEaAEG0f+4qfZXoiMEsvMVRQ2AlWrRe8/+Sv6xHchdsDX4xPwwWGwjajDXZ+RpRQp/D5t5sFUqKYKv4cAOnk/e1T+EYqB3++J3WgTGaGzRtv0RAeoYsRVdx7HS+sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740054520; c=relaxed/simple;
	bh=NUNQOQMsRGG7DSg4mxzSVG74HEh1Ws9TkBICyqpDumw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FX2NlES1vKtXKDb79NsaW8yC2p3YHgmC2LmDPVbNrOaNS620SM7/7T8/saKPSnG4+j2bY5LOrZ9swcinqwsKVO/PB7huYRNbOvDBT5mi9RjunKJ0U9O8IkMClHdxS0yw3ypqcofSMw7uOiXs41jQdiojfh+oWwMv+5JOA4dbha4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b96N/Iy9; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220e6028214so16768875ad.0;
        Thu, 20 Feb 2025 04:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740054518; x=1740659318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XzJzI3MSa7XK9xTdL5743Fq2Xbu9IkkDNG1ETRkFDyE=;
        b=b96N/Iy9EwHfexTHig7aubLanNbkebvaGWTCSXt/AM6ypfaqItHyMqNn0SY3tE0+Jn
         Duv2VcoiwEXvDjatAwi5bh0MO/JkFGD2ozGBYcJVuSBbZl8YBvTRUqI0O2XE84wzSke8
         Ol/Zc9r3Qaa7UJDm3P3aoWZ0ckVy/PmxShQo4h7YIZBqC7kv4nvlY0VywHTSspbHE6cA
         AMU/bs3bHJYU8JkH9g1GKrvF1f7EdyFP0bdUQBkMc3uLdK7JjQ3VLt/2z1Jm77sqDUMM
         /AxoIKW+b4eGVM+PNYRrFLyiZsBeCKCEqqYz/BKB8uh3Kcr5WX/ujePVusFU3Absld9D
         8blA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740054518; x=1740659318;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XzJzI3MSa7XK9xTdL5743Fq2Xbu9IkkDNG1ETRkFDyE=;
        b=UAjPuNAJsrcQfFObIbQWRi+whKfrD6kyHofST8AVg8yFQRZHoOLfxseaKD6tzosCim
         7SIINkB5XsH5JPOURU5J+pVgNrmkXGNMycaQnez3BIIYAwoUzUKS8Sgc4vhwft2TTJM5
         12IxU1QODef2gdYDxvK4+U/LOK04pr8iM08puSxwIVZSWshYwRjjsvVAaUwrz5Y0uEzM
         BX8Sv++zLJkzDUR9J0lPUQK9UU4w8MzBMwW36HEAUHzws0t88rTtouQBYZGtnnnOHGqA
         FqJ+gKSKNxGzmhReiVcz2mmJGUeN4p9T6kTifrOheHwrSGfBeECfIdZFfsW5AGiYM7kb
         ROSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYIcA5idEup6XxBqHF2qyiWH8/fJljsKUZuYyo9BjE3X9yeYjx9L/p89IXBiDfXbkYydErfuMMDpVU78A=@vger.kernel.org, AJvYcCWHwInUaQft4idXp/GYOJ4TnvxY/P5hSpaANbsQ+l1B9EWN4JDVsnJRPVP4llCvjIFZcLbMGOvDNnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvSsOolbOIrRonvBOrKWnZ4nq7syoqF2t9m7lFFG1cafqDHuvP
	6pLz85WqxRn8n+WOdrGsIWqgdy6hNXAce6UhYCp7rKQ2+HJfnwWixslfpKOi
X-Gm-Gg: ASbGncuZt7kI3wgA3fVIRss/Z1Np7koQphhKZgYAmHYjK5ECPICXNeMLmPmGmltyvrX
	sAQj0LCkODBtXGOc6JzbiYz+rDhFxyLqY6fHNhFhjXpaM5SHJ2QU88tDp0YDTbNY0wuyTmYqmN8
	NfOlM8t6pQBPepCMPKyirw91HL9sM8qaa3SqZ33y0m9wh8EmfjCkcYwHbQQ49kUXLvUFsA5obQX
	YChITBiUwmJwQOdBpYU1lVQ79fo5BT5btLSEVp9f/zh50Wewm2rsHgsk7AbnU/z4R7AtFiWX24G
	AYc9ibPXGO/TYAtjiWoMs+BQNFnhwOCFxrtxqU1TZIsstyxLs5h/RWg56Q7qOcwV0rX0
X-Google-Smtp-Source: AGHT+IHQdYQPOf3ZTYz+ch9fvB9kyQd03DdROjbnNGl6h80jK1GVCLd0dSbcE1zb/Rzt8hV8CH1BMQ==
X-Received: by 2002:a05:6a20:2d23:b0:1ee:e439:1929 with SMTP id adf61e73a8af0-1eee5d68e2amr4724131637.30.1740054518390;
        Thu, 20 Feb 2025 04:28:38 -0800 (PST)
Received: from [192.168.0.226] (220-137-0-183.dynamic-ip.hinet.net. [220.137.0.183])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adcbe0311b6sm10815482a12.56.2025.02.20.04.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 04:28:38 -0800 (PST)
Message-ID: <1a3c0e5f-777f-4053-91d0-aeed77f4a3d6@gmail.com>
Date: Thu, 20 Feb 2025 20:28:38 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: monitor: Exit with error status if execvp()
 fail
To: Shuah Khan <skhan@linuxfoundation.org>, trenn@suse.com, shuah@kernel.org
Cc: jwyatt@redhat.com, jkacur@redhat.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250211100530.5918-1-s921975628@gmail.com>
 <88d440c0-6a84-4483-939e-9f69e1d7befe@linuxfoundation.org>
Content-Language: en-US
From: Yiwei Lin <s921975628@gmail.com>
In-Reply-To: <88d440c0-6a84-4483-939e-9f69e1d7befe@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/20/2025 4:27 AM, Shuah Khan wrote:
> On 2/11/25 03:05, Yiwei Lin wrote:
>> In the case that we give a invalid command to idle_monitor for
>> monitoring, the execvp() will fail and thus go to the next line.
>> As a result, we'll see two differnt monitoring output. For
>> example, running `cpupower monitor -i 5 invalidcmd` which `invalidcmd`
>> is not executable.
>>
>> Signed-off-by: Yiwei Lin <s921975628@gmail.com>
>> ---
>>   tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git 
>> a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c 
>> b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
>> index f746099b5dac..0fc0e229739d 100644
>> --- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
>> +++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
>> @@ -6,6 +6,7 @@
>>    */
>>     +#include <errno.h>
>>   #include <stdio.h>
>>   #include <unistd.h>
>>   #include <stdlib.h>
>> @@ -295,6 +296,7 @@ int fork_it(char **argv)
>>       if (!child_pid) {
>>           /* child */
>>           execvp(argv[0], argv);
>
> Good find.
>
> Add a check for execvp() fail and print a message
> to say that it is an invalid command and then exit.
>
Thank you! I'll send another patch according to the comment.
> thanks,
> -- Shuah

