Return-Path: <linux-pm+bounces-14096-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A64976DA7
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 17:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38A9288403
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 15:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BBD1BB6A4;
	Thu, 12 Sep 2024 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AfCrwZyU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE743548E0
	for <linux-pm@vger.kernel.org>; Thu, 12 Sep 2024 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726154488; cv=none; b=NTnBh/EAmsbqBi+Z8ONVTX9FU5qNo4maTvSB4u1qt/W4vEb7x+sZ22krsiBq+whmzPhyKMeGljvkYjGNkFTS0Pz/ZbpySmr3LU+cC8uf+CEy3yon8Li6F3+ILcvp2zZ1b/bBC6Voxrx+Eug7FQ3XWNAzQkW864+TJ6j5UZqvD7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726154488; c=relaxed/simple;
	bh=uN1oYA0myYbXgQTkDCm1pVnzk5hImXCysuahXmxFavg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o8VGlClV7XxTexOnUBfR+v9IzXiJy0t8dgSDLx8+NSqqr7g/2mNWs7g4+1wWhT672o+gK85vyUshpkA79CHb6uC5xVCHwI6PcFiJD7NsE5BEz80SaeSSen/5UYsjOrzOtE+K3qDgr7jmdGAiw17J7Xdh4kD8+7wfI5SSag7hI6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AfCrwZyU; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-82aa8c36eefso53009339f.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Sep 2024 08:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726154484; x=1726759284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tZNlGWMH9v05LMlASstXyJey4cdG+X1schcNc8DL3xM=;
        b=AfCrwZyUJm3xsXnyL4VRM6jIufqiYJtYBxWwZmTciUaecA3cJczxYCM7BNN5rjU8t9
         0aFHRxr43v+5mH+bLO3w0Mobg75MpysO8xytFRuIxJlrYtfH0LGaTlcrGTzQi2JvKVV+
         6v7Fm2IOuMQca+bD9ZS+Z6wNUpLoXMrbmI4co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726154484; x=1726759284;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tZNlGWMH9v05LMlASstXyJey4cdG+X1schcNc8DL3xM=;
        b=MJOS6OsGiHqsPUGu1qPfpsapJA2PHoBPABgdWDAgGU6mV2tUIdgDfwLO+ft4E7bsZ+
         UzbfiMPtxdefzoSYXt5vqfzoCa5f8q9u14dUanejoVWHjE/TYNZFdQLouOepVygfiXtm
         q9cd73cKkrfHlpA5G6ZkM+vcNeyshxFY8evCA7IkzjhcNVZuNLjZ1thObSNWW1RrUZib
         xXnX7niDuCRL+B16YE6Ah/3WpCRsg32JXpL58TtGiiBgiMcSax9v8BWh+NtAmeiJUv0q
         qdzDt4zFDMIxX0WUFv5ZyQ2NHUY9yZ2jkq27Ph4G4g1vs+AzXUt8r1GgOh5CV8JPehHe
         BZXg==
X-Forwarded-Encrypted: i=1; AJvYcCWOp+SRMNgIC31lMNMi++zX9GayzPcyyeZts1ZI9VDXW7p+ItvqnAZnFFHjfgb4fecQX08qFyibOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEWckmJh5mfiUIfOTtv1lDxQiYuO+izJdQ5UKRF24BlX4N6CdA
	mxvqx7mbPQ81yAkqUqRYgvAFrhLv4AA1YQU6I7Om1WpODRxTvaCVDaLQ/IuiZJk=
X-Google-Smtp-Source: AGHT+IHoWGkx34fzoZjY/3fKE7Cqz2uXeVe9T5b0JY6cte+Hc7mU0kvLcrmxBw4Ynk+qFVnkNWF7mQ==
X-Received: by 2002:a05:6602:6b19:b0:7f6:8303:ba80 with SMTP id ca18e2360f4ac-82d1f9624f6mr372896039f.11.1726154483803;
        Thu, 12 Sep 2024 08:21:23 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d35f89205bsm642208173.117.2024.09.12.08.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 08:21:23 -0700 (PDT)
Message-ID: <0f8df90f-007a-483e-83ce-df8ff0e99791@linuxfoundation.org>
Date: Thu, 12 Sep 2024 09:21:22 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pm: cpupower: Makefile: better support
 cross-compiling
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Thomas Renninger
 <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>,
 "open list:CPU POWER MONITORING SUBSYSTEM" <linux-pm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: Peng Fan <peng.fan@nxp.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20240912013846.3058728-1-peng.fan@oss.nxp.com>
 <20240912013846.3058728-2-peng.fan@oss.nxp.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240912013846.3058728-2-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/24 19:38, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>

Improve subject line. "better support cross-compiling" doesn't
tell me much. "Allow overriding cross-compiling env params" would
is a better subject line for this patch.

> 
> Allow overridding the envs, this will be easier to user Yocto

"Allow overriding the cross-comple env parameters to make it
easier for Yactor users."

Then add what it is like now and how this change helps.

spelling "overridding"?. Run checkpatch on patches before sending.

> cross-compiler toolchains to build cpupower with only two steps:
> 
> source (toolchain path)/environment-setup-armv8a-poky-linux
> make
> 

What steps do you have to take without this change? Include that
in the changelog

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   tools/power/cpupower/Makefile | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
> index 6c02f401069e..e2a48af6fa2a 100644
> --- a/tools/power/cpupower/Makefile
> +++ b/tools/power/cpupower/Makefile
> @@ -86,12 +86,12 @@ INSTALL_SCRIPT = ${INSTALL} -m 644
>   # If you are running a cross compiler, you may want to set this
>   # to something more interesting, like "arm-linux-".  If you want
>   # to compile vs uClibc, that can be done here as well.
> -CROSS = #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
> -CC = $(CROSS)gcc
> -LD = $(CROSS)gcc
> -AR = $(CROSS)ar
> -STRIP = $(CROSS)strip
> -RANLIB = $(CROSS)ranlib
> +CROSS ?= #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
> +CC ?= $(CROSS)gcc
> +LD ?= $(CROSS)gcc
> +AR ?= $(CROSS)ar
> +STRIP ?= $(CROSS)strip
> +RANLIB ?= $(CROSS)ranlib
>   HOSTCC = gcc
>   MKDIR = mkdir
>   

Send v2 with cover-letter to make easier for reviewers.

thanks,
-- Shuah


