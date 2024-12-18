Return-Path: <linux-pm+bounces-19411-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F379F601A
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 09:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18F7F1885CE7
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 08:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D33B176240;
	Wed, 18 Dec 2024 08:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXbEKV2D"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCF2155303;
	Wed, 18 Dec 2024 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734510388; cv=none; b=kx88T7eiEM1pV8uf4UZpAFNTJJBzZ5lDLkwY/PWdk5DazwvwtMjZIAff1yX311ub91qEtBIWoZYU8argMsleYiKPtbrg4h0QDQtGbtayCVFL0Ai8B4FN1ECLi3zr/7YYDyBFs4zYILuQ5IBtutY45UaUh02AB1e2cBjAUOU/S/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734510388; c=relaxed/simple;
	bh=QVhPBYKERvJOVgBZTYWRNCaWDUKp8LPmS/ncSg7LCao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5pCRJjgJj4hCZHxLA4hYtqF6aP/AhLfFcN2z0C5fECCDw9uTGzvJhK5VUR0zsaAztGn6Cn1WXCBBfg3Ag7QEyI6umDW449hmAwxxM4oYDn9xIJMKH57cV8fFPBZUqn2noku7CaPW9hTxQd3nLY/Z4PjfJ8c/LWdUlYBAI/hQ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXbEKV2D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2F4C4CED0;
	Wed, 18 Dec 2024 08:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734510387;
	bh=QVhPBYKERvJOVgBZTYWRNCaWDUKp8LPmS/ncSg7LCao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lXbEKV2DiZX9j1+B9L0QYFgqFYIW34um97+FTplgXBuFIpATbwdTvDZ85xlKlKR+v
	 Wd4EPqo4vQmWBcjC+gSIIq3b8QZO9E5BIHF/8oR/tDFWygAb5k9oong9C67/FGJ958
	 08FyAB+ptNGbVxKUrzqTQImjUZCVnTkEq5SrSuBvpvkVUtrzSOab2aPWlqoZ7zrfDz
	 ji7jF+qJpkRw7lB5FK3TShJUKUY+Ee/Uc/I4UODCCPktvATrsNeYstPaYCSL8YLz/8
	 9l3n1qyot4m+vD+OoGgpziPfZ+gPXC77e7l02PkYzA09ENDU1uShbvgnvSuDtNjFnW
	 g/gwHh6XAHpHw==
Date: Wed, 18 Dec 2024 09:26:24 +0100
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
Subject: Re: [PATCH v12 05/11] dt-bindings: mfd: add maxim,max77705 sensors
Message-ID: <d5jd4dz6v7yid3yz67qw2pam6tyr2pjb6ri5z7y2467jkgf32o@ooqefgguntyf>
References: <20241217-starqltechn_integration_upstream-v12-0-ed840944f948@gmail.com>
 <20241217-starqltechn_integration_upstream-v12-5-ed840944f948@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241217-starqltechn_integration_upstream-v12-5-ed840944f948@gmail.com>

On Tue, Dec 17, 2024 at 08:30:03PM +0300, Dzmitry Sankouski wrote:
> Add maxim,max77705 sensors binding part.
> This includes fuelgauge and voltage/current sensor on
> chip input and system bus.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/maxim,max77705-sensors.yaml | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77705-sensors.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77705-sensors.yaml
> new file mode 100644
> index 000000000000..738ce30ca72d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/maxim,max77705-sensors.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/maxim,max77705-sensors.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX77705 Companion Power Management IC sensors part
> +
> +maintainers:
> +  - Dzmitry Sankouski <dsankouski@gmail.com>
> +
> +description: |
> +  The Maxim MAX77705 is a Companion Power Management sensors part includes
> +  fuelgauge and current/voltage monitor for charger input, and system bus.
> +
> +properties:
> +  compatible:
> +    const: maxim,max77705-sensors

Apologies for missing your reply in v11, somehow I was still waiting for
your reply and only now went back and found it. Maybe my filters moved
it too aggressively, it's actually tricky to get filters properly for
responses.

About this, I don't think there is such device. Measuring current inputs
is the job of fuel gauge. It's literally this device.

What's more, you do not have here any resources which is another hint
that this is not a separate device.

Best regards,
Krzysztof


