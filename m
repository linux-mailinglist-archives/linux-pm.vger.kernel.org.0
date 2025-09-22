Return-Path: <linux-pm+bounces-35179-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CB4B9219A
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 18:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DDC6176CFE
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 16:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772173101A5;
	Mon, 22 Sep 2025 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W59gmQgd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BBEEEC0;
	Mon, 22 Sep 2025 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556842; cv=none; b=AIZ2Twy7mX9OonUwN+0jFUW1thnaZD1nPNEp3UWCfonmIKl0B1OtGkJlM6neEzHeSyF76GuzsUKUEAMTx9jbcprE6YIvvwy+hNB2NmQIbTal4u9sNVEgCj1kB3AxvnUnFjqoaiV3KhhWnaaofJBfut36hb+Pkj2Hymsb9AN/+t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556842; c=relaxed/simple;
	bh=gurdba/DTsv3U8QqRqFzecsKxs5zCX7qM3Ox+fJp8HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9O8i0M1XgZQJ3dHgAVlIeBe+ihdoVNDWiNdnnDKgewTJQJXbNsQ+iKwoB9SV9qgNa3AREVUEnWt7/KNwDLOOvK0gdGUlcafjMafpd/Zitm9PI+c2G/vG4+77ecgt7Pkb31mQmNHhB40tSLS4mbvWarauct1hZgK9QM8AaxbELk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W59gmQgd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9312AC4CEF0;
	Mon, 22 Sep 2025 16:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758556841;
	bh=gurdba/DTsv3U8QqRqFzecsKxs5zCX7qM3Ox+fJp8HQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W59gmQgdPctUTyG45puWTxq4a/dcWAgxGUxdASo4fqk9kIAuo1Rt7L2MuotxNYoXc
	 d2mdX20+NU+uYrvBRpOP35HueZEPXa7tm1Nh9WfiRXsINRqceeJtjKa0unyUJxZeal
	 8AH3YVieOZfp9JNU/+2eoIghAA+oVyl9J6DwjrWAO+fiBAlfrReDQFyj9BxJwWfHzH
	 gQiHTxe7IW8YqgfHN/OKpw4Cy8Cgyi+3TO8Im/87UNo1FTzHY3ZTs86UA914UbJu89
	 8brQy3zw1JZG/eoAXFcyfTDGpQMvPswjmFwBazEjpPUfF6Zcoo2qk4Vn6Xbi4r/H0u
	 P/912Bgy/W3Nw==
Date: Mon, 22 Sep 2025 11:00:40 -0500
From: Rob Herring <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Dmitry Osipenko <digetx@gmail.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 03/11] dt-bindings: memory: Document Tegra114 Memory
 Controller
Message-ID: <20250922160040.GA92842-robh@kernel.org>
References: <20250915080157.28195-1-clamor95@gmail.com>
 <20250915080157.28195-4-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915080157.28195-4-clamor95@gmail.com>

On Mon, Sep 15, 2025 at 11:01:49AM +0300, Svyatoslav Ryhel wrote:
> Add Tegra114 support into existing Tegra124 MC schema with the most
> notable difference in the amount of EMEM timings.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../nvidia,tegra124-mc.yaml                   | 97 ++++++++++++++-----
>  1 file changed, 74 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
> index 7b18b4d11e0a..9cc9360d3bd0 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
> @@ -19,7 +19,9 @@ description: |
>  
>  properties:
>    compatible:
> -    const: nvidia,tegra124-mc
> +    enum:
> +      - nvidia,tegra114-mc
> +      - nvidia,tegra124-mc
>  
>    reg:
>      maxItems: 1
> @@ -64,29 +66,10 @@ patternProperties:
>  
>            nvidia,emem-configuration:
>              $ref: /schemas/types.yaml#/definitions/uint32-array
> -            description: |
> +            description:
>                Values to be written to the EMEM register block. See section
> -              "15.6.1 MC Registers" in the TRM.
> -            items:
> -              - description: MC_EMEM_ARB_CFG
> -              - description: MC_EMEM_ARB_OUTSTANDING_REQ
> -              - description: MC_EMEM_ARB_TIMING_RCD
> -              - description: MC_EMEM_ARB_TIMING_RP
> -              - description: MC_EMEM_ARB_TIMING_RC
> -              - description: MC_EMEM_ARB_TIMING_RAS
> -              - description: MC_EMEM_ARB_TIMING_FAW
> -              - description: MC_EMEM_ARB_TIMING_RRD
> -              - description: MC_EMEM_ARB_TIMING_RAP2PRE
> -              - description: MC_EMEM_ARB_TIMING_WAP2PRE
> -              - description: MC_EMEM_ARB_TIMING_R2R
> -              - description: MC_EMEM_ARB_TIMING_W2W
> -              - description: MC_EMEM_ARB_TIMING_R2W
> -              - description: MC_EMEM_ARB_TIMING_W2R
> -              - description: MC_EMEM_ARB_DA_TURNS
> -              - description: MC_EMEM_ARB_DA_COVERS
> -              - description: MC_EMEM_ARB_MISC0
> -              - description: MC_EMEM_ARB_MISC1
> -              - description: MC_EMEM_ARB_RING1_THROTTLE
> +              "20.11.1 MC Registers" in the Tegea114 TRM or
> +              "15.6.1 MC Registers" in the Tegra124 TRM.
>  
>          required:
>            - clock-frequency
> @@ -109,6 +92,74 @@ required:
>    - "#iommu-cells"
>    - "#interconnect-cells"
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nvidia,tegra114-mc
> +    then:
> +      patternProperties:
> +        "^emc-timings-[0-9]+$":
> +          patternProperties:
> +            "^timing-[0-9]+$":
> +              properties:
> +                nvidia,emem-configuration:
> +                  items:
> +                    - description: MC_EMEM_ARB_CFG
> +                    - description: MC_EMEM_ARB_OUTSTANDING_REQ
> +                    - description: MC_EMEM_ARB_TIMING_RCD
> +                    - description: MC_EMEM_ARB_TIMING_RP
> +                    - description: MC_EMEM_ARB_TIMING_RC
> +                    - description: MC_EMEM_ARB_TIMING_RAS
> +                    - description: MC_EMEM_ARB_TIMING_FAW
> +                    - description: MC_EMEM_ARB_TIMING_RRD
> +                    - description: MC_EMEM_ARB_TIMING_RAP2PRE
> +                    - description: MC_EMEM_ARB_TIMING_WAP2PRE
> +                    - description: MC_EMEM_ARB_TIMING_R2R
> +                    - description: MC_EMEM_ARB_TIMING_W2W
> +                    - description: MC_EMEM_ARB_TIMING_R2W
> +                    - description: MC_EMEM_ARB_TIMING_W2R
> +                    - description: MC_EMEM_ARB_DA_TURNS
> +                    - description: MC_EMEM_ARB_DA_COVERS
> +                    - description: MC_EMEM_ARB_MISC0
> +                    - description: MC_EMEM_ARB_RING1_THROTTLE

Like I said before, I don't think it is worth enumerating the list of 
registers for every variant. If you want to define the length 
(minItems/maxItems), then that is fine.

Rob

