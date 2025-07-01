Return-Path: <linux-pm+bounces-29877-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A00FAEF0E5
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 10:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C00D04A07A2
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 08:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A48F26B09A;
	Tue,  1 Jul 2025 08:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/G7wm6C"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB36264638;
	Tue,  1 Jul 2025 08:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751358155; cv=none; b=rtrAY4/NFFX1NYUVBBc9MVnv/tTteJw9Q4P1CvNh9TKnYBO+4ZNYnXxAI0DhmYjQrX0IEFV3e0H21FhegCxcZXq8Ax0td/564D0mZbnasjZw/9IdvfaTTaBIeOtikzgXnp46NZf6W/GWWwrou7Hg86zOXhRgZ+AZnR/gaD+3SRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751358155; c=relaxed/simple;
	bh=aNmVXBFvp+oOEwr66jDZuE77bJXKpgGM030ZO2mjHy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aH6rKaZu5jVSFWUNh67pWZK3Qzkv4CjccBNd40GdZfgCTx8cAUtyQ2vhUuUt7m+nxxq6l8enT6isbHUM08ciQ8XnhTmNUgzO+IHzbj7/yt3TZw4KfBRgT7vPeG1UpqXk0+w8XZ3H7T5lwa1xoAVFVjPhAWdnXlmNPsWgPyz5eWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/G7wm6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E83C4CEEE;
	Tue,  1 Jul 2025 08:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751358154;
	bh=aNmVXBFvp+oOEwr66jDZuE77bJXKpgGM030ZO2mjHy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E/G7wm6C5AuMjrIvU4l39LHdafufPMXKLFxveG+LYZ99NKTbODQNImWRM306pWtam
	 DdLaG2J7kCW5+Us5nXz9wyEvdv2xbMOSSNcSH4VucS5nOtkD98X9spEnuXaqcdXTav
	 yM3CN1ESPqtqULUdevukehKMs3JZNkBUP1khMeOFh2sdiHsaeYMGAM80/oTdot7dUU
	 QOvhxGVO3ZikHM5ioNc/afb3NMjaL8K6WpJkkEgqHF2z4d12Ap5oaTjWGNwvSrOXNq
	 3eFMUX6H5LZzE8jUrZ0x1kBI/2L2lv34dwEmhzjpE/zeZeNaWOkxhm0IuUHueqdgG9
	 YgPN4oxr7n0nA==
Date: Tue, 1 Jul 2025 10:22:31 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Georgi Djakov <djakov@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Richard Cochran <richardcochran@gmail.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Anusha Rao <quic_anusha@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, quic_kkumarcs@quicinc.com, 
	quic_linchen@quicinc.com, quic_leiwei@quicinc.com, quic_suruchia@quicinc.com, 
	quic_pavir@quicinc.com
Subject: Re: [PATCH v2 5/8] dt-bindings: clock: qcom: Add NSS clock
 controller for IPQ5424 SoC
Message-ID: <20250701-optimistic-esoteric-swallow-d93fc6@krzk-bin>
References: <20250627-qcom_ipq5424_nsscc-v2-0-8d392f65102a@quicinc.com>
 <20250627-qcom_ipq5424_nsscc-v2-5-8d392f65102a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250627-qcom_ipq5424_nsscc-v2-5-8d392f65102a@quicinc.com>

On Fri, Jun 27, 2025 at 08:09:21PM +0800, Luo Jie wrote:
> NSS clock controller provides the clocks and resets to the networking
> blocks such as PPE (Packet Process Engine) and UNIPHY (PCS) on IPQ5424
> devices.
> 
> Add the compatible "qcom,ipq5424-nsscc" support based on the current
> IPQ9574 NSS clock controller DT binding file. ICC clocks are always
> provided by the NSS clock controller of IPQ9574 and IPQ5424, so add
> interconnect-cells as required DT property.
> 
> Also add master/slave ids for IPQ5424 networking interfaces, which is
> used by nss-ipq5424 driver for providing interconnect services using
> icc-clk framework.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  .../bindings/clock/qcom,ipq9574-nsscc.yaml         | 70 +++++++++++++++++++---
>  include/dt-bindings/clock/qcom,ipq5424-nsscc.h     | 65 ++++++++++++++++++++
>  include/dt-bindings/interconnect/qcom,ipq5424.h    | 13 ++++
>  include/dt-bindings/reset/qcom,ipq5424-nsscc.h     | 46 ++++++++++++++
>  4 files changed, 186 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
> index 17252b6ea3be..0029a148a397 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/clock/qcom,ipq9574-nsscc.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Qualcomm Networking Sub System Clock & Reset Controller on IPQ9574
> +title: Qualcomm Networking Sub System Clock & Reset Controller on IPQ9574 and IPQ5424
>  
>  maintainers:
>    - Bjorn Andersson <andersson@kernel.org>
> @@ -12,21 +12,29 @@ maintainers:
>  
>  description: |
>    Qualcomm networking sub system clock control module provides the clocks,
> -  resets on IPQ9574
> +  resets on IPQ9574 and IPQ5424
>  
> -  See also::
> +  See also:
> +    include/dt-bindings/clock/qcom,ipq5424-nsscc.h
>      include/dt-bindings/clock/qcom,ipq9574-nsscc.h
> +    include/dt-bindings/reset/qcom,ipq5424-nsscc.h
>      include/dt-bindings/reset/qcom,ipq9574-nsscc.h
>  
>  properties:
>    compatible:
> -    const: qcom,ipq9574-nsscc
> +    enum:
> +      - qcom,ipq5424-nsscc
> +      - qcom,ipq9574-nsscc
>  
>    clocks:
>      items:
>        - description: Board XO source
> -      - description: CMN_PLL NSS 1200MHz (Bias PLL cc) clock source
> -      - description: CMN_PLL PPE 353MHz (Bias PLL ubi nc) clock source
> +      - description: CMN_PLL NSS (Bias PLL cc) clock source. This clock rate
> +          can vary for different IPQ SoCs. For example, it is 1200 MHz on the
> +          IPQ9574 and 300 MHz on the IPQ5424.
> +      - description: CMN_PLL PPE (Bias PLL ubi nc) clock source. The clock
> +          rate can vary for different IPQ SoCs. For example, it is 353 MHz
> +          on the IPQ9574 and 375 MHz on the IPQ5424
>        - description: GCC GPLL0 OUT AUX clock source
>        - description: Uniphy0 NSS Rx clock source
>        - description: Uniphy0 NSS Tx clock source
> @@ -42,8 +50,12 @@ properties:
>    clock-names:
>      items:
>        - const: xo
> -      - const: nss_1200
> -      - const: ppe_353
> +      - enum:
> +          - nss_1200
> +          - nss

No, that's the same clock.


> +      - enum:
> +          - ppe_353
> +          - ppe

No, that's the same clock!

The frequencies are not part of input pin. Input pin tells you this is
clock for PPE, not this is clock for PPE 353 and another for PPE xxx.

Best regards,
Krzysztof


