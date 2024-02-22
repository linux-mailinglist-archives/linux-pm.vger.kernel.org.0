Return-Path: <linux-pm+bounces-4265-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD9185FB88
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 15:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3FA8284578
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 14:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D959B1487E8;
	Thu, 22 Feb 2024 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QXvIVA2V"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013901474BF
	for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 14:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708613304; cv=none; b=gfUJUrnveQUy3q9+LyLIwVdznXSg5GHcDSGKooRjxOLQT43gjHAlthg+Tv9p3KnB3XBq9ZnomPKiEGjG7cr2SFVLMem4DljhTwEnloc4/eu0f+e5JLC4OBTjVfpAV9a0attarN3pw08ikNJjUjYE+5yl/nrxn4QVc1bE0qFAjS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708613304; c=relaxed/simple;
	bh=oTNiQOVa9UPc+CcXKg/4uP4XhIhH0XZw8JWypLjnUrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KdbHhszFT7xtiTit+zwpVNUGVqDrlYEbUkR6eGm6nsl+tq/B4NyyNSAxJuO7IFSN+WXfAi02Og+2LfKxZJyqLzH3YaP/o8wlw9AwodRkxgSwlQYM4swkwqVuUCYRSVvGpP2lEvyrb9z6hTGT9Nz4JhT7lPyVMoP0hPfME5fTAvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QXvIVA2V; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512dc7b7fc2so983713e87.0
        for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 06:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708613301; x=1709218101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=peIj76sTqyfZMIrz7VgORO7dcy5u5KgAsi9Knmv8iBM=;
        b=QXvIVA2Vmwewwfw9hfU6jg46jk+xCtAE6LgAIdZWdCQRkxBquR1ZoRpdNC2x6Vfs8x
         lOC9dsb90JgiELVmwcyP0jEcvI1wFRaHLVTMc5w89JWh6ufQu1gaXtPYP95wVQqqfJoh
         vcXnvc/BXlfpLO1c1SVOheXDRgS2ThIuPuXNAd/ogBWQZqEAp0ID/WnET1aJ/eUwhL8b
         I9MVrT/nn2dj2G7CUDwOnIeNjFa//hIy9gLuo58VJnpyzfRYCGB988sS3hf1CupHiCXO
         Cp+aaqymR+eZ+DcOBa1y8sjlGaHFtIGuGORJCz4jRaKr0j/q24DFHOGF/odka+uAjNrM
         2v9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708613301; x=1709218101;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=peIj76sTqyfZMIrz7VgORO7dcy5u5KgAsi9Knmv8iBM=;
        b=dH/gNlqHyF/GfLOvQjJPlmezETQSQSn92I9pTnwqxt97hFRZEIViX5CU4b8+FWNfpY
         a7rifNiABSNJTftIyuCnumZgfQqV5S/f6QU2BQfqi1sN972GX18eWzF14h0xbIBeWAIU
         ZZp/5dTlR5fC21V1zWXpBNhGLXzjz8ew+RXR25ZaBWBitwseI9OV5BnGwBxMV0TmY3pM
         tr+5TQzAhlxsyQiiVHh9yAkXRxMMY4lftqFE6AZnjNRTx9zcXMHuOk23HEkogPUCpjuk
         fKUnod9p3siWQIusae6m9xNTFHvLAi2xaDBp9D7wR9bixnsrRzLV/VMDg4Jtli5piRnH
         WlfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVrhntJ0luT1JhrSPWZCPCLVq9UQ509GBKyKX+Mv+2AcFeBw9fgfvMvzq5WbKHJFrCjYHJSLWiIo9NrYwN6z95OH1IcrWVPZQ=
X-Gm-Message-State: AOJu0YzjtdtNdKwKZznKDJOdJx1hTfxap55juRFLVN1BswNsyS68PhXI
	cnZiLG6y1pbBtVx9neTPSCuPwAcE0jw6KHwtee9jZ7tzdlCQuvbunAf8fTw0ytA=
X-Google-Smtp-Source: AGHT+IHjV4zsu+gepvm6hVV3ZEWYhg3xi0pO8rAfzf0Mj/Hk8VjjKzGsYl5EVyFm+i8ZMKbveXDTJQ==
X-Received: by 2002:a05:6512:3b0b:b0:512:e240:c5af with SMTP id f11-20020a0565123b0b00b00512e240c5afmr463099lfv.1.1708613301172;
        Thu, 22 Feb 2024 06:48:21 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id f19-20020a05600c155300b00411ff030f06sm22717689wmg.9.2024.02.22.06.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 06:48:20 -0800 (PST)
Message-ID: <e9947180-a10e-4359-b015-096506c1e39f@linaro.org>
Date: Thu, 22 Feb 2024 15:48:19 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] thermal: core: Drop the .set_trip_hyst() thermal
 zone operation
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, netdev@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 linux-wireless@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
References: <6017196.lOV4Wx5bFT@kreacher> <2923201.e9J7NaK4W3@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2923201.e9J7NaK4W3@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/02/2024 19:32, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> None of the users of the thermal core provides a .set_trip_hyst()
> thermal zone operation, so drop that callback from struct
> thermal_zone_device_ops and update trip_point_hyst_store()
> accordingly.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


