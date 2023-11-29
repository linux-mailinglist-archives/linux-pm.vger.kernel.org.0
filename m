Return-Path: <linux-pm+bounces-464-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A157FD647
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 13:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B80282FF7
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 12:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9D71D6B1;
	Wed, 29 Nov 2023 12:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FCj+KUmJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56D6D7E
	for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 04:06:14 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40b4c2ef584so15508165e9.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 04:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701259573; x=1701864373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0K4x5/3z5HBN3+ypyyGTbuqxNkiu5uT0EWvOU6MU1RY=;
        b=FCj+KUmJ43j5zfjYslLPt8In2wnyHaj5fqIl2m3k6cHetK7/jUaNyDZ2zdvhN/A6Vn
         A04nRNU9R+qeACsG8dQvoD9td/MP1iNV94jZEIxdhGRq2K8EkZYt25EfhhsxcTcaDCgg
         50xRpo0CVztoJWMNFP/arLioL72sV9jmv5i02Phhbk9LOC+ixLKtxBPO5Lp1d8NIK+q8
         CQ93mA9QhdysWwmQEFvq260j6CzneOSW6OXH6848xR6wk3WWNVlpcqHTrausH3MF4M9j
         73mjN8zp9lYfaAZEO4JjZuG4to8Q23RrN1v8WOxwBA5svq2aDVLPauOeCO5TiZeDoM8H
         EnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701259573; x=1701864373;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0K4x5/3z5HBN3+ypyyGTbuqxNkiu5uT0EWvOU6MU1RY=;
        b=qmWlTS+lk/70fD5xPbPE/4wAZH7w2ouZkx0NhAAuh5Bj2Hn6Q9Z1JimcsCL6srq44A
         UWc5pcdP+XRTtMA/nt2OJdteDEPLJDgRiLtISkN5jnOgsb+Y5Oqqf1r5N53rQC7fxH7X
         NmJmh+J7LeANnzNUHnfRxwtUBhhU+k9p+/zJfCDEKeMFUjGiQKQ+q3lS0RsYwMObMJ85
         qorT1JAhP0k4fim4e3vus+MTiQXqisrBnnqKMmnfq+qK3+0JDLMq9a9ZoZsgQNIRQMEk
         Q7Z6kZ5/O6CgoXiPCu6v7cwM8FCKD4bup/j9PCZGHpjr4BneUreL0dVPn5aSOLaPEFg0
         Y92w==
X-Gm-Message-State: AOJu0Ywt0IKHk9OgKFRZq5ThJxxWzw9ocS/sA7gRlYTEn+XqTd6LWQeQ
	c4xX3OOm9UlD4LUzsRAzwKBsQQ==
X-Google-Smtp-Source: AGHT+IEavg7sg+S7jrYdKqWtEn3Im15kJntLpiPxKsrgDiaRvPVfxkIybp2af2B44ez/Hh5OE/pXYw==
X-Received: by 2002:a05:600c:3595:b0:40b:36e6:7940 with SMTP id p21-20020a05600c359500b0040b36e67940mr13885625wmq.35.1701259573212;
        Wed, 29 Nov 2023 04:06:13 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:38f1:13b7:9b7a:2d6b? ([2a05:6e02:1041:c10:38f1:13b7:9b7a:2d6b])
        by smtp.googlemail.com with ESMTPSA id j35-20020a05600c1c2300b004076f522058sm2048368wms.0.2023.11.29.04.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 04:06:12 -0800 (PST)
Message-ID: <9d86cac8-3654-43ca-84cd-fa9ea8e91772@linaro.org>
Date: Wed, 29 Nov 2023 13:06:12 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/4] reboot: Introduce
 thermal_zone_device_critical_reboot()
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>
Cc: rafael@kernel.org, krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
 conor+dt@kernel.org, mazziesaccount@gmail.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
References: <20231119130551.2416869-1-festevam@gmail.com>
 <20231119130551.2416869-3-festevam@gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20231119130551.2416869-3-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/11/2023 14:05, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Introduce thermal_zone_device_critical_reboot() to trigger an
> emergency reboot.
> 
> It is a counterpart of thermal_zone_device_critical() with the
> difference that it will force a reboot instead of shutdown.
> 
> The motivation for doing this is to allow the thermal subystem
> to trigger a reboot when the temperature reaches the critical
> temperature.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---

[ ... ]

> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index cee814d5d1ac..3644326b18ac 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -361,6 +361,7 @@ int thermal_zone_get_offset(struct thermal_zone_device *tz);
>   int thermal_zone_device_enable(struct thermal_zone_device *tz);
>   int thermal_zone_device_disable(struct thermal_zone_device *tz);
>   void thermal_zone_device_critical(struct thermal_zone_device *tz);
> +void thermal_zone_device_critical_reboot(struct thermal_zone_device *tz);

It is more relevant to keep it private to the thermal core as there is 
no user of it except in the thermal-of. IOW in thermal_core.h

[ ... ]


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


