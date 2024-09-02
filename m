Return-Path: <linux-pm+bounces-13361-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F79D968E63
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 21:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D711C22F92
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 19:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD501A2644;
	Mon,  2 Sep 2024 19:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiH15ebP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B351A3AB6;
	Mon,  2 Sep 2024 19:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725304782; cv=none; b=Gm7vJTTSNLfO0FUWoETwjUFduGoPJITi6qvovAGr2MbFlpwzq2NAP9VXEn0NvsT2Pr+Twm4bLWhyZbyUMS21nN19uTcHoqiW43PNWvNRZWHODoIFQKEgKGx9BLMduOia/WhjKxUzm6RLPkV+vtouoz5r09FLu2s79oUEqyscR40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725304782; c=relaxed/simple;
	bh=CSG42c0Zza6vQ2aeIZ0JWOH/0VvsfGO1cv6kMXBDw6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AbcyhXHswgO327doaJNlMN31bJ/66vINjC+jTEBkY2BEiDS3vp+zxv46AjutYAoORQXrfR4/SQXtP5Plg1lMFyMXmLyDg5ac47Xs/o7OW7uptLvgIMNjB70EXl0/tHlaq7M2k1UVMynRMqWhaumTSSuTXvmzuGQ1CrtbImJGqK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiH15ebP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8B6C4CEC8;
	Mon,  2 Sep 2024 19:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725304781;
	bh=CSG42c0Zza6vQ2aeIZ0JWOH/0VvsfGO1cv6kMXBDw6U=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=aiH15ebPMb+BTMSWl1RX4qe0PycRIQbNRQToY6db+26jTPBqCFdgFvktJdpRNQWmt
	 5PoM+81kb8Q5tVXb7lzZZzXwFntFrX7959Lb8wNl5sNizqB0ZcIbjhRkPZnmmCbpYJ
	 7Eghso8DNUif2f4LbBt7CcZkDYohImO46sSpo2CqpySPKQnge2vjnpdLLbI8RGNs8r
	 nwmVGbEpi4Nc3lawsCs6nWOLCQF9d0cj4ouLErWVM3sroS0qlFGiCze2rf18nrFjW1
	 PUFDWy44/PlKnmiVm+r1HOdD11OgicewSFl1TJX79hBRxjUqa+UsBlBvI5mao3MX87
	 igNaukAwdmJdQ==
Message-ID: <815b7445-3113-4ef7-ab36-b4a216308dd6@kernel.org>
Date: Mon, 2 Sep 2024 22:19:34 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/8] dt-bindings: interconnect: Update master/slave id
 list
To: Varadarajan Narayanan <quic_varada@quicinc.com>, andersson@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org,
 catalin.marinas@arm.com, will@kernel.org, richardcochran@gmail.com,
 geert+renesas@glider.be, dmitry.baryshkov@linaro.org,
 neil.armstrong@linaro.org, arnd@arndb.de, nfraprado@collabora.com,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240829082830.56959-1-quic_varada@quicinc.com>
 <20240829082830.56959-5-quic_varada@quicinc.com>
Content-Language: en-US
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20240829082830.56959-5-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.08.24 11:28, Varadarajan Narayanan wrote:
> Update the GCC master/slave list to include couple of
> more interfaces needed by the Network Subsystem Clock
> Controller (NSSCC)
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

Acked-by: Georgi Djakov <djakov@kernel.org>

> ---
>   include/dt-bindings/interconnect/qcom,ipq5332.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/include/dt-bindings/interconnect/qcom,ipq5332.h b/include/dt-bindings/interconnect/qcom,ipq5332.h
> index 16475bb07a48..5c08dd3c4f47 100644
> --- a/include/dt-bindings/interconnect/qcom,ipq5332.h
> +++ b/include/dt-bindings/interconnect/qcom,ipq5332.h
> @@ -28,6 +28,10 @@
>   #define SLAVE_NSSNOC_TIMEOUT_REF	23
>   #define MASTER_NSSNOC_XO_DCD		24
>   #define SLAVE_NSSNOC_XO_DCD		25
> +#define MASTER_SNOC_NSSNOC_1_CLK	26
> +#define SLAVE_SNOC_NSSNOC_1_CLK		27
> +#define MASTER_SNOC_NSSNOC_CLK		28
> +#define SLAVE_SNOC_NSSNOC_CLK		29
>   
>   #define MASTER_NSSNOC_PPE		0
>   #define SLAVE_NSSNOC_PPE		1


