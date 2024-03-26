Return-Path: <linux-pm+bounces-5454-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6AC88D027
	for <lists+linux-pm@lfdr.de>; Tue, 26 Mar 2024 22:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6B632125D
	for <lists+linux-pm@lfdr.de>; Tue, 26 Mar 2024 21:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7B713D880;
	Tue, 26 Mar 2024 21:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQJH7DzJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CD93FD4;
	Tue, 26 Mar 2024 21:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711489038; cv=none; b=t6zY8+aRKi2DpQbPy+NVMFOyDK3d1u60lpzPKw/FtpkkpvWpZpjHcWviRDgpg7EzQGKrcZxo24plZjekoZSzoCY8ypk/LHf8pgN3CBY8DrZe5j4lFIPAp6lzsCPVZ7hembeKR920ciGoQRg67aMkvDBifRreXiCDKsBH4aemeRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711489038; c=relaxed/simple;
	bh=6ivBE7vx79QiGHFMd4cIu5Wx1VjWmybvGs2bLSwyU7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1x3VLhXOwszKkRaW9z+hjSJIVKmyHBVCJDYLmazPXMS0bzH1HVz5aLv+DFuilt+abQeXFdX7UaeGuGQOwoijfEpy4qUcdpypm9LA+l10K/J7zIJgTrHtyFt5axnk68meV2WXyoy7dC6wyxCJFzMAaZ6X/ZA/dz4fwc/d8kwnig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQJH7DzJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2444FC433C7;
	Tue, 26 Mar 2024 21:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711489038;
	bh=6ivBE7vx79QiGHFMd4cIu5Wx1VjWmybvGs2bLSwyU7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PQJH7DzJZoHcnrCEgL8Q2sVNfJeWHv8k8mVelU18DN+6Vr6IYf9X5BvRvtt3cfCm6
	 ijFjPuJWf2b+dFBk1sUUAJPwap5U2ONmvCqZ3cZiqp4jRjLirCIWUFIK0Yb7z4GUPa
	 YZEEH1UbiwxJ7ImfLp4LvQZl23jKyvGKyjqXd2PWGCBc7lSwKvePlKkqIN41754MtV
	 +YtCTu3QtTu/c9Go3qe0FzKmxhC6esqDzlN6M5NHTfW73uw7EdgvlHvYOzIFmqozVn
	 jJnfD42MUgjS7LnZsnMr8iK2PRfdzHISWVBrrP+8FcD7n9oLrFqnatNiAwyQaeadmb
	 z0xw0ScmbaZHA==
Date: Tue, 26 Mar 2024 16:37:16 -0500
From: Rob Herring <robh@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Yangtao Li <tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>,
	Martin Botka <martin.botka@somainline.org>,
	Martin Botka <martin.botka1@gmail.com>,
	Chris Morgan <macroalpha82@gmail.com>,
	Ryan Walklin <ryan@testtoast.com>
Subject: Re: [PATCH v3 3/8] dt-bindings: opp: Describe H616 OPPs and
 opp-supported-hw
Message-ID: <20240326213716.GA3686856-robh@kernel.org>
References: <20240326114743.712167-1-andre.przywara@arm.com>
 <20240326114743.712167-4-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326114743.712167-4-andre.przywara@arm.com>

On Tue, Mar 26, 2024 at 11:47:38AM +0000, Andre Przywara wrote:
> From: Martin Botka <martin.botka@somainline.org>
> 
> Compared to the existing Allwinner H6 OPP scheme, the H616 uses a
> similar NVMEM based mechanism to determine the silicon revision, which
> is required to select the right frequency / voltage pair for the OPPs.
> However it limits the maximum frequency for some speed bins, also seems
> to not support all frequencies in all speed bins, which requires us to
> introduce the opp-supported-hw property.
> 
> Add this property to the list of allowed properties, also drop the
> requirement for the revision specific opp-microvolt properties, since
> they might not be needed if using opp-supported-hw.
> 
> Also use to opportunity to adjust some wording, and drop a sentence
> referring to the Linux driver and the OPP subsystem.
> 
> Shorten the existing example and add another example, showcasing the
> opp-supported-hw property.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../allwinner,sun50i-h6-operating-points.yaml | 86 +++++++++----------
>  1 file changed, 42 insertions(+), 44 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
> index 51f62c3ae1947..d679b2e4a7199 100644
> --- a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
> +++ b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
> @@ -13,25 +13,25 @@ maintainers:
>  description: |
>    For some SoCs, the CPU frequency subset and voltage value of each
>    OPP varies based on the silicon variant in use. Allwinner Process
> -  Voltage Scaling Tables defines the voltage and frequency value based
> -  on the speedbin blown in the efuse combination. The
> -  sun50i-cpufreq-nvmem driver reads the efuse value from the SoC to
> -  provide the OPP framework with required information.
> +  Voltage Scaling Tables define the voltage and frequency values based
> +  on the speedbin blown in the efuse combination.
>  
>  allOf:
>    - $ref: opp-v2-base.yaml#
>  
>  properties:
>    compatible:
> -    const: allwinner,sun50i-h6-operating-points
> +    enum:
> +      - allwinner,sun50i-h6-operating-points
> +      - allwinner,sun50i-h616-operating-points
>  
>    nvmem-cells:
>      description: |
>        A phandle pointing to a nvmem-cells node representing the efuse
> -      registers that has information about the speedbin that is used
> +      register that has information about the speedbin that is used
>        to select the right frequency/voltage value pair. Please refer
> -      the for nvmem-cells bindings
> -      Documentation/devicetree/bindings/nvmem/nvmem.txt and also
> +      to the nvmem-cells bindings in
> +      Documentation/devicetree/bindings/nvmem/nvmem.yaml and also the
>        examples below.
>  
>    opp-shared: true
> @@ -47,15 +47,17 @@ patternProperties:
>      properties:
>        opp-hz: true
>        clock-latency-ns: true
> +      opp-microvolt: true
> +      opp-supported-hw:

As this is an array, 

maxItems: 1

> +        description: |

Don't need '|'.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

