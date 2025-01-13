Return-Path: <linux-pm+bounces-20364-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7FEA0BFDF
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 19:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F48168D8A
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 18:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42471C3C1F;
	Mon, 13 Jan 2025 18:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ig3xdhV4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5C71C5485;
	Mon, 13 Jan 2025 18:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793262; cv=none; b=nBj8gTElLnsah0nzCtIKyO2QZB/Y8lMTdcYHQwbXFnAKbzHvo6jzh726MPLaLaWr4ZHRsIuvZ+ZGkRzVvdcnoXOZwSg9hAZd4UvPANssv991EyRYI6UPKspj3QPkSZt4ce07huNpN/1q5XjuAs2uerRX9AjwnnK8pgg/mMSRZ8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793262; c=relaxed/simple;
	bh=JW66LzXvkSldtcjOIAoWhfUsMT1RsmmpXnMrCnnL98M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SOcvV7f0KGnyvyR5wWQBZyj9bP5z6fRT5Fh/QcXKlBjuzxqhngZYJgiSEwUxmokGn5n6ejWGccyvxO9M1KPHa84eAh5MTt9znB5tGe/ZC+NsDWxYXP+bwWYhyKrnFAWd9Sj5VQYRPnTfJ9Q+Z+sVpi7tby6Cx/pSkQ+GtvtM33I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ig3xdhV4; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ef748105deso5849458a91.1;
        Mon, 13 Jan 2025 10:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736793260; x=1737398060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dUk9K/3v1fmRTIGpSlzyJ4xMMqx5o/nZbSm/00tBSUQ=;
        b=Ig3xdhV4VrOpQO4CQ7srMkUZesZOs+vJlKusoVcUqA2uXwYZFYYBJjjYBO9yTUKTR0
         ufF0zZZSYOqp+ad4NE36e7HVdrpNv8HFzF7dTvan6IGAAFKBPX/oodVq00XP7qZJl8yX
         51T0+j5mgvPJcOtyL54IybCkbWgc+l7htUEeoCD4wi+GaN2y6JDCW0Av0ew6r1D6QLK1
         rPSCU9Pbgd+iSj3mKdhGPre43o2Yo8Tx/Zxb2g3d2elYOKOhgYXYD0m1EZQvCq6nud9R
         L16lYs0BXUAGdvEdPxCqSmdNjgZwfmXmY3aHAbX0zvEBSFodjyuSqIj24VqavBP2aFav
         8aMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736793260; x=1737398060;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUk9K/3v1fmRTIGpSlzyJ4xMMqx5o/nZbSm/00tBSUQ=;
        b=WVTQX2oj6N9uatgjDwLIgjvDT7Dd+6pql4S+fo03uraZLkqO+PEN3IeHZSQ8iXR0Pt
         aP9fRNT1qHqntxBaYTyChkZGCdqLhpEZsW19BNLuhVPbwQsrSpD+qYynuZXFQyiQ2kd5
         ewAJVNUua6epOh95FcwY7NOuMyI/arzueuJ/kKTXILAPf5Hl36rwQa6t/oCMwyVZBqJZ
         gwjZyZsKn8A21lnEovmbABASL/ZuZIBkc+sVzpi1NBq/dOFjA73jTBb8buEd74l9jxNY
         aNdxrBuJ9q13Esf/uhOu2hkXkusHMKhbrgA+c4e+gyR8kuhszk0B+K6Kj4x3MdNz62vz
         DZLA==
X-Forwarded-Encrypted: i=1; AJvYcCUkphzOSwL44VhK/PxzI2vKqBEtInHln7ogQGlUwTmY/9rdJGcB7VkSOPPhBQMWi47OZAWjVBxSKFKcMPQ=@vger.kernel.org, AJvYcCVSeNyo+xe81SY4jDj7Ot0Qkc7e6/iPF/Vw1r3ELmbT+qZcUsDFMBcvYr2zrCkK0/hvsKlFpqdeZkLqvxqhyIo/bLxNBw==@vger.kernel.org, AJvYcCVSo1rbbU4bllLGTNIZVf8VW031vqe3MbTsLrTPPLvJyLB80OGqCScnXLwZ/YgxJ0K66tGDZrO9Kck=@vger.kernel.org, AJvYcCVmGVxAlCcJVd+FF/UFZIgkHA0Ckpn9iv1dN9AvIKHQvQGrX5NsmvWiznz7xHxYhnL3EDSagepUU0zIGMiP@vger.kernel.org, AJvYcCVvwf5a9tBRX+AuKWgfW2PbZR+PMqPY6uHb5uSE76So7AbFbutcM4Pl1fmPmnGpCzHWMbwqoPfgkMWgo1bJ@vger.kernel.org, AJvYcCXVm8lbZbcUEGZLKZ84ifdI3AhkGzTsTDo629yWhxYCY4N5LTIklje9/em/ZlsvZPVKCYcdNR3hwxZd@vger.kernel.org
X-Gm-Message-State: AOJu0YyMhSPxb6hfS9VLNT21MdoNLFID0cJSpZQMSAY37MZCcHKAM+HZ
	83aceD64+ZyxMf8SQWzZ/HCqn+6ry7694YmHI3Bb8RVnObgdyb55
X-Gm-Gg: ASbGncsWyb1qN9NDCGXSgIO5RpG9vofVq/AZFDHTUblXo5x//WAKG4LnJTtVM9BtHzu
	FOQtoHkEiLOPZErWJVF8bWeHwIvZH5hWU1BreR+zcb+dZA/8qgi2AjzCU8U6QBVTUtk2iGafgbn
	txJbWZnU6keDExEgmYw3kOufRRqaokMppfr4/9180cNEr/25ARGB8gJXKSniswqqYkCoE/c4P09
	gYVPnhy2V+ldUdUzxHLbPL0XU0Tarhc2gmox67c0hOIzZhNnqhSEK2k4kNgm6iUj5BCZEkJeKKz
	fjrKBX82dZGhUji/DqVKfkEaXY5ASg==
X-Google-Smtp-Source: AGHT+IGffTqtldE+fbRRcZSQfUCPNUY9FZEm8W/f9587s75zCFU9ByP7Dahck4ocBkuv8JrlehJN8w==
X-Received: by 2002:a17:90b:4a44:b0:2ea:61de:38f7 with SMTP id 98e67ed59e1d1-2f548f1d420mr31860946a91.29.1736793260365;
        Mon, 13 Jan 2025 10:34:20 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f5593d07cbsm9069751a91.3.2025.01.13.10.34.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 10:34:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <dae486c3-8c3d-4b56-8022-4620fa638f82@roeck-us.net>
Date: Mon, 13 Jan 2025 10:34:17 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] platform: arm64: add Huawei Matebook E Go EC
 driver
To: Pengyu Luo <mitltlatltl@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Sebastian Reichel <sre@kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jean Delvare <jdelvare@suse.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20250113175049.590511-1-mitltlatltl@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250113175049.590511-1-mitltlatltl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/13/25 09:50, Pengyu Luo wrote:
> There are three variants of which Huawei released the first two
> simultaneously.
> 
> Huawei Matebook E Go LTE(sc8180x), codename seems to be gaokun2.
> Huawei Matebook E Go(sc8280xp@3.0GHz), codename must be gaokun3. (see [1])
> Huawei Matebook E Go 2023(sc8280xp@2.69GHz), codename should be also gaokun3.
> 
> Adding support for the latter two variants for now, this driver should
> also work for the sc8180x variant according to acpi table files, but I
> don't have the device to test yet.
> 
> Different from other Qualcomm Snapdragon sc8280xp based machines, the
> Huawei Matebook E Go uses an embedded controller while others use
> a system called PMIC GLink. This embedded controller can be used to
> perform a set of various functions, including, but not limited to:
> 
> - Battery and charger monitoring;
> - Charge control and smart charge;
> - Fn_lock settings;
> - Tablet lid status;
> - Temperature sensors;
> - USB Type-C notifications (ports orientation,  DP alt mode HPD);
> - USB Type-C PD (according to observation, up to 48w).
> 
> Add a driver for the EC which creates devices for UCSI and power supply
> devices.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=219645
> 
> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> ---
...
> +	ec->hwmon_dev = hwmon_device_register_with_groups(dev, "gaokun_ec_hwmon",
> +							  ec, gaokun_ec_hwmon_groups);

This API function is deprecated.

Guenter


