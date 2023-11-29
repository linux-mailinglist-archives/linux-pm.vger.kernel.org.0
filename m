Return-Path: <linux-pm+bounces-465-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3AB7FD65E
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 13:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 102F9B214EC
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 12:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F09A1DA26;
	Wed, 29 Nov 2023 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gTNSr+Hr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0C2C1
	for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 04:14:22 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-332e40322f0so4166132f8f.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 04:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701260060; x=1701864860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AsQvimBOnTjXGdKhEAnGYzR8KiGWDUYPadmCZZ7TXho=;
        b=gTNSr+HrG/QwEBmtDbp+q7SRM8xQA21O1oKOnkYyaUBRGrY7GEtgbqeasLBtHHTRBz
         +SuoISl4aCzbwy0LTxBRLdO7F8n86VnbZYLQcx5VSoeRK9TfX7/sn5GSCgwksIdYYRfv
         aoi+fHMmv1oFjUARbFl+lKCZ/5REIBR/gj9UvJsoWmKqwNT7+QpPUoJP4AWtCQObxM8x
         wNqZkMSKh7H4jP+7Tp34TneLO6fPtq0MKJb0/4a+J4Kqok2q4Pb9RTjAinigsUAmTmCW
         7zVNdYNtg4hM8IPLAsu45cQvqzrANVcX+ljV63Y5qkn5o4Grd2mpcalWH3gGCbRY9cuU
         yGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701260060; x=1701864860;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AsQvimBOnTjXGdKhEAnGYzR8KiGWDUYPadmCZZ7TXho=;
        b=I14IYeHK1C4fWg425Y7f/Dfg5dljUNufCcFH6dqdIXpsIz1ftsin4xR4V9bKWI4nrn
         qo59/KyWWHVnQyOPMoMsM5/2RJY+gSySjDNNQxNfEIQfATox1RQQzZFzbMhjMn8Q4qhy
         dhf8Uu1VCMCJ+lnsxucKm1AKkPTXcEUj8Y+P4koDj650EG4R3nCN3Fo0Vr85DlGvGSBG
         o1cMjVs+Y545bD7Uz0+BItFdDp8xcAMwAEEJy42Rp8ehde4m/v0G4iLwnlwCYsa9Zqq/
         e1qpT0hG6ifSk/Dn6fqhNaBNLUfH4lFzkBg57DpSWCm8HMvO886dIT+K5KE1arRR3mlO
         jWfg==
X-Gm-Message-State: AOJu0YzI+ov+8HO5JGMN20zenf0aSo8BMhrezFRSp+62T3H+f993z8NQ
	hYCksUf1f+0JgDDF6FmsDLQYfA==
X-Google-Smtp-Source: AGHT+IH4VTkrd6SDnt/sTDh9R9XPApG7O61ItmfuFh5MunMzdqfZlrOGpBMpkKqBpf907RBXyT1V9A==
X-Received: by 2002:adf:eb41:0:b0:333:727:2ff5 with SMTP id u1-20020adfeb41000000b0033307272ff5mr5299207wrn.9.1701260059703;
        Wed, 29 Nov 2023 04:14:19 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:38f1:13b7:9b7a:2d6b? ([2a05:6e02:1041:c10:38f1:13b7:9b7a:2d6b])
        by smtp.googlemail.com with ESMTPSA id f5-20020adffcc5000000b003313a1e0ba1sm14998254wrs.89.2023.11.29.04.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 04:14:19 -0800 (PST)
Message-ID: <673c06e7-61a8-450f-96c9-35bb0e1fe111@linaro.org>
Date: Wed, 29 Nov 2023 13:14:18 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] dt-bindings: thermal: convert Mediatek Thermal to the
 json-schema
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Zhang Rui
 <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20231117052214.24554-1-zajec5@gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20231117052214.24554-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/11/2023 06:22, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This helps validating DTS files. Introduced changes:
> 1. Improved title
> 2. Simplified description (dropped "This describes the device tree...")
> 3. Dropped undocumented "reset-names" from example
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---

Applied, thanks



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


