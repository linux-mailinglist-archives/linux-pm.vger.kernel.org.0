Return-Path: <linux-pm+bounces-36920-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 621A2C0EC91
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 16:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E33A50295D
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 14:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C22C2D1905;
	Mon, 27 Oct 2025 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkeWIOuN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620D321C9E1;
	Mon, 27 Oct 2025 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577024; cv=none; b=hSQyJkUUZIUm/DndomuuFKFclDPM0sXdRLMxSr1PGEQ4qoTOaFi5n7kpj3VFwHnEc78Lc1sghLHt86PinvHTpe/zXA3AjajvxdA87lqgDT0oRD7oe+aBdVFgwFCoPFjlt1kQwJWPTP44G40pmAK7xF3L0M4rD6oQoXzO58zmCL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577024; c=relaxed/simple;
	bh=kaVcK8OIjSumIxwpqcKoNlQqE5TYmqKt73ac9Bo6W6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4bx1HPgysIYiJFs6fDXXAmscClRPuBXnfuf88Q32MsIYLjN/FlPgBUPuJQFpm/C7Lc76NXFWN9jUqw4GypdcUydUfTo8cYXDu4tSotH+BF3i2IlPhWrEF8MsnWdIzmxh/WINMI2m9snNI4X05w5egfjow0J5PM90UEifm4cI+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkeWIOuN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C65C4CEF1;
	Mon, 27 Oct 2025 14:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761577024;
	bh=kaVcK8OIjSumIxwpqcKoNlQqE5TYmqKt73ac9Bo6W6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IkeWIOuNY4mzVdHn3NP4FLLtIvss8zVbGkyBOYzE211jm5ye6enSDZlYPA9rNYCaH
	 WrXIupVFDGv1ccFmqQYOWnsI0wIqwW7ryynwcQp7zG0gellqb0h2jopDawVL2TimaV
	 fnWkftXXCBdb8olxftOOiu4qFaQUQA7Kp3qgDmF2es8IA3pdEJo+c0RNMbQ6IAKQn9
	 6YK/SKWt+zuq/btmHCaEtCxL/jeZ1Wdz0bcj83FFNpf965Fts/paC4/VHcZWnkjMj+
	 VqZxtct8VIG71UdISyp3lmQoBdMhoHwCIVLN5sy48UkzsdC74is0PBG1dP9QIZkMxg
	 BgBqbojmAdPAw==
Date: Mon, 27 Oct 2025 09:59:56 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: george.moussalem@outlook.com
Cc: Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sricharan Ramabadhran <quic_srichara@quicinc.com>, Konrad Dybcio <konradybcio@kernel.org>, linux-pm@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <lumag@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: thermal: qcom-tsens: make ipq5018 tsens
 standalone compatible
Message-ID: <txxcpxtirdhmwrf35o2es75hyzpc3dgeczbfcvjtred4mj7ggn@2baviuiajxf3>
References: <20250818-ipq5018-tsens-fix-v1-0-0f08cf09182d@outlook.com>
 <20250818-ipq5018-tsens-fix-v1-1-0f08cf09182d@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818-ipq5018-tsens-fix-v1-1-0f08cf09182d@outlook.com>

On Mon, Aug 18, 2025 at 03:33:46PM +0400, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> The tsens IP found in the IPQ5018 SoC should not use qcom,tsens-v1 as
> fallback since it has no RPM and, as such, must deviate from the
> standard v1 init routine as this version of tsens needs to be explicitly
> reset and enabled in the driver.
> 
> So let's make qcom,ipq5018-tsens a standalone compatible in the bindings.
> 
> Fixes: 77c6d28192ef ("dt-bindings: thermal: qcom-tsens: Add ipq5018 compatible")
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index 94311ebd7652d42eb6f3ae0dba792872c90b623f..9f342e63bdb1d27bd12373fb4c7611964bfd8d4b 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -36,10 +36,15 @@ properties:
>                - qcom,msm8974-tsens
>            - const: qcom,tsens-v0_1
>  
> +      - description:
> +          v1 of TSENS without RPM which requires to be explicitly reset
> +          and enabled in the driver.
> +        enum:
> +          - qcom,ipq5018-tsens
> +
>        - description: v1 of TSENS
>          items:
>            - enum:
> -              - qcom,ipq5018-tsens
>                - qcom,msm8937-tsens
>                - qcom,msm8956-tsens
>                - qcom,msm8976-tsens
> 
> -- 
> 2.50.1
> 
> 

