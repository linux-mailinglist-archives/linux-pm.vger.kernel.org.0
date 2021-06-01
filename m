Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7F7397226
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jun 2021 13:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhFALOi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Jun 2021 07:14:38 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:31859 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbhFALOi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Jun 2021 07:14:38 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1622545970; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=H7I2JnaqYF6CL/wEO6LRuQa0sZewm5UzwCJdW49EwRT4tLTI4/jguwjQNLz87eHb70
    OFEdWfpudWeruM1TybWpYrcLR93EKwerRBEDxcMMN/8WZKtfhvGlMK1Wsfv0Gbk5B7FG
    UvX/SeNjjmtF7IVzgx0NksKAmWD46UYh1rXonYJEsNv5uDaCwW1YrzvmV5DsOCw29NTS
    AyOaajLVT/nPt+3f+nwgbUh4YKKL4PPweOIXoYahZiG6dbMbVWsDG+tDaha19du4LEf0
    x13TM4yCS3FETcw8PSoXNogz+77KC9RKkNvJsis5oH+P5tIJS8Qm0jVLMs9k3VKkzb3k
    BCfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1622545970;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=2Y0syN6BFgNmVAtqwzsN/LcxcMKopqBO9nUiq1/4tlI=;
    b=AHyvsdtdvI45knouM6OjQk8rmLTb1MUai6GTJPTDu60nDuwAZZMz+UAmrKF/KmVQhH
    yLK+lKUzGfZCnANsuZqrSwBfzPQOW4nEG0LbVSG0wqKEn7CjxLQdPzJ6kY5ZCJOWzF1M
    SZHS5TjkUqVXDEyq4dx8OJYGAAkcH0LWbOE0BWhP4G+GsJnoOfE0IakcPoyY6pdURtL6
    aS2tjWdUL3k3HpZBeJvxZTJofihBP5yTmb9L3iCcp8DjQA+BcnC6Ez7LPypVMF2CVqpL
    2w4m4HEVmnLutSTV2eWkunrPLtyKtR1FFmvbreWvMjLtRETI95LUzv05aRMmzztYa0bQ
    faAA==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1622545970;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=2Y0syN6BFgNmVAtqwzsN/LcxcMKopqBO9nUiq1/4tlI=;
    b=JAFNbJbyRgRPd2xlUS0DVhqbBSUm0nUZ4v0v4CIs2LQgtoUzCteQlPtJScC768CbxJ
    R7KhVEB+tfsM7mcaHX5JWQeF79GXJeDs8TYAlWothyr/OngVM2lHcq8bbqleCl50pJ3t
    vozEwIdv+rkpD1fJ+ce5y7W50fix8izaTXQAA+5Z1weZZSiD+1FhkEKUd6BHlRbS2xEK
    UO+NFSuNwR4JP/1i91+DyWImOENHkkZOa0sVhRV28QUx0P76IumbR0SW/VtXxlHYL6mK
    qiGT5m0cJRW68KymPByS4jTa1BIW/0ZBiadkzIbHKP6c2Y8wzdYi63Kp0x0y1evYT64o
    3e1A==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j7Ic/MaIo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.26.3 DYNA|AUTH)
    with ESMTPSA id U0b2c9x51BCoSLb
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 1 Jun 2021 13:12:50 +0200 (CEST)
Date:   Tue, 1 Jun 2021 13:12:45 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        bjorn.andersson@linaro.org, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, rojay@codeaurora.org
Subject: Re: [PATCH v2 1/3] dt-bindings: power: Introduce
 'assigned-performance-states' property
Message-ID: <YLYV3ov/iBffZMg4@gerhold.net>
References: <1622095949-2014-1-git-send-email-rnayak@codeaurora.org>
 <1622095949-2014-2-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622095949-2014-2-git-send-email-rnayak@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Thu, May 27, 2021 at 11:42:27AM +0530, Rajendra Nayak wrote:
> While most devices within power-domains which support performance states,
> scale the performance state dynamically, some devices might want to
> set a static/default performance state while the device is active.
> These devices typically would also run off a fixed clock and not support
> dynamically scaling the device's performance, also known as DVFS techniques.
> Add a property 'assigned-performance-states' which client devices can
> use to set this default performance state on their power-domains.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  .../devicetree/bindings/power/power-domain.yaml    | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/power-domain.yaml b/Documentation/devicetree/bindings/power/power-domain.yaml
> index aed51e9..88cebf2 100644
> --- a/Documentation/devicetree/bindings/power/power-domain.yaml
> +++ b/Documentation/devicetree/bindings/power/power-domain.yaml
> @@ -66,6 +66,19 @@ properties:
>        by the given provider should be subdomains of the domain specified
>        by this binding.
>  
> +  assigned-performance-states:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +       Some devices might need to configure their power domains in a default
> +       performance state while the device is active. These devices typically
> +       would also run off a fixed clock and not support dynamically scaling the
> +       device's performance, also known as DVFS techniques. The list of performance
> +       state values should correspond to the list of power domains specified as part
> +       of the power-domains property. Each cell corresponds to one power-domain.
> +       A value of 0 can be used for power-domains with no performance state
> +       requirement. In case the power-domains have OPP tables associated, the values
> +       here would typically match with one of the entries in the OPP table.
> +

Is it just me or is this actually in the wrong place here?
Given that #power-domain-cells is required this looks like the bindings
for power domain providers, not consumers. :)

It looks like the consumer bindings are still in
Documentation/devicetree/bindings/power/power_domain.txt

>  required:
>    - "#power-domain-cells"
>  
> @@ -131,3 +144,40 @@ examples:
>              min-residency-us = <7000>;
>          };
>      };
> +
> +  - |
> +    parent4: power-controller@12340000 {
> +        compatible = "foo,power-controller";
> +        reg = <0x12340000 0x1000>;
> +        #power-domain-cells = <0>;
> +    };
> +
> +    parent5: power-controller@43210000 {
> +        compatible = "foo,power-controller";
> +        reg = <0x43210000 0x1000>;
> +        #power-domain-cells = <0>;
> +        operating-points-v2 = <&power_opp_table>;
> +
> +        power_opp_table: opp-table {
> +            compatible = "operating-points-v2";
> +
> +            power_opp_low: opp1 {
> +                opp-level = <16>;
> +            };
> +
> +            rpmpd_opp_ret: opp2 {
> +                opp-level = <64>;
> +            };
> +
> +            rpmpd_opp_svs: opp3 {
> +                opp-level = <256>;
> +            };
> +        };
> +    };
> +
> +    child4: consumer@12341000 {
> +        compatible = "foo,consumer";
> +        reg = <0x12341000 0x1000>;
> +        power-domains = <&parent4>, <&parent5>;
> +        assigned-performance-states = <0>, <256>;
> +    };

Bjorn already asked this in v1 [1]:

> May I ask how this is different from saying something like:
>
> 	required-opps = <&??>, <&rpmpd_opp_svs>;

and maybe this was already discussed further elsewhere. But I think at
the very least we need some clarification in the commit message + the
binding documentation how your new property relates to the existing
"required-opps" binding.

Because even if it might not be implemented at the moment,
Documentation/devicetree/bindings/power/power_domain.txt actually also
specifies "required-opps" for device nodes e.g. with the following example:

	leaky-device0@12350000 {
		compatible = "foo,i-leak-current";
		reg = <0x12350000 0x1000>;
		power-domains = <&power 0>;
		required-opps = <&domain0_opp_0>;
	};

It looks like Viresh added that in commit e856f078bcf1
("OPP: Introduce "required-opp" property").

And in general I think it's a bit inconsistent that we usually refer to
performance states with phandles into the OPP table, but the
assigned-performance-states suddenly use "raw numbers".

Stephan

[1]: https://lore.kernel.org/linux-arm-msm/YAG%2FpNXQOS+C2zLr@builder.lan/
