Return-Path: <linux-pm+bounces-14983-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2BD98B322
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 06:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D536B229C0
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 04:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B6A1BB6B5;
	Tue,  1 Oct 2024 04:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iHYq1pQE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F21E1BAEF8
	for <linux-pm@vger.kernel.org>; Tue,  1 Oct 2024 04:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727758487; cv=none; b=WyIRBohFuOyPUYMALGYGJfjPtD7+85iasHutenghMuQLeByuAP45ihB3waQB7roW4IietYG6D+cfjf4vtTnveHSKlkwcld5F+6A+2t8l6WBbc+XiUe/f+J9h5W73I73SmQo9mSbK0nqS6fLh85Rt55QnCZ5O0xRdRl0F3UgmHHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727758487; c=relaxed/simple;
	bh=SFcYxeh6D6hQziheMn4w8C17Py5ysIvLmDhsp6Mf3As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grQMNEh0jSXwQR7r4SIQP6l0+lEE1C679AZmZCHn1tKZRGXml62oN2otFT+0b51FzOibTkdLWzB3jjSPHOZRIRz4F8Xp7djJ1pYvQL3gwhTdIizCMmxsfKR4AUNoef0o2kPCgVH6dX8i8ZAWcSLs3DEGR5IyWPeH7QfgQjYcUcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iHYq1pQE; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20ba733b904so8368755ad.1
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2024 21:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727758485; x=1728363285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgOc1RXmYSlrn8XevR/ExtFztBKGG/uI3XFCUWmMOYA=;
        b=iHYq1pQE4OFhqEcRNCWzXSpQpGikDECahaO2bokKhrol7KN15rkEAZ7ZYxJqDLdFaA
         ssc4BON7E4pcFQeK+OU16YFUvWxbTACAM7tS9urPZsCH/VN7Z9JvObFao0CvMajEPDNc
         p0GQpqV8tB+Yxvm0YM0g7l3/X82tP5v0Lpt6rj6b9RkAI83DGWvkdCodk9aYUuutUPRF
         yqO85BLlWgUx95gbj1PA13jHNhETFfkRl4XTiQqUbYC2Rr6QCQmRufUMMoy8ErmOd+Ru
         hSE3ox77YLf37RNVnH0hGy7iPmall1pWp0pRlqYUi1sh2Sy1k2EDuQm0R/qyhqphZ4Oa
         ZNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727758485; x=1728363285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgOc1RXmYSlrn8XevR/ExtFztBKGG/uI3XFCUWmMOYA=;
        b=N3WIoSw6XVPWye9othwZdesuW8ph4QOBbvYmNLVIyHcta1jTDZTA35hw1lyA4OZESu
         HHKfsOJ6JIPuOSntLCyLIl+aj7SWefsmWIaghyidvKmW180MU0WCPzDZBDQvdnFu0DGy
         LwUeUjUdzVWxtop0pWxnSfj2RzT45scbk92cVujcbYnGbiZWuvb0yPrOl9NeUFVRj00p
         P0seymMuRlqXtI8xAJqEXUAGTKNWnG0VB6gFRlc0ofzqpekCA/XY1Fg+LMExx7su8MBd
         pN3TV3uldmikvXYj5km5vvh+Yl18OaVUY9O2lG/sah8/AiISNppvu6Hg4AVwgqgPYPWQ
         h/kw==
X-Forwarded-Encrypted: i=1; AJvYcCV0fc56igkij0lM+l80G0KJCKfx93CA4UQG7YncGBMht06x+CxzL4stlLWWD5NPTHbBn0Dz/gpuEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVkEiDf3lFK1FP6qGp+fbVTsx7w/wN9vhJVBbXSJZLW0O1y1dP
	0FrQJnKShklIj8yYoDo2H1p3lucV0uj3Cf4U0cAIlhERtbEwa2e+54Coc4FNYaQ=
X-Google-Smtp-Source: AGHT+IEimOh3pb8T09w8gjZKssoPclvF61Bdah2TzwsD7k8Ppv+rvDr/IX+I89OOAH9g09+8afhcLA==
X-Received: by 2002:a17:903:22cc:b0:20b:7388:f73 with SMTP id d9443c01a7336-20b738814e7mr124493935ad.42.1727758485621;
        Mon, 30 Sep 2024 21:54:45 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e51811sm62200475ad.259.2024.09.30.21.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 21:54:44 -0700 (PDT)
Date: Tue, 1 Oct 2024 10:24:42 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zhang Zekun <zhangzekun11@huawei.com>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
	linux-pm@vger.kernel.org, chenjun102@huawei.com
Subject: Re: [PATCH] OPP: Remove unused declarations in header file
Message-ID: <20241001045442.y6oh3bpka27rjstd@vireshk-i7>
References: <20240907080701.102266-1-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240907080701.102266-1-zhangzekun11@huawei.com>

On 07-09-24, 16:07, Zhang Zekun wrote:
> The definition of _update_set_required_opps() has been removed since
> commit e37440e7e2c2 ("OPP: Call dev_pm_opp_set_opp() for required
> OPPs").
> 
> Besides, the definition of _put_opp_list_kref() has been removed since
> commit 03758d60265c ("opp: Replace list_kref with a local counter").
> Let's remove the empty declarations in header file.
> 
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
> ---
>  drivers/opp/opp.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index 318a4ecbabf1..641e4bccf68e 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -263,9 +263,7 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct opp_table *o
>  int _opp_add_v1(struct opp_table *opp_table, struct device *dev, struct dev_pm_opp_data *data, bool dynamic);
>  void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, int last_cpu);
>  struct opp_table *_add_opp_table_indexed(struct device *dev, int index, bool getclk);
> -void _put_opp_list_kref(struct opp_table *opp_table);
>  void _required_opps_available(struct dev_pm_opp *opp, int count);
> -void _update_set_required_opps(struct opp_table *opp_table);
>  
>  static inline bool lazy_linking_pending(struct opp_table *opp_table)
>  {

Applied. Thanks.

-- 
viresh

