Return-Path: <linux-pm+bounces-19186-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7939F0A4C
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 12:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E7A1889E22
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 11:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92D41C9DC6;
	Fri, 13 Dec 2024 11:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCTtHUZ2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798A61C3C0D;
	Fri, 13 Dec 2024 11:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734087650; cv=none; b=aB162fH6UknkMZZlp2pt83XGtA8115A1IiisTejytArnELauP2Qzk6VBWFLmeO2fZ5qRq4oCkfZlnAxAvqEN3covZeTYU/0YZyJETXPl7ZbmxZl4mnmtU0VE0gwNiEg/GqzWhQUQlM8jPrtZIOrF7WG6q7PQmhy7z8LAdbwsqsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734087650; c=relaxed/simple;
	bh=xPaMFLDu/nqHKKwyxV+rOSMISn75qqvM0XYS7WHwLm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYtpApwoYHkNrKK0VMhfpaUcETHsiizu34lrR8k0WIn2m8Tvcr5O84aItKomh39p0zkLbxNe8iEaPmXz9L3qZkZ/Xi2wKpkqr87b5c+/F/XUwtkc7+JdxYxvtdd4EVsWtYxthk3EvBLQnRVhtCUKbsXrhkYk+QMUrXOFJPU06B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCTtHUZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1F5C4CED0;
	Fri, 13 Dec 2024 11:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734087650;
	bh=xPaMFLDu/nqHKKwyxV+rOSMISn75qqvM0XYS7WHwLm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KCTtHUZ2gVegt6m+OrBB7y4SCt2ZBKFaFwu1SPqbNnnseaJ0DA8SifYwRV4jrFIw2
	 aSxC4v4Ys6jG+wRxdWvepBgVhrrMbSqXbS4tW5TpnxZyONZAr8EYDrdaa7drcdPYU6
	 cpYMTCTds95rfXWrMMDNfEt+yKaBOAQyjKzWfV6T3m6Fcex97a3h5xqsFnCGJrUoag
	 fIoMgfADo2muryZClr/+uRE/XkI8tsOJfa6uaipolfX4VmNxR7D8opDDfxIKAo+kqA
	 7CxNMYP0Ml6huMx2YfRnjU0Fxh1bvlIeKblQHNUK2IyyDP51V2asbjcELaCg3RXfrI
	 A6sjTO/KN1FTw==
Date: Fri, 13 Dec 2024 12:00:46 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: gpio-charger: add
 support for default charge current limit
Message-ID: <4lef2r5lblj5waulkc56xbfa4xnlxbrk7rawdjgmkatgfnlj3z@vmtcvza6wcna>
References: <20241211-default-charge-current-limit-v1-0-7819ba06ee2a@liebherr.com>
 <20241211-default-charge-current-limit-v1-1-7819ba06ee2a@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211-default-charge-current-limit-v1-1-7819ba06ee2a@liebherr.com>

On Wed, Dec 11, 2024 at 08:29:09AM +0100, Dimitri Fedrau wrote:
> Add binding for default charge current limit.

Why?

> 
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---
>  Documentation/devicetree/bindings/power/supply/gpio-charger.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> index 89f8e2bcb2d7836c6a4308aff51721bd83fa3ba1..545fdd7133daf67b5bc238c5af26d0cbd8b44eae 100644
> --- a/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> @@ -58,6 +58,10 @@ properties:
>              charge-current-limit-gpios property. Bit 1 second to last
>              GPIO and so on.
>  
> +  charge-current-limit-default:

Use standard property suffixes - see other bindings how they define
charge current.
git grep charge -- Documentation/devicetree/bindings/power/supply/

But what I don't get is why GPIO chager needs it, since this is
non-configurable for GPIO charger.

You have entire commit msg or property description to explain such
things.

Best regards,
Krzysztof


