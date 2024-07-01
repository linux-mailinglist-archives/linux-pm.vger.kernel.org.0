Return-Path: <linux-pm+bounces-10301-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 525E891E8BB
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 21:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1488E283413
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 19:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094EE16F850;
	Mon,  1 Jul 2024 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FVNE8Wog"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C93816F848
	for <linux-pm@vger.kernel.org>; Mon,  1 Jul 2024 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719862812; cv=none; b=Ga9XoqvlCWj25K0KSdJWrl8BWOC+7vY6jQuHeKRZzXSvUNCoXfy4ZyT7cIPfyVuDil0XOj5KUC+Mlqzv6T0wn12uEXU+eDs4GBSC8EHwHceSuQM4+jLxjvPXQ9P8gyd9UkV4yhBex0GBWuZ+xjblv5FwrfExW5HKZP4UuctZOuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719862812; c=relaxed/simple;
	bh=Osp/Q2MP0iI+oJriW8ZjrL3Eg4r3SKimzRBMLOLVGq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Af54efQDq/kGW/kc9f3dXuXy3aCg305rGDup7DSuLHJEYjl7VvdX0x9r/FhkU7Vg2QP6OOojD0ZQ2bHXN1qaz+9IQiZG4CGiy3l/IMD8ECigl47hJD4Zoqc17VTmogEXOIYypij5pp6rbh1cnT0ySCW7YqHsOiKTH4B3CIrUvs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FVNE8Wog; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3762c172d94so1750055ab.0
        for <linux-pm@vger.kernel.org>; Mon, 01 Jul 2024 12:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719862810; x=1720467610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DAhhPyLlfY/a7RrnttMrssdLFe9/7+sNUUJTZ5aCBQ0=;
        b=FVNE8Wog2pGzYfF/O6XlfJPF+D79v4UcmTyhowZ7Lo6jr1e/2/t0Pb5yXQy2rCx6PJ
         YJgDk98h66ecO0grkQ9oz7NTNBq7oAAbFxV1P/Yqi++UaDzPkr4gAuxp9u6thARklVzI
         Atu3IcmVuxEWSBfOHwZqovGTGeBFAxPRNDy48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719862810; x=1720467610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DAhhPyLlfY/a7RrnttMrssdLFe9/7+sNUUJTZ5aCBQ0=;
        b=dzeP3AJMJym88x4W/BzxSS0jnojjkJwf3JlufQuz202K9UXXAjFZ/iPcUlGe+bkuSy
         GO4lkTH9wrf6UDAp4dkrS6lCMqMGbtVEBjZ3ccEr9PvZjPq/BffpB8ZWdacb2MQROK6r
         WjkQ3H5DLgZ2hZcxu2YIc8eAf18pJwwgrGRYk7xeQ8aKf37Bi7NJiMFGkZzKej90jnFa
         zJCDJVzsNfziwQGZ3w4geo8ckVs66z1bvIYBuN7WYj+vJImLTs1nLSrEYqp7+B7j7uZt
         MnRF4iirrbPNNwYKYdd3GR3JJqk6KmU5YfCE9H4jXBkgiaR+e+Qiilv0BNwnn/x2263l
         SWXA==
X-Forwarded-Encrypted: i=1; AJvYcCXX/AlmubigLinXs3H5LNR8lVpBOZ8IrLkVXRmxs+wDkKsjvtk/q6oTrMIAAOqnXHSvkcZ2al2QEDVvaPX1C6r1bE1Zs2h4hRw=
X-Gm-Message-State: AOJu0Yzo4pBxTuoEL1ux8nT63ogC8ohRyFba6anHqWI3LoU+jSoxYkiI
	LIKocGYSHJzq31NMQr9CeCKqkSx7FAo5P5eUi6uLrnJYh3p1GFDU9jVd+1BE/Kw=
X-Google-Smtp-Source: AGHT+IF8axZ2/vy/hXd0tRQ0/E+Tei2rSB81t2iyY6jdEbqmwfAm/hp1ooFCB8a4pZpHMxGxuu1nfQ==
X-Received: by 2002:a5e:8908:0:b0:7f3:9ef8:30a4 with SMTP id ca18e2360f4ac-7f62ee595b8mr564143839f.1.1719862810525;
        Mon, 01 Jul 2024 12:40:10 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73dd4b82sm2406130173.42.2024.07.01.12.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 12:40:10 -0700 (PDT)
Message-ID: <501954d6-3f0a-4f1e-863b-c60353435700@linuxfoundation.org>
Date: Mon, 1 Jul 2024 13:40:09 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cpupower: Make help command available for custom
 install dir
To: Roman Storozhenko <romeusmeister@gmail.com>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240627-fix-help-issue-v3-1-85318a3974e4@gmail.com>
 <c9df6637-6055-4668-b80b-a1a6e6be445e@linuxfoundation.org>
 <CALsPMBMeo5E9ZND0bPK089VHBZnybsigkvoC2r8BLCTjYt9QFA@mail.gmail.com>
 <f1261f1c-abbe-49e4-b0bb-b72af367da7f@linuxfoundation.org>
 <CALsPMBP42_oKJDegVQOzHUE00mie2Mh_aPyvyTUhgsnjQO1DDQ@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CALsPMBP42_oKJDegVQOzHUE00mie2Mh_aPyvyTUhgsnjQO1DDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/29/24 04:48, Roman Storozhenko wrote:
> On Fri, Jun 28, 2024 at 9:45 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 6/28/24 05:30, Roman Storozhenko wrote:
>>> On Thu, Jun 27, 2024 at 7:33 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>>
>>>> On 6/27/24 01:49, Roman Storozhenko wrote:
>>>>> When the 'cpupower' utility installed in the custom dir, it fails to
>>>>> render appropriate help info for a particular subcommand:
>>>>> $ LD_LIBRARY_PATH=lib64/ bin/cpupower help monitor
>>>>> with error message like 'No manual entry for cpupower-monitor.1'
>>>>> The issue is that under the hood it calls 'exec' function with
>>>>> the following args: 'man cpupower-monitor.1'. In turn, 'man' search
>>>>> path is defined in '/etc/manpath.config'. Of course it contains only
>>>>> standard system man paths.
>>>>> Make subcommands help available for a user by setting up 'MANPATH'
>>>>> environment variable to the custom installation man pages dir. That
>>>>> variable value will be prepended to the man pages standard search paths
>>>>> as described in 'SEARCH PATH' section of MANPATH(5).
>>>>
>>>> What I am asking you is what happens when you set the MANPATH before
>>>> running the command?
>>>
>>> It adds the custom search path to the beginning of the MANPATH variable.
>>> I tested this case. All works as expected.
>>>
>>
>> Let's try again. What happens if you run the command with MANPATH set and
>> exported and then run the command. Can you send the output?
> 
> hedin@laptop:~/prj/cpupower/install/usr$ echo $MANPATH
> /tmp/
> hedin@laptop:~/prj/cpupower/install/usr$ LD_LIBRARY_PATH=lib64/
> bin/cpupower help monitor
> ...................
> man output
> ...................
> hedin@laptop:~/prj/cpupower/install/usr$ echo $MANPATH
> /tmp/
> hedin@laptop:~/prj/cpupower/install/usr$
> 

Is this with your patch or mainline? Can you give cut and paste
the man output here for the mainline coupower without your patch?

thanks,
-- Shuah


