Return-Path: <linux-pm+bounces-17642-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6679CF280
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 18:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2DF21F21CB3
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 17:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C86F1D5AC0;
	Fri, 15 Nov 2024 17:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNR2SleJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1931D5173;
	Fri, 15 Nov 2024 17:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731690792; cv=none; b=pPL14LVvKenRHa2pYeZFAO9etAUC7KhuHQoHJROhRXikzKo4WwFXIXnxp5F7Mv0aq4CdOtsjBjLzmRu59GCqwbXtW1RGzUYYhPQHP9kpw/qlGSzbcjcP1/O2pA370axNA6M9HURKhyzF2AhoUjh0QSEOOzlM0q1kqIeC/P0r6gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731690792; c=relaxed/simple;
	bh=sEzTkK8tBzDoNCkPrYPhapI5bIdjA/ehHbsZ9yd/nPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JlKCb3Ey81TnswZs6thWbPwIwJKxhDX226aVR3JnKfjg6wW7DlDmAtZXvXnnC7YTW1m1662kvZGK/z455gb05ZpTd1OaRLm/2MxAfSDvaXrBKQpSyOr2eTrkobj1YPwalLXxpkb8d8k+x/gS71QS/xf1KvvNs1f11ugNv2W/0TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNR2SleJ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ed9c16f687so677181a12.0;
        Fri, 15 Nov 2024 09:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731690790; x=1732295590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gY4NhCLwqH9wEkLSR5pI2JhRlkkr03HGnCBjgVFYm8g=;
        b=CNR2SleJDkjfbg9OSSKSb+AWc2mAgB4SUZ6IiZyahF8kALBfYCwW9hsqZjDjxRJzKo
         Kn9QQbl+rAWz+XpHBfIq2xeX5U3Wz40r2y9ZKGGSTQpX+le+g2Y96Noq/s08H6/AZ45t
         GIbJwYzRJjjVpGHyIJCEDVlgcGbyb81l6KduORgoEkrelb0cLxMIy3amYIDhr2hJwhh2
         2dUjyYukx2965Z+SeFct86z97ncpxm4U5OOmxaEJV9bjuKNMQciyRkXfvEpp36XLWIp2
         3xnCuRpAse+RNpZm73CksnxmxPbXjKSPwJmcdcVKjlCNtpXucQ6asX+nUWjGKJMRRHgK
         LSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731690790; x=1732295590;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gY4NhCLwqH9wEkLSR5pI2JhRlkkr03HGnCBjgVFYm8g=;
        b=w4yFAVulK/J5SG2kPMFf7DSnuNXojLRyXLmoK2YKjro12LjlNBsdTsZx7PLypigaia
         S/cmmly/uxrNBLtD+/X2j1eQsUyfoqMOSlhoBfGLx6hMaVBWoBawOIbkYwpITP2gg0eV
         YcFsXGHpg537DLGlVDaNSCoBUIZNUe4R46cQaTv2S/9g5YDegJU51u6nTdTq6ZqOxBLE
         OgEx9p8U/RxB8BIPXTcLSpS/ZkSYRskOw9jyTu7mzGo1oIl5XUBhEwKip2zR6PfmWXRC
         WH5WPEYdLAPqTQw0DicSvrrDt9bLyvfdvPnyacEjc0dF6dNvVM351SzI0MKlFQMvc7+T
         PWeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSIrDR4b0T/dPEY9ez9zPkih4JncxgeMl4wPSEBL6cj2Wh1E3vz0AZfsN9Gaf0wtJupiaPTqiziHuzzRI=@vger.kernel.org, AJvYcCXydZSjAbTxig2V/0IBjfLSa7O3CcnBewUH2SUrkXPZr7yNUMbJqpnLiULO9IzuJR7IIIZfbxiJRC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjFBCSBLMlfl27kWyPTwbLX23hkG7P/AWoUQZlx1BtXDC1xULv
	kDTm3r5EykZ9DmlWt/gDeMbyWlFMZ5t0nt7qS/3GpFhK+xQjcMOo
X-Google-Smtp-Source: AGHT+IEwWlGvMiN732+gdweh0l1KzLxnmkdC+Wti88J9SuConhBHXmVR/KjB9bkEzgCXnyEBhqqXcA==
X-Received: by 2002:a17:90b:314b:b0:2e2:cfef:86 with SMTP id 98e67ed59e1d1-2ea154cd93dmr3859721a91.4.1731690789908;
        Fri, 15 Nov 2024 09:13:09 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea024b82aasm3136043a91.33.2024.11.15.09.13.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 09:13:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <16ff1f86-8de2-4522-8f9a-51f5110bb365@roeck-us.net>
Date: Fri, 15 Nov 2024 09:13:07 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hwmon: (core) Avoid ifdef CONFIG_THERMAL in C
 source file
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Jean Delvare <jdelvare@suse.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20241115-hwmon-thermal-v2-0-c96f0c0984b2@weissschuh.net>
 <20241115-hwmon-thermal-v2-2-c96f0c0984b2@weissschuh.net>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241115-hwmon-thermal-v2-2-c96f0c0984b2@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/15/24 08:40, Thomas Weißschuh wrote:
> Using an #ifdef in a C source files to have different definitions
> of the same symbol makes the code harder to read and understand.
> Furthermore it makes it harder to test compilation of the different
> branches.
> 
> Replace the ifdeffery with IS_ENABLED() which is just a normal
> conditional.
> The resulting binary is still the same as before as the compiler
> optimizes away all the unused code and definitions.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

For my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Pending acceptance of the first patch in the series.

Thanks,
Guenter


