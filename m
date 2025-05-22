Return-Path: <linux-pm+bounces-27516-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97059AC0FB6
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 17:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF8B2189E6BE
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 15:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E672980A8;
	Thu, 22 May 2025 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XLPHO6rK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7B72980D2
	for <linux-pm@vger.kernel.org>; Thu, 22 May 2025 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747927050; cv=none; b=I3DJWTDD+9uGhnlOtBXV68D9GanwVAA1eLnWZkUt+O6lGjayEM1OG+8t3pw8Ak69I8Q6Th3MFMTBkIipa+UUn2F6nPlig4Fq8f3FMr3Ua0ixZWy3/5hkbt+e5G7w/TCs5R3/Hr3wULZM2FSB0Wai+TnNmg4//sydCs7BL8w8Mc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747927050; c=relaxed/simple;
	bh=yECD6ZktgTjXDSCFgMyFUoroNATnVYVOCITlOnNEHpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fI4VgsRE6YezUcIcQh9xxziXlE8BdxLWZmsOGqvXDb47vf9kdsuwyG9OpO8GsBupxs1Y7NZNfTdnGOg/CA+sJ0pXJXWRkRP+nT09goPDhM4Z7EbGLoam1gH3R30sohBzPYUe9HpoUaQxW4UnEv516ME5DPQeypYqAlF0GewoPi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XLPHO6rK; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-8613f456960so242003839f.1
        for <linux-pm@vger.kernel.org>; Thu, 22 May 2025 08:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747927047; x=1748531847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IETGeB30Ud5t90dKFtz7PPdKbD88fIhHcL4tZXb4WTs=;
        b=XLPHO6rKWko+sw+IZXc/CqddPJL2u1YVjas/lQyH6No6tywCoJ7tXRSOTQxrtLDOVH
         LNnjbQDtVPx+89YwKtWJQHrYaKnKaB2ScLHuG13vC8AwOKipjeQg3aQt1ryQnI8tvACg
         V3CIVdUvzcmWqoCUHxCjnID5DGrM0g0GvBXRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747927047; x=1748531847;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IETGeB30Ud5t90dKFtz7PPdKbD88fIhHcL4tZXb4WTs=;
        b=YWWBxWsNpeHUFFmpoRv9L8JhtlwKT7Ot0hrJRsHxZwrkG4li76ZDJyQ5B66OhnNWvP
         Wv+jyzURQOqmNxjeTWoBQ5x4tYnfkqgHH/heDyDWK7CtBJ6dlwMgDVe0BeWyCe2iiBVu
         V3QhM8UVyV0fLVpi+rCqxHcd2TOfjfPYn5IrPk4nyvKcQ5w2ByQ+QXtNfQbKBic/iJNY
         RQq5YphZthOhS4qzsjVrBgElL1mx/hHlnqmjeyG0dZAP0tTw2gDlJzqWcWA2SKu/Fd9w
         CMlhJPx1V+hA4lFIBXwp/iF8KHvxVH5IBRzpUuMbj9E9BV0p62VE3JIca9UEwtImSKrP
         jjbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbmkEEY7n3o59ehhqA488vGE8GSvoRgjkXiiD6wgD/ehWp+M5PfeIgaAXbZzyYPTpZuhlZxhblPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhExHe9PepOEjQDlqRO4PNk4ESAnLADB1JpayFrat+9Hh7MCm+
	zLOCbyOBGsRKhzy56rz5lrxJGXEa41WP/TkOph4v12zntdMaDu+Pyx/j2qXoESRo1jU=
X-Gm-Gg: ASbGnctcxZ59NSucElwoAWPS4PH6UOVcR3Ildsw3qx+ANWcUhbT2hsMbAWmLzEATgVs
	pZsgaHtEHv2sBQHA1aaeo57d35WzuALASnp6b7g0k/bFpZCuWc9/jLEKG7V/oDsP5NtHBlbzgIj
	WMkxEzA3vKwhVFKvsM95DLwtBCDpT18nQmDM+QDNZ1hpJdkFpjQ3peP2VIGX7Nk18ss2AR6tBlC
	G7v6lDszI+xa5ZPmSjFzJc1OOQ/NN0O/gsh86XddGHPeQ6J+A6xC55Xrqnjxo1uepNUkKHDjKOU
	6+xLMm7K7DjSF3SR48PxLGp9o9jp5cT/sxDXDtDLvbwSlbrZlTs0RtwkiMFtAQ==
X-Google-Smtp-Source: AGHT+IE4miy92v8IzzM9z3nzWIqMhYC4PYeZ/1gnpzPA+Nm1GpEEXc0VF3cDp3wCEis+0MsO80e57g==
X-Received: by 2002:a05:6e02:3e06:b0:3d5:893a:93ea with SMTP id e9e14a558f8ab-3db843046c6mr236224255ab.13.1747927047461;
        Thu, 22 May 2025 08:17:27 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dc8ad89ecfsm5792365ab.26.2025.05.22.08.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 08:17:26 -0700 (PDT)
Message-ID: <2b7acb5f-65c7-4787-aac5-ebcec83c8ac0@linuxfoundation.org>
Date: Thu, 22 May 2025 09:17:26 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/cpufreq: Fix cpufreq basic read and update
 testcases
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>
Cc: rafael@kernel.org, shuah@kernel.org, gautham.shenoy@amd.com,
 narasimhan.v@amd.com, linux-pm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250430171433.10866-1-swapnil.sapkal@amd.com>
 <20250519075854.opnlhjlbybrkvd2k@vireshk-i7>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250519075854.opnlhjlbybrkvd2k@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/19/25 01:58, Viresh Kumar wrote:
> On 30-04-25, 17:14, Swapnil Sapkal wrote:
>> In cpufreq basic selftests, one of the testcases is to read all cpufreq
>> sysfs files and print the values. This testcase assumes all the cpufreq
>> sysfs files have read permissions. However certain cpufreq sysfs files
>> (eg. stats/reset) are write only files and this testcase errors out
>> when it is not able to read the file.
>> Similarily, there is one more testcase which reads the cpufreq sysfs
>> file data and write it back to same file. This testcase also errors out
>> for sysfs files without read permission.
>> Fix these testcases by adding proper read permission checks.

Can you share how you ran the test?

>>
>> Reported-by: Narasimhan V <narasimhan.v@amd.com>
>> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
>> ---
>>   tools/testing/selftests/cpufreq/cpufreq.sh | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/testing/selftests/cpufreq/cpufreq.sh b/tools/testing/selftests/cpufreq/cpufreq.sh
>> index e350c521b467..3484fa34e8d8 100755
>> --- a/tools/testing/selftests/cpufreq/cpufreq.sh
>> +++ b/tools/testing/selftests/cpufreq/cpufreq.sh
>> @@ -52,7 +52,14 @@ read_cpufreq_files_in_dir()
>>   	for file in $files; do
>>   		if [ -f $1/$file ]; then
>>   			printf "$file:"
>> -			cat $1/$file
>> +			#file is readable ?
>> +			local rfile=$(ls -l $1/$file | awk '$1 ~ /^.*r.*/ { print $NF; }')
>> +
>> +			if [ ! -z $rfile ]; then
>> +				cat $1/$file
>> +			else
>> +				printf "$file is not readable\n"
>> +			fi
> 
> What about:
> 
> if [ -r $1/$file ]; then
>      cat $1/$file
> else
>      printf "$file is not readable\n"
> fi
> 
> 

thanks,
-- Shuah

