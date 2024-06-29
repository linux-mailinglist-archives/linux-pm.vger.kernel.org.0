Return-Path: <linux-pm+bounces-10238-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 747BC91CD12
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jun 2024 15:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 968BC1C21569
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jun 2024 13:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132537F476;
	Sat, 29 Jun 2024 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="khB+ZG3o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293B5524C9
	for <linux-pm@vger.kernel.org>; Sat, 29 Jun 2024 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719667558; cv=none; b=WXikk2aVNMvFwYJvLx3ejPIR8VLdhCghU69nwIhJo3WYyxPcPjelnhtvRaG4wAzgmyxWNP99i7RNuJLMJOzp/mVfaNlV2xwN9iCeetO22pbEiReLdamTO3uEqWqWOqKFWUu1EWuBcx97lQKyuYIWXjucc3XbtMdDncMc7G2nVSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719667558; c=relaxed/simple;
	bh=6EhUsA3UxVX3IQKQ+u+Zt+mCTBTcxt3GZzyVOlXeRrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d4pTdYQ66yb5iBmvs/VrtY0qooXFtZH/zCQaiGMvL5td8YkELqQIBAJGEtOpFj8JwM1M/HdwBWMsN9Td0In6gURXFFPUOz9NKNB7ygcHDj8iyurqXKV+hvNqbgS8AYaOI3BV3nhtjfQV0gSPXIXgsEM2YMSL7dAVTo5oAeSqnvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=khB+ZG3o; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a724b4f1218so203575366b.2
        for <linux-pm@vger.kernel.org>; Sat, 29 Jun 2024 06:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719667554; x=1720272354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3fkbnmyjpmYb5mPmveRTWfsHhRYjv7G8dpWohhpks2o=;
        b=khB+ZG3oz6xg97Dv+97B1Rq9EV9P8O/N9G8NpUhsOT42mjr3bzUNDiZDppf4bBDwN3
         qXlMPHFX7LrUivXG4XhIiWW4udYh9+iEuOF+T/zJ4M09VMrFdhIJvPIkvLGNjld3lzTZ
         xWQkfnurcLohiHo8MzwT0B5m5FSGccpNnDNh0plZ33YLadNo24lK3lHldrTncwgujjjY
         DPtOwJ7Nu5b6VP7VBRDIlHyRV8e1rqonqB5GnfvBqPvG21UF7Zg2U1eVPjxjBNsMYkLd
         9ksfI9C9IDH78FznmmmEDmjutsFtp5nuRoLLMoobMbOxzPn716U4xMhllXWz/RHXJdBx
         kdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719667554; x=1720272354;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fkbnmyjpmYb5mPmveRTWfsHhRYjv7G8dpWohhpks2o=;
        b=v1icqMxUwq61JvMKYTCdFHc2dgPKSYLQhlqn9aLtwAiXIGYO5b7XxbnXUGz1yLLUhn
         C/kVrY2vVjTIwJSfGalBXTDEW+ymhG8OTRzjVyqiPnEzOmClzxV/lwiH/jS7Nm0y7cNo
         MRhlQANOuJ65/jxYCIQgye2XnFl6so2qylweG8Opqkra/6L5OTZNcw9WhvD2QF6BEAa7
         wmAXXuOdPVsSXwTTje3Rx1ThkIKoR4U0QaXGfrD5KafNiKBrwo08D/u+TrGO+uYute4i
         ApokElRzbNDsE0xGwlSlhJ57WALLrw7y72C0Rqu1buHGQUX7hjSyxlGCpvraBIX221pk
         7CyA==
X-Forwarded-Encrypted: i=1; AJvYcCUT2iFByMeIy6f/4GTCcoBZ+zcSPZZxT0wCwMkbWOjERzW0j+XTBdx+euv6Nd8z7DrFDTRkRXX2k90/9vf9ZCa7ILUR14ayWkQ=
X-Gm-Message-State: AOJu0YytqSR3f+iW8Ktd/je/sIygzpYaBqzzx75atQM+k+Dx7R3dDQYX
	xLvXN6fmNCESf6Wd5hbLfopWjKJkPnex98bi19qX6Z1Kc/v0nISBNIL4qdKNnOCDPr8YEUL7pxA
	E
X-Google-Smtp-Source: AGHT+IHxXY3GnqAyDZpcxtE7Yybd2qLLCguisyhttFM3FF7Lao1hk9scg++tV+vI4pVCEzZTgoMfnQ==
X-Received: by 2002:a17:907:9620:b0:a72:88e2:c30f with SMTP id a640c23a62f3a-a751447b26cmr88092866b.48.1719667554305;
        Sat, 29 Jun 2024 06:25:54 -0700 (PDT)
Received: from [192.168.215.29] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab0b7dcfsm164134366b.209.2024.06.29.06.25.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jun 2024 06:25:53 -0700 (PDT)
Message-ID: <e758edc4-49b5-4b3c-abe2-7d5cbce52ee2@linaro.org>
Date: Sat, 29 Jun 2024 15:25:51 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/6] arm64: dts: qcom: ipq9574: Add icc provider
 ability to gcc
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, andersson@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, quic_anusha@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <1a08ef42-b52f-4c97-90d7-e7fdee7725b4@linaro.org>
 <Zmgb+OjdBNw71sC1@hu-varada-blr.qualcomm.com>
 <176137e5-6312-4d46-97b6-c4494bc1c61b@kernel.org>
 <ZmlAdETV0+6Md8HC@hu-varada-blr.qualcomm.com>
 <e24cfd23-6f77-46a0-b020-9cb3daef6930@kernel.org>
 <Zml4RQ5R5s3mVMnI@hu-varada-blr.qualcomm.com>
 <8e32a8be-dbbf-49ca-92a1-2fe3c8bfb571@kernel.org>
 <ZmpsOdsl9AMTSH88@hu-varada-blr.qualcomm.com>
 <ZnKKjomRQtJS2ZgL@hu-varada-blr.qualcomm.com>
 <9938a67b-1f6b-4955-b4c0-a9f78c55f276@linaro.org>
 <Zn54xhM/qfBv58e2@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <Zn54xhM/qfBv58e2@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28.06.2024 10:48 AM, Varadarajan Narayanan wrote:
> On Thu, Jun 27, 2024 at 12:00:35AM +0200, Konrad Dybcio wrote:
>> On 19.06.2024 9:36 AM, Varadarajan Narayanan wrote:
>>
>> [...]
>>
>>
>>> Tested the patches with both gcc and nsscc providers having
>>> 'sync_state' set to icc_sync_state.
>>>
>>> 	# dmesg | grep synced
>>> 	[    3.029820] qcom,gcc-ipq9574 1800000.clock-controller: interconnect provider is in synced state
>>> 	[    3.470106] qcom,nsscc-ipq9574 39b00000.clock-controller: interconnect provider is in synced state
>>>
>>> I can see that icc_sync_state is getting called and clocks
>>> related to paths with zero bandwidth are getting disabled.
>>>
>>> Will post the NSSCC patches to get the full picture.
>>
>> Going back to the original question, does removing interconnects = from
>> things like PCIe now make them not work / crash the device, which would
>> indicate the NoC clocks were indeed gated?
> 
> Yes. With and without 'interconnects =', the following behaviour
> is same
> 	* Boot completes
> 	* PCIe devices were probed succesfully and can be
> 	  seen in /proc/bus/pci/devices.
> 	* icc_sync_state is called. The system has 4 pcie nodes
> 	  in the DT, out of which pcie0 is not enabled.
> 
> The difference is seen in icc_sync_state
> 
>     With 'interconnects ='
> 
> 	* During icc_sync_state, the following 2 clocks
> 	  corresponding to the interconnects of 'pcie0' get
> 	  disabled.
> 
> 	[    2.986356] ---> clk_core_disable_lock: gcc_anoc_pcie0_1lane_m_clk
> 	[    3.012486] ---> clk_core_disable_lock: gcc_snoc_pcie0_1lane_s_clk
> 
> 	* System shutdown also completes without issues
> 
>     Without the 'interconnects =',
> 
> 	* During icc_sync_state, the following clocks
> 	  corresponding to the interconnects of all the 4 PCIe
> 	  nodes get disabled.
> 
> 	[    2.887860] ---> clk_core_disable_lock: gcc_anoc_pcie0_1lane_m_clk
> 	[    2.913988] ---> clk_core_disable_lock: gcc_snoc_pcie0_1lane_s_clk
> 	[    2.939857] ---> clk_core_disable_lock: gcc_anoc_pcie1_1lane_m_clk
> 	[    2.965725] ---> clk_core_disable_lock: gcc_snoc_pcie1_1lane_s_clk
> 	[    2.991594] ---> clk_core_disable_lock: gcc_anoc_pcie2_2lane_m_clk
> 	[    3.017463] ---> clk_core_disable_lock: gcc_snoc_pcie2_2lane_s_clk
> 	[    3.043328] ---> clk_core_disable_lock: gcc_anoc_pcie3_2lane_m_clk
> 	[    3.069201] ---> clk_core_disable_lock: gcc_snoc_pcie3_2lane_s_clk
> 
> 	* System shutdown hangs (possibly due to un-clocked
> 	  access of PCIe register) in pcie_pme_interrupt_enable
> 
> 		[   10.773134]  dump_stack+0x18/0x24
> 		[   10.776779]  pcie_pme_remove+0x2c/0x88
> 		[   10.780078]  pcie_port_remove_service+0x50/0x74
> 		[   10.783725]  device_remove+0x12c/0x148
> 		[   10.788151]  __device_release_driver+0x65c/0x8cc
> 		[   10.791972]  device_release_driver+0x2c/0x44
> 		[   10.796746]  bus_remove_device+0xcc/0x10c
> 		[   10.800999]  device_del+0x14c/0x400
> 		[   10.804904]  device_unregister+0x18/0x34
> 		[   10.808203]  remove_iter+0x2c/0x3c
> 		[   10.812369]  device_for_each_child+0x60/0xb4
> 		[   10.815583]  pcie_portdrv_shutdown+0x34/0x90
> 		[   10.820009]  pci_device_shutdown+0x34/0x74
> 		[   10.824263]  device_shutdown+0x150/0x258
> 		[   10.828169]  kernel_restart_prepare+0x98/0xbc
> 		[   10.832249]  kernel_restart+0x44/0x110
> 		[   10.836502]  __do_sys_reboot+0x18c/0x304
> 
> I believe, this is confirms NOC clocks getting disabled by
> icc_sync_state.

Yes, this looks good now, thanks.

Konrad

