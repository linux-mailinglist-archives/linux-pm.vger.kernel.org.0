Return-Path: <linux-pm+bounces-21791-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15797A30674
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 09:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EC92165EC1
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 08:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AE61F0E3C;
	Tue, 11 Feb 2025 08:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BAn9ulat"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B091EF0B6
	for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739264038; cv=none; b=jrb8jSuP1OLpTJXWHMTg1vDpQvnI7F7/OmuGBeTmAYw3+E5+XMn6e0P9eJ58ZUuJaPgVnjgayL5zKMTO5yUH2H6EfrVoirPU3jdA+RVBy1nHco9ltWhX00UMfeYDncIWdzglP0wPPSy3Fp71WswmqMF+JAGyM4BIEB+1T5/pwQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739264038; c=relaxed/simple;
	bh=E97S9Di08n2Zwttga37TWY/Ab91xIrEIh6c+b1GeuY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WqUSoAOwXrecY1f/GuEW8vfYY+6osLFRN4hs0Fy3gHg86o2lQIjyR5zJQOVMW3zZAjkN2gRBwpU0fgYVnklH9QMQMGlUU6JevO0bqM3SI2tg/l6qz9lVq0Io6N/PClAvaNn9aUEQPKQDSRYGI+ld5KbkK7aCylqAnB0+36GQ3Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BAn9ulat; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38dd14c9a66so1307525f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 00:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739264034; x=1739868834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wn7f5KmIzBSGwAjAxMKL/5WhoZoIiEa6FOztIQtXGwY=;
        b=BAn9ulatUqXcxf5V04lalC1ewJcwtpz8hrCdhp0XwtMRy48Lnt1yVKJpPnLg5HIsCr
         M9nj9vwXzE3f5Rr7I21LV8hPH4KiKqLndmPQqQsIHWptP9IcYnTfmSdjPdy2BPfNwJlx
         VfamofOv+2+xzF0ymRcfamI4XqWCeKhI7NWvVEUftFHDnHD3Ru9Kd8T7aJ/qcFYaweRM
         gTfS1gRP3wfXiBueqFZPC5ilWkL/EqgiyAbYyDzMeSJh7ShN4AO+dyFHyjiZQqI6MQoD
         idR5B7mkS3SJ21QqCJfhBuVunNd+vlkMWcba6MR9qXboHZjblIHqlIp54nByrqMll0ag
         kOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739264034; x=1739868834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wn7f5KmIzBSGwAjAxMKL/5WhoZoIiEa6FOztIQtXGwY=;
        b=dhgSC5orQ6LdG/10SGOBET18TnHmHXUc8IyXnNYiI38W+iv66b4aCSuW4AB92tSBAd
         5tkC5fF9xSOYW/fLakjVZhT5h39F3ThilXXy9gkomhYJqdgmYezctsfHZs6WQAn6+Xti
         d6TGc+JWehwILux9Igy2cF1zlvz0il/FCgsC43cRRaGKFuUOzaoBRSc58Vrc4Iuba+fH
         wjDZ2TeAJ0VFKSReEqNs7IKp0Uxbo64D7S6K7Kk+XNYEI3XfJ1h21xHm/fB1q4BhVehl
         mR9HgllI4OFMtjZkncMHmXriv/b6gewGFLLgKrqPukNqAqlyseq5RlTNves+fnaUXM82
         xc7w==
X-Forwarded-Encrypted: i=1; AJvYcCWSQA/r4lbE+0d5PLr6vAI7Rc9+9buge8Hx4koM3AhngkNwb6hffS7Ye9BVviWVcwDOhpG+WQzi8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnN4xyWea9AcpE8t4jKpLLqv7aetksSZkHpi4VYn8Xzj5qqbux
	7qOC0be/CB186VRgHta86RUkASW186BoctnfwyE5qMTCjbB8SVNn3NB8/ooZVgQ=
X-Gm-Gg: ASbGnct79GgTdDT76VlrPU3kpm4/SJDd7pRipTFekGxThdSKo+0x97X7s1vfNycJnKy
	fZh+25MdckAMJ2kxMxWpjwO935n5S5BcDaSSdZ85gSq/k45NeWKmevxWM8GHW5ErGTiqdxqtFwG
	sZJ20KSzEnCvS5zhEkGfO0amzVKAVyM884+iA54bfuf2npSu8RAjA0EzmfIi47rwLpIBdKqDB21
	A3ttC+MBx8lSMCgyzlc7BqHp7ANImDedsneKyQ+Kifr32kuceklox5iYiQRoRlAqVbwRE5Gu2ad
	YKYt5HXn9u7z3UGkvdl0ERmrIYhtwyGrsXp8eJY3S1ecl2aiONmKJfQ=
X-Google-Smtp-Source: AGHT+IHJl8az0biIroaElZQMVe7CvDinXzmDIW3C9slxWarkLuaunRbzDNQ1/xMc93YOJwVs4z36yw==
X-Received: by 2002:a05:6000:400f:b0:385:fc70:7f6 with SMTP id ffacd0b85a97d-38dc8d985c8mr12045557f8f.7.1739264033847;
        Tue, 11 Feb 2025 00:53:53 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38dcb4410e6sm11284454f8f.8.2025.02.11.00.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 00:53:53 -0800 (PST)
Message-ID: <843953fe-4c81-4176-845b-0ce9ecb0f84e@linaro.org>
Date: Tue, 11 Feb 2025 09:53:52 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Thermal support for BCM74110
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 linux-kernel@vger.kernel.org
Cc: Markus Mayer <mmayer@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 "open list:BROADCOM STB AVS TMON DRIVER" <linux-pm@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
References: <20250116193842.758788-1-florian.fainelli@broadcom.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250116193842.758788-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/01/2025 20:38, Florian Fainelli wrote:
> This small patch series updates the existing brcmstb_thermal driver to
> support the BCM74110 chip which uses a different process node requiring
> an update to the thermal equation.
> 
> Florian Fainelli (2):
>    dt-bindings: thermal: Update for BCM74110
>    thermal: brcmstb_thermal: Add support for BCM74110
> 
>   .../devicetree/bindings/thermal/brcm,avs-tmon.yaml    |  1 +
>   drivers/thermal/broadcom/brcmstb_thermal.c            | 11 +++++++++--
>   2 files changed, 10 insertions(+), 2 deletions(-)
> 

Applied, thanks

   -- D.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

