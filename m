Return-Path: <linux-pm+bounces-31360-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD796B10324
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 10:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17E5E1899BD3
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 08:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE21274FDE;
	Thu, 24 Jul 2025 08:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjmW/oZS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0928E2749E8;
	Thu, 24 Jul 2025 08:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344844; cv=none; b=LsQYFm8rCciFbaKm9AnlTgghpxINuJ4oVL/B4Kp56DHQ7jJksBhaG48gw2RxfIWuj8CuiSbX0awQ7g0WtDnZ/aSGewCKQ4r44tTSxAk2nLX7mbmA4PP5An7czEwXtT0LtiqhIkLZZH3LfJT7sN06MbOmnCKJoPSX6Y2EYpF09Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344844; c=relaxed/simple;
	bh=be/TV7DsQTgAMaqFuPJ87zxEaHVLnfypSiqhdxwc3EY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pua3tPn0Jif7hmkuql0al2NI0TBEmDPhZMw8I+VEnkKLrFMRLsViCW32cOBY8BOaOOTYB+t5MlLjj4mz4HopaO3mXx4V65eakCz5Pb+0E4vm8vd+LxHEEuiLchw3did/E4uPPP1v2PBcrp/OuoofvtCzIGa2nmYlLBxGGYnCRGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjmW/oZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1875BC4CEED;
	Thu, 24 Jul 2025 08:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753344843;
	bh=be/TV7DsQTgAMaqFuPJ87zxEaHVLnfypSiqhdxwc3EY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OjmW/oZSiZg40w7QefsB5RDF1gR/c5sKUb1/6D2I5MWwT5CaTsyrozNbZIB2fWs1C
	 99tZC+kdMvZjNPPXcmJKqCotUYE664ufSp/9qsUaILCWayzEsvlAIsgCFTDphkQKRn
	 FuB015KzhxoGC47W67yrRQTUV2bAmLR0ZV2YRERgRh4YOKcfUgdO09heVGmAHTkIrk
	 1tGmNh6nMMBdjmTF0Sj1EPIAM/R15ElpRBjpkX4yqz25dv+9E1jWhMg0GyQFrUDRxI
	 gsXAz8BAZWyg8Hou0CXnCp6tkP8Gg1vvD6hyxyUP1jrtEy19qJdLSx8LtLpksS5fro
	 yykLqYzwtBicw==
Date: Thu, 24 Jul 2025 10:14:01 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org, 
	rafael@kernel.org, viresh.kumar@linaro.org, ilia.lin@kernel.org, djakov@kernel.org, 
	quic_srichara@quicinc.com, quic_mdalam@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: clock: ipq5424-apss-clk: Add ipq5424
 apss clock controller
Message-ID: <20250724-remarkable-kind-ibex-3bb86c@kuoka>
References: <20250723110815.2865403-1-quic_varada@quicinc.com>
 <20250723110815.2865403-2-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250723110815.2865403-2-quic_varada@quicinc.com>

On Wed, Jul 23, 2025 at 04:38:12PM +0530, Varadarajan Narayanan wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> The CPU core in ipq5424 is clocked by a huayra PLL with RCG support.
> The RCG and PLL have a separate register space from the GCC.
> Also the L3 cache has a separate pll and needs to be scaled along
> with the CPU.
> 
> Co-developed-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> [ Added interconnect related changes ]
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v2: Add #interconnect-cells to help enable L3 pll as ICC clock
>     Add master/slave ids

and v1 was where? I cannot find it in the inbox, no lore links.


> ---
>  .../bindings/clock/qcom,ipq5424-apss-clk.yaml | 61 +++++++++++++++++++
>  include/dt-bindings/clock/qcom,apss-ipq.h     |  6 ++
>  .../dt-bindings/interconnect/qcom,ipq5424.h   |  3 +
>  3 files changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml
> new file mode 100644
> index 000000000000..abb9eb78d271
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,ipq5424-apss-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm APSS IPQ5424 Clock Controller
> +
> +maintainers:
> +  - Sricharan Ramabadhran <quic_srichara@quicinc.com>
> +  - Md Sadre Alam <quic_mdalam@quicinc.com>

Are you sure? Why they do not send their code then? Usually sending
other poeple's code means they do not care or moved on or changed jobs.

> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The CPU core in ipq5424 is clocked by a huayra PLL with RCG support.
> +  The RCG and PLL have a separate register space from the GCC.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,ipq5424-apss-clk

Missing blank line

> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Reference to the XO clock.
> +      - description: Reference to the GPLL0 clock.
> +
> +  clock-names:
> +    items:
> +      - const: xo
> +      - const: gpll0

You do not name the inputs according how provider calls them. You name
them based on the INPUT. pll? source? bus?

> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#interconnect-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'
> +  - '#interconnect-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,ipq5424-gcc.h>
> +
> +    apss_clk: apss-clock@fa80000 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Best regards,
Krzysztof


