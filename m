Return-Path: <linux-pm+bounces-25672-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 719DBA92C66
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 22:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B9007A4BC3
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 20:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A692063C2;
	Thu, 17 Apr 2025 20:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ATBPhGaE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B009199947
	for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 20:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744923204; cv=none; b=l7i9skozgZXPER80Bq3XLs/YJnoiIaJmGeao5h/Wqw8feZEBC210dxnP3Is+kyhkRJ0HcVgQiFJLM2OVy+q8WrWOZ3IMM3cO0/XLe5W50mlKRQNaw+5gpKUKJbYkws5VE40S2WUuUNKFtT7sW0x2LZlT83LMjIyV+B9nELcfbtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744923204; c=relaxed/simple;
	bh=dU4K8w2iZUqK1qEwcjzFKZf95JgMH503fYGue1h04/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufROpsaZLX4aWa5Ly07DbcXNCZ02QIyn6UUBD85q6+k5VdkZVsdY1QN96MtkcxQ28aEfxpkGYoA5BH/OsoM3UID9Zm8ciQom5ZAds2tP9k0pj21n9mTUgU9Ry7GbRnW9w6Yllk4x3BM5WmhQ2VQJrMrZdBXkz/APLVN8D34wvp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ATBPhGaE; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf848528aso9599865e9.2
        for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 13:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744923200; x=1745528000; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xDbB859dSDSfvEjPhjet4jsYsLjTq5f/3IKKPbQbhjc=;
        b=ATBPhGaE921YD+OxmrFJAIF5q1jNXPA8c9QQKqWjM8UOprf7i31rmipI1ohg64JvSL
         XfACDbNayyuzU+bKe0YDOjMbSTch7sMf9bK1pS5vdpcRUfT0bD5F0hoZXvi8qpfY4FNp
         7YjE0Se4qINVirmd0RPalDjWOQHDA6k1ZrxrNCHsr/SGWMINDiaVJTBW8XrA7Hk3l5zZ
         3yrc0k0FIvKuGx3DOYffGqu1FBu+Bk1dHvAgfnH7g6yH28SKJ7Cv5SpLKte1Pm6hqPqd
         VuJsyL6FVVwQQOGIsr29MrvrAwa8paM7xZHJswJpapmOIjcU25Sjd75vRzxIGRPeh1Fj
         /4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744923200; x=1745528000;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xDbB859dSDSfvEjPhjet4jsYsLjTq5f/3IKKPbQbhjc=;
        b=aD8VZuuk9DPt51j59T7RUPa57aHYIeZ3F8vpmuXONEMSZDsw1n12G1p0Hcx+jbn7wR
         aAOq/Vkwts1DDK9qilmtKE5tCaYrJMXG80cYNLGSNBk3JnSMl/Al2VvexdbeRM0/JJr1
         3/pAU06lTkbBR8e5vPhuV3CJIjuyYBEopO3b8DNkfIjDVQACigeL8cucfAhZxqDg3ACF
         qkm3CeXXdjxjXVfvg81+SYQ2BV9xVNrCS3Vyn101CMfWGCzLtEE3lg+aa0GLPjg/kqmj
         nmsJ+Q43BAW1kprOIr4ikOGIrD3G2EsEi7bzssUmVJEXrJJU4qi++LRconBA4f09ZT4C
         FE6g==
X-Forwarded-Encrypted: i=1; AJvYcCWS9ttmdUcYVYstDa4CKhIQLbcEJpkuoZah7y8t7MtYZraMoW2YEnwJTsaF8B3m4xWQ15EbMo4Z1g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5e8lN7I3EgJ6ryJIajHuJgPJ6ZIa7siZ8uIINdNuHuVYtVCmS
	tijufUH8HvE57rjmWlvCM5mfna67cjrzYX3yT5mSLz+NCgpyEVybb7U2dZdhufQ=
X-Gm-Gg: ASbGncs9IBXEbObEn5mUDuWOZQlzrrBCd49N56rY+Qt2L+P9hPtsQq5x4AtqUEpDV/R
	MNdXOiZVn02dd6l5c/uODdJC82HXWA0OvdGj2GN/4lEX6savt7eZCP5tS4uFDxxg1z3IYEvyDJd
	tLxzcG+FNw7xe51BOVVpiitaqHBh7vRGNfK3fggHnZX+S9/s0Gcwc74xBI17T1Zfh8skznGbSwL
	ROWlfjCCZZEmis/rABMm+V/FJa70nUUx9y1FnHTh52oqBkn1f9jLE8ZzDS2uVUOrvSHUf/ZI8P0
	VbDiunvW5EekVZ7X4uGFg3TK6ccbgIPWAdRisQaZQ8Ok5ObX5jokxECVL0W0KounjG9D8Apotxm
	hl3c=
X-Google-Smtp-Source: AGHT+IE/Yp64SirhNGNelGiWpri0X2Q09E00vtNFhQsoUcfIVJFu1JQsSDwG5YgCWmsxIzILvvYqcA==
X-Received: by 2002:a05:600c:b94:b0:43d:fa59:af98 with SMTP id 5b1f17b1804b1-4406ac65474mr2651105e9.33.1744923200468;
        Thu, 17 Apr 2025 13:53:20 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406abb640bsm3339605e9.2.2025.04.17.13.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 13:53:19 -0700 (PDT)
Date: Thu, 17 Apr 2025 22:53:18 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: hisi: Do not enable by default during compile
 testing
Message-ID: <aAFqPuFBfGEKFb-D@mai.linaro.org>
References: <20250417074638.81329-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250417074638.81329-1-krzysztof.kozlowski@linaro.org>

On Thu, Apr 17, 2025 at 09:46:37AM +0200, Krzysztof Kozlowski wrote:
> Enabling the compile test should not cause automatic enabling of all
> drivers, but only allow to choose to compile them.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---

Applied, thanks


-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

