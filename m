Return-Path: <linux-pm+bounces-20389-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B01A0C589
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 00:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E9C77A3E22
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 23:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FE91F9ED5;
	Mon, 13 Jan 2025 23:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aeAMysrp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DE51FA147
	for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 23:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736810255; cv=none; b=S10W/QQHIkyLSjA0lElhefuZORf2GPy5YR/MSOEPZhOKYS3/HwNg0z7815h8cWcgWN3HKgCSke3c4coXtkZ7qP4NYHJdQ+V+STt0NpEURGX4JWvKNbveaSlEKwux3rUAeWtJmpO1pSAMexFsn6uQ97mJh3FBwj6Ke7BGZ3LQ4mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736810255; c=relaxed/simple;
	bh=qPX4NOXivkgZqAUJdD5VQ/MAz22rnvckLXVL0wdW4yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aPl8j2zC5b99bcGbBhN79TRHT4BeSWi6fFKUMktyA1OhazNXIMC2tVi9BKcBXJAvSg244sd7rs+JNitIreaB+rCxwoDP1wdc7XM/GFsk2AwhtuPE6u+ZOtnK5ku7IPItLTDPSt6zSbyGgmgP35+5UuEwkF+akzBrnAk1CmWkuPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aeAMysrp; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3ce7a33ea70so2103745ab.3
        for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 15:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736810253; x=1737415053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iEdzZpzV6rr1LZH/PIcj+RyNfCE1psWSlxwq+r5ywyo=;
        b=aeAMysrpuw9gBdX/nKFzTDD3KTOFkSnbRuWyo+iLrRniyeAVi3Y/zOlikAwcq6ei5q
         t6PGwjUHyrOMZA3KFfxbVJuxaK7XDzYV9KYlMVTID7hlQnvB0NPnct2I4jdLpHw/vLE4
         IF6agBTv5fCicBsxWBOe+G9DTq9PLRALcANN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736810253; x=1737415053;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iEdzZpzV6rr1LZH/PIcj+RyNfCE1psWSlxwq+r5ywyo=;
        b=ZgHqWzeXTAUKWCnuJjIEodCP435y1J2w56IVIoQ+PKEucw7hgRhRxDF9uFZN1Ia93H
         Di7ldN25oVS0RNxCb8cUY6Q3Rs58Q9n+PI61GFuEwzz9DyeN39owwyZiuPXUTAbxTRPW
         RI4Obnunc38NtrewRXGMaEiPviTPLHp8bIDwYkGxrHrB3Q0j7vkWrc2mWWvWZSQmFFng
         eywQAS6YzydiCHIB9E/Esh8wpF4KuwNrGwN2XIkbpc1VhFbTBuqOUOhEurnn1XZ3gGR4
         swf6N788Zsh4ZUa+W4UeiYcR6lVxDVUpidE6EuoqOh8uarDAyPK5HC4E0SQf+2tyrBYc
         ZtqQ==
X-Gm-Message-State: AOJu0Yyphb3Yzf+MG4IFNIQhD30SzLvEWiDqfvZQJDJJFUcOkdwf4Q98
	70ubGurLJqH6dtj4xxgJ63flHlD4hwmlPlrhjZA1V1TH6OzICOdF0EUDZs4DtK8=
X-Gm-Gg: ASbGncseCFHyAnX/M8kfnRVltohe95yubRUKbNSX1j2DbmaLQOXG/Y3PEdT4Fyo/73S
	1tHy7zDBKw1AxhuPpAv9tKNxybjOUYn7jyV+ev9SYLtyDbJLRLFTLwLIUQTol46MpSBT1dZ6Wil
	2WVk76rDHDLVGpuBiI6WEKQCb+sJyTr3j1Itx6L7db6AHyNf8s13NG336mT8jjYhZeUwVil+lC2
	b5JRqJ9Bj7A7vyuFkNeQdfgP07eo9fmojSIGAmM2QDwXGQ5w1OQgvPKewEBawgnwYY=
X-Google-Smtp-Source: AGHT+IF71xVPwLt/tNHScneYWb0ep3+5IPFikVnLdKq0wK0b1mb4MqFIy6oc9sLOBJSHBclWoHOj5g==
X-Received: by 2002:a05:6e02:1a2b:b0:3ce:78e5:d370 with SMTP id e9e14a558f8ab-3ce78e5d557mr19352445ab.12.1736810253037;
        Mon, 13 Jan 2025 15:17:33 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b7463dfsm3053989173.140.2025.01.13.15.17.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 15:17:32 -0800 (PST)
Message-ID: <03f5eb31-32b3-4dee-934e-05bc0bb0eb06@linuxfoundation.org>
Date: Mon, 13 Jan 2025 16:17:32 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pm: cpupower: Add missing residency header changes in
 cpuidle.h to SWIG
To: "John B. Wyatt IV" <jwyatt@redhat.com>, Thomas Renninger <trenn@suse.com>
Cc: linux-pm@vger.kernel.org, Aboorva Devarajan <aboorvad@linux.ibm.com>,
 Shuah Khan <shuah@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>,
 "John B. Wyatt IV" <sageofredondo@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250108221852.30771-1-jwyatt@redhat.com>
 <Z4UdWpRie1ZsJ4tk@thinkpad2024>
 <4f4ad06c-b2e4-4e3b-8ec9-85cb81e61ae0@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <4f4ad06c-b2e4-4e3b-8ec9-85cb81e61ae0@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/13/25 09:36, Shuah Khan wrote:
> On 1/13/25 07:04, John B. Wyatt IV wrote:
>> Hello Shuah,
>>
>> Did you have a chance to look at this? This is the second header change
>> that was missing from the bindings.
>>
>> On Wed, Jan 08, 2025 at 05:18:44PM -0500, John B. Wyatt IV wrote:
>>> "tools/cpupower: display residency value in idle-info" added a new
>>> function to cpuidle.h. This patch adds them to the bindings.
>>>
>>> Link: https://lore.kernel.org/linux-pm/20240809083728.266697-1-aboorvad@linux.ibm.com/
>>>
>>> Tested by compiling both libcpupower and the headers; running the test
>>> script that does not use the functions as a basic sanity test.
>>>
>>> Signed-off-by: "John B. Wyatt IV" <jwyatt@redhat.com>
>>> Signed-off-by: "John B. Wyatt IV" <sageofredondo@gmail.com>
>>> ---
> 
> Yes I did. Looks good to me. I am waiting for Rafael to pull my PR
> to apply the patch.
> 
> thanks,
> -- Shuah

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower

Will send another pr to Rafael later this week.

thanks,
-- Shuah


