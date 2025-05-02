Return-Path: <linux-pm+bounces-26597-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70007AA7A6E
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 21:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1EC33B1A18
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 19:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551421F2B8D;
	Fri,  2 May 2025 19:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ARfc+u5N"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179AC376
	for <linux-pm@vger.kernel.org>; Fri,  2 May 2025 19:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746215754; cv=none; b=Eyrwlf5MbjPg6TtDu9Jek+jnBtyaXQ0dHV3WkTbZ9llg2bXx72plm/zV5OcGwAe+9B0Squhbv/dQc1rkB4A6cpInQfCpKXTAoqDTtudUOqP95lSYTNCXJwH4h3cDnhW5auqHJIXush22VDXzz5KQ50tW2Yi8z6FlR2L0ElKT5q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746215754; c=relaxed/simple;
	bh=VtPlKWFy8dLyv40NHTCnooyrWiuzHaBD47um/SalBkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RBKKx4G7+uChAu3T7KxE5QceRaHK2QQwrvsW5sj6GVHjY61FNXy93hWUbt8b986bSVykLzcwNd3MTgWr0jCRdbCEEbOvmYgw8a145uFclVP4KSaEfB6vrCAtgge2o8fycmnVmnXuNzaZRaLzNhuMngWw1AoVnvFt0dEsMU3+DrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ARfc+u5N; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-861b1f04b99so98645939f.0
        for <linux-pm@vger.kernel.org>; Fri, 02 May 2025 12:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1746215751; x=1746820551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EdHVSx+/Zv4EI0oT8E/EyFlV1rhKfQaBAkeD7BezElw=;
        b=ARfc+u5NvVvPOHVu+IugwK6Or345/xzYbPiUXGMv9Yt67+wLFSXiuffKDOWwRn0mvd
         PMACnFFNdiWHTtRBUq1ktqWUdWns1sMqBDbuF8zGjaXMpDOE1/lsncpfcCmW/+haNfqM
         QeLjmmIBe6+AsBS1EtuVv9JkvqQr4qY6cXh2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746215751; x=1746820551;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EdHVSx+/Zv4EI0oT8E/EyFlV1rhKfQaBAkeD7BezElw=;
        b=gI2qryoESLlotuXwXEMS63NVsyAf+qRBVhgzQBoNHlHrtoIkhEb9lDyZt7oTjwYGfi
         vdSXjBq/IFZNvF+RekLneKTgxIAP2zjMQhjj55zPwW1Ns3wQNiOOfLEs4RW/1GmSoXCL
         W/5C609lDb58efeirCpBjH6yr97F+XWM8QFRvk4w32TKRV/PnEvrJ1dgf/UlGyNqnThk
         axwTA9POgAvsv+kdf8gRiAavmsKoiHO9ykGtsiM7TfNpeGCiM+48sJTxHGFjLfwbZt5s
         7Y0RycjBm7BV4Jr4+Nd7igAudnE6rS+txGVPLfcHEfrFKigMQbsOr28pAysQ00AjK24X
         QIDA==
X-Gm-Message-State: AOJu0Yz5AHd4AxG8DVT6eMjCqBOFCTmLtxb5vMJ5ThNM60SQq+7TK0KJ
	/EKJwhWC3r28DXiQEeWdErO61UsVvUtahDEA06nflguWT6Qzs0/emPU20PoKkb8=
X-Gm-Gg: ASbGnctDscxaVhWDTpGTYk/UPUP053PrALSVvXN84s7ARUbR4FrDBhLziWDjiGVh83J
	oB6UzzBlfseFND7/NK41hwFoKRiVbhtNMVtGi9sK4pZXavqHCUH9XXRjFpMyd82EmSCln9y+4JS
	9ugT2cTyeonKAeryg5E90AUxYvJ5kFODFbo57wu0wvUQrPGFNZz8/NRZqI6rndUhOIAKaTt1sEP
	zpz6wwl4WVkmKQEwwEo0hs8Swk96XvBjB31SmnIW54DSR9iETQiIqIzeRaiRE5P4rzWVcbQqv2m
	ODXzrzno54AUy2mo1+8/+MRBWwR+1To22nw3V+uvaEuGkx0dcMY=
X-Google-Smtp-Source: AGHT+IHz40ezoPkpw4ypsNSC/ftFEhx2VVCiTDcFlni2O4E7NekFGHZP7j3c7uAHylH7D+25Kz6pnA==
X-Received: by 2002:a05:6602:358c:b0:864:58a2:1f0a with SMTP id ca18e2360f4ac-866b349adf6mr545650839f.10.1746215751025;
        Fri, 02 May 2025 12:55:51 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-864aa585a1fsm66852639f.44.2025.05.02.12.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 12:55:50 -0700 (PDT)
Message-ID: <bb5bb612-e98f-49ce-9082-5a883068977d@linuxfoundation.org>
Date: Fri, 2 May 2025 13:55:49 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpupower: add a systemd service to run cpupower
To: Francesco Poli <invernomuto@paranoici.org>,
 "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: linux-pm list <linux-pm@vger.kernel.org>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 John Kacur <jkacur@redhat.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20250425151024.121630-1-invernomuto@paranoici.org>
 <aBE9ly7vP0eryfMO@thinkpad2024>
 <20250502175309.05e66d43fc2654afb01721fc@paranoici.org>
 <bdc10540-2e4a-4f97-9007-e4b70db04c64@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <bdc10540-2e4a-4f97-9007-e4b70db04c64@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/2/25 10:41, Shuah Khan wrote:
> On 5/2/25 09:53, Francesco Poli wrote:
>> On Tue, 29 Apr 2025 16:59:03 -0400 John B. Wyatt IV wrote:
>>
>> [...]
>>> Adding my tags.
>>>
>>> Reviewed-by: John B. Wyatt IV <jwyatt@redhat.com>
>>> Reviewed-by: John B. Wyatt IV <sageofredondo@gmail.com>
>>> Tested-by: John B. Wyatt IV <jwyatt@redhat.com>
>>> Tested-by: John B. Wyatt IV <sageofredondo@gmail.com>
>>
>> Thanks a lot for reviewing and testing my patch!
>>
>> Do I need to resend the patch (without any change) with these tags
>> added to the commit message?
>> Or is it pointless?
>>
>>
> 
> No need to resend. I will apply this later on today.
> 
> thanks,
> -- Shuah

Applied now for Linux 6.16-rc1 - will be included in pull request to
PM maintainer.

https://web.git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower

thanks,
-- Shuah

