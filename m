Return-Path: <linux-pm+bounces-29017-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D00ADF98A
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 00:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03CD97A4180
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 22:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE6127FB2E;
	Wed, 18 Jun 2025 22:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NTD9eQn1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5110A27E04D
	for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 22:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750286629; cv=none; b=DYcTVCz/eGr4OvHUUJthMoPe59SHFKQn+JI5Vwcw2MZNv1NYKHUZtNoj9yHYHgVD+PKNLIdMj4ELcp7uesgyAPz9ecd3OaTKIENX8mAiu/rocU7XBLtTaHcKL6vC4+S3SSaHzknkpQL4CnU+9nLRnA7HN3EYBETlGNUhZltj1ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750286629; c=relaxed/simple;
	bh=7C29pda3Os4hXi9P50dJ+HkdgVgdm4Pec7nJ3piopZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qob2nzpBvo91jYgH6QQdHdDYLrOkG6FqFsKJH9hwpwUj5+IoeKox7iZogL7dg/EMzJVhB5MQJmRYD5gBXn1lTH5TKMy2ngEVQ/Wyh51a4mwpt+TsOw9THoq/7DXtLOaGCD6TVruQdaLZQeEH51OOXLRTgAmtRHKVu71F0V6bDLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NTD9eQn1; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3dddbe5f8aaso621675ab.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 15:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1750286626; x=1750891426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G3vMQgaSAr8pHAxdoofscIYDx1FiHrooeZ+m1KEAAQI=;
        b=NTD9eQn1N8AlJ6nXia8gu+neLP6b4QruLMJ2hCZRPPyS0jB/jpFlSU8Vv0JeavkBgA
         4DqC0fLD3728bF2ZuNcH5CSzrDQkqK1/MTUZMaKhp6KdwUQXp1eJzvmuCuCLV1a5OakV
         j8qpF5V5sSgyjS/ND4ylSff+eEE26v6aHyfpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750286626; x=1750891426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G3vMQgaSAr8pHAxdoofscIYDx1FiHrooeZ+m1KEAAQI=;
        b=tukBonrBXu6S2YyzGNaWjPJ+EtylDcBLz0WSV3u2ti5L1cJOJOnNK8fcPBHAtJe1CO
         /a64jWB9ROZa0iuJsuUYss7viXUhuK96P6yrCYFfY6nLmubc46jqqefyiBAMLNutiWB1
         sy9Liu8CqR2ONg3KbW2D9iACsYDFwI3ae9WbbICsMtJuzQDtHn++eBz8H1N9CSmPOLfM
         1GyxR9tXTSW02Prcgc/C8bTAVIU6fqsLYp5K7iohaERqA528WZdW7FGtf1cQT5ZQ8emZ
         3t4tjsQ0A2XpNIhvoxTIYV9zNx8hCorbPqsT/QZxYPL3IDtk7czlaRDZO+8iw+si88WT
         aCvw==
X-Gm-Message-State: AOJu0YzO+Pz/LeE8UQ9AgkFYXW25Z9u7e9+kAQIVKRmhsz8Q13COn40K
	40ACKdvg/Qm0BfYYJi19RSRbQfkRqDh2SPvcJiLlaZ8/YbtWRVr3veQ3obaZVqU7+Vs=
X-Gm-Gg: ASbGncsHm9kIubR6i1/vwU6JNooYFaOYCVt2EWTI9Lk1hiECG9EMSYyatxdBGgMaSHU
	PuUms/jIHjfGS244P8/jNiN630apW+UcHoJNfPMz1U6c0PPMmUnVLK43OCYarFecBiQ5v6IWNWs
	zIYZfGj4ZlX7tmBG7HCT5W6167GSe57MNaKZSq/Hlmzu3dLNhWXbjEK2dZeG4ziudeUEdLbm3Ji
	8vJ22dLZZkDJgW7Sj59eVHswr8fuo+ittOF4Tn43I1fYuAFqp5xVnjSDJcwZeJUFVMyjqqKJ9Cd
	fjcAeh9DS9+vCPqLKIDq3drk8WtPrF6UvSvrrLxjnkRriR3Em3aAUiXKF39fy4gtQUbR4ViwiA=
	=
X-Google-Smtp-Source: AGHT+IEMut0sjA/9CDO/vrij1jeyFo8AI2L7cAgeng3Ed7laLSRLtq3UWRU1AmzOiPi0tBvNRQ9u6g==
X-Received: by 2002:a05:6e02:2784:b0:3dc:879b:be95 with SMTP id e9e14a558f8ab-3de301f83f4mr16768425ab.5.1750286626342;
        Wed, 18 Jun 2025 15:43:46 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3de019c6411sm34321835ab.21.2025.06.18.15.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 15:43:45 -0700 (PDT)
Message-ID: <d3e1b43a-48f6-46eb-be53-4731e5eb5681@linuxfoundation.org>
Date: Wed, 18 Jun 2025 16:43:44 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] pm: cpupower: Couple of fixes to the cpupower monitor
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 "John B . Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250612122355.19629-1-gautham.shenoy@amd.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250612122355.19629-1-gautham.shenoy@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/12/25 06:23, Gautham R. Shenoy wrote:
> Hello!
> 
> This patch-series contains a couple of fixes to the cpupower monitor.
> 
> * The first patch ensures that the C0% printed by the mperf-monitor is
>    100% when the core is fully busy.
> 
> * The second patch ensure that the CORE and CPU fields are printed in
>    the cpupower-monitor output for multi-socket systems. This has been
>    broken since 6.15.
> 
> Gautham R. Shenoy (2):
>    pm: cpupower: Fix the snapshot-order of tsc,mperf, clock in mperf_stop()
>    pm: cpupower: Fix printing of CORE, CPU fields in cpupower-monitor
> 
>   tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c | 4 ----
>   tools/power/cpupower/utils/idle_monitor/mperf_monitor.c    | 4 ++--
>   2 files changed, 2 insertions(+), 6 deletions(-)
> 

Applied - will include in my fixes PR to Rafael
https://web.git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/?h=cpupower

thanks,
-- Shuah

