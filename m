Return-Path: <linux-pm+bounces-33809-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEDEB434FB
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 10:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289B51891257
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 08:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010292BE7BA;
	Thu,  4 Sep 2025 08:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5HYk2ZR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF9A2356B9;
	Thu,  4 Sep 2025 08:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756973380; cv=none; b=Sb4W89+9OjuHbDqykLy+70U89HHncqMVb2phh35HYX6Pht4czoUViLZzpfwlyqCLF/uBvj/lqtbOUV2QiP3SVWh4w5ZMmpKQlG9Yc7djscN4VZ4w5qH11cBwWj2IPbEkvK4Sh5dYSI/bCSVUinwwqzN+iadMukVH97rebjT7AYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756973380; c=relaxed/simple;
	bh=qkE3ubDGMdiTeUVZkhKENg3iBmmcENjcbXJj/EDA/H8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tg5zOEhGXMr4E9dPPCE7JBw/TEKIyCfxYLKnCissFFFWFi0dwPJub07yqLz7uhbYfFCuyD5nki48/0/69F/RkeZ8SsWFMcLzlL+ZfDKrgIpI8lJ0T6P7wnSULwmEFxUxfXK72PB021KNNPeLxJw1IQEbWvq1AkWqEG+iYZtpqRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5HYk2ZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAF4C4CEF0;
	Thu,  4 Sep 2025 08:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756973380;
	bh=qkE3ubDGMdiTeUVZkhKENg3iBmmcENjcbXJj/EDA/H8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n5HYk2ZRqQv4Of0WDHGaKIqdOCkOk4njZJc38vDpJ/JJTdKXZ8MGFgKU3N5KziyzZ
	 aYNO8MFiX3u68miWDcGtDjDI4bo6xnwxpi7SYdAWO7M6TauaITIx0PrjdTAQWK+hwU
	 iIxQeQTsX6HiJxVpXq/FHCsycfcdaJ6rI7rMV6cWTd49J4lj7SlHwpOQTm5cDE4TF4
	 3kPqq8iUvOiii+YasIUHTU1xVXb90E9yJLFhAcqciWvbHpSiqDaGRe7qR4SF22OW8c
	 cYnv1EqiAk1Bn6yBX/lvbGhRJoM+cwv4znSDWf3/8Z6COEgI0UnKSjm0toHrZOipXC
	 t8CoHWfTfaeqQ==
Date: Thu, 4 Sep 2025 10:09:37 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Dmitry Osipenko <digetx@gmail.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/8] dt-bindings: devfreq: tegra30-actmon: Add
 Tegra124 fallback for Tegra210
Message-ID: <20250904-nice-fresh-lion-0d718b@kuoka>
References: <20250903-t210-actmon-v2-0-e0d534d4f8ea@gmail.com>
 <20250903-t210-actmon-v2-2-e0d534d4f8ea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250903-t210-actmon-v2-2-e0d534d4f8ea@gmail.com>

On Wed, Sep 03, 2025 at 02:50:08PM -0500, Aaron Kling wrote:
> The Tegra210 actmon is compatible with the existing Tegra124 driver.
> Describe the compatibles as such.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  .../devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml  | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


