Return-Path: <linux-pm+bounces-42016-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFR2JkKDgmneVgMAu9opvQ
	(envelope-from <linux-pm+bounces-42016-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 00:22:42 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F61DFB7B
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 00:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8A9B3057EB2
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 23:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5453A326D51;
	Tue,  3 Feb 2026 23:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lA7Z6LXz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F05731ED83
	for <linux-pm@vger.kernel.org>; Tue,  3 Feb 2026 23:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770160939; cv=none; b=jI1fVaki5NjEItVQKeMdSGtT96J2db+JmMqDPSAhRYUNPONRM4m+62zAUWwXKc2lNXgaE2Zjqxxrvh7a+SVHnL3WYkYK40RLUhwrgCtx3vdIpJTlBjf4unXNhpbZK3P8y/v6x80jVo1oxPXOqPK9JBp0FQDjM997SKubjWCEAcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770160939; c=relaxed/simple;
	bh=vmGDTvEh0kB/nA8sp+H/PED+RYlPTGDJvMgu8OOxZgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f3MFBMIGyl8u9YhGJFtcTL8BOl+EFT2AxWj+7O0ja5bmuSve3JtvGm2Sr6oRZhyCymIr7SdH05D2tBRHjQylFO4zSMkBFxwTa6rEZpbplcn/XGMHq7j0nPQPASBtJlxfdX6rX6vRMUMa+HYA1nTLSy53q2wLflMFCCKgpGP+N48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lA7Z6LXz; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42fed090e5fso67907f8f.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 15:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770160935; x=1770765735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zHQSzgLVAjnFP4dBv05KnkyuxPSQFJ3wmRvAOwsqKgI=;
        b=lA7Z6LXzT+vaJ1rbVAfhg+7GjJkYrIgBM/ims6zHGMCYrIxKjmE+WPTRfIzvcSdrA6
         jXpZ5dLPLw5gwb75RVqmPp3+pgUFoRZ18CYP6U/dgkpcDx5LKNMhAzamnfaku1LiRPh8
         iWyVmJ6+6IgFiVkuGUW9opeO49Fd8zt+lH/PrmgYDzflPy3JCaXnRt+0aUWfmwnQV0yO
         hqHG96AxXgFcKXIVNuUyYO5q3x5j7gF13SCMf+QIewodnXqcPRV8yxRjS72a4wNk0LTn
         aeTtg0nxCbrFvDYRBkoawUU+gbtm1DkOTxo5zGzc8INEo5nDZ2hWxOZ/LTBVglaKaAeZ
         iuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770160935; x=1770765735;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zHQSzgLVAjnFP4dBv05KnkyuxPSQFJ3wmRvAOwsqKgI=;
        b=xSDbTedOJSHAFuIjxC9jxPM0DosRW+U9e/jf3XKY+qaHwP5xxJ697FZF+0HNfq2Vo3
         ZfMIn06TvfqBsGnDPIc7uba/FqskRUP2RVyrpUwfbocWTg5Nsza0w1VQrHOKBsVoi1Za
         3wOwQs5xXYDMVMWsolXyMhLx+v6lyMC++6M3rKcZXmi0m45jfA2njudIfpQGIN7wFuKz
         Q6/5LUJocU8Xu+aNl6bCvmdX+0Yc3FQ/j9tHgs6xQPfBdEpZE9ZfdL3hyAaHgn+QQxsb
         eL7pEXAUbv4krvcTOCdjKwVhu7aLtgzLe+kCWwNovlKgjXdM2/E+SRgv9auCd/b6Q4e/
         OvBA==
X-Forwarded-Encrypted: i=1; AJvYcCUdxCn257xTPmFoXmDaklSlbbs6cY/XotdxgoI4ioE/XMlzIe+zCwq32OHE+IdUP9tWuQPOpkWtFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb3TkTsbdkNJmmzwCGUOrbcRd2/Q2EPjlMZXG8DI39EMP76fjE
	/FZ6xF+JZLCZMtUmmL/gPZvhCyZkDo5ghxL47QPeeF6LVMD/dJDH78m+yZvyWyaYysg=
X-Gm-Gg: AZuq6aK2EgpU8KUXehFrskjT1RDSpvwGVnUF8qII4ZYfGuHNRUGSECdamHIZkgVP6Er
	jgg0gV7m4Wv4HgAmksHR7LBIhxDKlu0xzT9J75TAWdLs3OzBTn0IJyImTOiuH25Um/i5Yj2kksU
	QcmnEpjglPNCxoXGc9peov2g6D0IY+MSnz+1AA+i60Lc7hg46OgyCQ2NGchcj1ElmKfYzfe97Gn
	/rZed5C6zgI2UYNqNDSwkYoMUBRn446SrtQh2EDjZLUFDZunWBxCR/MN2NNavqoxMVMlxiBiqOO
	os0zuAbEqVsEu9tMFjjQwr1elR8V4U6R1dAPsM4un2nbsb78DYHap5t6s5KmWMurC54NWxoM2ME
	4SENgeB8V8iR8fWbJCXL3BopK9hqqo5Ho4rrn9hlga9q9+7QevQouA9cYtpmwPE5JZCXeM7/ak2
	JPPKVc0iyZRjyTmDMRREGDPpDwedJWL7ZxXvWEt+P5eHzUMUUg3o5l6dmhR2VLyrk=
X-Received: by 2002:a05:6000:603:b0:436:143c:c000 with SMTP id ffacd0b85a97d-436180593b3mr1240527f8f.45.1770160935331;
        Tue, 03 Feb 2026 15:22:15 -0800 (PST)
Received: from [192.168.0.40] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43618057f7csm2010133f8f.23.2026.02.03.15.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 15:22:14 -0800 (PST)
Message-ID: <e29f4014-a8f5-479c-8043-e0d9f3de06d7@linaro.org>
Date: Tue, 3 Feb 2026 23:22:12 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] media: dt-bindings: qcom,sm8250-venus: sort out
 power domains
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
 <26272oeYIcfP__dNdKT_lizJQ9hvr9jKE2zsy_3aiWVlymjbtHB5vToDV_2DL3N8gIxnqB_YminHDztbUanmwg==@protonmail.internalid>
 <20260201-iris-venus-fix-sm8250-v2-3-6f40d2605c89@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20260201-iris-venus-fix-sm8250-v2-3-6f40d2605c89@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42016-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bryan.odonoghue@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,linaro.org:email,linaro.org:dkim,linaro.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 06F61DFB7B
X-Rspamd-Action: no action

On 01/02/2026 10:49, Dmitry Baryshkov wrote:
> First of all, on SM8250 Iris (ex-Venus) core needs to scale clocks which
> are powered by the MMCX domain. Add MMCX domain to the list of the power
> domain to be used on this platform.
> 
> While we are at it, drop minItems from both power-domains and
> power-domains-names, it doesn't make sense from the hardware point of
> view. There are always 2 GDSCs and two power rails wired to the video
> clock controller and Venus. Disallow passing just two.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>   Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
> index da54493220c9..04cbacc251d7 100644
> --- a/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
> @@ -21,15 +21,14 @@ properties:
>       const: qcom,sm8250-venus
> 
>     power-domains:
> -    minItems: 2
> -    maxItems: 3
> +    maxItems: 4
> 
>     power-domain-names:
> -    minItems: 2
>       items:
>         - const: venus
>         - const: vcodec0
>         - const: mx
> +      - const: mmcx
> 
>     clocks:
>       maxItems: 3
> @@ -114,8 +113,9 @@ examples:
>           interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
>           power-domains = <&videocc MVS0C_GDSC>,
>                           <&videocc MVS0_GDSC>,
> -                        <&rpmhpd RPMHPD_MX>;
> -        power-domain-names = "venus", "vcodec0", "mx";
> +                        <&rpmhpd RPMHPD_MX>,
> +                        <&rpmhpd RPMHPD_MMCX>;
> +        power-domain-names = "venus", "vcodec0", "mx", "mmcx";
> 
>           clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
>                    <&videocc VIDEO_CC_MVS0C_CLK>,
> 
> --
> 2.47.3
> 
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

