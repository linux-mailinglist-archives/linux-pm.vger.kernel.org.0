Return-Path: <linux-pm+bounces-10300-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAEE91E8B2
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 21:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACEB21C214C1
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 19:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C3516F85E;
	Mon,  1 Jul 2024 19:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Iu451LQO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29F416F848
	for <linux-pm@vger.kernel.org>; Mon,  1 Jul 2024 19:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719862604; cv=none; b=M72WMzxNFwLvND3pAl+ZsCeOKDWeIWvZNWk9d5ycV1e2IrAQ96FshJWuM0bbSNbARztuFv3Hjz1ZPwk2q/Hrv29cTyoy6q5M0ATlnQpXYc1Zfj+kSMofvd+YD4LjoP3jVBBDO4gUFz+kbtrL5yCLwWwX9Kr4DHieZF6LtN1mFLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719862604; c=relaxed/simple;
	bh=9hcTUlw54rfRZbB/lQZJnKhUD6x0xuQXJIBd1zmJMFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHXWWcxohWBpy4J4IvXvZSeBcxtsecawAw5X9qCEb8knuu6QHlMptLp03xyG4O1TJkXzqLuE5j7nFB8EaGZiAFyVIkPz0G0qScB5vE/yVh8J0sEre1uQO+lZYOsGWrhc/agbryVJHBeVtFzegBMeigVJ2JtAaPQTWGmK+C/HzVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Iu451LQO; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7f4cfed0fddso8196739f.0
        for <linux-pm@vger.kernel.org>; Mon, 01 Jul 2024 12:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719862601; x=1720467401; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wx9lXf0oziS1rVD8821+SPz53RbUxh/GzQzA4Px47hc=;
        b=Iu451LQOnNBnbfRTiex8jKKDd8LJkURM3GE4FbGC41skzgQBCL0aeqY7oSdyT9/aqN
         Os2SqdtFOIn5NiKETpbBgC4nHUsvKfwf4ky9A44Phd8Oc3x9QLmVqHydU4sabcVdBz1a
         bNYm2NfvmJnvaBg5Qgc7dXZ5sn9g5To/pB5H0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719862601; x=1720467401;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wx9lXf0oziS1rVD8821+SPz53RbUxh/GzQzA4Px47hc=;
        b=O+jwAo+JynVrX48PKPQoA4YbdXOVJ2slrnGq2xgiGqDnVgAMasnJSdVohjGMhPrMPj
         hQsRBQzbhomv4VOQHTAucCPiGybGk9ST0Zfe7txL88A7SBhlTEzdRQ4gDVgsQ2vyx7ga
         QzwBzuVcMkD2AI+19NE8/BsuXr3GRGKTwhOyQjNUXi2mTbcOLuepm9sI1RtP8tCdSk/C
         HuDfUZqZwKU3fzS/VZOzUXbzwEVdd3d069iZWeJpQLqoA9I7fPy419Y6dl/Q6hsFSigN
         y1Trxe3xW5D93i2ow1zjoXZks5QI1970q213XxcMAWsHFuYGmOX8q2tZhLfNZqKT24OQ
         J/Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWnJeCcC/ICQA04O4xUXEDQtaIea4NXZqCqytax9p8vHVZHti/vwT6JFGuMXWn0CDZ6mUb09mVTgQ4uhluXFtEOk1XoJKzzHz8=
X-Gm-Message-State: AOJu0YyDuhsu+TAp3QFg2wxNt2hUfKgi9WSNYP2nKbk1IwJSH5fZnSuE
	4O7/nHihSRMO7vbBkJPpxBK9ZU4/rFXwMu7sDUFiC/ZUf+F//Oqf0bKqslo3adw=
X-Google-Smtp-Source: AGHT+IGA8fvxjOPBZD9A3FtIjo5IK9zJ+aI4kzcbItEa8WKo5wbjmNw/+0GSpqNEFSYBZ1h+f8QJ7Q==
X-Received: by 2002:a5d:9b8e:0:b0:7f3:a20e:c38f with SMTP id ca18e2360f4ac-7f62ed4cf57mr572225239f.0.1719862600759;
        Mon, 01 Jul 2024 12:36:40 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7f61ce9d85asm211315939f.18.2024.07.01.12.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 12:36:40 -0700 (PDT)
Message-ID: <8be80c5c-b405-4dae-bd91-83db29c94291@linuxfoundation.org>
Date: Mon, 1 Jul 2024 13:36:39 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: fix lib default installation path
To: Roman Storozhenko <romeusmeister@gmail.com>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240623-fix-lib-install-v1-1-bcbd03b78d87@gmail.com>
 <cfee36c5-c5d9-49db-bc94-c6e5fdb77840@linuxfoundation.org>
 <CALsPMBNd67iYF_tFQbBH=e3D0Mjn+KOv6sA1x6Hr940_C+sjMQ@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CALsPMBNd67iYF_tFQbBH=e3D0Mjn+KOv6sA1x6Hr940_C+sjMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/29/24 06:20, Roman Storozhenko wrote:
> On Fri, Jun 28, 2024 at 10:44 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 6/23/24 07:10, Roman Storozhenko wrote:
>>> Invocation the tool built with the default settings fails:
>>> $ cpupower
>>> cpupower: error while loading shared libraries: libcpupower.so.1: cannot
>>> open shared object file: No such file or directory> The issue is that Makefile puts the library to "/usr/lib64" dir for a 64
>>> bit machine. This is wrong. According to the "File hierarchy standard
>>> specification:
>>> https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard
>>> https://refspecs.linuxfoundation.org/FHS_3.0/fhs-3.0.pdf
>>>
>>> "/usr/lib<qual>" dirs are intended for alternative-format libraries
>>> (e.g., "/usr/lib32" for 32-bit libraries on a 64-bit machine (optional)).
>>>
>>> The utility is built for the current machine and doesn't change bit
>>> depth.
>>> Fix the issue by changing library destination dir to "/usr/lib".
>>>
>>> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
>>> ---
>>>    tools/power/cpupower/Makefile | 10 +---------
>>>    1 file changed, 1 insertion(+), 9 deletions(-)
>>>
>>> diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
>>> index cd0225a312b4..6c02f401069e 100644
>>> --- a/tools/power/cpupower/Makefile
>>> +++ b/tools/power/cpupower/Makefile
>>> @@ -67,6 +67,7 @@ LANGUAGES =                         de fr it cs pt ka
>>>    bindir ?=   /usr/bin
>>>    sbindir ?=  /usr/sbin
>>>    mandir ?=   /usr/man
>>> +libdir ?=    /usr/lib
>>>    includedir ?=       /usr/include
>>>    localedir ?=        /usr/share/locale
>>>    docdir ?=       /usr/share/doc/packages/cpupower
>>> @@ -94,15 +95,6 @@ RANLIB = $(CROSS)ranlib
>>>    HOSTCC = gcc
>>>    MKDIR = mkdir
>>
>> These are set when make invoked from the kernel main
>> Makefile - see "make tools" option in main Makefile
>>>
>>> -# 64bit library detection
>>> -include ../../scripts/Makefile.arch
>>
>> This does the 64-librray detection based on arch.
>>> -
>>> -ifeq ($(IS_64_BIT), 1)
>>> -libdir ?=    /usr/lib64
>>> -else
>>> -libdir ?=    /usr/lib
>>> -endif
>>> -
>>>    # Now we set up the build system
>>>    #
>>>
>>>
>>> ---
>>> base-commit: f76698bd9a8ca01d3581236082d786e9a6b72bb7
>>> change-id: 20240623-fix-lib-install-3b7dccdbdf45
>>>
>>> Best regards,
>>
>> What happens if you cross-compile with this patch? Take a look at this
>> commit that fixed cross-compile:
>>
>> a73f6e2fbe8077811ea9546e0d44a7533111f0ba
>>
>> This makefile has to be in sync with the rest of the tools - see
>> "make tools" in the kernel main Makefile.
> 
> I have done this using "make tools" method mainline kernel and the
> patch for x86_64 and risc-v:
> 1) x86_64
> $make cpupower
> $ sudo make cpupower_install -j8
> $ cpupower
> cpupower: error while loading shared libraries: libcpupower.so.1:
> cannot open shared object file: No such file or directory
> 
> Works with my patch, and doesn't work with the mainline.
> 
> 2) RISC-V:
> $ make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- cpupower -j8
> $ sudo make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- cpupower_install -j8
> $ cpupower
> cpupower: error while loading shared libraries: libcpupower.so.1:
> cannot open shared object file: No such file or directory
> > Works with my patch, and doesn't work with the mainline.

Please update the change log with the information you provided above
and send me v2.

thanks,
-- Shuah

