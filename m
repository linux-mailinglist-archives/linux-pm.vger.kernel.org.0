Return-Path: <linux-pm+bounces-12414-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A229567DD
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 12:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E779F1F22C3F
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 10:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6942515F3E0;
	Mon, 19 Aug 2024 10:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZfbVLNe9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C71315B14E
	for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2024 10:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062343; cv=none; b=j4PNMX4Ny5ZHPkgttf9CIKq+d+TGpBqrC6kblIpVRUsOS274AwrYUmRdye8tcNUc/zWsvdF3gmvlbDr0wsXyV7MRVbVDqI4oahgZhZjGfleYD0ZF6jVFPO/pzOdJ7qGlJ6nOReTKW0zaQ2iGFgxioPO9bGCjgNQ/dYpJ18MprJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062343; c=relaxed/simple;
	bh=/ghlRPw7Tuu3E6xgtqsVeIXHB8YA6tN69TVusu8Ea/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Re6QrJilV5HAnL5GyI0GB/bOpQ2r7WdsNsETItEZZWCRGE4p2WYjXw+yUKxDgtt73Pa03XGDq/aCZFTaSYRNPBIuqUMKXRLXVPJqFwuxylXEZGX6nadEy3dwTMRFC40stt8r+w66G5KrfRj+L3D8j4G7Aw0g6uW6xjYcj5GzRCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZfbVLNe9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4280bbdad3dso31950275e9.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2024 03:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724062340; x=1724667140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u01tN3aVPRz7WiKLoD0/+oPhy5rtcvmG0FA6+cZ2cQc=;
        b=ZfbVLNe9rffrhwo2UUVykmH17138ANMwfmd8EpI81sSzQdNjXOaUtbJUysDFSXF5Hf
         GSrctYhA7/YYcRqvg/wDIwtnVGOwhfRv8xjoyrpIf1uSe6dFXVZXFzDiF87Gx6lV9Kyh
         TqE6M287MM6lzukbiYXW8qdOBwJlW4eC0yQo5wf4QSgAGPbhtylPWOmNNQYPkX9WeL1m
         Ob5nXlE9nO8UU7SHY8joFMiJYD5cPwkJahzGs65e9YrfEBbEVVsSphqYGYT9i6ipdYYC
         TQHjcoZJc7OB6b01mDROPDcWE1YnVElo4wr/F9Ersl/Gad9mfrPUy+qulnKQcp2aR5xV
         1ARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724062340; x=1724667140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u01tN3aVPRz7WiKLoD0/+oPhy5rtcvmG0FA6+cZ2cQc=;
        b=PS7Ow+Do3kEhZjAyZINA1CrsMZGOqxo5aiXVV9kkE+7/KeDt725MnvNKQ7nAepfcm6
         VWzk2uB0T7sQb9xkSBYlWlwZu8IgzCsM/HHtuesTFquefhJPooOVuas1lDRr9/lCEWFD
         +Z7ZiXXMH7SqKNXE7fbgpMRnmkn3XVLzvWQldZx5ERrRDPlOiagg2wGq3oyEhPWGFGaq
         /8nIquSYq4UuhBnfYAZ+geiW5gpNU7z4Y4tTjgByd/2mVOhgMhBUvCdlWqzhRAIjE1ek
         xgtGCWOVGN7VQ+W8bgCvfUH+g4y1FQRNTQeWKAgHRHXoioYnYy3uWNtSsNR6V7j3hse6
         TJcA==
X-Forwarded-Encrypted: i=1; AJvYcCWRlKpk8Ma8NePrRx5otVW2IazcOlNo2vKh3MAHByQLkprbBhRvUgSnzD5VE0prMpj+QClrIfU/jvemwrv1rZ985abh4P/mDrc=
X-Gm-Message-State: AOJu0YzpSORhvQsp302/lMPlPaJ3mZXnpNZSF2AqhQAvT+1a6h3X7icR
	l6dHKsbHoqJI7jh4VjLMUUs/h/T6Xf/kzTsVlvXZe/nY3QMguPYCRyD/FABSPgs=
X-Google-Smtp-Source: AGHT+IHu+N6/2viMLzlmeJTksGmRyS8v1GlaliV8j0cpbt9bMFA3jAFMaaZXMRXUvn8ECUs599nhQg==
X-Received: by 2002:a05:600c:354d:b0:426:5dc8:6a63 with SMTP id 5b1f17b1804b1-429ed7d19e9mr62670535e9.30.1724062339473;
        Mon, 19 Aug 2024 03:12:19 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-429d877f234sm163622105e9.1.2024.08.19.03.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 03:12:19 -0700 (PDT)
Message-ID: <f3d2c104-360a-4da0-8d77-59af89ebda2b@linaro.org>
Date: Mon, 19 Aug 2024 12:12:18 +0200
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
> ---

Applied, thanks for the fixes


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

