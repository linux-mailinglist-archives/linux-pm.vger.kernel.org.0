Return-Path: <linux-pm+bounces-9952-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A958391694D
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 15:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE99B1C21051
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 13:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E5315FA7C;
	Tue, 25 Jun 2024 13:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyDTq8fh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9987E14F9E0;
	Tue, 25 Jun 2024 13:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323260; cv=none; b=IL9za8/CNtsYLG6PGAwuaH9u4YOuryKStVG8uovfsvMFiRXYyrw778FaAhcLPy4rl/pyyXZ57cU2smAs+vGVjndVn8UIJKGX0CgguBtVNkS4TTsGL6edfCTSY2jTSvsoDOHChOxEHmfeQeSstlRHCKPH7cM5Q2e/Y4b/9q6/RJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323260; c=relaxed/simple;
	bh=b5bQuGXklfY8sLk02p3wUGhDJpODn0sWZF1HuKoUfWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CRa7v9EbCgbrVloIZsEfrsa9BxzVlxS3+xV9FDtCDeu526/lfl4Vvr5X+NnzCK6ks+j8rrpaeQjNYdBpfqvtuwBP/gB/gyXX0Aidryb26Zx4Mr/DQW00QBKwsUD6mw4SqfsqdeB9//nXJQyoNd4CrxxtoomYcI90NmQO2mO/Eb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyDTq8fh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC60C32781;
	Tue, 25 Jun 2024 13:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719323260;
	bh=b5bQuGXklfY8sLk02p3wUGhDJpODn0sWZF1HuKoUfWo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dyDTq8fhq+PeJuFomMNte/WwU8kiBcnStzb9DDQvEygH//GiYOAmpRrC0eG9StExJ
	 NDybtJWhT8fEhzgvuzsRaR6F2t4aSEK4XRhPWIM0PiugiVRJtFukwOkqHOlwy46TLR
	 FbWHXREiU8vPY/5LVJW8fQJB/4gRfZvNHziUqOPoik9qFXUVFX3vig/mWdAv3L7Dqu
	 1a/bW/5Qtcn0zcSjWxtofJ3T29GDVjVARn0qtZX/mCO20DDT27ifbcWeSlh6vkQqDc
	 NlkrnBQp1EwroLdSbSnV79RgIFqNdTKJLLYXdihVoeCzKXDjCJr30p7Cs90nvdbjn8
	 gsVk79O6UmbZw==
Message-ID: <772d65a6-9d89-4e65-8fc4-f60040a91f24@kernel.org>
Date: Tue, 25 Jun 2024 16:47:34 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/4] dt-bindings: interconnect: qcom,msm8998-bwmon:
 Remove opp-table from the required list
To: Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, dmitry.baryshkov@linaro.org,
 srinivas.kandagatla@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 quic_rgottimu@quicinc.com, quic_kshivnan@quicinc.com, conor+dt@kernel.org,
 abel.vesa@linaro.org
References: <20240624092214.146935-1-quic_sibis@quicinc.com>
 <20240624092214.146935-2-quic_sibis@quicinc.com>
Content-Language: en-US
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20240624092214.146935-2-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.06.24 12:22, Sibi Sankar wrote:
> Remove opp-table from the required list as the bindings shouldn't care
> where the OPP tables (referenced by the operating-points-v2 property)
> comes from.
> 
> Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>

Acked-by: Georgi Djakov <djakov@kernel.org>

> ---
> 
> v3:
> * Drop OPP table from the required property list. [Konrad/Krzysztof]
> 
>   .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml     | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> index 05067e197abe..9c248e1eabe2 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> @@ -72,7 +72,6 @@ required:
>     - interconnects
>     - interrupts
>     - operating-points-v2
> -  - opp-table
>     - reg
>   
>   additionalProperties: false


