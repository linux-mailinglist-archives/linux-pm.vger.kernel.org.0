Return-Path: <linux-pm+bounces-23477-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8388A4FAF6
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 11:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B023AED34
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 10:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F9B20551D;
	Wed,  5 Mar 2025 10:00:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F85F202F80;
	Wed,  5 Mar 2025 10:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168831; cv=none; b=YXUhyR1Jbymae2yQcaY6gIxGOHWkctjiEibR2j/yoW/o/dg3pQw6frcQUHeWrRHrteZWmJ80XI9Ptweq3o2gVqvngI9QrOIu5hSsmDseHhZBD808U+5EoG55xK/eR9mfRlAJhcC5SwWV1mh9tgun9eVU+HaaM4DxNHGDQ6x7ewI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168831; c=relaxed/simple;
	bh=4Nj9kYc2Cn8AMP7q2Zs3ZHTkTUsPP4vXUI+rkihS9GI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VAGR05nhndYJQaq1Ui+PTAlThCSEs6jLF2BE2q2f/gbkdufpzZffGr/BoreYx0ie+lDFJ0Y6Gcikd3ywpGIwmNyRnkBWXif9xeHYiKs2D973LvMn/R89abX8FqALRVm8IlaUr7aAcNqCmssfaq0R0sGwnTqqgvA38uSRn/OPfWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D16BCFEC;
	Wed,  5 Mar 2025 02:00:42 -0800 (PST)
Received: from [10.57.64.200] (unknown [10.57.64.200])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C7083F673;
	Wed,  5 Mar 2025 02:00:27 -0800 (PST)
Message-ID: <08f305fa-0dbe-4ed9-bec5-cf8b5bbecfdb@arm.com>
Date: Wed, 5 Mar 2025 10:00:25 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: thermal: generic-adc: Add optional
 io-channel-cells property
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 Laxman Dewangan <ldewangan@nvidia.com>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
References: <20250303122151.91557-1-clamor95@gmail.com>
 <20250303122151.91557-2-clamor95@gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20250303122151.91557-2-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/3/25 12:21, Svyatoslav Ryhel wrote:
> This implements a mechanism to derive temperature values from an existing ADC IIO
> channel, effectively creating a temperature IIO channel. This approach avoids adding
> a new sensor and its associated conversion table, while providing IIO-based temperature
> data for devices that may not utilize hwmon.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>   .../devicetree/bindings/thermal/generic-adc-thermal.yaml      | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml b/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
> index 12e6418dc24d..4bc2cff0593c 100644
> --- a/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
> @@ -30,6 +30,9 @@ properties:
>     io-channel-names:
>       const: sensor-channel
>   
> +  '#io-channel-cells':
> +    const: 1
> +
>     temperature-lookup-table:
>       description: |
>         Lookup table to map the relation between ADC value and temperature.
> @@ -60,6 +63,7 @@ examples:
>           #thermal-sensor-cells = <0>;
>           io-channels = <&ads1015 1>;
>           io-channel-names = "sensor-channel";
> +        #io-channel-cells = <1>;
>           temperature-lookup-table = <
>                 (-40000) 2578
>                 (-39000) 2577

Do we really need this change in the DT?
Won't the code in the thermal driver that registers a new iio device
would just be enough?

I agree with Rob that it looks odd.

