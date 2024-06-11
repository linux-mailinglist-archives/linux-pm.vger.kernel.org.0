Return-Path: <linux-pm+bounces-8972-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D66B9045DB
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 22:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018CC28659E
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 20:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C952E15250A;
	Tue, 11 Jun 2024 20:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNbbr/GI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958793839C;
	Tue, 11 Jun 2024 20:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718138403; cv=none; b=N/UlgSfqhFLOs8l8sXRvrKRC7fD/2BhDBCPnEDrOSFt2H2KWIhSXv6gKI2rnkQ4WCDqVX7EzVapyQoYxO30eJpdqx+ZyxOKvGpqDsdmh1ye4znTu4fmizGp6Wip7lfw8pbnp96WY1rTsjOXpzHQNdtQUs/mLky5wMaCu81QYczw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718138403; c=relaxed/simple;
	bh=Fc2HEeo9okemeHUxDvZyvIytBDjmzwdqdSkla9vn06k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGLrmRpJsA0XHaOn1SP4WpJRsqaZqJiuM6cnAGobQnRfmh9iODE0Jjxb5sr9nZjAy2da2BZhQH6+2EpKFqRfN+OoSCqdSHypzD23JexMoseTv8GQW2CCdBlwBHDFlraHxKCVwQsQ7fD5qMfscEW3NrEeyfVsKuHvIgRv+69LaU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNbbr/GI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76A2C3277B;
	Tue, 11 Jun 2024 20:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718138403;
	bh=Fc2HEeo9okemeHUxDvZyvIytBDjmzwdqdSkla9vn06k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gNbbr/GIbov1z2/M0ZncN5ndZNY+RGEhOS3BIuFYzXKt8Ix1x4gvYDNrWS9/yq40I
	 6lXvO+02Y5iwtyyg2Dgwgy1ZryBRF/gdz+iqST9EQ+152f+ciYHW5Qf5aUBK7W7Kzi
	 VTD8q9PmcNkGtujnalwAQL/x6WOrxSyiplUw2qbNu//8Mk5ZZSpkP14nmgASSoZQK7
	 pvvDqmUMcSw9B0BeHuKLeL5/GeoouKM8LvPxnorq9e3jUzQVyqihdi6ceYa78xZREu
	 mKzMS9Xab+GFv0Jbvyrubj5oLR/zkYuW6phmvv8UYJ2QVOx9ZZgfObZkisaaFtrm3C
	 yFV8OoRy5gYIA==
Date: Tue, 11 Jun 2024 14:40:01 -0600
From: Rob Herring <robh@kernel.org>
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Andy Yan <andy.yan@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
	Melody Olvera <quic_molvera@quicinc.com>,
	Shivendra Pratap <quic_spratap@quicinc.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: power: reset: Convert mode-.*
 properties to array
Message-ID: <20240611204001.GA3026541-robh@kernel.org>
References: <20240611-arm-psci-system_reset2-vendor-reboots-v4-0-98f55aa74ae8@quicinc.com>
 <20240611-arm-psci-system_reset2-vendor-reboots-v4-1-98f55aa74ae8@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611-arm-psci-system_reset2-vendor-reboots-v4-1-98f55aa74ae8@quicinc.com>

On Tue, Jun 11, 2024 at 08:35:13AM -0700, Elliot Berman wrote:
> PSCI reboot mode will map a mode name to multiple magic values instead
> of just one. Convert the mode-.* property to an array. Users of the
> reboot-mode schema will need to specify the maxItems of the mode-.*
> properties. Existing users will all be 1.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  .../devicetree/bindings/power/reset/nvmem-reboot-mode.yaml        | 5 +++++
>  Documentation/devicetree/bindings/power/reset/qcom,pon.yaml       | 8 ++++++++
>  Documentation/devicetree/bindings/power/reset/reboot-mode.yaml    | 4 ++--
>  .../devicetree/bindings/power/reset/syscon-reboot-mode.yaml       | 5 +++++
>  4 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml
> index 627f8a6078c2..9b9bbc0f29e7 100644
> --- a/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml
> @@ -31,6 +31,11 @@ properties:
>  allOf:
>    - $ref: reboot-mode.yaml#
>  
> +patternProperties:
> +  "^mode-.*$":
> +    items:
> +      maxItems: 1

Drop 'items'. Otherwise, you are defining constraints of a matrix.

> +
>  required:
>    - compatible
>    - nvmem-cells
> diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> index fc8105a7b9b2..4c87ff5ecc9a 100644
> --- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> @@ -54,6 +54,11 @@ required:
>    - compatible
>    - reg
>  
> +patternProperties:
> +  "^mode-.*$":
> +    items:
> +      maxItems: 1
> +
>  unevaluatedProperties: false
>  
>  allOf:
> @@ -75,6 +80,9 @@ allOf:
>          reg-names:
>            items:
>              - const: pon
> +    else:
> +      patternProperties:
> +        "^mode-.*$": false
>  
>      # Special case for pm8941, which doesn't store reset mode
>    - if:
> diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
> index ad0a0b95cec1..523602fb82d2 100644
> --- a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
> @@ -28,13 +28,13 @@ description: |
>  
>  properties:
>    mode-normal:
> -    $ref: /schemas/types.yaml#/definitions/uint32
> +    $ref: "#/patternProperties/^mode-.*$"

No need for this. The pattern schema will be applied already. Also, a 
$ref to a regex is fragile as it won't work for some regex patterns.

>      description:
>        Default value to set on a reboot if no command was provided.
>  
>  patternProperties:
>    "^mode-.*$":
> -    $ref: /schemas/types.yaml#/definitions/uint32
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>  
>  additionalProperties: true
>  
> diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
> index b6acff199cde..e9d2e3b27885 100644
> --- a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
> @@ -32,6 +32,11 @@ properties:
>  allOf:
>    - $ref: reboot-mode.yaml#
>  
> +patternProperties:
> +  "^mode-.*$":
> +    items:
> +      maxItems: 1
> +
>  unevaluatedProperties: false
>  
>  required:
> 
> -- 
> 2.34.1
> 

