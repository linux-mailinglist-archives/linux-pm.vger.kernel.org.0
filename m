Return-Path: <linux-pm+bounces-23577-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED9CA55753
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 21:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7654E188E9BA
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 20:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5182D27602E;
	Thu,  6 Mar 2025 20:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MUT1kLk1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BEC1311AC
	for <linux-pm@vger.kernel.org>; Thu,  6 Mar 2025 20:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741292060; cv=none; b=C6PpxL0lCeCgkeBHVSKUo/WeYg+p+lvOYmpfiPovoTPX2o6T3cEEwljZ9TPn/KL4r5jIWFLQc/C+kZw0cUDgNI/EzABEawm7v9Uq9ve8DzD2Z72WgbXxhu0bOddFvq7oxZnLWsRK2V0g2+WiA7jT8o050w8my4O9xzipGD/Uao0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741292060; c=relaxed/simple;
	bh=wwcWwBE0sSEMdHwr9p5wKUS42qWGgJSQb57mFeHC3Z8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMBDmPh4yAHrzGFFmlYNLXmo/tqrqf3/MV8QL/aN4haHZu48CzG56jGWlyz1M6q8wbICD4ArFgrMFnWa7Mh/V+5P9mX9m5zlnSoxn97d4tDBZgbLNFq5VXuGGfJZV1dRb6LlCgex3LqhZpc/tGbsbyLWc62PtIrK/fIeYOBON9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MUT1kLk1; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-85aec8c95c4so88813739f.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Mar 2025 12:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741292056; x=1741896856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pvfJLfP5WzUnxJcgKycoKuG00dpEdv8cBX8Elv0AIqQ=;
        b=MUT1kLk1ddX+ST2bLJtvgqj35/p/7PHNm02HfX7mntsW2zK5jyRDg5Zh9KOC0tM9qk
         6jgqkcapYMp2hJO7pgNl6uQ1vm8eQibuF3XYm8S30hCWP+yftQ3B2v1m5Qb6FqOixFcR
         U7PBpH1L5BmRdrHdS65shtJpUyldfefG6olj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741292056; x=1741896856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pvfJLfP5WzUnxJcgKycoKuG00dpEdv8cBX8Elv0AIqQ=;
        b=Kvk3ohFbQXtFEVI6RaifEX1heHsTFPY+ZBfXS4KoU968NRDd64PN0z2jmLgCNdTvfG
         bv7M0VcmSrck9nCbevQvN6Pet/UKzbzutlt7TPI8hdMGqsRlsEeOQp6o+1lCi7+H5hmI
         DeNRyA9EivbAAgVNsGblS3ZgHjjNrWKgxnCL14TylyFK6/5+gV0DvXjBJOZArVkb8k+K
         +xHcRc9JX3lpBygOWb0cYO2HGGnNMx1leTnrUtr2NNjQiDU0nqgyJ98QjgeI97zKmoSH
         JixSXKbcqadJeSBv4eou9eJ1Xkvmp06Nytb5RB0/xVRl/LbMlCm2brttTJLf0foM6OpO
         S3UA==
X-Gm-Message-State: AOJu0YzK7ftge+yFc89t4QnxZCr3rxFZx8j8Chbf4dVbb/oLHBBb7Iwb
	lf0lEb5cengLs3vjdE9Oksf1SWb9i5d9dzbLGb/j5Vh8fESLGxlj1tbzv6816vAs6tHBS/wn5xD
	d
X-Gm-Gg: ASbGncu1LXk+SRBKqxHscyN4t0C73Z20dhFNXvWNqtMu6JPVhQhrV0ws4Ad9J78/0ii
	4Z+LX9D/5CbXwSmbsS45SG0R2GTKB2UijKp5TKmQA3Xrr/pOuLN8VlApJMo9N1QyL8t0Q5+fjrP
	9kt5S9F5aG7kKdJrI0CJ60lBk+Hdedy2V2fJ95anuCrNYJbZOC/Xvj8ZrDKYP1kysG0r74rtqGz
	cPHdyq+CJ+lemhZ7TzNXqIojzT4GZl7iJJUv17gqyfSP4ip4QGze6O2VJJ8ha3hj3n2cyZEolfk
	MzsISEcoHRF5PLjaLCLbQ+4f03IVJ/PwSojGQPxReNO9cH9iWoSzOkI=
X-Google-Smtp-Source: AGHT+IEh+Lc6Aj2NXWnZQ8k7UCCl1O9RCdKPZ3pcgarCSG6z7uw+xKz0EMQv/zVrIWy6yk5R824M4g==
X-Received: by 2002:a05:6602:6a8e:b0:855:9e01:9aca with SMTP id ca18e2360f4ac-85b1d059d36mr122062039f.13.1741292056146;
        Thu, 06 Mar 2025 12:14:16 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f209e15b12sm523935173.52.2025.03.06.12.14.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 12:14:15 -0800 (PST)
Message-ID: <fb15134a-e822-4757-8cd8-ec6a60b23848@linuxfoundation.org>
Date: Thu, 6 Mar 2025 13:14:15 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Make versioning scheme more obvious and fix
 version link
To: Thomas Renninger <trenn@suse.de>
Cc: linux-pm@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <3513228.LZWGnKmheA@laptop.fritzbox>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <3513228.LZWGnKmheA@laptop.fritzbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/6/25 08:27, Thomas Renninger wrote:
> Hi Shuah,
> 
> I can darkly remember this was discussed already, but it seems
> it's still broken.
> 
> Currently there is:
> LIB_MAJ=                       0.0.1
> LIB_MIN=                       1
> 
> Resulting in:
> libcpupower.so.0.0.1
> libcpupower.so -> libcpupower.so.0.0.1
> libcpupower.so.1 -> libcpupower.so.0.0.1
> 
> The naming of the variables is confusing (MIN should be MAJ) and the result is wrong.
> 
> You get the desired result by:
> -LIB_MAJ=                       0.0.1
> +LIB_MAJ=                       1.0.1
> LIB_MIN=                       1
> libcpupower.so.1.0.1
> libcpupower.so -> libcpupower.so.1.0.1
> libcpupower.so.1 -> libcpupower.so.1.0.1
> 
> Correct, but still confusing.
> Here my suggestion to fix this with a reasonable (re-)naming:

I thought we fixed this one. Guess not. Can you send me a patch
to fix this?

> 
> -----------------
> diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
> index 51a95239fe06..a7d7d335c1ee 100644
> --- a/tools/power/cpupower/Makefile
> +++ b/tools/power/cpupower/Makefile
> @@ -52,8 +52,11 @@ DESTDIR ?=
>   # and _should_ modify the PACKAGE_BUGREPORT definition
>   
>   VERSION:=			$(shell ./utils/version-gen.sh)
> -LIB_MAJ=			0.0.1
> -LIB_MIN=			1
> +LIB_FIX=			1
> +LIB_MIN=			0
> +LIB_MAJ=			1
> +LIB_VER=			$(LIB_MAJ).$(LIB_MIN).$(LIB_FIX)
> +
>   
>   PACKAGE =			cpupower
>   PACKAGE_BUGREPORT =		linux-pm@vger.kernel.org
> @@ -203,9 +206,9 @@ $(OUTPUT)lib/%.o: $(LIB_SRC) $(LIB_HEADERS)
>   $(OUTPUT)libcpupower.so.$(LIB_MAJ): $(LIB_OBJS)
>   	$(ECHO) "  LD      " $@
>   	$(QUIET) $(CC) -shared $(CFLAGS) $(LDFLAGS) -o $@ \
> -		-Wl,-soname,libcpupower.so.$(LIB_MIN) $(LIB_OBJS)
> +		-Wl,-soname,libcpupower.so.$(LIB_VER) $(LIB_OBJS)
>   	@ln -sf $(@F) $(OUTPUT)libcpupower.so
> -	@ln -sf $(@F) $(OUTPUT)libcpupower.so.$(LIB_MIN)
> +	@ln -sf $(@F) $(OUTPUT)libcpupower.so.$(LIB_VER)
>   
>   libcpupower: $(OUTPUT)libcpupower.so.$(LIB_MAJ)
>   

thanks,
-- Shuah

