Return-Path: <linux-pm+bounces-37721-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3E1C46681
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 12:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19C653A5580
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 11:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA21030C609;
	Mon, 10 Nov 2025 11:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yZ8sbvzu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C9A30C37A
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 11:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775815; cv=none; b=hbsJJ6k1jvzRMbws+QWcvHKudN/Swfv9k9pQvVMfwjqaX/+ICN2+fHSh3CiTkFR7+z/uEHRXEGiA+uVj9EluePcE4M0TkfdXg8hmhHXYMTAdyIT/XWxe185qXwXFQgKqK0VAyReVwuOwfXa/iu3G/RJEVyRLMqMjhKqADeP/27k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775815; c=relaxed/simple;
	bh=oUgierYSU3dRBhCJGCsjS3J9M3HkXvV59r1SNiAzvk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJpx6PfaQfxoymiuI8idmki+H17Hi0pjrWNrRT2cYAjWxSILUonm6amJzrFJ7vGJo4PWSrHOZImaTZI6S1lLfeeuuRJTu5dB6KlNiG0Ctua4Ox18Busqs6JkC7bVuyjIIYNRGPNyoLBRa559OGKVA9T9ZcxVw5D8yGJB6rA1wNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yZ8sbvzu; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b3720e58eso1045360f8f.3
        for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 03:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762775812; x=1763380612; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4g2z/CUdSCaQjy9LxpwOngAggO4WOQO9SBX2pApcNyk=;
        b=yZ8sbvzuAGCw2mrF/znpax5qC41Ec7OITzSh/dmx2az4dedT5WWB6bpqwtSq1I4Nlr
         oIpLrJxktDxHg06jbPw7jL2jKcc+0jSEAQd3c+S4v1KeOvQi/QSH90zJ/r6OyfXi506r
         hmTKfE/X0/sdzVMa9BE+0dwJJQdEftjpNt6jt1tHT6/j6tfYT6HVn/algXMNXZKO3VB+
         dRSM/3B6u/fUySKFFntvkD2WpNch/ElHnxg6XbZjgr8WjqdfdMpnrFgmL2piHu4dwSty
         M8OWYVWlLYbBk3RJ3adi7uPuosp/yzM+ERCRJasi1lgQxCnJnXtKfsoEfV5hkEUCGeMw
         hsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762775812; x=1763380612;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4g2z/CUdSCaQjy9LxpwOngAggO4WOQO9SBX2pApcNyk=;
        b=gvy5xDNRdAajTSbZoSr/ztNMEi2jLS2yDxBTqJXaAhTz4PMPXydv4wcrWoUclJC5J5
         SYZVDhV5WJ7+sbcaSVmHzlUkiLqtda/uIBkKoj0k9AweEwaTMiNYaitLy1LBSsNE8Hqj
         VGiQRPWZDW8DaCYKKSL7UBVERvqgAgV3XjnsPZBEyobu35TpswDS7J0K9+ZXcqD6oRwM
         /BVVDPb2UehuSLkGist0yMuOUf5js0e6HNTzAvImfVy9gCFreKzKWasuwIF4bIvKdFJD
         q0YDSwxzC1lyz6ieEozTb1HgMmrnWzOYJhvxhwgOmnWtL3KPtPFO6c4jXYToOzUF0Q7i
         INKw==
X-Gm-Message-State: AOJu0YyvWqF85dUypy7SR4Ev7yBrN51gmh8UdqYYeMhL7SlB7wGtCZI6
	SEGVjJ7C/l1yAvu9np4QsvwWI5SJxNw3gSDTL4pA5MjgV4WhyJjh5hTgyspG94GribY=
X-Gm-Gg: ASbGncvvdidBAhd8kDrFpm3gEen9QbcqvdXSJMUv3N8jHPFRbJVZc9Fdwp3IQ0Bk0Lh
	7AnVLkPrBB9piviaHTeaxPI1aUD9bn2TSvJ8+aBXM+g5Wm1i3zoeB+MmebCcCwYNG254lNoNOX2
	K8l+DzLPwOOj8zJapltUOc1IHmWbQg3/zs0I7ExGXbE0ltv8tgSmDeSVCX4wtspu21S5i1WpFrN
	gTkSdtrwuHJCm26wFEV7MS/+xPPA8JvLWokPKrg8aSPZTqec+oiuc9JvWRexxUbxvBHwGfeNO+M
	vufD7KTML1fBdGNp2zT89jqhj+66TwbXZ4Mxmefyn9U2yVNcsjix4thADtC3/ee00RzIB446HEF
	ZrNqUyiKWYl0tyNA7xedXfdcloUZ2EaXSrRQhQbPjjJyXxmxTBs98xAg9gTpMMWjwsjehTx/Z3c
	3rB7eD1FTbt6TDfPimeE15V1fduh9nLz+friANuKGZOEzEpqaxq7jw8p0=
X-Google-Smtp-Source: AGHT+IFbcw4K9ivqGLQddDZa5CrYY9iwv64S3IIlLZWbi+XRwqAEU+75TumzHzlJ4CnXK9gTK1CTaA==
X-Received: by 2002:a5d:5f42:0:b0:429:bca4:6b44 with SMTP id ffacd0b85a97d-42b2dc1f4e9mr6741662f8f.13.1762775812360;
        Mon, 10 Nov 2025 03:56:52 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:2b20:d700:6e9c:533c? ([2a05:6e02:1041:c10:2b20:d700:6e9c:533c])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42ac679c5dcsm24735244f8f.44.2025.11.10.03.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 03:56:51 -0800 (PST)
Message-ID: <d36f89d7-2d18-4c24-840c-243d4fa10de0@linaro.org>
Date: Mon, 10 Nov 2025 12:56:50 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dt-bindings: thermal: r9a09g047-tsu: Document
 RZ/V2H TSU
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
 john.madieu.xa@bp.renesas.com, rafael@kernel.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
 mturquette@baylibre.com, sboyd@kernel.org
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20251020143107.13974-1-ovidiu.panait.rb@renesas.com>
 <20251020143107.13974-3-ovidiu.panait.rb@renesas.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20251020143107.13974-3-ovidiu.panait.rb@renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/20/25 16:31, Ovidiu Panait wrote:
> The Renesas RZ/V2H SoC includes a Thermal Sensor Unit (TSU) block designed
> to measure the junction temperature. The device provides real-time
> temperature measurements for thermal management, utilizing two dedicated
> channels for temperature sensing.
> 
> The Renesas RZ/V2H SoC is using the same TSU IP found on the RZ/G3E SoC,
> the only difference being that it has two channels instead of one.
> 
> Add new compatible string "renesas,r9a09g057-tsu" for RZ/V2H and use
> "renesas,r9a09g047-tsu" as a fallback compatible to indicate hardware
> compatibility with the RZ/G3E implementation.
> 
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied patch 2/3

Thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

