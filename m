Return-Path: <linux-pm+bounces-12748-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D78D95BB65
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 18:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B992E1F2385C
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 16:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8841CCB5E;
	Thu, 22 Aug 2024 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ub03fLtv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B12217A588
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 16:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724342979; cv=none; b=U170ZlDBehXVjF2jpWFjyqCFvsOx3ayp1E1gPLcCpZMsWCW+j8SMTQfbWgpXcl4W38jFvsITdcyQ6YDJFu/rnWUXh27qBWWArlfCBgEssCiyEh3WQUrDncbb+sRLABJmoITCRsJ9D2LDZ8aWXPAYjHXV9OPbaFgP9u2FiH9AjNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724342979; c=relaxed/simple;
	bh=N1zMZ+hXVfz11gY2kkBw6IRe1yiWuDqeJ3l7e5bM8Vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDJiprewGxxQDYIYqlvPPwdO+IcKmVe+CH9aEf+jOv3vHZW+YXURfTyhaAGNVhNGVgym6UE7p0LusyFe2DZ7n/WGefIQkNTu+wG+hpqrccwVfbhYMT99X2mx9kPoHyPHXSfu4auc/49EtOkEXxiAui1tmGT8FQi+fpwq+j5UFaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ub03fLtv; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-428fb103724so11381835e9.1
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 09:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724342976; x=1724947776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YVHwgiGRwBVRiA1k1Gg1ltpgqyX9aL/hfU0tA2E2xBs=;
        b=Ub03fLtvJPJBUCdiCNr+J76L0yFG82k/Tz0UTY1aE5DvJMhWxd9vhyON/CoYLGAezG
         vOOAldCbqa4Z8sTVmHlJNYDB5NJbcCpVBfZvmgmO7xUGiLwAhY5iv63v1iiLsq1GtySM
         +93OyZ25s1mngsE7TpUbm2AWIi41UO9lZIRzQnbXdR3lzneIeLN4qd1ArGoClh21x9gz
         dsNp8BLO4NMW5EXoVHlu7sB9SFTttjcD3ED6Veikr6ChVwIMi8GQQd6fS7VTI1PoiFa5
         ER1pSCBCam2OFI5viLJhGIS++wETBVficE5kw8wspH71ifPjdOakUCMSwprgD9P37Kg5
         5Qqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724342976; x=1724947776;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YVHwgiGRwBVRiA1k1Gg1ltpgqyX9aL/hfU0tA2E2xBs=;
        b=NKdl/RuxaQ5+YuyT+qsrJYXg9y8dy6wkQj9Vge2kufSRWQ1nefQ9Xx1hzq+H0dqO3c
         Llizl5XWLg2RpWDjuK2J8fTlgPh0jXTX3hSfuDKoCsKV+HHN5jAt7NCN2Geb+W7OtCCa
         78PJC9LdiYF/AVqfq6Ozcib3inA77TuAviu94r5toElzZJNXs6eG2ZSPNQr6QO5fTnBj
         of8z2Jr3s3m0tiE/wTRxBQ4Z8B5Wx2PLQfpSj0D9T0F1HEN/vh9u9qse9q0ShNWCwL/a
         VWY12Kw7HmIXeAAGMKBSTuqrmhO7aS1MNMNOAJw8z428ziWSehGYqTc4yxuLvFbiauCx
         GXkg==
X-Forwarded-Encrypted: i=1; AJvYcCXcZJGcGfitI0GjUtFlaPmgRXNXQ2SpBs6FYlSB7wcipdLFOAzrzJOw5EEb6JgibwYWGhQeTallTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcxnC9bLBCdDBCqx+Xs0X/28e/VC9UBtvNmvU3CCeRauJDy3uv
	jlgWaywYbcxK9ypMUx6U6+eh4M6Sb67CosYybDTBVViwHvZqU7fQQgSVcg/1Fjo=
X-Google-Smtp-Source: AGHT+IF1xtLjO7HbauT10nJjxAFzvO6sbfbstsDOKVLiY/kd6TeqGRF7IYYKtPte/9nFo8s5ewLDcA==
X-Received: by 2002:a5d:6e8b:0:b0:36b:5d86:d885 with SMTP id ffacd0b85a97d-373052b51a8mr2118977f8f.24.1724342975461;
        Thu, 22 Aug 2024 09:09:35 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42abee86df3sm65738805e9.14.2024.08.22.09.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 09:09:35 -0700 (PDT)
Message-ID: <65d60efb-9512-45a9-9303-4354eec21bd4@linaro.org>
Date: Thu, 22 Aug 2024 18:09:34 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] thermal: of: Fix OF node leak in
 thermal_of_trips_init() error path
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240814195823.437597-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240814195823.437597-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/08/2024 21:58, Krzysztof Kozlowski wrote:
> Terminating for_each_child_of_node() loop requires dropping OF node
> reference, so bailing out after thermal_of_populate_trip() error misses
> this.  Solve the OF node reference leak with scoped
> for_each_child_of_node_scoped().
> 
> Fixes: d0c75fa2c17f ("thermal/of: Initialize trip points separately")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

