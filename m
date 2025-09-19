Return-Path: <linux-pm+bounces-35044-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3C6B8A56C
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 17:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90BB6B64831
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 15:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035C631A80A;
	Fri, 19 Sep 2025 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="olAimwhx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BDD31A564
	for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296190; cv=none; b=QeTw2PJH2F9I5bKlcADhCHnHeKln1YwmkT8U5nfc2FCp9YRsY4BbiOQZ9ydPkp52UmMV0XYiz1AvD1MzMy/4Sxa4asY12Y6THumtHE1kjOnInpEIIYMsMQRiwEGTuFDGQWKXzpyhF7ElrX3jQWUS3oEWuTdXBbH+s64vRetinLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296190; c=relaxed/simple;
	bh=QQ13y357KdcEoMsg6bRgvQuNzIHdWlBZTLLZM/2ttNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=efczkUBHVMFBUs2sBY8N/EhH2Thvzqtayc4PeH0Pi+3TMHe7xS3OeWoMZu+16QIVmuXnQlCJMxbe8RKBKDjxO0Wuu7F8no9F/omEr+oW0vTDU/6C2QvTe3FEDtY8vLW6397S7/mmDXN9L11Hy/5lH7uDnnDtqukbyWcWk9BvBM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=olAimwhx; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ee1381b835so1237940f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 08:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758296187; x=1758900987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f2pRpE/45sP9niRYSRq9qImpVKIDTIafU8gzww+a/cI=;
        b=olAimwhxLsKMhKYeqjqMZvqxn071mQyq0ldUX5QgkcLSzXtBsBqRHbSAGScekEdTU+
         MGeKRZoRPGyIycDGUzu4hIs9xjb51px4qgFatcI28GGL3ixLuZ9289r4aJtFsbawrk1w
         choirb1DyaXSd/XwmZ67senyHvZkBdUOQnUef/320a6Y8GgP7SNzHEBF4ickCRidcAkq
         Ts5SyCHyMJNHWgi90qP4yM7ShZ0LJxxu1EMaYd0igXZIutrxE6xlJ4nED6tfvDdh/4+t
         wV/p3mML4z4DN4PsFA0/67+fcm78wM3zxtmFQmYQoVRq32aAr2cx5jojUcMzgqV3nFLZ
         odjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758296187; x=1758900987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f2pRpE/45sP9niRYSRq9qImpVKIDTIafU8gzww+a/cI=;
        b=mO1ROamYFzhIn05Sq1YRt/sxdf0OVYfi/o8jzSRq+4OOrg+Ao+CqSckf7oi7bdVjti
         RN8yDh5h8mqBekvmh5n+wAGwpvxr1LrgowYKVrhVnlmIOS0qiHblLcgU5h6nhtGfTU8J
         93K2c5JSywmEnfGuFQmBIa3xq7oKv8iNzTjmTa1hJSzAvX1GdI6nJTO5pAJh9ALPgjsu
         G1Vc9j6YJ+/Gl08T2pR/LCSfiSrhTHz9VUwLZ+Yfg4Si+DT6GdTnZ+NA0gH+GnvIFzDq
         l451m97dXIvojQm8wRQuKKL3yCLs0NhoslyyFZO+51AhKE5i6rK3ER8D1oyXbqIMUXz6
         N36A==
X-Forwarded-Encrypted: i=1; AJvYcCURXJ23QeQie2DPQhE3M/MNZnBl0enjhzQ4G/EKgvh3Wfq6kjzpt4PHYZkIRTMaVzjRQ6ZpH/1VMA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx37bfkUvMl/Vi+xf1y7EMxpmjXjPwOpQ5ZKC6H8DaI8TzEkCMN
	cqnHPmcTan3/DXWGo3r+sUI+LEYoyb+xU1n5v4D2mi7uLpz/zWkJGW9Ikok9iLKc4Ew=
X-Gm-Gg: ASbGncuDRsKtaj69W41AtBWY4l4xKBjYki8199Et2/SoUQztzFu/LTK6+JtiYuWIbxf
	5wPM5MOyY7t7H2QYKXz6U0dnk5kueyxeua9WDi0vYZRuiiwZfaLdOM9JIh6tgDnA1XJNhuJE1KG
	4FY0vKb96CHgQRIPt1of/RDi5roIph7eoUxqBNLL6XsrIftLsiwjPkZ+aHf6zr/bXlbWQr60ocw
	DgTPSHBN6WrsNI/3hTwK6WEtRqlFkGdxStF1THE0Vs+OH7lOmWWVNEtp9q178wDfC3bHmIvvL7D
	s3oVHBGEXm+OKcuRUJJVh7KXPPV4AHzmJiILxkL9QclKyNRQhRuS3vIUhKUp+cuLeI0FwmNCjnF
	/kFDLz229DiURCZCcHiaRqJNuoram/ufjr3kSZwdrYxkMd3Ss4sDKu2BwQduvl6QcrJFLgQaEZT
	qtAg==
X-Google-Smtp-Source: AGHT+IG3N6yDffPIIsvlc2hrfvII+0O+KrDC9YtG2RKsx3+KurTsZNXbENU81ur2gTzujZrnIC6z3A==
X-Received: by 2002:a05:6000:1862:b0:3ec:1b42:1f8d with SMTP id ffacd0b85a97d-3ee7c5542c6mr2990681f8f.10.1758296187269;
        Fri, 19 Sep 2025 08:36:27 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:8ffd:205a:6719:49c1? ([2a05:6e02:1041:c10:8ffd:205a:6719:49c1])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-464f0d8a2bfsm93035635e9.2.2025.09.19.08.36.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 08:36:26 -0700 (PDT)
Message-ID: <3613157b-8c98-44b4-89b3-75eb7fe397ac@linaro.org>
Date: Fri, 19 Sep 2025 17:36:26 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/rcar_gen3: fix mapping SoCs to generic
 Gen4 entry
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-renesas-soc@vger.kernel.org
Cc: =?UTF-8?Q?Niklas_S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Magnus Damm <magnus.damm@gmail.com>,
 linux-pm@vger.kernel.org
References: <20250911070254.2214-2-wsa+renesas@sang-engineering.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250911070254.2214-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/09/2025 09:00, Wolfram Sang wrote:
> S4 was added first so it was assumed to be the blueprint for R-Car Gen4.
> It turned out now, that S4 is a special mix between Gen3 and Gen4. V4H
> and V4M are the similar ones as confirmed by HW engineers.
> 
> So, rename the S4 entry to be specific instead of generic. Rename the
> V4H entry to be the new generic one, so V4M will use it as well now.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

