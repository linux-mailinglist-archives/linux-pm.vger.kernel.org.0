Return-Path: <linux-pm+bounces-19701-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CB89FB0DD
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 16:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4C51883ED2
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 15:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465FF18787F;
	Mon, 23 Dec 2024 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUTq+Alc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117C91392;
	Mon, 23 Dec 2024 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734968780; cv=none; b=D5buUH+oDjVadx15Ses1kcbXoI3cXne7Pmq84kT3kgNV1ejmbzCQNOagLvWlFa6a4E8DhKzzEO1liIs/hfGtyXBpHHfDxx/rgx9soRDMQrbC3x/UUHar8LLxrGpiGZKlleNgb4szeg+HDGgqcLBVugmrn5i1Yj4DFFmuzE0vwdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734968780; c=relaxed/simple;
	bh=uop49uBpbXqej56ftuAFpY8UMjB+pj1mTC0k/vppsbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5QdJy0X/2dNPbE1TCCEXeynZJTsTn43uzDHUy4IbkEiW7myB6kW7lzjNQDJqotmTmEKNTCkwr7TW+jrBcaXhf9UyK0RqgptjxJxULqRjNqwdh0/9d5KX7ovOFKvgRPJw1nHmccuZEBRKJ8TZdJCnHnwyS8O0u5U+bMq/Js9dTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUTq+Alc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92B8C4CED3;
	Mon, 23 Dec 2024 15:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734968778;
	bh=uop49uBpbXqej56ftuAFpY8UMjB+pj1mTC0k/vppsbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CUTq+AlcbWZIxPvj6Aig2mJxJDsT+jiJ5i2uVOX7UJhmOvMVEkXwJiZLOBAGnlnIL
	 Sx4Q03dJl2acLRJSM0YeBPiXEWAXpxo9wkE4izO89aRnZcV6lMIs/kOv02iC8j3Q4j
	 5eTJES6BOAmDUSmJTa+D7aF7bRnzGJCJ5320p8FZE98K6+pRnYfFU2gG5/XuJC5oPX
	 2m9ky/Wit7RybrEDHN3z97nMx0WXTbI1fmpkQ+aZz8BVsb8FwZrPR91GPpiOBtxDmi
	 nllP1Clh37BE2KPQ0TsSccJdPhDypRyFiiOWSj3vZkDn3r1puT9FhheqfVGXnJm5cC
	 yCllaI+wsAo0A==
Date: Mon, 23 Dec 2024 16:46:15 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
	Purism Kernel Team <kernel@puri.sm>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v13 03/10] dt-bindings: power: supply: add maxim,max77705
 charger
Message-ID: <ag42llsb7oq7xlf4ouq2cfhux6s2yqzfqzzeu6coclhyu66sts@36evxbbdbfnn>
References: <20241223-starqltechn_integration_upstream-v13-0-fbc610c70832@gmail.com>
 <20241223-starqltechn_integration_upstream-v13-3-fbc610c70832@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241223-starqltechn_integration_upstream-v13-3-fbc610c70832@gmail.com>

On Mon, Dec 23, 2024 at 04:59:40PM +0300, Dzmitry Sankouski wrote:
> +allOf:
> +  - $ref: power-supply.yaml#
> +
> +properties:
> +  compatible:
> +    const: maxim,max77705-charger
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - reg
> +  - compatible

Apologies for not completing review last time (or not noticing it
earlier): please reverse reg and compatible, to match what's in
properties: block.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


