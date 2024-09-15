Return-Path: <linux-pm+bounces-14290-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC6A979461
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 04:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3849F285507
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 02:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2033E186A;
	Sun, 15 Sep 2024 02:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAzvOK1E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DBF8C0B;
	Sun, 15 Sep 2024 02:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726366898; cv=none; b=EtJBO1NPfkUCpmP6H8FQ3WketBOFlgi4tT0YRR7MYMgMlntYF9D3hdgzxtQ/+NwQlGE3pcZGtCBxuNWhpaNNsEQrm8YdNJixCSKIhuqYxqNEcXP69vKatXNmA/3VEf+3+SiPexQUzfczWv2EcOh0QjowJvoWWvEJA6byZWiVPOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726366898; c=relaxed/simple;
	bh=/TFCcMuH3eFlHq9L3PNd9dVZtxS+2tNTLiYU/MynuPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EfJKSWQFd68jefvKPpMV+OCrzcR/D34BCuX1N6QYMoEpPHn6b8NT+eOTDXeE8kxqD5XHnfr+lw5g451xwOTTSO3Xw6CYBuYgp8uxxFSQrp19VAyjk81vDk3gKPBtN71NNE935PFaL1oncIJ9CaACGwVr+cNvRF2+EjNuEWks3RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAzvOK1E; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d873dc644dso2833220a91.3;
        Sat, 14 Sep 2024 19:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726366896; x=1726971696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wlgq2n3Pu88VWjuj9DZNU9s2yQJKQNU/Scco8Aq+2xU=;
        b=QAzvOK1E8/BYVPnuGKYkYApnlXiPX4pTYIatrGZiik+G7IfLCNAuv+mnjfSwSuIWww
         1jYG4WPXsvQU8l6TRnR9CnqUjawQMV2XkJPleaqBK2hcFqO3yWUWAam2GFyOQKayLi+w
         MQi2wIAvPNued9sF7maudvQqSZ1YQPtpTBGz3DxuqIyoKJsC07oFfS3tK1sL3rwcT2HU
         /4CiXt4ToWBUH3tWgaCQZEmJ3WncIwy7xsw/zJx/KvhOSFCBjGSvSOOVgl1bHiCgRlS+
         RPluK8dGdHVC5zImWDng5lFWK7fVzYfRbl1ryTvS5uEPs2ZXdvSUdtrFBvf1LlSj5wvM
         It9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726366896; x=1726971696;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wlgq2n3Pu88VWjuj9DZNU9s2yQJKQNU/Scco8Aq+2xU=;
        b=nZdAze4kRrqrhFqu6ZIsGiMPAlGMw0DKtpkrMANDNFQmXkRhEWGAxJr2z8SM13rsNI
         UkhLqr/M+ctVbzOaAGEQTSEMT3883aiku4m/tAti58VAoRXlh1m+TK1FjxVH8wPYFCAW
         0zZG1SBopmQx4cMbA6/vTnj4Ytz7wfyKqDKU0PbFdvs6KodNDU7iNRQov/wwCKYqhjak
         ghkdgnnluLNXfXO5B9L1q1O6FbHOd7EJrEM0pPZ2t8XudJdp4oOh+OVl+cWPCFhBXUxE
         svl1cgi1vKC1WUTHDyLQNCf85hlEAwnsLpyMWBW4jzeVVh3Yymd1oKiyQ+8S61zI83JM
         /kVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1S3kQlRwdcXCPxnCFK1j1ft7lqATJ01o6gOHdCSARSOpgQXz+djC162cbL8mOpwILozwUfUuNz0uw@vger.kernel.org, AJvYcCV7YHtJY+7yQV2zMGVTPB+nHm2UgQuJYaUqkaigMNRKO+4OAT4Zyr0g14Eglo9mqecgGQ696spA/sm/+kFiceo=@vger.kernel.org, AJvYcCVMX/jPKHf0an1f7h2Oid6kUXz/gNnKFp5Pr7Ctjq4MP5WfusOV66XXOr1WDniHtP1WOwWcX91Bkdf7aA==@vger.kernel.org, AJvYcCX05Cvz5BjygfFAFjR+I+kAmcfvltY8kENXMgookvnUupDbGM2aRk/Ezp6KUkZXYQDGYcKNpwCIxYY=@vger.kernel.org, AJvYcCX5WMxuAzw/+pUxCPGB2omtgOqFMP78WU/iMg3mXIkntvro87yPXRH/vKeGZTk6yM9FONkF1V+YKJY8mdBl@vger.kernel.org
X-Gm-Message-State: AOJu0YzIwmlIVmwtHntwIAFPXdON+s77duXlFvU1xxXhIOXJZf827sSX
	Fd8bV+1WkTWUyWkCS+tZv1sQrZaQtXsToQWQ0V7hdrWKB2C44yGu
X-Google-Smtp-Source: AGHT+IGaD7u+NPj+qsxGjhpuYjsmHLBN+A4TI1iEQ+R9rpf75fx7e5oYIgQONG2M0UTX610QvqKYAA==
X-Received: by 2002:a17:90b:4b8b:b0:2c2:df58:bb8c with SMTP id 98e67ed59e1d1-2db9ffef53bmr14156849a91.18.1726366895835;
        Sat, 14 Sep 2024 19:21:35 -0700 (PDT)
Received: from [172.20.10.2] ([182.153.180.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9d5c9c6sm4419363a91.46.2024.09.14.19.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 19:21:35 -0700 (PDT)
Message-ID: <8a813234-71d3-49e7-9a2e-c950fe35be20@gmail.com>
Date: Sun, 15 Sep 2024 10:21:28 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/22] arm64: dts: apple: Add A8X devices
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
 Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Mark Kettenis <kettenis@openbsd.org>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc: Konrad Dybcio <konradybcio@kernel.org>
References: <20240914052413.68177-1-towinchenmi@gmail.com>
 <20240914052413.68177-19-towinchenmi@gmail.com>
 <34c748fe-89d2-d3a5-599d-52972c10f688@gmail.com>
Content-Language: en-MW
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <34c748fe-89d2-d3a5-599d-52972c10f688@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15/9/2024 05:02, Ivaylo Ivanov wrote:
> 
> On 9/14/24 08:17, Nick Chan wrote:
>> From: Konrad Dybcio <konradybcio@kernel.org>
>>
>> Add DTS files for the A8X SoC and the only device based on it, the iPad
>> Air 2.
>>
>> Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
>> [Ivalyo: system memory bits]
> s/Ivalyo/Ivaylo/g
oh...

>> Co-developed-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
For A7-A8X, the tags are from Konrad's linux fork from two years ago,
though your tags in particular may no longer apply since as you can
see, all memory related things are now /* To be filled by loader */.

> 
> You've confused me with Markuss Broks <markuss.broks@gmail.com>.
> 
> He was the one who brought up A8X. I brought up A8 (in particular
> 
> iPhone 6).
> 
> 
> Regards, Ivo.
> 
>> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
>> [Nick: SMP, m1n1 and gpio-keys support, pinctrl fixes]
>> Co-developed-by: Nick Chan <towinchenmi@gmail.com>
>> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
>> ---
>>  arch/arm64/boot/dts/apple/Makefile        |   2 +
>>  arch/arm64/boot/dts/apple/t7001-air2.dtsi |  46 +++++++
>>  arch/arm64/boot/dts/apple/t7001-j81.dts   |  14 ++
>>  arch/arm64/boot/dts/apple/t7001-j82.dts   |  14 ++
>>  arch/arm64/boot/dts/apple/t7001.dtsi      | 154 ++++++++++++++++++++++
>>  5 files changed, 230 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/apple/t7001-air2.dtsi
> [snip]
>> +			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
>> +	};
>> +};

Nick Chan


