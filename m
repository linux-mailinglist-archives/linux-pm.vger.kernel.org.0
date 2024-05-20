Return-Path: <linux-pm+bounces-7991-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 738578C9A63
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 11:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162F21F213F7
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 09:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECC91CAB0;
	Mon, 20 May 2024 09:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ABtfl/GW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B9B1C6A3
	for <linux-pm@vger.kernel.org>; Mon, 20 May 2024 09:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716197562; cv=none; b=rLqv++2EgNl5D0qPUt+KB+gKTYc0uMaqZyLndTzD2Kbi5QPl8FL0pUtjeVxnGEvfKehU9LQyH3JlwgA5JuQhVP5hgFsQ520mOWmP2TBot4C8jXhI/+afX3BHywV2y4bsx9aPNpv5D4RhLWJCCLNycTmVDdEcoQ7vW+llh3L81hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716197562; c=relaxed/simple;
	bh=6qqAt+q020TEX/srbVeaNcplSl/KDDH8/TynN7XepB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKbH8p/UQJF1ApFoQE6U5b6Se1HTfHtEwIgUkyn3lwUcY6orbSYNirnt0imyqJRLuGXtcjoSSEl7LC6g6BDWM6VegKehSCdFp9m7e0yijJV9QmICUe5q2P/rfDr69SjlLK/DtFnu0lEcFGW5zlhc9h3Ud2NklyWBGBWfis4pMCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ABtfl/GW; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f2f566a7c7so36185535ad.1
        for <linux-pm@vger.kernel.org>; Mon, 20 May 2024 02:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716197560; x=1716802360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VHjDhF8zKcuH4KaZDrxu/GGnpHyFrMbNt+nqVfo/Ty0=;
        b=ABtfl/GWJsS2j7QFjZny3VQhxa0wIOS0fY2+8mOTZKNwQds9z7xJS4JzFEM4E2lS6w
         HgPdqXISwcxph5cZi9uzJQjnFdzl8G7JuRNZw80FXOXwdCCknJ5emLRovZuuvvsLJbDx
         1xFW8SG5T3gswEpnt7HbtpARZSVroukH1WujziKqo2tMGMOeABgTeRShUib3kdO0Y3cV
         K7d0RhkEM+yFgyR5XxHozta9eC4ByBQiR04GcbB8gRJ5EzsfkeMX30dGDZ/fZ3W5Butk
         BhpSN92QbQgVjoMsACCJTp0ES/3tvjiBwro8ikRpytrhljVUfy2jywIbqozNPQ7FMdDQ
         G8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716197560; x=1716802360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHjDhF8zKcuH4KaZDrxu/GGnpHyFrMbNt+nqVfo/Ty0=;
        b=pKk/ZXPsDJbUN9jm4mZMV0r94hfDDKXh5Hlfu+QYM9rN9f+Ww64DRm0/LT0bs6hQSm
         2tRzses8b6rn0uBjN6wl68B1kjwsK+blo+jStsY49LfwT5Fhdo4HDncVMpFm4yKBzTbu
         RwyOCNgIgJ81YcT0Q/lcWCiOwgtnoWKGGTudR73Ybgu4gWj9ngBra1dVTEuj5TplVNTm
         cBKaOsj6CC114XwA8R5tdUerisAugC0QGkwKdKnMuNZyyG9UBN+7Y6jQo3pexc3kbXtj
         c+ggWntQ/E66EY0oL73/sFKECTnvpSYp+CNMoBBMwnbn2MA4dUvctcNyC1+T+zQdFfZN
         E67g==
X-Forwarded-Encrypted: i=1; AJvYcCUCKTqZHW6D2CeK3EbihrGj9c3J+SX7CV0m8lw1V/jXZWREIX0vC4reM9y4klZaAPKLMCsd7xm0NeGG7EXHPvk4qs3IYpXY6IE=
X-Gm-Message-State: AOJu0Yx7JSI6Y8JUGwqDgjRuV4iw6XWmYQncOUkh3X1Brx4ABQ+odfZ3
	h2QHVFiPw8OFJ/h1uJw9isBxVRAQBnyPQgMJIGE0DxdHLfTKbMQomqSeyyOfVh0=
X-Google-Smtp-Source: AGHT+IFa8g+pCvcfTr1oEO5S4AwyMh2Iyy71hR8SjL5gaoTIDdRqmSgGKDGc01l9L6eqB0yM0+XG+g==
X-Received: by 2002:a05:6a00:3a01:b0:6ed:5f64:2ff4 with SMTP id d2e1a72fcca58-6f4e02af0d1mr31874819b3a.14.1716197560387;
        Mon, 20 May 2024 02:32:40 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-65e149dd925sm5500703a12.58.2024.05.20.02.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 02:32:39 -0700 (PDT)
Date: Mon, 20 May 2024 15:02:37 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] cpufreq: sun50i: fix memory leak and remove
 of_node_put()
Message-ID: <20240520093237.fucml6sp2ziygyav@vireshk-i7>
References: <20240503-sun50i-cpufreq-nvmem-cleanup-v1-0-0a2352cac46b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503-sun50i-cpufreq-nvmem-cleanup-v1-0-0a2352cac46b@gmail.com>

On 03-05-24, 19:52, Javier Carrasco wrote:
> This series fixes a memory leak by means of the _scoped version of the
> for_each_child_of_node() loop, which was recently introduced with
> 34af4554fb0c ("of: Introduce for_each_*_child_of_node_scoped() to
> automate of_node_put() handling").
> 
> The new approach is still not widely used, but this might be a good
> occasion to use it in a driver because it actually fixes a bug, and
> the loop is rather simple.
> 
> The creator of the new macro was added to the discussion in case the
> new approach is still not mature enough, even for such simple case.
> 
> Additionally, the existing uses of of_node_put() have been removed to
> favour the _free() cleanup handler, which reduces the chances of having
> any other memory leak because some of_node_put() is missing as well as
> simplifies the current code.
> 
> I don't have the real hardware to test the series, so I "faked" the node
> in a device tree for an arm64 device (Rockchip) and hacked the driver
> to get to run dt_has_supported_hw(). The new implementation works as
> expected, but if someone wants to test it with the proper SoC,
> additional tests are always welcome. The same applies for the removals
> of of_node_put().
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> Javier Carrasco (2):
>       cpufreq: sun50i: fix memory leak in dt_has_supported_hw()
>       cpufreq: sun50i: replace of_node_put() with automatic cleanup handler

Applied. Thanks.

-- 
viresh

