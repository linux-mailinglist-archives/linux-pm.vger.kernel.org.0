Return-Path: <linux-pm+bounces-8135-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DCB8CF9A6
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 09:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E76DB20B13
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 07:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F0C17BBE;
	Mon, 27 May 2024 07:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zLAcWfkI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334E015E8C
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 07:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716793250; cv=none; b=aGEpVaUnZtLU5pO4hiJug3x52xLEMPaElnofqHaG7xQRKXd7v60GFt/i/q5fypC/RBuHguYgJj6SB7Ua+e5vxXrWQAgprDyLod2/UFRyXgDsWi6sYTZFJupTLHCTZQJgYl+Xb+QX5desVdr0kmez5OJZ8Ajs2/7Mh7RGted9cx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716793250; c=relaxed/simple;
	bh=ZBjRRGQfKQl5/b05tZA4zkWp+A2rO2OQzVfREOizFgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sSC8mkTXgGwpv58Fmkq6Xwz2XpctgI7aoLoVEgbi6tiWfxtej0ditVJc99qjwxP4ynp2vtYTSJEJIFkMCJ6y3WSbJGGmrDylgZiMheTxYKJZ3Ft0KRC0TznUyrsUVxx6HOxrndGe2N4W9zmBdH3KXInlyjMVhAETw/MnjSajxwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zLAcWfkI; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a630ff4ac84so15344066b.1
        for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 00:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716793246; x=1717398046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O8uegtVJ9to2aA6iQ6J2dzPoiPz/JfrWOXr2v1sY4RA=;
        b=zLAcWfkIdisVcpIalxEhBdjbELZvQbQQl0atM7L7fEqmUBxOfRSIrcZwo8Zv0hsPDS
         G3V8iYZNraBFrjDAsZD3k0u4IUeVHm8SQOu2iWmJ9fiaZceZT/0SU87YJjRzTzrhu63L
         slwYDT1P4jGyHbMIqM+xYV985SJ8ESQCNX1MEqqVzm/r9HgGVHNbDZwBtQYmfRu976+6
         zqAaFDWuYxZw+eAgzZINwHLcfxZIlHPKT2IyT8W5fAnvfqBH7tOPNUCJ2ikRUGbSpUmE
         00c32/DJwy4BzrAt8VnVrVfErdcsGXZKk8UQHgPMuJa1MULMo+S9fS1J4ww665G3eMe+
         whog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716793246; x=1717398046;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O8uegtVJ9to2aA6iQ6J2dzPoiPz/JfrWOXr2v1sY4RA=;
        b=ksy3wM/prqCqHQ5H/dXQTLXIpyI1QBfEs3eOjZIjE2Ffiyb6CU5U7o0Qz4VY6OzI7H
         vb3g9290zlkwg6Y4KzejmPBJprKzIRXloTMBuxedz1I0Tjf8mRviCQ1WG1JlPrM0ep8+
         d98d3bsfJwv4/9a2YskW7TEScenB+PIWKxa7GxmNBHajk0+p+PXwiran/rarGHxg8aCt
         BOOxWYLjVK7zch7ZnCIUk0P053dehqT+sDakGBIEo6ocaK/OH4tgthu6jClYVRmdJ1jr
         BYplJsD9GUyevonTIZKISBkbLYz3wXbfwPniMp9U0Kr0ToEYS0h9kyx4PsU36SyhfOIC
         Zrzw==
X-Forwarded-Encrypted: i=1; AJvYcCX0+xPKLUUkTCr5CgwQeV0/C4vkb2y66nA4buy3TlQV25t+12FOEZNIEuptigLafJ125df/D81BLEeaczXhX5rZeHT31DkSNYw=
X-Gm-Message-State: AOJu0YwQaGubu9ZbKX6pA3PejbIDlWX1tFZF6PQINiul0UkQnu9uaPJa
	D9hYFTa87trDGBT8Y9gdIadbyA5TAzH6AXxDdtgQuK1pEF3vsgkFy2lfeqmMw58=
X-Google-Smtp-Source: AGHT+IGaeKhVHOqbW9aadAG0MXQb/uFbWeIPaa2CekoIThD5I6huDQAkltmyjKbIoa9Tfw7bxF5UQg==
X-Received: by 2002:a17:906:adcb:b0:a62:8ee2:16c1 with SMTP id a640c23a62f3a-a628ee217f7mr385665266b.54.1716793246465;
        Mon, 27 May 2024 00:00:46 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c817974sm457554866b.25.2024.05.27.00.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 00:00:45 -0700 (PDT)
Message-ID: <834e18c7-21b6-400e-aa61-a4f591027620@linaro.org>
Date: Mon, 27 May 2024 09:00:43 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] thermal: Add support of multi sensors to
 thermal_core
To: Alexandre Bailon <abailon@baylibre.com>, rafael@kernel.org,
 daniel.lezcano@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240524143150.610949-1-abailon@baylibre.com>
 <20240524143150.610949-3-abailon@baylibre.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240524143150.610949-3-abailon@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/05/2024 16:31, Alexandre Bailon wrote:
> This adds support of multi sensors to thermal.
> Currently, this only support the get_temp operation.
> This returns an average temperature of all the sensors.
> If defined, a coefficient is applied to the value read from the sensor
> before computing the average.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>  drivers/thermal/Makefile        |   1 +
>  drivers/thermal/thermal_core.h  |  15 ++
>  drivers/thermal/thermal_multi.c | 332 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/thermal.h    |   5 +
>  4 files changed, 353 insertions(+)
>  create mode 100644 drivers/thermal/thermal_multi.c

This does not really build...


../drivers/thermal/thermal_multi.c:249:38: error: initialization of ‘struct thermal_trip *’ from incompatible pointer type ‘struct thermal_trip_desc *’ [-Werror=incompatible-pointer-types]

Best regards,
Krzysztof


