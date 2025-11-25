Return-Path: <linux-pm+bounces-38547-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3520EC8453F
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 10:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BB26934F007
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 09:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34992EDD40;
	Tue, 25 Nov 2025 09:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ODnHQgPc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0372ED853
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 09:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764064688; cv=none; b=lroSFstv/M+7ybF+aqmhJMkwoVAsWUji7nG+QLhzUghdwwnV/oRzLp/quQC2zi7pXlnfI7mnm39l8XPQ0qLRGUp4fRR+0JVndhmiMb3H8022CM/4vjjCTkHLefHSrKDz+0hIXkWXQCjM+Gkg55BUU1ZPa9VSnkJ2/JRVu3zAJOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764064688; c=relaxed/simple;
	bh=+Bvp48vIsEAty/4kptj5aE0gOoyNVogt3ZIlOlJPcbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=elfVEWltgWSI1uF0L4LjMVMb+1eyNmr4kRoPOeBo+wykt6BgvuicHEHGjdo5z8o8ugO857W4NVIvlD7wo7lbDzGjOheFdEHZiEG2/AzVDadp5ZjS8awteykDSl8iXaH9YNrKFY5sTY6bfYD2coCf7xEaeIPvX8DrDmNKl56lKYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ODnHQgPc; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so55721355e9.2
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 01:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764064685; x=1764669485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6dOkxs8WqzorGeMW44vvMt1jQg4XWV2o2YphYrM2grQ=;
        b=ODnHQgPc+cYaDiw52ouplzhUiwUtj7HUhylh1eMaIofCH0fxWO6CUdU7Wq/fIwnTbU
         2lB8mLVqxlkVlsydssMb04N0l43tcQsET5iX0UZl5B91CCTTwFpCAsaNlrJDOjertVSg
         3An2DjMNZI+I7RvHCy8f951yfHU2JvkIL/ALMfXBK4sHyEbavPlvpIFPK5UEDPCnqXy0
         EZtQnwEGdHJi1O3Ji4MnZ60aBmvG2AnuPL40AYhEN37JZ59mCcFJ1OFCepHIy5yz31XO
         3/ZX5vLQf5YDePQ7B6P1ifwY1J8VP+d7zZp29JVzinELPMxKtk527Aa4drnj2zYesWze
         ko8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764064685; x=1764669485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6dOkxs8WqzorGeMW44vvMt1jQg4XWV2o2YphYrM2grQ=;
        b=nCEQVy1ctx3SLfbrWfneIQMCmoMRgVcOR3sP+fsbA474TuUyIgLBwgE5aezv6iQIrl
         DOnbBpde7vBIHVLKp8bGsHjhsEkibqXX1fTEG75Mnn0nRXE4MG8m/mjCnusxWux3B19Q
         /6u7aQIE6wt0VLAwMMx7QOtrXYQ08sDcCt2e3EG8Rau6NUcQrTsiELOsr0Jxr7Ek2zg8
         vVEoshqoEXpJ23E/FnfKmNAB5RF54ILgy5V9NIGBi7X3/IxLoBhzrYjXeJ4Lm7+r/qvh
         M3lAVhccY4F95MYX+n2/yBcAQP+4OL702zdoA5v8KNnhUpZf3Zh25ITkQ05DfDIyTzLX
         jiqw==
X-Gm-Message-State: AOJu0YwIjRd+9aurei1eO5cSY2JAKLN8t0ZonuT46JiivaiUhWiwxHzw
	GOgHb8ianJNCce/+HcPD4qtl67fD5DYfqB9knYBMYjpkOjAsNm9IHmTfPmJIadGHhpY=
X-Gm-Gg: ASbGnctwJikasLcNFqia33McJqU75awzRQGafZb0CV5klEbAvk/ly+I+7FkCK0Bf39s
	MxKkWVw7SQmLlhdFbO+6B/Pbw/XasPrtIvjE5+GuYGMFTCjjtiWWW8ASqU0QtxWCOKnVRAowiOZ
	rkzEx9Eb5SbgXqN8OzkBNvIaVJzl5ljIgtE30q5NHbeIMWFwef40a/1jJGvNXclq2osZnH62EaD
	dS1gGsHq23SOrkQQCJvMJ9lWT02rI/81y4LJNCi0EC/8FsJJ56fCZx3gcwrbeOJUrYaoKfpmOJZ
	Hq114FaHzJWcT0wWta5HgqyjlhZDzZX4ffmGnWmfgvqfC1KfzsLyN8x5qAh2PNWttcL3nWdYrRZ
	qc87uPyVZxV60nRLXW3tLJ5zExZ9V6VZF29dOI5PpGjEOyOCopfGDDgl7WEwj0gTkCtxH/vTwYp
	1wqsEooXp4cVZGDw+ohXXvNjpivq6ilYDMPpNtB+3cCMFyhW+pZE6lKILnN/jtVRgvjts6lquKE
	nLt
X-Google-Smtp-Source: AGHT+IFoE9OmJaNFhl0oCYA4I5Vz8Lh4b1/CD22Ed+dT5SBsnD4UIM73MCg/02FxSamLM9sqOV5Ppw==
X-Received: by 2002:a05:600c:3b97:b0:477:9e8f:dae8 with SMTP id 5b1f17b1804b1-47904a685c0mr25597235e9.0.1764064685199;
        Tue, 25 Nov 2025 01:58:05 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:1d9d:2362:4539:c68d? ([2a05:6e02:1041:c10:1d9d:2362:4539:c68d])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-477bf3ba1b4sm246185395e9.15.2025.11.25.01.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 01:58:04 -0800 (PST)
Message-ID: <fe1efb30-9d23-4291-a21e-80a5ffb954b1@linaro.org>
Date: Tue, 25 Nov 2025 10:58:03 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: thermal: qcom-tsens: make ipq5018 tsens
 standalone compatible
To: george.moussalem@outlook.com, Amit Kucheria <amitk@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <lumag@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250818-ipq5018-tsens-fix-v1-0-0f08cf09182d@outlook.com>
 <20250818-ipq5018-tsens-fix-v1-1-0f08cf09182d@outlook.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250818-ipq5018-tsens-fix-v1-1-0f08cf09182d@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/18/25 13:33, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> The tsens IP found in the IPQ5018 SoC should not use qcom,tsens-v1 as
> fallback since it has no RPM and, as such, must deviate from the
> standard v1 init routine as this version of tsens needs to be explicitly
> reset and enabled in the driver.
> 
> So let's make qcom,ipq5018-tsens a standalone compatible in the bindings.
> 
> Fixes: 77c6d28192ef ("dt-bindings: thermal: qcom-tsens: Add ipq5018 compatible")
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---

Applied patch 1/2

Thanks

   -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

