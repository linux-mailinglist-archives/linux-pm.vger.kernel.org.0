Return-Path: <linux-pm+bounces-29018-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86899ADF98E
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 00:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CB355A01DA
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 22:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB6C27E069;
	Wed, 18 Jun 2025 22:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DyLDCb/I"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37FE27EFF2
	for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 22:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750286700; cv=none; b=icRxrXzL/GflTzT/vSLYr8Qo8lSZ/5oWk2h4VNFNfOITR3SO8OqCZpwPFkEjbckuVECs1AiWnCvH7b7CmVVhSrsXqjN21peTR3Y5KY/3/Wnr0gfm0k7Lm7kJi9EmiXmr+QVegPqPcyUQNqRviO7os3w+js7qVg2xzRCUGmda29w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750286700; c=relaxed/simple;
	bh=0ED5HZjv3WSWzpJDL2MNE3DxJKC3CPCwd3eAHubf36Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZ912DZefT1PSwJkbRpirlK6uCb47g6cfBjKy9eWlk79SilOgMfLPRfmtz66ZblMFvEEp/kjwsxgnhTF6dC7fwycZnDfA7B5R/YQ3CWuHgN+1wwIX5+2A0olH8TWDarup6rqmbxZItzFpa7sKhiICnLsle3jYsxxLr88W7A2ssw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DyLDCb/I; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-8760d31bd35so4113439f.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 15:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1750286698; x=1750891498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2n2SQNFGQmtENFVzE8cjN4n7LHc1Thph1pphR4bfrBo=;
        b=DyLDCb/IX7UnllW+r/78Jb4q3P+abine8Ont+KUC9P/QKLC5qMg3bgX4yJXh8FRCAg
         U/BLPSTeFUfky+VoucW2+VNdnZY7/MDqGqoj3ksqp+ngiiz0biNGn8NATUoOLL5Oz5gd
         5KTqPdsZcn7oTCwkp+gLPYLw8B5wzih91h+Y8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750286698; x=1750891498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2n2SQNFGQmtENFVzE8cjN4n7LHc1Thph1pphR4bfrBo=;
        b=PgOpnsfbBjHRuRj9VpPAov1AeIYo/6LHmFUv7VAhbKSNvFcZ+GR+0MB5RJwDWm/e28
         p9PwQbZzh+3ne8qtoiFPEYe4gIzdWdQdChfUvnuTgLvx6uvpxhkvN2YIh1A3H9v/Pl/K
         oNyF5/uht35Io+tm6Qql9Slx6IUUz3cNb8m3paZ6pPpH14mgICy/zDUddkOxTTSWdqBi
         WQB4R2MmDMld8U7CFOifgapOVaEaVbrS0wmrRNInMIbRt6w9N+QAkZg5se6Fz9IMSuF8
         Cq4Ny9C1ATq+AUrWmUFqA7OdmWsWyrbDTDMaNvNxofRcdQiAfFiGqEFNJXl9jU6O8rLQ
         471A==
X-Gm-Message-State: AOJu0YxNqvtlq/oXMbzN7zjiMLyul2fNdu4BhJFDybwBV5qY43AyX9j2
	D+VwFxFcdyHBLmUrI3fmPz5tH2fSa0pn3wjnXSCFKzhzGDW8Jub+EDgvgwlOlIO0afQ=
X-Gm-Gg: ASbGnctevHAVOs2tAW5+Eqo+f/zQknfguwJF7OwQT2HxD4gehY66xu4dHZAq88mM9I2
	6zBbWd/1P8jTXjNp9w1KzYDdbo1LgDP8h3v0zu8MxkIE+ehGMViczKdh5h9bl6fmwGb7QsDr/yr
	lymxZlpsmt0jWBm5HKYIqGwcxTiq3YGVfwbdCEH2TwVQpqvUud4Jms2i4/+cYfYf37tmsmUGPK4
	k0d40gnUS2YmBQ9lEARt0wtnPUiHV5+Da8zqj10JrdlmLDPoJWdowPXXUuioSDUNYvwU0AIyG8w
	7HMm0+S4/JNDk1hApBYaCzjCONc29EZXSfCteCGIM0HMwGcnkDMMFc/hKjlmCu92WBrRy+lRqg=
	=
X-Google-Smtp-Source: AGHT+IHXsSSQld9y7WIQoRaIUbFW+s42HR4KGpA2t3mpOt2Rr+gELKUrlxZAvg3wyi0Rm3o7nfKxfA==
X-Received: by 2002:a05:6602:1612:b0:861:6f49:626 with SMTP id ca18e2360f4ac-875ded13886mr2568261539f.6.1750286695900;
        Wed, 18 Jun 2025 15:44:55 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-875d57ff0fesm281953239f.26.2025.06.18.15.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 15:44:55 -0700 (PDT)
Message-ID: <6e1fe001-dd21-43fd-ba7b-aae6df819fdd@linuxfoundation.org>
Date: Wed, 18 Jun 2025 16:44:54 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Add cpu_start()/cpu_stop() callbacks for
 monitors
To: Rohan Lambture <rohanlambture13@gmail.com>, trenn@suse.com,
 shuah@kernel.org, jwyatt@redhat.com, jkacur@redhat.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <94c3faee898b5436cc0b837c6778011a060b8468.1749480264.git.rohanlambture13@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <94c3faee898b5436cc0b837c6778011a060b8468.1749480264.git.rohanlambture13@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/25 08:49, Rohan Lambture wrote:
> Move per-CPU logic from inside individual monitors to the main
> monitoring framework by adding cpu_start() and cpu_stop() callback
> functions to the cpuidle_monitor structure.
> 
> This refactoring allows the framework to handle per-CPU scheduling
> and gives higher priority to fork_it operations as mentioned in
> the TODO. Individual monitors now only need to implement per-CPU
> initialization and cleanup logic without managing the CPU iteration
> themselves.
> 
> Changes made:
> - Add cpu_start()/cpu_stop() function pointers to cpuidle_monitor struct
> - Update monitoring framework to call per-CPU callbacks for each CPU
> - Refactor cpuidle_sysfs and mperf monitors to use new callback pattern
> - Maintain backward compatibility for monitors without per-CPU callbacks
> 
> This addresses the TODO item: "Add cpu_start()/cpu_stop() callbacks
> for monitor -> This is to move the per_cpu logic from inside the
> monitor to outside it."

Please share details on how this changes has been tested.
Also run checkpatch - there are a few warnings.

> 
> Signed-off-by: Rohan Lambture <rohanlambture13@gmail.com>
> ---

thanks,
-- Shuah

