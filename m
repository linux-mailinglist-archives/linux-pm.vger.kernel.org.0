Return-Path: <linux-pm+bounces-7448-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 635F28B9DA8
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2024 17:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 946781C2257E
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2024 15:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FA115B566;
	Thu,  2 May 2024 15:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="etufmLNs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D41C15B0E7
	for <linux-pm@vger.kernel.org>; Thu,  2 May 2024 15:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714664522; cv=none; b=EGC9DcEV5sA8kROEvPqtMKc1cMUQde9MC6Wl2imSIGU9+F5lhE1Kf5MmoQJNq/C3WZdGrDYwlW3hXN9Tl3vgT4Yd+IAB1peBE4RcOA8RQxxwUjpbeclS2uSpJZeBWOfUO1JQ6s6v0tFZ04VwAdu5Vs1PuwZ+DjdlWUojSd1hKOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714664522; c=relaxed/simple;
	bh=BfGYmqaEPgJV/sPLwkgpPXEEBqMjyD1KiEQoEP6Ry1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y1Qvq+Qn+7taq7LV3h44oOPQs0U5IuVNvMACh+bNVRNnrbTN+kjJaZPc8Fus6cfkolvr7Z5GbCsJTfP6E7ap6J81MruQfa6PHadi/oDtpk+D3KBgPGp/sPQw6PJ9CPOxcdpWWtaNHVwtw2NqJYLipTWTJwi7i7m0cE+ZR1KZHfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=etufmLNs; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7d9c78d1087so52420939f.2
        for <linux-pm@vger.kernel.org>; Thu, 02 May 2024 08:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1714664519; x=1715269319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BfGYmqaEPgJV/sPLwkgpPXEEBqMjyD1KiEQoEP6Ry1o=;
        b=etufmLNs0h71ujgXcqdh3Yl8bpyHvCTRFwM5OvxXtO/h6UdmfSZppk3Qkd7ij+V/Rk
         zP5OFBNWtUn1kB5v2uQVXk4h/aTyKDmBvtZyGlJW/Yuc8om/jhnccGzgVT4zfLKcJj11
         EYnFn20WSCgSdFTjNWKUh0DtMGBTS9MSfMOew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714664519; x=1715269319;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BfGYmqaEPgJV/sPLwkgpPXEEBqMjyD1KiEQoEP6Ry1o=;
        b=RPUCjHxFCFZw8mpfC533g4FPEZFIiF1nhFp9AwVdxHmjWT1B6LpRq9/8P/B3+A8zcA
         24sXX1CA7hutYfY+5xisuCqzndPlxxGjQ83VjfiYJIhAsDEPI9e2iOnUykj+zz4aozly
         3IuGKeXFFKNvMalecHOWu86oTJIQPEYZVVcGbIMXaZedBrGsCpOXbNYWdJ9Hb8nvT0b5
         JMkMz8r0mbzA6/QVMSqgBDZvr8wobXyBzegcTfbJaLBVCKLABQBXK8U0bD4ZEhqtIl34
         +NdE/An03xm1hrr4GxVrUVmonhFBwLYF3D0EgFu5oCygqcose7Z4GxOM8j4a9SzP4TZn
         FsCA==
X-Forwarded-Encrypted: i=1; AJvYcCWoyC8FpalUQ5cpRVv59qMI65p7aRWqRvDpE/0AK5mX3VkramAr+UrdoSAbhirGVaVXkXaZoz3eMMe1x/gapk8fptD9e+MsSR0=
X-Gm-Message-State: AOJu0YyVBbvpka/2WKKF2OOIpVSb1EtPWpzNhzYKaFdE9ZTMlrSVbHh/
	1H2iclKtSC6OUJ83RzGR6J2lFcf/7uY2u3J7exYzZiCkS1fS4fad3+Mp2TMZipc=
X-Google-Smtp-Source: AGHT+IEC5dfuT+FFk7h1TTMiHug2ythsJtqV6OG+J23mQi+UO++Mtkz8gjQSmfD/X833Y1BBw82JKw==
X-Received: by 2002:a5d:860e:0:b0:7d9:eeb8:ddeb with SMTP id f14-20020a5d860e000000b007d9eeb8ddebmr18108iol.2.1714664519677;
        Thu, 02 May 2024 08:41:59 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id j11-20020a05663822cb00b0048813dbf4c2sm262931jat.156.2024.05.02.08.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 08:41:59 -0700 (PDT)
Message-ID: <5cab1797-aab0-4f49-b9fe-cc0520462067@linuxfoundation.org>
Date: Thu, 2 May 2024 09:41:58 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/power/cpupower: Fix Pstate frequency reporting on
 AMD Family 1Ah CPUs
To: Mario Limonciello <mario.limonciello@amd.com>,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, trenn@suse.com,
 shuah@kernel.org
Cc: ananth.narayan@amd.com, gautham.shenoy@amd.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, rafael@kernel.org, Perry.Yuan@amd.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240430083706.69641-1-Dhananjay.Ugwekar@amd.com>
 <13bcd356-a5a0-4cf0-9222-bccc01177032@amd.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <13bcd356-a5a0-4cf0-9222-bccc01177032@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/24 11:06, Mario Limonciello wrote:
> On 4/30/2024 03:37, Dhananjay Ugwekar wrote:
>> Update cpupower's P-State frequency calculation and reporting with AMD
>> Family 1Ah+ processors, when using the acpi-cpufreq driver. This is due
>> to a change in the PStateDef MSR layout in AMD Family 1Ah+.
>>
>> [ dhananjay: commit log, tested on 4th and 5th Gen AMD EPYC system ]
>>
>> Signed-off-by: Ananth Narayan <Ananth.Narayan@amd.com>
>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Thank you. Applied to

git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/ cpupower
branch for Linux 6.10-rc1.

I will include it in my pull request to Rafael.

thanks
-- Shuah

