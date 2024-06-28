Return-Path: <linux-pm+bounces-10208-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA2A91C5EC
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 20:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5191F22C7E
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 18:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728881CD5D4;
	Fri, 28 Jun 2024 18:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S05dfqxr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2AA1C8FAB;
	Fri, 28 Jun 2024 18:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719599996; cv=none; b=jCPFvdpls3hI1Njjr2cMwPWr6A4xyN2DMR5YChUJAKbRYT32C/BUtecybvgXURCBIUnT/1jyUdjPK0Rel6N/P4a2YoFTz1u4hxclmukrIW3UAoF7TvtlYr4Q/gRRNDHtE/1zoIurH91QA+TFF9Z9gbjX0IjQf+v6dtlAfvFi5KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719599996; c=relaxed/simple;
	bh=XoSwQPaw4xVSbnAE6h9xsyMVlZcN3NV1inNXV2TNqpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g2yEGqdU5gNc57FUa9YkuSrRi8VXnpj6MdWofX1DmCutrGffKYOexVQl4ryT5ZgQx/j9wnLDY00WJYop8NWOQ5EUyKUaMh3Ej7Jxj+T+DGpM5YDk7sJkWgalt0cbq5oz52+sKi3KMVf18D9b3POmqzjhtmyugxK1YzPcLLlLCAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S05dfqxr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8A5C116B1;
	Fri, 28 Jun 2024 18:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719599995;
	bh=XoSwQPaw4xVSbnAE6h9xsyMVlZcN3NV1inNXV2TNqpI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S05dfqxrMD31tfJs1vAXWacCilgnvjqVWdB1Xp39HiiTM0CrR3S+Tb089H6w4CVBt
	 8jY6m0l2TZKR5W8WgBIfdhJ9V+BIHKIF7ZEHnbzEQoZNeKZ9LFOkhI+5bC2i0f8veI
	 P/cmNZH3WX5lQuzFugKlbga0w5mkS0Cdu/njXy2ud3Cwozg1GqhLIRVhwxLeY41U6i
	 papDbkXage/4s79R1YO+gGpk/0E2O5c7+xkz215PS3/ydxCpUASihT+mleSKII5Xrq
	 bM+F/uMhLOYzK0Ja6cFGMWQPteYWGYQ/rJKnbTaONXXO0obod4x3jFC1upElwYHPxL
	 6q65VHUIhsqHw==
Message-ID: <f0f09455-5bfd-4dbc-b393-dbef75441e8a@kernel.org>
Date: Fri, 28 Jun 2024 21:39:50 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] interconnect: qcom: Add MSM8953 driver
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 Vladimir Lypak <vladimir.lypak@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240628-msm8953-interconnect-v3-0-a70d582182dc@mainlining.org>
 <20240628-msm8953-interconnect-v3-2-a70d582182dc@mainlining.org>
Content-Language: en-US
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20240628-msm8953-interconnect-v3-2-a70d582182dc@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Barnabás,

Thank you for the patches!

On 28.06.24 17:01, Barnabás Czémán wrote:
> From: Vladimir Lypak <vladimir.lypak@gmail.com>
> 
> Add driver for interconnect busses found in MSM8953 based platforms.
> The topology consists of four NoCs that are partially controlled by a
> RPM processor.
> 
> Note that one of NoCs (System NoC) has a counterpart (System NoC MM)
> that is modelled as child device to avoid resource conflicts, since it
> uses same MMIO space for configuration.
> 
> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>   drivers/interconnect/qcom/Kconfig   |    9 +
>   drivers/interconnect/qcom/Makefile  |    2 +
>   drivers/interconnect/qcom/msm8953.c | 1321 +++++++++++++++++++++++++++++++++++
>   3 files changed, 1332 insertions(+)
[..]
> +++ b/drivers/interconnect/qcom/msm8953.c
[..]
> +static const struct of_device_id msm8953_noc_of_match[] = {
> +	{ .compatible = "qcom,msm8953-bimc", .data = &msm8953_bimc },
> +	{ .compatible = "qcom,msm8953-pcnoc", .data = &msm8953_pcnoc },
> +	{ .compatible = "qcom,msm8953-snoc", .data = &msm8953_snoc },
> +	{ .compatible = "qcom,msm8953-snoc-mm", .data = &msm8953_snoc_mm },
> +	{ }
> +};
> +
> +static struct platform_driver msm8953_noc_driver = {
> +	.probe = qnoc_probe,
> +	.remove_new = qnoc_remove,
> +	.driver = {
> +		.name = "qnoc-msm8953",
> +		.of_match_table = msm8953_noc_of_match,

Why no .sync_state?

BR,
Georgi

