Return-Path: <linux-pm+bounces-6977-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BA58B058C
	for <lists+linux-pm@lfdr.de>; Wed, 24 Apr 2024 11:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5EB51F249EC
	for <lists+linux-pm@lfdr.de>; Wed, 24 Apr 2024 09:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AB8158A29;
	Wed, 24 Apr 2024 09:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YHUm/YQH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2117158A24
	for <linux-pm@vger.kernel.org>; Wed, 24 Apr 2024 09:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713949915; cv=none; b=mYSV+Wd3gttfG/V1mQkzqWMFx8GxZpvnHECjQOTQg7/la4tNtXoUoQxPBlVM7YgVEqHy9MxU7Lyu0aLV3mm0JxSogjDMXthRU8Jp/TTyth9G21uerVfbPw31VkkfLzQVoEcbavgYxzd+pKanTbN+lMFzq7cE6nTJDrQGP7vJaP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713949915; c=relaxed/simple;
	bh=/Gw9SGr+uP1rHAd0zWKwjjh9duYPFysFK8EJUFOnbFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElBc3QM0STTggbUuqbL9yRpSt7eny5DP+j36sCyf//wo4pnEeyyW93pNFH5xcKi5N5xLtTZtGShGBY/ebyHNdtLJHW3kiwesqtB+z5q8NCSZ0rZwx5+rSrSqul9SHsqnhby2fA51sgClX6d7UB/MYkvJXPzfVqPXnAF/xMAqNkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YHUm/YQH; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41b1ed3ff43so122945e9.2
        for <linux-pm@vger.kernel.org>; Wed, 24 Apr 2024 02:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713949912; x=1714554712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uYheCt1GtATOF4UzQefKKFdBWpbyM5L2mxeuseRPHVE=;
        b=YHUm/YQH2psI1FxLKgpO8crBuc8mhlZ4eODsMxHeekDD1wDT5R28NmLiHSJetdEUgf
         3tXTZk/UEpMOyj+sVRzPvzia87n4BhjNwsJqcABaLEMAcQ4FdAI2VY7D4Wi0Yp7YHfiE
         2r161i2y9oj51Z821DNlulv9DxrGRMBEp7HDics8CByT6LK2xj3rQwq8dMzNq/JXbo64
         1RGKeO1/R/g4MaohXYuM4H+7+qTFykGJuCEtO6HJaoRBOG/6GNpibmnSpw/VE3w8lAe4
         iAdIVK1XcwOgSPDDbi91Y3KqCmqK0FsqTxDJunjibE0mWTGw4gJUShdGL0sV+ZlTo+GS
         8z7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713949912; x=1714554712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYheCt1GtATOF4UzQefKKFdBWpbyM5L2mxeuseRPHVE=;
        b=ZZyvTVsU46Z/hpNiREcEtbIrKjxl/4UPvQOiFgh6vg/Zw2YYf+ArxtAptN6yh53xmX
         G+6ACOuvnwIjmmU9rTnixJaGEWf38u2QFwvBC0uogXQ5h95zUxz7E+AEda5kk9bd7gQj
         +x+yjAflNAMgKiLTcpK8e18nSfYm7HNT0loHrIEb/GtfHis7B31yNrejadIyIgoFEvvA
         VIfhzyz4N1o1tgzx7vk6LhUVtfhgJbLfm1pSXS/nSVbcPvjavjyVkuB3maGVfdMs4Px3
         W2JPPV+CEA845A5feeNDgiBeUsstlF5/Mto7j0qR5MAQQY8v1+jDhzZkNRxGh3LIVvpX
         oCAQ==
X-Gm-Message-State: AOJu0YwP5OHjLgPVeUmZasNK2SE3RvGy5juYAznjWJOIoRxw4rvuqY34
	k3cjC7r54HqhWoNwqudX1IV5JMZiKXA6lfaWV4gDGT5RZXc0WFNQfyzZ48mbqJ13E1Wops32Rbb
	M
X-Google-Smtp-Source: AGHT+IFJk2zdZKGHi6wJ9ClVSqC5H/sbZMgSpHJeKtQS7vdf+P0Z3/jvVQGfhTojE+bxiUi60E9KXw==
X-Received: by 2002:adf:f751:0:b0:347:f26d:c183 with SMTP id z17-20020adff751000000b00347f26dc183mr1250051wrp.45.1713949912051;
        Wed, 24 Apr 2024 02:11:52 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id g2-20020a5d5542000000b0034720354152sm16567128wrw.117.2024.04.24.02.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 02:11:51 -0700 (PDT)
Date: Wed, 24 Apr 2024 11:11:49 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v1 15/16] thermal: core: Drop the .throttle() governor
 callback
Message-ID: <ZijM1SqCg92qlQ81@mai.linaro.org>
References: <13515747.uLZWGnKmhe@kreacher>
 <2701448.BddDVKsqQX@kreacher>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2701448.BddDVKsqQX@kreacher>

On Wed, Apr 10, 2024 at 07:42:35PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since all of the governors in the tree have been switched over to using
> the new callbacks, either .trip_crossed() or .manage(), the .throttle()
> governor callback is not used any more, so drop it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

