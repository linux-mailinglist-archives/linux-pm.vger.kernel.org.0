Return-Path: <linux-pm+bounces-16804-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5D49B7585
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 08:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 511DF281C4F
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 07:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C0E14B08C;
	Thu, 31 Oct 2024 07:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhzZduIs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8FA14A619;
	Thu, 31 Oct 2024 07:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730360573; cv=none; b=AooP4ZcQeXP2BQtRdGG24liZvh9CYw9hckn8UwMODNYfJ2VVLyIvaQs0A0zACiRnVNm2j3VzLP8HqcfaIVTJ1aUepMXjiQUxVhIIY3sf+0nvzeU2dm9cuCE1rfagQNEwsSI+AAos7l42dr9+XEh+83v2wn9vkPXh/75BJfTR0lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730360573; c=relaxed/simple;
	bh=cKqO+HacNDsYOGX1oXC/gkePXadnPjS5KOgqUQC17uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWDmRfWL3WbTjpUBqMli/Qu5YKgdxX+1B5XqYG74SMDVKNlrjq8CVlmlWAtFXvaeVInkuX1qZ3P/91KA+9uUPlL00OqZqix9JPE0JxjLvgjBRoVsopocDv0VWhlrRFMwouR1sEFN4x4Ha1+MbRvwDnceQ1uOYsch02OriM5p/5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhzZduIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7621C4CEC3;
	Thu, 31 Oct 2024 07:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730360572;
	bh=cKqO+HacNDsYOGX1oXC/gkePXadnPjS5KOgqUQC17uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LhzZduIsTLE6KmsEKbW1O8sF8COg0PID66sl16MUGDwWFLNDMt4WnDIxrgUdQIb85
	 bY9WRwqdcj5/n5SfhLufBmHB7Ao6fZD1ZBCBC45+pRCJ1/Z7IBLuC4SNza/FkujWP9
	 JVfy7d7o7Tx9hhjauRbtg10ChC0bDwV6wkZUyhd7BlZsXt1hgnqGNNw8YsFVN+TAVS
	 teqzBBA8m8s3c1+rzIxw6IRE9LHhHxllIC1gZ5OoUX2soOKrtV3k66za5iEd7BrWXV
	 SixWZapnydK8F1EbKgrC7JsI5/ep/eQmSsOn2VwyAIJA2jsBfY3w3X3uEwIIBBsIao
	 yXV6wZ7YYHARQ==
Date: Thu, 31 Oct 2024 08:42:49 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Cody Eksal <masterr3c0rd@epochal.quest>
Cc: Yangtao Li <tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Ripard <mripard@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Parthiban <parthiban@linumiz.com>, 
	Andre Przywara <andre.przywara@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/13] dt-bindings: opp: h6: Add A100 operating points
Message-ID: <4flk2ub5dldqfv7wd7ytmmnvyvwqb7fxhw6eut2fpatnoms5li@kwehlp4mhytf>
References: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
 <20241031070232.1793078-12-masterr3c0rd@epochal.quest>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241031070232.1793078-12-masterr3c0rd@epochal.quest>

On Thu, Oct 31, 2024 at 04:02:24AM -0300, Cody Eksal wrote:
> The A100, similar to the H6 and H616, use an NVMEM value to determine
> speed binnings. The method used is similar to that of the H6. However,
> the information is stored at a slightly different bit offset.
> 
> Add a new compatible for the A100.
> 
> Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
> ---
> Changes in V2:
>  - Fix ordering of compatibles

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


