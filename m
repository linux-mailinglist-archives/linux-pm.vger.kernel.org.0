Return-Path: <linux-pm+bounces-475-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 372F07FD791
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 14:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C1981C20B1D
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 13:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544591E51E;
	Wed, 29 Nov 2023 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jvlFeAZe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B7385
	for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 05:11:24 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c9bd3557cfso10420871fa.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 05:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701263483; x=1701868283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aWMf/klpzywMLzA0r9l0xYbzFZeq3FK18LVIlLuRJbg=;
        b=jvlFeAZetzKCkTXAvbY4n8Vj5w3ErB44NvRr5di0IzytgCiIJLSlNHWpTLHj2oJIcU
         isxS+ATxC3PG61uwSwtEp5BS01GVwFoGDDO/LbW3DUiOk97uKiGHo5ju+B1OBXR7A4qd
         3oh3BMZifxmebFSHYhd2xi5KX7/zrXWB4NsHBjX+U/MMfgUiDjYcE9+Cun68E6xg+ck4
         zSECJrhSPVCoWw4IJTyUJDpp2LZnCKx8vrBPv2MLublIGyAHBYToufJN2sq1CkrYi2PQ
         IU7W2HOl1fxfAuBUufIyJyUEJaluz0R6lY6NV+UzFPljeVPMZFKhHWeE8Ja9KP3eQQnF
         ehtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701263483; x=1701868283;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aWMf/klpzywMLzA0r9l0xYbzFZeq3FK18LVIlLuRJbg=;
        b=GgT1S2vzdo4swLSOP1Dd+bSpWbJaplLZgy8GMLH5/+pOiJiyg2Q2YVE/z8TM05m1OB
         s7GBqYIeOv0kVmHI6U6mfI7luRPg1QoN6YbiQmPeiwAjKLqVLa0BbLfeKv43r2gEkC3F
         ZpT7X1yLGhZ7HEbfao/onGDBgDo+s2MrW37p8FokJ4tvdcQ+IzYHJu+6ubbMsH1h6Lsi
         tuJb7G6Af+ug6dYV6KB4NlqSODtW758TFBlfh4uODn6fYoiuyXzGPQutzXMylz45zYLP
         H+54Ziz8ljKgXUGQugfCeUakPszW1ZuLPCr1dv/us1w7qK5TZssOR0FkqxpCZCXJwMDS
         OlZg==
X-Gm-Message-State: AOJu0YyFZQnGCjq7xqh1GiQjI3jvH63wzvRW1uIJu008lf2tuckRzDYJ
	MbwvPGpiIaiPuvWCbWqRGFwxtg==
X-Google-Smtp-Source: AGHT+IHpvrnrEzzRn83d4IZPTHmaxwag88GIMbhkKF73ZmvwoY4hLd/VWHGxuvvDqQZdVuP/yVKQhw==
X-Received: by 2002:a2e:8804:0:b0:2c9:b84a:1485 with SMTP id x4-20020a2e8804000000b002c9b84a1485mr2743559ljh.7.1701263482976;
        Wed, 29 Nov 2023 05:11:22 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:38f1:13b7:9b7a:2d6b? ([2a05:6e02:1041:c10:38f1:13b7:9b7a:2d6b])
        by smtp.googlemail.com with ESMTPSA id i3-20020a05600c354300b0040b4b2a15ebsm2142988wmq.28.2023.11.29.05.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 05:11:22 -0800 (PST)
Message-ID: <3c92f044-d69f-4593-8aee-6d9b318b90e9@linaro.org>
Date: Wed, 29 Nov 2023 14:11:21 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: thermal: qcom-tsens: document the SM8650
 Temperature Sensor
Content-Language: en-US
To: Neil Armstrong <neil.armstrong@linaro.org>, Andy Gross
 <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Amit Kucheria <amitk@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20231128-topic-sm8650-upstream-bindings-tsens-v3-1-54179e6646d3@linaro.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20231128-topic-sm8650-upstream-bindings-tsens-v3-1-54179e6646d3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/11/2023 09:44, Neil Armstrong wrote:
> Document the Temperature Sensor (TSENS) on the SM8650 Platform.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


