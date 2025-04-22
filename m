Return-Path: <linux-pm+bounces-25906-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAFAA96DEA
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 16:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4801889C71
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 14:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE28283CB6;
	Tue, 22 Apr 2025 14:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xlH5qHVN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B631EDA27
	for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2025 14:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745330820; cv=none; b=K+0fLhXwtyKx7PcYBuz+NCNwhrnT/SDuUI1wxUKv4BpJyy37wPYmdlUjemEPpjlA0/3INAmWYXS4FvptuPzqjy6F0M/IiYoI59AJeVOXZqhg6xE94zpfkXdGerxFGmA6TsvkSUpicDzSGZNNSDvJxHqgJHGzqOi5GyU/kOfFwX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745330820; c=relaxed/simple;
	bh=Oryn9ySIryVpHrGVoxkqAjqwi8kpr2fXSiVFCTh/yBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kh8Xko70JzA9+RnXeVIlAflTFKXlSTwGKvUrnGu9mCuh6ZHExy82CaDWPx9ypDyt/W2mY59BFnssbDdlgKYu8PPauSim7eqGex7QKxQaz/wKM8ZPCk1lwocYzrmu24TN48kcwnUOT4PDkCdzNfgB6COR+HryxbIzQwaUinfFwY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xlH5qHVN; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5f6222c6c4cso7098935a12.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2025 07:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745330817; x=1745935617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jd3xJuk6FST7n0S2TVkTNzsFUMjoZp3JZccjQ28WDhI=;
        b=xlH5qHVNkZw6vnYuSoxRpfFBaWfjnw85i/cB/tKrx+rX/cBbIY4MnZzxlzfn2HFhEs
         p59wkzhzZK6P9HscwtNnbhcT4CuHi26Pp++oT8n+1nqIJIkgrbSg09qy6xAdPyq2D670
         OTuXZZp28SiRZGH4y0gYikuWIOoNWFHAwuVxURVTbhC4K36tLDWbAlPeMzt5ZJNuW0rE
         Bz76e0MsG6Uc0yjVGNjGy0gfXas/dBiWAMdjjki0njWrSKgVQY67OsJs6uQyVlskOAD9
         YfbMfZkt2XzUxX7W/9jw73KrRJ6G/rox6KAgqp2iQdgttcJIf/8w4B6B74GuDHmVBWTL
         p5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745330817; x=1745935617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jd3xJuk6FST7n0S2TVkTNzsFUMjoZp3JZccjQ28WDhI=;
        b=dZ0Ohk2nzXl9Ga3BjMbyD3y4Z03S5rO5xvFw3C3P7mZVDerhvlWPxQjXniViJA3NML
         mx5rJEb/2g064Mh+a2azY7kKNtAAYMMgHlI4frRFEUvbM5TBGuOn9sTsyOBlr59kFrAO
         0KLcNVvwZ/obEkCGC16RivtlyDtwddkCHQ/9mzJvb2sxmCNxL9C44c3hNoorteN1vCjs
         8yBep4NddScZ3BW53Eihr21mQdLDOfRJ+C+Cpclu99H/F47GAubnQrQtGrYQ/Lr9oCnX
         /HvZhU8gXXOUUOxULm+zj+vx5LV/T3sV/WUZaNjwahwuLQOfMpmiYsx0rBVMXbVNQNuj
         avNA==
X-Forwarded-Encrypted: i=1; AJvYcCVJdOOrkFA3r0X39+FHPCfS5FNzCwBOnjDI8c3F2iko4sBCKIydZIIOYqrEJa+o4Pl0SWDj97d12Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyW5BAZ/WAc4fpmGL+gKOGOkI2OL1+BJRaKZ/p+/ShGlO7r7tGS
	58bkneDCK73KqV/q1+A2lFn8srm1ONr1uDgbEIZMjx1VmQCPvDuq9Jl2gNTQkJpi8CW+mkZMJQ/
	b
X-Gm-Gg: ASbGnctChbZbT2cJHjRlb6SJMAl8Hw3dTLMZI+ARS023Vu98s5v7zs0x7/WXng+CTcD
	ywIlBaiMA1FWIFNqtSgUVcar0RpAv47emxSVnnLXYsnqIx5z3SgM4mxtn/YfZzSD20DZHQ3Nrxh
	F266rYz9Cb6pPdtMK6wgFdXM49RLUobvuKz0fzWH/+OxV2EC27NQvjhGX0f4zjGwzGHNLGTWHjR
	B8cnB9/x3MHuHcjcuHB2PnfQJRvWY2dEjmuvTIbIPy1jvX94ayjLRFZT9a2NwYCFgb9NJcB5k6H
	tQHnwdtskibIvs6YxCp+gWCXq8UfD9yjyA807w==
X-Google-Smtp-Source: AGHT+IE6qyTXes9SNmoJNFucgPGNq3S9gJF/Z5FLJA8q1EwlXstU/Kat+/34d9QRRlSBxR2b2iRPKQ==
X-Received: by 2002:a05:6402:13ce:b0:5e6:bba0:6778 with SMTP id 4fb4d7f45d1cf-5f6285ed3e0mr12811708a12.23.1745330816878;
        Tue, 22 Apr 2025 07:06:56 -0700 (PDT)
Received: from linaro.org ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f62583400csm5965159a12.59.2025.04.22.07.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 07:06:56 -0700 (PDT)
Date: Tue, 22 Apr 2025 17:06:54 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Devarsh Thakkar <devarsht@lewv0571a.ent.ti.com>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] pmdomain: core: Add the genpd->dev to the genpd
 provider bus
Message-ID: <aAeifr60sdT/AENz@linaro.org>
References: <20250417142513.312939-1-ulf.hansson@linaro.org>
 <20250417142513.312939-7-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417142513.312939-7-ulf.hansson@linaro.org>

On 25-04-17 16:25:04, Ulf Hansson wrote:
> To take the next step for a more common handling of the genpd providers,
> let's add the genpd->dev to the genpd provider bus when registering a genpd
> OF provider.
> 
> Beyond this, the corresponding genpd provider driver's ->probe(),
> ->remove() and ->sync_state() callbacks starts to be invoked. However,
> let's leave those callbacks as empty functions for now. Instead, subsequent
> changes will implement them.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

