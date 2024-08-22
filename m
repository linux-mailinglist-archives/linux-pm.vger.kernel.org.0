Return-Path: <linux-pm+bounces-12749-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02D195BB68
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 18:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7B01C22E18
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 16:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F481CCED3;
	Thu, 22 Aug 2024 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wC/2Iep0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9DB1CCB2D
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343045; cv=none; b=brki2gUgQgC0CNqUVuQAUMDDoHUHGOmY8Im+lPQHMWEV/mbigvvNQejU2rB8h8ap9MjVlAqctb0UNtYKw3NjAT1hu7rwHCHysaQfbWo/AftX5QLMs3uTBuNYXPeVegbgp/SDEbnLE4Z4IrlxkkiK03vcfo813otck+VqvoK4z1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343045; c=relaxed/simple;
	bh=oTVnwnxoi3MwR+fT4MSoMLg39Y4GQfy4UfuGydIln/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fj6dLhQcSloGpRuLlecpmVRtCMDnEwHR/nWeNZYXVVoKbfJghyPhk3Lk+aByHvdZtlitF6iW7sAMUh7Eoo9gsqvIYbpJdPCEAtoAhbKtzXb0KShBy/XYBI6+YXnUZ7oMfszp3IuUOKMb5IXSSn49EtAHU557m/4uwmu11JnVx4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wC/2Iep0; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-429ec9f2155so7633455e9.2
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 09:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724343042; x=1724947842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ghU7bGQfCH6VMs7XeQb7I+ZFRK+m6U/I472i0hWudlY=;
        b=wC/2Iep0M0IEKgTPpYzAOntqPZRcTH8+Crcnc5mpjAoy7eiT1E7gjvhZBTadltxUG2
         UoaICx2j2/wK3ubd0Quv+fJXDdxWDne2xXocjwTWmQZ3GdNvYNqm5SiEbleZtVnSaeAN
         LBS5zkznBnRRMjiwmDC6SiYdxbAuP1hqf6XYjt+3z+nX6f9J8ka2xHP3VjkCUq74liva
         imjIg7ARB3OBSxl0egIeyXIi4pg+u9rPGu1TVuoF61Vj/0SRHiOurZD9Fet1CUxNY6Vp
         nwboLI2MCMsm0TNuFBN6g4tvR+nDtB1nENMmkqSGIl3NZct1DJU5pXrQKr9E+2AhxqZ9
         jxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724343042; x=1724947842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ghU7bGQfCH6VMs7XeQb7I+ZFRK+m6U/I472i0hWudlY=;
        b=uUs4i9fkSa2pwcq7NfQ9bRtLAu4HFOx7IDogPG2GEjHQLpQyK37M4grNvaqyruh0og
         oQLw1I9915+Xd1CqjntEkUHVHINl/Ts+l9tngn1ElWWcoK16233LAIoUz2Is6MytFl5H
         zHyZSI2fl9Pb9quTfPvh+/Z2a8NSHkmO7/Ek7ZF+R5+QzM14H32amCHbOw+KrAYKHnMY
         zGPL+iksZBAvXPXfsP5/RYzqT+zCtANYKjZo1vGNlcCh7lcD42fIrQ1H66g7xNop4YCJ
         krMF3CDyQpGLseo4UjQRkArygIPp3tzxK5L0yvw9ubb0lgbiZWZ6QLdpF9A/P+FL/Dcw
         uBDw==
X-Forwarded-Encrypted: i=1; AJvYcCUSFwhh9u4iBaRhx9+lXg0fyE31tTTcj8Lqe+xJV70uBWv256aeKWc/TSCxKM5858MUfjzaffiY2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwV3j6+EC7BVHhx47IZqxult1iTEu2qDt/BcXSNQS5CmzhMo0ml
	X/URpS2xXdF4vNPHArPx65hB/GIvD6IDqQX5TXZk0rYdhdIxBrcjAwbYWjvIkN0=
X-Google-Smtp-Source: AGHT+IFbeUlcYW7rVjFtPeB/keXD1uOdpULEogsJaEXgMJoh81iXZzt7Lg0xKqgNI513crPHQS93Ng==
X-Received: by 2002:a05:600c:c8d:b0:427:d72a:6c26 with SMTP id 5b1f17b1804b1-42abf048b3dmr42289485e9.6.1724343041166;
        Thu, 22 Aug 2024 09:10:41 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42ac500e119sm29671935e9.0.2024.08.22.09.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 09:10:40 -0700 (PDT)
Message-ID: <133ea087-a5e9-48ca-bb89-33f41220276f@linaro.org>
Date: Thu, 22 Aug 2024 18:10:40 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] thermal: of: Fix OF node leak in
 thermal_of_zone_register()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240814195823.437597-1-krzysztof.kozlowski@linaro.org>
 <20240814195823.437597-2-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240814195823.437597-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/08/2024 21:58, Krzysztof Kozlowski wrote:
> thermal_of_zone_register() calls of_thermal_zone_find() which will
> iterate over OF nodes with for_each_available_child_of_node() to find
> matching thermal zone node.  When it finds such, it exits the loop and
> returns the node.  Prematurely ending for_each_available_child_of_node()
> loops requires dropping OF node reference, thus success of
> of_thermal_zone_find() means that caller must drop the reference.
> 
> Fixes: 3fd6d6e2b4e8 ("thermal/of: Rework the thermal device tree initialization")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

