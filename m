Return-Path: <linux-pm+bounces-12050-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E64994D4D1
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 18:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D28CB231B6
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 16:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAF23A27E;
	Fri,  9 Aug 2024 16:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HlrYeJJC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DAE381AF
	for <linux-pm@vger.kernel.org>; Fri,  9 Aug 2024 16:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723221403; cv=none; b=I7h/OJSYIZE/cKhXzqRtoM//dZEUzRm7F8gq/i2U5F7ZS9KTrIKYWYGGyCH9122I+AolErB6ir6TVRDCc9B7+3zmdaj9haB5yvIaxB9HsEP8lNnEvP+DF0cm3pzyI2i39Qvl62DQm+jN/VMoInvuVaFhtNhgjQ6tRQ482yosmoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723221403; c=relaxed/simple;
	bh=zY/8itV5u7Zbi/hEhQbzkrvJ8pPSgHSXqx+XCgQOgLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fKqe/kkfjU09bOQqlm5TsqN8XDC86PyT2axbp0Wt6LfkYr5jZdgIzk7fJiqC/QDFqW27npwMPcQfMtSK5FznAX3YmhX0C5Z2Rf4zKvEKdumn7jAt0Vyp9JaJ67TegzrqwF1q/c5tXkVcoEpkDOkRtvHQn3DRxDoIQomnijcGa9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HlrYeJJC; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-812796ac793so8143839f.3
        for <linux-pm@vger.kernel.org>; Fri, 09 Aug 2024 09:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723221399; x=1723826199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mk8/V5VvYKUUaqepxZuKi5bDsdYGJmCv7TchI+3iYzU=;
        b=HlrYeJJCcCJscOodG9Yd2NRVQT1rymjkv6AuYm15WBKkx/7HcK9KiZYQbemsK8zEFK
         pzqlA2IiM/CVuzyqkMKntR4q4XGmWOkQG07Fsb4lYhus4+Xsr5fUBWscYqEStniqPhQn
         qUgMgB06u6A8BPB6vnhs+mmwv0zEIS0dh0FFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723221399; x=1723826199;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mk8/V5VvYKUUaqepxZuKi5bDsdYGJmCv7TchI+3iYzU=;
        b=V3SB6v1Hmw/hzahbCgAOd7/GD4Olg0l4WWFCOIwRNKMte01IvNMz85KUxccV3zaTVB
         WKrD8LJu+x6F2gzhByFZyOY2hQ8PiI9/Hn3/9M16B12kaTrv+NRlkM5z/NlibzulExV/
         fKwmrmXly0QbNL/tKENZ0ijGfoZfP0yMPTXFykqGlDr7jPkyBnjHlUZufils7gr106M0
         NBJYbjW1cUmrAjpAL8h+5sr3FIBAm1FSbvUXN4iJjSfScuamgYQ85ViMEr5UFfw+cWGP
         U+mNRB6ZFr3nz7OtfZauZzt8Xj/0O9DRcmRuzjOk1NYQ8cMCT9naOlFqsUQMrt6WNLRw
         48DA==
X-Gm-Message-State: AOJu0YxXKia6KjHm86KJCLwbL9TBqu3N8h42mhZw1hCaTgogljbH0aLg
	Z/z0jnBG1mPDZsJc4g+dO5hoacw4Di50A18ixlSqDa8hwVzhrq589wxyJaZp5fA=
X-Google-Smtp-Source: AGHT+IFR6EVMUI7ff1OO3hN3QKy6sTmT86zcuY54L/tltPb7i1I7uyd1RNCpT7vnEDUA9elpgyZ/vw==
X-Received: by 2002:a05:6e02:1aa9:b0:39a:ef62:4e96 with SMTP id e9e14a558f8ab-39b86f8553dmr15608265ab.4.1723221399555;
        Fri, 09 Aug 2024 09:36:39 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39b20adfb97sm65561995ab.65.2024.08.09.09.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 09:36:39 -0700 (PDT)
Message-ID: <3670ea66-a72d-4fa0-b0fb-c0ec408d2ba7@linuxfoundation.org>
Date: Fri, 9 Aug 2024 10:36:38 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tools/cpupower: display residency value in idle-info
To: Aboorva Devarajan <aboorvad@linux.ibm.com>, trenn@suse.com,
 shuah@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>
References: <20240809083728.266697-1-aboorvad@linux.ibm.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240809083728.266697-1-aboorvad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/24 02:37, Aboorva Devarajan wrote:
> Update cpuidle tool to display the residency value of cpuidle
> states. This addition provides a clearer and more detailed view
> of idle state information when using cpuidle-info.
> 
>   --------------------------------
>   Before Patch:
>   --------------------------------
>   $ cpupower idle-info
>   CPUidle driver: intel_idle
>   CPUidle governor: menu
>   analyzing CPU 28:
> 
>   Number of idle states: 3
>   Available idle states: POLL C1 C1E
>   POLL:
>   Flags/Description: CPUIDLE CORE POLL IDLE
>   Latency: 0
>   Usage: 7448
>   Duration: 207170
>   C1:
>   Flags/Description: MWAIT 0x00
>   Latency: 2
>   Usage: 7023
>   Duration: 3736853
>   C1E:
>   Flags/Description: MWAIT 0x01
>   Latency: 10
>   Usage: 18468
>   Duration: 11396212
> 
>   --------------------------------
>   After Patch:
>   --------------------------------
>   $ cpupower idle-info
>   CPUidle driver: intel_idle
>   CPUidle governor: menu
>   analyzing CPU 12:
> 
>   Number of idle states: 3
>   Available idle states: POLL C1 C1E
>   POLL:
>   Flags/Description: CPUIDLE CORE POLL IDLE
>   Latency: 0
>   Residency: 0
>   Usage: 1950
>   Duration: 38458
>   C1:
>   Flags/Description: MWAIT 0x00
>   Latency: 2
>   Residency: 2
>   Usage: 10688
>   Duration: 7133020
>   C1E:
>   Flags/Description: MWAIT 0x01
>   Latency: 10
>   Residency: 20
>   Usage: 22356
>   Duration: 15687259
>   --------------------------------
> 
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---
>   tools/power/cpupower/lib/cpuidle.c        | 8 ++++++++
>   tools/power/cpupower/lib/cpuidle.h        | 2 ++
>   tools/power/cpupower/utils/cpuidle-info.c | 4 ++++
>   3 files changed, 14 insertions(+)
> 

Thank you for the patch. Applied for Linux 6.12 to

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower

I will send this in my PR to Rafael.

thanks,
-- Shuah


