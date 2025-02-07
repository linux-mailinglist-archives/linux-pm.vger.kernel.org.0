Return-Path: <linux-pm+bounces-21522-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3945A2BA15
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 05:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D5BE3A3FA2
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 04:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D906C1DE2AE;
	Fri,  7 Feb 2025 04:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xA6j1h3H"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBBC2417CA
	for <linux-pm@vger.kernel.org>; Fri,  7 Feb 2025 04:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738901819; cv=none; b=E+i7DYOG/lo21wf2fzpNAQa5Mz2qe31XR09No+TAwtoCWPa1ilOEuDhaqyJ9ON10ydyBMEzQtKfAaFneh8+clm3TuTmG2jzCeGSc5I0LeEhgykj0C90aI8O2FsRCoyJWuJCzCc3y2mulXjOx5taHwk0jb11iHUAcrXQw74b5Il0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738901819; c=relaxed/simple;
	bh=tJr/h/82XdaXhwtSYvOC9IfBxa/rDwuLDiIbbM4xvQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZEJfl3yD2YMLM84R9jw0jFRWT6dOFzKm2hHeQBBcq3ri9QEWs5eD+iFMnBaoNm6aTjY6g4k1z2Y3O9+khgOF9KKSvs8Z84IdALfYVqm/h86I/J/MxlI3q9ovfzWAyWKKTxR4Yg38ZfsAwss0cy7PV22MPBSSxMlA91/ZzIgLjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xA6j1h3H; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21634338cfdso39711245ad.2
        for <linux-pm@vger.kernel.org>; Thu, 06 Feb 2025 20:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738901817; x=1739506617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/PGwJeZbBL1as/rhK6k6WMBCNMpCiV74c6vEaEy0GrI=;
        b=xA6j1h3H/httufssY6b4/X1F+Qpk5vIUBon0ZkL3IWRQyGy/D9eZqsVCOzkoOoyter
         w07qSgDW4QavsH9MR8Suh7sxC2yU+RGRFd3tbOma8NvMbqTJ2y5k4UM+1j9ZyRHChZoN
         UNob+yBh/APsoeV9SULkwEv6er8d6PChTZrktOUkzcbEpfGlSk9nUruzUduUrk/wMNl1
         kfTV5fVfboukqWWmeE1iRRBUbZ7T/X3tjmfPBbz/6Cr3z8nZOg7C7kX/FqUdQ3jHKC2C
         cebLnRx6aubrLxmfJu24uV5EudeRw3yw1AkR+/DfM1MSen5S+XTiPfZh6JyMfVgYzopG
         YzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738901817; x=1739506617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PGwJeZbBL1as/rhK6k6WMBCNMpCiV74c6vEaEy0GrI=;
        b=bcV4ycmJklZzYkFc/Qqe5Xw47vd9tUO4xsJAsxHilOKQcTqPnYAVN2+bU6qML4hxwu
         j219KQgmuFmVpcmD0QD4N/71GwDbOs+91QZzelXg+P7z9mSD6DI95AJ+6fZhoc0TxndL
         A99LfWYSq3PJIh1snFnVxvNU848Vya1i9T++Ux3kw7OBmoYbGT5+qZ+oy1TivW1z0rZY
         cwXR6CJtHnZgW88BpsbE2VFpGEGmyuo8hEaHdK+GfAybk/+u6cikaQQ0s77Il+XFim3o
         WEiyTH6n3BGhQl0yFB1LwFdyQpba1f5uX+kdwX4ddBgGShdWi11U6E0LC3Uesk954rUf
         9olQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYayPf7ek4QhGb/0FPllHAXCQGknipvcuLCTeeWQPusq5JNiHjEQ9anybIKMD9idZekG+m0eg4Sw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjFdjs0+MteDqysjlRh3xuc0adledfulQl1jEPKyne5VUppUta
	nm1XUNj2s17mlJ468t6UxYsGxSKafuonp+S+vPIAEO/w5htsMmjcNd7qL9itUNYRk281BTZHX66
	V
X-Gm-Gg: ASbGncsOjXgmQzGwba9AkwAZFwkdtYI5jHqEZE2VBT8SnQF53Rs4aeyMwk1pxpuxrph
	Kg8MmGSidM9esyDax4diww/mxok5QPxlkZ3EhVeXV54cmcxikH88EQuIzXee1urpyaHJYTvJbnO
	PfYya5lXrPW2vBTiFIuUWMx3SK+8+KfbzIl70Xt1Nsu46v5DaC/bmDad2TRkxI/ulR0yqRMlrTs
	X0xhQWr+sM5ByyIdFPhtf1PDK+vtSZiFhuIZbCdJdOmRATtdgU9GXt0yl+i4CMabzueVgFmtR1n
	lSNyLbURkRsRuAsXxA==
X-Google-Smtp-Source: AGHT+IEaLCJ/CIOckb+5DvHUOnJDGJC8wnrzMC5q0EsvjDFp+53jkrTnbvgOr5BU0EJtP7/tyv+yvQ==
X-Received: by 2002:a17:903:2987:b0:216:2e6d:babd with SMTP id d9443c01a7336-21f4e6a99acmr27767115ad.15.1738901817366;
        Thu, 06 Feb 2025 20:16:57 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51aecd846sm1791664a12.30.2025.02.06.20.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 20:16:56 -0800 (PST)
Date: Fri, 7 Feb 2025 09:46:54 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com,
	lihuisong@huawei.com, fanghao11@huawei.com
Subject: Re: [PATCH] cpufreq: Use str_enable_disable() helper
Message-ID: <20250207041654.62xollzzkehl6rjk@vireshk-i7>
References: <20250207035953.2420053-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207035953.2420053-1-zhenglifeng1@huawei.com>

On 07-02-25, 11:59, Lifeng Zheng wrote:
> Commit f994c1cb6c43 ("cpufreq: Use str_enable_disable()-like helpers") has
> already introduced helpers from string_choices.h and replaced ternary
> syntax with it. Use str_enable_disable() helper in this line to stay
> consistent.
> 
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 30ffbddc7ece..a12e1da89163 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1578,7 +1578,7 @@ static int cpufreq_online(unsigned int cpu)
>  		if (ret) {
>  			/* If the set_boost fails, the online operation is not affected */
>  			pr_info("%s: CPU%d: Cannot %s BOOST\n", __func__, policy->cpu,
> -				policy->boost_enabled ? "enable" : "disable");
> +				str_enable_disable(policy->boost_enabled));
>  			policy->boost_enabled = !policy->boost_enabled;
>  		}
>  	}

Applied, thanks.

Rafael, I have picked this since I am carrying other boost related
changes via my series. Please let me know if you want to pick it up
for rc.

-- 
viresh

