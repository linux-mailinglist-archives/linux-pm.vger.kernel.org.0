Return-Path: <linux-pm+bounces-20061-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8760A04B22
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 21:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97FDD16524E
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 20:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D54194A75;
	Tue,  7 Jan 2025 20:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JDO6CzxH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DF51F63F1
	for <linux-pm@vger.kernel.org>; Tue,  7 Jan 2025 20:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736282327; cv=none; b=X5ith+bOKo4iRPIi65DvcwLYlPWJQiWypOHN5ynn62OiPU3oQqaqCtSCiWFBrTOUF/cf+jw8Zt8ZEtH4tJLscVcBT0NR0PmyOmjqyzaN+V1pwfhmPZb3DiERshtHoG5897lO9pyc4nQA87y/cw6WgbyOyWqj9ew8qT+q85FlWiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736282327; c=relaxed/simple;
	bh=e8WQ39Su6ky7skUv3PyuvKeIr5tlC26nKHLRUgnNraA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LKcGT7QJw6/AGW/buwcWDbn5DtRAx4Ir5vK0oxfdhtqElnA/YJaz0XnSkMmdPIQ7Su12aSfV+LFUj/A5aukppm+cWc7KjlXXFoqBwzQYnlTVBnoQO59ebpp831MCpQgbaK2a05ScZQY7V2K7MIOV9YjQ/Xs/ZJdiQdq1r/rcqmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JDO6CzxH; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-844e9b8b0b9so1250715839f.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Jan 2025 12:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736282324; x=1736887124; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uzbso2+ca1pLZqt/93l4QqoXiGatRJPC5SsTzTNGAHI=;
        b=JDO6CzxHd7Uu40+EFRtDfynvvtoiGClZr4WFDnmq5kRF8ThTTpxttSq23n4PgdrCWf
         wYBp+S3Wsl0ozYoPt5SoUyfVzGidCnMqrLJaaUQaxK4IBLSPi3hGj1pYQ832pvTPhQ7Q
         LYqFJq8o+1fapLbyD/K5Oc11N3tusOB3S3lOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736282324; x=1736887124;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uzbso2+ca1pLZqt/93l4QqoXiGatRJPC5SsTzTNGAHI=;
        b=GL2wgS+yDrI2OnfcV03WH/iMl1Tw/lAg9+Wo4mJKaDLi2b7/c7dDdu+1Z9E5CDX7Bb
         IuW52QIoeOyNDB8p4h1J+TMwXG8lrqCepaDH2WbMRRoeasExP+tJtb9N9d4YIUi+wYlZ
         aJ89P8xLfaklYftZlWwMuAasLZ7h5D4m0fg/y7D61eWB2Zb6d0ps0Te9SPiLkIkaJtm1
         VLKSFJaFdL5m/sUDBDWTJSwjiTsIXaFWbUoKAvC8Q5C5O8GHUHkuizjJi8Q5YC6ijQpz
         JhKvC9sUAIYdF9QkZPwvFd/6UyOcyz7eAdhj4ynZH7y8pWpPnZloWL9HTAf9uS582MfV
         XqtA==
X-Forwarded-Encrypted: i=1; AJvYcCWnLwZIrBngs+KF05xun/JZ+MXw92RbZi7Xsh8QU/plco7585tvpE/NhMBXDuD6D5e3zaqXyCveLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEEVmW5EMvisQxHYXKRB/3sAKDgOvYfEiqb17itTHAN6C3E85d
	b6N5HQezHXl7R0whGnDNHpoX5DnnYD7cf8XJtJ07F8ukWpy4Cih0mr/4HcMQhqg=
X-Gm-Gg: ASbGncty2LYWQY/DGDZp7RFHywHx0ApTmm+N000jT4NyoLu5l7NyudCw2IpiC3l02zZ
	GbrEAty1wUqc7q1qOmy5YmX47fgK4yp5OAFUXA/YSAYdhS5dtxAYVpyZEncpVzXKkVFQjbK1DHQ
	mSstCX/u+IsrIAw0ZhJK/Nil894MKksHtFZIdjoO4cJQFskOvkMJZsRRBZyx9X1SylTVocavIuF
	CE9QoQQJiPLMzJTrMVSBaZmnr5izl5AH0TwGCy7nNzKBoMMC7bWlVngQipL5YHdCcse
X-Google-Smtp-Source: AGHT+IHjFkhumWPxo4w0OFqZx0FKT5AXj10ENPl5LhQhojTdBUyruRJpYRD7p7bnN0WrZq9CT3z5fw==
X-Received: by 2002:a05:6e02:1488:b0:3a7:a2c6:e6d1 with SMTP id e9e14a558f8ab-3ce3a93a83emr4414725ab.16.1736282324344;
        Tue, 07 Jan 2025 12:38:44 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3c0deccf34fsm103978225ab.30.2025.01.07.12.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 12:38:43 -0800 (PST)
Message-ID: <f727eb90-4ed9-4d8d-856c-2de526d97795@linuxfoundation.org>
Date: Tue, 7 Jan 2025 13:38:42 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pm: cpupower: Makefile: Fix cross compilation
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>, Peng Fan <peng.fan@nxp.com>,
 "open list:CPU POWER MONITORING SUBSYSTEM" <linux-pm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241129012006.3068626-1-peng.fan@oss.nxp.com>
 <ae5eba41-e2ae-48c4-b25d-daece4d329ca@broadcom.com>
 <16615e97-268e-4daf-a991-6cad7803ac16@linuxfoundation.org>
 <3b55d23b-aa37-4187-9649-aef663ee1de8@broadcom.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <3b55d23b-aa37-4187-9649-aef663ee1de8@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/7/25 11:56, Florian Fainelli wrote:
> On 12/9/24 16:58, Shuah Khan wrote:
>> On 12/2/24 10:12, Florian Fainelli wrote:
>>> On 11/28/24 17:20, Peng Fan (OSS) wrote:
>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>
>>>> After commit f79473ed9220 ("pm: cpupower: Makefile: Allow overriding
>>>> cross-compiling env params") we would fail to cross compile cpupower in
>>>> buildroot which uses the recipe at [1] where only the CROSS variable is
>>>> being set.
>>>>
>>>> The issue here is the use of the lazy evaluation for all variables: CC,
>>>> LD, AR, STRIP, RANLIB, rather than just CROSS.
>>>>
>>>> [1]:
>>>> https://git.buildroot.net/buildroot/tree/package/linux-tools/linux- tool-cpupower.mk.in
>>>>
>>>> Fixes: f79473ed9220 ("pm: cpupower: Makefile: Allow overriding cross- compiling env params")
>>>> Reported-by: Florian Fainelli <florian.fainelli@broadcom.com>
>>>> Closes: https://lore.kernel.org/all/2bbabd2c-24ef-493c- a199-594e5dada3da@broadcom.com/
>>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>>
>>> Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
>>>
>>> Thanks!
>>
>> Thank you. Applied to linux-cpupower for my next full request to
>> Rafael.
> 
> Since this is a bug fix, any chance you can fast track that change so we can keep on building that tool in various environments?
> 

I am planning to send pull request to Rafael later on today.
It will be available in linux-next once Rafael pulls it in.

I don't think if it can be fast tracked with the vacations
and holidays for the past 3 weeks or so. The best I can do
is getting this into linux-next

thanks,
-- Shuah


