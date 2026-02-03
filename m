Return-Path: <linux-pm+bounces-42013-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAwpJMeCgmneVgMAu9opvQ
	(envelope-from <linux-pm+bounces-42013-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 00:20:39 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C1839DFAE3
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 00:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9E3B33008099
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 23:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1D231AF1F;
	Tue,  3 Feb 2026 23:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BZ+bG4DI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44DF3148C1
	for <linux-pm@vger.kernel.org>; Tue,  3 Feb 2026 23:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770160786; cv=none; b=bHKI/y0k7JQQNj3GL3+1xJjjtH/VQFXIsWBEz7HkieyS1qRFvRh9NMK0c617Qq48yNmP/R3WUkPgkaXk+pRwoL8s9bxJkvV0YetjA3e/mNwr/BXm/+sijCuoaZxIywkyViWawE8cRLDWfBxIHgYu+nvRXj7afRtL4eJKnHmeBJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770160786; c=relaxed/simple;
	bh=QmJIRkoJvSC1+X5XmHnKi501SEuHKyJrim2KrRQ9zFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SurMOzOXFU9E2qtbBWWOuqji2B7OZ0lSw+e/cCQXBbolGyqu4GMOi6u5Shweh/3hGMFDZlLfqY+FMuo5dCOb+MEUIp7ja9grWRd86jxpoEGyJ9p/zUwZtVsJL2CGcHXlwXhmKNHyiWi22wKMBjArvdslP93WfLgKD0ImP40/vZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BZ+bG4DI; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-47fedb7c68dso1159615e9.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 15:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770160783; x=1770765583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nUf/+8BbxtoTRhkrLvjqMjX8iWnPM8A43bKR4Om6EwE=;
        b=BZ+bG4DIorv3Ms/VAg1NzEFZ9dK0XKKnWYUFIoEjjsTpLTi6DGrMlEw3ptbVClWDKS
         6ueTSgQgEvee72itnYjh6LkSB2u0NBM07EpK+KKlDkbwUf73M3R2nSPR/5l/C4xycTh/
         WKofmE121djfiy+TaVV4UXI/GAhV9SvobJOPdmO6fIDNxBFyIN0c64tOD5zxHt0xPNrU
         LymDtom+q9w3cgKhYHTewqGxqTtrwy1Fk2wGqkCwVlFqtjy+g1/5niKy5KqRFp/2zt/h
         4ilr/Y8BFT4RAXnmDyHWgQ/Jxoancq4ShpxKcOl1p74XU9ecVnFJ43f+HxokvG26fmCV
         VLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770160783; x=1770765583;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nUf/+8BbxtoTRhkrLvjqMjX8iWnPM8A43bKR4Om6EwE=;
        b=FDdt+cFpKtsxWKxPGMb+Tc1RAot3OEcN6joISdhyUQ3w8QK/tj1mC2jplpoOujseBD
         6nhPs3KlUtmwFLTa3a7kwRiJ6MHk83XTMKGX3M2coS3aNG09PWEvTWOLYclAoES0AM/Z
         bEDgrJEHIV0meLF9LizfCett3NrPw5tPL8lTxR235cLyUhlaYdu/DKhCmtVFW+NpnIlZ
         kMRcpefgEpWdj/U4BIAQKk0x82Dz069uFhBC12RIi51aPMcAXH+Ag18RU82nATwQbBNN
         LxV9OtWgQRXef0btXQixSTNE50YJNI6PR5Z9DSVHsEx9J6wJTP8/i4Q/MCf1D3w6s/+k
         HiGg==
X-Forwarded-Encrypted: i=1; AJvYcCVdUx5gnKfjEx+0G6BMExOrQL3SSsOXnYaWRNDR1WwWyOvUu3UxHxRbch5JVuzF/t99KNhBC1GApw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCgTI7Usd792kAgz0HKXOUYiN4tHSJboWrtkPhvoa67dkeAF+V
	cbcQ56oPvrAoAqzC5fAjrmJtJSEVwUKL2XhhN4Ac00DR2BblKvuV9I10yw+sq15djAE=
X-Gm-Gg: AZuq6aKDrzDIp63PIZyKwBS0XuqREQeehnXrk29g+A2xBqLw9JnI+cwO/tNkopm2CLy
	VX5k5m/vnHb3zhx5gb3fn0FRfC/uQ2pEdFR6k72DyjbHILzLnUbvpqa/p/1axij3aRgN4K2VyDw
	d9l2sQ/+5ct2ULlRsYF4RkO3IYxWhUDNFKYMRkt0JLbW9fVodFHC76JVoyhWgjY3AYaQPToYicS
	ZlYyBY3I5Qol+hYwClTrTsLw9XyhzIJlHQakBhohibriQ997S3bH0sdIEW9kMNkk2KQkiRKm9kG
	B8xXhCwyeD6/oI6WhEFruT2NtOcKAZontcyMhuMfokiCM6mM1WdarFQlI+tx2fvZXmUmADyuKv9
	EmIIWhSm8bercBs7khXPBuhE8qI1mh5NF/AbT9qhKN59kuQ89NOIuQ5DSuZptoTXHIq82NBLP6+
	a40A8q56dUi9RfFt2TytIoqUDlMu0z34QfTrYeV1Xv+mLUWMxRkm8a
X-Received: by 2002:a05:600c:1c17:b0:480:5951:fc1e with SMTP id 5b1f17b1804b1-4830e930f73mr17628865e9.11.1770160783238;
        Tue, 03 Feb 2026 15:19:43 -0800 (PST)
Received: from [192.168.0.40] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483108ec315sm2221095e9.8.2026.02.03.15.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 15:19:42 -0800 (PST)
Message-ID: <0c3acd1c-5860-4819-9b36-6935137deea8@linaro.org>
Date: Tue, 3 Feb 2026 23:19:39 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] dt-bindings: clock: qcom,sm8250-videocc: account
 for the MX domain
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
 Jonathan Marek <jonathan@marek.ca>, Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Hans Verkuil <hverkuil@kernel.org>,
 Stefan Schmidt <stefan.schmidt@linaro.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Dikshita Agarwal <dikshita@qti.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <20260201-iris-venus-fix-sm8250-v2-0-6f40d2605c89@oss.qualcomm.com>
 <gfDLl0QXQ6wHp-p_Lm8sRAgCea7hCkOH5OWeF2Rj3rLMllCVIut5Je7AqhSNCTptN0w13hXwkQvP9rjH9hNUHw==@protonmail.internalid>
 <20260201-iris-venus-fix-sm8250-v2-1-6f40d2605c89@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20260201-iris-venus-fix-sm8250-v2-1-6f40d2605c89@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42013-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bryan.odonoghue@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[quicinc.com:email,qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linaro.org:email,linaro.org:dkim,linaro.org:mid,ab00000:email]
X-Rspamd-Queue-Id: C1839DFAE3
X-Rspamd-Action: no action

On 01/02/2026 10:48, Dmitry Baryshkov wrote:
> To configure the video PLLs and enable the video GDSCs on SM8250,
> platform, the MX rail must be ON along with MMCX. Split the bindings
> file in order to provide separate file utilizing MMCX and MX power
> domains.
> 
> Fixes: dafb992a95e1 ("dt-bindings: clock: add SM8250 QCOM video clock bindings")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>   .../bindings/clock/qcom,sm8250-videocc.yaml        | 85 ++++++++++++++++++++++
>   .../devicetree/bindings/clock/qcom,videocc.yaml    | 20 -----
>   2 files changed, 85 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8250-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8250-videocc.yaml
> new file mode 100644
> index 000000000000..341d3cbb7cbb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8250-videocc.yaml
> @@ -0,0 +1,85 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,sm8250-videocc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Video Clock & Reset Controller
> +
> +maintainers:
> +  - Taniya Das <quic_tdas@quicinc.com>
> +
> +description: |
> +  Qualcomm video clock control module provides the clocks, resets and power
> +  domains on Qualcomm SoCs.
> +
> +  See also::
> +    include/dt-bindings/clock/qcom,videocc-sm8250.h
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - qcom,sm8250-videocc
> +
> +  clocks:
> +    items:
> +      - description: AHB
> +      - description: Board XO source
> +      - description: Board active XO source
> +
> +  clock-names:
> +    items:
> +      - const: iface
> +      - const: bi_tcxo
> +      - const: bi_tcxo_ao
> +
> +  power-domains:
> +    items:
> +      - description:
> +          A phandle and PM domain specifier for the MMCX power domain.
> +      - description:
> +          A phandle and PM domain specifier for the MX power domain.
> +
> +  required-opps:
> +    items:
> +      - description:
> +          A phandle to an OPP node describing required MMCX performance point.
> +      - description:
> +          A phandle to an OPP node describing required MX performance point.
> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - '#power-domain-cells'
> +  - power-domains
> +  - required-opps
> +
> +allOf:
> +  - $ref: qcom,gcc.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,rpmh.h>
> +    #include <dt-bindings/power/qcom,rpmhpd.h>
> +    clock-controller@ab00000 {
> +      compatible = "qcom,sm8250-videocc";
> +      reg = <0x0ab00000 0x10000>;
> +      clocks = <&gcc_gcc_video_ahb_clk>,
> +               <&rpmhcc RPMH_CXO_CLK>,
> +               <&rpmhcc RPMH_CXO_CLK_A>;
> +      clock-names = "iface",
> +                    "bi_tcxo",
> +                    "bi_tcxo_ao";
> +      #clock-cells = <1>;
> +      #reset-cells = <1>;
> +      #power-domain-cells = <1>;
> +      power-domains = <&rpmhpd RPMHPD_MMCX>,
> +                      <&rpmhpd RPMHPD_MX>;
> +      required-opps = <&rpmhpd_opp_low_svs>,
> +                      <&rpmhpd_opp_low_svs>;
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
> index f4ff9acef9d5..8676c7e22b4c 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
> @@ -19,7 +19,6 @@ description: |
>       include/dt-bindings/clock/qcom,videocc-sc7280.h
>       include/dt-bindings/clock/qcom,videocc-sdm845.h
>       include/dt-bindings/clock/qcom,videocc-sm8150.h
> -    include/dt-bindings/clock/qcom,videocc-sm8250.h
> 
>   properties:
>     compatible:
> @@ -30,7 +29,6 @@ properties:
>             - qcom,sdm845-videocc
>             - qcom,sm6350-videocc
>             - qcom,sm8150-videocc
> -          - qcom,sm8250-videocc
>         - items:
>             - const: qcom,sc8180x-videocc
>             - const: qcom,sm8150-videocc
> @@ -128,24 +126,6 @@ allOf:
>               - const: iface
>               - const: bi_tcxo
> 
> -  - if:
> -      properties:
> -        compatible:
> -          enum:
> -            - qcom,sm8250-videocc
> -    then:
> -      properties:
> -        clocks:
> -          items:
> -            - description: AHB
> -            - description: Board XO source
> -            - description: Board active XO source
> -        clock-names:
> -          items:
> -            - const: iface
> -            - const: bi_tcxo
> -            - const: bi_tcxo_ao
> -
>   unevaluatedProperties: false
> 
>   examples:
> 
> --
> 2.47.3
> 
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

