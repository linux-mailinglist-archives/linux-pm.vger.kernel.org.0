Return-Path: <linux-pm+bounces-8874-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FEA9022AF
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 15:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5481B2143D
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 13:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E566824A3;
	Mon, 10 Jun 2024 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sIKqTxhp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94C48249B
	for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2024 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718026109; cv=none; b=Umdan8o47cYhtuuu2dDu/TGxrtThOIlX9jsV8juIWpHE0DJ1PY93J3dGf9wYvKGK7vkn7WwfJo1Y4tVfG/2TZU3kDKNGwo0IXzQGSokrqCnF8tmJTg/fQeC6vINrfxZtYbu25Z3HWmJBGOsJETiDpavQSo5QtSQc+i6/c9YhvHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718026109; c=relaxed/simple;
	bh=HLJkyNwu/QwsVCrk06z5wtkB8+x802VnQ68ITsvyxbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rutAesm+ceE3QDv/kLLr2yziqzZric8IxmkrJwrY0+JCq5LlTNRTu7H7GMiB6WxO22uOrcyrVePrnCaZKx5yhGV8rMvItUBzSTcHhwO/jYKWjERYPu7qewGiCyU5irF7YiHP8mD9E4FM3RqgsZOKL87K4cYQDX3dwdJcO4tZAi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sIKqTxhp; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4217dbeb4caso12999265e9.1
        for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2024 06:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718026106; x=1718630906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CqQwdYUmJ+EJJuVtBmHAWhAxWewlVzUYX5sXZikJKvg=;
        b=sIKqTxhp5/llAOnM3hgI7PTx+cVxuoD2EuBawytZBNqd0X4MOqUB8LwH9ZciWtJqvE
         1wiAiXy7OMqllctQxGoJFyVV0jmgqT+J94K/VhmCTfJQ6ZWoNgWm8vhyy5Kufwe8s5rv
         ATVL0boMfa5ZO17zHYKQeqPIpEe8Jw1N/1duO9RUDP0FXSvKwfloWXShwYcIuC9g8nJO
         G2ssf3eovmhf6bVUDy3z0Xrl0Yz97fT0GLQ80ZiFRUAt+yLgDEfj14M0vQcx5l5C64aH
         yb3sQA1Osrk/TvoEYlpJ6CT41uCmSrlj0Z02T6+vCHEK4wtLbmxd6REwd3u9DGOq33j2
         8khg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718026106; x=1718630906;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CqQwdYUmJ+EJJuVtBmHAWhAxWewlVzUYX5sXZikJKvg=;
        b=DjVBzNmGn2iQCelJmVe0f5Tni5ThvJlaXN8c9Rfi4jakwrUISlB868xRiFV2Agax07
         ijM3jh86IwBfuCJHnGPmmdX1fOdnCoq1D7c+Um/8AhhN3Z1kQr21ragSOJwYvFtp/qnM
         RowVXNczH2HlpwStcq3TlNHbBahzWT+ivCkrKe9ZmTGfyfsgpF3aGR4aoL/ZiEzxRSA0
         K6sDcLp0yQO6j3mBIPOq3v5QB/AVKwkyW3zoVv5g3Eed9zMYInlopHLh/cf0vlVtl+nK
         7CXAvnUUqk9hRUZmkqHIbRYzJyf5yIlTIFUriGcNxBgh/Q8/PK9sC/ip2bW/4Q8/3z/+
         g/4w==
X-Forwarded-Encrypted: i=1; AJvYcCWXMaHEQZpirD//0bYBIMC+GLziCZU81sFas+EQNqx6w7A+LmNXEcmsfRLFUkCsaedt0PAwUgeeAha4dCHr8Wt/Gi5zWmHdoPE=
X-Gm-Message-State: AOJu0Yzm5Bj2so5OTX8+Iibcl+2Z3uRg44Y8f4vnJBoHUOBR9IwE/C2h
	0/6Epv6t+eTa6WoP0Pw54rKk2rpP+8jAVA2TEvEH9Z76hEBfrhjY70ZjD/J7MNw=
X-Google-Smtp-Source: AGHT+IEnhvOfdr49j7137meK3u/T2y8/6AqdX8GHZrGcL+x9DelsrqcZSEfnRUVxn5jqYqXbl6s+ZQ==
X-Received: by 2002:a05:600c:8508:b0:421:9cb0:77cb with SMTP id 5b1f17b1804b1-4219cb07b17mr26045785e9.40.1718026106031;
        Mon, 10 Jun 2024 06:28:26 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:bb3:9a3a:605f:c4c3? ([2a05:6e02:1041:c10:bb3:9a3a:605f:c4c3])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-421ff76799esm20217165e9.32.2024.06.10.06.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 06:28:24 -0700 (PDT)
Message-ID: <a1f159ed-9ef9-4d0c-b36e-0df3bb0a0eac@linaro.org>
Date: Mon, 10 Jun 2024 15:28:24 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] thermal: trip: Use common set of trip type names
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <5794974.DvuYhMxLoT@kreacher> <3821032.kQq0lBPeGt@kreacher>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3821032.kQq0lBPeGt@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/05/2024 17:00, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Use the same set of trip type names in sysfs and in the thermal debug
> code output.
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


