Return-Path: <linux-pm+bounces-22014-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E58A33F0C
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 13:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C14E188AD2C
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 12:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEA8221559;
	Thu, 13 Feb 2025 12:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kMP1GvgS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919EC21D3D2
	for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739449494; cv=none; b=FHEmCSP1ONC8lD2rbrAz3Ct4nhZTnw3DJkfVurWDp9srzRdly901PhlY5At+EWSG12f1WFcFWPhEyMxjXVXaPRWW+wnptAv9yYBcDHPnCLDnqRYpz8QMVBF5CYefqg0AJWUW2AlgELoXIml0rC3Bz+mgcZiGEgV8AUgPSnEaLdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739449494; c=relaxed/simple;
	bh=ZDgifnO2eXQLO+3FjCdjysEvK77aW7cAL9ZpjrzvDXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PyLZHf6lTadk/5nKjXbakn3RZ+nPB04sRQtPf7s2HsygvTcj3gkmuEEswZFWYyBb/5fDl1Ykkhnzf9h2wRQcWXdvyrB1quyd0ViLIK854BFECaYTrYI3GaN9k1uFyfPinLG0yw6ZP5n0S43eZa5Fyo9aG6qN19FPsHpO/W/mBkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kMP1GvgS; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5450982c7edso76685e87.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 04:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739449491; x=1740054291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5GCfGb+lf3aOIwd+RY6NCgd8Twa0/XMsahXFwWYyqjk=;
        b=kMP1GvgSPYe4qzneEhYLHbfaV3B5c5p/WxWm09rpN8J2zrDONAWsjvvkZ/xY54DNc1
         KHpgkvLdHTGJy8YavBRrhsqsDAW6i25OK/BCAdbgHZO1YAW8Laq+f30mnrz7pu0sPZS/
         0CTlwl4QE4ZoK7U9biWPu94EdqcQ4OwmUYLL7ZY1cEqsxUhh1vbVwY6QZING1d9nBIDO
         5ld5PQc277jGFwMPEHPxSP28qhIxaERB4OJ7ejtS4gLPRREFeWEI7fXezqrR7k3VOmYj
         +/didzFi3x0+K16Hv/getXcXguskXpeBq6KUtFVOWBofiM1NRJp3z8kN2nAgbZMbGNDh
         ED1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739449491; x=1740054291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5GCfGb+lf3aOIwd+RY6NCgd8Twa0/XMsahXFwWYyqjk=;
        b=buyQnxgMdQTHMoHia6v8h1PGwNsZlT7zXI7vBbb1DH8fHjOy+h+L1O1pmzn+FgSp9s
         4zANhaKSotCxPnmYI8GeaP0Mx9BpIAYNuVvwBKWvBo0LPrkmeLpOO+T13xJXc1ymSgPm
         9CYaShFNV1bvIfUiZKQfD5ef03hjAgTwdxWqPFL6xP/B9strw0PdBMe3+jjB3WoXbYZs
         chCTel8Bqi1eDJ9vu4PQ7dy6T0cZP9VPP9PwrlGBJKn1CBB9kvjUJHcijI53Ymhx3/Jg
         o4sGpEbk3nUZ0t12UNIX63ghNYFCD6alQAZ4moq5UOaBwapPK95gohCf48z41ORI1rYY
         BHpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnsDDZr5mQcenQSQ33gwt4AnZIzscv+2nV59gihXprl79RWJv79cdgmDnkECHOEzPUcRLykbjOOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf5VLhgkecgyrvr/3tjrUGZIOlB2HA8QIu37MDY+R19nM4llwD
	DsGS6oJ8TkuP3X4XqtyLci93n3kypp8asiS1m1kzQrhaGXIm1hpksRZal9EX6DY=
X-Gm-Gg: ASbGncsiaNbV28v51TbHgKwsezd7gGgVsu+HsyrkZBmKPhOxaZLS1GO8VYqGzdWbMq6
	Wm8JPwBoZFgYl2yFtiC5B4mKxByAdHozS1XLWevBxsftYGcFX2BYk/v4yR8PYKtgAgrWrzoFpTI
	D40/vLUSXcxd/2bhWkbcHOgZMKECo/VQ5wekx/ABAF7weyrQngrt+8gkybOSTsOz49KWm2mDcfn
	TbDAyXt+1Ps6CLgdst00MdQ8Jg9DI8zZawsobgqvdpr64VUUTGbzbcCs2wzG2LnOFr30bOhCAKI
	GX9Vpkir6GJZnpDRhYQaxjBg8MDC1WVhuTijBpiSo7M5EuUbPMIA8Q1KWpBhpzO1WbRGzw==
X-Google-Smtp-Source: AGHT+IGGGD1LnQRTjzKIMu7P71jbpTMS7skHZBVLY6dWl3mmG7KfIeCOfXaf1YVcbcnJypSEi1k+cQ==
X-Received: by 2002:a05:6512:234e:b0:545:576:9e07 with SMTP id 2adb3069b0e04-545180ddc06mr822493e87.2.1739449490594;
        Thu, 13 Feb 2025 04:24:50 -0800 (PST)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f09ab7dsm162311e87.61.2025.02.13.04.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 04:24:50 -0800 (PST)
Message-ID: <85a9eda7-a6f5-401e-90b6-0353182b8deb@linaro.org>
Date: Thu, 13 Feb 2025 14:24:49 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] power: ip5xxx_power: Make use of
 i2c_get_match_data()
Content-Language: ru-RU
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 =?UTF-8?B?QmVuY2UgQ3PDs2vDoXM=?= <csokas.bence@prolan.hu>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Samuel Holland <samuel@sholland.org>, Sebastian Reichel <sre@kernel.org>
References: <20250213114613.2646933-1-andriy.shevchenko@linux.intel.com>
 <20250213114613.2646933-2-andriy.shevchenko@linux.intel.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20250213114613.2646933-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/25 13:45, Andy Shevchenko wrote:
> Get matching data in one step by switching to use i2c_get_match_data().
> 
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Now sending the tag from my different email address for the sake of consistency.

Thank you for the change.

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

--
Best wishes,
Vladimir

