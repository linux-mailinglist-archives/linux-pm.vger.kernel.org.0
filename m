Return-Path: <linux-pm+bounces-23925-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0E2A5E168
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 17:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BFCC168E12
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 16:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CBC19D092;
	Wed, 12 Mar 2025 16:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="boVJ9VfV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957843D76
	for <linux-pm@vger.kernel.org>; Wed, 12 Mar 2025 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741795593; cv=none; b=opfRfzubCdZdQ2T9MOKVTUAGPRofGUPSPsnqLUzsMfJmH7/uua49ZHSIAdpr5Iu8VqdKHqfczBKNBkOBvjwf2erRn5rBoRZP6I8Q8vu9xW5p2Xa3pXxcj12brtE59hKMDZy9etwJimeMLXN12ArFcS8t+o8K4r/1JsTI91/ZrbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741795593; c=relaxed/simple;
	bh=nmo8fdXV2sIpmS5UmT2CDlZRiYH6e9W1wePfJpe9bQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EnHnScFaqD6V2OXIwu3NUJeChH6Xlb0ABiiAXjP57JI+HXgQ6H/C8Z7mKneH2UXpwM1m5S2cD4e7zusq4BTSFplGwrdt2pJLwkrTmtHfjaaqnldWRUr43ktGuruVUwOZYmzM/2+OzJYVO99bgrpWvs8Lkv42ezRz0P3lA8iOIos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=boVJ9VfV; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso27648285e9.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Mar 2025 09:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741795590; x=1742400390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9YK3oQqTUtAqfGd/88d2ovA0EBim6Stx5RfHYpnVTCQ=;
        b=boVJ9VfVpEJZgLL086LpZsrEZhmK9n1+E8TpCP9/sOlagwkHgZgKvm8RrvScTaoBLZ
         wCmlcZr4xnJTp+ORcQVXZ8cII2DFSkW11KtO6KPrL3x3cPlrF/pJz3+33B+XX+KHIZ9y
         5tvVw8vLKPvftshVaK/D9Ipw2UBeBIC6FPcji//M1lUP5h3lXGJnz0a5cPHp8mhXrzvD
         GRFALkOLBNGoYzMSKNlc8kLOXA2xv3Jsw3uLngoxs+qUeS0u+mvQb1toSrUrmnb+OxvF
         Y4YlzSJXDZ/A5rnHO7Qo789w34CXMP1r+0j7RWK73xlGw1aPcDXBk3mb3Uh6De+tZYAN
         vIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741795590; x=1742400390;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9YK3oQqTUtAqfGd/88d2ovA0EBim6Stx5RfHYpnVTCQ=;
        b=uqKXFAgvHNUMDeT2hvfkfdKDS6aGmSZpjnXZ3Nobt8AP8FVVCGyUGhx8bpmTdWdT9l
         uhMncklUA/L+hulwzIZ15Cwq7Zs124DZIeGoygx0I1DKPq2eph63VEC50dudDTkWP4q2
         Ehzqgov3LdhqAdQ4gMF/miDIB2mdbWqWw4BsbSL2Le+mp103l5BgPFj6cjzHPtTm8gyR
         a3HJ55FJc93rgLvb5LoYxY1TKwGZHI+Qhg73aS7sv8dFCUNmXHgQUw87lF1zulC9BsyU
         S17Skls7W9B7Uh1jtdKRAOmi1p18uQSYLjDBCHFYq9f+NXEeW/4J4WXj6e6wndbNWkq4
         9NPg==
X-Forwarded-Encrypted: i=1; AJvYcCWn+PhP/t3pT7QoJcIk6m/nhKQ5qHKSplRfd472f6oB+CSGe36rt5Q9gswKkZmD69vmxxEFNH3utg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjIIqei2kPvAmLmDWvZ3WXIWiyM/ytrue9Bhh2khRUNsXkXVrI
	RnBPy+cRSL4mfpvqRRwxsA84IvZwsWSt+SiDydJcygAGqf8bgbtuEh4hu4rXjzM=
X-Gm-Gg: ASbGnctRJSWszkqDavs8spCa2P4QJB4u4WQ13g6FPvyjNPx+/W7DXF/pT3LGYxw1E/T
	btWY5HUlP9C/bgQ2c9BA+ozO5aLzF3fRDHDfp0mbMhRgcB2kVeRtJaLOzLKsIADo0iMfhCqi/8H
	8KFazQdYazXeD+4bUp5mPJ53d3QBlNQlYfppmpqPdQJXnsYnyT/6H6M3qPLmLZeDE7IvvqZUwj1
	IC24eTgnBSm27jzYUy1+kEO0w6eAuTfJ6K3w7owrknucghk0mYYT9aZY96qeWOBJ9GKsBfj0ctT
	viCz2eTBRD7oRjlIQWApkemkqlYsj7Cr0ykhq6jSgfn3OfU2vrrUngaVWi5NJtE6NGRZjYLVEro
	NvrqKdnx5
X-Google-Smtp-Source: AGHT+IGMjnZwEAiEt9Jm4Glsz7srOujFsqeA4GASDmYTpBVB3vgRlKNikYsg5C0lOJ+mSPfd3fXt3w==
X-Received: by 2002:a5d:6d09:0:b0:38f:355b:13e9 with SMTP id ffacd0b85a97d-39132d33c10mr18303880f8f.15.1741795589829;
        Wed, 12 Mar 2025 09:06:29 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912c0193bfsm21775014f8f.55.2025.03.12.09.06.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 09:06:29 -0700 (PDT)
Message-ID: <9721ca95-7726-4c17-bbb8-3db1212847ce@linaro.org>
Date: Wed, 12 Mar 2025 17:06:28 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] thermal: rcar_gen3: Improve reading calibration
 fuses
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, linux-renesas-soc@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250305174631.4119374-1-niklas.soderlund+renesas@ragnatech.se>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250305174631.4119374-1-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/03/2025 18:46, Niklas Söderlund wrote:
> Hello,
> 
> This small series aims to remove the code duplication that was added
> when adding support for Gen4 devices. The logic to read the calibration
> fuses are identical for Gen3 and Gen4, but the registers are at
> different offsets.
> 
> Patch 1/2 is a small drive-by patch which fixes a style issue of the
> constants found when working on the fuses code. While patch 2/2 is the
> real work removing the code duplication.
> 
> It is tested on both Gen3 and Gen4 boards, but as not all boards have
> the fused calibration values and the driver fallback to hard coded
> values only Gen4 have really been tested as I don't have access to a
> Gen3 board with fused calibration values.

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

