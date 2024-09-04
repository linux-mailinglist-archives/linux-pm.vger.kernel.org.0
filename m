Return-Path: <linux-pm+bounces-13602-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D94C196C31A
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 17:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 172B8B26FEE
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 15:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3799F1E0B7A;
	Wed,  4 Sep 2024 15:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W29J2V+5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B5B1E0B72
	for <linux-pm@vger.kernel.org>; Wed,  4 Sep 2024 15:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465139; cv=none; b=CPitMR1y3/uimSEXgY+/blU80WeWy9lNvVKHcOjRkc3KUDODSsmVxir8BrxViYYThinpKB4rXrV7a8uOQHw+hFJaTuoOBPa22aYU8v8vQ+3VWGcuMTYNz2uMUwqNor6VaGpFgU72pYro3HZzX6zFcxmpfViiwEi6o+4+lpKaTXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465139; c=relaxed/simple;
	bh=rYyRA6enZf3Z+Vz8JwkHG41q18ctJtQgk39vRKV2Scg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=szYYD2ErYxG7RTYAIX+jXC/AgIJtiAoQ59ev4eebY9GDSiBi1asq9BWK+mZveiT3L/TntDp4cgqPUkqCHSelGG7QPHF7+w/7zSuRYmzyhqwSoGBqs5ax2VQTBeKjWFU6TVzqlcS24vymJL7b7m1SxXl3yQztF/T0gWAOLIQSFL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W29J2V+5; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-39fcae1d459so2509755ab.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Sep 2024 08:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725465136; x=1726069936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1F6z7aom2l+zwYv4bAFPmXnr+9mQvzC1zWeuLt2yJZg=;
        b=W29J2V+5+juvf3idKJ3mJic/TaaRyg8bS1NNfPvj4V3jBe3cx2qiHvoVGIMIQ1mkHE
         4zG644ubxbMhyxDRsuzo7dNFTQMvQBx5K5QfYC8RyIJk+jRyzq6wAwTOEPejWCHMNY7r
         NIDb2aO0FE6VTfK1LQCz+R3UJxppOnZXLDDlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725465136; x=1726069936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1F6z7aom2l+zwYv4bAFPmXnr+9mQvzC1zWeuLt2yJZg=;
        b=p29lohWdp5FFej03toHEB3K32mG3+kB59BQnPfDLfJ+K1U9FZIX8j89JrlMEMM874+
         03492Ikj3i5BRbPlrYDIkEUPud1TJFoTapkKndbFxZn4ad/WvqrWfzuQwKZzNaIwS+xK
         PdDJrC8FpmWrKXAfuJr8G+ATOnM5aUaKdhXttWFLfsyZ7DWX09RM2TDPoKZ0JSWia54x
         Z20tnyDs5LGSZaq08luaGujk6s9fBWhGZjoHSZzklI0DG+EhhHdFwIy3WFQgCLzj+FXT
         zYH52+WcxUzqvWWlqcGuyk+6uuF5NPFl8ipQ7OSB/Sh9kikNkrfmZcmSXQ7faJfPdPnc
         j8Hg==
X-Gm-Message-State: AOJu0YxriEbbAcxACCnQsoxVErR5vdFos3sIlV+7paQBz0EcEd4wzZkp
	gFSwUefaPYFI7UXQb3ta36HLGzdLAy3YseYUX25Q5+xCo991mI8Q8ev0/dEf8YC8WgZElprjQgK
	6
X-Google-Smtp-Source: AGHT+IGJxj99I7Lx9VRpurNkyqRoE4VY2BE28+JGwvHWANHOTMtgECHvU2Ope7Zpogwhuz+Bze5fJw==
X-Received: by 2002:a05:6e02:152a:b0:397:a41d:aa8e with SMTP id e9e14a558f8ab-39f37879fc5mr237963445ab.0.1725465136595;
        Wed, 04 Sep 2024 08:52:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2de5f52sm3186226173.44.2024.09.04.08.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 08:52:16 -0700 (PDT)
Message-ID: <f469b5b1-a846-4add-a629-b0a415e9fcab@linuxfoundation.org>
Date: Wed, 4 Sep 2024 09:52:15 -0600
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
 Shuah Khan <shuah@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>,
 Tomas Glozar <tglozar@redhat.com>, Arnaldo Melo <acme@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "John B. Wyatt IV" <sageofredondo@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240827062438.71809-1-jwyatt@redhat.com>
 <ab9e3727-9978-4a30-8bff-e366fa5defc1@linuxfoundation.org>
 <ZthrAiB2j-l-V2wu@rhfedora>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZthrAiB2j-l-V2wu@rhfedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/24 08:13, John B. Wyatt IV wrote:
> On Wed, Sep 04, 2024 at 06:41:14AM -0600, Shuah Khan wrote:
>> On 8/27/24 00:24, John B. Wyatt IV wrote:
>>> [snipped]
>>
>> Couple of things to address:
>>
>> 1. I noticed none of the patches have the subsystem prefix:
>>    pm:cpupower is the right prefix for patch subject for all
>>    the patches except the MAINTAINERS file
>>
>> I will pull the fix  "Implement dummy function for SWIG to accept
>> the full library" Patch 2 in your series.
>>
>> I want this subject changed to just fix as it is a problem irrespective
>> of SWIG - we have a missing function. Subject would be as follows:
>>
>> ""pm:cpupower: Add missing powercap_set_enabled() stub function"
>>
>> Make this the first patch in the series. I will send this up for
>> Linux 6.11-rc7 or Linux 6.12-rc1
> 
> Understood.
> 
>> Depending on how the timelines for merge window work, expect the
>> series to land in Linux 6.13-rc1. I would prefer to delay it anyway
>> so we can get some soaking in next.
> 
> Thank you, I appreciate it.
> 
> What kind of soaking are you looking for? Is there anything I can do to
> help?
> 

It is more the timing than anything you can do. We are at rc6. Please do
send the series with the changes I requested.

thanks,
-- Shuah

