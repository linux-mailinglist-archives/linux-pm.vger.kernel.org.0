Return-Path: <linux-pm+bounces-8942-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEC4903A14
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 13:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B3E1C22BAC
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 11:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F31617B41F;
	Tue, 11 Jun 2024 11:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fC+KaHaQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EC417A930;
	Tue, 11 Jun 2024 11:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718105395; cv=none; b=t7cAjMHvAim57lLZvNJgKjElQI+Ybp03suclFaxHwGoSX7tZ+Q1FyNfT2+6lPJMivphBIKkK146mCZcrXbJHhjQT9CCnH3dviZ7aean5WX69sJF4zjvhLpSvd1q1/rywbBL/agzsW2fc2f8GQ0rEHUq5GNNS75+2ZLDwGFerIoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718105395; c=relaxed/simple;
	bh=v1wPmjm6dFdn2OBU3/MOe0zu3EOVJMs/Uhyx/PeNHUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RkiM0m0f+CiorydOL8f0vUnyPszOE6XUoGv2yox1WJjPa+/kiGT5WPaBAKqJZiF3JqS5QKgE0R9IZ+q2ngrkB0O9mvKxRVef0R7/ypUixrvLTPoYcVoMsTPDfhjeyfkDyV8AKpq1VDl0vDhbSu7xIuJigBFpnvp9EiUfd1HvUiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fC+KaHaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA104C2BD10;
	Tue, 11 Jun 2024 11:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718105394;
	bh=v1wPmjm6dFdn2OBU3/MOe0zu3EOVJMs/Uhyx/PeNHUo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fC+KaHaQzvpP3LpHfg/9JTHwp4d3p7VqEZQR1G3nQjQVo+OPdv+e2mMncshGJTNZE
	 utBtuZH8BtOdSpLC1hDWHS221jrBU2YFdIfhoWKZ3BNEKovw08s+2h7tU2jJtikE1I
	 EvQTS/VWrRBIaOsJLsFAV940ZwmIl9VQtml/valvz/q2E4yac4N+Rk0DtgbhTeXJ+s
	 sT028DprkflkR/pIVy3f/6S546l0MupgNqBvgFAsiFhdeUFPnR0mDSnACtMRavRadq
	 2ASWJetbt87CET8H7tuNR6Fvo7NM+Vn1CcVLtO1D5ehoRezuA7BHvKyf24pQQaFwrZ
	 YIW9CPET6mYfg==
Message-ID: <176137e5-6312-4d46-97b6-c4494bc1c61b@kernel.org>
Date: Tue, 11 Jun 2024 14:29:48 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/6] arm64: dts: qcom: ipq9574: Add icc provider
 ability to gcc
To: Varadarajan Narayanan <quic_varada@quicinc.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, andersson@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, quic_anusha@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240418092305.2337429-1-quic_varada@quicinc.com>
 <20240418092305.2337429-7-quic_varada@quicinc.com>
 <a7194edd-a2c8-46fc-bea1-f26b0960e535@linaro.org>
 <Ziov6bWBXYXJ4Zp8@hu-varada-blr.qualcomm.com>
 <27f4f3dd-9375-40cf-8c8f-1c4edf66e31b@linaro.org>
 <ZjNdTmmXucjtRxJt@hu-varada-blr.qualcomm.com>
 <c015b3a5-2213-4ebd-b960-d97ed1fe7062@kernel.org>
 <ZjshR0ekcn0gxwOa@hu-varada-blr.qualcomm.com>
 <CAA8EJpqENsojPQmCbma_nQLEZq8nK1fz1K0JdtvLd=kPrH_DBw@mail.gmail.com>
 <1a08ef42-b52f-4c97-90d7-e7fdee7725b4@linaro.org>
 <Zmgb+OjdBNw71sC1@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <Zmgb+OjdBNw71sC1@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.06.24 12:42, Varadarajan Narayanan wrote:
> On Thu, Jun 06, 2024 at 04:06:01PM +0200, Konrad Dybcio wrote:
>> On 8.05.2024 10:10 AM, Dmitry Baryshkov wrote:
>>> On Wed, 8 May 2024 at 09:53, Varadarajan Narayanan
>>> <quic_varada@quicinc.com> wrote:
>>>>
>>>> On Fri, May 03, 2024 at 04:51:04PM +0300, Georgi Djakov wrote:
>>>>> Hi Varada,
>>>>>
>>>>> Thank you for your work on this!
>>>>>
>>>>> On 2.05.24 12:30, Varadarajan Narayanan wrote:
>>>>>> On Tue, Apr 30, 2024 at 12:05:29PM +0200, Konrad Dybcio wrote:
>>>>>>> On 25.04.2024 12:26 PM, Varadarajan Narayanan wrote:
>>>>>>>> On Tue, Apr 23, 2024 at 02:58:41PM +0200, Konrad Dybcio wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 4/18/24 11:23, Varadarajan Narayanan wrote:
>>>>>>>>>> IPQ SoCs dont involve RPM in managing NoC related clocks and
>>>>>>>>>> there is no NoC scaling. Linux itself handles these clocks.
>>>>>>>>>> However, these should not be exposed as just clocks and align
>>>>>>>>>> with other Qualcomm SoCs that handle these clocks from a
>>>>>>>>>> interconnect provider.
>>>>>>>>>>
>>>>>>>>>> Hence include icc provider capability to the gcc node so that
>>>>>>>>>> peripherals can use the interconnect facility to enable these
>>>>>>>>>> clocks.
>>>>>>>>>>
>>>>>>>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>>>>>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>>>>>>>>>> ---
>>>>>>>>>
>>>>>>>>> If this is all you do to enable interconnect (which is not the case,
>>>>>>>>> as this patch only satisfies the bindings checker, the meaningful
>>>>>>>>> change happens in the previous patch) and nothing explodes, this is
>>>>>>>>> an apparent sign of your driver doing nothing.
>>>>>>>>
>>>>>>>> It appears to do nothing because, we are just enabling the clock
>>>>>>>> provider to also act as interconnect provider. Only when the
>>>>>>>> consumers are enabled with interconnect usage, this will create
>>>>>>>> paths and turn on the relevant NOC clocks.
>>>>>>>
>>>>>>> No, with sync_state it actually does "something" (sets the interconnect
>>>>>>> path bandwidths to zero). And *this* patch does nothing functionally,
>>>>>>> it only makes the dt checker happy.
>>>>>>
>>>>>> I understand.
>>>>>>
>>>>>>>> This interconnect will be used by the PCIe and NSS blocks. When
>>>>>>>> those patches were posted earlier, they were put on hold until
>>>>>>>> interconnect driver is available.
>>>>>>>>
>>>>>>>> Once this patch gets in, PCIe for example will make use of icc.
>>>>>>>> Please refer to https://lore.kernel.org/linux-arm-msm/20230519090219.15925-5-quic_devipriy@quicinc.com/.
>>>>>>>>
>>>>>>>> The 'pcieX' nodes will include the following entries.
>>>>>>>>
>>>>>>>>          interconnects = <&gcc MASTER_ANOC_PCIE0 &gcc SLAVE_ANOC_PCIE0>,
>>>>>>>>                          <&gcc MASTER_SNOC_PCIE0 &gcc SLAVE_SNOC_PCIE0>;
>>>>>>>>          interconnect-names = "pcie-mem", "cpu-pcie";
>>>>>>>
>>>>>>> Okay. What about USB that's already enabled? And BIMC/MEMNOC?
>>>>>>
>>>>>> For USB, the GCC_ANOC_USB_AXI_CLK is enabled as part of the iface
>>>>>> clock. Hence, interconnect is not specified there.
>>>>>>
>>>>>> MEMNOC to System NOC interfaces seem to be enabled automatically.
>>>>>> Software doesn't have to turn on or program specific clocks.
>>>>>>
>>>>>>>>> The expected reaction to "enabling interconnect" without defining the
>>>>>>>>> required paths for your hardware would be a crash-on-sync_state, as all
>>>>>>>>> unused (from Linux's POV) resources ought to be shut down.
>>>>>>>>>
>>>>>>>>> Because you lack sync_state, the interconnects silently retain the state
>>>>>>>>> that they were left in (which is not deterministic), and that's precisely
>>>>>>>>> what we want to avoid.
>>>>>>>>
>>>>>>>> I tried to set 'sync_state' to icc_sync_state to be invoked and
>>>>>>>> didn't see any crash.
>>>>>>>
>>>>>>> Have you confirmed that the registers are actually written to, and with
>>>>>>> correct values?
>>>>>>
>>>>>> I tried the following combinations:-
>>>>>>
>>>>>> 1. Top of tree linux-next + This patch set
>>>>>>
>>>>>>      * icc_sync_state called
>>>>>>      * No crash or hang observed
>>>>>>      * From /sys/kernel/debug/clk/clk_summary can see the
>>>>>>        relevant clocks are set to the expected rates (compared
>>>>>>        with downstream kernel)
>>>>>>
>>>>>> 2. Top of tree linux-next + This patch set + PCIe enablement
>>>>>>
>>>>>>      * icc_sync_state NOT called
>>>>>
>>>>> If sync_state() is not being called, that usually means that there
>>>>> are interconnect consumers that haven't probed successfully (PCIe?)
>>>>> or their dependencies. That can be checked in /sys/class/devlink/.../status
>>>>> But i am not sure how this works for PCI devices however.
>>>>>
>>>>> You can also manually force a call to sync_state by writing "1" to
>>>>> the interconnect provider's /sys/devices/.../state_synced
>>>>>
>>>>> Anyway, the question is if PCIe and NSS work without this driver?
>>>>
>>>> No.
>>>>
>>>>> If they work, is this because the clocks are turned on by default
>>>>> or by the boot loader?
>>>>
>>>> Initially, the PCIe/NSS driver enabled these clocks directly
>>>> by having them in their DT nodes itself. Based on community
>>>> feedback this was removed and after that PCIe/NSS did not work.
>>>>
>>>>> Then if an interconnect path (clock) gets disabled either when we
>>>>> reach a sync_state (with no bandwidth requests) or we explicitly
>>>>> call icc_set_bw() with 0 bandwidth values, i would expect that
>>>>> these PCIe and NSS devices would not function anymore (it might
>>>>> save some power etc) and if this is unexpected we should see a
>>>>> a crash or hang...
>>>>>
>>>>> Can you confirm this?
>>>>
>>>> With ICC enabled, icc_set_bw (with non-zero values) is called by
>>>> PCIe and NSS drivers. Haven't checked with icc_set_bw with zero
>>>> values.
>>>>
>>>> PCIe:   qcom_pcie_probe -> qcom_pcie_icc_init -> icc_set_bw
>>>> NSS:    ppe_icc_init -> icc_set_bw
>>>>
>>>> I believe sync_state is not getting called since there is a
>>>> non-zero set bandwidth request. Which seems to be aligned with
>>>> your explanation.
>>>
>>> This doesn't look correct. sync_state is being called once all
>>> consumers are probed. It doesn't matter whether those consumers have
>>> non-zero bandwidth requests or no.
>>
>> /sys/kernel/debug/devices_deferred may have some useful info, too
> 
> /sys/kernel/debug/devices_deferred seems to be empty
> 
> 	# mount | grep -w debugfs
> 	none on /sys/kernel/debug type debugfs (rw,relatime)
> 
> 	# cat /sys/kernel/debug/devices_deferred  | wc -l
> 	0
> 
> Added the following print to icc_sync_state,
> 
> 	@@ -1096,6 +1096,7 @@ void icc_sync_state(struct device *dev)
> 		struct icc_node *n;
> 		static int count;
> 
> 	+	printk("--> %s: %d %d\n", __func__, providers_count, count);
> 		count++;
> 
> 		if (count < providers_count)
> 			return;
> 
> icc_sync_state seems to be called once,
> 
> 	# dmesg | grep icc_sync_state
> 	[   12.260544] --> icc_sync_state: 2 0
> 
> Since 'providers_count' is greated than 'count' icc_sync_state
> seems to return before doing anything.

Is there also another interconnect provider on this platform, other
than the gcc? Check for DT nodes that have the #interconnect-cells
property. Are all providers probing successfully?

All providers must probe, as there might be paths that cross multiple
providers and we can't get into sync-state with a topology that is
only partially initialized.

Thanks,
Georgi

