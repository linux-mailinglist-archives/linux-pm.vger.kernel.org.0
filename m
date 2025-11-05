Return-Path: <linux-pm+bounces-37427-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE4CC34BA2
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 10:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC98318C5748
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 09:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922322FB610;
	Wed,  5 Nov 2025 09:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pH7cu0yH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543BE2F7AB4;
	Wed,  5 Nov 2025 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334064; cv=none; b=N5kv3DR+PXpEEVwz0FZGVHOAlMTDTIrBU0iHbXHf4vawp6oUQO3myBUX7heFsdRXXYakll7a3K2JSjEdCMzo1dzFdngZW2x85wApVzTwvCMISXYfyR8ZyY7ZdzXEoj0NKigpFjg8RBzrBRCGscFHp6OG9jL3bchBqCHQgsjskE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334064; c=relaxed/simple;
	bh=KwmEx9hgVk7y+RSTS2QImEXQ30/Rh4I9Ht/dNmvoaNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isoOnzstEqf6s1L5cdl/LQNpdIcP4DxV5LfqyQZ0JBxC3fLYdBit/Zu1TzqB1bB0/XSEeWZEaaCjVBE2X+oFgCQD1Dw6bKmOafHnoVzfb9N/SWEQqd2ZtRmLw6ukMG/5hwDYTuUPsqG4wcFUy6dEv+vePZTQJl/x/f5smRx7mOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pH7cu0yH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52BBCC4CEF8;
	Wed,  5 Nov 2025 09:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762334063;
	bh=KwmEx9hgVk7y+RSTS2QImEXQ30/Rh4I9Ht/dNmvoaNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pH7cu0yHXFCgGt/0ca4SBMfZGTNDILeOA0KZMzEsw4w+vZj60tTfcxwaYWfKrwu3w
	 o7J1IPVKRIdWcEBAZSy/fj8XR3vKj2Hu9atKHPZUXmsS3655T9txDKldlerftBkxNA
	 8amFqn5ek/xXu6qOJuS8XsPTqzFH7AwCIMGCXdvGpn0Pqz+q9PMRD2xf9kFvhFFv8A
	 2GKm8Hm4v8/Nnh9pmVXUzvFD6JMXXBrVjnDBjvTNt50KX4ZRa1Q2WD1/F1jBIUdCxh
	 FJDEWEvqtokO1UTT+PmsVKu4AYcEr14JwL9Y+fowwcjRFKaDJ/1WMs4Ek1Lh0bP8E7
	 ihgx6P3BrvcFw==
Date: Wed, 5 Nov 2025 10:14:21 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 2/5] dt-bindings: remoteproc: qcom,sc8280xp-pas: Fix CDSP
 power desc
Message-ID: <20251105-dramatic-denim-kangaroo-cef9ed@kuoka>
References: <20251104-topic-8280_mxc-v1-0-df545af0ef94@oss.qualcomm.com>
 <20251104-topic-8280_mxc-v1-2-df545af0ef94@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251104-topic-8280_mxc-v1-2-df545af0ef94@oss.qualcomm.com>

On Tue, Nov 04, 2025 at 08:31:07PM +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> The power requirements for the CDSP instances on SC8280XP aren't fully
> described, with only one of the three present. Fix that.
> 
> Fixes: ee651cd1e944 ("dt-bindings: remoteproc: qcom: pas: Add sc8280xp adsp and nsp pair")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml
> index 96d53baf6e00..5dbda3a55047 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml
> @@ -91,9 +91,13 @@ allOf:
>          power-domains:
>            items:
>              - description: NSP power domain
> +            - description: CX power domain
> +            - description: MXC power domain
>          power-domain-names:
>            items:
>              - const: nsp
> +            - const: cx
> +            - const: mxc

Heh, so if this was described since beginning entire binding would fit
100% into qcom,sm8550-pas.yaml, instead having this now in different
file because of different order. Not great. :(

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


