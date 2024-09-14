Return-Path: <linux-pm+bounces-14287-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B35369792A0
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 19:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75151C219CC
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 17:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5781D12FB;
	Sat, 14 Sep 2024 17:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoqGHgcm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F399B1CFEC1;
	Sat, 14 Sep 2024 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726334285; cv=none; b=C7UX2vRNMGMqbp9F29Vyr1O5ilQZoIBHQabeygm5ohqjqYof9ixFiGAwdxp7D4YsH8jlK0/jmU+Gu1R/8vU7rU3mWy9iRO6/p2HS5fykotQ5w79oky0lcLWnle+gYu+09QjOG98m3HXEAu1CdeSpj+0qrUcRHv/c5lQGxlRkbAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726334285; c=relaxed/simple;
	bh=aRytwP9pLBei3TTlU1BMBB5/oF2kGbMPm/3Y+2Ugk9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pVd6oIxVJ2f+34yNzTPZ/Cv9mf/H+gVDutWrO8tIoTM8l7STwfQQweES0DJiyGbZiiLCNboS2XPHjkfiEBhrTmSjypEl28AtFuVsBd/Y7A6ZkFOWpCvf9dQ5w1aDMdmaXsL2AMew49hR3JH9aI6Rabra2g4b4abj1hA/LBW3XNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoqGHgcm; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-718f4fd89e5so2925803b3a.0;
        Sat, 14 Sep 2024 10:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726334283; x=1726939083; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5+GhMoA3xa1971oY2HzI8hp5Uk+PbFfIHHqZtQjkbuw=;
        b=aoqGHgcmwSE8wbps4MAOXLJh50AaJmj5IVUjAJ5wazDJROV/MrdWS8KgL5nazrpB8Y
         CgJj48ZVu+b9rSxghfmgie02ycaau4zdJb2cvLNJr8rcnGI5YoR0k82XACkYT3rf0fUh
         z68GbGKQhjgGrR3GfoSIZij4vmx1pA4uY4f2AQiA6mipu+38+oXcUNpjsSWNS3yTBEQc
         HJAjXIWliDj7NvBcficUOpNWA8GncHGMRjJ39IVenFGahyZDxJXtY7EGaiY3/FIWqzVg
         exth4x6xPoKCc0857MESbPrMjYNap7szo637826JlGlvRyK+FHH1aZAyS22ZuEFnCNpY
         GtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726334283; x=1726939083;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+GhMoA3xa1971oY2HzI8hp5Uk+PbFfIHHqZtQjkbuw=;
        b=A5auRwNcAAHxvUOV9IlYk4lqFI4bFlXtPkPqx5hUpWZAwSKUrv+pl5umbZnDwOObdZ
         UtQNXRL/RPecc/waKZD5YGaaYiCzurv/iVbnWs4M1dsaKf+SsVTGJ3MiNb4Q6hMet8AW
         zYuY4V1O19BVIEjhL1TVrEtlMkv7uDhsLefQ/lLfYlEgC1hIjw73SJ7Ux36OuXF+2Bhs
         De2AuvM6+7mQeZQaWdsTqXsWA1y48hFHR+oyjYZyAvdR4CPa4jMo8TVG68m/9rz6XtkE
         NJ6IY4TRG+kfmkFCdXA/TupSRT1gKXeJAdUb/q8ny8R9AU8FqQoBaMPg03cY3Gy/+SKI
         LnkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS9IR76KT1NN986O4Lp8UfGQ7EAgzo8dgbFA++2RRliQEQ7C+gY/528vAbo3pnNiyGiJMf5ZavpMk=@vger.kernel.org, AJvYcCVR5DR9TxAnxQfsSiAuVCF+UQmEABuNeOZXdm9qqPDhg2/n8uZLtARv246wEx6gzdNNWrAcFArdUODcMzG+@vger.kernel.org, AJvYcCVtGXsS7U/nAveX9bG5c6vOmzYjUXqadikcthwqvMyJWU2nXUglNoOIymmnLZJOPO95ripyBM1gV/BMMHhEbo8=@vger.kernel.org, AJvYcCXLW1k6vseSJtk+2UVIOMeiPRgBUnwrAZDn1PIHwL3u7NySl9MaA0J+9rztt9aIWBM8nvpmD7gd7The@vger.kernel.org, AJvYcCXONPUUPsBNOucWQd6yj7wjH3/h1VvXKJhZdEtlo88PnvfulgS215XemBRMsnf11ioT0KKPbYDjBwHHDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqerectmuYGGykdaZxsRDmeKFDAZbI+lPIdhJXW+HznZwPeaGL
	mUDNpREOkzi3rEmlXj4dTgH7tP4zzP7gm/rVpwT8Y/87kp72B4Kw
X-Google-Smtp-Source: AGHT+IEVlENJgk8dXWBf4D2XILJQRHJRlYjJlO5FZwJPUxVX2SZ1X5qAa0SOTNhIkEM4keufiASuDw==
X-Received: by 2002:a05:6a00:b92:b0:717:8d81:e548 with SMTP id d2e1a72fcca58-7192606523bmr15785200b3a.1.1726334283027;
        Sat, 14 Sep 2024 10:18:03 -0700 (PDT)
Received: from [192.168.0.122] ([59.188.211.160])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db4999cfb7sm1397145a12.79.2024.09.14.10.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 10:18:02 -0700 (PDT)
Message-ID: <2ebf5258-b55d-4010-aa94-d5bab1f93bb5@gmail.com>
Date: Sun, 15 Sep 2024 01:17:57 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/22] dt-bindings: cpufreq: apple,cluster-cpufreq: Add
 A10 compatible
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
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
Cc: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>
References: <20240914052413.68177-1-towinchenmi@gmail.com>
 <20240914052413.68177-6-towinchenmi@gmail.com>
Content-Language: en-MW
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20240914052413.68177-6-towinchenmi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14/9/2024 13:17, Nick Chan wrote:
> The block found on the Apple A10 SoC is compatible with the
> existing driver so just add its per-SoC compatible.
> 
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  .../devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml    | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml b/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
> index 76cb9726660e..e0d1a9813696 100644
> --- a/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
> +++ b/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
> @@ -24,7 +24,9 @@ properties:
>                - apple,t8112-cluster-cpufreq
>            - const: apple,cluster-cpufreq
>        - items:
> -          - const: apple,t6000-cluster-cpufreq
> +          - enum:
> +              - apple,t8010-cluster-cpufreq
> +              - apple,t6000-cluster-cpufreq
>            - const: apple,t8103-cluster-cpufreq
>            - const: apple,cluster-cpufreq
>  

Have to retract the cpufreq patches, a v3 without them will be available
tomorrow. cpufreq works on iPad 7 (A10). However it is already pretty
weird when the cpufreq did not work on Apple TV 4K (A10X), with adjusted
p-states. However, it seems that iPhone 7 (A10) is also not working. So
this is definitely broken. As far as the hardware interfaces go they should
be compatible, so the only explanation that makes sense is that the behavior
is not correct on t8010 and t8011 and it only *happened* to work on iPad 7,
with some incorrect behaviors.

Marked as deferred on patchwork.

Nick Chan

