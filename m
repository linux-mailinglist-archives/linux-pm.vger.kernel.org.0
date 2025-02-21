Return-Path: <linux-pm+bounces-22698-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCE8A401DF
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 22:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BD1D164EB3
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 21:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD0B253B73;
	Fri, 21 Feb 2025 21:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFPitaO/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F49E1F3FE8;
	Fri, 21 Feb 2025 21:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740172384; cv=none; b=sBw+xTbBPobxnJlhVk9xjUBjNFzi0R7WarhVg/HQ1kZL5AyJav2KQkmIg8uvionkNwYTeKITaYXroNIkrVzHHwkhsMvJayDtG6Q+t1UKUWLLrbqf+0rIjwunoNjWrxhhhxiyOqQS1fpmg7apKemjJr8It7m04Eij0Od5LgWzQus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740172384; c=relaxed/simple;
	bh=4JCvoidMQjiDQ1GXmRi4cdYLlP0NG7KuK8i8El+uIb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csd/BgWq+MTFpoXGUw2w3vwv/i6LFjRRWVJuF89LhjqUJrxLNKX6Cn54o3nW7CpvByItY8LsRBUyaYts0RccAxSbdAKoOIs/gXAOV4bVK1Jgh3CDT4clhIzQMhLvivhrTjlDAeop6vqvswF7hokV23lxAO/+QM7nZzIvfgXYOYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFPitaO/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40761C4CED6;
	Fri, 21 Feb 2025 21:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740172383;
	bh=4JCvoidMQjiDQ1GXmRi4cdYLlP0NG7KuK8i8El+uIb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DFPitaO/9Ls3UKZR2HYxLp5LCx5c8IvWn7AFngL3a27ptV/9GzAhLaOztIYHEb7M4
	 p1sXIekoamiwrLtUWRxV/EJX43oH6GxfCx9sKFQablcSnfMgXrAWJ7jvaMvB3umpAh
	 GYe2RSQwCKktWzPYdntd/g6q3qCqkeA10Qz3aaX9bE1/R/eQy0txBVmV+SCAXVEP7I
	 mH1hBY4H1jDsjwnplYNOE/IfsaPfYqg8X4aC6kA46c9+/avzITG/4iZrWb9pQuXayB
	 B4YdNX5ZmuVeF4YtojozH19rKIyfEuQrFCCUVdw1p0pbIGQGQqnyQjnb2Au7aLX2nL
	 bxk0G1OOt+ZEw==
Date: Fri, 21 Feb 2025 15:13:01 -0600
From: Rob Herring <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laxman Dewangan <ldewangan@nvidia.com>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: thermal: generic-adc: Add optional
 io-channel-cells property
Message-ID: <20250221211301.GA83357-robh@kernel.org>
References: <20250219082817.56339-1-clamor95@gmail.com>
 <20250219082817.56339-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219082817.56339-2-clamor95@gmail.com>

On Wed, Feb 19, 2025 at 10:28:16AM +0200, Svyatoslav Ryhel wrote:
> Since device is a thermal sensor it needs '#io-channel-cells' to allow
> exposure of thermal data via IIO means.

This looks odd. The consumer is also a producer? What in DT would be the 
2nd consumer. If you don't have a consumer in the DT, then you don't 
need '#io-channel-cells'.

I would like to see Jonathan's buy in on this.

> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../devicetree/bindings/thermal/generic-adc-thermal.yaml      | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml b/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
> index 12e6418dc24d..4bc2cff0593c 100644
> --- a/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
> @@ -30,6 +30,9 @@ properties:
>    io-channel-names:
>      const: sensor-channel
>  
> +  '#io-channel-cells':
> +    const: 1

You have to document what is in the cells.

> +
>    temperature-lookup-table:
>      description: |
>        Lookup table to map the relation between ADC value and temperature.
> @@ -60,6 +63,7 @@ examples:
>          #thermal-sensor-cells = <0>;
>          io-channels = <&ads1015 1>;
>          io-channel-names = "sensor-channel";
> +        #io-channel-cells = <1>;
>          temperature-lookup-table = <
>                (-40000) 2578
>                (-39000) 2577
> -- 
> 2.43.0
> 

