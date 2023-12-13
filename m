Return-Path: <linux-pm+bounces-1092-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C62F8112E5
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 14:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32B741F2147F
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 13:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C1E2CCDD;
	Wed, 13 Dec 2023 13:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qamF2V5P"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F55DD
	for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2023 05:31:23 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40c31f18274so64808085e9.0
        for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2023 05:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702474282; x=1703079082; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gT1+x2jNVKALOWKjd6FkOQOQNIpKL6HodGq+cYC6MoM=;
        b=qamF2V5PuQKFeC4U/9RO4DQ5g1CTlQrC9LpLjwo5ZY51pPFIUWO1gKuWWXFb55DxWh
         DWQcEnTZW8qg+yM/moCYvmu/+GnrWk5Db4WKmR6IEelFjmt9USwwzp1b9gG3PQ4QQJcQ
         h67wU+vlQnTmrOXQKqa0VSknRlL/Z5x+zn8RjC4jxTXgxBvWItd3jTI5j8YAj5ymHPmy
         Si/ZJCGye5VqS5Vi84PvJaCdF+c2dG/obaJ99biIRNt31hxZPXahuhEBob6Qx239uR08
         Mot+GhV/S8ZbLjvS72jtaBBCO4NuM55fa9+dNelWD9CrZ6eNBrtZBsdI2rYXOmF5KNIF
         o27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702474282; x=1703079082;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gT1+x2jNVKALOWKjd6FkOQOQNIpKL6HodGq+cYC6MoM=;
        b=JI3jLdaAURC754au19CzyJduk1gidGJDLx7ycUkJLJwj5xpuuVhJdFgzw0jDJd53rb
         FaGuhrnrWQVz5BK34qChUyGSLRP+Tf33LzlzHP3D2w+pWz7L/ip76L1ChExuNtn8arHI
         iFGa4h+cbMGPJFBlrxc9DX4bqNeODxQ8OHDCYl/UgHI/jlTJfd84TxDN8GLWM5nwvDOn
         N+jCK43Yjdz/KjixBH+9yi8J44+HgHyXJRUlD/TKi6c69AIqNY/MuTvfJmAk7Rx4VA1d
         Whlk+aRr3wrVHJQ29mApgOTEI6ZMWFJcYxh9/zEMhXQX+xxfmlEuEPc34VFLLJPyBm1h
         Mf2w==
X-Gm-Message-State: AOJu0YwjcY4wmWcoMC1IP+nKhFrBz2+5LNwHpnYyCTSYfLy252ZouMWF
	Zw/b6wKpFUkZ4sZhMpBRNlhWNA==
X-Google-Smtp-Source: AGHT+IE+E11nyqtn0hlYZuSK8aM31EzC/BzujBRteSYaLrs3lmlbx+QqDB2/JYVsDQYVeP2ePPFp+Q==
X-Received: by 2002:a05:600c:43d4:b0:40b:5e21:bde9 with SMTP id f20-20020a05600c43d400b0040b5e21bde9mr3652331wmn.120.1702474282158;
        Wed, 13 Dec 2023 05:31:22 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id fc7-20020a05600c524700b0040c44cb251dsm12863860wmb.46.2023.12.13.05.31.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 05:31:21 -0800 (PST)
Message-ID: <c7e4a344-ef15-4316-ac41-6ec9c062eabe@linaro.org>
Date: Wed, 13 Dec 2023 14:31:21 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/core: Check get_temp ops is present when
 registering a tz
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20231213121322.2486967-1-daniel.lezcano@linaro.org>
 <CAJZ5v0gjeiCb9wBjdG+yWp5E_g2SPUMNNf-Stm_xkGau0Cbr2g@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0gjeiCb9wBjdG+yWp5E_g2SPUMNNf-Stm_xkGau0Cbr2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/12/2023 13:46, Rafael J. Wysocki wrote:
> On Wed, Dec 13, 2023 at 1:13 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> Initially the check against the get_temp ops in the
>> thermal_zone_device_update() was put in there in order to catch
>> drivers not providing this method.
>>
>> Instead of checking again and again the function if the ops exists in
>> the update function, let's do the check at registration time, so it is
>> checked one time and for all.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Looks good.  Do you want me to pick it up?

Yes please

Thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


