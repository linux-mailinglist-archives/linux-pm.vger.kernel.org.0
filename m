Return-Path: <linux-pm+bounces-10198-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B9591C06A
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 16:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA8411C21CD8
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 14:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0771C0047;
	Fri, 28 Jun 2024 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="OkW3r4Bu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A56C1BF312;
	Fri, 28 Jun 2024 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719583589; cv=none; b=mTf9V4N05zwUK6rrpoE+RHsX+hBdD4MFvFM2RMnF5pBlmL/ZIAokMWTJEni4nrLr9DKKa/PprZ4rmY3w5QFwnauBqv/EJIST9hz7AbLg2yxSr12NP5nYJr2NL/6MsxPDbfX1VKiSeiFZrySii/RMNaOMGbOvSbR1HxnJkcNSgQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719583589; c=relaxed/simple;
	bh=2nqaANr9KI1GOoZd9vxK91mXGFhY0QeIyy1to+366+k=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=uRGYWB+1/Yj9d/Jj6o+XbBrVKx0rG+CRL1whVnNvsRkTifAFavs2gxrX9LEWAIkTbA0rpmSRcb3q1mu9m0uR/xEwimX2ej/aWzt2tN0cu+jFApJ4eMskAIKP2GH641S/b3MB5FilTc8uRkx3hXY6aBFlqwY6DQeu4POLD0S29yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=OkW3r4Bu; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from localhost (docker-mailserver-web-1.docker-mailserver_default [172.22.0.5])
	by mail.mainlining.org (Postfix) with ESMTPSA id 8BB0EE44E7;
	Fri, 28 Jun 2024 14:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1719583585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bkTzu+1zggtZIYhz4XF8rolkuWFvay19lMZEfprUXmc=;
	b=OkW3r4Bun912nw6xuThAIOaEVhomorlmrGlJesxH59FtcFX6yB7nTeTixun7k2whTdresO
	Ndo+NKdMq42HRo4ln7/XszJEUsS2owR3iRAaRMWbVXXjGJrQHfNnRLlI2r+VX7tTs6mIGM
	C3Jjoqh1MnI1C1YMueYfmhL2haIfEsT3YeZmBZZ6JRhH4iLywrg5oVpIW1eRKy4yGBa+cJ
	yR9tI8yhkCGpFdZCc2MxjqpdwjTdTcSlT85NLtCuUFESCsnKM362eg/5xFwtIvpRON5MNr
	uZbJXMSs3XXOukSO4GpIc7nfF8h9BlUPwDnTzCs5/Mti2x/psxlcOwnayuwRDQ==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 28 Jun 2024 16:06:25 +0200
From: barnabas.czeman@mainlining.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, Vladimir Lypak <vladimir.lypak@gmail.com>
Subject: Re: [PATCH v2 2/2] interconnect: qcom: Add MSM8953 driver
In-Reply-To: <b6b8df30-cd81-489b-801a-afd8fceaf41d@kernel.org>
References: <20240627-msm8953-interconnect-v2-0-b4940a8eab69@mainlining.org>
 <20240627-msm8953-interconnect-v2-2-b4940a8eab69@mainlining.org>
 <88588f06-66e1-47a9-b5ab-7849b1c53fb0@kernel.org>
 <b6b8df30-cd81-489b-801a-afd8fceaf41d@kernel.org>
Message-ID: <ee1060ab3472c2106863c27ffcc4cbd8@mainlining.org>
X-Sender: barnabas.czeman@mainlining.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 2024-06-28 11:41, Krzysztof Kozlowski wrote:
> On 28/06/2024 11:32, Georgi Djakov wrote:
>> On 27.06.24 18:08, Barnabás Czémán wrote:
>>> From: Vladimir Lypak <vladimir.lypak@gmail.com>
>>> 
>>> Add driver for interconnect busses found in MSM8953 based platforms.
>>> The topology consists of four NoCs that are partially controlled by a
>>> RPM processor.
>>> 
>>> Note that one of NoCs (System NoC) has a counterpart (System NoC MM)
>>> that is modelled as child device to avoid resource conflicts, since 
>>> it
>>> uses same MMIO space for configuration.
>>> 
>>> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
>>> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
>>> ---
>>>   drivers/interconnect/qcom/Kconfig   |    9 +
>>>   drivers/interconnect/qcom/Makefile  |    2 +
>>>   drivers/interconnect/qcom/msm8953.c | 1325 
>>> +++++++++++++++++++++++++++++++++++
>>>   3 files changed, 1336 insertions(+)
>>> 
>> [..]
>>> +
>>> +static struct qcom_icc_node * const msm8953_pcnoc_nodes[] = {
>>> +	[MAS_SPDM] = &mas_spdm,
>>> +	[MAS_BLSP_1] = &mas_blsp_1,
>>> +	[MAS_BLSP_2] = &mas_blsp_2,
>>> +	[MAS_USB3] = &mas_usb3,
>>> +	[MAS_CRYPTO] = &mas_crypto,
>>> +	[MAS_SDCC_1] = &mas_sdcc_1,
>>> +	[MAS_SDCC_2] = &mas_sdcc_2,
>>> +	[MAS_SNOC_PCNOC] = &mas_snoc_pcnoc,
>>> +	[PCNOC_M_0] = &pcnoc_m_0,
>>> +	[PCNOC_M_1] = &pcnoc_m_1,
>>> +	[PCNOC_INT_1] = &pcnoc_int_1,
>>> +	[PCNOC_INT_2] = &pcnoc_int_2,
>>> +	[PCNOC_S_0] = &pcnoc_s_0,
>>> +	[PCNOC_S_1] = &pcnoc_s_1,
>>> +	[PCNOC_S_2] = &pcnoc_s_2,
>>> +	[PCNOC_S_3] = &pcnoc_s_3,
>>> +	[PCNOC_S_4] = &pcnoc_s_4,
>>> +	[PCNOC_S_6] = &pcnoc_s_6,
>>> +	[PCNOC_S_7] = &pcnoc_s_7,
>>> +	[PCNOC_S_8] = &pcnoc_s_8,
>>> +	[PCNOC_S_9] = &pcnoc_s_9,
>>> +	[SLV_SPDM] = &slv_spdm,
>>> +	[SLV_PDM] = &slv_pdm,
>>> +	[SLV_TCSR] = &slv_tcsr,
>>> +	[SLV_SNOC_CFG] = &slv_snoc_cfg,
>>> +	[SLV_TLMM] = &slv_tlmm,
>>> +	[SLV_MESSAGE_RAM] = &slv_message_ram,
>>> +	[SLV_BLSP_1] = &slv_blsp_1,
>>> +	[SLV_BLSP_2] = &slv_blsp_2,
>>> +	[SLV_PRNG] = &slv_prng,
>>> +	[SLV_CAMERA_SS_CFG] = &slv_camera_ss_cfg,
>>> +	[SLV_DISP_SS_CFG] = &slv_disp_ss_cfg,
>>> +	[SLV_VENUS_CFG] = &slv_venus_cfg,
>>> +	[SLV_GPU_CFG] = &slv_gpu_cfg,
>>> +	[SLV_SDCC_1] = &slv_sdcc_1,
>>> +	[SLV_SDCC_2] = &slv_sdcc_2,
>>> +	[SLV_CRYPTO_0_CFG] = &slv_crypto_0_cfg,
>>> +	[SLV_PMIC_ARB] = &slv_pmic_arb,
>>> +	[SLV_USB3] = &slv_usb3,
>>> +	[SLV_IPA_CFG] = &slv_ipa_cfg,
>>> +	[SLV_TCU] = &slv_tcu,
>>> +	[SLV_PCNOC_SNOC] = &slv_pcnoc_snoc,
>>> +};
>>> +
>>> +static const char * const msm8953_pcnoc_bus_clocks[] = {
>>> +	"bus", "bus_a"
>>> +};
>> 
>> This seems to be unused?
> 
> Heh, was it ever compiled with W=1? I double checked and easily see a
> warning...
Sorry it was my mistake, i have fixed it. I will more careful next time.
> 
> Best regards,
> Krzysztof

