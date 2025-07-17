Return-Path: <linux-pm+bounces-30984-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F69B087CA
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 10:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5242A3BC5B4
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 08:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7017E279DDC;
	Thu, 17 Jul 2025 08:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fMBo4lRl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896CE267F58
	for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 08:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752740442; cv=none; b=ox/4MJWU5CjMl8AxwGCDn4B7Q8r+61nX8Ve9rsmKp6ckCSjkShpoUW3dmM/GhbFysNcxlXM6yhcvznU5SLVq5txNoI3qSfJpKC9HODPpGZoQk9UCOfktJH0VE62HrdUmB6F59k4lNyGCPmiMVqZJRi/ESxuZIOsvFzaiUREJEAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752740442; c=relaxed/simple;
	bh=xtE1BEijImzQ1+EyvVeZicpa6Rbr5rJKyFTiSZFDxbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHvyF4VCxETI5AbERCbHL40oVmR8yI/IHeDxMtWsD74eZxQKed49ZHeSZh1by97FRX7EJtLaZgKsJN3k8OyQx0dYfu5zMIH6AwaLrTA6HG9NYuBhFvDMyHvABISQDZIftGzB0e12UekMgiITnOyG5ic/B+mHJmlG9lEXoQf86lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fMBo4lRl; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a57ae5cb17so340001f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 01:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752740439; x=1753345239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aSn1ikrBu2w6g+uJ3D3dKbejXUUZcJbs+RYM3hSQgKE=;
        b=fMBo4lRlik3YTDpGC0ZNZi1dUcV6KuzHYcUaP5Y7MX/h9BBidYEmwgbfMGliMxAb1Q
         CwCDDSjAfK4u00O1p7z85GlixLlycO9IzqWSssRhImoXTODsRd/8LQbjR+wqVe1EqFZi
         ysUETCMLQ6wXfaUG61bIMDXlnhx2cpKKKdcptpsBIJL7273bKhlO4EL2kWUyO7GBfaNq
         6ljFM3RU9UyyEniuO5iBBQJrDHnCHn76keNvcIqRQNzqDgjfTtJZ6NrTEu36DOUiKfwb
         Yv4wHRcosjZUUv4khCj89FbCXu0fP9ws2oYPdHjAmDYhgjk6iu5/RnZEHVeQgOEasreE
         LWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752740439; x=1753345239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aSn1ikrBu2w6g+uJ3D3dKbejXUUZcJbs+RYM3hSQgKE=;
        b=NNxBII+9QCa73oK1BOHrcrkeKRKEnWFnWmxwGoPfNmciwZ5jnkMB5mh6lwgxyIx4cV
         gmf6t53xRk4afdJD9zV3pGNFeVmJN1nAfMyykbQAJ+EBJsr1u3jR3KXxlwzdA2YXd/75
         uCoxLz5tWXJf6P1zQD68Gx1l/uqAzaHahLQZOV8UGt1DpbGVJ3ec2h27dCKvEY0shIlp
         uiLejNnGE6UqMIfnta1/fIeEQqLv8uDuzhO7DFznjrMXJkkUHmvkIJJmZ8bnCcWIXdsL
         h8QTP/rWD87njZcvB82eXq4b3JaUZztuH0RC39GH/QU3xxYufIm2A1GUVu0rB3CDe7/0
         NSHA==
X-Forwarded-Encrypted: i=1; AJvYcCXK2PkQpsAcW+GAd/jAiZ5PfY8H+lvwiztUVXBcl6CDcGRZ54OdtgTsOqjLYgsTZ6ttLOkH4uzQ3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnGwn+v7UzRFh3z3CXpi8dD+P7v8bQIoQIfgL8t/qAQ7m0A3PQ
	Ctf4CguzndJaLGR9h0RHi+nsWjxgSyaD495XxDov3x9/6Ke997qIARWJV0BxNOERYRU=
X-Gm-Gg: ASbGncvgkUmXaEsUCiawILSlkS9qpYhjE+XFAEN/Gw4rdbG2druZ4TciPi1mKRXAQ3O
	spLCyviI6l8duSMFnCOkFw51685v6JLOCsfzsPXwk9jcgZN+nF1i+RngVmxJuDUVB5pNTj3we1J
	RlKvmZBDTTmeFLpIF5fRAPm9eDBDCzuUOZPB59C81Qttq/3Pep63VZgxiG0lX9KlAwviIRL8UfK
	LU6k+re2qcUm7GaSlI86WAIkHjLtxmEhZ02BXOFT2TAeT/CSTr/cfbSwpZ4xPGWOOkdYJuYTgW4
	jSR2oEsy1HabmIpdE8r5rqpG1x/ZMJUVBw91JsORnC8yMNwfvGexLaTXmDOvYbAZfcJHD/4HhLm
	Ru7CiL9jlVCFPU/U/1kMu2xS4lKMIel7r01ERcBC0tjZaMcMRakamXJmchkCrebLsMoyM2AA57l
	Iw
X-Google-Smtp-Source: AGHT+IFrAHuwDARLY/8Ay2Ov5spI2j+L1Q0PXdz00Ci8rMXPWEOFk1gUDBGwxIvEnn/1FaCq6ZYz8w==
X-Received: by 2002:a5d:6f0e:0:b0:3a6:d92d:9f7c with SMTP id ffacd0b85a97d-3b60e4c5212mr5057459f8f.9.1752740438729;
        Thu, 17 Jul 2025 01:20:38 -0700 (PDT)
Received: from ?IPV6:2a0d:e487:37e:ce58:94c8:a752:de4:96bb? ([2a0d:e487:37e:ce58:94c8:a752:de4:96bb])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b5e8e14e82sm20214519f8f.71.2025.07.17.01.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 01:20:37 -0700 (PDT)
Message-ID: <14c91ee4-3a09-4ec9-966f-0d563d7c8966@linaro.org>
Date: Thu, 17 Jul 2025 10:20:35 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] RK3576 thermal sensor support, including OTP trim
 adjustments
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Alexey Charkov <alchark@gmail.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Ye Zhang <ye.zhang@rock-chips.com>
References: <20250610-rk3576-tsadc-upstream-v6-0-b6e9efbf1015@collabora.com>
 <aHgHxR1_Gzu8Dwbm@mai.linaro.org> <4178173.5fSG56mABF@diego>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4178173.5fSG56mABF@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/17/25 09:21, Heiko Stübner wrote:
> Hi Daniel,
> 
> Am Mittwoch, 16. Juli 2025, 22:12:53 Mitteleuropäische Sommerzeit schrieb Daniel Lezcano:
>> On Tue, Jun 10, 2025 at 02:32:36PM +0200, Nicolas Frattaroli wrote:
>>> This series adds support for the RK3576's thermal sensor.
>>>
>>> The sensor has six channels, providing measurements for the package
>>> temperature, the temperature of the big cores, the temperature of the
>>> little cores, and the GPU, NPU and DDR controller.
>>>
>>> In addition to adding support for the sensor itself, the series also
>>> adds support for reading thermal trim values out of the device tree.
>>> Most of this functionality is not specific to this SoC, but needed to be
>>> implemented to make the sensors a little more accurate in order to
>>> investigate whether the TRM swapped GPU and DDR or downstream swapped
>>> GPU and DDR in terms of channel IDs, as downstream disagrees with what's
>>> in the TRM, and the difference is so small and hard to pin down with
>>> testing that the constant offset between the two sensors was a little
>>> annoying for me to deal with.
>>>
>>> I ended up going with the channel assignment the TRM lists, as I see the
>>> DDR sensor get a larger deviation from baseline temperatures during memory
>>> stress tests (stress-ng --memrate 8 --memrate-flush) than what the TRM
>>> claims is the GPU sensor but downstream claims is the DDR sensor. Input
>>> from Rockchip engineers on whether the TRM is right or wrong welcome.
>>>
>>> The trim functionality is only used by RK3576 at the moment. Code to
>>> handle other SoCs can rely on the shared otp reading and perhaps even
>>> the IP revision specific function, but may need its own IP revision
>>> specific functions added as well. Absent trim functionality in other
>>> SoCs should not interfere with the modified common code paths.
>>>
>>> Patch 1 is a cleanup patch for the rockchip thermal driver, where a
>>> function was confusingly named.
>>>
>>> Patch 2 adds the RK3576 compatible to the bindings.
>>>
>>> Patch 3 adds support for this SoC's thermal chip to the driver. It is a
>>> port of the downstream commit adding support for this.
>>>
>>> Patch 4 adds some documentation for imminent additional functionality to
>>> the binding, namely the trim value stuff.
>>>
>>> Patch 5 adds support for reading these OTP values in the
>>> rockchip_thermal driver, and makes use of them. The code is mostly new
>>> upstream code written by me, using downstream code as reference.
>>
>> Replaced previously applied version V5 with this V6 patches 1-5
> 
> are these commits available somewhere?
> 
> Because git.kernel.org reports that
>    https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> has not seen activity in a while?
> 

I just pushed the bleeding-edge branch


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

