Return-Path: <linux-pm+bounces-4593-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C43A986E021
	for <lists+linux-pm@lfdr.de>; Fri,  1 Mar 2024 12:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AE19B22DD4
	for <lists+linux-pm@lfdr.de>; Fri,  1 Mar 2024 11:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA9A6CBE2;
	Fri,  1 Mar 2024 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LpNxoC73"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB60820300;
	Fri,  1 Mar 2024 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292324; cv=none; b=sfC8vBjQdgKgCCGiglQH3/ezFHG4Qf4P4TOFI7zuzT/6/jjW8eByj8xnzZHSJEuQCNmzv0oBtcIDx5AnXp87qxEDwwDjWE53BYbMl8Qm5P8YWLvAabU93lLS9xMIUBMkS73q+/zRQuJpwrTk2tkDOmLvnD2KMTm+4TSfdQFnvIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292324; c=relaxed/simple;
	bh=W/1WfOOnotgfzDhh6sPdm0zlIC75gd/R/TxxcQvU83M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hRXhoE+GKvzbsIY679mrX8+16T7bkrHxJ37iGIvWpSiGl/5jmSIC0SF0xl8x15SZYY89gcZrDbPITSqb2DH92k6baRmcRXDWLDboGVfbdPKGr4JGH/KfppfTWija87Vn/u8p+073Vyq/pUueVOaUAF3KmU5BOq6dQMXvmP80Odk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LpNxoC73; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4216COVw013756;
	Fri, 1 Mar 2024 11:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ZEXUTybxiN9ZLwTEbHlqBVG7ggy9vypk6yhyt0gudJg=; b=Lp
	NxoC73Tb+CEkTrckMN9Z4evJMkEYzwBLc9iiPD5zV928meJIjI+jTN/aXoNPd5F9
	kMFfwpuwUB/lDH0+a/Av4ppqByFl57VIjVw3OCCj5P2a5c7Enfvq7Z5R0KYQBM0p
	Xm41RQfH49yMzYqszBZ4jGAta93cO4SKQzK1upTBn29ooHTWptBmngvGm7O8x+2P
	DsuulaInqT6SScyqfobR+CG7A4INe1EKUGo3z1bPTrQEYYRSQicNSbenObTFZauR
	zzOvmfMMgciO3OBpbVflylB/HbQEW6CAL8dyWwfqHwmG2bBZ1sxiuMyP91qF+2fS
	jtR3avIQrv5msUxGhDOA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wk9hp0r2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 11:25:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 421BPAgL005394
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Mar 2024 11:25:10 GMT
Received: from [10.217.216.47] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 1 Mar
 2024 03:25:03 -0800
Message-ID: <19bcfe92-8c5a-4736-828a-6680ad81463c@quicinc.com>
Date: Fri, 1 Mar 2024 16:54:06 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] PM: domains: Allow devices attached to genpd to be
 managed by HW
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stanimir Varbanov
	<stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-media@vger.kernel.org>
References: <20240122-gdsc-hwctrl-v4-0-9061e8a7aa07@linaro.org>
 <20240122-gdsc-hwctrl-v4-1-9061e8a7aa07@linaro.org>
 <tax3c6o5qjegy6tv3zbgrd5rencfvypr3zg7twxfrmdngscp74@n44ei3q63g64>
 <CAPDyKFpdtrWbzNksLoY++aOY7Ltyt1HhtLZo8bj8sQ05-4Sq0g@mail.gmail.com>
 <l7icfezpajren25545n4cjtqehhividt5b2dxnxgetdsshc3k3@tdws423qdblk>
 <CAPDyKFp1vg2+-pHJ_idkdhb_zZUMpq7W17DnCCGj0eTwd4jFbQ@mail.gmail.com>
 <87b7967f-d8c4-426e-92ed-5a418c702481@quicinc.com>
 <CAPDyKFqy0osJRTU1mL0Ew_3pnYOe5z20ZWNrew8B6t99UFO0pg@mail.gmail.com>
 <a1c2641f-80c0-4e6e-9c44-ef7209da97a5@quicinc.com>
 <CAPDyKFrg_otBETwM9hTOvxkdCPadDYdaxguS5RVJh4wL9NCovA@mail.gmail.com>
 <eb758a6c-a3e0-4ee9-bff4-4b62e5530d09@quicinc.com>
 <CAPDyKFopSyH05oavacniXTesYkeC7wAGd5EKs0p4mNn2QDPm8Q@mail.gmail.com>
Content-Language: en-US
From: Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <CAPDyKFopSyH05oavacniXTesYkeC7wAGd5EKs0p4mNn2QDPm8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: D58NAmZ-YIOif44G2Hjuedlff4s44RKG
X-Proofpoint-GUID: D58NAmZ-YIOif44G2Hjuedlff4s44RKG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_10,2024-03-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 adultscore=0 impostorscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403010096



On 2/28/2024 8:23 PM, Ulf Hansson wrote:
> On Fri, 16 Feb 2024 at 09:01, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
>>
>>
>>
>> On 2/15/2024 9:57 PM, Ulf Hansson wrote:
>>> On Wed, 14 Feb 2024 at 05:29, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2/13/2024 7:21 PM, Ulf Hansson wrote:
>>>>> On Tue, 13 Feb 2024 at 14:10, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2/2/2024 5:59 PM, Ulf Hansson wrote:
>>>>>>> On Fri, 2 Feb 2024 at 00:51, Bjorn Andersson <andersson@kernel.org> wrote:
>>>>>>>>
>>>>>>>> On Wed, Jan 31, 2024 at 01:12:00PM +0100, Ulf Hansson wrote:
>>>>>>>>> On Wed, 31 Jan 2024 at 02:09, Bjorn Andersson <andersson@kernel.org> wrote:
>>>>>>>>>>
>>>>>>>>>> On Mon, Jan 22, 2024 at 10:47:01AM +0200, Abel Vesa wrote:
>>>>>>>>>>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>>>>>>>>>>
>>>>>>>>>>> Some power-domains may be capable of relying on the HW to control the power
>>>>>>>>>>> for a device that's hooked up to it. Typically, for these kinds of
>>>>>>>>>>> configurations the consumer driver should be able to change the behavior of
>>>>>>>>>>> power domain at runtime, control the power domain in SW mode for certain
>>>>>>>>>>> configurations and handover the control to HW mode for other usecases.
>>>>>>>>>>>
>>>>>>>>>>> To allow a consumer driver to change the behaviour of the PM domain for its
>>>>>>>>>>> device, let's provide a new function, dev_pm_genpd_set_hwmode(). Moreover,
>>>>>>>>>>> let's add a corresponding optional genpd callback, ->set_hwmode_dev(),
>>>>>>>>>>> which the genpd provider should implement if it can support switching
>>>>>>>>>>> between HW controlled mode and SW controlled mode. Similarly, add the
>>>>>>>>>>> dev_pm_genpd_get_hwmode() to allow consumers to read the current mode and
>>>>>>>>>>> its corresponding optional genpd callback, ->get_hwmode_dev(), which the
>>>>>>>>>>> genpd provider can also implement for reading back the mode from the
>>>>>>>>>>> hardware.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>>>>>>>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>>>>>>>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>>>>>>>> ---
>>>>>>>>>>>      drivers/pmdomain/core.c   | 69 +++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>>>>>>      include/linux/pm_domain.h | 17 ++++++++++++
>>>>>>>>>>>      2 files changed, 86 insertions(+)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
>>>>>>>>>>> index a1f6cba3ae6c..41b6411d0ef5 100644
>>>>>>>>>>> --- a/drivers/pmdomain/core.c
>>>>>>>>>>> +++ b/drivers/pmdomain/core.c
>>>>>>>>>>> @@ -548,6 +548,75 @@ void dev_pm_genpd_synced_poweroff(struct device *dev)
>>>>>>>>>>>      }
>>>>>>>>>>>      EXPORT_SYMBOL_GPL(dev_pm_genpd_synced_poweroff);
>>>>>>>>>>>
>>>>>>>>>>> +/**
>>>>>>>>>>> + * dev_pm_genpd_set_hwmode - Set the HW mode for the device and its PM domain.
>>>>>>>>>>
>>>>>>>>>> This isn't proper kernel-doc
>>>>>>>>>
>>>>>>>>> Sorry, I didn't quite get that. What is wrong?
>>>>>>>>>
>>>>>>>>
>>>>>>>> https://docs.kernel.org/doc-guide/kernel-doc.html#function-documentation
>>>>>>>> says that there should be () after the function name, and below there
>>>>>>>> should be a Return:
>>>>>>>
>>>>>>> Thanks for the pointers!
>>>>>>>
>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> + *
>>>>>>>>>>> + * @dev: Device for which the HW-mode should be changed.
>>>>>>>>>>> + * @enable: Value to set or unset the HW-mode.
>>>>>>>>>>> + *
>>>>>>>>>>> + * Some PM domains can rely on HW signals to control the power for a device. To
>>>>>>>>>>> + * allow a consumer driver to switch the behaviour for its device in runtime,
>>>>>>>>>>> + * which may be beneficial from a latency or energy point of view, this function
>>>>>>>>>>> + * may be called.
>>>>>>>>>>> + *
>>>>>>>>>>> + * It is assumed that the users guarantee that the genpd wouldn't be detached
>>>>>>>>>>> + * while this routine is getting called.
>>>>>>>>>>> + *
>>>>>>>>>>> + * Returns 0 on success and negative error values on failures.
>>>>>>>>>>> + */
>>>>>>>>>>> +int dev_pm_genpd_set_hwmode(struct device *dev, bool enable)
>>>>>>>>>>> +{
>>>>>>>>>>> +     struct generic_pm_domain *genpd;
>>>>>>>>>>> +     int ret = 0;
>>>>>>>>>>> +
>>>>>>>>>>> +     genpd = dev_to_genpd_safe(dev);
>>>>>>>>>>> +     if (!genpd)
>>>>>>>>>>> +             return -ENODEV;
>>>>>>>>>>> +
>>>>>>>>>>> +     if (!genpd->set_hwmode_dev)
>>>>>>>>>>> +             return -EOPNOTSUPP;
>>>>>>>>>>> +
>>>>>>>>>>> +     genpd_lock(genpd);
>>>>>>>>>>> +
>>>>>>>>>>> +     if (dev_gpd_data(dev)->hw_mode == enable)
>>>>>>>>>>
>>>>>>>>>> Between this and the gdsc patch, the hw_mode state might not match the
>>>>>>>>>> hardware state at boot.
>>>>>>>>>>
>>>>>>>>>> With hw_mode defaulting to false, your first dev_pm_genpd_set_hwmode(,
>>>>>>>>>> false) will not bring control to SW - which might be fatal.
>>>>>>>>>
>>>>>>>>> Right, good point.
>>>>>>>>>
>>>>>>>>> I think we have two ways to deal with this:
>>>>>>>>> 1) If the provider is supporting ->get_hwmode_dev(), we can let
>>>>>>>>> genpd_add_device() invoke it to synchronize the state.
>>>>>>>>
>>>>>>>> I'd suggest that we skip the optimization for now and just let the
>>>>>>>> update hit the driver on each call.
>>>>>>>
>>>>>>> Okay.
>>>>>>>
>>>>>>>>
>>>>>>>>> 2) If the provider doesn't support ->get_hwmode_dev() we need to call
>>>>>>>>> ->set_hwmode_dev() to allow an initial state to be set.
>>>>>>>>>
>>>>>>>>> The question is then, if we need to allow ->get_hwmode_dev() to be
>>>>>>>>> optional, if the ->set_hwmode_dev() is supported - or if we can
>>>>>>>>> require it. What's your thoughts around this?
>>>>>>>>>
>>>>>>>>
>>>>>>>> Iiuc this resource can be shared between multiple clients, and we're
>>>>>>>> in either case returning the shared state. That would mean a client
>>>>>>>> acting upon the returned value, is subject to races.
>>>>>>>
>>>>>>> Not sure I understand this, but I also don't have in-depth knowledge
>>>>>>> of how the HW works.
>>>>>>>
>>>>>>> Isn't the HW mode set on a per device basis?
>>>>>>>
>>>>>>>>
>>>>>>>> I'm therefore inclined to say that we shouldn't have a getter, other
>>>>>>>> than for debugging purposes, in which case reading the HW-state or
>>>>>>>> failing would be reasonable outcomes.
>>>>>>>
>>>>>>> If you only want this for debug purposes, it seems better to keep it
>>>>>>> closer to the rpmh code, rather than adding generic callbacks to the
>>>>>>> genpd interface.
>>>>>>>
>>>>>>> So to conclude, you think having a ->set_hwmode_dev() callback should
>>>>>>> be sufficient and no caching of the current state?
>>>>>>>
>>>>>>> Abel, what's your thoughts around this?
>>>>>>>
>>>>>>
>>>>>> We believe it is good to have get_hwmode_dev() callback supported from
>>>>>> GenPD, since if multiple devices share a GenPD, and if one device moves
>>>>>> the GenPD to HW mode, the other device won't be aware of it and second
>>>>>> device's dev_gpd_data(dev)->hw_mode will still be false.
>>>>>>
>>>>>> If we have this dev_pm_genpd_get_hwmode() API supported and if we assign
>>>>>> dev_gpd_data(dev)->hw_mode after getting the mode from get_hwmode_dev()
>>>>>> callback, consumer drivers can use this API to sync the actual HW mode
>>>>>> of the GenPD.
>>>>>
>>>>> Hmm, I thought the HW mode was being set on a per device basis, via
>>>>> its PM domain. Did I get that wrong?
>>>>>
>>>>> Are you saying there could be multiple devices sharing the same PM
>>>>> domain and thus also sharing the same HW mode? In that case, it sure
>>>>> sounds like we have synchronization issues to deal with too.
>>>>>
>>>>
>>>> Sorry my bad, currently we don't have usecase where multiple devices
>>>> sharing the same PM domain that have HW control support, so there is no
>>>> synchronization issue.
>>>
>>> Okay, good!
>>>
>>>>
>>>> But it would be good to have .get_hwmode_dev() callback for consumer
>>>> drivers to query the actual GenPD mode from HW, whenever they require it.
>>>
>>> Okay, no objection from my side.
>>>
>>> Then the final question is if we need a variable to keep a cache of
>>> the current HW mode for each device. Perhaps we should start simple
>>> and just always invoke the callbacks from genpd, what do you think?
>>>
>>
>> Yes, agree, we can remove the variable and just always invoke the
>> callbacks from genpd. But we may need the variable to reflect GenPD
>> mode in debugfs genpd_summary, or need to invoke get callback there as
>> well to get the current mode.
> 
> Hmm, after some more thinking I believe it may be best to keep the
> variable after all. For reasons you point out above.
> 
> However, we need a way to synchronize the initial HW mode state for a
> device. Therefore I suggest we invoke the ->get_hwmode_dev() callback
> from genpd_add_device() and store its return value in the variable.
> Later the variable can be used for debugfs and returned from
> dev_pm_genpd_get_hwmode() too.
> 
> That should work, right?
> 

Yes, it should work.

Thanks,
Jagadeesh

> Kind regards
> Uffe

