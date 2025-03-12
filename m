Return-Path: <linux-pm+bounces-23926-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20568A5E173
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 17:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DF0D7AA6A4
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 16:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0371C5D4B;
	Wed, 12 Mar 2025 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rsCGXmXL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C191B87F3
	for <linux-pm@vger.kernel.org>; Wed, 12 Mar 2025 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741795705; cv=none; b=NzVlwL9eNmDH7HJyoAMCux0GCffQoVnwAFRLec3Tx/XlOnYglAgWQvtVWJWhAISV4vKoN2b911YqDa88GAIUoupuyPIs1HIY3m/tkTYwnZMwi8qroFWfxcKSGqkb5jN+fheoKbTc8EF1pdijm0mH5DcZr1e9RqpS8JSGNjw/ezY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741795705; c=relaxed/simple;
	bh=/l81mkc4n15BgZGzuE4Us34XgHcjyXIkl5hqU1q+Oo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahOL9Bd4MPBcJSpT9qiNcJC87Ae/OI5qVdgZLUQhwT3GcCjBtfRu1amr4YnSuYcDEF88KC5xxUOY4N6E44u5bFBsZQaKrvQmYqbNgqvcvzTlGXOoiZ0bIYnVRiqNkF4BfAwlhj1Zt5I6rICw8l0+nIXIrDpx+TTBI5tsfk9MzvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rsCGXmXL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso36567805e9.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Mar 2025 09:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741795702; x=1742400502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5kRABI63t00ZhwHPnXAq2zHuyopqgID5ECRPytCo344=;
        b=rsCGXmXLzu/bprVNKhb4LZlry8lLTQOjhsTSTEc24P8xM4uyfaTuyO+5+HNnDofwKp
         PLejQLSQJ/jLXh82TzAm5XNxYBJdGuDrAhwd0408pEiMavOzistsb5j45Ug7UYWATBpT
         sKhMII+Akt43jRry/Y3LyCFPmNudCrJUpVreLenyPb4n/finvgvjXmCXrCudXWen8Vyx
         0dLpVIq2yQXxFEQZdQvORlD5VHpLcisJ03vJxYLNuKrsgO4nRnojLpPCiHKhG6w1N4pf
         fBfDYyJf1rV0tuEM4D4fiU5XFFGlYxSDYGkid448QCYD5FVlRSY3pF2GBsjFiAmXh7hu
         IKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741795702; x=1742400502;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5kRABI63t00ZhwHPnXAq2zHuyopqgID5ECRPytCo344=;
        b=bsUildpqmxO0RDHIlkJIzD6ZvA0HPLqlv9wLfBa2/dwpIsdUdIegNa/Lwqb4n8EB4A
         iiMBHxbfiqvLSbTRI8ZLt4kGEzGpzbbEq7hghSPaL3cYtzRWTMdfTGM/t5//+5L3dGdb
         Hs+azRC1d9eDTFWimWUC6XbPJNqeH8jLrKRaFmfTRna33lRwXrx4ejiNGljdP9XbCm8t
         DCFXg7/GGpN1NCl6aFiZUWi8+7v43bjDD7jxzG9K7XaJYPia0Dp/fBbkrt+618LksKfF
         ZPW+b1TAplzT6eNa2n2L/PUbZ86I/1ZPnvj3UuOUo5Jf+txzWiyS9KC2L88w8RITBCNI
         2OIA==
X-Forwarded-Encrypted: i=1; AJvYcCUjKE7WE2yVXTjgAxrfGKDIDgfLdF320PsFY7V6m6EXnEnFqpjNLa/vBSF/Fmvwv5bfrLzVxv39Bw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmvtphCn9dpNZ451D5gCyiuJHVD8WhKcd00elteV5I2SarlM1G
	gw/Gbz8kMPk3doe9QkbL0Yc5+71cutX9PB0UvYWO9GZTxYDx42O9NtV4OdqY4ow=
X-Gm-Gg: ASbGncsmtnl86wFXnXZmWUzbXYExKDrKbQZ6nhd35GrH46rG1AM31OdPv/NpVQwqccy
	oMRdEFRhOkcjf2tTufQ1weO8G8H04AboR6C/Upd0Beogz98iSSEnFjtSksegzlgf0GajJfg69ev
	43b4O646ddrhUycQqHUYTKJRb8YKmATZq+E43hMFGfitpP6ohjrk9pExucqNRZr6twtlzCW9Ol8
	UyCQ1m7y2zmKB3MBVS5ic0X0i2Nr7jLbPtwtXxjQUA6GCC4DqKcXJfbXXF2WKKDNfUDlbRcvoRw
	cL5MA3V5/o4ep/3ZyFzDH4bFm/wfWqHjahYBMuNRyMhwxLcS042QkeqBwb4GNKT090UEg8jiwWu
	2hWrDaaGz
X-Google-Smtp-Source: AGHT+IF+4mY3bB11AO8af31IGQWD2xZOhSkCDSiLj78VIR/ojQV2gPQFAWRE0UoElYony/PXJed0CQ==
X-Received: by 2002:a05:600c:1c9d:b0:439:643a:c8d5 with SMTP id 5b1f17b1804b1-43c549dcc0amr199565905e9.0.1741795700168;
        Wed, 12 Mar 2025 09:08:20 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d0a731265sm25382605e9.4.2025.03.12.09.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 09:08:19 -0700 (PDT)
Message-ID: <2372dced-c786-4699-9317-2ebcbda1b0cd@linaro.org>
Date: Wed, 12 Mar 2025 17:08:19 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/qcom-spmi-temp-alarm: drop unused driver
 data
To: Johan Hovold <johan+linaro@kernel.org>, Amit Kucheria <amitk@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250228082936.5694-1-johan+linaro@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250228082936.5694-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/02/2025 09:29, Johan Hovold wrote:
> The platform device driver data has not been used since commit
> 7a4ca51b7040 ("thermal/drivers/qcom-spmi: Use devm_iio_channel_get") so
> drop the unnecessary assignment.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
> 
> I noticed this when doing some rework for pm8008 last year that I have
> yet to finish.

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

