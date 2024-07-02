Return-Path: <linux-pm+bounces-10389-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CE79249F7
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 23:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9F531C22857
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 21:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BD5201279;
	Tue,  2 Jul 2024 21:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LVosFV6S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57BE201245
	for <linux-pm@vger.kernel.org>; Tue,  2 Jul 2024 21:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719956049; cv=none; b=PxB4UBP9a1ApEGPSII7bbAkgmm4hS3ZP8XaR7kWY3immz3Cn2owlC+vnCe8L9JtQ8Wab3rMUOy4eLaPJNkZ2ORjwQ707rewFXo+XbuGVlq4r1EpL3AxpH5y8G7cCFiieXWuS198d3zQILf9WnWyzu9YhwmGRLVCdDUIKCVBZjKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719956049; c=relaxed/simple;
	bh=ELI3qm3FmCNzQfbVTY5hJV3PlWzVeUfnT25kFEvdp+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HjL1hVwCQNAUhAnUtc8Y4d9Sy4zlGYx0auNsocFw2hIm7Ftu+MHQGrQlLVj2V9oHcEaInL/wF6IPiw2LmiTkjDLdOkr0aoE7uZfDN+wdZ5ajwTna6CvqVuIhnipsBqdSOk0piBrAMcnuhhA2gCEhAXBIcKIc8hh2cUhX5tv6mfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LVosFV6S; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-375dea76edaso2655335ab.2
        for <linux-pm@vger.kernel.org>; Tue, 02 Jul 2024 14:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719956047; x=1720560847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b1WgNk/YPEbRVNBSRfJrE9za+i3oxO1I0TjYFVdi7kY=;
        b=LVosFV6SOdwJE8vs1ZKkpRVEu6+F9AHp25lwTL5QspYf7XlLKUOVCSY0dnvhK3Dddl
         0xcwNkUCu+38hls6fOoVMhNZCbZ/fzB8Vk8MeAgmCLCUBwt5Tb7foz/sPpW8cdpAMNXI
         LfSJpmOqEkD109N2zM2Wd/N3+1pkIbX2oOE6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719956047; x=1720560847;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b1WgNk/YPEbRVNBSRfJrE9za+i3oxO1I0TjYFVdi7kY=;
        b=DAWFmC6qYVtSBYi4hpJ4t1EH3w6Mo9qX3sTJfOG0lnsklTxHgw4PbMS8l9mlj5WXhK
         SzlbrUaqcsz571h2ZkwVPKKI5xbiLOHaA+d9hHSxjanmcc97YWYqiSqgwT8aOqkKGP4W
         Er/jcd+VSz7fONVK9U/VNb6Rj7sktiBfFCisLuoLX8ka2f1c/VV9/72gcZa/o8sEKqCP
         pOD6X40Et9P3TYgTBzKBFgdtXjMzKO1dPeK7V3tf7Tfx5ax0cZIshtXw6luWIGSUpueM
         B1xpNzpYN5tZhJ9tmChYVNcjfMhbxnvhjz5mejHciNz0kuhkydlL76rmnSwzDNJljLtH
         lvAA==
X-Forwarded-Encrypted: i=1; AJvYcCUPa/kV/3U2kCU6S3q4KwnrQIkufuSrGMBu+Kt/9bNoz3vZYvO9uCJEv8MZim1O3myB8kOhkGyqDyEMlzcTac0XP9VEG8iW8qA=
X-Gm-Message-State: AOJu0YxKcUo/q498c1KzMe80gCxsc/rK+WzY5BZ2WX2feRYEoagNac37
	aru2alhVVeg/4PlYPr2EAV+9b/eML5vXfpsI+VfT0JDE/RQyhTcZqou+e8PTCD+waGwTyHS0jYe
	o
X-Google-Smtp-Source: AGHT+IHtaBQC52DDcEJ8qeKFFOsLfGso6U0Z9VOH3B7LnIkEUyY6IjpKReJg7jT8NZRnXtU9141MDQ==
X-Received: by 2002:a6b:fe09:0:b0:7eb:66a5:d1c with SMTP id ca18e2360f4ac-7f62ed686a2mr915246239f.0.1719956046707;
        Tue, 02 Jul 2024 14:34:06 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73e08428sm2972009173.77.2024.07.02.14.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 14:34:06 -0700 (PDT)
Message-ID: <753c55df-82d7-4756-861b-62e4e59c7615@linuxfoundation.org>
Date: Tue, 2 Jul 2024 15:34:05 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpupower: fix lib default installation path
To: Roman Storozhenko <romeusmeister@gmail.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240702-fix-lib-install-v2-1-9b84dcd3c22b@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240702-fix-lib-install-v2-1-9b84dcd3c22b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/24 01:56, Roman Storozhenko wrote:
> Invocation the tool built with the default settings fails:
> $ cpupower
> cpupower: error while loading shared libraries: libcpupower.so.1: cannot
> open shared object file: No such file or directory
> 
> The issue is that Makefile puts the library to "/usr/lib64" dir for a 64
> bit machine. This is wrong. According to the "File hierarchy standard
> specification:
> https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard
> https://refspecs.linuxfoundation.org/FHS_3.0/fhs-3.0.pdf
> 
> "/usr/lib<qual>" dirs are intended for alternative-format libraries
> (e.g., "/usr/lib32" for 32-bit libraries on a 64-bit machine (optional)).
> 
> The utility is built for the current machine and doesn't handle
> 'CROSS_COMPILE' and 'ARCH' env variables. It also doesn't change bit
> depth. So the result is always the same - binary for x86_64
> architecture. Therefore the library should be put in the '/usr/lib'
> dir regardless of the build options.
> This is the case for all the distros that comply with the
> 'File Hierarchy Standard 3.0" by Linux Foundation. Most of the distros
> comply with it. For example, one can check this by examining the
> "/usr/lb64" dir on debian-based distros and find that it contains only
> "/usr/lib64/ld-linux-x86-64.so.2". And examine that "/usr/lib" contains
> both 32 and 64 bit code:
> find /usr/lib -name "*.so*" -type f | xargs file | grep 32-bit
> find /usr/lib -name "*.so*" -type f | xargs file | grep 64-bit
> 
> Fix the issue by changing library destination dir to "/usr/lib".
> 
> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> ---
> Changes in v2:
> - Enchance changelog by providing more details
> - Link to v1: https://lore.kernel.org/r/20240623-fix-lib-install-v1-1-bcbd03b78d87@gmail.com
> ---

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/?h=cpupower

thanks,
-- Shuah




