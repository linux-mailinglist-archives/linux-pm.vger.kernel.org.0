Return-Path: <linux-pm+bounces-15635-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E12199DA4B
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 01:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291C11F21F03
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 23:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAC71A4E9D;
	Mon, 14 Oct 2024 23:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BdwIzKmU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B606146D65
	for <linux-pm@vger.kernel.org>; Mon, 14 Oct 2024 23:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728949758; cv=none; b=Qj9f85ystUpKOyGYiIF8R9U6TVusRFQzv+icBW4ApL5m/4xWuBy+q/aaBaRg/R1DDzdR1zBEbR3amAX6VcwooBu6Y7LdjnZuklI0hvvlgSXinHGN3IGiqTMTG6d/UtsDCCEJOKrNISwH8sz4l3GNUdUHOID1u8dAz1oGMIRM03M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728949758; c=relaxed/simple;
	bh=XkFMW9qqXhz5NcztJxtsGEGFvgG/+6XjquMraVD2O0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lI5eNGmA+vDt9ppFt5sQe3bMM4CqQmFIWA5XDCk6+lmqw9SQu7pnUiZvTL4DoPWHi93F+D67g9cHXuXiEELl7tK1waIM5jsu/Fw372aRd0i+1i0BvRatwqoj+VcTyHBE3+0gSnyoouTCcRPM1UgJ6r7uXvcslHOiJaaFOXy9W3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BdwIzKmU; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a3b8964134so8846075ab.1
        for <linux-pm@vger.kernel.org>; Mon, 14 Oct 2024 16:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728949756; x=1729554556; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rWe6IuexOe+i8ZiAj9oB5+f9OBLjXk23n/ktjCPYH4M=;
        b=BdwIzKmU/SGKbpQEOfjxdjjo7tUqDfL2srO8GdbLxo6iqUu1+0udVNLP4GWPVt2U80
         vgnBpJLjTZnsj4i9ggDFKiImYeQ03f8bV7zH4eQOQm/Snn4TYbigHFEtupT/HkTuD9KJ
         HQW7uQQfFaACbtxmlIs963fx78mMW3d1fXKXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728949756; x=1729554556;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rWe6IuexOe+i8ZiAj9oB5+f9OBLjXk23n/ktjCPYH4M=;
        b=MdQBJJCHJLc8ihzJap3lykCiCY4OrE6awAM0I2wclyALqT53va2kbFDIg+3OyRBGit
         cZYj/YW05dsqGulZyZqhPVDM85ap26D6oyMqC2m60Q3fo2wQ73C4wMCCQZ9N2MbNhczs
         04ITIb6dk81vc963OVdrXoZTjqCF8RQuhCV6DUWCE/rO2EaXinAvRS809ghUa87QZZaw
         jx+lso0Sij81/5VRWQKoz/3JZdhZ/ZKbzrzLNlOI72jDXXPXVd9nKlIFQRpsYCw50Bos
         4zWs6kVsNUo9Rm3Z4qHyvuuVGPEoPU4BaMvUwk1krNTEo5fz10Q7+xO/IHMdw5UThcew
         VNcA==
X-Forwarded-Encrypted: i=1; AJvYcCUjgZGz1xg90TeO7pE25ypumJJbHbqxI5rFz/MvbR2ge7XaSwvWzC4/9R/UbQWPh07KWwBXunhExA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgtTST6tjMIyltBSzd6qqzytyGHU8IrPHifITORAVqRHU0rrE1
	YObs2MIGPEtv/mPuSENRweW0k+wYx213eVmq6+OlPW9gfNFvBkzI1oLvs2UdH58=
X-Google-Smtp-Source: AGHT+IEZ2NSeBe5voVSUCeq2HBwOyBsJZdeZRWIdx0WeoToxCr6cKneZoX9cuIrjRGj9g2KdM9SDDA==
X-Received: by 2002:a05:6e02:2167:b0:3a3:9801:b668 with SMTP id e9e14a558f8ab-3a3bcdccca0mr70458855ab.15.1728949756084;
        Mon, 14 Oct 2024 16:49:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3d714ed16sm386205ab.64.2024.10.14.16.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 16:49:15 -0700 (PDT)
Message-ID: <0ca380e7-3913-47e9-8cde-819ff90223fc@linuxfoundation.org>
Date: Mon, 14 Oct 2024 17:49:14 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Add Chinese Simplified translation
To: Candice Cheng <ap@linuxfoundation.org>, Kieran Moy <kfatyuip@gmail.com>
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240522165745.76561-1-kfatyuip@gmail.com>
 <1f4dc3b7-f05d-487b-b22b-5f0c37921672@linuxfoundation.org>
 <ae0cf2c8-4e90-4575-b69d-67234ea47dac@linuxfoundation.org>
 <CAJ1P9G7BGo0NOHxAc3xX63PR+W2i=4mXvi2fkV8+eOmpS6eOvw@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAJ1P9G7BGo0NOHxAc3xX63PR+W2i=4mXvi2fkV8+eOmpS6eOvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/14/24 10:25, Candice Cheng wrote:
> Process Core C3:  处理器核心 C3 - changed to 处理器 Core C3
> 处于睡眠状态的包: changed  to in sleep state.
> 
> PS 包 and 核心 are confusing Chinese people. Everything else is understandable.

Thank you Candice.

Kieran, please make the suggested changes and sene me v2.

> 
> On Mon, Oct 14, 2024 at 8:31 AM Shuah Khan <skhan@linuxfoundation.org <mailto:skhan@linuxfoundation.org>> wrote:
> 
>     Hi Candice,
> 
>     On 9/30/24 09:35, Shuah Khan wrote:
>      > On 5/22/24 10:57, Kieran Moy wrote:
>      >> Add Chinese Simplified translation for cpupower
>      >>
>      >> Signed-off-by: Kieran Moy <kfatyuip@gmail.com <mailto:kfatyuip@gmail.com>>
>      >
>      > Sorry this got stuck in my Inbox.
>      > Adding linux-pm
>      >
>      > Also I would like Chineese speakers in the community review
>      > and give me a Reviwed-by - any help is much appreciated.
>     Thank you for offering to review the patch. Please review and
>     let me know what corrections need to be made.
> 
>      >
>      >> ---
>      >>   tools/power/cpupower/Makefile    |   2 +-
>      >>   tools/power/cpupower/po/zh_CN.po | 942 +++++++++++++++++++++++++++++++
>      >>   2 files changed, 943 insertions(+), 1 deletion(-)
>      >>   create mode 100644 tools/power/cpupower/po/zh_CN.po

thanks,
-- Shuah


