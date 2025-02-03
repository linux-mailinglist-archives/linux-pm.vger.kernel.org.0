Return-Path: <linux-pm+bounces-21253-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC0AA2532F
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2025 08:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1DA73A3627
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2025 07:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E354D599;
	Mon,  3 Feb 2025 07:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edWnDBwK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9695F1C695;
	Mon,  3 Feb 2025 07:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738568741; cv=none; b=ZQusTBrcWxtshTqQRf/Y2pvWVTQKlXuD5FNE2NXEkMOpth++jPQWz/bD2qMoKER1qdgl+qNiAdDj7qEzuQw7f3nLOB2JonCgIqD5lonAx4UqEyvBnJ/amNxjr+j3nasrjAXuI+PgIGkkOIsaVYm2HedZCHoaO2EZY6C8U46gCzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738568741; c=relaxed/simple;
	bh=sM+SEmMVh612/29K7P8n4XH60Fcz6ZprPPmuPQhpZ5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOyXtff287JWQw4FHzK4xolBFx/OcTLIzJHPkgDtoS+GNsESXfjrZsS1fuB1gsl61pnmRDiH0KnAg400f9kSHotJydXqNLRQ+oV+Kag1l2BLLyQZS5TfTdADC9udWqyRFFriqne+S0UTG4MRWvZvnhfcqiB9tv1oGHWCAw8++N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edWnDBwK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E109C4CEE2;
	Mon,  3 Feb 2025 07:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738568741;
	bh=sM+SEmMVh612/29K7P8n4XH60Fcz6ZprPPmuPQhpZ5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=edWnDBwK1Scbfos/qzlkzU9ai3+7U6zajsvqn66liiwU9Lc1C+yCaW0j3RgA7gpIv
	 8UrJ2iBzBegjmvyBwRdd/nsyu9nlsFyhb9gS1hNPNzaFPfJ6zH363UefRZ6G0ADJiR
	 UCfZiL2lA/P1EhtFHpeKnMSVMFHzyTyBm3aOsTtFNO8CixQtaKeo3kAhjnn8LndYpJ
	 SfCBdCrHlW60MySmqiBaPDBBurczQPn4kTdNkNFBFKypQqo+cs1IEun2uUVHNnLrts
	 lOX7deqtFaE8h6PzVXYyQFdspVR/MNv1nc0FkWmbL5JfqvZH1VzeLf/hGP5DBOJ5Ju
	 P7mfu16wkUbUw==
Date: Mon, 3 Feb 2025 08:45:37 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, lee@kernel.org, samuel@sholland.org, jernej.skrabec@gmail.com, 
	wens@csie.org, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, 
	sre@kernel.org, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 2/5] dt-bindings: power: supply: axp20x-battery: Add
 x-powers,no-thermistor
Message-ID: <20250203-translucent-mature-deer-1538de@krzk-bin>
References: <20250131231455.153447-1-macroalpha82@gmail.com>
 <20250131231455.153447-3-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250131231455.153447-3-macroalpha82@gmail.com>

On Fri, Jan 31, 2025 at 05:14:52PM -0600, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add the vendor specific boolean property of x-powers,no-thermistor.
> This property optionally describes hardware where no thermistor is
> present on the battery and is specific to the AXP717. In rare
> circumstances this value can be set incorrectly in the efuse of the
> PMIC, and if it is not hard-coded the device will fail to charge.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  .../x-powers,axp20x-battery-power-supply.yaml | 22 ++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
> index 5ccd375eb294..e0f134a13f7e 100644
> --- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
> @@ -14,9 +14,6 @@ maintainers:
>    - Chen-Yu Tsai <wens@csie.org>
>    - Sebastian Reichel <sre@kernel.org>
>  
> -allOf:
> -  - $ref: power-supply.yaml#
> -
>  properties:
>    compatible:
>      oneOf:
> @@ -35,7 +32,26 @@ properties:
>        this gauge.
>      $ref: /schemas/types.yaml#/definitions/phandle
>  
> +  x-powers,no-thermistor:
> +    type: boolean
> +    description: Indicates that no thermistor is connected to the TS pin
> +
>  required:
>    - compatible
>  
> +allOf:
> +  - $ref: power-supply.yaml#
> +  - if:

This could be simpler - use not: here.

> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - x-powers,axp717-battery-power-supply

Anyway,

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


