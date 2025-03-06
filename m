Return-Path: <linux-pm+bounces-23580-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13623A5577E
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 21:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31C683B591C
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 20:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875862702C7;
	Thu,  6 Mar 2025 20:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XBwR+uC7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A186249E5
	for <linux-pm@vger.kernel.org>; Thu,  6 Mar 2025 20:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741293241; cv=none; b=E6bBP7tB6WsCkApzuqbIsVt6YfluCH7KeVtxVzwh9INH5wcP8gAM6OdyNPDPnn/avnCs8+d3+qusXxKmn7GVq9aZqqX6+/IaSl1x6fKE8CDVDOX6YKl4qsxh3+qQuFdXVVKDNlFxFn9PN606zHwjEjmuKjdRr2WleHPXsJfe+IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741293241; c=relaxed/simple;
	bh=SIZ0tBXr7dUaXQTtqSJRA7y83aQRtS5SAAGiC//XLHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=deBOpP7aEiUqST3QPmdPpz9iDAEs8kpQ3mqc9E29vKc9xWxFpVJsmRgWuOhnpHZSScju/j/dxvMzrk9vsJ2/uO1/xHGOm6uCljQPo61jxNlQ+tg1XlhWeo1aXgYfQTVn9s8LejprctISYdQthRmjltBmdspg3t4SzLm6xki5oyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XBwR+uC7; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-855184b6473so77888539f.2
        for <linux-pm@vger.kernel.org>; Thu, 06 Mar 2025 12:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741293237; x=1741898037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WIhhdziM3iU4t3IzVbBCpNdmTjl/KV+FrSoZ0CpQigM=;
        b=XBwR+uC7DnUuJgQ7ErTZQU9j/84AHydPK+ka135A2N8wgC9jNdkIcS9QZRQIoYdt6y
         Y3K/6Utsh2lnVAPwP/m9nUrTapVluHWCZiMbrNkqZ5/EBRipjxbwFF+UefS7GjmQ2u0w
         h1p0fyioSesokouMJ0HURPR00Zz6xbV45mBYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741293237; x=1741898037;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WIhhdziM3iU4t3IzVbBCpNdmTjl/KV+FrSoZ0CpQigM=;
        b=osDCjWZrVulxv2r5DHmp4Kx7JV/ZTO2tZwQxBwR4LD8294EaqBvsMcljWgjDkzhJSI
         5oiSEuc2hq0tX9Lq09onA7yT+6V4i5e+EkzPCukL0wZiPrJ4xNAzyl3o8lyXilL3Dg8Q
         xDAjqKtwFBKdAP+58s8FROU8/bhX/M75t4UCHPAzmI4adkDu8vfbFMR7g+5eD0s26Wda
         jSRq7AwrxWNesOaUEevtwv+NQuX1/pNl/YvxVecq1xiDoQ3DmIlpJVloz9amTTPZei0j
         ff4UT7ew21xq+O089JgXpLJA7LoQV+tYcGmH4Ds/sWhY56PU6TzYStVTxUyhjU2RgO3q
         E1tw==
X-Gm-Message-State: AOJu0YwtxKz9DW8wZvJtxKOfJveQRiU28GGNOdlCtrfMgsI+nvs4JHSu
	Bt30mlYlgb+bxtzcJ8HWrZVuA+iSw9eK6HJJObarFl5SQf/aBCjZFL3fO4NhAmI=
X-Gm-Gg: ASbGnctC1hWbthX+PDAnbUdVEoRuhzm+LF8XgYKjU3Eo0rxoGGb5N04dClT/LS7z/AY
	o5CmhluhGbrJA5ujCVxNWPlMEV/kiMCVsgrBEJlRWvfpC6GrrOrHYCoEB6Hx/yPBYhIIhBgJM9G
	rTSCDYublhVaaGi1Aip3Gq27fcoaUD3tRImv3rubL1uk2m9/Syna8L8vrLKstnB1cLg6VPxe1HS
	ia88BsYqse1oNYJOuNDdsjj1ukew67oxtlypjmhpxC3U+XvxvAa0O3wM1gOJUTxf5syQ6VT0/oV
	/NZn+X21Et2Wv/xu05LPan7AJ2D3JNLh69gLvHn6L0RnYHiJoHkqfUk=
X-Google-Smtp-Source: AGHT+IFn1RRbyMg/82EdQHWJDM6fySYuvESRAD5YIJzAaWoT1EYQ7doQLWKl0VFK0CXtlAmzhAUxTg==
X-Received: by 2002:a05:6602:720a:b0:85a:fd37:1c65 with SMTP id ca18e2360f4ac-85b1cf985c4mr146678439f.5.1741293237713;
        Thu, 06 Mar 2025 12:33:57 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f209df50e4sm529476173.8.2025.03.06.12.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 12:33:57 -0800 (PST)
Message-ID: <cf81280a-fd37-436c-aefa-fba5a4df87f6@linuxfoundation.org>
Date: Thu, 6 Mar 2025 13:33:56 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Implement CPU physical core querying
To: "John B. Wyatt IV" <jwyatt@redhat.com>, Thomas Renninger <trenn@suse.com>
Cc: linux-pm@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 John Kacur <jkacur@redhat.com>, "John B. Wyatt IV"
 <sageofredondo@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20250305210901.24177-1-jwyatt@redhat.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250305210901.24177-1-jwyatt@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/25 14:08, John B. Wyatt IV wrote:
> This patch is also an issue report. get_cpu_topology will always save
> into cpupower_topology a cores size of 0. The code to handle this looks
> like it was commented out, and what is commented out is missing a curly
> bracket.
> 
> https://elixir.bootlin.com/linux/v6.13.5/source/tools/power/cpupower/lib/cpupower.c#L206-L212
> 
> Inspiration was taken from psutil to implement this by querying
> core_cpu_list. Instead of using a hashmap, I used a sorted array, and
> counted the number of valid unique strings. The counting of this takes
> place before the qsort for .pkg as the following code says it is
> dependent on the order of that sort.
> 
> The previous code claimed Intel CPUs are not numbered correctly. I was
> not able to reproduce that issue and removed that comment and the code.
> 
> This commit was tested with the libcpupower SWIG Python bindings and
> performed correctly on 4 different setups. The most notable is the
> Framework Intel laptop; a hybrid system of 4 P cores (8 threads) and 8 E
> cores (8 threads).
> 
> The 4 setups: A 4 core virt-manager VM running Fedora 41 4c/4t (specs not
> listed) was tested as a sanity test for VMs. A Lenovo Ryzen 7 Pro 7840HS
> 8c/16t. A Supermico Intel(R) Xeon(R) Gold 6330 CPU w/ 56c/112t with 2 CPU
> sockets. A Framework 12th Gen Intel(R) Core(TM) i5-1240P with hybrid
> cores.
> 
> CPU(s):                   16
>    On-line CPU(s) list:    0-15
> Vendor ID:                AuthenticAMD
>    Model name:             AMD Ryzen 7 PRO 7840HS w/ Radeon 780M Graphics
>      CPU family:           25
>      Model:                116
>      Thread(s) per core:   2
>      Core(s) per socket:   8
>      Socket(s):            1
>      Stepping:             1
> 
> CPU(s):                   112
>    On-line CPU(s) list:    0-111
> Vendor ID:                GenuineIntel
>    BIOS Vendor ID:         Intel(R) Corporation
>    Model name:             Intel(R) Xeon(R) Gold 6330 CPU @ 2.00GHz
>      BIOS Model name:      Intel(R) Xeon(R) Gold 6330 CPU @ 2.00GHz  CPU @ 2.0GHz
>      BIOS CPU family:      179
>      CPU family:           6
>      Model:                106
>      Thread(s) per core:   2
>      Core(s) per socket:   28
>      Socket(s):            2
>      Stepping:             6
> 
> CPU(s):                   16
>    On-line CPU(s) list:    0-15
> Vendor ID:                GenuineIntel
>    Model name:             12th Gen Intel(R) Core(TM) i5-1240P
>      CPU family:           6
>      Model:                154
>      Thread(s) per core:   2
>      Core(s) per socket:   12
>      Socket(s):            1
>      Stepping:             3
> 
> Signed-off-by: "John B. Wyatt IV" <jwyatt@redhat.com>
> Signed-off-by: "John B. Wyatt IV" <sageofredondo@gmail.com>
> ---

Thanks. Applied and will include in my PR for 6.15-rc1 to Rafael

https://web.git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower

thanks,
-- Shuah

