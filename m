Return-Path: <linux-pm+bounces-11407-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DCC93C6D3
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 17:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCE10B22549
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 15:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA04619D89C;
	Thu, 25 Jul 2024 15:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N6ihvnkY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4788919CD05
	for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2024 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721922744; cv=none; b=L+y8IN99YeXXl397xIxufOhIZU0ekG7Jzxle/7xFuJhbymFxxnnKWOrkNIkKGmqd8bVas0UAg6p9bbUx5D+VPHC6wOqUNBOzqJGSZjJew7sLlEGOERKHH5lrghhV1MmjmeeRUUUN7BrQu9mEM2+MvIhHTF5pktGB+D8xVmIm6Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721922744; c=relaxed/simple;
	bh=mo7q2/uoC4GEhq90NIoOuGRylVoOtZelBxC1FagUlWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sQZOqao5osC7rOQeyrndvP3In+vhxnROPzPIaUyvMHrjm4F6ZlTnjZre+GmGat65mqbt/Snh0pPN3K3VCwLCo3K6RNcV8uFd9JMoLdQ6RcNPnLV0RKksSzLv9PNsZ8btm0KLWaYwoYLOiN3pFiTTSRF2NcTzoJqyLJXakKZXmak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N6ihvnkY; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-804cba4c8a8so2122439f.2
        for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2024 08:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721922742; x=1722527542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S/JqN+pHcExrSb356L3vtrB44/14O6YEZAAfNBlaK60=;
        b=N6ihvnkY4Am59VPON1UN6LEMi24lWBE5RJJWPIFDlYZSFK1Yb8TrB9RAk+si5NwnEm
         TYfv71WxMUFC2K+/Sj52QIrktwCao72aJXxaJr9wJcXF+ywVXGtT6gd1kTEUTmK8dKXr
         GxStFdjaGWjyT5sZqAxe3Kl3CRRofwxvT43Yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721922742; x=1722527542;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S/JqN+pHcExrSb356L3vtrB44/14O6YEZAAfNBlaK60=;
        b=EGqfExoKxGOzqKEqmoPgPwmHGBUP1qFl2bLYN2IWLXpEuQMRScg12TZcJ+/FC3U0wE
         7sG4fnvqNo2s4Exnyu9Lt5AcUN14pz+Q4FCfund/ZeNn1r0BUWPej1URLG+OMerf8vZ2
         vcSe6bSh3a5bI8/H9Us8dzHE8XcVQEk/vlI0vKyH7poicyzUYgHRTsUTLmYb2E7HmrHr
         K0yEf/k1D7rt/dkwHYeHZPcDazkCJiy/jU3FcyfBGx2yzWKNVv6n0yEsMLpSF5uYz7f4
         w/qQjgayyuUryP9MA5kxuFkVFk1Ll42pNruiuyBONO0eS4MffyR5yH5ct+7PuzACpUOI
         FqnA==
X-Forwarded-Encrypted: i=1; AJvYcCW5Ev4Txt5MpbW/Cf751KO8KOkpQIEA6zSPpEFL1ldr9sGdJH3GjEK1NPWrfUjR2hSlanpp91PXpw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdV9IGUWhy7Ffa68BjWoAS4AxiXVsHcf0/N/3aylW9vhhBvgu1
	5BQ/knWJXVffBO4oV07QAc2Q5QNiCkaeEo6IdutBq1SFCmyuTXotGzfOmNM/suY=
X-Google-Smtp-Source: AGHT+IEqVp/oG+/InFGTAhbwWhUAvE4/fcFF2CC3JSSKpBgRYqaeQfyRqJFHexKt4gYsGUq+GQmjdA==
X-Received: by 2002:a5e:df47:0:b0:7f3:9dd3:15b2 with SMTP id ca18e2360f4ac-81f7cf031bbmr207094739f.0.1721922742449;
        Thu, 25 Jul 2024 08:52:22 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fa43ec2sm392272173.11.2024.07.25.08.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 08:52:22 -0700 (PDT)
Message-ID: <5339a20c-86e4-4829-bad2-2b998c184523@linuxfoundation.org>
Date: Thu, 25 Jul 2024 09:52:21 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kselftest: cpufreq: Add RTC wakeup alarm
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Shreeya Patel <shreeya.patel@collabora.com>
Cc: rafael@kernel.org, shuah@kernel.org, linux-pm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240715192634.19272-1-shreeya.patel@collabora.com>
 <20240725035742.uahab5uf2kmv476g@vireshk-i7>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240725035742.uahab5uf2kmv476g@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/24 21:57, Viresh Kumar wrote:
> On 16-07-24, 00:56, Shreeya Patel wrote:
>> Add RTC wakeup alarm for devices to resume after specific time interval.
>> This improvement in the test will help in enabling this test
>> in the CI systems and will eliminate the need of manual intervention
>> for resuming back the devices after suspend/hibernation.
>>
>> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
>> ---
>>
>> Changes in v2
>>    - Use rtcwake utility instead of sysfs for setting up
>> a RTC wakeup alarm
>>
>>   tools/testing/selftests/cpufreq/cpufreq.sh | 15 +++++++++++++++
>>   tools/testing/selftests/cpufreq/main.sh    | 13 ++++++++++++-
>>   2 files changed, 27 insertions(+), 1 deletion(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

Thank you. I will apply this once merge window closes.

thanks,
-- Shuah

