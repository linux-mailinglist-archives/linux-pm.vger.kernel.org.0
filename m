Return-Path: <linux-pm+bounces-27692-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E064FAC5ACC
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 21:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F0B1BC1FD8
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 19:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFF028A3E0;
	Tue, 27 May 2025 19:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhPia81T"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3916B25484A;
	Tue, 27 May 2025 19:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748374482; cv=none; b=an1cWjHg285W1rX7TgCJSUMpnJ/dLoHY5/XLckRCACfc9pZLc1p1yvxHhlKlsnpVAmTPze5M3QPYjudHD/8R91K8/sfLUadjMhMGU1MR4MJH7xdIQ7tNkp6345WpXS+od6xkUsR8Ih2SPQ6Rcfus9zINCUNgYAICo5pG5p/0+P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748374482; c=relaxed/simple;
	bh=/h34jjkP8Tzegi+t/1woEurKobo1VjvZzZ4R9+gNIYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFOnbZwgom4calTvloNjmOvTpRSJaLzgFSwq7f70CNL1i3QFCe7nHn7+K9L9wz4dwRn3W+JKo4p6O3mcsWE4QgT/3qvlgC9+f08tMYYgArQr56G+7/HnRU8PwNqOag8KjY4eFXR4kI9ZIb+xkHAGtpB14W7PwKDTaesIDWruJQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhPia81T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F4EC4CEE9;
	Tue, 27 May 2025 19:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748374481;
	bh=/h34jjkP8Tzegi+t/1woEurKobo1VjvZzZ4R9+gNIYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PhPia81TIe3Dg79bgkliFloVIeCDISxZ9ufFJkL734ooVeE42cK1mFQALvIa9AbE4
	 QI4jwwMZ9XrTAwd15ptjEXrUHPE/nISJ5rODk1d5EmiDpaBNKM9YBI5A+BwZDpy43H
	 kr0AAkQcOPTwsKF05CuEUo82vtXjtc6a9H1B/d2eldgiRIsq8InCm6vnc/+cirvBzh
	 2czuBVSw9jlEmNYRKFnzdjoeEGsDHSt29e+YbKnwNQqhvRfbmkOC6XvayihEQKhVAd
	 OfmlM36ik/twqLUlPYRb3J1Ap0vCIcoEfYQwnZon2N7aPqrVRPkH35sMh5MfTvOl7Y
	 akViLmW9olW5w==
Date: Tue, 27 May 2025 14:34:39 -0500
From: Rob Herring <robh@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>, linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] dt-bindings: gpio: rockchip: Allow use of a
 power-domain
Message-ID: <20250527193439.GA1101149-robh@kernel.org>
References: <20250518220707.669515-1-jonas@kwiboo.se>
 <20250518220707.669515-7-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250518220707.669515-7-jonas@kwiboo.se>

On Sun, May 18, 2025 at 10:06:53PM +0000, Jonas Karlman wrote:
> The GPIO controllers in most Rockchip SoCs are part or power domains
> that are always powered on, i.e. PD_BUS or PD_PMU.

Are these described in DT, so this is valid to add for all SoCs?

> On RK3528 the GPIO controllers are spread out among the PD_RKVENC, PD_VO
> and PD_VPU power domains.

So should be required for RK3528?

> 
> Add support to describe power-domains for the GPIO controllers.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml b/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
> index d76987ce8e50..bdd83f42615c 100644
> --- a/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
> +++ b/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
> @@ -41,6 +41,9 @@ properties:
>    "#interrupt-cells":
>      const: 2
>  
> +  power-domains:
> +    maxItems: 1
> +
>  patternProperties:
>    "^.+-hog(-[0-9]+)?$":
>      type: object
> -- 
> 2.49.0
> 

