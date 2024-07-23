Return-Path: <linux-pm+bounces-11317-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5E8939891
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 05:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC4151C215B8
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 03:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECEC13B7A6;
	Tue, 23 Jul 2024 03:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6EASUze"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9692813A241;
	Tue, 23 Jul 2024 03:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721704123; cv=none; b=XkzKqj4g9dG8zBHnv1xVD/hEsca26tMr+YSztkvTccJljZBLpgRzKho/V1W2xpIwvjJDEWz3n6oaewKOdHrtFAMW7+yug4UmgJgU/jmhXoflLQWfmKreJsIMF+QRY/vUrzg/39eQBuN8iEIGalLF95FOjeaLO6l35ZpRJ+AQ1VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721704123; c=relaxed/simple;
	bh=lCpxy95lx+Jjei/kZQBV3BIgkddjlRM1fYb5FYkdFxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErZmjWHlnszfrvhYSxWVIM5seRudB1YOPyunRnYpuVlh2FSOnECzhcuCsySjHpSrqq4iIZdoCXuwvXr1e/Y1amzvhDbzr+68ThJ/nTi/6bzXOpwQKI9BoQQRjvQ/7t6F9y4jMu2ma8WkDHvK6OYQ4UqcNLxsC+W3PwhfrHECApQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6EASUze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C70C116B1;
	Tue, 23 Jul 2024 03:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721704123;
	bh=lCpxy95lx+Jjei/kZQBV3BIgkddjlRM1fYb5FYkdFxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D6EASUzeZCvDJcQWdoO2YAHDSFfg5YuzE+EgXygaqPKmt8Fex6G4OnKpatzquZGfk
	 Z6E8R3o/A1L0LJDvll+Cm4xajkinXYSubPnrea/kXAvlc/mAKh3IBIjKB9zfi8aX3u
	 YTKYqb2ErQ+zVmQJ4ppvxcYPSucJHeplJL16EF5gPoEegG3WtAbb2folVLxH0ya1ed
	 zcRGJycFne07+BKbdJr9QYudB+tVFgdSaq4MVYHrhO8LeaFjsr9OglheKwwu5yXHmo
	 qEfvoz6EMV5yO65xVKPDNIg2kAmJ9jfqATOiP17bY49AKTCWJ8zZx968+UJoTmf0Rr
	 w7J3bB+JsFRRQ==
Date: Mon, 22 Jul 2024 21:08:40 -0600
From: Rob Herring <robh@kernel.org>
To: Mateusz Majewski <m.majewski2@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [PATCH 6/6] dt-bindings: thermal: samsung,exynos: remove
 outdated information on trip point count
Message-ID: <20240723030840.GA226948-robh@kernel.org>
References: <20240719120853.1924771-1-m.majewski2@samsung.com>
 <CGME20240719120949eucas1p1b061c716ac55b4a79ba57c407c0b2d91@eucas1p1.samsung.com>
 <20240719120853.1924771-7-m.majewski2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719120853.1924771-7-m.majewski2@samsung.com>

On Fri, Jul 19, 2024 at 02:08:50PM +0200, Mateusz Majewski wrote:
> This is not true as of commit 5314b1543787 ("thermal/drivers/exynos: Use
> set_trips ops").
> 
> Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
> ---
>  .../bindings/thermal/samsung,exynos-thermal.yaml           | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
> index 4363ee625339..5a82764a4dbb 100644
> --- a/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
> @@ -40,11 +40,8 @@ properties:
>    interrupts:
>      description: |
>        The Exynos TMU supports generating interrupts when reaching given
> -      temperature thresholds. Number of supported thermal trip points depends
> -      on the SoC (only first trip points defined in DT will be configured)::
> -       - most of SoC: 4
> -       - samsung,exynos5433-tmu: 8
> -       - samsung,exynos7-tmu: 8
> +      temperature thresholds. The trip points will be set dynamically in
> +      runtime, which means there is no limit on the number of trip points.

How can the hardware change how many trip points it supports?

>      maxItems: 1
>  
>    reg:
> -- 
> 2.45.1
> 

