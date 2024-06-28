Return-Path: <linux-pm+bounces-10220-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C75F91C774
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 22:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F2E1F232C2
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 20:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E62378B4E;
	Fri, 28 Jun 2024 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZvYAOjBD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960054D8BC
	for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 20:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719607448; cv=none; b=g8x7qO+biDMWpE9JL2vevrUJtoPtcLkAzIYSzyhrRRkR+SMUGR6ZGa6Go9tnDGNjxGSAjO2QY44PsjHpkU4nQf3trD23HR6DOH406TEL4xOCLLU0RKcB05DA6xvOOECyBbaviYEJHaIq6bK51afZQ4TsLv2Czfc2WYrYiB/m550=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719607448; c=relaxed/simple;
	bh=8dGdkVxWgN9JzcpOHdS5PlD3VTcxy/ssHnXcSzuLaoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B74l+RpjvRcXYXV3AHIyivFYf4L58l3cbstx0pJ4OxzA+df3IgD6bxVXowPTm+68P5eXnHNkCGSY6IfDt6wU4Dzm0rs599f61XVoLAix6FzV4QNMQ3lXRcvXkQl6Wm3hxKiHklek/s/97ghtb4J99HNiuwSTtXVJVAvs5pxv0WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZvYAOjBD; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3748ec0cae2so765655ab.3
        for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 13:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719607446; x=1720212246; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VV0l09SoWGJ1SnpCeKyT1K1d8xCV8UNByaKVaVGNTYE=;
        b=ZvYAOjBDPphjCXH1463daJzlPV5xiadtceEvLrBBPzmodsnmqf0vBiBoiRPS0jNQOc
         5ESJjckOJ5/ZPpR20mHoO7ks1WaerkZuPJeHOo0aBirallwi0TuExZEwORnKzfKwGvea
         udNqqKhzFToHW5qQ8UwoCsiTa4xk/3/q5SFaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719607446; x=1720212246;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VV0l09SoWGJ1SnpCeKyT1K1d8xCV8UNByaKVaVGNTYE=;
        b=Or6w5KAOc4gfPSowYow2kPek7FHn8dnfxdeBZTbM4g1uo/T3ylO08AMXTN8v6S3vGN
         AH6c40v23u9rlDcxLrxHSkK77KViwNiYZU4AyfFi8TZYZDpnoWteVMBmiv6kkObTbbKC
         zF9TBmNN4oL04tHOPBW8cp1chBhAZXiDaVMF+Hww9CCveQ1XPvPuIShkB0gDXKnva3Or
         zk+U6z7f/5jlmF+LI0WdNjt82x4LbufbsOAtAmzUDJiOYnYO8yKRPfCauSJr5YB8wl9U
         rMyBmRU6BO0rA5XfTHAeptIIb7MCe1xgEfqOAK8UeEUoWf9z53F4ZHh2QB/zBTlmZwjo
         gPPg==
X-Forwarded-Encrypted: i=1; AJvYcCWve+tZlNon+Pz0pV71/KYH5/hNT42gfQxQrnLRtikw3u2iLydvzgs/ylwuGZEopUbeqllu5irm+0pBB6fyxzZz+JOjnVAt8Gg=
X-Gm-Message-State: AOJu0YzOc2KIUxURrnkIMld8wXpoHi8A1RgpQgDpyqJZvaSTK0EDMnnD
	Oa2W2tL6/2PgJGxDaVsSD5nX2abT3ZTKyeApq6tQYW+wSgtGrehKyk8BhZIeYls=
X-Google-Smtp-Source: AGHT+IG+om/imzFgy8LRRQHUqfx2XPHiL05dYxs+tlDZTUfjHA5g2wsrx/jwjMi5O5hKd/5yau5siw==
X-Received: by 2002:a92:c981:0:b0:375:bdfe:287a with SMTP id e9e14a558f8ab-3763807c15emr188331605ab.0.1719607445733;
        Fri, 28 Jun 2024 13:44:05 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37ad2e4bfabsm5782135ab.38.2024.06.28.13.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 13:44:05 -0700 (PDT)
Message-ID: <cfee36c5-c5d9-49db-bc94-c6e5fdb77840@linuxfoundation.org>
Date: Fri, 28 Jun 2024 14:44:04 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: fix lib default installation path
To: Roman Storozhenko <romeusmeister@gmail.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240623-fix-lib-install-v1-1-bcbd03b78d87@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240623-fix-lib-install-v1-1-bcbd03b78d87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/23/24 07:10, Roman Storozhenko wrote:
> Invocation the tool built with the default settings fails:
> $ cpupower
> cpupower: error while loading shared libraries: libcpupower.so.1: cannot
> open shared object file: No such file or directory> The issue is that Makefile puts the library to "/usr/lib64" dir for a 64
> bit machine. This is wrong. According to the "File hierarchy standard
> specification:
> https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard
> https://refspecs.linuxfoundation.org/FHS_3.0/fhs-3.0.pdf
> 
> "/usr/lib<qual>" dirs are intended for alternative-format libraries
> (e.g., "/usr/lib32" for 32-bit libraries on a 64-bit machine (optional)).
> 
> The utility is built for the current machine and doesn't change bit
> depth.
> Fix the issue by changing library destination dir to "/usr/lib".
> 
> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> ---
>   tools/power/cpupower/Makefile | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
> index cd0225a312b4..6c02f401069e 100644
> --- a/tools/power/cpupower/Makefile
> +++ b/tools/power/cpupower/Makefile
> @@ -67,6 +67,7 @@ LANGUAGES = 			de fr it cs pt ka
>   bindir ?=	/usr/bin
>   sbindir ?=	/usr/sbin
>   mandir ?=	/usr/man
> +libdir ?=	/usr/lib
>   includedir ?=	/usr/include
>   localedir ?=	/usr/share/locale
>   docdir ?=       /usr/share/doc/packages/cpupower
> @@ -94,15 +95,6 @@ RANLIB = $(CROSS)ranlib
>   HOSTCC = gcc
>   MKDIR = mkdir

These are set when make invoked from the kernel main
Makefile - see "make tools" option in main Makefile
>   
> -# 64bit library detection
> -include ../../scripts/Makefile.arch

This does the 64-librray detection based on arch.
> -
> -ifeq ($(IS_64_BIT), 1)
> -libdir ?=	/usr/lib64
> -else
> -libdir ?=	/usr/lib
> -endif
> -
>   # Now we set up the build system
>   #
>   
> 
> ---
> base-commit: f76698bd9a8ca01d3581236082d786e9a6b72bb7
> change-id: 20240623-fix-lib-install-3b7dccdbdf45
> 
> Best regards,

What happens if you cross-compile with this patch? Take a look at this
commit that fixed cross-compile:

a73f6e2fbe8077811ea9546e0d44a7533111f0ba

This makefile has to be in sync with the rest of the tools - see
"make tools" in the kernel main Makefile.

thanks,
-- Shuah



