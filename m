Return-Path: <linux-pm+bounces-26449-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7D1AA46F6
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 11:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B643A5E7E
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 09:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B8523182C;
	Wed, 30 Apr 2025 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zVPwqDSm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2948171D2
	for <linux-pm@vger.kernel.org>; Wed, 30 Apr 2025 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746005168; cv=none; b=MMrvDTP+i+UKGjp08nCeiButWpNN0H5zZzudQ9oKHsOYwgRDC38RUJIFN5JsNd4Jqq6QVr1kVrjb6u8uqd5ZpZqOJMkubXwot8Pmr9TxFooXWvJ5uBamwxd/8iUpeB0FkTG0ZK/SeOhp6DHawbuhesjir4+xbAr+SsL+T8bWuv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746005168; c=relaxed/simple;
	bh=emeN+xQPR0w2hK/gMUA9tohvwWpJtFpuJ68pOjXXpCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eX4+ohrK9IUE+RUKpoF84NHkceDngYjllTbVC+MeLO0v9FxYBq3les+ono8ASIhCLISOzXHJaqwFCKf+3IpcF9omBk6fsgpYEPk+8D0n6uhagFAt6rkUk5vkGyR5B4UvGk+2jFXnTwylpokMwRXqY90oQpRQZruCQbgGkVBPlYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zVPwqDSm; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cfe574976so48486185e9.1
        for <linux-pm@vger.kernel.org>; Wed, 30 Apr 2025 02:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746005165; x=1746609965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gg8+U7uhajg2zvUCUMrdqQmupPgIClRDIQQD6o+TZVs=;
        b=zVPwqDSmRuMi3bR106aQWcNmF/9pT7OmWcCLzdrkapWRU4aynK1otwdxRjzNkqxGYr
         hcBx/kNIVNzbS7JBKIsSMeURyceN339+/oSHfPbQwsO87OjCR+ONI83jIEMUiuXiYzwX
         apUITFwzP1X/HRkS5pOfzJsB7rzFvlswetd4ruCcoghk952CXfVRKNfZlIBr+jrFBZDG
         KB8U9t1gNfiFd1uUz8wYKa+37VWaa7IfLg3eIL9kK08Q7cK/XsIIdi7ujRzW3oQrwpx/
         +5fgcecZnYSDIRVhBVbE8Ble0aaMu7He/nBqExI8bKbcz4SsS7LJRWwCIvBLuBwcfdsa
         bgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746005165; x=1746609965;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gg8+U7uhajg2zvUCUMrdqQmupPgIClRDIQQD6o+TZVs=;
        b=NWvhhxRA5P04b82vIg5vF/3FYkHJx2n6p06R7noAd0oWC6R4WMKIoJAalrHudw3T0f
         +kWBdVKpP57txczgmAFLU2NCABbVs6vhfjyaHkPTcl60ss2qBDr4IKKBHyxs6z3VdCFB
         bY2nsHJAyNYFE5Fh5v0prFC2fZD1j9WI4ekBRPjmENT0WdX2UaBXBfHqPoGZ2DWeu3Up
         WLL2V5qxBDzLH3609ou/jylfeM35ra52hA0ZIVFSF3/jLWrP1Bv2Y+lj5hQ4CfkA/+T8
         5mvWdmFb+kc6Zvvi/9Wsxx6hVyCHYqpt6bLAELEN+S3MlKit9TEM9y4l409v0SGAGQiG
         FXng==
X-Forwarded-Encrypted: i=1; AJvYcCWLCyQ+KMxMKQgKUxj52kOxwRF665LieGR4uUqxK5HQfwddnVmGyvXx+bxht+Dfdf1e2zK8I9st3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzX1BXV+t5KBXkDCNXhUJPzaGDQloyU/mYgWoG0f9d/3E34a/Mn
	x/kg/kU40RRWUzB0klEtMPQmFM9N3i2QpXu4x4M0kqFeLc6yq/aKtDSmsSdP78o=
X-Gm-Gg: ASbGncv5H2OiI/OW0E0pTooMbL4S2yTDzXBFvqAwVgpJuIMs5W3PWBgIq85+Pv9wrQN
	xAX6QPKd8CY523CP4V12y6VSv0MGMlJJhARKefuuz3qAiMAruOsVYS149+rPkEEAxqiCh9vLsB/
	0gi1/Y5nlY8NxtOsb62+Snq84E7d4n54/fsV4NLxlKhAZurwqKAxUjA+L8gvDm5FaAmniDLbNm2
	r+kEZW6Gj2rDpRI0P/BUXp+eUUEgVQmPFgicpvIyD3tOmwWODZ6Itppfo9mKFC6mvIm5KJFeISL
	WcKtq/DcQArJEgJgXIVIa3dn7haM5sOfUCFB5TeoMqJheGGp+dy7LjDPsXQmchKf3m24XnsrgMc
	k35E2
X-Google-Smtp-Source: AGHT+IGeU+1g/ZzusMepn3Swj4cy0n4ZXYGf5XGELdjXdxHsUaERxZxPSUk0zKSfnUqF6M2pw81X1A==
X-Received: by 2002:a05:6000:4287:b0:3a0:6b91:fefc with SMTP id ffacd0b85a97d-3a08f7d22d8mr1934468f8f.50.1746005164916;
        Wed, 30 Apr 2025 02:26:04 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a073c8da58sm16614490f8f.15.2025.04.30.02.26.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 02:26:04 -0700 (PDT)
Message-ID: <542d80c4-edba-4b5a-a47e-8cb1d76e4c89@linaro.org>
Date: Wed, 30 Apr 2025 11:26:03 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: amlogic: Rename Uptat to uptat to follow kernel
 coding style
To: Enrique <kike.correo99.f@gmail.com>
Cc: glaroque@baylibre.com, rafael@kernel.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, linux-pm@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <Z-MEZNMLUmj75uxN@debian.debian> <aAImJGYXFDx_q8D_@mai.linaro.org>
 <CANfmkGDVks5tqgDw0ZvNMxT_vfD8rUKyZZJ4LUK6k637wt7=-A@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CANfmkGDVks5tqgDw0ZvNMxT_vfD8rUKyZZJ4LUK6k637wt7=-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/04/2025 20:47, Enrique wrote:
> Hi Daniel,
> 
> Thank you for applying my patch! I’m trying to verify where it was merged.
> Could you confirm if it’s in the `staging-testing` branch or another tree?
> 
> Commit hash: 84fe0cc6fddb6afcdca838d80756080f84cf9ecd

https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/commit/?h=thermal/linux-next&id=b8e05d5de934c037594f4ad3550b8228da1b9c2d

> Best regards,
> Enrique Vazquez
> 
> 
> El vie, 18 abr 2025 a la(s) 4:15 a.m., Daniel Lezcano 
> (daniel.lezcano@linaro.org <mailto:daniel.lezcano@linaro.org>) escribió:
> 
>     On Tue, Mar 25, 2025 at 01:30:44PM -0600, Enrique Isidoro Vazquez
>     Ramos wrote:
>      > The variable Uptat uses CamelCase, which violates the kernel's coding
>      > style that mandates snake_case for variable names. This is a purely
>      > cosmetic change with no functional impact.
>      >
>      > Compilation tested with:
>      > - checkpatch.pl <http://checkpatch.pl> --strict passed (no new
>     warnings/errors).
>      >
>      > Signed-off-by: Enrique Isidoro Vazquez Ramos
>     <kike.correo99.f@gmail.com <mailto:kike.correo99.f@gmail.com>>
>      > ---
> 
>     Applied, thanks
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

