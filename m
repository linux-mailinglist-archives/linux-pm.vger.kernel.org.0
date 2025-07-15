Return-Path: <linux-pm+bounces-30865-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8066AB05C9E
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 15:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D624A3909
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 13:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02E02E8E1E;
	Tue, 15 Jul 2025 13:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MhoH53pH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F4A2E54BB
	for <linux-pm@vger.kernel.org>; Tue, 15 Jul 2025 13:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585993; cv=none; b=SxY5wxqZk5V13L9CvxRJ/rR/K6Z7zSwjVbQpb8bJJVQolTNSkkW2ynoUbyzZOqineSDWSxPvh7nkQ2zX8xAECjdlCGowXY9WjXoJ+NXfb8GwC3ODZ+6e+dl92TbNZD3ZdyMX24akwJIlopioefdh8WIGOitFSjMsuWbHRWjh8Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585993; c=relaxed/simple;
	bh=WsPqDkkR0w0NChv6i3skLUOm50mr+MhFYwPfQ2zF7hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWLPseW0MQCB8XooeEB+Q1f6ZVOXZk7VkAMwQSXe7I73Hofe7HiEscnNcG15XwAjBe6cxw0wTPfJeeb4bdAgEf4g7KitgoMagOw00/VPllaKc8joG4uMqCQNms7FTvOHOfW5le9piSzUMexdRQBqb37uKijvqUENxmw8ftL6yao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MhoH53pH; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso2532754f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 15 Jul 2025 06:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752585990; x=1753190790; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VvPKW23vcGHWbJZ7ulKit+LygcP46v08cpOClJit2gQ=;
        b=MhoH53pHIJrJbX8BlEjunSGwZ+hzVoWJCZZqS67xlw8v0Ohe9+eLWEV71ASxlWTKTi
         XgmwTPzgqoFNyAyDhogL5gkWp1k0M9GmpNlAveztgqsG75TBh1pnGo4XkzfDIEO5bpAZ
         zPfVNNWHA1Ax9OEjCmocRKbGiOuvVfo/jTlDjM4GjMIMeX8mzyZwIGZfdjKC1q6VpLOi
         5wUhuQfuYUgrmno0ZCA7UbBv4TLoq8sXO7JGALeeZcb7HswAy9LV6wtJYtaIv83tq5F7
         o3yBJlameDJZ7BKzJT3Tm3PiKaf2xGg2sVDOb3aCIg9F6xtkKxHRnkb5wSO7wud5wjX+
         n3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752585990; x=1753190790;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VvPKW23vcGHWbJZ7ulKit+LygcP46v08cpOClJit2gQ=;
        b=EbKE3uTGurEkfg5Z6SsLRzU2Z4Xi9k7FkI9SxxITnaxZnO7fH5BXJ4QQYN56IMhC4r
         kEdji2mH6jkMTNk3XE9DaPIz0sRHswE+bfqzrOfxHRcTraafjXkVnUSonjKuYNJSi6O9
         y6baC/54klDrV+YdEcxWbroUbsYnnXmRffeO5hmQe8YMM3j7ZFB01PB4DgsvR63Pf5bM
         rAd+CFL/pKmpqgl9YWJNtiIrd8/agff7Ut+KRZg9jZEGRQJcVaJtRP82hOIfRuQjQO5s
         f0tSpO4xWYl8lYqj+DPrzHMyo3eb5yiPSX2EyFbHAMps3Wq+XpW2eHfMFQz4RYMv5o2M
         Nj2g==
X-Forwarded-Encrypted: i=1; AJvYcCVbmHtTUGIHlNLnK9mlYPLTozG0MLwPUNmJ/symBCS0yX0guA1CP8IdFdsVm4MJiz4xA2TMb8ALhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeP5GRmtmFNRN7s8L/j40f6l4XlLm0qx4RssNA44cyf6mU8Gn8
	eF9fZs+zKKtDVRbQdlIf9N+0D7yDzqvZnRo+e4gb89W6q2oSB4ydpDUMWX74a9/bkIQ=
X-Gm-Gg: ASbGnctX9L2gPgn+IYsoum8Yqc+L4qm9iipL9PhtoE22F83s4xgr3zRyzMp4dWYZ1YS
	tjvP85j7DZK0li+geQyyA7pPFrz7JkRcsGjTCMpKVAoH3aT96kSmL793ZzsysJRleK1xWu/Z4JY
	mmNsNiF06dh85thEw3siRT+5AnWhzPmmUWbTplbU9kO1eaXEyzKMfplP5CprWyLpUQY98DmWpN6
	mJVldHl4Hh0m8cyotAT7XS+fsluTrgcn1BCK46abcdH3ZZFqPWdgAVz/kmcxORmyLMwzZhVVnM5
	tU3DUGMK4aTsr9RefSHfqRVqc57tVEe1xtaGwqZOHKZ6Ygte1c5JL1iHzO6aPIyXkP8pWJiIV0m
	BByMvXSiTroZyRb0Aj2K4yjlV/4EVA35kQzVZnyiWDLi6AKJh/OkiHOak1N2h
X-Google-Smtp-Source: AGHT+IE407KS8uKPTJWroRm8IILV/e+TMXBeoa0EGQKc6WbP+vL8QbjAW05nEN1glpgEAbE4/IV9fQ==
X-Received: by 2002:a5d:6f01:0:b0:3b6:463:d85d with SMTP id ffacd0b85a97d-3b60463d8eemr6451671f8f.11.1752585989943;
        Tue, 15 Jul 2025 06:26:29 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d872sm15337925f8f.60.2025.07.15.06.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 06:26:29 -0700 (PDT)
Date: Tue, 15 Jul 2025 15:26:27 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-pm@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] thermal: Constify struct thermal_zone_device_ops
Message-ID: <aHZXAw08359qCBz2@mai.linaro.org>
References: <5bba3bf0139e2418b306a0f9a2f1f81ef49e88a6.1748165978.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5bba3bf0139e2418b306a0f9a2f1f81ef49e88a6.1748165978.git.christophe.jaillet@wanadoo.fr>

On Sun, May 25, 2025 at 11:40:04AM +0200, Christophe JAILLET wrote:
> 'struct thermal_zone_device_ops' are not modified in these drivers.
> 
> Constifying these structures moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
> 
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   28116	   5168	    128	  33412	   8284	drivers/thermal/armada_thermal.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   28244	   5040	    128	  33412	   8284	drivers/thermal/armada_thermal.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only
> ---

Applied, thanks

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

