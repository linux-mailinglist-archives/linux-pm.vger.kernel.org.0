Return-Path: <linux-pm+bounces-11684-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A250F941824
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 18:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59E151F2546F
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 16:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79077189901;
	Tue, 30 Jul 2024 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afeRAfvX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466DD189516;
	Tue, 30 Jul 2024 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356270; cv=none; b=CJTGa6WCmCsnDRZcRDHg0uF3tC51QVSd5O055KGy16M1OyH2gFh/JpytlS/iCgSJaGp8jCnK0Cnmyy8na+hZONzWb19YoJMhmqx25rYSotOg1oN688aAdq/CreXIM65SXIMs69sppt4UUC+WW3d1ECYffJdotEhWqElx1xi26m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356270; c=relaxed/simple;
	bh=OGxKQ4I9St0tmE2nsVXT+IFnBRjjfbo0RmqqbjRFRUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udCjmI2tuVjzFwoA6AwIg61ACtpq2nMN+nJtOYIMUaqaPSCMY+Lf+KBPq+HbYPe1rn9TtngVpEPxuNgehLFROyYntRQyZzTeMtq4AE+ICrkZxFLyzQlykmP46ss6hjnDgi3cZHtK1fBESjKkax3IdVHQJl5gppb3yndxGN77MHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afeRAfvX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDBCC4AF0A;
	Tue, 30 Jul 2024 16:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722356270;
	bh=OGxKQ4I9St0tmE2nsVXT+IFnBRjjfbo0RmqqbjRFRUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=afeRAfvXyF4qzTQqkpPROjhSChSjFnVo9K+eR6y96JuNLk+SoBy0eW+ihXGbBY6CH
	 kOH+HdzCgTbu9JU9gyghbRXqeVz67ymKy7JDxPPgvVUmxQSEgIWZ+biVRW0cx1ip4O
	 2lpnQNa3CdZInm8Y/FJC8Yy9vhAOlFTwBd+Sxoydyvud70ahzDDgQ36d0ITlHtIBKC
	 qPsWLw5V5pq5FsdTbp404HlsT0A+s8oToxUzC1trA6Y0XkIrJvZBVz5ph4HiVBlHja
	 x3TTUtFWICBcVzcxa0vWhmkSa90ATABlcVcmqcU3H+VzuZDp2eWk2wvErrI56lymIm
	 beKhcOp7o77Mg==
Date: Tue, 30 Jul 2024 10:17:48 -0600
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
	Alim Akhtar <alim.akhtar@samsung.com>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH v2 6/6] dt-bindings: thermal: samsung,exynos: remove
 outdated information on trip point count
Message-ID: <20240730161748.GA1414176-robh@kernel.org>
References: <20240726110114.1509733-1-m.majewski2@samsung.com>
 <CGME20240726110142eucas1p29f261e5e81c177456fd5bb5546871eb4@eucas1p2.samsung.com>
 <20240726110114.1509733-7-m.majewski2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726110114.1509733-7-m.majewski2@samsung.com>

On Fri, Jul 26, 2024 at 01:01:10PM +0200, Mateusz Majewski wrote:
> This is not true as of commit 5314b1543787 ("thermal/drivers/exynos: Use
> set_trips ops").

What is not true?

How can the h/w change? I already asked that. Please make your commit 
message summarize prior discussions so that the patch stands on its own 
and you don't get the same response again. Assume the reviewers have 0 
recollection of the prior versions because we don't. This is just one of 
100s of patches a week...

> 
> Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
> ---
> v1 -> v2: remove an unnecessary sentence.
> 
>  .../devicetree/bindings/thermal/samsung,exynos-thermal.yaml | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
> index b8c0bb7f4263..b85b4c420cd3 100644
> --- a/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
> @@ -40,11 +40,7 @@ properties:
>    interrupts:
>      description: |
>        The Exynos TMU supports generating interrupts when reaching given
> -      temperature thresholds. Number of supported thermal trip points depends
> -      on the SoC (only first trip points defined in DT will be configured)::
> -       - most of SoC: 4
> -       - samsung,exynos5433-tmu: 8
> -       - samsung,exynos7-tmu: 8
> +      temperature thresholds.
>      maxItems: 1
>  
>    reg:
> -- 
> 2.45.1
> 

