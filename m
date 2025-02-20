Return-Path: <linux-pm+bounces-22562-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D947FA3E2FB
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 18:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC9797A9878
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 17:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFACE2139CF;
	Thu, 20 Feb 2025 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ci02DAWs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627B12139C4;
	Thu, 20 Feb 2025 17:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740073591; cv=none; b=pFUxkPmJgb8VY72xK0PGnF1eZvzErJFYIeLf94r/raTPEhbJA1ot9/pv9WOY9W+ai/KaJfHUIM1WcmyoHUT0Dl/PfScH0nmBFsr0FobICOZdUC0lao72W79H6iqWbad67ZoD32mDGV4BgeLt98mVWn1XJwO01nczq1q82i1kq7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740073591; c=relaxed/simple;
	bh=WTF4cLVsFmMS7choUjpmO9g9zNpFg3WXY45q8MWFYHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rj9sQsCcUVlPDjKksNnTX9iXvP8sxgh+jTih5t0uYKVdeKf7sqXyHaEjfFGM0U/c8qwaXij2kusOaTLzvEIbO3F9MM5qY8j9Z5iI9monUPVO0X/Aek7sjtBkVC+dlqTdTgtYrf9BACHSqTsL32UlKDtzHku4uBy3i0xnbPU8WnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ci02DAWs; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2211acda7f6so26051485ad.3;
        Thu, 20 Feb 2025 09:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740073589; x=1740678389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TWAfEwgjW5n0g7O9PngxJaYTzxQet9B6fCRYbNkTchI=;
        b=Ci02DAWsbdCMtTR35UJRdiheV5lxZe8vXRjWwMqC9SnHHOxHIBY+45UdINMbRE4YDu
         PxoygAuFcVL68FZYYUBueykgGTvD3UHXJtUQbk6pWtDSEs3pPj930qmDnL/WM7ULVPWx
         KQSonnEmwhaPDEBtZ72+FMyYE5LcTeFjuokkQofznvhGJ/1m3eTxoc/RvsqDLSuN5YoC
         2CRV3tiF1Vmci+bkvnC6wnLj2PVzOVmQGxKcCkO691cM9JIs0qUL3ja1Mm4GJ+W8hV/9
         tOdOavOXqvZ3rmt8pXiTfP8RIT+ca5EagI8cpzdtIulq+BizisZWG5yGwE7oZ8fdSRUi
         O2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740073589; x=1740678389;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TWAfEwgjW5n0g7O9PngxJaYTzxQet9B6fCRYbNkTchI=;
        b=PEi67pQT+DUO7cqKdoksZqb60dCFlvKfywluiLkFDjyVdeqvR8sSeg9GyB3thDzSEb
         E7+0wpjR5bOfT2x2/1vVBDxa/nfaujF6SkWJhPMbW3xh7B87a8kM87/LSZvwim9RzYW7
         kfUHgrU9dCH/AaPy3oJGN8T1UUsrSEW9hWiLnuXsmeh5J/C9FMp+ZD8yO81kNswzW6Rv
         gR5pXcrw2lkSSL79wVEJTp5U+r8JBmvnshIE263LEdrwwYzWQCwFQ9QEp+DvtuHdpQTO
         PYhz15vRncykx4MjmutcKOBw8GNbmVQCBQHEfDg/7Io+2tQqU/YXO8TqJWEJAJFfLEYC
         DHGg==
X-Forwarded-Encrypted: i=1; AJvYcCVAwtiyyhqlelFzmTS9ZxNWtnKG2jv1iH+Awbq+iB3b1RHKYHYqtSup+XWOtpX+fcCaV2X0+zt6s8k=@vger.kernel.org, AJvYcCWJ/4h/Uhj+j2otFGDCy0NY8jQUHvoP75wTo5zUk/kY+Zz+YJDjsfH1xNoZRDfibq6AR4qvlJTOl4lsA5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsC4Ph9+s2yVUze4C+TS3cOpMVgwEgIH2TpOYXiNnlFeG9M72m
	clLyaoeUpltSOULQCWFRHjvYJ+QDHSbe5ODyGpDE/ALClUaLOrPu
X-Gm-Gg: ASbGncsU5uDTuvjvVMd2uz63Ilp4seN/+D06r+DdQ2xZnb23MShl4uiFgvgBcxWL0HH
	aZ6fuSGnr2CSFy+gjfMoQS+S2VZGf3Uqkgrm6JUkqQ/iN1pjc8s0C7CsS+DNWuoj/jl6OoNB7aE
	RjWAvyLm+ue7J5/t1sd5MrpXFzfqqfTDyS+5s4EXBQbsD0xvL4qFkiQAEYazzSkWYdAqSyDYS0K
	Ue6tZHij/qisb4MjuXotXXhRzk2jpC+RX717t88YKOOeGLPndsYopJuM6jmsGinw8vyDojujAyb
	7pnHyIbmEQ/jquct6Bt5Tmn//qnBfIzNc903cuFH08l2taAxYDY2fcZVYGLgYnM=
X-Google-Smtp-Source: AGHT+IFduRunIjVQ1KCO5LD7npVz+lWxT5h4YlwQYeUz8PqlZX3bQdUyYveUb1UicjTd2mesfrfsHw==
X-Received: by 2002:a17:902:d54d:b0:220:fb23:48e0 with SMTP id d9443c01a7336-2219ffa7caamr135165ad.38.1740073589551;
        Thu, 20 Feb 2025 09:46:29 -0800 (PST)
Received: from [10.19.100.228] (59-124-78-18.hinet-ip.hinet.net. [59.124.78.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53491d4sm124363205ad.4.2025.02.20.09.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 09:46:29 -0800 (PST)
Message-ID: <c0c8505e-ceb4-4a82-8c3c-8043ee2ce256@gmail.com>
Date: Fri, 21 Feb 2025 01:46:29 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cpupower: monitor: Exit with error status if execvp()
 fail
To: Shuah Khan <skhan@linuxfoundation.org>, trenn@suse.com, shuah@kernel.org
Cc: jwyatt@redhat.com, jkacur@redhat.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250220163846.2765-1-s921975628@gmail.com>
 <929c1d63-e3e7-432c-b34a-8953662297ab@linuxfoundation.org>
Content-Language: en-US
From: Yiwei Lin <s921975628@gmail.com>
In-Reply-To: <929c1d63-e3e7-432c-b34a-8953662297ab@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/21/2025 1:37 AM, Shuah Khan wrote:
> On 2/20/25 09:38, Yiwei Lin wrote:
>> In the case that we give a invalid command to idle_monitor for
>> monitoring, the execvp() will fail and thus go to the next line.
>> As a result, we'll see two differnt monitoring output. For
>> example, running `cpupower monitor -i 5 invalidcmd` which `invalidcmd`
>> is not executable.
>>
>> ---
>
> Note that everything below this gets thrown away.
>
>> V3:
>> - Modify output message content
>>
>> V2:
>> - Check return value from execvp and print message for invalid command
>> ---
>
> These version information goes after the --- below the Signed-off-by
>
> Note that everything below the
>
>>
>> Signed-off-by: Yiwei Lin <s921975628@gmail.com>
>> ---
>
> This where the patch version stuff goes. I fixed this for now.
>
Thank you to help for the fix! I'll be careful with the commit message 
next time. I'm sorry if you experienced any inconvenience with this.

All the best,

Yiwei Lin


