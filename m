Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43EF3BAC84
	for <lists+linux-pm@lfdr.de>; Sun,  4 Jul 2021 11:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhGDJjg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jul 2021 05:39:36 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:21620 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhGDJjf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jul 2021 05:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1625391417;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=/+wpk91XMTrihc0Qk9RG3f8dQOkAeUU1aoN6fWllpYM=;
    b=AWYE1y2P5P0ZuIi/dY80zB0abajbv326S4WSmfUtKjqLNdS64WjyVCK+I268e+bCmB
    3jat+1qj/drJLCZm8NIr5jQifWLFuW2Qt1Q/XSOuGbDFApsBg6fM6j9q2xXyBihmy8zL
    7o2+5mO2jKkvybUGwpM/4BpX1UiixBWPPk6ufsC5lPf67IbBXzzzAwmx9RFioAExvgwf
    vAn7xPftt34vlxgLeuabOqIyJw1esIjmXwa+Y02VPRltZ+WYtlldQZZcmjk4dCJtujoI
    /+LPXkzzI+T1lNHBg5Uq98FMAqVJtdbTEboP+riWTP4bYz4FNfu2w2TvL9QAMWI+yxHm
    p0Ew==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j5Ic/HBg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.28.1 DYNA|AUTH)
    with ESMTPSA id Y070ccx649avK4p
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 4 Jul 2021 11:36:57 +0200 (CEST)
Date:   Sun, 4 Jul 2021 11:36:41 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: qcom,pon: Add 'qcom,mode-in-imem'
 support
Message-ID: <YOGArXunEf2O58gL@gerhold.net>
References: <20210704074045.21643-1-shawn.guo@linaro.org>
 <20210704074045.21643-3-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210704074045.21643-3-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jul 04, 2021 at 03:40:44PM +0800, Shawn Guo wrote:
> It's not always the case that reboot mode value gets stored in PON
> register.  For example, Sony Xperia M4 Aqua phone (MSM8939) uses a
> different set of mode value and stores them in IMEM.  Add property
> 'qcom,mode-in-imem' to distinguish this mechanism from the existing one.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  .../bindings/power/reset/qcom,pon.yaml        | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> index 7764c804af1d..a6270e39b7a2 100644
> --- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> @@ -23,6 +23,10 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  qcom,mode-in-imem:
> +    description: Reboot mode is stored in IMEM rather than PON register
> +    type: boolean
> +
>  patternProperties:
>    "^mode-.+":
>      $ref: /schemas/types.yaml#/definitions/uint32
> @@ -35,6 +39,7 @@ required:
>  additionalProperties: false
>  
>  examples:
> +  # Example 1: Reboot mode is stored in PON register
>    - |
>      pmic {
>          #address-cells = <1>;
> @@ -47,3 +52,17 @@ examples:
>              mode-recovery = <0x1>;
>          };
>      };
> +  # Example 2: Reboot mode is stored in IMEM
> +  - |
> +    pmic {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pon@800 {
> +            compatible = "qcom,pm8916-pon";
> +            reg = <0x860065c>;

This is quite strange. pon@800 is a node of the PM8916 PMIC,
so the reg should refer to the address inside the PMIC, not some memory
address of the SoC. dtc will probably warn about this too since the unit
address (@800) should match the first reg. (At least on W=1.)

Actually we already have some devices using IMEM for the reboot mode,
like this (qcom-msm8974.dtsi plus qcom-msm8974-fairphone-fp2.dts):

	imem@fe805000 {
		compatible = "syscon", "simple-mfd";
		reg = <0xfe805000 0x1000>;

		reboot-mode {
			compatible = "syscon-reboot-mode";
			offset = <0x65c>;
			mode-normal	= <0x77665501>;
			mode-bootloader	= <0x77665500>;
			mode-recovery	= <0x77665502>;
		};
	};

Perhaps it would be cleaner to add a property to disable the reboot mode
functionality of pm8916-pon and then set it up like this?

Thanks!
Stephan
