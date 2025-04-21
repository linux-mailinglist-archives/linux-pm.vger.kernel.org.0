Return-Path: <linux-pm+bounces-25801-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB1EA94FAD
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 12:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57E341893F90
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 10:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F84C2620D1;
	Mon, 21 Apr 2025 10:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RkJTbKkn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83D6261571
	for <linux-pm@vger.kernel.org>; Mon, 21 Apr 2025 10:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745233128; cv=none; b=Mgjkc6LW3mahvGJWD3DOT+5kdbArssu8LJHQalOfllpGIh2x/C0T2qUTcGlankfMnLYRA5Qx1ejKcT/OPGRIBAEDrmCc26XkRH9Iuwd7Vwgi4cKO9NUNUuwCJX6MOnup54abqlcYhtu/2v+ptlIApVIHX6ixFHTxhJLs5Eh8cjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745233128; c=relaxed/simple;
	bh=+0MPd8esne8GaOhQJYv1aLbJ4MXyJXAMmqMo9igC/ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljdr+axpyaRBnDocz/OkGbCcQcVQ2kvNNsmPrDv8GUNIe4jeQcAUFWnhuAyFy34xrVwOBkvfx3iQzekeJaOej+gU/Fnglmx9KPTxWAdTWPX7oqO36R9aEvT1DPuP3brcAor0fZt+/AQms7VmngmPnGK1CPRblmEFs0r5r9iD/k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RkJTbKkn; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-73bf5aa95e7so3409357b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 21 Apr 2025 03:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745233126; x=1745837926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dpDL9p5aNgl91SCF05ObEwkxd9LU8WN2T/wRhZzS9wU=;
        b=RkJTbKknn+OJkRXkhxi+24SSWhGhhTWC5dOH0ICKcBwEzdgiIBG33IRTOn18OTDpBu
         t44k/Iu2Fi1EJDKL/sOW8ZR2zqA9shDMHuAvszo1GuxK6Ipbj7e30Q3kjF+i+ZZpYceN
         Y8SZkLa+vZkuZt/D85CLsf8jZ7tfIbADa3J2QV12BumEMwTNBtkfPbYhd9V8j2Mlothm
         4sD/zRJm5xByvUezokhR+oWG4S+yyUr0aufGqILchc7r6DeAFhlGdUyb9fhjtWrcH2Zu
         Ysy11plHAQxnC7yZWUi/oTaipJbKGRQt3pwIlSXmQn63LQaidN4NVRaFPQNKulGv+h21
         xzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745233126; x=1745837926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpDL9p5aNgl91SCF05ObEwkxd9LU8WN2T/wRhZzS9wU=;
        b=dmKMwsLWrGKPTtUBWRGsCGTDJhf4zfvNtYQ+PdYwle2xtcOzOMBnOB5Cf3N481YJ6R
         Q/R2PaKLFBuxbhpcdXermCMiWOBVEygeNQpairE96G4KlXjy6U4JTKriDqDsDzLIQE6n
         rvd6+w/8AtyArG+WBNuSsDnDGVhE1/eFybX4t9t0QLkqWspcwC1mWZ3vdQy+e4xZd+QA
         GZx6dYTy85V3j+PmE8koO6KXtgLBZ0te0PsT1zJCiX58oO9w+XgFcrK3LwKxyV1MbFM6
         5HMsaMtqazPary+SixYsPhMpfqcPzbX9lMJ2Sjc0N4V+YJ8eAWOJgeBuJv0YnMmNpAYr
         1nyg==
X-Forwarded-Encrypted: i=1; AJvYcCWXf1Bpqm9GO1l44RWDzM2gyr5cErRLmyPpqYa3dewtmBsK0ahavHb9Fh+IzUhWRPiMsQ8gg3kIcw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXJMt3T8vHSCKB+QkPnENF/awHUvYdpl+q4Kjwhv+zCE2Uezue
	kPBe9mNmtipyRN6Av95Sksrjz8TA2lksznh202pb7EdYwDvgzEhhuYfKyOSKh0rPbmozI/j8ews
	I
X-Gm-Gg: ASbGncuPDVecTia3GDplgcbqTVmDaMK9M8+sHMkKiZlBiDnY7nNKssLRG9GDayixHb8
	pnKPG1zo7oJoNOXzKw8z9fCB3o1Cf1PEjVwhShlvUiS0j2LI8qd15K/LZDleauZh2XApr1a/2+Q
	fmjhWIKEYW+GhGS/dBmjuXCWw0L4NMwSEs41odzeBk8LhiQFmJj4BW2BGPdm7X1v58Z3G2HWyVt
	9IXSE9s3mOp/VMb/A1IBUw2bGgcSrVqlf79sX7lcBdMASmu+sKcf0PBUHXT0obeTpSJkSsZh/qA
	JX5clg6RS2MaLsoNh4KycJAZqZAUTnD3ibYdxDUWZA==
X-Google-Smtp-Source: AGHT+IGrFaUMFTf0LtqbvFpeCf5IlX4Eo/WbINxiduuCVDXs/QnVAkFFQAF5W4OPmARlvmwlQHFHgA==
X-Received: by 2002:a05:6a00:e8f:b0:736:6ac4:d1ff with SMTP id d2e1a72fcca58-73dc14573f4mr16876474b3a.3.1745233125904;
        Mon, 21 Apr 2025 03:58:45 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8c06bfsm6279722b3a.9.2025.04.21.03.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 03:58:45 -0700 (PDT)
Date: Mon, 21 Apr 2025 16:28:43 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: webgeek1234@gmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cpufreq: tegra124: Allow building as a module
Message-ID: <20250421105843.rxgctjw3jrkwuxsd@vireshk-i7>
References: <20250421-tegra124-cpufreq-v2-0-2f148cefa418@gmail.com>
 <20250421-tegra124-cpufreq-v2-2-2f148cefa418@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421-tegra124-cpufreq-v2-2-2f148cefa418@gmail.com>

On 21-04-25, 03:13, Aaron Kling via B4 Relay wrote:
> +static void tegra124_cpufreq_remove(struct platform_device *pdev)
> +{
> +	struct tegra124_cpufreq_priv *priv = dev_get_drvdata(&pdev->dev);
> +
> +	if (!IS_ERR(priv->cpufreq_dt_pdev))
> +		platform_device_unregister(priv->cpufreq_dt_pdev);
> +}

Ideally this should undo everything probe() would have done. There are
a lot of clk_put() calls in the error path of probe, I think they must
be done here ?

Also I would require an Ack from Thierry or some other maintainer of
the driver to get these changes in.

Thanks.

-- 
viresh

