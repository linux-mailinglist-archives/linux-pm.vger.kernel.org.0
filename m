Return-Path: <linux-pm+bounces-13743-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA7996E713
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 03:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C0ADB22287
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 01:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7679C179BC;
	Fri,  6 Sep 2024 01:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c+0xw3Ez"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718A5186A
	for <linux-pm@vger.kernel.org>; Fri,  6 Sep 2024 01:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725584588; cv=none; b=BP7OCmoaBLSCqs76iqR5mIX014p1mUnPm0cK3mSgieEE6YReFvCsu0SGXtFww74tnJ69usNZm9LrOu9hC8ZVzm9OJLp5ClNEw2QEKMS9jrfeau9P47byY18OHF+btIwYjNdqXTmDlt9QluzqfNUP8t+kwMjlJueqvH1nTpznpp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725584588; c=relaxed/simple;
	bh=z4m4o2/drN603NiUF70RgY7/WIJvRfsJfDnzeGXC0qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PDgHUb2oVWBSsUNg/Zt7bMCYKwHLGmFeBE2lPm/9oiB6CUqGJVVZM2Hxo1+iI3RYYQ2AZQiNAarbSnTgVwQMAubnZxPjjEjzX2/bgY23OnL4KI2GG6k9X+8fFxk9CthF5ihO7PR5hHqPgRiVX/DNW4/ugL4O0Bq/J2TtQfpkg7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c+0xw3Ez; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2068acc8a4fso15955645ad.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Sep 2024 18:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725584585; x=1726189385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dOGqKcCZS3m+coWkXftBCip2jTDTfVTP0RKG8IcdHp8=;
        b=c+0xw3EzIQpfKnDqnjyAQkd4MqwN8bJHtuntHwTTjH3O0zzt4bQ4qRq6VYouowktxR
         P4nDEsyJNQ8TYg8UyhniRwyvKvK18vHFVnzqbyC6yn0kmQPH3aL+xq70JqXSCEVwpmI4
         E9Gs03Ax7YB0LfM5yPN9cioKkObDE6HBYxXsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725584585; x=1726189385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dOGqKcCZS3m+coWkXftBCip2jTDTfVTP0RKG8IcdHp8=;
        b=EWcyUS76hjdQKeBWhDeCci9b3WMruVCyEneRBEN/DndpiOGo8HL7AnNeTHCpGXG3mL
         ivpA2WZhPvWx9fs5bBmM1l1N8UyzvXJdTJUEph3fCQVZwAXOa0bwzPUnRKEy6VV7xtIA
         CFQpJppNBItQLsEIqNTWxHfmfff1cctoJh/9mEF5nXeXYW7koUq0itOTtlfY8dnDVZ9G
         9r1fSPSut2W0UZZMHebPbBl3IVV+rW/6wIQaEJMpJmJ2M/NIVFhiSDQFDY4QZJel0H0F
         E/x3x+H1kpG2kSEjuYT9NUgvcOJVF+5mH7jURgHaKGcIU6tia2wPQ7XiarsejYrR76k0
         nc1A==
X-Gm-Message-State: AOJu0Yz/6dagt5W87fdAbW78kaWaE+4JN5HSFyaA7UPOlGFkjfhLXM/G
	NI1OPVdrva+mOa/OtJ+ZLyTQYnFvmMB5lcmIj9h+SPtmP57SbIGHa8oXoCpROF8=
X-Google-Smtp-Source: AGHT+IGQS+zlVQH8e863up19r0CoJnbE9Az0nr/PClGUOKV1rszxTZ+R67nI2CgGD6MOFohQXJrtIw==
X-Received: by 2002:a17:902:d4cd:b0:206:96ae:dc57 with SMTP id d9443c01a7336-20696aee0a4mr135653185ad.48.1725584584485;
        Thu, 05 Sep 2024 18:03:04 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea37ccdsm34167785ad.168.2024.09.05.18.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 18:03:03 -0700 (PDT)
Message-ID: <428a42ef-2a3b-41ec-b1a0-7886d52d621f@linuxfoundation.org>
Date: Thu, 5 Sep 2024 19:03:02 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Add SWIG Bindings to libcpupower
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>,
 Tomas Glozar <tglozar@redhat.com>, Arnaldo Melo <acme@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "John B. Wyatt IV" <sageofredondo@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240905021916.15938-1-jwyatt@redhat.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240905021916.15938-1-jwyatt@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/24 20:19, John B. Wyatt IV wrote:
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
> The V3 of this patchset includes:
> * renaming header messages as requested and adding people to Cc as
> requested
> * moving the stub (dummy) commit to the front of the patchset
> * small punctuation fixes
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
>    pm:cpupower: Add missing powercap_set_enabled() stub function
>    pm:cpupower: Add SWIG bindings files for libcpupower
>    pm:cpupower: Include test_raw_pylibcpupower.py
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

Applied the series for Linux 6.12-rc1 to

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git cpupower branch

I chose to walk through the steps without installing SWIG
to see what make would do.

Some things to improve:

Running make in tools/power/cpupower/bindings/python directory without
installing SWIG gives me the following errors:

make: python-config: No such file or directory
swig -python raw_pylibcpupower.i
make: swig: No such file or directory
make: *** [Makefile:27: raw_pylibcpupower_wrap.c] Error 127

I think it would be good to provide better help message walking
user through installing the dependencies.

Documentation/Makefile is a good example to look at for useful
message on the dependencies to be installed.

You can send me patch on top of
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git cpupower branch

thanks,
-- Shuah

