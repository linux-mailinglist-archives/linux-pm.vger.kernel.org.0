Return-Path: <linux-pm+bounces-8835-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD862901C1D
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 09:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 541C61F2289E
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 07:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BE837143;
	Mon, 10 Jun 2024 07:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yx+LOxBT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018BC1CD15
	for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2024 07:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718005947; cv=none; b=Q/JrheHoCXXtJ2bWGs9hCayCtebDW5NIBKOlDNkFQ4nJG9NxNbNaWEb1XasglVdoHkmiW3giPFv27Z1dDfFQDuNjSY5EGVZT1mBpyExLphg5AuyikZOsxDq1d8PrK+AALKMYqXdK7yS9WWP5+KGGn65onBFuay7yJGoGa2cBG0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718005947; c=relaxed/simple;
	bh=dxVuE/hNWYeZw5tFy8vEhNe3cf4qc8+xAwskp2xLck4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NX3MKWB9/ZruVtetb8ZYHjAijz6xRQqs3nxXNtInXTYEyaPkjgfrP8CxhwLYjWZNXR9+MAuwqSSCyR1cFNtms+7KpP4m7kGdoIocgLpPgsMTwIYG5cMdXPjEcr+KlIldh7TSuaQ/U+aFYngH0ljLp11f5A9LOtOgdRsFw5nQmks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yx+LOxBT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-421792aa955so15384585e9.1
        for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2024 00:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718005943; x=1718610743; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+QH9gS9l5QUcVvDrff4oSQi4P2/FJxvn+9mnHcnpPEw=;
        b=Yx+LOxBTgi10cSWhbmuWbgpV203pjE2PrpiX9I20kvLMmshuNTXLlpzY8RhepGiBhx
         wtee12Z+YOnsowyl5v5anxgIhE2Kan3tamCOJszEFXXMb6MAhb7ocBoI7zr3l7S60MWe
         xisM3IKjj//ldJL8NUS+amR7CAoECaI3Jo4h0t+lLN2GmKEYxgB+/ZrPGJQcHlW/7oEH
         9L549+lrySa5p/ePg3+aJIqXtrsZweyQdVRzhnZ4pfhX3y7H1VGANBeHF5y+4SDqGR29
         B9T+MQg3d735kP6cma/2Bi6UBbWNTja+6H2g+snBUdm4e7wPZW2rgDD/vXuECBiRJtFr
         CmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718005943; x=1718610743;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+QH9gS9l5QUcVvDrff4oSQi4P2/FJxvn+9mnHcnpPEw=;
        b=f5rkuT0TXv7xgqdmmNxcAnXFPfSUgrlzlp/tVQjp1OvNDQHayre+yM/uXR8T0onYdc
         yKX05MDBLbnOnizCfHcFOcPUe+igkPDrZZpNv7ojC9w8evt8D62DeX5cFg7vbw9mD/kg
         0wP0ovXyyFIyoZ0c2/W2Jk5jcKpssUzj8ZetbBn+da4xlcwvSAZuoMdKPt6IYwtbQRnC
         L7aC/MPLupkhqVHKgllCWYSIAbBg3ya9Pos0OEjrfVidLvV0RR6ONFS+tATH9K4D4xS0
         NNnLJYP9dBWFZeYT/trqBgJgSo2P3CrxaxFdRHREfEj0vm1u0Xu8N6K/RnrTJilnmK4Z
         G4Og==
X-Forwarded-Encrypted: i=1; AJvYcCW25rOhFWRsaO3Rqw3wvO7f6dCD1JcOMTxdJZPKENmBCYv9kMah5gI+zqVxULIQpmX5fucDghWSunREB/MMBgog8x8edRcorYo=
X-Gm-Message-State: AOJu0Yxf4KKLol3KzJfkiME+3i259XoM55aBakMAFF99Lu8edtEqLuFA
	78qD0Z8d7A9960HJwTjr6IOkfKvb9NbOg2yG+2ClkwgWlxHfX9bQjemzN+PY4zW1FjbAywsEdzq
	0
X-Google-Smtp-Source: AGHT+IHDqhYByhibZYBWYiQva1hDQY7Bo5JFaXZZJs5YYX7YncASi5qYqc2dF4Qt4sXtxhFybKX4JQ==
X-Received: by 2002:a05:600c:4f84:b0:421:80d2:9db1 with SMTP id 5b1f17b1804b1-42180d2a37emr32655115e9.25.1718005943329;
        Mon, 10 Jun 2024 00:52:23 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:dead:19f0:2aa4:219a? ([2a05:6e02:1041:c10:dead:19f0:2aa4:219a])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4215c19e674sm133763795e9.6.2024.06.10.00.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 00:52:22 -0700 (PDT)
Message-ID: <a19f6e36-fe49-41f8-9ab4-3b2f8c307d6f@linaro.org>
Date: Mon, 10 Jun 2024 09:52:22 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] thermal/debugfs: Use helper to update trip point
 overstepping duration
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <5794974.DvuYhMxLoT@kreacher> <4933647.31r3eYUQgx@kreacher>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4933647.31r3eYUQgx@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/05/2024 16:52, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add a helper for updating trip point overstepping duration to be called
> from thermal_debug_tz_trip_down().
> 
> Subsequently, it will also be used during resume from system-wide
> suspend.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


