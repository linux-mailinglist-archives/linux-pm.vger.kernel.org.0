Return-Path: <linux-pm+bounces-10221-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F02A91C77A
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 22:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0938BB2409D
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 20:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C97A78C7F;
	Fri, 28 Jun 2024 20:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Eauw6lqb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4840253398
	for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 20:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719607629; cv=none; b=qTZ6zH7F1IRWrSt8jjqzs+pC9lpswHtJSSPu0ShhozwtvKvQXIfhB4l5/f0G+8GFvcNSnA6fwzcaWTuT8Cz3MWV1EGKXzGEkZp0aaV9hhSRNovtnjuHkmjZEzmTHvH2+df9aRDWgSYwPyb8jEp/sRgKAfOLz0vlVY36jkfgCFPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719607629; c=relaxed/simple;
	bh=Jb7mKXaAYVuB/4EKR0Fr/gT6mE/i4tP53/+kgnh7LHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjs1OJAjWqrQkIXbHxYhnMVeywBCcF4kre7NcBYC+aWfWNccTTt4ngMpzy8reehi6s+4KEgWcn5NDIlsrJpeYCyWUyu8y2U2kwpQgehYpVngN0WJHl1A11kYDtt//pm0An+BihIYRrGgMqWlSN0BSXFTfeBNLRxp1BAau6NsRDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Eauw6lqb; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3762c84e120so752675ab.2
        for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 13:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719607626; x=1720212426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qhHtiTqQ+z7E3AhoOR3qMD5WdYC0t8JoAfk16HBLnGU=;
        b=Eauw6lqbgg+qVPaP+m2WooPAh9cogLkJO2hTd7mHmbW1urtnkZJrxXf9JUw2XrWuFq
         Xr3YihAjxjyLdpvRCXtjx0FdmRbbCeV/yHxWx3gAgW478ZOA3RYmDQoSsJBQkIFcoCYw
         jtsKiPumyDW/8VWAeS0TPFMfqScQ3S4sl0eG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719607626; x=1720212426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qhHtiTqQ+z7E3AhoOR3qMD5WdYC0t8JoAfk16HBLnGU=;
        b=GyDlSdJ1ueOsX1BHxJ8AQdnQM2JXnjWzUqsrfS2QXhpSjI40DHg+uHLt5QxiCxbniX
         pSyYBH9cfsdr7wk/vsZm0qRTgBe4+MSk2Dwt7Wh7XPW9y+8ByqEEhdIwW9eTeTrMnWke
         X7/uav6VGbwg3TCP+IQgKcjJNoW5h/Q2vCHx2RyJeNOlsNyQPK+tRMrdift1NyI4m+Bh
         Kc+hxdWIAZ5FW3u37eANdfuPAnh53l7TZzUbj4BYbrQZSztbbetYnVE/kxbELaI7bGYY
         j0KOV//rV8diRAeYp3H80V7HIqhMno/IMZeYcqP8Ao8Jw4xPn4LXOgzqUpzVWQOhigVy
         Dnvg==
X-Forwarded-Encrypted: i=1; AJvYcCVKdKGfFYSybclJ4eL60ULfTvf6eHiEA4PmrFIuYnenUc11UYmc3r9HMZpVny8ItU//7ZNwfpyoo8F4smg6OzTUSSCdut3AKGw=
X-Gm-Message-State: AOJu0YytHwoFOqaXC6ZI/m/bnVORa3LIb1Bp3OD2qyuyPQvm2p3fk4g6
	5IKNOJyl3Ih5yEpPV9GOnNP3ubW7SIwW739rnUFoVP4khCrQtdfyxq50EGQC/SQ=
X-Google-Smtp-Source: AGHT+IH1+SWc0NKfOYJvpd8tQQbkp2GXyhvPN6LfHnbWHhu/jSABWnvhN55JWn8alHmEiAhfJUOn7A==
X-Received: by 2002:a05:6e02:1583:b0:376:408f:585b with SMTP id e9e14a558f8ab-376408f5927mr198443125ab.1.1719607626394;
        Fri, 28 Jun 2024 13:47:06 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37ad22cb699sm5855235ab.12.2024.06.28.13.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 13:47:05 -0700 (PDT)
Message-ID: <da8ceb50-91a4-4b6b-92fd-fae78dc49812@linuxfoundation.org>
Date: Fri, 28 Jun 2024 14:47:05 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] cpupower: Add 'help' target to the 'debug/kernel'
 subproject makefile
To: Roman Storozhenko <romeusmeister@gmail.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240623-make_help_rest-v1-0-4bd3fd51064b@gmail.com>
 <20240623-make_help_rest-v1-2-4bd3fd51064b@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240623-make_help_rest-v1-2-4bd3fd51064b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/23/24 13:19, Roman Storozhenko wrote:
> Add 'help' target, describing all user-available targets, to the
> 'debug/kernel' subproject makefile.
> 
> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> ---
>   tools/power/cpupower/debug/kernel/Makefile | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/tools/power/cpupower/debug/kernel/Makefile b/tools/power/cpupower/debug/kernel/Makefile
> index 7b5c43684be1..9e4522a42c6b 100644
> --- a/tools/power/cpupower/debug/kernel/Makefile
> +++ b/tools/power/cpupower/debug/kernel/Makefile
> @@ -21,3 +21,15 @@ install: default
>   	/sbin/depmod -a
>   
>   all:	default
> +
> +help:
> +	@echo  'Build targets:'
> +	@echo  '  all		  - Default target. Could be omitted. Builds "cpufreq-test_tsc"'
> +	@echo  '                    kernel module against the running kernel if the "CONFIG_X86_TSC"'
> +	@echo  '                    kernel config parameter is enabled. Puts the built module'
> +	@echo  '                    to the current dir'
> +	@echo  '  install	  - Install previously built "cpufreq-test_tsc.ko" module'
> +	@echo  '                    to the running kernel "modules" dir'
> +	@echo  ''
> +	@echo  'Clean targets:'
> +	@echo  '  clean		  - Clean "cpufreq-test_tsc" module build artifacts'
> 

I don't see a value in adding this - these are common targets and
nothing new about them.

thanks,
-- Shuah

