Return-Path: <linux-pm+bounces-18927-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB0C9EB773
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 18:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4D128284F
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 17:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A5223497F;
	Tue, 10 Dec 2024 17:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fbNc3w+K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5892343DB
	for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2024 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850535; cv=none; b=B1N2oiSE3YVTZgXicFrCbSFV1jKYB3T05K53Edz2E+5zSc2hxbfPtjR93X8/qo1gYqnaCjqxCmRLKT7W/W4hMaczG/kOBpCE3YK2OBCYBbhi3bve0ybpL0fCwrvsYqv5VEl8No3qaTW9YcNKRvc8Ywf/6FKT4jjQ1bITXrPjVH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850535; c=relaxed/simple;
	bh=vqnBy2TUzl5VEh6Ll+x+Xk8e1C2DbaIVDVhMQuQ/vzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QnIehm5sRRHPHMorTzOCxGOg92UqGJphnr2giowLEL+WuesxEUQp9UbtEzU2BDVKiWDyZLUw63qnOQMRqW5DhubQhATzXvKkM/QUJn2ZXEfvHHvKcMfz7aYnR0FGrIKjGWcu6guEfb7eBSxxGh0JyeHAquZZh5qsvLX03/tZjdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fbNc3w+K; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-84194e90c0fso411887239f.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2024 09:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733850532; x=1734455332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B5PJ17q8lD7k4hVY6ctGVVWNwOwWO51bb5PDCcKGo6o=;
        b=fbNc3w+Km/yqjUHcR4q0Yw23p971vs1gYm7T0EeLW8sDF0dExjAKQqp4P7N6RbF01X
         XdNolJsaUKonfeSuqix2Vl9Ffb8nBSyISOmNcIQp0lggxp/U+YnhJXLhOacxHg8yxMX1
         kikdLbqsPLEbWlgxEapR2IW52icNC9GE1/oUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733850532; x=1734455332;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B5PJ17q8lD7k4hVY6ctGVVWNwOwWO51bb5PDCcKGo6o=;
        b=NoqWNcax9TAts5l9ROzDnaGrwwd5yu6Yz2P743Kvvlc/JY0WYDJMd3Z/8joBTbVjpX
         PkY8SRhemoh9zpC4B+JgXLqgSwbj77al2d4IBOVHdzBnqxgc4kKBi3oWABZuzVwYeMCZ
         CD45tLDYu05PfwMte0xWAvuFVmtRRMNN3lbe/X7Gik7QvdMcjs+kG4ARoJ53ONPrkZMx
         tp8NGMt1/LRbfydiaNLMmlA/biMKJmOhGAmNTxkqPkfBFSOUU+DSIK5TaJXcjr8+oMD9
         yukaEvhoO0Br9jl5hB89ffotjFuq8GpApsCgqN6YVSkjab1H1FpIw+WZD09lMSoFNQtm
         Nx7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLAyNBXyZ+6BxktEZhk4bEGuzjsWL7DiaBV2O5vbSHuaM0ROBLlNm4wnDWyzpBOGWqOOLVasCZNg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3yLRLrntB6TdntFsSCm2/HVv8F6AK9VBKYQ7UUfdHBKP0xJQ/
	smMYfKeFfFUNTcpj05vPe2DCuwFN7qhLyXlK8eiaBKtOe3SkLWGXxMSIgZeDRbk=
X-Gm-Gg: ASbGncuengby2ViF06fPpd599j05TMkqcEgfoUtdS9HO5npXzUpuo/vaMifqNmhnfh0
	w/rOc36dKicTwM+Dv40v6bvRsJUvNkEBOs4YxI/RGM1pHbim1iPK1x0yXXld2EE2km8kC+V2eK7
	4vwrGG+qQ4dQ4f+RrDMqT1LEy3Fvi//lO/yBMmeICCLqPATlslcO97iF+0YuylrgVIq5gIuescN
	b3p+VOiLZ+u2/E92gIz8YbwyV8RKcjuG4FruzbDL4iqG9DmvXpLDqtI62bgzBOZvg==
X-Google-Smtp-Source: AGHT+IG/gkZmbkJxGMdHnI+Js79ydu8p5QIVfUBfMDkz2ZNcb9kT6//CIdURU7BGEZClLOWq6Kg11w==
X-Received: by 2002:a05:6e02:1c8f:b0:3a7:dfe4:bd33 with SMTP id e9e14a558f8ab-3a811d98e10mr213572065ab.6.1733850532088;
        Tue, 10 Dec 2024 09:08:52 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e2ca310cfbsm701831173.152.2024.12.10.09.08.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 09:08:51 -0800 (PST)
Message-ID: <1e61303f-69b7-47e1-863f-1d52ac6c3ec7@linuxfoundation.org>
Date: Tue, 10 Dec 2024 10:08:50 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3] selftests/cpufreq: gitignore output files and
 clean them in make clean
To: Viresh Kumar <viresh.kumar@linaro.org>, Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-pm@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241122074757.1583002-1-lizhijian@fujitsu.com>
 <20241122081304.j2zbjvmgd2nnfca3@vireshk-i7>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241122081304.j2zbjvmgd2nnfca3@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/22/24 01:13, Viresh Kumar wrote:
> On 22-11-24, 15:47, Li Zhijian wrote:
>> After `make run_tests`, the git status complains:
>> Untracked files:
>>      (use "git add <file>..." to include in what will be committed)
>>          cpufreq/cpufreq_selftest.dmesg_cpufreq.txt
>>          cpufreq/cpufreq_selftest.dmesg_full.txt
>>          cpufreq/cpufreq_selftest.txt
>>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: Shuah Khan <shuah@kernel.org>
>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

Applied to

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower
for next pull request to Rafael.

thanks,
-- Shuah

