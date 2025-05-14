Return-Path: <linux-pm+bounces-27156-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D591AB7635
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 21:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC38D3B41F8
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 19:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256AF28CF73;
	Wed, 14 May 2025 19:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="do+TrsiD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EAE29208E
	for <linux-pm@vger.kernel.org>; Wed, 14 May 2025 19:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747252441; cv=none; b=cocqdPV4v7Vu0KsAacEjmcut4sQts31JG+7ddG9CrasbVv6jOh2IS2MmD87I1kNY30yTrvp1QX0g2Z4WPfOcKs02vYgoorTWBfbJuOVs6kGOsCQf7A+Knm+Ga6gEbEf297IvxFltfVdKZFcrOgU/Hqhd3fz+AwfjP8OFE7f2+C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747252441; c=relaxed/simple;
	bh=TiuJIqeQPLPdM7MV5DHSFrrCGNzg1U0NfsIusO3DWzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lxG+RTInJggNCgjmqB52erHUcJ8AKkUFdIwCcVL7K/tMbH0t/WT8Yz5ecRGkodmLn6bpP5JDpasKRGH6PoZkKZqx3DGggn2jW0cmMZxqW1uFOmCoSvwrqWiqze8asvroVme3erqtCJf4lPcSx1VI2+v+f0IKrlT3RrqKPjUXBxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=do+TrsiD; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-86192b6946eso4290339f.1
        for <linux-pm@vger.kernel.org>; Wed, 14 May 2025 12:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747252438; x=1747857238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rqFC7XclFM6HmznNg5RpQqMdlIL+E3U4uiILOAOVAFs=;
        b=do+TrsiDxIuLHSLCDwRo/JE8/ze5+EEReEonbbZbZz/uGvGHVHVyIWu53w9onN5QYv
         jbtkur+E+v+F0FFBKxK91FcHL9vellkRsQs4AspsZtKuLh+dyvOAIquM1TVhMNCE+9LJ
         SZ4XzDf4ftBnBNVxaQmEtTop4E2aytebx8JR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747252438; x=1747857238;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rqFC7XclFM6HmznNg5RpQqMdlIL+E3U4uiILOAOVAFs=;
        b=dxOObF87CY0HJtstmjeaehRojvEUoAc10Pz3xhzSnKdXOBrQCwiKV3E+E3qAHHRxnU
         ZYI/ajqwq4gYMVzmwp5ifmmPanszmFLj8ZLMcH5I1IFUb0BVzUd1afmm2bTIzJqG1h+Y
         Bke3rMrONhOkRag8pB2OZhTGgSHaOrSkMwAJwHrjbnDNVf04Yy529Y+ngra5AhEYJVor
         IG5pkIP3Lz7yxHpW/XBzJPbx0xQKm3RiiPag62JdXKLOZQDZLF/GU4IXgOWp/6zTxTRN
         jGNlqVM3iXeR0ycecrUiEVEdRD88ZkV2bTIlgGMsmXzmByXFoK9HCmu8nCpOVXNvTZRI
         /8UA==
X-Forwarded-Encrypted: i=1; AJvYcCVNLJlL5jRCi/NM/SKzWrVz7F7TFqqWbiKpi/AQUU4rErABTMrZslg40VbMkAlSj1juRgiqkjD0Uw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxK7zgFPW3/P0RC+HEBEtZYjSzpQHH2VYz8vDsrSmwW8fOvTByN
	rOIMBVnGz3XxlAs+FZ3dnK1kp43kGRMYLiuHFHkNuCNCbidCCOi4U+hlivoFYQOlnEdpDwOuAQ2
	h
X-Gm-Gg: ASbGncuuXJNSspjako3SIK4wxKZgHp4pFCoJ/CM86NHUx1JeJljHCytOC3LzvSMQKH2
	A++ZLulzNYZLmPbjYwDaeht5dBPNkU1fp8YS1LFtj8yc4KXnJ4jw6GL0SUYRZaBEJHnADiozNnK
	eltlhHTGaCkrCpo5xddbpClU8Ftt1O6IM/ddakhPF4gifN79kgy1seDO0suwts6EuzWZlqnBksB
	0GkwtVeR/vylTAiAgvB/c/zKv2awiT9t6VEQYRGh6vkUis3DFUlAA3b5Cnf01aAaOtgiwF7q+Fi
	Tbgv3cM7rvhHWDXZxnz5CGgHKj68UZTlMaYRQxRKDorYke5MFNtptrT8gAmDEA==
X-Google-Smtp-Source: AGHT+IFuhdhs1GZ17AJuuecrmu3II0fZTAN+vGnkqRWbS3S0XvQHj8BZNypViK3Lagb/zZFIppEymQ==
X-Received: by 2002:a05:6602:3a8a:b0:867:6631:d5cb with SMTP id ca18e2360f4ac-86a08dd377bmr647811939f.5.1747252437851;
        Wed, 14 May 2025 12:53:57 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8676356c768sm291043439f.10.2025.05.14.12.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 12:53:57 -0700 (PDT)
Message-ID: <53a4d88a-e84d-4cc6-a041-93476f9df75d@linuxfoundation.org>
Date: Wed, 14 May 2025 13:53:56 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/powercap: Implement powercap_set_enabled()
To: Suchit K <suchitkarunakaran@gmail.com>
Cc: trenn@suse.com, shuah@kernel.org, jwyatt@redhat.com, jkacur@redhat.com,
 linux-pm@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250510184709.44935-1-suchitkarunakaran@gmail.com>
 <09c7ad5e-4061-4c0b-b097-fa575c12a244@linuxfoundation.org>
 <CAO9wTFjyEngVR10ixYj=G8udRBeKaxAQquPCdi0V638t3WqQfA@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAO9wTFjyEngVR10ixYj=G8udRBeKaxAQquPCdi0V638t3WqQfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/13/25 19:20, Suchit K wrote:
> Thanks for the suggestion, Shuah. And I did compile the kernel after
> making the changes.
> 
> 

Please don't top post in kernel patch responses.

> On Wed, 14 May 2025 at 03:33, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 5/10/25 12:47, Suchit Karunakaran wrote:
>>> The powercap_set_enabled() function previously returned a dummy value
>>> and was marked with a TODO comment. This patch implements the function
>>> by writing the desired mode (0 or 1) to /sys/class/powercap/intel-rapl/enabled
>>
>> The short summary should say cpupower: Implement powercap_set_enabled()

I am not clear on how this can be used. Can you elaborate on the use-case
for the set?

Send me v2 fixing the change log.

>>>
>>> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
>>> ---
>>>    tools/power/cpupower/lib/powercap.c | 22 ++++++++++++++++++----
>>>    1 file changed, 18 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tools/power/cpupower/lib/powercap.c b/tools/power/cpupower/lib/powercap.c
>>> index 94a0c69e55ef..7947b9809239 100644
>>> --- a/tools/power/cpupower/lib/powercap.c
>>> +++ b/tools/power/cpupower/lib/powercap.c
>>> @@ -70,6 +70,22 @@ static int sysfs_get_enabled(char *path, int *mode)
>>>        return ret;
>>>    }
>>>
>>> +static int sysfs_set_enabled(const char *path, int mode)
>>> +{
>>> +     int fd;
>>> +     char buf[2] = { mode ? '1' : '0', '\n' };
>>> +     ssize_t ret;
>>> +
>>> +     fd = open(path, O_WRONLY);
>>> +     if (fd == -1)
>>> +             return -1;
>>> +
>>> +     ret = write(fd, buf, sizeof(buf));
>>> +     close(fd);
>>> +
>>> +     return ret == sizeof(buf) ? 0 : -1;
>>> +}
>>> +
>>>    int powercap_get_enabled(int *mode)
>>>    {
>>>        char path[SYSFS_PATH_MAX] = PATH_TO_POWERCAP "/intel-rapl/enabled";
>>> @@ -77,12 +93,10 @@ int powercap_get_enabled(int *mode)
>>>        return sysfs_get_enabled(path, mode);
>>>    }
>>>
>>> -/*
>>> - * TODO: implement function. Returns dummy 0 for now.
>>> - */
>>>    int powercap_set_enabled(int mode)
>>>    {
>>> -     return 0;
>>> +     char path[SYSFS_PATH_MAX] = PATH_TO_POWERCAP "/intel-rapl/enabled";
>>> +     return sysfs_set_enabled(path, mode);
>>
>> Did you compile this?
>>
>> thanks,
>> -- Shuah


