Return-Path: <linux-pm+bounces-37329-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F16B8C2EEE4
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 03:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7409E1896F6C
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 02:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168D423EA89;
	Tue,  4 Nov 2025 02:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQb7ZFeJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF11823E229;
	Tue,  4 Nov 2025 02:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762222420; cv=none; b=jJufspqtEDAhsVvVQ0wVOfqH3LwOVRegzzlEGEB04Sqhu6PEZssbBec7tnf5fcPbageyHuSlcQ1niVTa7fGi3Vb/R3g/0XCFnbWu5NiUrGgI8w+tI698RF8K9ZeeFOFYM4dHFk9KiebBg542W5py014npruKlYCruqUTAkhb4L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762222420; c=relaxed/simple;
	bh=gCcvN/9uEaHir98jFgVnionOoR3jofj5T0/2dI9+APE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLTvqGWFhmJWrhTi/PBOgwCUhFTNdHmMxWXls9c4pcPsVBmoe1FZm7486+5flcR3ED8mmcqDvZqAO8ZncMPFBb98bXQCQhVn+Qa1bOUZiEioIcOmHO2ACXgFM//9hX+uUp3dZqfT813QeBFAZWQlLz+FC/dBziR4hqDJiLAzKrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQb7ZFeJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36F4C4CEE7;
	Tue,  4 Nov 2025 02:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762222419;
	bh=gCcvN/9uEaHir98jFgVnionOoR3jofj5T0/2dI9+APE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hQb7ZFeJm+Ed7R3N0M4BtIyxMsOaWtGqSqS72kKX1Te/QVoQAbvygYu0RCpowxr9h
	 znrGWV0iUgfWGI2hXCm4ZRdyhknCfAPZM0iw+TEd5UCAmyCr7mIBnn724nP7L60HxA
	 0wy2i9wGJKmHSUQrGA/07VNT+0HCVKKKv3reKe475F3NxqtM30/JJQYBHLidyz40RO
	 7ENlFZaD8LIFqqoGpoG4Fwm2MXoea4C0ohc0pnnX5CsGzhIRCAyuIzd6UxgWcE5qlP
	 yjlII4GUd9l0ITMECadTDN1dlqYNPxjVh4MNSiG0F3OVLxqomBJv6VLkRqA5Gf+yxV
	 VzU64y6TVF/4A==
Date: Mon, 3 Nov 2025 20:17:11 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, sre@kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: power: reset: qcom-pon: Document
 qcom,warm-reset
Message-ID: <4mwms7f6htqe6kfx5pvticw5jx7aoaujh5totxfyaydqo2cqkj@aegwhvwuc56l>
References: <20251103182006.1158383-1-loic.poulain@oss.qualcomm.com>
 <20251103182006.1158383-2-loic.poulain@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103182006.1158383-2-loic.poulain@oss.qualcomm.com>

On Mon, Nov 03, 2025 at 07:20:02PM +0100, Loic Poulain wrote:
> This property can be used as a fallback mechanism when a warm reset
> cannot be achieved through the standard firmware interface (SCPI).

PSCI

> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  .../devicetree/bindings/power/reset/qcom,pon.yaml          | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> index 979a377cb4ff..ad8691c87f4f 100644
> --- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> @@ -38,6 +38,13 @@ properties:
>      minItems: 1
>      maxItems: 2
>  
> +  qcom,warm-reset:
> +    description: |
> +      The PON (Power-On) peripheral provides support for warm reset, which can
> +      be used as a fallback mechanism when a warm reset cannot be achieved
> +      through the standard firmware interface.
> +    type: boolean
> +
>    pwrkey:
>      type: object
>      $ref: /schemas/input/qcom,pm8941-pwrkey.yaml#
> -- 
> 2.34.1
> 

