Return-Path: <linux-pm+bounces-10783-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF8692A683
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 17:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BADEE2879BB
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 15:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB7F148820;
	Mon,  8 Jul 2024 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuYXxDIw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54D81442FB;
	Mon,  8 Jul 2024 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454130; cv=none; b=EfoRHoj8qpRyYYd3BvpbYnngjzQrGvZMDvJvISUO3XNkBCc3fuQq7qYV1CA+JhcD3NOuqwiHBvOPEg2cTkACt3HunOIYnRnf2UZP8GCjygQ7WMCCQl38e3DzBcRHTX2KRP3nSQ8I4kCF+I65Y8mFcrKUFjgsrywKwcIYGWdOaV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454130; c=relaxed/simple;
	bh=klBVxy8IiZUybk4NUjWGo9X6b6GwYIN3vkEddYVTDBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmKs9WnhwUv1M2xY40cgQdBt1hhB8F2z8p0PYJc3HR/X21eK1DeuqJyvaicxOudVuMtbvyWGZwwwY8qBKiZCvt0UUoJGDs9lVTe37/rdUCa9vpMXEQn8sXlJYU6CjTs/1AgiJuvzsHXRMZn4hZQQE70OkqSesoLtSLbka38g5kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuYXxDIw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2E3C116B1;
	Mon,  8 Jul 2024 15:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720454130;
	bh=klBVxy8IiZUybk4NUjWGo9X6b6GwYIN3vkEddYVTDBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UuYXxDIwcX4c9njAFXgqD6kPCnPvkqX13R4dwZkTjIwWzz9OlnkW+7lI2+BXng8Ex
	 HlueLCAKnas2BmaNAh8QSG+hNMLtbnRy4vkD6hZIxgpC9QQluc2SdJPnXlJrlZMWf6
	 28++49Pxyc8yqDP+VuaugpaSlF+qhCUagZeOQc+WrV9NL6UtEW3Klsz7G68LZWFZTo
	 QEySb4mqzeqfsZCdbu5dyK0D4OF8BzcNmgLCSKA4/RbdAIQM8L04RHG2DgZNQ8Uuh4
	 9G3rpoNOteMmvTxDGL2r26Udlv6QoM0cnjch5TTdK42W/BPN8UVVs5rMiTpjJ5Glfq
	 dZykVd8kygQfg==
Date: Mon, 8 Jul 2024 09:55:29 -0600
From: Rob Herring <robh@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, angelogioacchino.delregno@collabora.com,
	andersson@kernel.org, konrad.dybcio@linaro.org,
	mturquette@baylibre.com, ilia.lin@kernel.org, rafael@kernel.org,
	ulf.hansson@linaro.org, quic_sibis@quicinc.com,
	quic_rjendra@quicinc.com, quic_rohiagar@quicinc.com,
	abel.vesa@linaro.org, otto.pflueger@abscue.de, danila@jiaxyga.com,
	quic_ipkumar@quicinc.com, luca@z3ntu.xyz,
	stephan.gerhold@kernkonzept.com, nks@flawful.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 09/10] dt-bindings: opp: v2-qcom-level: Update
 minItems for oloop-vadj & cloop-vadj
Message-ID: <20240708155529.GA3244015-robh@kernel.org>
References: <20240703091651.2820236-1-quic_varada@quicinc.com>
 <20240703091651.2820236-10-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703091651.2820236-10-quic_varada@quicinc.com>

On Wed, Jul 03, 2024 at 02:46:50PM +0530, Varadarajan Narayanan wrote:
> Since IPQ9574 has only one CPR thread it will specify
> only one voltage adjustment value. Hence update min items
> accordingly for oloop-vadj and cloop-vadj. Without
> constraining min items, dt_binding_check gives errors
> 
> 	opp-table-cpr4:opp-0:qcom,opp-cloop-vadj:0: [0] is too short
> 	opp-table-cpr4:opp-0:qcom,opp-oloop-vadj:0: [0] is too short
> 
> 	Failed validating 'minItems' in schema . . .
> 		{'maxItems': 2, 'minItems': 2}
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v4: Fix dt_bindings_check error
> ---
>  Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml | 2 ++
>  1 file changed, 2 insertions(+)

This is going to need to be rolled into your dependency because it needs 
the same fix.

> 
> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
> index b203ea01b17a..1c1a9e12d57a 100644
> --- a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
> +++ b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
> @@ -39,6 +39,7 @@ patternProperties:
>            An array of per-thread values representing the closed-loop
>            voltage adjustment value associated with this OPP node.
>          $ref: /schemas/types.yaml#/definitions/int32-array
> +        minItems: 1
>          maxItems: 2
>  
>        qcom,opp-oloop-vadj:
> @@ -46,6 +47,7 @@ patternProperties:
>            An array of per-thread values representing the open-loop
>            voltage adjustment value associated with this OPP node.
>          $ref: /schemas/types.yaml#/definitions/int32-array
> +        minItems: 1
>          maxItems: 2
>  
>      required:
> -- 
> 2.34.1
> 

