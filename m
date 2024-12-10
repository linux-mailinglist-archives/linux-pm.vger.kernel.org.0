Return-Path: <linux-pm+bounces-18875-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3CC9EA3BA
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 01:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E329F18863E2
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 00:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD62818E3F;
	Tue, 10 Dec 2024 00:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PgnA62os"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943A3111A8
	for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2024 00:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733791419; cv=none; b=bfwFDIAKV/JgzzN9dcmX7mm7OKBVsf9k/tTjYBT1wL5wZnu60c8Of4mTSc26QWBHXBNCRu36JP+9QbensZ7nsZ922Tai/tsUm9Kykh9s+gX+IPyDfddznxtxET4JaIzo3gEbBpnTkNHgzSqIIneFai7CiPwa8DjuKPo166Q1e38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733791419; c=relaxed/simple;
	bh=7s8cXBHP/4C+GO2k56/2eFfcYIYomUQvCh2uoFWNhto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iL254iX0DQcg6Ijjl7XmTOU2zCXVe9N69EvakUqRsZ164QT1GUJWJuSMsgdL08258zqEKmu1KbtUFGMBAvpTK4nl4GkjSWWpTLjmkLFiEP97mr4qbbJ5vFCxfsKsTZdIcwt4AqDnQJb6eweG1W6luLh7itsne/CNPY7bwYNW6+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PgnA62os; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-843e3b49501so160972939f.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Dec 2024 16:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733791416; x=1734396216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uxQj4mFkPuCMF5g/bHPAP+ehf22UWQDWDQ3gf17TMVs=;
        b=PgnA62oso5qKw3Cryin9/fmfASCNwmh9+HvR8/5+uGLLkGhtmDBtP1PF235C3cJZH7
         8ZMhhd92uvfc0pBu+f236n0EWlm4Zaf9aNO0bHQvYHzpYrH9dCOcTpxQDT8N5Z2vs/H9
         CCvE8+k99zWJXBEMJkdwEBHZd/jeoCs+tEvk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733791416; x=1734396216;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uxQj4mFkPuCMF5g/bHPAP+ehf22UWQDWDQ3gf17TMVs=;
        b=f0nF37o4+saYXA8duUJmHLk2GSKeJWr5/OQhnEPv9b1J5tGQ7P8OaMSohM7tk4SBDN
         62GbJm9W/4gaB9c818dW4877cOECh1p/q8Auv6gEMyJS2ddTyo3GtIiLNSWim21L0ueg
         sK1jdYojrLvpkXfnwwbt1WLE5dyzGs/3wrbYi/8zEe3P+NSbJbqvOUVmB9j+DzrD9jCg
         ckkTjxYUrVLekZQSITs1k5roISn+9BDs/79SfdMqu7vk8p1srrLBPSq6t7GJl/zulVrx
         Y26OSCfQIHX1W/b7Vv15XeTAdd9Tvg59ZSgBrjque549RKFgZGw5FSOy2Wkik1VX+GO0
         +Y1w==
X-Forwarded-Encrypted: i=1; AJvYcCWTcs9Maa78qGHZZaBcFk4Lz1Z5YMSD2W75ol5NEdsaPoZ9FI/IKJv39oW1KOCxkJQjehEZy0VOAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGAf/3VWItnlKmPbnORWh4hnSA+cSUSGiLpfBA02zZ7yqAnF+i
	/WKQksAiNsVwFSFqMVAmztbAlYJkzclcSzN01D6WqKJpP6k9RR2xC7mIMwjg0Jw=
X-Gm-Gg: ASbGncvaFaFVUvlJq6GXLvVF6tmp/E6Z0DXvimJpUwdu9PyZdME7Jz7eFki1kh+BB6A
	J3jJTTMgdsplEJOx2ftPCDGV91vk7sLlcnmptsc+hiWCZoh7G4T6gty+WRm1n4VgbeHZEkhDKp2
	m1hwA+0fVJudUHrFVpGmemNizbsdKW0iMc3SqTYjuIPWEEqePBb/76TIQCpVGxzRSh9j3eiGLUv
	O+7TZCtDEbWVPpzJ3Qd3YH7AAX3uq3c3DO7wL6pOchVnufHBsOxOqMLpoKJqJDIsQ==
X-Google-Smtp-Source: AGHT+IEfT6QHF9o4tTU+ARq3U2kLw293RMSpojeZMjocSBS13RSPmW2lOyXE12NqKCYYgMLVBKBVng==
X-Received: by 2002:a05:6602:1482:b0:835:4931:b110 with SMTP id ca18e2360f4ac-844b51791a0mr375170339f.5.1733791415202;
        Mon, 09 Dec 2024 16:43:35 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-84473a5b3b9sm291700439f.35.2024.12.09.16.43.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 16:43:34 -0800 (PST)
Message-ID: <e5b0996d-be80-47a9-af28-ee9776638ab7@linuxfoundation.org>
Date: Mon, 9 Dec 2024 17:43:33 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: fix TSC MHz calculation for Mperf monitor
To: He Rongguang <herongguang@linux.alibaba.com>, trenn@suse.com,
 shuah@kernel.org, jwyatt@redhat.com, jkacur@redhat.com, wyes.karny@amd.com
Cc: linux-kernel@vger.kernel.org, shannon.zhao@linux.alibaba.com,
 linux-pm@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <269b8bb2-85b5-4cc9-9354-a1270f2eed35@linux.alibaba.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <269b8bb2-85b5-4cc9-9354-a1270f2eed35@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/28/24 02:50, He Rongguang wrote:
> Commit 'cpupower: Make TSC read per CPU for Mperf monitor' (c2adb1877b7)
> changes TSC counter reads to per cpu, but left time diff global (from
> start of all cpus to end of all cpus), thus diff(time) is too large for
> a cpu's tsc counting, resulting in far less than acutal TSC_Mhz and thus
> `cpupower monitor` showing far less than actual cpu realtime frequency.
> 
> Fix this by making timediff also per cpu.
> 
> /proc/cpuinfo shows frequency:
> cat /proc/cpuinfo | egrep -e 'processor' -e 'MHz'
> ...
> processor : 171
> cpu MHz   : 4108.498
> ...
> 
> before fix (System 100% busy):
>      | Mperf              || Idle_Stats
>   CPU| C0   | Cx   | Freq  || POLL | C1   | C2
>   171|  0.77| 99.23|  2279||  0.00|  0.00|  0.00
> 
> after fix (System 100% busy):
>      | Mperf              || Idle_Stats
>   CPU| C0   | Cx   | Freq  || POLL | C1   | C2
>   171|  0.46| 99.54|  4095||  0.00|  0.00|  0.00
> 
> Fixes: c2adb1877b76f ("cpupower: Make TSC read per CPU for Mperf monitor")
> Signed-off-by: He Rongguang <herongguang@linux.alibaba.com>
> ---

This patch has several warnings and seems to corrupt. Can you
look into this and send v2?

scripts/checkpatch.pl will show you the problems.

thanks,
-- Shuah


