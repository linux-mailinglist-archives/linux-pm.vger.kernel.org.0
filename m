Return-Path: <linux-pm+bounces-6975-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DE38B037F
	for <lists+linux-pm@lfdr.de>; Wed, 24 Apr 2024 09:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 109AAB25829
	for <lists+linux-pm@lfdr.de>; Wed, 24 Apr 2024 07:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FCF158211;
	Wed, 24 Apr 2024 07:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C93l+A/i"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8904157A55
	for <linux-pm@vger.kernel.org>; Wed, 24 Apr 2024 07:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945270; cv=none; b=gxjK7ljPmXRVaCW87GI4seI7sPdqrGeT7lU8ktRzmeIgFy/moAXmRUAWRUczymxO6ZiZMhh3jjJzC+USbkRipZrneS2lPyq9BO03YJFE7KYUjUA1Mj1fZ6D1Z00/aJEl/0bm1NdCBxtoIuaA0LmuZdHTTgPMfJaFZgi5TtkQGoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945270; c=relaxed/simple;
	bh=r25OLeguN4K1eHEelpNuj6AN7zkojxM0EofLkdAbtFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZY68IJeqGWPZsJZZdlJ4ZiKsiDosp2vTjUxzIpq1Tox2d2kubQ7rkxy7dRsx0vKnRJieENEQ2tltmNyGellZSqkta7udB3Peba9SKXjkxkOikL2C8h0dzCm2FYGj40Qhru0vhJfPSQtoLLd54y8tsYwh9OXhmbKdnfgdI4i2wtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C93l+A/i; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41b086d6676so1672765e9.1
        for <linux-pm@vger.kernel.org>; Wed, 24 Apr 2024 00:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713945266; x=1714550066; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=myyoINEtifDPjTf6aBdAezFxWZgIXfzRzt4GnDTHFGE=;
        b=C93l+A/i1VBKhZPguYbOZJAhuG6kyORNsBpp/qGAZpAAd2WxYyVxlYLCaPyPBqf/nq
         suNByXc7cX2WxgciLQFa1i/Y+ejnGZmhq8nH2RL29QmkNrK1thVq67FTjK6XPTErC8j2
         t4fK3uHZ26Yj8f2vWiSRo8QB/ckiQf6lA6pzRYBVLJkcTVI7uy2gn9ZjDGJD8kBDjsy8
         5y/RSytRQFDAicusNvfbo89t+BiVCncHwVrlPr3g1earGTx6PKbEO60KCFvuexRYH5ws
         XIeTJOOJAKE+E0SCn1Iu2WjIEluOhxN+5wgu8CcN1ZGcP8FY6+Ny3nF99fzYZ4kbf0As
         /+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713945266; x=1714550066;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=myyoINEtifDPjTf6aBdAezFxWZgIXfzRzt4GnDTHFGE=;
        b=MH/Z4Y8mxqfY5iFjF3H19ZgJ/hY8K3YvlCuMOz2qcc7aDS9xAI+muI3akFV/3t4XRD
         iKmrD6Ebk53OOXZm4KHrj1mL8mrnXtNB6bGtOj6+9W2Wxsgkkis+CGGQY6RLJIbONr+y
         sH5uTosfe8PqY/c8LqVnGa6gToSh96fEDNL5yYkVTVQBVDcbNo+QQbkJo+DE+OLAN/J7
         v23qYh+3FcDiJOglWq4ala+/Nb4wmeFSh+oeKVGg3aW9cyEXZoUjytBFe89tH1u05Q8e
         8VBdccHj8WAbgy2O3jIDfhXbqRdCzsG1LYMj3zMgWyBtwWysjYMG89/W6KY7YtXl3qoV
         9CHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnb9NVtrADgtc1biHDRRFiw/zh4iWg5pL1Y/bt8P6qE9GO8AFf8uBdZruAn+HxYpDFRlbgZsRmd7hxU7B+gnAM1o3pLcRT7GU=
X-Gm-Message-State: AOJu0Ywqf8yX+kBaIsR+2uhrlabOaCf7gfTwuFkYfvnaj+jHvydj5Pig
	nfAbPVH1tDA/qhWN262JsZKzJqM5Kk238PicOZpmOKXicXoCF5QiYRuObq2sAcI=
X-Google-Smtp-Source: AGHT+IEtSjCdcL4qwBEISb3Sd1YNtbbBrcgO00iMUi4ITRKcY4v2ExdRL+3YQLmx4jnbmd5Bvz7SNg==
X-Received: by 2002:a05:600c:4448:b0:41b:f95:f772 with SMTP id v8-20020a05600c444800b0041b0f95f772mr431558wmn.1.1713945266179;
        Wed, 24 Apr 2024 00:54:26 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id o20-20020a05600c511400b0041a49b10a13sm10614777wms.11.2024.04.24.00.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 00:54:25 -0700 (PDT)
Message-ID: <9ca49056-6617-4ce7-b064-a8c07b23a6ae@linaro.org>
Date: Wed, 24 Apr 2024 09:54:25 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/16] thermal: gov_step_wise: Use .manage() callback
 instead of .throttle()
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13515747.uLZWGnKmhe@kreacher> <2628456.Lt9SDvczpP@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2628456.Lt9SDvczpP@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/04/2024 18:13, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make the Step-Wise governor use the new .manage() callback instead of
> .throttle().
> 
> Even though using .throttle() is not particularly problematic for the
> Step-Wise governor, using .manage() instead still allows it to reduce
> overhead by updating all of the colling devices once after setting
> target values for all of the thermal instances.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


