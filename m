Return-Path: <linux-pm+bounces-7982-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4FE8C995A
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 09:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 647351F2152C
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 07:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA7218C3B;
	Mon, 20 May 2024 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tEXDjBz5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29031C6A0
	for <linux-pm@vger.kernel.org>; Mon, 20 May 2024 07:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716190424; cv=none; b=pVRBw+MlyKbTaLhIFFUSvCfWPQY9pNT7mlWCaxgG/v5dK+sSWZLhXHI7yvMH+cAB+KCRxlsM718OhyGzhBKsCZ2LZdai3BsCBE890VUc7E6Q7zybzWMkgSZWjQEUJHNnQxpryFZ+oItyfBjUvAfuaTP98juxUruH0Tl2PKtQumU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716190424; c=relaxed/simple;
	bh=WeixK4Kgn0MvKplzBTKjFtE2DZaxPq1ICJ/opiDshY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uraShK7I2bSW7QoDH8DaGyGR38Atgzr0BLKUPhzNw1+oxHyEtuUvjB51LH6mKiH9vYGjbWhMJsr5k23COJ3gShHOI7d3NJ+wWw5Y4NNpncOfKd4GOiYnZFoNELH6j8xt0TSQrhTvblvk+ahcsiWoYpeuWj9LRcMxPRKi0ImEYQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tEXDjBz5; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6f0f87f9545so1900650a34.2
        for <linux-pm@vger.kernel.org>; Mon, 20 May 2024 00:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716190422; x=1716795222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jTHkzAvMu+l8UyjO4kbcmDDhuFxHapp+W1C8XEMNXN4=;
        b=tEXDjBz5X6HIDXH/APEZKYUsx9z8++QOoTgXg1mStvoc9Ktlj2ZHefg99GLYWaPiDe
         sUrOgi/t0cfGfOBQwkS9kfRz8VcEyi5gJj6sWrqQ6W80b/a/LtlrteLrPWHv+4AAOgsk
         m05rMOipT9nBQIMp+1aPwqS5Ieb2w3qbZAfFiRS/mXaUJYEw7f3Kpq7otnGNao/r+T3v
         Eq1psNVOp9Flx8MQcBJ03nQkJjS5WcC6dSv1PqI45UGBYosD6vofoUzbnqZe0gOGG6Ls
         7GwkHGCyNuBK+KyKQqTHZKwNh2hjCqBG9NuB3WfYYfEBCPnPsyA0axjpu7lo4aHPQI1G
         G+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716190422; x=1716795222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTHkzAvMu+l8UyjO4kbcmDDhuFxHapp+W1C8XEMNXN4=;
        b=MSm86ipclPEeFqlvkKENF5646zomvIr92yhk3ijViPqXjf79AtVgruH/p/sqgckDEh
         vNCbgPznnVKmJLk8lEu6e+xNZD8ZRhBgSVdnPmT3bU2nFSat66Nbpj84AfPxg9swPD7V
         kgwfXh6HsHkUKh47dOEdjpq4l5ruykTD3E99uJdCBYEnB7OYrPZfTTJk74o3CaZBlf1N
         ynzt/iMwPgF25W5n/E96t7Bl3Dd3NFPBP2PPbqDCt8EfnlGH8c0HsZlY9JAR4ELwMaUf
         3YRcFU9FvWSFv/H2Xx3u9eN4fw2dJ1JEU5lcjBCLySyAwPIwCAWe5jsl9d0g7T1voEaV
         NhZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdaaN/Xvxn69z806nYpJAJ88+QU5JFJjdSd7qBsieR9m3YQ7xhaA+2T75vKhsTbsZiW8/BbRzGRdCmijMd8zSCg+QT+enpADk=
X-Gm-Message-State: AOJu0Yy1SHgx+ZbHuUse+cL1guGBb4wNRQQoRY0vdFuam4J8fTYjMaXT
	w/NrOiKM3G0zEGj2nwlePLQMOc4Vpi6AR0QSJG4EntOXaKOGBcyI4UtjQbAlFb4=
X-Google-Smtp-Source: AGHT+IG7YMk/8WZfU70jkrguYTPefZ2BNfU/qrbtxJO+K7HFLFtKIi73g49AXVItMr7hLaQS5M2OgA==
X-Received: by 2002:a05:6870:40c8:b0:23d:49b4:6718 with SMTP id 586e51a60fabf-24172bc060emr33527554fac.32.1716190421955;
        Mon, 20 May 2024 00:33:41 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af52b4sm19106876b3a.174.2024.05.20.00.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 00:33:41 -0700 (PDT)
Date: Mon, 20 May 2024 13:03:39 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq: sun50i: fix memory leak in
 dt_has_supported_hw()
Message-ID: <20240520073339.rf6laivnglmww3bf@vireshk-i7>
References: <20240503-sun50i-cpufreq-nvmem-cleanup-v1-0-0a2352cac46b@gmail.com>
 <20240503-sun50i-cpufreq-nvmem-cleanup-v1-1-0a2352cac46b@gmail.com>
 <20240510174937.0a710104@donnerap.manchester.arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510174937.0a710104@donnerap.manchester.arm.com>

On 10-05-24, 17:49, Andre Przywara wrote:
> On Fri, 03 May 2024 19:52:32 +0200
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> > diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > index 0b882765cd66..ef83e4bf2639 100644
> > --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > @@ -131,7 +131,7 @@ static const struct of_device_id cpu_opp_match_list[] = {
> >  static bool dt_has_supported_hw(void)
> >  {
> >  	bool has_opp_supported_hw = false;
> > -	struct device_node *np, *opp;
> > +	struct device_node *np;

Why is the opp pointer removed ?

> >  	struct device *cpu_dev;
> >  
> >  	cpu_dev = get_cpu_device(0);
> > @@ -142,7 +142,7 @@ static bool dt_has_supported_hw(void)
> >  	if (!np)
> >  		return false;
> >  
> > -	for_each_child_of_node(np, opp) {
> > +	for_each_child_of_node_scoped(np, opp) {
> >  		if (of_find_property(opp, "opp-supported-hw", NULL)) {
> >  			has_opp_supported_hw = true;
> >  			break;
> > 

-- 
viresh

