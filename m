Return-Path: <linux-pm+bounces-25700-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7536DA935E4
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 12:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218D71895F58
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 10:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8992586EB;
	Fri, 18 Apr 2025 10:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K5HAevjk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA6B204C26
	for <linux-pm@vger.kernel.org>; Fri, 18 Apr 2025 10:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744971386; cv=none; b=rKbbc8iTDfsKG2v4+lphu7xfA+Y/h6Eo2Yn0WmW4uhj8wJHSkKKojNqLch/1yIkmdoLySFTONuaj/YWbznQg4RNxLi5lxubp1/Eq07dGQKN8nQexHz1Vy+CZ8uIPn4xSJXgjw/Cgmxc4DSta+8YqZQ6Lif5KtGQXTp6x5n1YfUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744971386; c=relaxed/simple;
	bh=Lp5BhMcVKSsFsdsphNab3vl7zSMQBiTnGPfS7Mtuwdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QA0XsVR5MdK3Yc01bcH5nbO6DHG98D7D/1dMwAAjcede2muHGChmVwp+QCTgzIGOhdeqFkBSgWRueaGdJInqTxJjbEmNgcGWRsmMaSoyQSXEv3juM2gFWHJG91GovQieLQMbsh18kJODMWknqYDDSc+hobgziIdHgp+lNQjuMUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K5HAevjk; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39ee682e0ddso994960f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 18 Apr 2025 03:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744971383; x=1745576183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IiDBnIbN2ErdrAZnJdVTPEl8ORr2jBX+0bJeY940wkA=;
        b=K5HAevjkTyQM0IciGnF879tXYoqLCjZwCbSJhjpnUzPYRigEcshKpxtPK6eqVJV8fY
         hzRnN7hMi3AM25VpthXqc/Jr5mccamj/GhsJhPr0a1o36a0lz2gU080UIYrQ4mg1tav+
         6Bem6u9QXEnomNqjSxPWichvjGh0cbpFrXUB7ef/G3F0wxxaFH/4bAnVSvswH69eduB/
         jRfrspbD1LYa6UVfE9d6EAbC56D6ejt79Y2rW8bo+CDRVaGgG9SNFpTL1eDMPeXHeyi5
         +vUAxo9Jty9tfG1eTE0oWLSEmgnurmJKG0/BhMD8nral04/Ic7u8iJ2roGGTZyhHwCdJ
         rKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744971383; x=1745576183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IiDBnIbN2ErdrAZnJdVTPEl8ORr2jBX+0bJeY940wkA=;
        b=aPBxzcBIcoA39WDVQ/DxwsdrFle/c0uE+/lMEXg4UUpvqWW7Qn/kyrukW+XL/Jgug1
         d4tA/iX/GEQKqEETlDb6aGYZ78MLjbbNYenqlobC4fUQQ974Djhi2juVPspLCgW5Dg2A
         lmxDZiF4UNOVZHO0R39pmXc9bZ3OJSrlvrgGcUIwddd3+LP89H4hS/Ay4J/kBzEfWaDp
         /3nNQlwdxNX64qYjZAw1OUh4R6kYluP+a9keFi+ZyNOs2yhz5JgW2SfhU48wwidjf87h
         XV6zy+qZ7qypXp3meZCF5DAyHh+gtNPxLyqbC4sE2nLIezxueQtkQAMtxCpioRpqF5CZ
         AeyA==
X-Forwarded-Encrypted: i=1; AJvYcCU4JIxn/0VSn6sw7kFxgLyLT4xyRJtke0OjxzzD0pygacPIHf39OSsrK+p9yIbcCoR+4fhbhdwSBg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7bO+9Xb04W9m9AYXLwCqunGpxCXliq+T2hN2gWg27kU4mMoIC
	eVazmq+pkAP9w2Hc6sANnFxVMl5BJ3QTJm6T0ZdgisClVUkMRnKUhOKq+ERoTjU=
X-Gm-Gg: ASbGncukdE4T2Q5prgJXOFcY/v+8GZk8bmxb6zO7ku6PK5UpKve3j0HRni65Qlo5kdC
	pAE7/1FTT6Ok1hf0s9TM/SqWnJOhddApzKhlNFeCiN/6otiRquFcZt0jABXcRPJP/d8zYU8Rgkr
	5M3fSN+UQhssZqOlEGU5SB6+Myj0WoKkswh4dGTPDybwaHu7ZMK7uAhBaYezs9MjYnprUnD4OYD
	QQFIR3q2CPv6yuhLRdCCOgZGvYOduul3kxPgcGxeAXfRDPvNln7C4B7DCh9c08h56a0RuarMWMX
	be/woaMbcqQsMmHfLHZrtcxlpfSdEeFM3HBbS2haJQrt4ZPNu8LLwsRki62fd09GYbScy4NlhzY
	4DWua7PxiclGV+w==
X-Google-Smtp-Source: AGHT+IEhVsv0Ij1c7fYpfyCnxhTynvdaKQ/MYv7KemDDNjedaaUCumCbBnsf/IltIZ7kk3yXig1l8w==
X-Received: by 2002:a05:6000:2489:b0:39c:11c0:eb95 with SMTP id ffacd0b85a97d-39efba460e6mr1527952f8f.17.1744971382884;
        Fri, 18 Apr 2025 03:16:22 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa493377sm2340627f8f.62.2025.04.18.03.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 03:16:22 -0700 (PDT)
Date: Fri, 18 Apr 2025 12:16:20 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: rafael@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
	matthias.bgg@gmail.com, npitre@baylibre.com, jpanis@baylibre.com,
	nfraprado@collabora.com, wenst@chromium.org, bchihi@baylibre.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts: Fix debugfs unregister on
 failure
Message-ID: <aAImdJFvfLTKe-TY@mai.linaro.org>
References: <20250402083852.20624-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402083852.20624-1-angelogioacchino.delregno@collabora.com>

On Wed, Apr 02, 2025 at 10:38:52AM +0200, AngeloGioacchino Del Regno wrote:
> When running the probe function for this driver, the function
> lvts_debugfs_init() gets called in lvts_domain_init() which, in
> turn, gets called in lvts_probe() before registering threaded
> interrupt handlers.
> 
> Even though it's unlikely, the last call may fail and, if it does,
> there's nothing removing the already created debugfs folder and
> files.
> 
> In order to fix that, instead of calling the lvts debugfs cleanup
> function upon failure, register a devm action that will take care
> of calling that upon failure or driver removal.
> 
> Since devm was used, also delete the call to lvts_debugfs_exit()
> in the lvts_remove() callback, as now that's done automatically.
> 
> Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---

Applied, thanks

