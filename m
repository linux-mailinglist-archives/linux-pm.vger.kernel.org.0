Return-Path: <linux-pm+bounces-13565-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA0596BC9B
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 14:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A919328580C
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 12:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7631D9344;
	Wed,  4 Sep 2024 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XWRTP3xp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255221D9337
	for <linux-pm@vger.kernel.org>; Wed,  4 Sep 2024 12:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725453679; cv=none; b=Opa5zaA6PVASL22bHQHf5R8WWBb9O+JXZj16gcwgwFVMVaNwZxfFa9kMOoaGfI14gmZefgcV1S/MMcaDTd/9JzV4lbo4ssswG1Yy8+TMD474KsS2mpUsmhofMOhPc6bO7dJF5WbNGPmTs17k+yBSWBcLmyPEhG3HzJ0n3u16GAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725453679; c=relaxed/simple;
	bh=1UISgvlWcv2Y7+TxNQcrzQtP8EfA+ViBiYZQ6iNHTfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k0SClYlqOGZ4i0c/Y9JESq3JKmB26tBqY+khmMq8JK0juStkLpR7yX5Bd9+XpB8lePX8CwsoF5gLMvKOSOEKS3T9Xu1UMXrekrP1XbhGDkf0YIDnomu7rRLFA7RXMI4VVmqu8Rq1qGnZyZR3US9IzzuLoIAq5SaAj/xVY2plCbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XWRTP3xp; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82a1dadc2d2so263669339f.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Sep 2024 05:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725453676; x=1726058476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qcq1FEBxbDWBsgRl9Is3K+I7b8WqhaMddxDrtzjKeh4=;
        b=XWRTP3xpjnxCaL/kXZFPEpzYXiETBamAyfeQVmZu0JDZmIwgIVHa7zH07XfdamXfYt
         YQ/9EiFm8+TIsRjTsjynbKZZjyW04ktmwiu1Xh+sbJE+3/vbXozqEmLNZTUXYXd6gn0c
         iu/sBIfbWIRutqu2p0xCMhs/N205TviFv49Z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725453676; x=1726058476;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qcq1FEBxbDWBsgRl9Is3K+I7b8WqhaMddxDrtzjKeh4=;
        b=UQ0PRjrsm9MDuyDjuYnDU0VhqgC6g3bRm/2fsz0ar9I5JqXgNitYCFsiSZERSwzTGB
         zBqnXUexMfGMTHA3VcStw4b2aY/rPeSjvM3n0hdnVlbaca/L/iYcGD9ZhSZ6TNC8FAlV
         +j59F2F88Jm8P/QZ6Bk5PKsXIrOs5EvTsBY2jlyOmk8gwfhLpRGgc+JSmQ26XjOQfzUS
         DIAxCd52DtptY2UTKtBRW1rFicFvwdxGHziLzoJdi29HnMlQNsBxktJxNzsA8sGogTBR
         qyZ/TT5JxYQMRpGVEm7f/A/TNUhIHMUFv/+lfBiFR3BaLarjR6cam0oBVaqpyFfuzCU0
         n6fA==
X-Gm-Message-State: AOJu0YydTk8+jqj34OKdTWwkpnPXseRknuBRQ2QkEb7yCURcpAEk3zyA
	2D66543/DuoGBUuqpStXtSxdSGj/mh76EspNYZTvKatfwmG8uG8F+VSnSzgLIKE=
X-Google-Smtp-Source: AGHT+IFSTJiOA1xhZqwjBQpQ3S0Ug1iDsLyH/VoJmMKqMb92HEU0RD9+LXZdHya9APtp2pz3k3Stjg==
X-Received: by 2002:a05:6602:1609:b0:824:d9d1:e67b with SMTP id ca18e2360f4ac-82a3428cd59mr1922511739f.8.1725453676078;
        Wed, 04 Sep 2024 05:41:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2dcd722sm3160524173.27.2024.09.04.05.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 05:41:15 -0700 (PDT)
Message-ID: <ab9e3727-9978-4a30-8bff-e366fa5defc1@linuxfoundation.org>
Date: Wed, 4 Sep 2024 06:41:14 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Add SWIG Bindings to libcpupower
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 John Kacur <jkacur@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
 Arnaldo Melo <acme@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "John B. Wyatt IV" <sageofredondo@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240827062438.71809-1-jwyatt@redhat.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240827062438.71809-1-jwyatt@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/24 00:24, John B. Wyatt IV wrote:
> SWIG is a tool packaged in Fedora and other distros that can generate
> bindings from C and C++ code for several languages including Python,
> Perl, and Go. Providing bindings for scripting languages is a common feature
> to make use of libraries more accessible to more users and programs. My team
> specifically wants to expand the features of rteval. rteval is a Python program
> used to measure real time performance. We wanted to test the effect of enabling
> some levels of idle-stat to see how it affects latency, and didn't want to
> reinvent the wheel. Since SWIG requires the .o files created by libcpupower at
> compilation it makes sense to include this in the cpupower directory so that
> others can make use of them.
> 
> The V2 of this patchset includes:
> * the full definition of libcpupower headers that is needed for the bindings
> * dummy implementation in C of a function listed in the header of libcpupower
> (requested by Shuah Khan)
> * test_raw_pylibcpupower.py demonstrates an example of using the bindings
> * adding myself and John Kacur to the cpupower section of the maintainers file
> (requested by Shuah Khan)
> * addressed review comments about doc, makefile, and maintainers file
> * small style and other fixes
> 
> The name raw_pylibcpupower is used because a wrapper `pylibcpupower` may be
> needed to make the bindings more 'pythonic' in the future. The bindings folder
> is used because Go or Perl bindings may be useful for other users in the
> future.
> 
> Note that while SWIG itself is GPL v3+ licensed; the resulting output, the
> bindings code, has the same license as the .o files used to generate the
> bindings (GPL v2 only). Please see
> https://swig.org/legal.html
> and
> https://lore.kernel.org/linux-pm/Zqv9BOjxLAgyNP5B@hatbackup/#t
> for more details on the license.
> 
> Sincerely,
> John Wyatt
> Software Engineer, Core Kernel
> Red Hat
> 
> John B. Wyatt IV (4):
>    Add SWIG bindings files for libcpupower
>    Implement dummy function for SWIG to accept the full library
>      definitions
>    Include test_raw_pylibcpupower.py
>    MAINTAINERS: Add Maintainers for SWIG Python bindings
> 
>   MAINTAINERS                                   |   3 +
>   .../power/cpupower/bindings/python/.gitignore |   8 +
>   tools/power/cpupower/bindings/python/Makefile |  31 +++
>   tools/power/cpupower/bindings/python/README   |  59 +++++
>   .../bindings/python/raw_pylibcpupower.i       | 247 ++++++++++++++++++
>   .../bindings/python/test_raw_pylibcpupower.py |  42 +++
>   tools/power/cpupower/lib/powercap.c           |   8 +
>   7 files changed, 398 insertions(+)
>   create mode 100644 tools/power/cpupower/bindings/python/.gitignore
>   create mode 100644 tools/power/cpupower/bindings/python/Makefile
>   create mode 100644 tools/power/cpupower/bindings/python/README
>   create mode 100644 tools/power/cpupower/bindings/python/raw_pylibcpupower.i
>   create mode 100755 tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py
> 

Couple of things to address:

1. I noticed none of the patches have the subsystem prefix:
   pm:cpupower is the right prefix for patch subject for all
   the patches except the MAINTAINERS file

I will pull the fix  "Implement dummy function for SWIG to accept
the full library" Patch 2 in your series.

I want this subject changed to just fix as it is a problem irrespective
of SWIG - we have a missing function. Subject would be as follows:

""pm:cpupower: Add missing powercap_set_enabled() stub function"

Make this the first patch in the series. I will send this up for
Linux 6.11-rc7 or Linux 6.12-rc1

Depending on how the timelines for merge window work, expect the
series to land in Linux 6.13-rc1. I would prefer to delay it anyway
so we can get some soaking in next.

thanks,
-- Shuah

