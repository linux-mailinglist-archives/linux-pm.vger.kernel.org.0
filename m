Return-Path: <linux-pm+bounces-7494-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B94018BB5BA
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2024 23:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAA4E1C23003
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2024 21:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0CA50A9D;
	Fri,  3 May 2024 21:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dY45nWTJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90542364AC
	for <linux-pm@vger.kernel.org>; Fri,  3 May 2024 21:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714771816; cv=none; b=jboQjWFHiHa43q0Y8HEO1tNwjfnSZfrpwO6LZaaQR63T5Ju8/FozBolkVnaagGsiGCjkz+7jo2/3Haczctad7F9Mh68ZkgvJ3DxgvQhcGo93SEqTSg1z9kPCLLahS7DQjcFbcavvX5y0aCl300Kk+a0IyIbf2nprbFGhasTXV7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714771816; c=relaxed/simple;
	bh=fIV+IX4YE64LwrO6YWhRdaO/MjqE8ywgWpY3DUcU09I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Prma2n/xC7uu5tHM0c1769OR1nYfTb4h6YpnVAIlRYs+igEja2JmloTw9huCH1qpWUJA9wcbc5BXDGy03A1IG7WXzvU7sYIm6rLGl3ZGRCgXX66EE1TtYbPv5wzGsXudu/d+UODVWwLdidTEIW1VDbHy1LD9cTTBC/dphfwjPrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dY45nWTJ; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7dec9c65057so1053239f.1
        for <linux-pm@vger.kernel.org>; Fri, 03 May 2024 14:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1714771814; x=1715376614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V/F4Suyza/xWLquouauOO0XmH9wyukv551dmgnASnow=;
        b=dY45nWTJ8AxtgrBwNDMBAPWtN2ucsT+S7rxaTGjhyzq6FKvz5CcRvoEhXYdf24eBeo
         qCHE0ZxaeR9BisMv4UlcHXXmOhidBTSfylPBYQ9W6q31NePz3vNQODP4GubIDzjNUasY
         EyHhgZWA/AgFHp4k/rqcdpcXsQ3a8Ssf4ldoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714771814; x=1715376614;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V/F4Suyza/xWLquouauOO0XmH9wyukv551dmgnASnow=;
        b=svAT8LVu+4fmC3P81ocBg2ApPoGSgwWcUHeFwTI5kgABOJpo7YuSalEAKWqbcT6Yr9
         mtRb5Hm2fppY0SgB9GkChbJBoSHpe7f3uUDyjIpmtep4k9dbqFNWIObOVXpGmgQKjLsq
         9OxVPVF42qVRixLJeGDlsl9k75oObMCi4U/D7XENda0BRSnO7NyOlQjB3Vm+Wdu/mxdO
         xsKaOPcRad+IDFuJ+9101zHysm8kymRXzM/rwGmuqfDBPSyVVkCVLleAt+NHPKc1eig9
         mkna21KnXhmYxdft/JXsiR+9fBjESJn/cISRp2RQdQdDLdVwMHFvZ9rVf54156Ah29Zq
         Be/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW5bMyNgC6iOUHXlXB7TYyBXWrwhPGnXS2y97R9VKBLCShXAaq6wnhwEcPjt4vZqmaVip2HY4Hw0nkJF23BsTLdKMJakAQcYBw=
X-Gm-Message-State: AOJu0YyEYI8hdODHDh+4IXKBHbWb1lIwrZCuS6Yr6A2BSwnrmO56ZaXM
	/2Tdn3tqsQVzmryN6/C280T87ZAWlsdWcES6Ga4mqGmWf4Mmf8A1N6ZKFV7Pr9g=
X-Google-Smtp-Source: AGHT+IF97T8DUzny4+6yRfgfzpJ1WVn/a+MScGHa0ZdiMMEjGeTQLuH/luQzwcoJpMrD1IqWrHvhIQ==
X-Received: by 2002:a05:6e02:1b0a:b0:36c:5440:7454 with SMTP id i10-20020a056e021b0a00b0036c54407454mr4709227ilv.1.1714771813693;
        Fri, 03 May 2024 14:30:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ix20-20020a056638879400b00487cf11342fsm991920jab.102.2024.05.03.14.30.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 14:30:13 -0700 (PDT)
Message-ID: <d8723cb7-7296-43a3-8647-df446c57396b@linuxfoundation.org>
Date: Fri, 3 May 2024 15:30:12 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: exit() callback is optional
To: lizhe <sensor1010@163.com>, shuah <shuah@kernel.org>
Cc: "grygorii.strashko" <grygorii.strashko@ti.com>,
 "viresh.kumar" <viresh.kumar@linaro.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 torvalds <torvalds@linux-foundation.org>,
 "gregory.clement" <gregory.clement@bootlin.com>,
 "grant.likely" <grant.likely@secretlab.ca>, bsegall <bsegall@google.com>,
 broonie <broonie@kernel.org>, bristot <bristot@redhat.com>,
 brgl <brgl@bgdev.pl>, "f.fainelli" <f.fainelli@gmail.com>,
 "fancer.lancer" <fancer.lancer@gmail.com>, festevam <festevam@gmail.com>,
 Finn Thain <fthain@linux-m68k.org>, rafael <rafael@kernel.org>,
 linux-pm <linux-pm@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <b97964653d02225f061e0c2a650b365c354b98c8.1712900945.git.viresh.kumar@linaro.org>
 <5759bc29.32d04.18ed0ef5037.Coremail.sensor1010@163.com>
 <20240412062407.ntahibzv6xsbrnxs@vireshk-i7>
 <1b53a162.32e95.18ed0fdb13e.Coremail.sensor1010@163.com>
 <20240412063246.tk5z245miakbxws4@vireshk-i7>
 <2117690204.533771.1712904398042.JavaMail.root@mail-tracker-145-3ep34-c9h23-5f64cf7787-82gdh>
 <2024041212-bony-emphasize-75dd@gregkh>
 <663acff5.349d4.18ed18da6ff.Coremail.sensor1010@163.com>
 <20240412092108.xuvrfd6ioszltonf@vireshk-i7>
 <2024041259-ranking-aeration-29f8@gregkh>
 <28e13fe5.bc4.18ed2962985.Coremail.sensor1010@163.com>
 <1209348234.554742.1712932905664.JavaMail.root@mail-tracker-145-3ep34-c9h23-5f64cf7787-82gdh>
 <6e72f357-f944-4f0f-b74a-587de5780a78@kernel.org>
 <5c601757.54f80.18f05956113.Coremail.sensor1010@163.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <5c601757.54f80.18f05956113.Coremail.sensor1010@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/22/24 05:33, lizhe wrote:
> The maintainer's obvious robbery behavior.
> I submitted patches to the main branch. After receiving them, the maintainer submitted patches again, and the patches contained the patches I submitted.
> That is to say, the patches submitted by the maintainer included mine. It is the maintainer who failed to follow the rules.
> What's wrong with me submitting patches to the main branch according to the rules!
> 

This is the last email I will be sending to you. It doesn't appear
you are willing to engage with the kernel community in a productive
and constructive manner.

> Refer to the following document to understand the process:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst>
> 
> Refer to the following Contributor Covenant Code of Conduct to understand the
> code of conduct the Linux kernel community abides by:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/code-of-conduct.rst <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/code-of-conduct.rst>
> 

-- thanks,
Shuah (On behalf of the Code of Conduct Committee)

