Return-Path: <linux-pm+bounces-8714-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEF88FE869
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 16:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 240901C25878
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 14:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F10C196C97;
	Thu,  6 Jun 2024 14:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="luh/ZlY6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1DF196C72
	for <linux-pm@vger.kernel.org>; Thu,  6 Jun 2024 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682769; cv=none; b=lZAErstDf5CqcKFwI8uLQ2L7QgWsBsNYZ0k2h+a32Y+M6wjvqBqt9Eroog9axrjxJXQ1mud97iJxQrFfGP8xg3TlEcF5p/+0ygliCD6ttc/9bjj/b1cOnqyQIBc3kZw4xfAvfcUE00cii5gktMaBvZfuYO/4EjRUvl9RILHWOXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682769; c=relaxed/simple;
	bh=0XIaO8VC8/Cr25KGmS0Cf8z2nqAra51paSuynMDMkSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GTl/76HqTN1+7uZFhP0ZbHKMgfuwXHdnnDnbqJqyImK6aOUnsjw/ZZVAKQ8zSkSoTom4jrXltaSEYtCUiV0UtveaUpBlTo57OrtUM0dDsQmlQ9sVQC72gsxK0sJqixjCSwOQNv5lylZMPcbeIEMVI110jZdk+bUXeAPKCChlkhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=luh/ZlY6; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63a96so1207811a12.0
        for <linux-pm@vger.kernel.org>; Thu, 06 Jun 2024 07:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717682765; x=1718287565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vQKb19ONiS07YwbhzyqTZ4NVaKzqW4YHDAO1Nu9VvEE=;
        b=luh/ZlY6dJvTVX+ZmD4u7Vjkfi8G833l5e9dYSiFv5pIXEj5aN745++PCX2h39PRAK
         o/Cfr0sZDk36ykEHjIYuB+HeQtzUzJlN1RNay63ryX6iADoTe4R7AYKoU2yy4i2Z/eej
         nVGfcSoVblDQt1OnN19JON5s8sJw16/Z8hPXdLCLZYLfJZmwmzBsAqKPCTtj0FQOgsbo
         DEqQzL8P7DhxaiCipM4spw59v6vs1DS9HzNZ/p3z0PRSBttvaI1gtMXT8uYLo2BzdwXb
         kpvOfxGCpe4eZAFEDGrRIDPJHnaV7ZppNSCjYym3/EOAJvHfbYXW/5wbzWvJGkyKgUek
         hLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717682765; x=1718287565;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQKb19ONiS07YwbhzyqTZ4NVaKzqW4YHDAO1Nu9VvEE=;
        b=jCmys5+ajgnGHFjubodOAZ6DdOQQPzcMXTwZO2vsqb4FLBtrZCg6gVkkcdjBug3mFP
         Ac+38mfJTEMmgDGxF8EzPx3DNHIA71PVP6oxRvJ/GIjyc/AhiZD3H9683CImYV6gahJ9
         hDPvIzs7YD7T5thFWoX3vXde9AJZFprdJXuUvtHm+koEQS42CBolNOlizWg6i+4QcfnI
         4or6TsUb4wUWjF6MAg2OMGwbNdKDCTTwvLBBMM0j2wEQTSjLnpft8vsRiBXcJK2Qb2BK
         Pf2WUhVj/aMGQTAUU3tJ8QIYj8YtRdJz7+WsCdK4Gqdtqd5mbaoSBUlu/kvOOopVWTSt
         b2hg==
X-Forwarded-Encrypted: i=1; AJvYcCXr0W7e1p8PaXn8o0DZm3mMkYWVSpRw9GOQSLWIvPy69232dDACZpetqKX12fq4tgFkksK4B6L7icAUpiB3Tz5fBaVwqSvDRrY=
X-Gm-Message-State: AOJu0YzM+dA8hUx6q2zT4kcH9TIO+0U0hP2/s94MbZI+SPF68od70DzG
	C1Up8jNB5jV/0Hz6RBCBIAScxhSBHoss5PUdbhRJXPiKQPuRLuKblbVCBdnS52o=
X-Google-Smtp-Source: AGHT+IHMBu9F3fZBohRfOXGBJmwL+dUO/U6UFuk7SvnfrU+SXs+rB4HE/CdJVvunmmD5Lrwi01e+sw==
X-Received: by 2002:a50:ab0d:0:b0:57a:79c2:e9d5 with SMTP id 4fb4d7f45d1cf-57a8b6ac6c0mr3439122a12.18.1717682764777;
        Thu, 06 Jun 2024 07:06:04 -0700 (PDT)
Received: from [192.168.128.139] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadcbf568sm1166892a12.0.2024.06.06.07.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 07:06:04 -0700 (PDT)
Message-ID: <1a08ef42-b52f-4c97-90d7-e7fdee7725b4@linaro.org>
Date: Thu, 6 Jun 2024 16:06:01 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/6] arm64: dts: qcom: ipq9574: Add icc provider
 ability to gcc
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, andersson@kernel.org,
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <CAA8EJpqENsojPQmCbma_nQLEZq8nK1fz1K0JdtvLd=kPrH_DBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8.05.2024 10:10 AM, Dmitry Baryshkov wrote:
> On Wed, 8 May 2024 at 09:53, Varadarajan Narayanan
> <quic_varada@quicinc.com> wrote:
>>
>> On Fri, May 03, 2024 at 04:51:04PM +0300, Georgi Djakov wrote:
>>> Hi Varada,
>>>
>>> Thank you for your work on this!
>>>
>>> On 2.05.24 12:30, Varadarajan Narayanan wrote:
>>>> On Tue, Apr 30, 2024 at 12:05:29PM +0200, Konrad Dybcio wrote:
>>>>> On 25.04.2024 12:26 PM, Varadarajan Narayanan wrote:
>>>>>> On Tue, Apr 23, 2024 at 02:58:41PM +0200, Konrad Dybcio wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 4/18/24 11:23, Varadarajan Narayanan wrote:
>>>>>>>> IPQ SoCs dont involve RPM in managing NoC related clocks and
>>>>>>>> there is no NoC scaling. Linux itself handles these clocks.
>>>>>>>> However, these should not be exposed as just clocks and align
>>>>>>>> with other Qualcomm SoCs that handle these clocks from a
>>>>>>>> interconnect provider.
>>>>>>>>
>>>>>>>> Hence include icc provider capability to the gcc node so that
>>>>>>>> peripherals can use the interconnect facility to enable these
>>>>>>>> clocks.
>>>>>>>>
>>>>>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>>>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>>>>>>>> ---
>>>>>>>
>>>>>>> If this is all you do to enable interconnect (which is not the case,
>>>>>>> as this patch only satisfies the bindings checker, the meaningful
>>>>>>> change happens in the previous patch) and nothing explodes, this is
>>>>>>> an apparent sign of your driver doing nothing.
>>>>>>
>>>>>> It appears to do nothing because, we are just enabling the clock
>>>>>> provider to also act as interconnect provider. Only when the
>>>>>> consumers are enabled with interconnect usage, this will create
>>>>>> paths and turn on the relevant NOC clocks.
>>>>>
>>>>> No, with sync_state it actually does "something" (sets the interconnect
>>>>> path bandwidths to zero). And *this* patch does nothing functionally,
>>>>> it only makes the dt checker happy.
>>>>
>>>> I understand.
>>>>
>>>>>> This interconnect will be used by the PCIe and NSS blocks. When
>>>>>> those patches were posted earlier, they were put on hold until
>>>>>> interconnect driver is available.
>>>>>>
>>>>>> Once this patch gets in, PCIe for example will make use of icc.
>>>>>> Please refer to https://lore.kernel.org/linux-arm-msm/20230519090219.15925-5-quic_devipriy@quicinc.com/.
>>>>>>
>>>>>> The 'pcieX' nodes will include the following entries.
>>>>>>
>>>>>>         interconnects = <&gcc MASTER_ANOC_PCIE0 &gcc SLAVE_ANOC_PCIE0>,
>>>>>>                         <&gcc MASTER_SNOC_PCIE0 &gcc SLAVE_SNOC_PCIE0>;
>>>>>>         interconnect-names = "pcie-mem", "cpu-pcie";
>>>>>
>>>>> Okay. What about USB that's already enabled? And BIMC/MEMNOC?
>>>>
>>>> For USB, the GCC_ANOC_USB_AXI_CLK is enabled as part of the iface
>>>> clock. Hence, interconnect is not specified there.
>>>>
>>>> MEMNOC to System NOC interfaces seem to be enabled automatically.
>>>> Software doesn't have to turn on or program specific clocks.
>>>>
>>>>>>> The expected reaction to "enabling interconnect" without defining the
>>>>>>> required paths for your hardware would be a crash-on-sync_state, as all
>>>>>>> unused (from Linux's POV) resources ought to be shut down.
>>>>>>>
>>>>>>> Because you lack sync_state, the interconnects silently retain the state
>>>>>>> that they were left in (which is not deterministic), and that's precisely
>>>>>>> what we want to avoid.
>>>>>>
>>>>>> I tried to set 'sync_state' to icc_sync_state to be invoked and
>>>>>> didn't see any crash.
>>>>>
>>>>> Have you confirmed that the registers are actually written to, and with
>>>>> correct values?
>>>>
>>>> I tried the following combinations:-
>>>>
>>>> 1. Top of tree linux-next + This patch set
>>>>
>>>>     * icc_sync_state called
>>>>     * No crash or hang observed
>>>>     * From /sys/kernel/debug/clk/clk_summary can see the
>>>>       relevant clocks are set to the expected rates (compared
>>>>       with downstream kernel)
>>>>
>>>> 2. Top of tree linux-next + This patch set + PCIe enablement
>>>>
>>>>     * icc_sync_state NOT called
>>>
>>> If sync_state() is not being called, that usually means that there
>>> are interconnect consumers that haven't probed successfully (PCIe?)
>>> or their dependencies. That can be checked in /sys/class/devlink/.../status
>>> But i am not sure how this works for PCI devices however.
>>>
>>> You can also manually force a call to sync_state by writing "1" to
>>> the interconnect provider's /sys/devices/.../state_synced
>>>
>>> Anyway, the question is if PCIe and NSS work without this driver?
>>
>> No.
>>
>>> If they work, is this because the clocks are turned on by default
>>> or by the boot loader?
>>
>> Initially, the PCIe/NSS driver enabled these clocks directly
>> by having them in their DT nodes itself. Based on community
>> feedback this was removed and after that PCIe/NSS did not work.
>>
>>> Then if an interconnect path (clock) gets disabled either when we
>>> reach a sync_state (with no bandwidth requests) or we explicitly
>>> call icc_set_bw() with 0 bandwidth values, i would expect that
>>> these PCIe and NSS devices would not function anymore (it might
>>> save some power etc) and if this is unexpected we should see a
>>> a crash or hang...
>>>
>>> Can you confirm this?
>>
>> With ICC enabled, icc_set_bw (with non-zero values) is called by
>> PCIe and NSS drivers. Haven't checked with icc_set_bw with zero
>> values.
>>
>> PCIe:   qcom_pcie_probe -> qcom_pcie_icc_init -> icc_set_bw
>> NSS:    ppe_icc_init -> icc_set_bw
>>
>> I believe sync_state is not getting called since there is a
>> non-zero set bandwidth request. Which seems to be aligned with
>> your explanation.
> 
> This doesn't look correct. sync_state is being called once all
> consumers are probed. It doesn't matter whether those consumers have
> non-zero bandwidth requests or no.

/sys/kernel/debug/devices_deferred may have some useful info, too

Konrad

