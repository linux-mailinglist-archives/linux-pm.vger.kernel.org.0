Return-Path: <linux-pm+bounces-15218-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E85F9919C3
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 20:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B849C282F29
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 18:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD6415F3EF;
	Sat,  5 Oct 2024 18:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNJ4Rw5E"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298D21369BC;
	Sat,  5 Oct 2024 18:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728154643; cv=none; b=RbGQ9YzyqZSFwn7jBWMexoS/pujgKmdQ29w4y+N9yU5fPwNUCXi43+RyCVkIQ2FTiwY1Qsb+Nk6O1t3+cEWr/nZpeM5zEC1aRDryykUAHeunFlDGgx8qr6QQ/g1/EhKgv4+5RI0oHDrFMf63z55mpwbmtPNUZsa1B/E9/BLyUEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728154643; c=relaxed/simple;
	bh=bUzrElpcmZy00FDHR/UrYDu1AHlhoN1235+oQw1lFjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqLBzSdMVzonFpop4W4Jqxr+NTRKpYqpiBtlNEQuR1CA2HgQRvXp6wJNLm94MV2D94zIvcy7rs+XRRz1TS6rtzyZ3OJs4PCZ0i31XTTgvEoQaoSrA+XTf/Q1hZI+325PBxnlqhvImmdRU4o9VGqYlyKm42Atz09eeDB/OyIr0QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNJ4Rw5E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765A1C4CEC2;
	Sat,  5 Oct 2024 18:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728154642;
	bh=bUzrElpcmZy00FDHR/UrYDu1AHlhoN1235+oQw1lFjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eNJ4Rw5EnTkMqwFtWfHJ78gew7KNhf2tBTGben4UzqCy6C7DCci1zzmqLFT/1gF23
	 lU1TRWSM2jC0D0WU3SvjtK+PRpE3ih2n7TKA5NUwiB0mochG2qvhtRCcWqPMf/mM5/
	 FsULZsWYP5rdZe13rz4A7HPh3+XPfV2gSVqdipAQbBCqlovWv/BTNl4AE5zGmWMiS6
	 OXBoKC7PX2glSS7f62COrifq8EbPZzZM+vPElmybVVcwXetsopcz0nPQDirQBnCCeu
	 qak4k6wO/zXIJoUcNVIVq1bF5bXP6zXmR+kgXWd34TG5/kKx2MysCbx7Be9xWyaX/v
	 6nzks70GS3aew==
Date: Sat, 5 Oct 2024 13:57:21 -0500
From: Rob Herring <robh@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, tony@atomide.com,
	linux-kernel@vger.kernel.org, khilman@baylibre.com,
	linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: mfd: twl: add charger node also for
 TWL603x
Message-ID: <20241005185721.GA524539-robh@kernel.org>
References: <20241005060511.1334049-1-andreas@kemnade.info>
 <20241005060511.1334049-3-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241005060511.1334049-3-andreas@kemnade.info>

On Sat, Oct 05, 2024 at 08:05:09AM +0200, Andreas Kemnade wrote:
> Also the TWL603X devices have a charger, so allow to specify it here.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  .../devicetree/bindings/mfd/ti,twl.yaml       | 30 +++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> index e94b0fd7af0f8..e772d13adbfdc 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> @@ -54,7 +54,7 @@ allOf:
>            $ref: /schemas/iio/adc/ti,twl4030-madc.yaml
>            unevaluatedProperties: false
>  
> -        bci:
> +        charger:
>            type: object
>            $ref: /schemas/power/supply/twl4030-charger.yaml
>            unevaluatedProperties: false
> @@ -105,6 +105,11 @@ allOf:
>              regulator-initial-mode: false
>  
>        properties:
> +        charger:
> +          type: object
> +          properties:
> +            compatible:
> +              const: ti,twl6030-charger
>          gpadc:
>            type: object
>            properties:
> @@ -136,6 +141,13 @@ allOf:
>              regulator-initial-mode: false
>  
>        properties:
> +        charger:
> +          type: object
> +          properties:
> +            compatible:
> +              items:
> +                - const: ti,twl6032-charger
> +                - const: ti,twl6030-charger
>          gpadc:
>            type: object
>            properties:
> @@ -169,6 +181,12 @@ properties:
>    "#clock-cells":
>      const: 1
>  
> +  charger:
> +    type: object
> +    additionalProperties: true
> +    properties:
> +      compatible: true

I think the behavior you're after is:

required:
  - compatible

Because what you have is true when compatible is not present.

With that,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

