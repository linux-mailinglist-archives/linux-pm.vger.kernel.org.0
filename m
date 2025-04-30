Return-Path: <linux-pm+bounces-26444-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829A5AA45D9
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 10:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59CAD98695B
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 08:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6BB219A7D;
	Wed, 30 Apr 2025 08:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z8fxuge+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD7F2DC78E
	for <linux-pm@vger.kernel.org>; Wed, 30 Apr 2025 08:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746002822; cv=none; b=oFJQPh99a4KpGVKMXIngUJ9fnDncgd6fUGag/NhDxjuWV0S/Du/u6hsw1nkHLDaO1d7t0hdQkI/vD/6IUh0CRcaddHHof+8ismiND5WCVlH2GmnPxQWGKCds1Pa4wJ08AP23HSRu67KENOWRt2tFDnItHU/EMfxx5Hg2zR0uTzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746002822; c=relaxed/simple;
	bh=Y9EbBv9uhTQU/4WYy7VxL5xhYLllbFHdTeX3Z/LCSbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6yCyRodOO/DeD3/Fx8wXDrsUiokeNFq/AuB9CRn8JvxvHnDe9bqbedAEqcG55uM3NhHOAg6VTB8w8QgbBNJ7w3TyovPZ+Lff4BVzgebE61mZhF7cb/zZuSqzvV2vCtTdZzWI74wD589YFip7gmCERkPK4mkY2Ld2TTkyg8OXhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z8fxuge+; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-301918a4e1bso5738603a91.1
        for <linux-pm@vger.kernel.org>; Wed, 30 Apr 2025 01:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746002820; x=1746607620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ps/GlO1XvNY/W7BO10G7AD+oWxCe2mK1nHWx1SJsW+4=;
        b=z8fxuge+hR2OVuksWIz7AdhAMDMc9PyK93b7VA4uTYAQ2D5gL6SaoaoK8NnCutElXT
         cd+Gu4ofvdGXSUOXXXhyCsNIvMZ+8oa4NCRtwBxG1hDMWBov1VaDO32gRGeVfdvGAJS6
         rNJLy76dkqS/Ms+Kug+U+06OxPmuDlQcEWJMHSiG8P4ZmnDGQ5KKZdSVbwIDbS5xsvoB
         M0h9ho5EgMS2vmpp7OgQ1GgJKcyp2NMCDUIxPjCFdEfiVhCOkWH3NhlbmfUHIW8YHiCf
         imRFfXRWkRdobA9lM7ac5Rq1aigs7yFLYqHzwSmWjiNa9tGT0Q6sCHjFxAcpyuEQ9Uxf
         qjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746002820; x=1746607620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ps/GlO1XvNY/W7BO10G7AD+oWxCe2mK1nHWx1SJsW+4=;
        b=KUpGcxWCw1fkwgejsjF5qhEkG7KIRQMj2r0Xzzc7egVEFMpnSwC9Tq6pcK12IcBESI
         nBTzGE6bfX0i//550XR8Z5bo4XvytglDIPa8rlw5VpebQ3BpKtD1Jupkb1dDgl2m+qHb
         w5XSW4ZMmQM8+gG7dkXZAK2ZC6KHVYQyrlDCcdFHbziU+hWtUyTGk89OZ2AfCsoYPZb+
         qXgWrb5FvxVFCfJK1WJflRkPyfR/5cHMiaoACY+YhCdYGcIO/YYQT4IDa/krT50sNT65
         LxhMVTqYtyrcNOWlJNWM/QuqsTrNFKEKUmuv9cbLhQL0R36B5XvkbP3WYosXu02hKe9d
         9T0A==
X-Forwarded-Encrypted: i=1; AJvYcCWP5Hsg01XfhAAOE+r3Tcgxte53zoo7lFjuLw5akdOBjPCOaNSF3b4+5lznjD7/eCVfxgZ9Af0Rsw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yytn+369nMmCiJ7TG0UrnEc4Tm3Z+wfL8Z6arh9KRO8TXqEwyHr
	KvMcK+7Yeg4ymPt8PC8diycjlA6TY5nTXwqOwfKRYmMhWxZYL+7OiFlK6K1sRm8=
X-Gm-Gg: ASbGncvk+8pnJnLjyzyarCLo61+ojHHcntM4cb5+1iVoNb1TgA4r5A1ciW/gg2TH0uk
	XlCwDXhmdo7PInI2cHVl5pt7hrkn6M1DV4hGK4RmvnKCU3mtrIs/TXIlp8UI29nAwph7wNOHx7X
	osW/hS/1hNWx93XTYhujwsgZ4Df+mnXCyIqpJC8HClAJ+AD8MWiwZOd78x/tq/i+aG1/0sibFeK
	y5w6XxLgSRWHDrUrDIsaeHsbA0+RTCZ+4yJkDhHOKBvp8dzfFTUh6ASoV6GgR7+YiQcbkX+9JIi
	p5yFyCb1o6n18PHzvK/9iO5uFhtKeh1/UI/PZr5o8g==
X-Google-Smtp-Source: AGHT+IE71Ft93uGd7KPOG74PkFqMkkrdRnPcFWUsK9xk65jelbG+5UbR6p6ZpkO97gGUVEbhaAbNzg==
X-Received: by 2002:a17:90b:2747:b0:308:5273:4dee with SMTP id 98e67ed59e1d1-30a3330d535mr3768179a91.15.1746002819741;
        Wed, 30 Apr 2025 01:46:59 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a349fff9bsm1023758a91.18.2025.04.30.01.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 01:46:59 -0700 (PDT)
Date: Wed, 30 Apr 2025 14:16:56 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] OPP: core: Fix loop in dev_pm_opp_sync_regulators()
Message-ID: <20250430084656.otga5l6nv3u5frug@vireshk-i7>
References: <aBHaOOE8xHTsMap2@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBHaOOE8xHTsMap2@stanley.mountain>

On 30-04-25, 11:07, Dan Carpenter wrote:
> We accidentally deleted the if statement in this loop during a cleanup.
> Add it back.
> 
> Fixes: 5330d0dab736 ("OPP: Define and use scope-based cleanup helpers")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/opp/core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index fc9874946453..f56ddae35ef2 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2889,7 +2889,7 @@ int dev_pm_opp_sync_regulators(struct device *dev)
>  {
>  	struct opp_table *opp_table __free(put_opp_table);
>  	struct regulator *reg;
> -	int i;
> +	int i, ret;
>  
>  	/* Device may not have OPP table */
>  	opp_table = _find_opp_table(dev);
> @@ -2906,7 +2906,9 @@ int dev_pm_opp_sync_regulators(struct device *dev)
>  
>  	for (i = 0; i < opp_table->regulator_count; i++) {
>  		reg = opp_table->regulators[i];
> -		return regulator_sync_voltage(reg);
> +		ret = regulator_sync_voltage(reg);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	return 0;

Ahh, thanks for the fix Dan. I have folded this in the original patch
itself.

-- 
viresh

