Return-Path: <linux-pm+bounces-2216-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C7882DDFE
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jan 2024 17:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24F2DB21999
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jan 2024 16:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9E117C6D;
	Mon, 15 Jan 2024 16:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QJb0gT1P"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B40A17BD6
	for <linux-pm@vger.kernel.org>; Mon, 15 Jan 2024 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dbed5d1ffb0so7866442276.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Jan 2024 08:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705337705; x=1705942505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UCNjbbRtiRrrLG8qS/Xc9TIQUVtwQUGSg1R0IufXxj4=;
        b=QJb0gT1PpLktx/0uPXAcr1WeWa+07jrV9nnunkQxy829tIb24fkSjSrAqC7d8BDDqP
         ZP273IzDmOHkXUIclucJr+nmBkSPsIw15Im+j9ZUq1HRSJFz6mmhNJNBAFxtbddBTFdm
         mfifwOBmjUzwgp2foOYetcg6Lc3vXUGaqzBexwb58eMjb/M1gW3TUqg6AayBP1cdFlpr
         C+w+Op1PofYHTF65SyjNlwqf6vBx2Ym0WDlVfIbblZpHHyVWFQPt5ig/nOpYtRWNpMvL
         QxxrJDsgizMAYMcltKQHzVsmNhCtbhstOjttiFTQc3c2mj5pfVZNuEE5h0U+PS8gv9if
         LowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705337705; x=1705942505;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UCNjbbRtiRrrLG8qS/Xc9TIQUVtwQUGSg1R0IufXxj4=;
        b=KoYxMosqj0IySdp8M55PrCPePrMDoFYm9tQR5Sbysjm6UUwgBil2vuq5G0L+UAURyK
         RauRaXBFWSYjjRYm0EcmVhcI+1JpErfuVEGfLjOQa82Ar9m+AbxHCo30GJux4NUdCsgL
         c0jtQ/H81MwbIK/xYOMdka401r1kt2We29YOSZ22MBM/sFuGE8US6daE/MWvb6KpDpsS
         VkikAK9ELBGo1hxxUdgfF7g6uumOGK2P71Cn6pXODa51XHbmdFkNnlXS2goHmVJ+DhP3
         +DS8ABvnrWmiufvZCaroKtla7BVLK7y1FV18j6PYEXfPPBsNlOQ+iNT6ZaNR8YySoLKk
         zZQw==
X-Gm-Message-State: AOJu0YxLcUvVXeOLd16+nMQyE7ooJBdHu7PCCZmchsBi+x/gln4smcIy
	UXrZG88VCS4hcqdl3fRUCNIYancL/PkwEQ==
X-Google-Smtp-Source: AGHT+IG2jMx+j6CJIDShCnx/rmWa6ip/gJjEbKiYmOsyaZrgvmYXndu/Zek46SW/oXggmuhODiVRIQ==
X-Received: by 2002:a5b:8c8:0:b0:dbe:a4a2:c942 with SMTP id w8-20020a5b08c8000000b00dbea4a2c942mr2793432ybq.25.1705337705379;
        Mon, 15 Jan 2024 08:55:05 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:439d:3bc0:a764:73dc? ([2a05:6e02:1041:c10:439d:3bc0:a764:73dc])
        by smtp.googlemail.com with ESMTPSA id d193-20020a25cdca000000b00da082362238sm3703878ybf.0.2024.01.15.08.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 08:55:05 -0800 (PST)
Message-ID: <ecb33c61-bb40-43a0-94a1-8973d70dc0b4@linaro.org>
Date: Mon, 15 Jan 2024 17:55:02 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] thermal/debugfs: Remove unnecessary
 debugfs_create_dir() error check in thermal_debug_init()
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>, Minjie Du <duminjie@vivo.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, opensource.kernel@vivo.com
References: <20240115082507.29651-1-duminjie@vivo.com>
 <CAJZ5v0jPeYgGc9xmSrnLsg6RkhzmU=TfPdhrzxWBd_d_dmJh+Q@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0jPeYgGc9xmSrnLsg6RkhzmU=TfPdhrzxWBd_d_dmJh+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/01/2024 16:52, Rafael J. Wysocki wrote:
> On Mon, Jan 15, 2024 at 9:25 AM Minjie Du <duminjie@vivo.com> wrote:
>>
>> This patch removes the debugfs_create_dir() error checking in
>> thermal_debug_init(). Because the debugfs_create_dir() is developed
>> in a way that the caller can safely handle the errors that
>> occur during the creation of DebugFS nodes.
> 
> I honestly don't see what the purpose of this patch is.

I think it is because the recent debugfs changes were about to reduce as 
much as possible the code related to the error handling as the debugfs 
is not supposed to go in production system.

So for instance debugfs_create_dir() will not fail if the parent is NULL 
and will create the entry in the debugfs topdir.

At the end we are ending up with:

d_root = debugfs_create_dir("thermal", NULL);
d_cdev = debugfs_create_dir("cooling_devices", d_root);
d_tz = debugfs_create_dir("thermal_zones", d_root);

The current code will avoid creating lost entries in /sys/kernel/debug

The proposed change will create those in /sys/kernel/debug in case of error.

Note I reduced as much as possible the error handling in this function. 
So it is a matter to reduce it even more but may be resulting in junk in 
/sys/kernel/debug in case of error

TBH, I'm 50/50  :)

>> Signed-off-by: Minjie Du <duminjie@vivo.com>
>> ---
>>   drivers/thermal/thermal_debugfs.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_debugfs.c b/drivers/thermal/thermal_debugfs.c
>> index a3fa09235da1..695253559a61 100644
>> --- a/drivers/thermal/thermal_debugfs.c
>> +++ b/drivers/thermal/thermal_debugfs.c
>> @@ -172,12 +172,8 @@ struct thermal_debugfs {
>>   void thermal_debug_init(void)
>>   {
>>          d_root = debugfs_create_dir("thermal", NULL);
>> -       if (!d_root)
>> -               return;
>>
>>          d_cdev = debugfs_create_dir("cooling_devices", d_root);
>> -       if (!d_cdev)
>> -               return;
>>
>>          d_tz = debugfs_create_dir("thermal_zones", d_root);
>>   }
>> --

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


