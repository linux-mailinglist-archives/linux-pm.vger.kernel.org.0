Return-Path: <linux-pm+bounces-9953-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBF1916954
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 15:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17793281AD0
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 13:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7EF15FD08;
	Tue, 25 Jun 2024 13:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvS84w6B"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC8817C98;
	Tue, 25 Jun 2024 13:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323332; cv=none; b=VgjesAvLSKbffQjOWh7yYL2dZ0t2+d0xel1R3ss+Eo7GJvwaFtBBMGPY2HyrtibwOPHhlyyYiL6oOZ6FyH5E0GdeIlgv3frCij4CzOoXaNf4ZHbSH77lLbR7fgbUUZO0sO2A08FRQFSOYE86EFUDEZNHDcJdz137SAcu7JutDVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323332; c=relaxed/simple;
	bh=BQKvpt7Ba0OCOosSr+zAf6QCAcmlLu5zyssanXTWIdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mRVvfwYWlvMPJ/mvRFMf3lCwVgJ4ghPjt5R3R6gPJyDfCt9Z3v20b1zK16q887dIE5K3HVI1hiKbOF+40Ix9/Zm53lwNWUOSglEO2I06CKEzETdy3lnkTn4l8tyJl7gLOG8NHw7cAEP/VQR9iHqpuj3aSVDx+6G0V16m4TyLrww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvS84w6B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41590C32781;
	Tue, 25 Jun 2024 13:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719323331;
	bh=BQKvpt7Ba0OCOosSr+zAf6QCAcmlLu5zyssanXTWIdM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dvS84w6BBHgfN0IoVqHqyPsRnEmSvIUtG0B6DL4jcCCyA0Ywjd6qBwlU0e4PK8W+O
	 FEG27TXNPJHMCVLf0zWFSqGxwmj0Fvszu8D6DgQVHGOB7af1zz6Dk3ZnHfZhuKpixP
	 LAG8qbrdQIpS3Cj6QXjtU1SwegC5U0XHJzELc2MHwS06XM9SglCv78/vrEj472/vM7
	 KIUIVxjp1KibjvFVWDOyJasfCvKVihDKkNAZo8kJ6yXDP7vvHKUZjPNhc/GG6o9OaB
	 k+C9amoAzKSvA1g1+jgQzyMbaazPofr8K452rL3smUrgatuPTCpl4FREa14JW5TAnV
	 B0vjx3yQr2FKQ==
Message-ID: <596649dc-0683-4083-aa6e-e83372ad2ad4@kernel.org>
Date: Tue, 25 Jun 2024 16:48:45 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/4] dt-bindings: interconnect: qcom,msm8998-bwmon: Add
 X1E80100 BWMON instances
To: Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, dmitry.baryshkov@linaro.org,
 srinivas.kandagatla@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 quic_rgottimu@quicinc.com, quic_kshivnan@quicinc.com, conor+dt@kernel.org,
 abel.vesa@linaro.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240624092214.146935-1-quic_sibis@quicinc.com>
 <20240624092214.146935-3-quic_sibis@quicinc.com>
Content-Language: en-US
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20240624092214.146935-3-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.06.24 12:22, Sibi Sankar wrote:
> Document X1E80100 BWMONs, which has multiple (one per cluster) BWMONv4
> instances for the CPU->LLCC path and one BWMONv5 instance for LLCC->DDR
> path.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>

Acked-by: Georgi Djakov <djakov@kernel.org>

> ---
> 
> v3:
> * Pickup Rb's and Tb's from the list.
> 
>   .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml    | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> index 9c248e1eabe2..2cd1f5590fd9 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> @@ -35,6 +35,7 @@ properties:
>                 - qcom,sm8250-cpu-bwmon
>                 - qcom,sm8550-cpu-bwmon
>                 - qcom,sm8650-cpu-bwmon
> +              - qcom,x1e80100-cpu-bwmon
>             - const: qcom,sdm845-bwmon    # BWMON v4, unified register space
>         - items:
>             - enum:
> @@ -44,6 +45,7 @@ properties:
>                 - qcom,sm8250-llcc-bwmon
>                 - qcom,sm8550-llcc-bwmon
>                 - qcom,sm8650-llcc-bwmon
> +              - qcom,x1e80100-llcc-bwmon
>             - const: qcom,sc7280-llcc-bwmon
>         - const: qcom,sc7280-llcc-bwmon   # BWMON v5
>         - const: qcom,sdm845-llcc-bwmon   # BWMON v5


