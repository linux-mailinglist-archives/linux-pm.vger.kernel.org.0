Return-Path: <linux-pm+bounces-25070-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B76A837E5
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 06:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1F1E465799
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 04:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6ED1EF080;
	Thu, 10 Apr 2025 04:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ukcsbc1t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5111CAA80
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 04:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744259868; cv=none; b=g0PfzSvCRvvT9gTGkOGgdzkTBQ2qOAs4nU7oWzi/FrVG2WN2TrqOqeZW+sHY5skvj5UT+gYM3nlvx4cBQuuXICfkd/NPGNuUK0VQ0nVkRfHrzIB9RoBDGibUnjRh3jQ2Css9YbA9EgP68xuQwdc4ug8N9sHQCyAdOcPl/4V1jJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744259868; c=relaxed/simple;
	bh=1Xix/mO6aE19SIT5lyF30wlU6UXfyC7ZaeE7p6sIKzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPB5m6Ecdb2dW9H2sSaWvDIFl+kzMzy2qp26R6Y98EuzBcG9wjdJap9zcf/JuAEuRsbDZHTjL1fVTUUIvlcFr7HYhAh+bySBIQDWEeVdEMi+5Llt7qc/l6GLozOC7UoWFs8pzZ/Xy0rlvaod/fdYnLqm33sePnh7HCEWAnGN+Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ukcsbc1t; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-73712952e1cso299248b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Apr 2025 21:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744259866; x=1744864666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dKq9kzMYsicKdtkGA5MBDLw3TZIwxRLfS0ALUoxDg9c=;
        b=Ukcsbc1tJEjKUe37Yx1xWKCw7+bC/ztgqwJNZQJ+1jbpQslcw0z9jssFrlYsPjjanl
         MLLpd8JiGo0pc+zsrM1mI+G/wr5a2d2m2rGNOfUPlUNGt/BncCB+61oyl1R3LjHcicj7
         IqAesfPeTDSSdbku0Zzhgk0uYwK8ry/mjOq0NXLIUXqw3OqzQwj90F1V+nN7JT3Azm5B
         bsCCbopKRDKJ4InUXWJ6ZSU/gQm3TukuX84BQFHqLhb4E+6+4C0UmAEXjoYMCyEInAOy
         fn/CNmfGwEbfklAtntQC8zSxS0kCtedjnWU3UmzFFzWwFU7MzVxedWvLvwgbhVwBlf50
         61SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744259866; x=1744864666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKq9kzMYsicKdtkGA5MBDLw3TZIwxRLfS0ALUoxDg9c=;
        b=pqtArCP4Bdb5Rvz6zpl8ne9d84MTMMGP0fbUnL39nAoJ2ZNE5nI6TnDMQjUg0tSfA2
         OeU9WyaaQbVcYVU88ca4ES8jAe4Pxf5XLXaJn/LP550Wx3Tz2/VWHDnd6HCQH62BAFTM
         pw1p93J1Bke4i1FmSzHhyhBEmkGvspWmxFShptjgz/BR7Q/K72Xmmaym59Z5VHe09JYU
         G2DngaHVCxHgRygH5XxNfgO+y+IDRSIw20CaIlPs69mZyx1dcdThd1FVnI8kKo28/ySV
         B1F0n4l+YkNHWOfWcLECHdW6mb2c1Pb5g8gyuiMR8Y7b4YktKpEqiZxHRD88Hckx9aac
         I/hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbPk8gtvrPQHmwrzb7p+j5DJIG8EknbwBWNhqiKODlQsGpIJU05oZvQBD0ofTAMtfRyPTmdgj4Dw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz53ztL+9qLUiWN2XsUE8ISaMtNo2hIoxbRcO3UwGz5Wf/QPw5J
	ZXvejGMDXgqNxDygWrZa4RWMfp55j+TchdBBfcjjx65gmAioRoyJAHfdvMMEXNM=
X-Gm-Gg: ASbGncsgIrzGwrzHwSheFKdYScwvPDzOujdLC9Nt8qQQzCfzV50tX+S6yUMQ/KX5YcX
	4rr3N6TlOOC/BmDCOTrdLo20LKUN5ih5aemCTgc2iKYQsUewyZwWIV4ygoE22O6Njx6522QQaMM
	ViFajhdFxQAFhvHvFpuEa/sThk57hT15g1tgTUHlSdtVctJ0nxxhcVCAa7Zo3p2Q2RmpQsdqmQb
	jZzlWEbrgS9EogFPXJFHGPDvuePr1HxvB4FLi46FeKZ4uzgiIpnuKehQE15Gic1GELgMnbQbZmL
	O6/0AmukRYi52G0Ea8GOL4AHy+iBYsOuK318YX3FGA==
X-Google-Smtp-Source: AGHT+IE5WApQf0idcPfilUjF6fBUp39jssoyHNZPfC/qpfeRdr8GHZIk0YeghJmMBYI3ABubgqhHhA==
X-Received: by 2002:a05:6a20:d528:b0:1f5:9069:e563 with SMTP id adf61e73a8af0-201694cef6fmr2822217637.21.1744259866440;
        Wed, 09 Apr 2025 21:37:46 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1e3842dsm2345076b3a.108.2025.04.09.21.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 21:37:45 -0700 (PDT)
Date: Thu, 10 Apr 2025 10:07:43 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: sven@svenpeter.dev, j@jannau.net, alyssa@rosenzweig.io, neal@gompa.dev,
	rafael@kernel.org, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: apple-soc: Fix null-ptr-deref in
 apple_soc_cpufreq_get_rate()
Message-ID: <20250410043743.rxwixe7slr342d56@vireshk-i7>
References: <20250409124813.47193-1-bsdhenrymartin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409124813.47193-1-bsdhenrymartin@gmail.com>

On 09-04-25, 20:48, Henry Martin wrote:
> cpufreq_cpu_get_raw() can return NULL when the target CPU is not present
> in the policy->cpus mask. apple_soc_cpufreq_get_rate() does not check
> for this case, which results in a NULL pointer dereference.
> 
> Fixes: 6286bbb40576 ("cpufreq: apple-soc: Add new driver to control Apple SoC CPU P-states")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
> V1 -> V2: Use `if (unlikely(!policy))` instead of `if (!policy)`
> 
>  drivers/cpufreq/apple-soc-cpufreq.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Applied. Thanks.

-- 
viresh

