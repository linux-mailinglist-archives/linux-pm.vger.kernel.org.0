Return-Path: <linux-pm+bounces-32855-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B14B30C74
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 05:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 100264E04FC
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 03:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FC7289E08;
	Fri, 22 Aug 2025 03:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="oEPWH/gz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D8A22172C;
	Fri, 22 Aug 2025 03:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755832845; cv=none; b=TgOUkjzn00zYa6dor8sZr2Z95wUVl/Vn2r2Hziin5ezaNctcZ+BKOu8XwrPykQRGqY9ZTQ3xSzSf9vyI18EeILntUvMF8zYc9AkT8w/QMbSA1l/QB9e3gHSm2E1njrbAlRxKrbkU4TQAoMdGy73rcCUl+xGQ1riLwEsoBObfu1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755832845; c=relaxed/simple;
	bh=D+BEUaDZ2sK7ZJxEfqc3LcWo/ohH8HIPEE8rKADLHVQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=H4MOtOeK6habpST5uwR5rINLEo1mdjwlH5fxo9gyFcFAQmXJAc0w4Fz9RmdqJXlJ54Ebwxqybs+gAI4lDgiJyZ19eoMy7v8o7CMKQolh0MnFni+WvPL5JVZ3ZpArIkm47IrTweeQBT2Y8GGU3d8VIFt7b53QBkX6FW1qXwsgj4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=oEPWH/gz; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1755832841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r1MSjRRE6yUSWPMHEAUcp2VekQ/i3BRrfkltmpMLCjI=;
	b=oEPWH/gzrsp0qyfpLjduleSsCJb5NJaDYPeQ5XRapK/9fSiqFDHXyoAUnFzYvmb7xO9/vQ
	Lf4kmy4bIuCpsJUApQHN19NVC5u2P4dMDr9gXb3G0Rw/qZBHAvNb2uuEXxMDQoUjL4SK8C
	QKd6jpXXxL30QWV3paSXwCV1xb98C8FbK1zxlUPuo2DLMQf7I4WmOjeDz+5swCz4hCne8y
	OxLPVHTDuYPUqrf5Ere4y4rpId+jusXSoAjMyh06xH56khmJcCGUP3iC9QWLYNArR+fVFl
	wvE/61iNjD3lqt/CkUCkdHwLI8LkON9qs1sUe1dMOnfo9ZQv5Z5JFJrsw/mpPA==
Date: Fri, 22 Aug 2025 05:20:40 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
 <lukasz.luba@arm.com>, Heiko Stuebner <heiko@sntech.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Diederik de Haas
 <didi.debian@cknow.org>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH v2 3/3] dt-bindings: thermal: rockchip: tighten grf
 requirements
In-Reply-To: <20250820-thermal-rockchip-grf-warning-v2-3-c7e2d35017b8@kernel.org>
References: <20250820-thermal-rockchip-grf-warning-v2-0-c7e2d35017b8@kernel.org>
 <20250820-thermal-rockchip-grf-warning-v2-3-c7e2d35017b8@kernel.org>
Message-ID: <9ca53c3ee08a0e1c25adf916376f9a65@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Sebastian,

On 2025-08-20 19:40, Sebastian Reichel wrote:
> Instead of having an optional rockchip,grf property, forbid using it on
> platforms without registers in a GRF being needed for thermal 
> monitoring
> and make it mandatory on the platforms actually needing it.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../devicetree/bindings/thermal/rockchip-thermal.yaml     | 15 
> +++++++++++++++
>  1 file changed, 15 insertions(+)

Thanks for the patch!  It matches what's already presented in your
patch 2/3, so it's looking good to me. Please feel free to include

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> diff --git
> a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
> b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
> index
> 573f447cc26ed7100638277598b0e745d436fd01..9fa5c4c49d76e3a689f31797875124e7fb30d3df
> 100644
> --- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
> @@ -119,6 +119,21 @@ required:
>    - resets
> 
>  allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - rockchip,px30-tsadc
> +              - rockchip,rk3366-tsadc
> +              - rockchip,rk3399-tsadc
> +              - rockchip,rk3568-tsadc
> +    then:
> +      required:
> +        - rockchip,grf
> +    else:
> +      properties:
> +        rockchip,grf: false
>    - if:
>        not:
>          properties:

