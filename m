Return-Path: <linux-pm+bounces-17292-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9021B9C3733
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 04:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1ECB1F21F13
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 03:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA6814831C;
	Mon, 11 Nov 2024 03:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T23cpb8h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB31F139578
	for <linux-pm@vger.kernel.org>; Mon, 11 Nov 2024 03:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731297489; cv=none; b=CDw5eS8pH/f3uGT79yYt/XPAnTSQyceu13a6mIGZvqYsqPskhJkPMK+nwAAWb6ihjQLWCAT2tjs99BDmxJYMHpF7K+2wGE7AAWomLfC6DxGoK56ASozIkTbMhCpWCdD5xtoMoz+OcyQcrVw2G8n36nLIyY8MoD9s1ECmfuxAAKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731297489; c=relaxed/simple;
	bh=8Uh0uUSImmTy+qzL1Iu5nFKpjUikB4VJwYS9Y1E24Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSBvt59bCKEbZlduelqq/snNhBZtMLiKlhiDlJJnDuuafSLG/4XOBn1gakwb8BD4Ihh8ktkoARbpYdgkDLOUryCOlBKGppXJXNQLGkSkkVhYHYZ3oJ55oOY/nA3zhBjZHoodUi63hByLHp5n8J6IWguOBsk2GGLpev4WS0jYSq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T23cpb8h; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c6f492d2dso44423485ad.0
        for <linux-pm@vger.kernel.org>; Sun, 10 Nov 2024 19:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731297487; x=1731902287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mtCdbHmWUy1kL6nMDSsqmJyY6FPNtwwaaMfxqv080TQ=;
        b=T23cpb8hCxRHnPGY1md6pDjQshB7NjXu60JdGebh540bQ/4e/lvDmPlMIYucrzIrW3
         ZM0rUIRCcnV2EkKhPbJ334K7ZaWoiON0WO3ThAgG1V4AIP7obA3vrPurmZR4oWo3AAQ5
         /PNl2Ucgd8tTYgyJDmazn9xJtA3zKaGTHW44xtP8lPxWkVhcACAlHNmj6m7/GtwihliH
         MjlT5CpOnUh1S3/VBDG2OA3jMZSpYOj49WHhHwjV3xDY1B0gR3RDKU0wnLwemQA2v3G5
         GcMdNr8VErfLJc2ND5qMHyjVrybkDOM+D0djOQHDpZQN8di/f4arcJPwn4YRqMuGdtPf
         GKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731297487; x=1731902287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtCdbHmWUy1kL6nMDSsqmJyY6FPNtwwaaMfxqv080TQ=;
        b=XsxoKukQ30cVvgLj2DhNKsq8AdWD/V9Q44rn6Ll2iq4RmuwJAHXI8KjwEtk4NzBfGY
         muhykH/icXjj4m/kYXgDOGS70rkjqidKCa1zeDX7SFE4SA6J5/t5o1cnxWtniMwHKY/x
         2zjL4DvrV5iuyPsMbFZQPFLounmyfkvI5GPY0a3TCbcSeeFJCyzaHkEnsIxNyMmZqP88
         Tx6qe2IfwYxdetdhdiLhYg+dXVK+G7Ax3g93UwAlmB05sBxd6xinEhbBBTbS+VW6OfF+
         I+bCgbDd7ccxjYVi99q8oac+ELAEoVX0eiufhxvg6I0bS9foAVjXQjdaIOkzVkTLgKCq
         uNxg==
X-Forwarded-Encrypted: i=1; AJvYcCXlTqd7k/cUimgJaik/rrlRTIxX6OoxJiVztm7LdGcDMjKs7fCkjwaYnEYE8alTIS9p+Nkc+1pVTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWiIpGvYgx2JgAh4kQoNn8xD10MoK8JcUglsN0LTsUxrck1H3F
	ck/9LRO7+GA5kU69VcQ/m3Q60iVFtfxIVqbLcUVen54swCc3GeJy9D3nGa6V/lc=
X-Google-Smtp-Source: AGHT+IHPAn0saGccs4AgqLf8m0L9+JHHSw7AZDB4NvdRcyZctr50eyoVzjWGg/yZrgu0QilvtBenig==
X-Received: by 2002:a17:902:f641:b0:20b:58f2:e1a0 with SMTP id d9443c01a7336-2118350b048mr170353675ad.18.1731297487182;
        Sun, 10 Nov 2024 19:58:07 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc826fsm66579705ad.11.2024.11.10.19.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 19:58:06 -0800 (PST)
Date: Mon, 11 Nov 2024 09:28:04 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: chenhuacai@kernel.org, kernel@xen0n.name, rafael@kernel.org,
	zhoubinbin@loongson.cn, loongarch@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: loongson3: Check error for devm_mutex_init()
Message-ID: <20241111035804.zc3gwtg5ms3bz34h@vireshk-i7>
References: <20241105032053.1782082-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105032053.1782082-1-ruanjinjie@huawei.com>

On 05-11-24, 11:20, Jinjie Ruan wrote:
> devm_mutex_init() may return error, and the avoidance of checking
> the error code from devm_mutex_init() call diminishes the point of
> using devm variant of it. Add the missed check.
> 
> Fixes: ccf51454145b ("cpufreq: Add Loongson-3 CPUFreq driver support")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/cpufreq/loongson3_cpufreq.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loongson3_cpufreq.c
> index 6b5e6798d9a2..a923e196ec86 100644
> --- a/drivers/cpufreq/loongson3_cpufreq.c
> +++ b/drivers/cpufreq/loongson3_cpufreq.c
> @@ -346,8 +346,11 @@ static int loongson3_cpufreq_probe(struct platform_device *pdev)
>  {
>  	int i, ret;
>  
> -	for (i = 0; i < MAX_PACKAGES; i++)
> -		devm_mutex_init(&pdev->dev, &cpufreq_mutex[i]);
> +	for (i = 0; i < MAX_PACKAGES; i++) {
> +		ret = devm_mutex_init(&pdev->dev, &cpufreq_mutex[i]);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	ret = do_service_request(0, 0, CMD_GET_VERSION, 0, 0);
>  	if (ret <= 0)

Applied. Thanks.

-- 
viresh

