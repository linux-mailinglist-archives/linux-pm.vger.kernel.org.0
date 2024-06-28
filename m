Return-Path: <linux-pm+bounces-10218-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC22C91C6E2
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 21:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0E201F24529
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 19:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A621976C61;
	Fri, 28 Jun 2024 19:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hETK/qhs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128D86F2E9
	for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 19:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719604527; cv=none; b=UP64Tq62+zYTY/l06OgenKtKq5EXwLR5v3n/RUw5ooXj4X2cvgVeHnyvGYRa+aL7DLt/JMMj/vuDWE9qlDeepop3mAdjJZRBa+2f+Vy8vkKas0H8lVODwu3MXlW6Ux9uW0TYckV8uKC0dC+RcXE/sYPdjLxAtJqTBN73cNni1TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719604527; c=relaxed/simple;
	bh=LeF6+VIbsZR4AZNnzSW7q90MGWi7owkHEiFGjX3ZIZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fcuQ12kOM67ISqw4zNOEyK7WbRcH8nPRLPN1i1TedTCIMwd1AZEUzHs50ejFc+JR0WBA8IT9ZoxT7AEWplMXHqO5drnl5Vqga9aTYpKVEXEX2rGRy7FwGUXpCqigE8qqSvo/kgtiSJxjRS/MN3tgkhRnNvSQ3dco+gR76ht0bbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hETK/qhs; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3734052ffd9so594585ab.1
        for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 12:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719604525; x=1720209325; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DIV6yJjX8GB41D6fmmUZ7FkjneyetoEI+QshUrjZeMs=;
        b=hETK/qhsd1TrEIRlHCnTyWW5DqQLiqHYPx2AgOZ6cfgOr/QSRDW+cYkku2BbRsLAvc
         hRXf04Xh4qHRNupvGncCc4gbjAvDPBLP3F0Ae48cb1WDXEPKbuLWhbCd9URRe3pWN0ev
         57EM1LJMURQYK+Voc05VAY2EbLFce+z44lyjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719604525; x=1720209325;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DIV6yJjX8GB41D6fmmUZ7FkjneyetoEI+QshUrjZeMs=;
        b=kVTBrRlIQPrTLMpW+qqad8GUPDJLQsMNjUEbZdysH5C3VHgl2jbpEAKEJf+h7qRkIg
         e1L9C6Hzevj2VYKNKEMTjeV1I7MaQ7ctKJWL3sD9Vw0E1KLd/fW4h7iyYms75N4PRchm
         1q5ArQJ5P1E3AYXHHpfDK/6cx6cq48TB6vWsERQKiMdfMREKHrUjKzAjmuZdp2LJWJ6k
         qbHk9p6i8MXMQc/X4rYhC6pzSc9M/F815hHSabzJMQ6+hjObNrX1lFs90lr84VSYjc8u
         o9Lft/S+N0MPZPixXUbGJynqsuY6HO+B6Z13K4bztvffC71WuD46mNmLoyMzWvQk9cRe
         lPSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzl6AXdTLdeq+AMD7BM2hqoexNjPuhqwjpU+rk1mvB8JqNKtpRIGyi8spFvfReflsjaIUIOsl9QLUKxlrEPeQlwt7Egy/k30o=
X-Gm-Message-State: AOJu0Yyoei6QGmcrEllEAdhD3M3a8pYjTg7odQnf64N7q/IyyeLLsQE+
	eS61ngQl+wyG8IKXsqNFptiRqU8catxeUvSGa1q5KzgxDftGIoqjJUmEc4mJJTk=
X-Google-Smtp-Source: AGHT+IFz9Lf6O9yuRq0VsVMlK9RemhcCia+W9fPEx+U6wQpkhZkPBYq+Qo+rrlbwCfPjinAaSIg7mw==
X-Received: by 2002:a05:6602:3fca:b0:7eb:2c45:4688 with SMTP id ca18e2360f4ac-7f39dd12493mr2254867939f.2.1719604525171;
        Fri, 28 Jun 2024 12:55:25 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73bb3a32sm683825173.13.2024.06.28.12.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 12:55:24 -0700 (PDT)
Message-ID: <88d70179-1a7b-4960-ab1d-55652a7822bc@linuxfoundation.org>
Date: Fri, 28 Jun 2024 13:55:24 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] cpupower: Add 'help' target to the 'bench' subproject
 makefile
To: Roman Storozhenko <romeusmeister@gmail.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240623-make_help_rest-v1-0-4bd3fd51064b@gmail.com>
 <20240623-make_help_rest-v1-1-4bd3fd51064b@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240623-make_help_rest-v1-1-4bd3fd51064b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/23/24 13:19, Roman Storozhenko wrote:
> Add 'help' target, describing all user-available targets, to the
> 'bench' subproject makefile.
> 
> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> ---
>   tools/power/cpupower/bench/Makefile | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/tools/power/cpupower/bench/Makefile b/tools/power/cpupower/bench/Makefile
> index a4b902f9e1c4..81c862297782 100644
> --- a/tools/power/cpupower/bench/Makefile
> +++ b/tools/power/cpupower/bench/Makefile
> @@ -41,3 +41,15 @@ install: $(OUTPUT)cpufreq-bench
>   clean:
>   	rm -f $(OUTPUT)*.o
>   	rm -f $(OUTPUT)cpufreq-bench
> +
> +help:
> +	@echo  'Build targets:'
> +	@echo  '  all		  - Default target. Could be omitted. Put build artifacts'
> +	@echo  '                    to "O" cmdline option dir (default: current dir)'
> +	@echo  '  install	  - Install previously built project files from the output'
> +	@echo  '                    dir defined by "O" cmdline option (default: current dir)'
> +	@echo  '                    to the install dir  defined by "DESTDIR" cmdline'
> +	@echo  ''
> +	@echo  'Clean targets:'
> +	@echo  '  clean		  - Clean build artifacts from the dir defined by "O" cmdline'
> +	@echo  '                    option (default: current dir)'
> 

Is this help message necessary if bench can't be built standalone?

cpupower: Disable direct build of the 'bench' subproject
https://patchwork.kernel.org/project/linux-pm/patch/20240626-fix_bench_compilation-v1-1-d039bd5fa551@gmail.com/

thanks,
-- Shuah

