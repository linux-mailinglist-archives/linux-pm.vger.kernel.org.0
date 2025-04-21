Return-Path: <linux-pm+bounces-25800-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF75A94FA2
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 12:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877063B33E5
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 10:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DB92620C6;
	Mon, 21 Apr 2025 10:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YzCMSwCo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E275126139A
	for <linux-pm@vger.kernel.org>; Mon, 21 Apr 2025 10:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745233014; cv=none; b=oxxY/UzaAfmddtoHkWdbu8zIs37HuBuuB4tSXu5awGsNDX275ElkO4ke9AGwYAzeeMEX0riXyi/Uv4okuLU1pXPll+aC0A8wMAg8lyRfez3iRx5PgdO3N0Vli7JR0m6++3vXrfdtEapMSrLjTh2+3t3lYX5I3Qwe+2pa1pgRl30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745233014; c=relaxed/simple;
	bh=dFtUabfKRAAvW3M57Y2XYLhbkoWV/xW0t/A/tPJhfWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4x/D6Flxadz8nJ4hTN2z2iCKrqdkge4jLmAN57t77zEctuLdn5mbPRkZMnPxFEo2WoQ9Uc4mqHTghuKeQlNaHNWyEwWuBS1rCewWFNr56XWAooaCgiA+LevKoYQcxBL8wkzstVTWk8TBbr6TE/3DqRSGl8Fp9ULxVvgk7taDS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YzCMSwCo; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22928d629faso37329145ad.3
        for <linux-pm@vger.kernel.org>; Mon, 21 Apr 2025 03:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745233012; x=1745837812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4JOjjs/eTu6BI/Opf5A56OhMZjn4Z0iGykFeuQ+2ztA=;
        b=YzCMSwCocFe3W439FJIscVBnSPun2NsIOKjGKfmr+947evOncKJEi/dIqt0A6pVUqz
         ZNdFj4e2poSSnikA92L9xVTxKA7j7vgmbkIljIMKi6bQ2hjr5NbhbUWzIExRSLFCyuT4
         Ac6U9lJf9mtMoner4ERbvZCyLe6ryoPUyoLNM9YbRtZS9fbVGZVffiAItfIx+RR9DaR5
         AMr76ZI+Qzo3Fj9osVJWQSF7Dc4rSBnJ1VGC2lWpeGumXLLS57Nk0c+YXmSHC0xVse3H
         /xcsNPZcW0RhEIKqdHZcb7eVK6PGuPh71swhBrTuuc/K1YM3JkFtlib3nZ+WsHwykMNp
         2QzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745233012; x=1745837812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JOjjs/eTu6BI/Opf5A56OhMZjn4Z0iGykFeuQ+2ztA=;
        b=rWBft3A41E0MKZaBeJUWbFsT9jidv55BslgvFZOM/odugL748dYnrV2PstS7fYJlUD
         F+D9ZtqjcjCeowNg5ca8K4oDgCMe+AZ+rd7ST1X34eepUGUZfdc7hLt82j5usYulqq9V
         LYNtSpJfX6y28lD1wiNFicjuGtOt1x/1RPgIECrcAmuSxX14hH52LZicK9NUh1TxkW12
         Icr8DrJzo5Dk5RDvcyB1xAi6I5Lvldefy9K4iu+he2l8C0IkFruBc8ChPGmRaLjeEMkN
         8ywHhNa1X0hoSwXoGTzYfxT5coWhZ3jrpTCU5IDE7GzrL2UonljPwxS6CIbJoNGXnRaA
         s+HA==
X-Forwarded-Encrypted: i=1; AJvYcCVX4KN13QEEzVEkt9msg0IUgQx3sMTzwXRVJMFeBlaQlr/Ox/ROr8OSUHFZDy6Cu3e3LEDMXivJeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YymwxOex0V7+4boLTbjc7Q4wzfKCbtuUuGsgbo25lI/VbHwXC/3
	GdQSpU1WOAsEFS/JwueJBE+pWa6U1TDpaWFc8RDt/7myHhedT5JoWH1HprzcQH8=
X-Gm-Gg: ASbGncsgCujmhvLo16fad9eUN3ogBmQqrFPMiMDjup8UDHrLMYSRMuO2wCDU7Wl1OOk
	CXgQCnye8wR5t89RgafQxELO71AXLH1ayDvLUMzcNO+/UwE7K8C8cvGHXcIJxu+43BQfnuj4K88
	ChxL211duMdKJuLJoaGJUtYkxVi6xmUwF788Adf/uTy4zxDQ39dSJcu+apKliaTAxandztjRVFu
	wVBdNMwYxMW7GWSsCzFeC7E+rquiqC8MuoMFyXT4gi7nGrbfs4/KXEJ8R8AnwExQpnemHu/wyS5
	pip8uFrr4YWbuaKf9t/C5YhQ9D/xBdptxZg1uG0pYw==
X-Google-Smtp-Source: AGHT+IEEJ39NGYkYIENofGn5suL4OvuuiPwgjONjMHmL2nMj73P7QiaKLxsJqccgMDffLqh52LWmCg==
X-Received: by 2002:a17:902:f788:b0:223:4816:3e9e with SMTP id d9443c01a7336-22c5357ecfamr153311135ad.13.1745233012094;
        Mon, 21 Apr 2025 03:56:52 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bda75asm62750465ad.18.2025.04.21.03.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 03:56:51 -0700 (PDT)
Date: Mon, 21 Apr 2025 16:26:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: webgeek1234@gmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 1/2] cpufreq: tegra124: Remove use of disable_cpufreq
Message-ID: <20250421105649.g4xpkimbu6q77fxq@vireshk-i7>
References: <20250421-tegra124-cpufreq-v2-0-2f148cefa418@gmail.com>
 <20250421-tegra124-cpufreq-v2-1-2f148cefa418@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421-tegra124-cpufreq-v2-1-2f148cefa418@gmail.com>

On 21-04-25, 03:13, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
> 
> Instead, unregister the cpufreq device for this fatal fail case.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  drivers/cpufreq/tegra124-cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
> index 514146d98bca2d8aa59980a14dff3487cd8045f6..dc83b1631b13ec428f3b6bbea89462448a62adb4 100644
> --- a/drivers/cpufreq/tegra124-cpufreq.c
> +++ b/drivers/cpufreq/tegra124-cpufreq.c
> @@ -168,7 +168,8 @@ static int __maybe_unused tegra124_cpufreq_resume(struct device *dev)
>  disable_dfll:
>  	clk_disable_unprepare(priv->dfll_clk);
>  disable_cpufreq:
> -	disable_cpufreq();
> +	if (!IS_ERR(priv->cpufreq_dt_pdev))
> +		platform_device_unregister(priv->cpufreq_dt_pdev);

What if someone tries to remove the module after this ? Won't we try
this again ? Shouldn't we set the cpufreq_dt_pdev to some sort of
error to skip doing that ?

-- 
viresh

