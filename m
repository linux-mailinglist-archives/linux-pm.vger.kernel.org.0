Return-Path: <linux-pm+bounces-33600-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 979B5B3F4A3
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 07:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 618902000EC
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 05:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0980F2E1C5C;
	Tue,  2 Sep 2025 05:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WitTSfwG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFB81E5B71
	for <linux-pm@vger.kernel.org>; Tue,  2 Sep 2025 05:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756791615; cv=none; b=ppz/eAKoR3mEmRNUGvwvQuoSNXY/fyIEV2oD3/TlBJkq9DLgdvA++kNiBml6JikXHqCCz5vk/DC8j7304dPsuycX1oyYND7rO7APDj3u5pOvnzsoXK5onW+m2t46tHC4U1WW6aKQlemO5F8iDWoetFRNNHXU9WNiUHhVnDweX6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756791615; c=relaxed/simple;
	bh=8Tn7K5i1isgjo5oamWJLs+4w/BwjVbi7Qfelosp9mko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYa3NxctBC3QwMLzzDl9Brt3sXMyDCFMA38c2SfsbeHsNCVzWE9qo7xUdgLTa5XFgfoRwgeZEIzuTW1hftHp+HUFcrjJeZltNIMYx4Iw860oqrX2nDOtngfNU2MLsBf7ZaI4lJ6zh5hextDn9StLmzNAmhwBCffOTo/E7Gw4zf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WitTSfwG; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7722f8cf9adso3370743b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 01 Sep 2025 22:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756791612; x=1757396412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7CgLt7RIUR4eCRkWKk0fzd+AGBm8SmxIJSCNeFZDeGc=;
        b=WitTSfwGT3Yr34GNcUah1ae/5J+7wiflLbNWZvvqpxvUHei+LNCSNJCG8kihW5L7x1
         olO70+BCNZydBNHcOMvFMtSVej2CCivhkHl9VKZd5EDLJ8rQJLeRl7+qfUEeZ+G8wv1M
         xFWqZKnjj42W9HZihrPBpu9gHIz0m7QJO2ZR1SG2NUoiIz0z5WMjVNxQjHqW12TD0R8G
         t275lieZQJT7wswVxt5zQVOxe9EcXkNvST34E/onR2M/KJzbLAdOz1ObEJVT59c4Pw7h
         u3TpMA6yOh2fRP2G5F0rIcmF7euR5bqWCRggAK67bhA9hA/FtMS7t+3c4UybBRsRCHCz
         QS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756791612; x=1757396412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CgLt7RIUR4eCRkWKk0fzd+AGBm8SmxIJSCNeFZDeGc=;
        b=qvrYGPdXWi41JoKNjoTxfVBVxsvSDsh6YvraBVdeIfDnMnSPR7gBGWc/O/02HAvbsI
         9jehwrrmmB+KxHLya00MySYDwCKJnPzjGjHq0kwNTwRyRW1eKeBh9cR0Ez2oorviOP2U
         3wIykeRBteRrPFvMTLkRDl02FVA/CwCgYMAxJZHJ7d1nQig20eo51sGe3u3QLUP1OWhj
         FHgj5OaoggaycEVWqwFKhhaxV5sDrWhJKrjeaZZ3iThMU0kvgOFzXtRKBIhd7kf5B0qj
         Is257Cx1GmotZqMBw7VcJ1rjaL1eZ76dhdce14Y/FAdI8wvxg/hXZr/eVeRKlzWPYoBe
         Nw5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEBlAelPl8PALTdabD7U9AmJwVtE0FyRjkNkHaYiGde4XKP1ShGTWrb89eHsW3hfepXyEbOgbZ4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzantvMqv7YOt/h0+WomTZal+2Emv84McAMJ0qluhBnePkCn/Q0
	JWkgS63bZc73SAPyu+I2Wi+1IGQud+7ddc+BRAWVE26rb4DGJD//m5uVo9o1GVHGf4o=
X-Gm-Gg: ASbGncv3aZYAgnDESPY1kwTX5X9SwtpcseGIP6ZfvCpuKtJVJTvBzTcdt88y+ajeQvF
	GIRqoSn/kORxSU7xEyqFJThPROTKVMyRj3Jnk7PQVfrpgo/wG/Ow6cyd/s7UAJTE16uty0M8Bmd
	ApMWblntI9y+/wIgq3J+kN+VYzrnLrBYYq3pGC2cniGr/ZCuyu3L/h6MUdw2GeewS6lM7Zg6nFT
	CMuJH2pVyxTpJP4SQk9PuTTU/QJcIW/bILrgC2hjoVSRRQGp2l9HcehsSf7jiwv9Ix2JotidMEt
	dNZK/6eZF4Ycbe5hEhhN4unbb7XaMHPK3RPU3XrJODbUyGYujOjd5PUaf9NqxJrXNHbH4bhBtgi
	qUHUCRsWbv/eKekXLf2YDXJA5+VGOHnMeTHA=
X-Google-Smtp-Source: AGHT+IGWJbCBhztTVmd7cwokjocgGM90CqXAfMEUTus4zvpVxidmHRlC8OnM+wteG2mcHiOA8FYJpA==
X-Received: by 2002:a05:6a00:3e04:b0:76e:2eff:7ae9 with SMTP id d2e1a72fcca58-7723e276de4mr11916438b3a.12.1756791612472;
        Mon, 01 Sep 2025 22:40:12 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7726475290esm3157523b3a.98.2025.09.01.22.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 22:40:11 -0700 (PDT)
Date: Tue, 2 Sep 2025 11:10:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] cpufreq: sh: drop redundant freq_table argument
Message-ID: <20250902054009.rhqu4ki3bl4kr5a7@vireshk-i7>
References: <20250901112551.35534-1-zhangzihuan@kylinos.cn>
 <20250901112551.35534-3-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901112551.35534-3-zhangzihuan@kylinos.cn>

On 01-09-25, 19:25, Zihuan Zhang wrote:
> Previously, some cpufreq core helper functions accepted a separate
> 'freq_table' argument even though the frequency table is now stored
> inside struct cpufreq_policy.
> 
> This patch updates all cpufreq core calls to remove the redundant
> argument and use policy directly.
> 
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> ---
>  drivers/cpufreq/sh-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/sh-cpufreq.c b/drivers/cpufreq/sh-cpufreq.c
> index 9c0b01e00508..75d224ba56ba 100644
> --- a/drivers/cpufreq/sh-cpufreq.c
> +++ b/drivers/cpufreq/sh-cpufreq.c
> @@ -93,7 +93,7 @@ static int sh_cpufreq_verify(struct cpufreq_policy_data *policy)
>  
>  	freq_table = cpuclk->nr_freqs ? cpuclk->freq_table : NULL;
>  	if (freq_table)

Instead of above, you can now simply check if policy->freq_table is
valid or not.

> -		return cpufreq_frequency_table_verify(policy, freq_table);
> +		return cpufreq_frequency_table_verify(policy);
>  
>  	cpufreq_verify_within_cpu_limits(policy);
>  
> -- 
> 2.25.1

-- 
viresh

