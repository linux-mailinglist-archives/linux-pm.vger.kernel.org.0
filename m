Return-Path: <linux-pm+bounces-22561-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D05EA3E2EF
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 18:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 211363B23F0
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 17:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD621212B3D;
	Thu, 20 Feb 2025 17:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B86QtlY5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16D51D63D9
	for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2025 17:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740073055; cv=none; b=b64A76IVvae5+aDTqKtx5gVktLerHbrVp6dX/cAgZXSRYp6hHFo32L4hE/l+hY5BiHDCNPLHRTYYpQ9w+r20ZHUQaQJOF3G8KYzOSAdQgrHCxmRhP+EEfH48ZBJ5Xd8K8/Y+SOeNsEXbBnIbS8MSYKv05o/ioids1WRW5kTeBs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740073055; c=relaxed/simple;
	bh=7OqtMzzZ4TQXY1qO181+yuG56Lm6incgS9Z9e/8VJgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZTZHGojRGAwrPoYjzKX9HsT9nN/0WyYwUpixU01z9XNYzisfBSCPl+7hHbPNHC5q5UJYbOEweTBukInOHY7yp5Ocvvuvw6YfvQB+FSFs24MJX6XxMHi3q7XmLUWhJuo90Au8Sq1/NARnb3D4VrIL6MR7CkJ15bDrqFScQaV3CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B86QtlY5; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-8559461c2c2so29475639f.0
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2025 09:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740073053; x=1740677853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lnhaKkAMNEE9ZP4VliJW7pWKwvVo6cP4lX15YihDuIs=;
        b=B86QtlY5Y8HHjqN7QiRbFNL3KyXD3rkQkmXLVUO2n9Q8WLuvyLijkmNN3PQNMPfL3i
         MzIfK4WFE+GnpdV8Z7q/qvet3KZmlHgLSxPUUxdZt3A3AL3hfx2wj1vCSgY4wLHOM+ts
         zK18urVlo2esvZYiOWdavZRNehOr3cjI9GU+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740073053; x=1740677853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lnhaKkAMNEE9ZP4VliJW7pWKwvVo6cP4lX15YihDuIs=;
        b=EPvr6d80RDvDGr/YLbEr8uQnU0K9usdrapzwId5D8rS4v7bKLCR/BMo4MhodZ3Fcu1
         R+DoC0JbtzgIVJ8ZKKEpzt4OlCjirkc1Rpm36ytgRcCmzSW0n7EiSJ4zdri6Gi5bpd+y
         PXq+VN4XXN8TZX6KCinGA7Fpoz2i/TSG4YB5gs/4FvAq5V6AQARC/CiXFtxPZVcnk7qK
         TOTtghJ0aeOyP8oICJz4c51DpS08Ro+pDBrOscQHClEjk7IDwIGJkn05nfc2baV2NVzR
         UMvwC00xcUrudOU4Un/1UYOoMOHNqzmltqZtZ+5lq/Jr354iJXckvDuBF1HDxQ/XJWDw
         oHKg==
X-Forwarded-Encrypted: i=1; AJvYcCWlSbXRZhLaj/Ltins0twYY3WA6bH5/sL0M/7ILOFuqvkOfZW4G9wgvw8EavCYQErZ231Wf9jOmVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YymQ86NKm/uCBVgpTxRU6gPXnxqx6aqAIym9fNudT4CXqPYvE90
	Sjp7iu00NthMXIi4+laDIbJL2oz8NZkoYvsrxmDN4rCIdWA/JlVkIYnEuG9Vxxs=
X-Gm-Gg: ASbGncv8MYeytFHkbQZM1oY48kggwVmVH8koZY2vSIP5UnRv/P0inmNePGzbVF8jKn/
	qLNri2jFifWGDnZe6QKrobJa7vSfllQAjeKhbBpulTyoeTKITnRsnvZInnCVl1+hYtKAXEYNfxN
	TbOtuZMPLi9vDcjurbi42/kZDfEmOIBLVNuGRg9JMomhuUnUE+N6QY8iKsi38/3mfgcaFD7JJ5R
	Kpu6ibuXjubD8WPR+S9rGIiMLUU5Io7LbN/AomT/UbdXSKtTJje+626X4WhBLjX5oDJRE7yOz8i
	BY7p+kOidp2gsfCIJ+bRe1148g==
X-Google-Smtp-Source: AGHT+IEQDhWjRFdUbWy0dkLYBALEN/O88UerdzmcLg7I0kpse9O0b+B4HUdXcLsKRY2NrU2uQGNx8g==
X-Received: by 2002:a05:6e02:1948:b0:3d2:6768:c4fa with SMTP id e9e14a558f8ab-3d2b538c333mr102737215ab.21.1740073052986;
        Thu, 20 Feb 2025 09:37:32 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4eea13a1acfsm1816750173.109.2025.02.20.09.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 09:37:32 -0800 (PST)
Message-ID: <929c1d63-e3e7-432c-b34a-8953662297ab@linuxfoundation.org>
Date: Thu, 20 Feb 2025 10:37:31 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cpupower: monitor: Exit with error status if execvp()
 fail
To: Yiwei Lin <s921975628@gmail.com>, trenn@suse.com, shuah@kernel.org
Cc: jwyatt@redhat.com, jkacur@redhat.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250220163846.2765-1-s921975628@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250220163846.2765-1-s921975628@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/25 09:38, Yiwei Lin wrote:
> In the case that we give a invalid command to idle_monitor for
> monitoring, the execvp() will fail and thus go to the next line.
> As a result, we'll see two differnt monitoring output. For
> example, running `cpupower monitor -i 5 invalidcmd` which `invalidcmd`
> is not executable.
> 
> ---

Note that everything below this gets thrown away.

> V3:
> - Modify output message content
> 
> V2:
> - Check return value from execvp and print message for invalid command
> ---

These version information goes after the --- below the Signed-off-by

Note that everything below the

> 
> Signed-off-by: Yiwei Lin <s921975628@gmail.com>
> ---

This where the patch version stuff goes. I fixed this for now.

thanks,
-- Shuah

