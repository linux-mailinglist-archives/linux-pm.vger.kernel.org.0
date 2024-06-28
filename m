Return-Path: <linux-pm+bounces-10181-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EBB91BBB3
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 11:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60CD92816BA
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 09:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266B61534E6;
	Fri, 28 Jun 2024 09:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qo73OL93"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B5115278D;
	Fri, 28 Jun 2024 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719567687; cv=none; b=J/4Z9Mwpz29x+xQMGqZ2sLP7X/thAvuXhEsQguTCSLU26ebbebD+rGsLrdDsyqpkdrKOCO8RlnboOW1q8ev7cUHEyANJop9DOF42tH/7u31Q+WCgK2InflKkY4wLD4zSemZCoXADZNSnF8tHTTLcWD+6ImCNBwJirf6dok6WfS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719567687; c=relaxed/simple;
	bh=7fE04XeYu9aATZOwl4E0P6Tq0uKzW4U+34C43OY90G4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u0dtaYPPW7sExmpwgrORhEFNPIKZOuz6AZDmXofwJ/M+bADs7Kgjj/RrM6kit2+FWtrRAuT99eSiGQpj5fTgqFvKQCWe6rTBbQNucabpKL9wVjTDwe8sJYbZViuKnw/1fVEkWYBE4NeWOQSPNoJDFeAcVdV6sCHbtWt+paFAZh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qo73OL93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CE0C116B1;
	Fri, 28 Jun 2024 09:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719567686;
	bh=7fE04XeYu9aATZOwl4E0P6Tq0uKzW4U+34C43OY90G4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qo73OL93seSD8rNixz3g4wCJl5tpJBmXte1d3ytOWZ2eEDkV+J2MsU077Rqs4z+SZ
	 0R1Luk+Yjcc11xaMLh8+8n4a/XHePHapn9GUt4u3A14x5KyKPrK1S3K/B7J3FA1DXa
	 XOvI3dxbCj7tlmSo3jk8v/LD3hG77k80LBYVoFdDTaL//nJvZZzx7gISRiOUPStzzv
	 jfcSUwJ+NzEFuiFE7X6yi+H2KsmbCBD0R3FrIhwdG87y5oJJD8AKUhA+Ub8rJ+0HzV
	 SzmgykprLjDn5TBmnacvQ0YmDpTkQATyX3qEHC15Ve+hA903399uV7WUq+Ac+wyn1o
	 qGzPsQgIg1XBA==
Message-ID: <b6b8df30-cd81-489b-801a-afd8fceaf41d@kernel.org>
Date: Fri, 28 Jun 2024 11:41:20 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] interconnect: qcom: Add MSM8953 driver
To: Georgi Djakov <djakov@kernel.org>,
 =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, Vladimir Lypak <vladimir.lypak@gmail.com>
References: <20240627-msm8953-interconnect-v2-0-b4940a8eab69@mainlining.org>
 <20240627-msm8953-interconnect-v2-2-b4940a8eab69@mainlining.org>
 <88588f06-66e1-47a9-b5ab-7849b1c53fb0@kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <88588f06-66e1-47a9-b5ab-7849b1c53fb0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/06/2024 11:32, Georgi Djakov wrote:
> On 27.06.24 18:08, Barnabás Czémán wrote:
>> From: Vladimir Lypak <vladimir.lypak@gmail.com>
>>
>> Add driver for interconnect busses found in MSM8953 based platforms.
>> The topology consists of four NoCs that are partially controlled by a
>> RPM processor.
>>
>> Note that one of NoCs (System NoC) has a counterpart (System NoC MM)
>> that is modelled as child device to avoid resource conflicts, since it
>> uses same MMIO space for configuration.
>>
>> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
>> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
>> ---
>>   drivers/interconnect/qcom/Kconfig   |    9 +
>>   drivers/interconnect/qcom/Makefile  |    2 +
>>   drivers/interconnect/qcom/msm8953.c | 1325 +++++++++++++++++++++++++++++++++++
>>   3 files changed, 1336 insertions(+)
>>
> [..]
>> +
>> +static struct qcom_icc_node * const msm8953_pcnoc_nodes[] = {
>> +	[MAS_SPDM] = &mas_spdm,
>> +	[MAS_BLSP_1] = &mas_blsp_1,
>> +	[MAS_BLSP_2] = &mas_blsp_2,
>> +	[MAS_USB3] = &mas_usb3,
>> +	[MAS_CRYPTO] = &mas_crypto,
>> +	[MAS_SDCC_1] = &mas_sdcc_1,
>> +	[MAS_SDCC_2] = &mas_sdcc_2,
>> +	[MAS_SNOC_PCNOC] = &mas_snoc_pcnoc,
>> +	[PCNOC_M_0] = &pcnoc_m_0,
>> +	[PCNOC_M_1] = &pcnoc_m_1,
>> +	[PCNOC_INT_1] = &pcnoc_int_1,
>> +	[PCNOC_INT_2] = &pcnoc_int_2,
>> +	[PCNOC_S_0] = &pcnoc_s_0,
>> +	[PCNOC_S_1] = &pcnoc_s_1,
>> +	[PCNOC_S_2] = &pcnoc_s_2,
>> +	[PCNOC_S_3] = &pcnoc_s_3,
>> +	[PCNOC_S_4] = &pcnoc_s_4,
>> +	[PCNOC_S_6] = &pcnoc_s_6,
>> +	[PCNOC_S_7] = &pcnoc_s_7,
>> +	[PCNOC_S_8] = &pcnoc_s_8,
>> +	[PCNOC_S_9] = &pcnoc_s_9,
>> +	[SLV_SPDM] = &slv_spdm,
>> +	[SLV_PDM] = &slv_pdm,
>> +	[SLV_TCSR] = &slv_tcsr,
>> +	[SLV_SNOC_CFG] = &slv_snoc_cfg,
>> +	[SLV_TLMM] = &slv_tlmm,
>> +	[SLV_MESSAGE_RAM] = &slv_message_ram,
>> +	[SLV_BLSP_1] = &slv_blsp_1,
>> +	[SLV_BLSP_2] = &slv_blsp_2,
>> +	[SLV_PRNG] = &slv_prng,
>> +	[SLV_CAMERA_SS_CFG] = &slv_camera_ss_cfg,
>> +	[SLV_DISP_SS_CFG] = &slv_disp_ss_cfg,
>> +	[SLV_VENUS_CFG] = &slv_venus_cfg,
>> +	[SLV_GPU_CFG] = &slv_gpu_cfg,
>> +	[SLV_SDCC_1] = &slv_sdcc_1,
>> +	[SLV_SDCC_2] = &slv_sdcc_2,
>> +	[SLV_CRYPTO_0_CFG] = &slv_crypto_0_cfg,
>> +	[SLV_PMIC_ARB] = &slv_pmic_arb,
>> +	[SLV_USB3] = &slv_usb3,
>> +	[SLV_IPA_CFG] = &slv_ipa_cfg,
>> +	[SLV_TCU] = &slv_tcu,
>> +	[SLV_PCNOC_SNOC] = &slv_pcnoc_snoc,
>> +};
>> +
>> +static const char * const msm8953_pcnoc_bus_clocks[] = {
>> +	"bus", "bus_a"
>> +};
> 
> This seems to be unused?

Heh, was it ever compiled with W=1? I double checked and easily see a
warning...

Best regards,
Krzysztof


