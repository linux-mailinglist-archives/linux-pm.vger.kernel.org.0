Return-Path: <linux-pm+bounces-29016-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838ADADF8F7
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 23:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BFA44A22F4
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 21:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007B927E7E2;
	Wed, 18 Jun 2025 21:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VfCuiwdu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0432127E1D0
	for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 21:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750283700; cv=none; b=pcLribL1VELXggC3UFMNOzTabuhajYipNmMXPwFGMEQzoZ0nrbuvsEzzc4xNnUBUlTxfi2p7yyisHBp7xr4r02iXwCPvDFmwTFBGhQc0FmWbZ2fI+uH9JloCSolCneMSPsCZIPlcx/+RhkKyZSamSoTJWZ2fGuZwpL1Mgs0LIro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750283700; c=relaxed/simple;
	bh=8DE3YOgyvy88lbH8YeeAuIlAv07rp+Cil9OAMOgyewQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qSyKiuHHw6rpwgvvAfwN+k7Gv1Z1QpQE/+4xSk1x3iZPMBP2xOmNUYuqJqkM1HuE/qnPSqdCd3yUbJogtONZTkT+nvIoijTQL5ELU6Qv6pS7Tg3b8x0addq82AiUe06hcA52SkF93KkXJCZCDsvhNTN4LSB/6rJMfkAPofelogs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VfCuiwdu; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3da73df6b6bso508855ab.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 14:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1750283698; x=1750888498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VUtoT1ENysCm3OABGpjN4So/MyoL7Y8nki+8lFHBzLo=;
        b=VfCuiwduTxpV1QXvgrtM3z67wphP8BIGdFS7qK7uZfc0FUI0fAvWFM6JNZQMHfoyig
         0e6tHfXwfxkv6hCOwsedKz3nn+sEYuITvaSYcp9Huo4ozYJ2/7uFTSdLeDcdCJkzrV1r
         QQoRmSUmncFwhLQqb8jruf6mKBH1B6wdgiksc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750283698; x=1750888498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VUtoT1ENysCm3OABGpjN4So/MyoL7Y8nki+8lFHBzLo=;
        b=pvY+DaB5WH7ho1+u12yGHi8uPR7BLan7k0MRUZsjDWDIdsjDKrCE+O4jXFL5pTzfYZ
         qto0Uwi0TRvFqfw/MTOHExMfNnhXhY7DxNxAEIN6Jxo77gi3o6VSkNz46hfIPIgs9sTG
         vH2xNDQ1Fs9Gpe1Y5RF9NxhoWETMLZnb5WZQlpb+RvSaKG2Y8ZLBte/Ji/9gzM+03UXr
         T1TV/00j/Kzn/f/UEwVa5tM/TUMpieMAwrWal3rzpdQWN5U2NCif1xFOHLCLnvfWCpRy
         n6vOXTPqcLuo3w734aeqJkTNOpdCB2SoARSOJ2oUf1B2zGhkj5qsUR83IsXBbhSO/jpp
         ieag==
X-Forwarded-Encrypted: i=1; AJvYcCWicMAPJtYozbBnKCvbw6z1kpx5Ad54qzMGOzjuKOWT/7cOMvtHrICeMz+XeCVgBWvzbpjYgmk7uA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzI/sJ/drwaI37zXbASM9zyZ2AhMVyaqOy3RIYjUqIZW6OPfj54
	ScFzbQGp3Rofx7Z7q2SXNFSyT8j9Khw6QsGP0bc7eONDGCy22jsE2fPh8yF5yB3iXmY=
X-Gm-Gg: ASbGncvL0a9xxKhH+M//jsxZoO4x/6uKW3f3FUCPtpNe/nsArxH+9woXpiIP3bOXDj+
	R/FMV731BWB1y8SfoT2Hr/HK4+8ck+wu/TKR+G7lRRWsIUhgAwDhmTSSbwxEg3SjQkHhEfdQP8u
	EsyKclNg+L/Dkb8ByDDOy8tgJo79ufnhB4bDV0+/qj1uWMkD5FJ/1VZD4007Fwd0LAnK6f9p3rF
	FpXGDh1SfK+fOSbxCEMr32ss9rfKcQc4J1TtDvN0mDA1PyUMSweZsChxbg6xxGPWrWnDupEBWrU
	nzdkw6xqPtUnhYqEJNad2gWZJIy52iS6efAo1beM/HEzVZHYtL/hJ/CJNt0JsUS4AaVyYeVU+g=
	=
X-Google-Smtp-Source: AGHT+IHVTakmA6UH/U/GStixFyupZiGXk5F7Lm2Uumkibpd+AK5PI/o563y1OZU9QTTuJZug9VQbvw==
X-Received: by 2002:a05:6e02:2583:b0:3dd:d6d5:62c0 with SMTP id e9e14a558f8ab-3de07cc205emr222399815ab.12.1750283697880;
        Wed, 18 Jun 2025 14:54:57 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5017f8f40f2sm765271173.35.2025.06.18.14.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 14:54:57 -0700 (PDT)
Message-ID: <0053926a-7b0a-4e49-9acf-fcb1d73134cc@linuxfoundation.org>
Date: Wed, 18 Jun 2025 15:54:56 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] cpupower: Allow control of boost feature on non-x86
 based systems with boost support.
To: "Shinji Nomoto (Fujitsu)" <fj5851bi@fujitsu.com>,
 "'John B. Wyatt IV'" <jwyatt@redhat.com>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 John Kacur <jkacur@redhat.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250522061122.2149188-1-fj5851bi@fujitsu.com>
 <aDhJdTWzDihchywc@thinkpad2024>
 <OS9PR01MB14003E72236096AD987D2D4CED96DA@OS9PR01MB14003.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <OS9PR01MB14003E72236096AD987D2D4CED96DA@OS9PR01MB14003.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/3/25 01:16, Shinji Nomoto (Fujitsu) wrote:
> John Wyatt wrote:
>> Hello Shinji, ty for your patch.
>>
>> On Thu, May 22, 2025 at 03:10:57PM +0900, Shinji Nomoto wrote:
>>> The cpufreq subsystem has a generic sysfs interface for controlling
>>> boost (/sys/devices/system/cpu/cpufreq/boost).
>>> The sysfs interface can be used to enable boost control from the
>>> cpupower command on non-x86 platforms as well. So, allow boost
>>> controlling on
>>> non-x86 system if boost sysfs file exists.
>>
>> Did you test this on non-x86 systems? If so, would you please provide details on those architectures and systems?
> 
> Hello,
> 
> This patch has been tested on Arm-based systems.
> 
> * It was tested on our internal simulator based on QEMU which supports boost.
> * It was tested on the Nvidia grace system (which does not support boost).
> * The cppc_cpufreq driver is working on both of the above systems.
> 
> We have also confirmed that it continues to work as expected on AMD systems.
> 

John,

Let me know if you are good with this testing details.

thanks,
-- Shuah

