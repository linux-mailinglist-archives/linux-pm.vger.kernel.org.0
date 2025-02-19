Return-Path: <linux-pm+bounces-22486-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6444BA3C9B2
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 21:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E248189378E
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 20:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E60F237168;
	Wed, 19 Feb 2025 20:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LcrgGAiV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DE5235C1B
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 20:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739996854; cv=none; b=Lqi5xzey8zWkuWcZWVeRtK9VlbOgAdtHKGDY0TNcbJbQzCDt/t/uxoV1oU5sY0o6D7Qz7AiesO3vfN7aiZoTtPBRgdbBYqr3/PT9Vvov/GYTSm5ASbCE0LjuM7gCjEAZs35NyeSE86Wigr8w0Fzqaks4fSWY75cXSRCoxbpomZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739996854; c=relaxed/simple;
	bh=7+3Oqsi9t4NAojKLqXCl76z8Q1Z6durWBRdTaAMdOk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EuCeCNW2EiN4PAyqGEFYOArALc2uYu47lCaSO9Y8FxM+hztkMNj+0RLjuVySnJctKI6yiz+nHBTvTyEGjRJim9LlYEI2MjqL+q4TDZCYgDNWWMSgK0vKOqPEgSYU7j4w7Zjlt3N87iVN1ljKTS0XvossxFq45QF21HEeLdrgptQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LcrgGAiV; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3cfce97a3d9so608495ab.2
        for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 12:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1739996851; x=1740601651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SsejSwHwkJ6QYid4RdG2XJ8ehgacoeNREUlPqfWGagg=;
        b=LcrgGAiVsxBJep8L/RAtGhvrAmXixJtE+t6rA2D1J7i7876YdWxvq6E4v3/coojVhK
         Hn7WRLp9Wa7aie4OjBKKpMPzuQd7H9OFVQdTT6caQapOPRp5vkDdiTtMuDtgP1OVjKQm
         abTynkAjaywPneIX5Ye7Q5x2xoOdWXTW92AYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739996851; x=1740601651;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SsejSwHwkJ6QYid4RdG2XJ8ehgacoeNREUlPqfWGagg=;
        b=FwmdecPKKh+pm1PntmaplNe+WwAntl4eE/vdLdKsjhDezPe8bC6JNKAVwZcSL5m75U
         BweBmmpQVshKSgJ8guGu84wFh2JGCn/75HNFk3ZM6J1GbaOO4fQXZWfh4WZ2txgG2Ptu
         fWqc7QuGGI/l++5uR6cCMb2Kd13LyLtn2sW4SVzzg4mck+LE04aEKLCdK5IItqZf+ykW
         lOIAKjr9C+PNVQRxoipxEygGx2JlmPEViprJCI3AQ5HnTwhYyIkPJjcMhD9BC3XyJ4t6
         PtsAqD1tM3tfiurOG49/rE8W3tiTtjtaaj93IZ2PpEkTF72NyBtjBM2bkSHXA8d8AJAA
         nykQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXQnC64m2WoRsLnaZN5hS/6AS7W4CJCiSNXbE4k57qSLVTHAsao6K9QIcOLqaVLogAGwpGo+PI/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCk65DVMwTfFp5uUjnomQBCsp4YpLQkCL1oy2pG0iF4ab1Pb37
	1D4V0Ywa4ExXxyoEbOoij4ZWcrBNTqxyuzgKkBx7lxIYXSn3qxX5+7lyNfbsLDI=
X-Gm-Gg: ASbGncu8BqHgsOyzW/hjOx9PS+umvb2DAMII5xS0QsqD0AFKW81Ud5vzO9drQtyRBFV
	++U+pXiin3+M4rXhJpHBJJHlpfPpf2TVdYOy58E/+0+HYGRrjiukQIGvDJs3T51cVCDRwucFPFN
	QexbQpJbj5H3guUdNpO1lZZVbvQTMBzIXcH5IgNqWPUUT6TRMsXDL8+3Z3oqMidHzFtSfWPKWhl
	GTEt9WpognbR1HvXC+Fvhl6Tp0+BoJqY0HYGix9CBryKK8K6Z8TQ0jEGUL/ikWyAszwzM6MN7hz
	dx0LBg8BPTzqSfVDkOqW0lAnUQ==
X-Google-Smtp-Source: AGHT+IEfJAW3Yclfr0r5XudDdE31KDxPhhhC1Meiegi+EQSUrtQ6tXr0burmxFZLwf/V7Os++FKJzw==
X-Received: by 2002:a05:6e02:1a2e:b0:3d0:47cf:869c with SMTP id e9e14a558f8ab-3d280949c9emr151862565ab.19.1739996851528;
        Wed, 19 Feb 2025 12:27:31 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ee980374dasm1713460173.3.2025.02.19.12.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 12:27:31 -0800 (PST)
Message-ID: <88d440c0-6a84-4483-939e-9f69e1d7befe@linuxfoundation.org>
Date: Wed, 19 Feb 2025 13:27:30 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: monitor: Exit with error status if execvp()
 fail
To: Yiwei Lin <s921975628@gmail.com>, trenn@suse.com, shuah@kernel.org
Cc: jwyatt@redhat.com, jkacur@redhat.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250211100530.5918-1-s921975628@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250211100530.5918-1-s921975628@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/11/25 03:05, Yiwei Lin wrote:
> In the case that we give a invalid command to idle_monitor for
> monitoring, the execvp() will fail and thus go to the next line.
> As a result, we'll see two differnt monitoring output. For
> example, running `cpupower monitor -i 5 invalidcmd` which `invalidcmd`
> is not executable.
> 
> Signed-off-by: Yiwei Lin <s921975628@gmail.com>
> ---
>   tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> index f746099b5dac..0fc0e229739d 100644
> --- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> +++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> @@ -6,6 +6,7 @@
>    */
>   
>   
> +#include <errno.h>
>   #include <stdio.h>
>   #include <unistd.h>
>   #include <stdlib.h>
> @@ -295,6 +296,7 @@ int fork_it(char **argv)
>   	if (!child_pid) {
>   		/* child */
>   		execvp(argv[0], argv);

Good find.

Add a check for execvp() fail and print a message
to say that it is an invalid command and then exit.

thanks,
-- Shuah

