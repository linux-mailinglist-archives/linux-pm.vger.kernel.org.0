Return-Path: <linux-pm+bounces-25893-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DE2A9655C
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 12:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 790877AA6F6
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 10:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32CE201262;
	Tue, 22 Apr 2025 10:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdgRI5u2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729401531E9;
	Tue, 22 Apr 2025 10:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745316336; cv=none; b=C1R8NKkgSUwUJGTQpD2QPFjXUYiaAOaiSDD2YJLYQvXYhJA1vRa9opQcIriGPiG4d6+4qjT+7LVl3E3mwmpRujNsoB8LUhMjsyHJAGmEsIaAYZBv98NoAH8uG5/bYNQpyUiQYxRdXrFuSV3pd3Vu3LflnDLmax351nxY8BQR+i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745316336; c=relaxed/simple;
	bh=MCyas/ZQmYRO09vMAKd2USMq+gG5S05o1bktOFmHhNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gT3cy+0XpINvXsgig8XCOQESzEKnkvjYsDTKAfOa4SWAHh2aOgGy0FtUQBLwLMEOTga9byNzYrKtYmbDtEwmNA2Iu0HQAbHkH24JTBDm76OeAPhXze1eizkj1LjR8fDBEkTZE/Cn5m3QMzQ8GC2xN3i2QSA09COdK5D3wVObWZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdgRI5u2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4C3C4CEE9;
	Tue, 22 Apr 2025 10:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745316335;
	bh=MCyas/ZQmYRO09vMAKd2USMq+gG5S05o1bktOFmHhNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TdgRI5u2eSVDkgPTyjkZeU9I2EZJMTtkmgGFzP4nGBa+cBskbl3uPU+QVvemp7Wi3
	 xeO6ReDhaeJPrA1YOGZDQ5rt5yxJbyhavge4ibVUbYmHsrY0KKVZoaN9zSjIF/dPSW
	 TlUjjDUguI4NB8dOsfUcKJUQFx1PS53+dPVmS14eOjeFCIM+lC9L/SY+Tc5IvIVbPF
	 uEwx3pdOoTz3GxGpPtr0qqAt7mAH1BvVM/ohs862zQ5ozkhy7gitskklDI9JMc1QE+
	 VR/loMlqCBpT5DYXb8dG3MTCOvHSeo6/MWfu9UMQgqzOqJVq64fp6wFmm+9BJLVMQ2
	 Tj1O6BHLccrSw==
Date: Tue, 22 Apr 2025 12:05:31 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Thomas Antoine <t.antoine@uclouvain.be>
Cc: Rob Herring <robh@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, =?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 3/5] dt-bindings: power: supply: add max77759-fg flavor
Message-ID: <20250422-tireless-swine-of-fascination-6eba8b@kuoka>
References: <20250421-b4-gs101_max77759_fg-v3-0-50cd8caf9017@uclouvain.be>
 <20250421-b4-gs101_max77759_fg-v3-3-50cd8caf9017@uclouvain.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250421-b4-gs101_max77759_fg-v3-3-50cd8caf9017@uclouvain.be>

On Mon, Apr 21, 2025 at 08:13:34PM GMT, Thomas Antoine wrote:
> +allOf:
> +  - $ref: power-supply.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - maxim,max17201
> +    then:
> +      properties:
> +        reg:
> +          minItems: 2
> +          maxItems: 2
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - maxim,max77759-fg
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            minItems: 1

If there is going to be resend, drop minItems.

> +            maxItems: 1
> +        shunt-resistor-micro-ohms:
> +          description: The value of current sense resistor in microohms.

Property should be defined top-level list of properties and in other
variant if:then: you disallow it if it is not applicable at all
(shunt-resistor-micro-ohms: false).

Best regards,
Krzysztof


