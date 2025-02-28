Return-Path: <linux-pm+bounces-23151-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72744A4913C
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 06:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212D4188532B
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 05:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFDE1C3BE7;
	Fri, 28 Feb 2025 05:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ngn2jpDS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4171C1C3BE1
	for <linux-pm@vger.kernel.org>; Fri, 28 Feb 2025 05:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740722331; cv=none; b=UoNlGilkHui0m1Myib0u0/OP3YnXKcCRC0ThAetIdJCQXEN1OYhrbo+lU1GfWWiHjLLeGnXFWNpvqWs+Q8cgJuNvm7nk+I7Va6gIBuXqdVKdbNXN/eYa0OBunMm1NEjgiP6z3Gd4tKoX6zo7xaSTj2E78Tmvlm0PSvrM/rhdo9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740722331; c=relaxed/simple;
	bh=V8V/ZCN7frvfcECXuXfU8l3W4E8kK7o0sxD/Vdoy7Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHr2wI3fLjE6J6wnKB5tpH/J1yuZYiQ31FrsECGq1GEy2vb+J7HbuCDzd7R4ByQ4KV2n4n0lKaby9UES4wtiZf+CoFl0o+D250sF8dzqkQf82Fm3fUt3bTD/NP8FqeiyhWdOSQvDiZOniaXX0Cf4vydLxvYxpEBfBPMNQ4CsYg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ngn2jpDS; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54843052bcdso1546092e87.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2025 21:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740722327; x=1741327127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ibJBHy5xFJcYeoiCP5vmhHIfF4PoPWSUEyYMwmPo78=;
        b=Ngn2jpDSKjUpoG/a+Y4YuxwKHMcfhAmUz3gTktc7mAS9Jql1RSHSEZZRvFjiuKxZ59
         iRLiWytn6fAjXONpK1ITsuJgrTq+w7VPz/XFTmCBQVmmfSfAVFELQ6OsQ0pmE5S7n64O
         o0EtuMw+2hnh5moUq31dkGy89dRzPEClK9vPQpVGB/bdHCNHtSGWwdUWYD7HBmGKEXVU
         +zHYif8AcKSnv/deTbmVtVZF7TX0jwUxnjG7KlNEj/W38koXE+n5hBywjViXhFaqeZYQ
         /uwK6ME4OXGn43QsSt1EFne3RTgr4QvWSLcgBiiqYVcXRLb0MnGaGTSqjKPlFHScy/jr
         xblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740722327; x=1741327127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ibJBHy5xFJcYeoiCP5vmhHIfF4PoPWSUEyYMwmPo78=;
        b=QYMNDuUPyDT2GZlyGo7szIK55szv9h5tFEIC5x+3/LQzx2z/DqxD4Nr0aCfISBfnAL
         oWNfHXcu3GBgbsghZV+mPmKdM0PaVhn/vucs3qcN0tPzUkg2xwl1TM7cYQh88QgXiPZS
         7txpdaXLOxWXwM9Uh3oUHm/86prIUq99i8yFI6qbnjKUJZvZacNS4NKfmQwGmJmFPftT
         RPSFH2uqlzaFeEMA52eOt259n20uHDfMDb7CFKxt/wz/HENjNVPxF4j6A76p6lVstMBg
         lsbMtkz801R3nHeBMqdhJd1yjNsQgT0GfC5o1H8RJ6fWTZan+kZrE5UOG5LZPxfm9ahC
         OwxA==
X-Forwarded-Encrypted: i=1; AJvYcCVsKVdaTSkfrMda7gEsGc9Xz7k+s/GRUgzs3S4vHC2V7bqxZqbKQHag8WDMC/hIZklrD6MK98YK4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2i2qxpsPQTLvZQ+wcbdi7rma/5vSuGlZTZZEPsjLt+AxS3Q9E
	yBsX1Fss8puoFUhynsDrT93WsW4WscIK+irJdvKzWbeQqJ6MLCfNelHDD5Iw6w4=
X-Gm-Gg: ASbGncumQPfO8fdjZuhvO99cSZ9jKAm16xaZcxoosxLNI3ACURQciTudghCxTilqbV+
	GaVwF5K7hF+rTGIA6YXRmLNjC0QH+PEVwJwTOEUc8EMKexlxJRkQd1azk+6486m3u5hYxz6Frta
	Mp6eQlSOglOvy9TpRKR8emtHSxGwB0kDoUrxdG6qieTPg2SmSq9ZKkh44peFHBa5AqbWfVlzvHu
	OwiZNmtesUZSm16Z2dfMoYZJCY3uCfJsRkMqws2TqW82T5FowjjGWtsggquy2tmBD45yrb9e/Vs
	ishz8JStf1V4cGsNLpSc8F4xb35MYKZ2ML0PajDHk77Tchdd5VSfkjn2T8soHKCXZF7m5K2V4Zw
	RtbQx4A==
X-Google-Smtp-Source: AGHT+IEXLnFDwZvt1i2DDslT4P9hWVkKd38XTzY/galZKmHrDSqPgz/TCLothdRaE+i9h8hTW2yIaQ==
X-Received: by 2002:a05:6512:3b11:b0:545:2f48:d524 with SMTP id 2adb3069b0e04-5494c320d25mr623886e87.29.1740722327221;
        Thu, 27 Feb 2025 21:58:47 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5494f8ee8dfsm99203e87.222.2025.02.27.21.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 21:58:45 -0800 (PST)
Date: Fri, 28 Feb 2025 07:58:43 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: George Moussalem <george.moussalem@outlook.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, daniel.lezcano@linaro.org, rafael@kernel.org, amitk@kernel.org, 
	thara.gopinath@gmail.com, robh@kernel.org, krzk+dt@kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH v9 3/6] thermal: qcom: tsens: update conditions to
 strictly evaluate for IP v2+
Message-ID: <equtmcryan2zb775ljo2zxro4hotimwoj3nrftmlbe2bhp3azg@cp2jco4xa2jk>
References: <20250228051521.138214-1-george.moussalem@outlook.com>
 <DS7PR19MB8883434CAA053648E22AA8AC9DCC2@DS7PR19MB8883.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS7PR19MB8883434CAA053648E22AA8AC9DCC2@DS7PR19MB8883.namprd19.prod.outlook.com>

On Fri, Feb 28, 2025 at 09:11:36AM +0400, George Moussalem wrote:
> TSENS v2.0+ leverage features not available to prior versions such as
> updated interrupts init routine, masked interrupts, and watchdog.
> Currently, the checks in place evaluate whether the IP version is greater
> than v1 which invalidates when updates to v1 or v1 minor versions are
> implemented. As such, update the conditional statements to strictly
> evaluate whether the version is greater than or equal to v2 (inclusive).
> 
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  drivers/thermal/qcom/tsens.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

