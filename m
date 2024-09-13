Return-Path: <linux-pm+bounces-14204-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0D49789FC
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 22:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 216CD1C222F3
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 20:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAF81553A1;
	Fri, 13 Sep 2024 20:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Are5rVGU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12341547FF
	for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2024 20:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726259563; cv=none; b=SHT2MH/Jss6GxRRK8rTMXB/uIFZmrnWbsZ81FTm+gUpLYcdGYul8CNPUgxpgOjwc0gRACSh1FH+AXEkbyl6DAabHrTx9he6q/+wLv8AJHjEMlOs4En1Gbyy83BXtbl2+7oSH6K6GOpUph0msReQJwrUuvWjrzIiU5JfXWR9xaPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726259563; c=relaxed/simple;
	bh=fwuOPU1DLvYBpaby1f7T+O4GaF9hmmAJNjwmPA2hiHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fEoZ3D0T5ud7fGF+Q1r8yFi6sUury7zRPuohIRJtKWal+idW+DMo5E72FzPP+iDn8TEJw5SYbi5NPMM3k6de43Eshb3r1fRHaGNgWDzWrwIueLh67ey62PxV2FSYSHAGZaRd+WUqlMQqJbKXHcbC9eJ98VEYaQeYweYywUoorww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Are5rVGU; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-82a151a65b8so125600639f.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2024 13:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726259561; x=1726864361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iokW+SbmABqUAeWyfw38lvxQNwNSLZyDxA4tR7mvc4w=;
        b=Are5rVGU6jbKaozH4Fy0JDbJ6EIbL19eomeWq01SQiJeeo1RU471PEdIngendshJJz
         j86iyqFmt6A8Y9VXKqXbfihWKjyPNiQgb+1SRV4kGVwMRk8+6XzjRxFi3vRWOztejjIR
         /PejwUb1uwp+swP3BJhyrSQEEx7yrGxH6k/iM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726259561; x=1726864361;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iokW+SbmABqUAeWyfw38lvxQNwNSLZyDxA4tR7mvc4w=;
        b=qOB5ngpf1CEfvSpN2ENV5IGg/c6XLMR/CVPY8lbol0QZeoV2x5Vf1csrGtCX3Oj0bD
         QunB3SXm6mnB1GFPX2c3p2O9vWXUDn1gpx+BXmy2dafdmCGRglU0bl/BVfgs6eSx/miI
         IjjtPDbIUFL1MvfUdbqLFyfFRkVNJnJLVzuNzb7plbW9LCdm/Mf0V3bj7HLrI2oW5NxU
         e5rJQTKQBsr9DYA/bIYrM3uDyFj7K3cvUqLIL5g+9C3V4dTDnqzl1NM6YxuNwdb1Nv1m
         YKMt4Ff0D8RIdVetD5kA+LqaCsWUxbMoyzPm4FoLU89KbCuZ3hZDPrTdOOu/7qUHbV5p
         R5YA==
X-Forwarded-Encrypted: i=1; AJvYcCXuR2sXd/ylDLQYt5dJHG2eIta92e1nuf3ogdmZE/2ml3Q1IkB42CPVPsmYGu/GOPQixEZDFvQ8DA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZZNgrk2hVBqitlzGhwPzGzasYhgL+tbs5kxOOHRDAzkCcXYQw
	qH05kPCVFaHDezZoiVMzKQgAG904TNdNUrvFg7HplJsW/lRsH+KO6ECgvBNMPpU=
X-Google-Smtp-Source: AGHT+IEdD6C7OvAW/CrmnwlypG0qUaUAvxQCvyhocKiO0g0gICf6CSj1xvAOzIHKdA7tUAT9JJBUTA==
X-Received: by 2002:a05:6e02:1a8e:b0:3a0:4d1f:519c with SMTP id e9e14a558f8ab-3a0848b0589mr77975965ab.3.1726259560806;
        Fri, 13 Sep 2024 13:32:40 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ec1f004sm41888173.61.2024.09.13.13.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 13:32:40 -0700 (PDT)
Message-ID: <4e064b13-2473-4a65-a0a1-94f0edb36432@linuxfoundation.org>
Date: Fri, 13 Sep 2024 14:32:39 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 for-next] pm: cpupower: rename raw_pylibcpupower.i
To: Min-Hua Chen <minhuadotchen@gmail.com>, Thomas Renninger
 <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: "John B . Wyatt IV" <sageofredondo@gmail.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240913201705.7764-1-minhuadotchen@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240913201705.7764-1-minhuadotchen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/13/24 14:17, Min-Hua Chen wrote:
> The raw_pylibcpupower.i is removed unexpectedly after 'make mrproper'
> 
> We can reproduce the error by performing the following steps:
> cd linux-next
> make mrproper
> cd tools/power/cpupower/bindings/python
> make
> 
> We will get an error message:
> make: *** No rule to make target 'raw_pylibcpupower.i', needed by 'raw_pylibcpupower_wrap.c'.  Stop.
> 
> The root cause:
> 
> The *.i files are already used for pre-processor output files and
> the kernel removes all the *.i files by 'make mrproper'.
> 
> That explains why the raw_pylibcpupower.i is removed by 'make mrproper'.
> 
> To fix it, Follow John's suggestion to rename raw_pylibcpupower.i to
> raw_pylibcpupower.swg.
> 
> See:
> https://www.swig.org/Doc4.2/SWIG.html
> 
> Reviewed-by: John B. Wyatt IV <jwyatt@redhat.com>
> Reviewed-by: John B. Wyatt IV <sageofredondo@gmail.com>
> Tested-by: John B. Wyatt IV <jwyatt@redhat.com>
> Tested-by: John B. Wyatt IV <sageofredondo@gmail.com>
> Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
> 
> ---
> 
> change since v1:
> build a non-frc patch
> change since v2:
> follow the document to rename *.if to *.swg
> 

Thank you Min for finding the problem and working with us
to fix it.

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower

Please note that this will be sent to PM maintainer in my next pull
request. This might be after the merge window.

thanks,
-- Shuah



