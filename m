Return-Path: <linux-pm+bounces-7990-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4F18C9A5F
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 11:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC7DE1C20FD8
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 09:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679601CFBD;
	Mon, 20 May 2024 09:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mdwplcUz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CC51CA81
	for <linux-pm@vger.kernel.org>; Mon, 20 May 2024 09:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716197520; cv=none; b=JKV6udlhuAzeQNp+/5Tgyq2/snbsCujRw9siwLz6/dnfBRohkJXWc7Ovpq+Oo0P8s87QUg3g3BWw8JvIIhZwwQjaQWbIbcWVwEE4a4rik4OzAQE9qKG7y5i2/NH6DNOl+Vr0ADOJa8fpxl1ftved106HtH/rrqRnORDD7SsnFII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716197520; c=relaxed/simple;
	bh=fAwbFrhZucuUROZuu6MGO86O8/hvc7iTiETnrY7aFhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDgArU6HqRY3Gd1hnQZzTObE13z1KZPvP1xeSx2GTOrlxZt7LkaxAwX/c1ESkrU9sQwbS2OpbTvzHtWad24lZFwqdQ+vUiUiXi3kGp9001LMpoJIaMfBfAMRYqcZDUd2Ovkpe0FLEwCheJX4igIdYLLhmhhmqJsWPJiLu3CkqHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mdwplcUz; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ec4dc64c6cso64519525ad.0
        for <linux-pm@vger.kernel.org>; Mon, 20 May 2024 02:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716197518; x=1716802318; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gXcTr17OnY8F+y7pmTPTBCYGtlM1VN1xAJVrjdqU4FQ=;
        b=mdwplcUzhjzfcshi8DefU5V6JxPFbVR29v/II0Yag5Xn0aBEQX0xTs8XE2OAJEpRrs
         vSmmYr7NxNBs8CkLQFQqnS1aylkznKnHiL/LuwTLoRlGHCjY9BGPG1VlLdEJO++cZwsS
         fYYfzm6KxtgRL80o0Ioc4nnUdVsYKjTVoMt2QeOxwT8BULP2nW4J0H4DpEzblrVJpJ6l
         BV2oZsnGknsx1s0VrLfIBxOekGntydFvHZxfLjEszKi/CwxnGRuzPr5ap1cQcj0+MLIq
         /WgxoOEW+swmatM3A9J7XxOHnd/G8gs1hppWjFY1EE633eLRPrE88jYdlTgpB83H255y
         AeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716197518; x=1716802318;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gXcTr17OnY8F+y7pmTPTBCYGtlM1VN1xAJVrjdqU4FQ=;
        b=DJaIC8vv+nWFmWtV1cDdsTvSpUofa1/Rzd/Rv6GfrA32OUyb8Vuvku2TwJP/m0PYz8
         qZhtLA8rEMVxD82wAjCIXJfn+mbQBi7KMjhwKgEQqxeAXYsuUWf8QdEJBhm9r2zshLpJ
         pXKDu2RSGipyrQdu0/rwnLeVrjLIovuWOR+3xXDvNEaBOkbhYZE90O1SXZHyspIIUD9n
         QqyYtMTS00h6huIh/L+XKSHFdrbVJ6q9BOEsLiXJ89Poqcrjr7guO/Nw7ePObsnZmRaw
         NpPzMO9CZs4Szi7cyvp190DU5NMRubqzQeRY/TpRG6TB7+QlIV966iT9dk9zBKjBG7JI
         XGrg==
X-Forwarded-Encrypted: i=1; AJvYcCUySq3paN66GtXiFWKxUXAwwX+4jYqro7dG5zuRvG3U1QEAOLzDlXfqCk45hvBZJP8a+nBTeCLPYlRfjjJxgd2CqTQLMcUE+2g=
X-Gm-Message-State: AOJu0Ywe08GtWHTl486tKhCYwcUD46Y+EaMFYFuDiSjBEnbVl5v7nwph
	QBwJ0ZrgfrrW4amZ0YM5pAyHMLOllr9sUwbdkByr2ScEZbfzYGg7sj/QjHai04s=
X-Google-Smtp-Source: AGHT+IGMHTUCwV4E0Ap2p7ORxGvqyBKBjNs1RXtEdI5wPX18pjSwCUiOZO84RIQPeHBKQrbbAVVGHA==
X-Received: by 2002:a17:902:c40b:b0:1e8:6614:51cc with SMTP id d9443c01a7336-1ef43d0acb6mr329578705ad.5.1716197518171;
        Mon, 20 May 2024 02:31:58 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c15d516sm199167955ad.274.2024.05.20.02.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 02:31:57 -0700 (PDT)
Date: Mon, 20 May 2024 15:01:55 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: sun50i: replace of_node_put() with
 automatic cleanup handler
Message-ID: <20240520093155.bn4m7lpvkagopxve@vireshk-i7>
References: <20240520083522.vvga3aqjg4w3adkj@vireshk-i7>
 <fb6ee370-54d7-4eff-8a44-ee7cf2d13e61@web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb6ee370-54d7-4eff-8a44-ee7cf2d13e61@web.de>

On 20-05-24, 11:28, Markus Elfring wrote:
> …
> > > > +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > > > @@ -131,14 +131,14 @@ static const struct of_device_id cpu_opp_match_list[] = {
> > > >  static bool dt_has_supported_hw(void)
> > > >  {
> > > >  	bool has_opp_supported_hw = false;
> > > > -	struct device_node *np;
> > > >  	struct device *cpu_dev;
> > > >
> > > >  	cpu_dev = get_cpu_device(0);
> > > >  	if (!cpu_dev)
> > > >  		return false;
> > > >
> > > > -	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
> > > > +	struct device_node *np __free(device_node) =
> > > > +		dev_pm_opp_of_get_opp_desc_node(cpu_dev);
> >
> > Won't that result in build warning, mixed code and definitions now ?
> 
> I suggest to take another look at a corresponding information source.
> 
> [PATCH v3 04/57] kbuild: Drop -Wdeclaration-after-statement
> https://lore.kernel.org/all/20230612093537.693926033@infradead.org/

Ah, I wasn't aware of this one.

> See also:
> https://gcc.gnu.org/onlinedocs/gcc-13.2.0/gcc/Warning-Options.html#index-Wdeclaration-after-statement
> 
> 
> Would you like to stress a scope reduction for the affected local variable
> by adding any curly brackets?

No, it looks fine.

-- 
viresh

