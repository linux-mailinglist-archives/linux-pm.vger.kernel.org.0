Return-Path: <linux-pm+bounces-5929-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5235389873A
	for <lists+linux-pm@lfdr.de>; Thu,  4 Apr 2024 14:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC632987D8
	for <lists+linux-pm@lfdr.de>; Thu,  4 Apr 2024 12:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD6A8625F;
	Thu,  4 Apr 2024 12:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LaCA1bVv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE2B85269
	for <linux-pm@vger.kernel.org>; Thu,  4 Apr 2024 12:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233406; cv=none; b=ReUO+j8qQ0mV7KhoM1w2VKGd1HZJKkM/mUIVqV9gnX1jQ5bLb0ekGFTmysrAoBeEFGapcjnxpybE5IYufhwxm1XfqzM+cz/uRIUHFCIHdJ5sbJhXiZ9adZk86oXIaQJ8axpmNyZxs7XuSOzxe0WvTO0VitEGtQgtzkvpU2ovchU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233406; c=relaxed/simple;
	bh=9/E8tsU4oMIEanhdzLFEgNr653QwdLUvMZz3bWO4ajQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rCejUXDKGxsFj6E3VhIM5D4YXMTBmlpr1sfKDdV3sYMK1BHaHVX+mmIAzqHVplRZgDw6g584H5ubhsbp6Y28EWNPXnTH+2Mv0Ml4fbADEZJsHLquD2tCh4ENgXOZu88Mx49WskCCx1yTaCFB50pp94DOqfjW3k0S4T1jZW4NIGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LaCA1bVv; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so8979611fa.3
        for <linux-pm@vger.kernel.org>; Thu, 04 Apr 2024 05:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712233403; x=1712838203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eYE+eshATYqsMOTO3OJcrLKHBczJOSqmODQnoMCtRas=;
        b=LaCA1bVvGvgf6NkTVNhlXbfxaYalXL6fTZ7Wm5NwyTq+scdwKiRu1KQOkqtgmdneOr
         iRC8Pw7CO0s+iBEgos+lx4m0MepWLFoEAWSv3g6MvSAP+RD0vfsc/6k7fJSbL9QFu/+0
         Z3UVDWgbEW7pzG0kPCYnixObSljA9647T0++41HHrJfpFKoljd/LyIeWrU+mXUtKNdPS
         vNFYu7kSSnVwj76Dc5TZMMM8iaQaUvG1WnfkK6Sd4bXRgUL2rhDIcLKOY7OIWoz/B9Vf
         rTc6pvrmcNzDckCvzqAvhJWeVdk6VKy6UpONO/8N1zInD0amivSsokpVEkstFw3Yia7F
         xY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712233403; x=1712838203;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eYE+eshATYqsMOTO3OJcrLKHBczJOSqmODQnoMCtRas=;
        b=kpXAvauzagphEJn8nFiqNA2pNBssI2RgTGHaaEDG+W2osrYxt16G4w1oGs7wPlAzz4
         mwfJe6YvT9lYKiGsgkxxrcLtKzt4ZeRWbWFf6+2S3uUxtYuY8yenEgosyb3yO5Xg69lE
         xzBYC3A75rshoukeI7ErCzLWlKvRJ4xJRIXdyNKAshIl3kAks+a9rjg4vGUf7yQ+qnE1
         VH4ETdCl2Va02E+0JnlfmCsFH0Wk8845wWUSAG9sKGYAzIOS4PilsBMBpxfNXl/BhyfG
         5tEiFVG835VbxKUctBYqB/dBkJSonaTonmt8o5x0oT4tyKGh2HcQBOhmPDGTVtA2+I2F
         pW0g==
X-Forwarded-Encrypted: i=1; AJvYcCUbPLkqd+9sx6uHg2xfD2ul/XCWtk5bamgAbuD43EtU/5+wKJuDpvX/rRnhgooiAeCsTrup702gmFx6EzKvgKKLWumYr0YoLHc=
X-Gm-Message-State: AOJu0YzD83Ts8CAQXu5MPfk3p7GRP4abdNnklHNYXzQeRCOIu8EHAvsm
	u9bQNfI6u2QczeLxF6svRlOaHgcgyXZrOJhpibOOlCmtK014tN1NGqGtrbhz+go=
X-Google-Smtp-Source: AGHT+IHAr8zPO653SUr6XFqHyuFMhuWhZMQKuK8meJtxtbXfUpmzEPy7h6Ezmtdi77EyE7t19gkTfw==
X-Received: by 2002:a2e:a371:0:b0:2d8:4c9f:ed94 with SMTP id i17-20020a2ea371000000b002d84c9fed94mr1906339ljn.34.1712233402988;
        Thu, 04 Apr 2024 05:23:22 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id b17-20020a05600c4e1100b004148090cf86sm4646300wmq.0.2024.04.04.05.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 05:23:22 -0700 (PDT)
Message-ID: <38ba3618-2a67-4e21-b08d-7e382411e51a@linaro.org>
Date: Thu, 4 Apr 2024 14:23:21 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] thermal: amlogic: introduce A1 SoC family Thermal
 Sensor controller
Content-Language: en-US
To: Dmitry Rokosov <ddrokosov@salutedevices.com>, neil.armstrong@linaro.org,
 jbrunet@baylibre.com, mturquette@baylibre.com, khilman@baylibre.com,
 martin.blumenstingl@googlemail.com, glaroque@baylibre.com,
 rafael@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: kernel@salutedevices.com, rockosov@gmail.com,
 linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240328191322.17551-1-ddrokosov@salutedevices.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240328191322.17551-1-ddrokosov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/03/2024 20:13, Dmitry Rokosov wrote:
> It is primarily based on the G12A thermal controller, with only a slight
> variation in the offset value of the efuse parameters. Therefore, this
> patch series provides appropriate platform data and dt-bindings to
> ensure proper support.


Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


