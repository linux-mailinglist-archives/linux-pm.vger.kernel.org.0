Return-Path: <linux-pm+bounces-10222-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E3A91C77B
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 22:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 012FD282D83
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 20:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B1B770F5;
	Fri, 28 Jun 2024 20:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cj/f1HVx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A429158AB9
	for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 20:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719607643; cv=none; b=eARE9qNbGgDOIJGG3xEt5jYhMBbB/PErLpgfwpVIMyt7nkpesJh9eBtBbEpvHX5grJQiQu6hZGQU9wBV8jJIh3Jr3z0MMub/15JmOBh97XZtt88yPprbsGU2UpEz+tVVbEFYyWu9yQVSFNxc2wjNMVcbQJLmzwyEK/7fFqbbTQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719607643; c=relaxed/simple;
	bh=s44Et0ooy1BwV1wiuAthBqIcBlMZAPLGSgVzR8S+DTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cbHguxNPstPujI893ucWQ56JFF+P65tGlrsgBnm2fUJI2wcniloxJVI25D31j5AEuLhqpYdcImI3H40oLCDdFjFqFHdJzHeC0967Qxzus90qzBNQAHrPsXtmYzB2DuBC/aZDwQmAj+LHFHZUX60yzed4EXa9c3uEuz3oVbEa3so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cj/f1HVx; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3748ec0cae2so768915ab.3
        for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 13:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719607641; x=1720212441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ElFfL+9fsVftY7dbtRQDE0n67mXXjumfiDFLoKzxmKA=;
        b=cj/f1HVx56rsaZqysKz6dVMx6+wLuB+a3AqXcI35oIMauqLZ7AHD/qI0h18C4KJprU
         rAyieEkXpXyzV4HlSJneX95qCQD2trLvsbXNisPd4hmhyxbKjhlUr6EDaR2He7QqT4AN
         zr1qSF8wKCWNIGhUFOt1yC867wQgbzhGfy9G8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719607641; x=1720212441;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ElFfL+9fsVftY7dbtRQDE0n67mXXjumfiDFLoKzxmKA=;
        b=nEerO+Xxh83viIlAzCrGl8vEW9IVnOMCimzIzdSyckFPJbB7mU8hntuIfOck6d3JPL
         9wvUUA86Pgtuw18gLyfvvIrhv7J6umAbVsC0sH7UTKmCp+HSQ61THiZl0K3EiCNJJRU6
         dUFGaS+9e+rFhGSJBaPYwBayUxcrvIJebPU0RqRPs9ze8Aa3f8SLCnWNylb3dQ9yDrVC
         h4FcBltn8uM4iQnwMvOlWXdPk5I8wHNzh0pKUOgPJu0eNlRW3gnfBagn72KLgBkDZqN9
         OhHeZULYPrd/SEUT3RWk09o1vDnLhauYgJmCcs4/bbPtBA4TeKpoUqu2rRRGpersbqAi
         mtig==
X-Forwarded-Encrypted: i=1; AJvYcCXfDzgpiErQGDZ1+DJaSzXI5i56e1NHXUPklhxE+yWrOBKaWakgt7BgeIIv/Q9Am+xzWZQDvPtFNSQpuOt2Oa7U/Nqs+6H9Uns=
X-Gm-Message-State: AOJu0Ywr20CHDBDvbiH8uQ1LoK92RrAPpgDWc2Emci6CG/+fUGQin+wp
	wa3Z2zBncv0kpKbKvAPmToAWWDyrqCIW03jsCEqFgGQnsiD7/Ty2xy+x+e+Uj9c=
X-Google-Smtp-Source: AGHT+IGGLgOnM8KW/v8/yG6HDfxdCoco0NQRTG38bTNVCxdVf4hkcTIQxPG+L7frOd/AFnVLVzva1w==
X-Received: by 2002:a05:6602:25d7:b0:7eb:66a5:d1c with SMTP id ca18e2360f4ac-7f39c44f029mr1784451439f.0.1719607640795;
        Fri, 28 Jun 2024 13:47:20 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73bb37e8sm719417173.3.2024.06.28.13.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 13:47:20 -0700 (PDT)
Message-ID: <9962b32a-068f-400d-923c-bd388691656d@linuxfoundation.org>
Date: Fri, 28 Jun 2024 14:47:19 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] cpupower: Add 'help' target to the 'debug/x86_64'
 subproject makefile
To: Roman Storozhenko <romeusmeister@gmail.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240623-make_help_rest-v1-0-4bd3fd51064b@gmail.com>
 <20240623-make_help_rest-v1-3-4bd3fd51064b@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240623-make_help_rest-v1-3-4bd3fd51064b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/23/24 13:19, Roman Storozhenko wrote:
> Add 'help' target, describing all user-available targets, to the
> 'debug/x86_64' subproject makefile.
> 
> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> ---
>   tools/power/cpupower/debug/x86_64/Makefile | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/tools/power/cpupower/debug/x86_64/Makefile b/tools/power/cpupower/debug/x86_64/Makefile
> index b1b6c43644e7..4b35b2474182 100644
> --- a/tools/power/cpupower/debug/x86_64/Makefile
> +++ b/tools/power/cpupower/debug/x86_64/Makefile
> @@ -28,4 +28,16 @@ install:
>   	$(INSTALL) $(OUTPUT)centrino-decode $(DESTDIR)${bindir}
>   	$(INSTALL) $(OUTPUT)powernow-k8-decode $(DESTDIR)${bindir}
>   
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
> +
>   .PHONY: all default clean install
> 

I don't see a value in adding this - these are common targets and
nothing new about them.

thanks,
-- Shuah

