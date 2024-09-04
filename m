Return-Path: <linux-pm+bounces-13581-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 969D596BE71
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 15:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96FEC1C2033F
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 13:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9571DB557;
	Wed,  4 Sep 2024 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S2QJk5dq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863F11DA2E4
	for <linux-pm@vger.kernel.org>; Wed,  4 Sep 2024 13:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725456368; cv=none; b=dayRjqV4m1XbRmXpSaA03LkcrFHccQFc9xJk3wLAus3GNA8jzO6YFCLoECUccD+yeuaDxsTFr24Oz9Zj0dxqdGm8buHqXAMmYbyf+oiaq55EUb2XkhNfrbeuJhZ+ndZbqmihGhbWLZGVUfs30lW14xmlHULpu0stxd22puXfE9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725456368; c=relaxed/simple;
	bh=+UzTOrwTfi1Ek1kSR/0pA7oqP/WQdFFaxGxcdMcbzYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XCP4t7N0INBTPECVZsAk/MsQK7CuhDHexrjTL2kRl7l9gvxw15lOKThFGWVPo/97Cf/yDNirAWr5er6e302ogvLcRcQ6y5XyqTbhOg8GIbLpQJcZj0mAFX/oJZCHRf3G1OXuaKpqZukBkv0OZ+mTI4FecidCgcQRUUAl3hkbOPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S2QJk5dq; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-82a20593ec1so239331139f.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Sep 2024 06:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725456365; x=1726061165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CICro7vkXrs8sHD3fUI2iQ4lanIBBnekvLD7hab6AoY=;
        b=S2QJk5dqmEW1oLiHBKzUjzGiDoUx7aInp0FNakMjaBdQyBygfUzYSXeu7KrKRTOuFR
         1qLtKiJw7oEc1ESqHxuj7/XYkd50J578KtQm90kTIRv4q+9072w2g7I4Acl8LxH22dxH
         rV6fideE2XrJA28uO9+DdLy8AJ6NORPmCG4eI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725456365; x=1726061165;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CICro7vkXrs8sHD3fUI2iQ4lanIBBnekvLD7hab6AoY=;
        b=Wd2oGDvuuV4ier+P4ZUb5o1edzeUIWBU70V7AyHooAacu7uTQq5/LzTgDVoUuVFENs
         APgmGVpRaZLjD+QMti0nUSUcv5IK7mwlYVdESOng5nDUloR/n5IYg+0lCKXbnnsVp40Z
         ziXk/GvRZBqQoDB+0sf3nklF8XIjZLwHh1oFTF77kOMaPWUfYbxla2c8xGcDOywWPxn4
         am7ZPs8wy3kSDAs3yDwD8g+qsUEbJNJ0OJlHijpsqoIBo4fjNWyO9wgElWDIMdy53N1Q
         o1CRfp7656H4fhYxIXr+iX2vpYAKPSOUb8+8gc4YlJxEC+E05FSP2p3dhYNcqRaAJJok
         cZww==
X-Gm-Message-State: AOJu0YwaDCsb+M0ptoK97rAkDF16WtRVuDr7e6FENVPCYAfMkm5Hgv9E
	r4x/M3bseqBDiY7Wt2WINOrCP61u0AVHVjItRAPQMy4e597vkTwoGMsvXN27wo0=
X-Google-Smtp-Source: AGHT+IEluXNl214CW5UNS9t+LtCX+oeGGsC/N5xGJbSzupQnxzp+YC8JdWd11rKuUcXNRSJSOawNjg==
X-Received: by 2002:a05:6602:29cf:b0:803:f97f:59d8 with SMTP id ca18e2360f4ac-82a10d7d132mr2645960039f.0.1725456365606;
        Wed, 04 Sep 2024 06:26:05 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82a1a499535sm362048339f.41.2024.09.04.06.26.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 06:26:05 -0700 (PDT)
Message-ID: <6db4d860-e72e-424b-8463-c82bff08a6c6@linuxfoundation.org>
Date: Wed, 4 Sep 2024 07:26:04 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Add SWIG Bindings to libcpupower
To: "John B. Wyatt IV" <jwyatt@redhat.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 John Kacur <jkacur@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
 Arnaldo Melo <acme@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "John B. Wyatt IV" <sageofredondo@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240827062438.71809-1-jwyatt@redhat.com>
 <ab9e3727-9978-4a30-8bff-e366fa5defc1@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ab9e3727-9978-4a30-8bff-e366fa5defc1@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/4/24 06:41, Shuah Khan wrote:
> On 8/27/24 00:24, John B. Wyatt IV wrote:
>> SWIG is a tool packaged in Fedora and other distros that can generate
>> bindings from C and C++ code for several languages including Python,
>> Perl, and Go. Providing bindings for scripting languages is a common feature
>> to make use of libraries more accessible to more users and programs. My team
>> specifically wants to expand the features of rteval. rteval is a Python program
>> used to measure real time performance. We wanted to test the effect of enabling
>> some levels of idle-stat to see how it affects latency, and didn't want to
>> reinvent the wheel. Since SWIG requires the .o files created by libcpupower at
>> compilation it makes sense to include this in the cpupower directory so that
>> others can make use of them.
>>
>> The V2 of this patchset includes:
>> * the full definition of libcpupower headers that is needed for the bindings
>> * dummy implementation in C of a function listed in the header of libcpupower
>> (requested by Shuah Khan)
>> * test_raw_pylibcpupower.py demonstrates an example of using the bindings
>> * adding myself and John Kacur to the cpupower section of the maintainers file
>> (requested by Shuah Khan)
>> * addressed review comments about doc, makefile, and maintainers file
>> * small style and other fixes
>>
>> The name raw_pylibcpupower is used because a wrapper `pylibcpupower` may be
>> needed to make the bindings more 'pythonic' in the future. The bindings folder
>> is used because Go or Perl bindings may be useful for other users in the
>> future.
>>
>> Note that while SWIG itself is GPL v3+ licensed; the resulting output, the
>> bindings code, has the same license as the .o files used to generate the
>> bindings (GPL v2 only). Please see
>> https://swig.org/legal.html
>> and
>> https://lore.kernel.org/linux-pm/Zqv9BOjxLAgyNP5B@hatbackup/#t
>> for more details on the license.
>>
>> Sincerely,
>> John Wyatt
>> Software Engineer, Core Kernel
>> Red Hat
>>
>> John B. Wyatt IV (4):
>>    Add SWIG bindings files for libcpupower
>>    Implement dummy function for SWIG to accept the full library
>>      definitions
>>    Include test_raw_pylibcpupower.py
>>    MAINTAINERS: Add Maintainers for SWIG Python bindings
>>
>>   MAINTAINERS                                   |   3 +
>>   .../power/cpupower/bindings/python/.gitignore |   8 +
>>   tools/power/cpupower/bindings/python/Makefile |  31 +++
>>   tools/power/cpupower/bindings/python/README   |  59 +++++
>>   .../bindings/python/raw_pylibcpupower.i       | 247 ++++++++++++++++++
>>   .../bindings/python/test_raw_pylibcpupower.py |  42 +++
>>   tools/power/cpupower/lib/powercap.c           |   8 +
>>   7 files changed, 398 insertions(+)
>>   create mode 100644 tools/power/cpupower/bindings/python/.gitignore
>>   create mode 100644 tools/power/cpupower/bindings/python/Makefile
>>   create mode 100644 tools/power/cpupower/bindings/python/README
>>   create mode 100644 tools/power/cpupower/bindings/python/raw_pylibcpupower.i
>>   create mode 100755 tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py
>>
> 

Noticed Rafael isn't on this thread. Adding now to keep him
in the loop.

cpupower pull request go through Rafael's tree.

> Couple of things to address:
> 
> 1. I noticed none of the patches have the subsystem prefix:
>    pm:cpupower is the right prefix for patch subject for all
>    the patches except the MAINTAINERS file
> 
> I will pull the fix  "Implement dummy function for SWIG to accept
> the full library" Patch 2 in your series.
> 
> I want this subject changed to just fix as it is a problem irrespective
> of SWIG - we have a missing function. Subject would be as follows:
> 
> ""pm:cpupower: Add missing powercap_set_enabled() stub function"
> 
> Make this the first patch in the series. I will send this up for
> Linux 6.11-rc7 or Linux 6.12-rc1
> 
> Depending on how the timelines for merge window work, expect the
> series to land in Linux 6.13-rc1. I would prefer to delay it anyway
> so we can get some soaking in next.
> 

thanks,
-- Shuah


