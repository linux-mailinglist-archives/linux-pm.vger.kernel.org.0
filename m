Return-Path: <linux-pm+bounces-40897-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFF3D225A3
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 05:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2144301E167
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 04:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1CB2BE05F;
	Thu, 15 Jan 2026 04:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wDjuo5Tg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3A01EA7DF
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 04:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768450205; cv=none; b=kSqyEEOq7im+7NXPs3VMnnY+yu9bqidRhEH4zQc6gFLjUw5ioYr0vH3kHmM5QqzXni3XgQL40sobZ8XkmlGln1+uQYwdYCi1hdtLZ2OslWGxef6iAKuWgjdrUJ6AlsFJyVE3Lbhuaz77Fjk76kHVKQqN8pIqPYWtBEqBmxFzo8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768450205; c=relaxed/simple;
	bh=W3YTlyIyTEmUUWUK+ddJl6j1aIj4PqfVfc+lQKZOQC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDckvAsl6RHypMgEdS9rsSJxR1le8c7WE4g3+eFDBAWHJy288SeDk69ILPidpinzwDopXwGTJpgd/yyc+HnFqmPUSikH+iwgzabByPaSk0ZcJIvBTEyMLE3Hl3NVLm91pet4u/Hh1cJhI2lu4FIceQcTCtqskCkiRaxt8wC5OP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wDjuo5Tg; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-81f42a49437so246632b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 20:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768450204; x=1769055004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A5gl3gMVAyOtPUMAz83ngr2tNJpXwKQ2fr+w2KMc5JI=;
        b=wDjuo5TgZWqgeTRb9man7RJKywKBhefT4zNJHXEWAZLV6Ny0G37Ao8a8iacViTWEFu
         RBvlws+vnZR2o0r5v9jCR+2z5/9wqGpWAuTSEmMPldkzvPLmJYEnp7FB6hXtMMqnOntq
         tfB1b70BugX4x5fGW/8Xf/JPnnbU/Tx9lApCabxMAtoK7fAmPcRAAdU/+/TwSmOsEk66
         /bXOBNNAbYuYojCXeZiE/qAFZy9mAQxcvcMMwJozPMbUoOk9frzlEDGxihvLnRlSqRFe
         4ybYuZatPVE14H8B7ns89sStupodf8oZJHQyXj4fDQbzHtsGD1Mcg7LOoHloWT8ZNnuS
         YVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768450204; x=1769055004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5gl3gMVAyOtPUMAz83ngr2tNJpXwKQ2fr+w2KMc5JI=;
        b=VIi5XhRw/hw8ERQNIe8Z6yLbXZYuHhdPMQQ/oZfxkhFwHjUieVxtV/IhyZC/28vsv+
         F142/eNO8GpPTNQIgiZ5NXZCgYqCfdlUWaZyoK75fvfd34qv+s3AiGmvR7kS3C8O5LBn
         QYM7SQWFC2MWlavGPHjzKp8+bV0Af1V3kxRhw6QF29GuL8LQcUJybi2EWjR6VoCLLyYC
         oldXXl+Kl9FNym059UARFsS5+H3BFQtkS2q3dwIISkU0PGxHvRm56DZrhqr7FGrYcQ9p
         rVfkSjmtG3nc9185vPsmrXaINUR7yqbC1Wxtrc1M9dAI6Ds1vm8xdXL0i9AJOpxu6HK7
         LZ8w==
X-Forwarded-Encrypted: i=1; AJvYcCW1Nqmlu8PjayRbij2NuWuU84kc0Z7UmoMqG+F7S0qkwI49PTk+2FEpShc3Wa/LTxSOK2HNzNX4Xg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGD0EbnVOCdGc6Ecxxqcjs5u9LEDQIVYc4fHF/zaFhBuVLVgkk
	uPIGS64XzFC923BiC97PgIEbX90eTZeeIdPfDgYuU0DvMJWRSCGAnLtr6Jd1cVTSQqw=
X-Gm-Gg: AY/fxX7CqEZqDbN5Xr97yZz/Vz4gdfiBM9YnhcKv3YQb7qiwbczxMVMc+AMVq2oh8tx
	e6upRUuSQGUp89ZbJCSt7cmZdq1jCWYqX9Pt4JrtaH5gf7If5yEii+8v1DzN6plgE8WwJQrmnZV
	dq2w4Nr5ppNP53a0QeUxoAClzsyRz9Q7tWZB6XSVIyku/41w6P+WrBuI3axzeYWN5QZjEhS05cG
	6KiGEi1vMSAmUr9bmMo4n/OINDwZJty+B3kc9WOt7NkKNmGPMLOwJj9CYkp4ewb+eRFGNyVH77P
	JHifNjAyclLnNafw4v+OZdR5hMJI9AWuZ21LeBtHqzPOsjLKHV/0a99jZODbfckQ0vmTYRrwQ1H
	KngMiy4jSJeWDM3y+IyjSZ1McfiCwZlYFuf+IQxyQJMSFkI1e28WF1jQSvqAVP73FtkMjBUDr6k
	06ociLWznJg4Q=
X-Received: by 2002:a05:6a00:4008:b0:81f:477d:58da with SMTP id d2e1a72fcca58-81f8200cdb2mr3948607b3a.60.1768450203685;
        Wed, 14 Jan 2026 20:10:03 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f8e4c2293sm1058671b3a.13.2026.01.14.20.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 20:10:02 -0800 (PST)
Date: Thu, 15 Jan 2026 09:40:00 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2] cpufreq: dt-platdev: Block the driver from probing on
 more QC platforms
Message-ID: <zlt6uqucsbbyua65wy5epr6fmjoydoqf7sub7idkijb3meccq7@53vuidepfvyg>
References: <20260113-topic-cpufreq_block-v2-1-537cc7f06866@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113-topic-cpufreq_block-v2-1-537cc7f06866@oss.qualcomm.com>

On 13-01-26, 16:25, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Add a number of QC platforms to the blocklist, they all use either the
> qcom-cpufreq-hw driver.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
> Changes in v2:
> - Drop entries associated with scmi-cpufreq (no OPP table => wont probe anyway)
> - Add SM7125
> - Link to v1: https://lore.kernel.org/r/20260113-topic-cpufreq_block-v1-1-91f27df19028@oss.qualcomm.com
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied. Thanks.

-- 
viresh

