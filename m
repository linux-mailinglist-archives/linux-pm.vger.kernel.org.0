Return-Path: <linux-pm+bounces-7378-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C212E8B7A3D
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2024 16:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F18911C225C6
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2024 14:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9481527B4;
	Tue, 30 Apr 2024 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kMJOHmeD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3164152790
	for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2024 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487833; cv=none; b=aDwx21ZAsPqeUvwCABuEeM0js3JYcLPAyaMuSeAPHV9D+Hi6mUKYAfq/sNW6ZBgSCEVYdynwMAXkFRZT7oz7mH7DOsBp9eLWaTCtkUKDoFPlq/pPCMkrBJFsn1SGmw+8qq+ZMCaUoBXh6ssxLf91hnlUqzEwlUeEGzX+xy9Hw0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487833; c=relaxed/simple;
	bh=f0dkUJvP247eFb6RRMOvrHscG3Fy7Az/Ygm6QZcviZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AzsiSLXgWVkYpIbsYoko1W66fFJbQtQ04uK6+W3oHzlJBGomzAgJi4+rcJa49/EFZCqDf8k/UgmWli9fZU+c11OIDb/+FDDb58Q6NHDXAhvVArBokQLCIH8hMLKfAHJLM6V/3G6oX2mVZUFfPpYbp9sBzyyO3ayhzfv4EpjIOF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kMJOHmeD; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41b4ff362a8so53174705e9.0
        for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2024 07:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714487830; x=1715092630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xG6VaO1pEcNllDR2zlipXpEEsS9LiBKBjRSPWPlSPBg=;
        b=kMJOHmeDnn4UxEdGkpM7qQ0sDUOOP/76olRdW3KZkTpLv1hj1gQavbv3UVmoBaxaAB
         PZ8hIPl/seHs8MU2CNfVffOlpFNW0IlkjnKBlpeHXKf6oT6VLo151TlufclAzCQgi5cD
         9bG+mr0RVCv7Oy9OZg1LuINxToEJ2SMRInNM+NCC+fkP6lcvHAyR59zFuiWAKy9IpR7+
         6HOmZJn5VodAa+ETaYE0ddjEu6q/koWssOIjwOJjDoAtx4GMZIB3CsRtFH/uSI0mYtSR
         8qfAZb0/cQfZTH5DNZtGiE7Vgyq2zk3VIDF1uWwhnTZ6ApbBoMCF13OSrC5dugYUMmbn
         MVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714487830; x=1715092630;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xG6VaO1pEcNllDR2zlipXpEEsS9LiBKBjRSPWPlSPBg=;
        b=xD0+Fwp3HS1FL//hyVF9oKteZynnUXj/+DkukbTKIYjQdxcVVvXK8/4SDeZuIBTUK5
         MoSpCjnN6zq3Kuy5LHzl7P9ul3tnwPl4AOcmu4GY7pSwGNsMUcz+b5a3/CsRB8kGItog
         ddXgtJr4wb2ckaio5l5AIL4ED7OZCNDgBQJ0/cOxLbyKImAjzjjh+2TzbvpOEgwTBfpu
         9f/nqXRQc5jxGgZBv0DwdLS1Ip+uk5RS0OBUDbQPplAJd/dnGqPZSS7EiKLeXN6mgSI7
         FJpWdXd4ZMFJZZq99sOoV3c8r1XWzoc94QfVrzfHP2tcDvOI2DKwjptnZvPvgrHbrrMG
         2Bzg==
X-Forwarded-Encrypted: i=1; AJvYcCWhyPNYwSjcizCNBcRlP3kKhijuR9PMSskfJNZY3m6jkQrZ60aKw9rizw3LJDSgbMDFS6IMDySGy9Tna7ujHfD3sxxithM1LSc=
X-Gm-Message-State: AOJu0YzI1J5Pft01NC7UNAdjXBJ9SEKMgJ547dg2LhxJlDXSW9kIVaK0
	vHseSbv2C0zLem+pR/utoZiDIukDdsB5PIgRuySuMOYW7zBp2WKrZEMBRosXrro=
X-Google-Smtp-Source: AGHT+IFrpD8t3g8jiV/X2L0uuAYZmAQ34PYQNYTcc9EdnsStQhXYkVN4RO5IjcwHTzaqWXkVDVmeVw==
X-Received: by 2002:a05:600c:35c4:b0:418:df4:b24a with SMTP id r4-20020a05600c35c400b004180df4b24amr14803236wmq.37.1714487829980;
        Tue, 30 Apr 2024 07:37:09 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id jt24-20020a05600c569800b0041a68d4fe61sm1334075wmb.0.2024.04.30.07.37.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 07:37:08 -0700 (PDT)
Message-ID: <03fbaefa-de17-47f0-a48d-7b40e5df50f6@linaro.org>
Date: Tue, 30 Apr 2024 16:37:08 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] thermal: Add support of multiple sensors
Content-Language: en-US
To: Alexandre Bailon <abailon@baylibre.com>, rafael@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240119110842.772606-1-abailon@baylibre.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240119110842.772606-1-abailon@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Alexandre,

On 19/01/2024 12:08, Alexandre Bailon wrote:
> Following this comment [1], this updates thermal_of to support multiple
> sensors.
> 
> This has some limitations:
> - A sensor must have its own termal zone, even if it is also registered
>    inside a thermal zone supporting multiple sensors.
> - Only support weighted average

Is it possible to elaborate why this feature is needed ?

The thermal framework is able to aggregate the cooling device requests, 
so having multiple sensors aggregated or the cooling device requests is 
from my point of view the same.

I can imagine one reason to do that is to group the sensors in order to 
use the IPA because it won't work the setup mentioned above.

Is that the goal you want to achieve ?

> Changes in v2:
> - Rebased on 6.7
> - Seperated generic multi sensor and dt specfic code
> - Simplified the code
> - Drop min / max and only do weighted average (seems more adequate for IPA)
> 
> [1]: https://patchwork.kernel.org/comment/24723927/
> 
> Alexandre Bailon (3):
>    dt-bindings: thermal: Restore the thermal-sensors property
>    thermal: Add support of multi sensors to thermal_core
>    thermal: Add support of multi sensors to thermal_of
> 
>   .../bindings/thermal/thermal-zones.yaml       |   5 +-
>   drivers/thermal/Makefile                      |   1 +
>   drivers/thermal/thermal_core.h                |   7 +
>   drivers/thermal/thermal_multi.c               | 178 ++++++++++++++++++
>   drivers/thermal/thermal_of.c                  | 139 ++++++++++++++
>   5 files changed, 327 insertions(+), 3 deletions(-)
>   create mode 100644 drivers/thermal/thermal_multi.c
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


