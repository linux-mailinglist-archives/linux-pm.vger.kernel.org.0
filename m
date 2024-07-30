Return-Path: <linux-pm+bounces-11629-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A25894083F
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 08:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCC8B1F23E5E
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 06:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B0716C86F;
	Tue, 30 Jul 2024 06:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyVRE8Lh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5BF168489;
	Tue, 30 Jul 2024 06:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722320438; cv=none; b=vCLpXTKjlFn3FUA2utSSZLuo0pOCJFQizQO4ZlR4OLk150WF//McY/jcT8Ir5Ib19x7pTqJci7Y/4/w7XlEo2y9B/S0kGX5YtUZXgHKXhDMo1YYg4FtDvuJ/TGGpB1YIW8WBW2AJirfLhvdpj31honTkNe0XkbLQCWhPfBjKOWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722320438; c=relaxed/simple;
	bh=cCEHv3EcRRfR3yMNUwGFtRbviA3JE4aiZjOmJn2agZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+75kawQVgD6lqZj1/cREIbZL4A/hdhVAPia7vfyaMlN86uD9GAnU3GeqCOjUj7O17PaZs1wbDlrff/7NkeqVumImw5fEaVt7yy5keirbCHs/3pyqFEIpDJFgWSDHFodYtOyIO5U2O7p3Dtr+ErVlm6BzcmyZAybnPXm1Q0IgGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyVRE8Lh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879F9C32782;
	Tue, 30 Jul 2024 06:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722320438;
	bh=cCEHv3EcRRfR3yMNUwGFtRbviA3JE4aiZjOmJn2agZI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JyVRE8LhEWcYNjDKLddLtTE4FVPvkPd7aeXuMnu24HC4bSu17yvsONl0eAEG00s2k
	 +GbEU82q9ucGSYo0b6dt3AXRuCBKMU6fKXuMpcYwMEWZxSgg4M4xlP8fBkMxRCzcv/
	 47Y03QApa1VMOuV0jAXTYCLgV3CZcAFin2wz9xDItydbiEeNpXa56dzwq1svkRYO1T
	 yVkWFzLsfm5C6s4EhL/yLojtsnb3+tlwnsas+O5Ox8Rg4MiM5kqXQJgQQ31QDSFT9Y
	 g3/4j+v0QiI2Q3S6e3CFVglyIS8zdXIkOBReyn9woBd8bRpGcoDhV/PjAE/zvDRzNP
	 6XcBGVHbcRgZw==
Message-ID: <4205c1d0-0d91-4593-bf71-be8f02721ddd@kernel.org>
Date: Tue, 30 Jul 2024 08:20:30 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] dt-bindings: qcom,spmi-temp-alarm: Add compatible for
 lite temp alarm
To: Anjelique Melendez <quic_amelende@quicinc.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, amitk@kernel.org,
 thara.gopinath@gmail.com, andersson@kernel.org
Cc: quic_collinsd@quicinc.com, rafael@kernel.org, daniel.lezcano@linaro.org,
 rui.zhang@intel.com, lukasz.luba@arm.com, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240729231259.2122976-1-quic_amelende@quicinc.com>
 <20240729231259.2122976-3-quic_amelende@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240729231259.2122976-3-quic_amelende@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/07/2024 01:12, Anjelique Melendez wrote:
> Add compatible "qcom,spmi-temp-alarm-lite" for Temp alarm lite
> peripherals. Temp alarm lite peripherals have two stages: warning and
> shutdown, and use a pair of registers to configure warning interrupt
> threshold temperature and an automatic hardware shutdown threshold
> temperature.
> 
> When defining thermal zone trips for a temp alarm lite device the first
> thermal zone trip is for warning alarm IRQ in HW, the second thermal
> zone trip is purely for software to perform a controlled shutdown (no HW
> support) and the third thermal zone trip is for automatic hardware
> shutdown.
> 
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---
>  .../thermal/qcom,spmi-temp-alarm.yaml         | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml b/Documentation/devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml
> index f9af88d51c2d..bbf201cad16b 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml
> @@ -22,6 +22,7 @@ properties:
>      enum:
>        - qcom,spmi-temp-alarm
>        - qcom,spmi-temp-alarm-gen2-rev2
> +      - qcom,spmi-temp-alarm-lite

Uhu, it's growing, now we have "lite". No, this is way too ambiguous.

NAK. Use PMIC compatibles.

>  
>    reg:
>      maxItems: 1
> @@ -84,3 +85,46 @@ examples:
>              };
>          };
>      };
> +
> +  - |
> +
> +    pmic {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pm8550b_lite_tz: pm8550b-temp-alarm-lite@c00 {

There is no difference in this example, drop.

> +            compatible = "qcom,spmi-temp-alarm-lite";
> +            reg = <0xc00>;
> +            interrupts = <0x1 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
> +            #thermal-sensor-cells = <0>;
> +        };
> +    };
> +
> +    thermal-zones {
> +        pm8550b_lite_temp_alarm: pm8550blite-thermal {

Drop as well.


Best regards,
Krzysztof


