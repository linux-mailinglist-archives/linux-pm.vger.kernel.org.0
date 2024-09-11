Return-Path: <linux-pm+bounces-14025-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 851939754EC
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 16:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B466C1C222B1
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 14:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0917819CC07;
	Wed, 11 Sep 2024 14:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJJPGjEn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4C9198A21;
	Wed, 11 Sep 2024 14:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726063546; cv=none; b=MrEkeLnEiRRJpURG17FD8fZ3NOhNm5F0QrtGmvRFFtvAHXu1BQPl7lBY28CLra7tUCKa23ijN+4Pm2i+HGXh1YjB4COTA+247h4r82Y0o9tDtO75pDbHK4SxN93jxKk/1D0tinGTQ/w/aKlQorsS6GkIjeIKuvbbmwAJed9YLwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726063546; c=relaxed/simple;
	bh=CXvVgiKVVo42EiBoYi+GWqFah6+XVYpe9X59iNadIIU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=inpbYljoKXjw8zZsl079YEAZZA4dq3boSLV23mLlomocyMJnjWadKn547kLqaHZWckTzsb3V4HpvFyJo71xmiXEO8pk+ADRPBKifiRMBLEybn+ldDh5BmfdnxaC9Cu3LN1LvQL+VVd1CqrSo7W5ZLAyiU/pCMA02N31f48GBb/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJJPGjEn; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-718d91eef2eso673301b3a.1;
        Wed, 11 Sep 2024 07:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726063545; x=1726668345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2pnLXhMia9bNNnroq4Q5YOL9U9MnwhtuwI40LclTYj8=;
        b=AJJPGjEnBB2vg+dUWX70xvrgvgjO74TGgki0duUGMGwrRtHLuyZxv/t4BgwjIrciFF
         XR1IpGj+jE7HpJRf6/2WzBWKRYIcSdoNKADYUvBFOMXGUw1UliGV3aJw7aV/Y7B4T3PN
         Q9jHbpMaDCmTsp44n+eHnjrvKwIqZFUbuP9cD2I4a+UF5VmJvjk5Vigf0pUsHPNxDYXy
         bcpyLZMlPKLISSS7lnvzowvMEX1OXmSFeyr57amnfh5CxvehQkzQWlpTnClh3EjpwUFE
         el2/mdUgckBvdgoCavEg5QvLWGfI54MkmvEiwJPUBlDbw4SNKrSFa4GyXsdOlesCGwSc
         h17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726063545; x=1726668345;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2pnLXhMia9bNNnroq4Q5YOL9U9MnwhtuwI40LclTYj8=;
        b=Zkr92lKnF6kMp/wySS8gQG2kAHW4Qc/UeS/zHjSwPLcfHlIj/YuVwW8eC3awXGnvlp
         PFPTl0t9rQjGoLse0gQNOUs3NQaPYtPmEtXCizn6O4CmdCpjC7Aru9apII9+Faf0XQzm
         k/5X03h8H/xYX9JxDhToKqCi/1uW2TExSbfCYtUvsAOBvQRGbUuBHZUDkUcxqnbWxmbI
         9iK56l93HKLycoHf9SnVgv1qqlTQa//myFXAl156vtqP30vx09g3Q1soNHtpJZSz0IoM
         goEkFS16V2YLUC429JJ4Hwgb70qi4vJaPDiip5MnU+7nKgCkD8eY8Ttdl5CDOjtO/v9z
         F8lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlLowewX+fyrBOLyiU20zfl7bwdpMZAj0cfewRkt9Pg3MMeykHJznRxYD7VVPnqjAOKTCxakEPKF1BAQ==@vger.kernel.org, AJvYcCXkl+XNxJm7KWsiEbSvT4xXUHbLoT4eZMPCkNVN2phFWPd20ivBtsK5nEoRZ88eAtxw1m71U+w+z5w/rJQj5vY=@vger.kernel.org, AJvYcCXt8pGN7fGJGQC42xO/Pw1nB7ARjZVVZH/l26CIULKdfZLlmFxGyQKrRXhIParjyz1SH/TC59Dvp+JGFmgy@vger.kernel.org, AJvYcCXwNeTgt7YqCKtXa2werBKzqhZ9eM5rauO8VV1jrcBoHbG93AXZPYsaem1aGGb8Ljqlhrwgv4LA2MSO@vger.kernel.org
X-Gm-Message-State: AOJu0YwugAubgM42COh5hrQuMvVGKc8HCVpAX4gC8+3TlvV2FX9T+xr9
	baF6ocDTLa1XOaqRtPlYer14xHL4raZ28sQEcEsssOU9QBDiIMxj
X-Google-Smtp-Source: AGHT+IFaiwWSHDTRYdWheipvNrkDIz8LsChIJnMeUpcmCh4XvfEUYk4ttb7dzHIbpGXRqrXDDY4pqw==
X-Received: by 2002:a05:6a00:4b0e:b0:717:8a98:8169 with SMTP id d2e1a72fcca58-71907e985fdmr11515101b3a.1.1726063544737;
        Wed, 11 Sep 2024 07:05:44 -0700 (PDT)
Received: from [192.168.0.122] ([59.188.211.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71908fe2636sm3019052b3a.60.2024.09.11.07.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 07:05:44 -0700 (PDT)
Message-ID: <0ac53bdc-7599-4f5c-a666-dc359e747530@gmail.com>
Date: Wed, 11 Sep 2024 22:05:39 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/22] Initial device trees for A7-A11 based Apple devices
From: Nick Chan <towinchenmi@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Hector Martin <marcan@marcan.st>,
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-kernel@vger.kernel.org, Mark Kettenis <kettenis@openbsd.org>,
 linux-arm-kernel@lists.infradead.org, "Rafael J . Wysocki"
 <rafael@kernel.org>, Sven Peter <sven@svenpeter.dev>,
 Conor Dooley <conor+dt@kernel.org>, linux-watchdog@vger.kernel.org,
 linux-gpio@vger.kernel.org, Will Deacon <will@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>, Viresh Kumar <viresh.kumar@linaro.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, asahi@lists.linux.dev
References: <20240911084353.28888-2-towinchenmi@gmail.com>
 <172606224294.90706.12818129202356312350.robh@kernel.org>
 <dd27d389-99ed-45f7-b2ae-c15f2633610d@gmail.com>
Content-Language: en-MW
In-Reply-To: <dd27d389-99ed-45f7-b2ae-c15f2633610d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/9/2024 21:57, Nick Chan wrote:
> 
> 
> On 11/9/2024 21:50, Rob Herring (Arm) wrote:
>>
>> On Wed, 11 Sep 2024 16:40:50 +0800, Nick Chan wrote:
>> ...
>> Error: arch/arm64/boot/dts/apple/t8010-n112.dts:21.18-19 syntax error
> Note: this is caused by missing #include <dt-bindings/input/input.h>
> This was not caught due to another error: It was not included in the
> Makefile.

I mean, it is added into the Makefile, but it got removed by the commit
to add A10X dts files...

> 
> 

Nick Chan


