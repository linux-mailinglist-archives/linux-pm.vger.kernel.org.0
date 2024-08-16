Return-Path: <linux-pm+bounces-12373-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B079550CD
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 20:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BDBB286EDB
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 18:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002841C37B5;
	Fri, 16 Aug 2024 18:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JbYLMWcJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3901C3796;
	Fri, 16 Aug 2024 18:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723832787; cv=none; b=YLf3RdTPWQDLz/vmevD1wS4OXFBkDifEUSTA8i1taNDqHO7RxTzKwQRR2z6SKbGMiQ2TCjgaYZc1IlzOVTi4lWDZOj1EFKt9A30z25vZwV1mIx6+2XiFEGt1U5Ow/ErqLco5u8soU689L9hHvR8Se8I6Y30pYnhgEDt7tagQp1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723832787; c=relaxed/simple;
	bh=DPeLOYOagAKnh5ZukpveM96prGndAPIjdk5ydkkOY0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iOebxSnHh+n6J0O55yokWg/BnvRO58MB5qej+bSiHEcEjALAHPqTHbO0qgn588AZ+0vujZbTwrfPZjSAoJfvPj6Bj6o4NZSNngEPO8lltPosyqd0/ocTQzy13Ys09UOwX+uwvhf+2bC3qW49tHoCFzme1Fg2rSbcLKK/Xc4Be8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JbYLMWcJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47GA5lxd028282;
	Fri, 16 Aug 2024 18:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AAO4g3kLHhH442QaXQyYQqWtZBVUSZQd+XlfgrdodQw=; b=JbYLMWcJ/lblCd5v
	yHxezmaqrpWdHKsGAyLqJE0W4rUrTz6WvwrRvFVQXY7Jk89ddEjbzB0pe/qvBviF
	i0Ku/Bh2FNocCRrRK28nshgO5uruSofzLvKJa6mk3AlOYIu/0qPobP0jtiLffn5F
	Bd59t73QfGUMRb79mVxY3Hth4aMYejly5MJmAnYP04xkH5bY9JQz0CABTTm84ndg
	5hOkAqB/c38+wkHT5GKcYCHrXU11pdom8b1LEFjvs0uvKPXP/r8D1Fx8YCqEJ0Zi
	6UybW7knGzfsEntSbeY14JhaEtRWFS1ALO0G96+YBGJag6MO+64U5x1MXjH1Ggyw
	tZ041Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 411s5pjnvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 18:22:05 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47GIM4as022144
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 18:22:04 GMT
Received: from [10.216.61.113] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 16 Aug
 2024 11:21:57 -0700
Message-ID: <5bf5c208-f90c-19b1-7006-694d3cd2351a@quicinc.com>
Date: Fri, 16 Aug 2024 23:51:53 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 3/4] firmware: psci: Read and use vendor reset types
Content-Language: en-US
To: Elliot Berman <quic_eberman@quicinc.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Andy Yan
	<andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Bartosz
 Golaszewski" <bartosz.golaszewski@linaro.org>,
        Satya Durga Srinivasu Prabhala
	<quic_satyap@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_spratap@qucinc.com>
References: <20240617-arm-psci-system_reset2-vendor-reboots-v5-0-086950f650c8@quicinc.com>
 <20240617-arm-psci-system_reset2-vendor-reboots-v5-3-086950f650c8@quicinc.com>
 <ZrOMjomTTWZ91Uzf@lpieralisi>
 <20240807103245593-0700.eberman@hu-eberman-lv.qualcomm.com>
 <ZrYZ/i1QFhfmv0zi@lpieralisi>
 <20240809090339647-0700.eberman@hu-eberman-lv.qualcomm.com>
 <28c8bc92-4a55-8a07-1ece-333316d78410@quicinc.com>
 <Zr4Td7PiKhKl3Et3@lpieralisi>
 <20240815100749641-0700.eberman@hu-eberman-lv.qualcomm.com>
From: Shivendra Pratap <quic_spratap@quicinc.com>
In-Reply-To: <20240815100749641-0700.eberman@hu-eberman-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: k339WUc2558CtmYnKtpnI043KslKmbsq
X-Proofpoint-ORIG-GUID: k339WUc2558CtmYnKtpnI043KslKmbsq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_13,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408160129



On 8/15/2024 11:35 PM, Elliot Berman wrote:
> On Thu, Aug 15, 2024 at 04:40:55PM +0200, Lorenzo Pieralisi wrote:
>> On Mon, Aug 12, 2024 at 11:46:08PM +0530, Shivendra Pratap wrote:
>>>
>>>
>>> On 8/9/2024 10:28 PM, Elliot Berman wrote:
>>>> On Fri, Aug 09, 2024 at 03:30:38PM +0200, Lorenzo Pieralisi wrote:
>>>>> On Wed, Aug 07, 2024 at 11:10:50AM -0700, Elliot Berman wrote:
>>>>>
>>>>> [...]
>>>>>
>>>>>>>> +static void psci_vendor_sys_reset2(unsigned long action, void *data)
>>>>>>>
>>>>>>> 'action' is unused and therefore it is not really needed.
>>>>>>>
>>>>>>>> +{
>>>>>>>> +	const char *cmd = data;
>>>>>>>> +	unsigned long ret;
>>>>>>>> +	size_t i;
>>>>>>>> +
>>>>>>>> +	for (i = 0; i < num_psci_reset_params; i++) {
>>>>>>>> +		if (!strcmp(psci_reset_params[i].mode, cmd)) {
>>>>>>>> +			ret = invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2),
>>>>>>>> +					     psci_reset_params[i].reset_type,
>>>>>>>> +					     psci_reset_params[i].cookie, 0);
>>>>>>>> +			pr_err("failed to perform reset \"%s\": %ld\n",
>>>>>>>> +				cmd, (long)ret);
>>>>>>>> +		}
>>>>>>>> +	}
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>  static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
>>>>>>>>  			  void *data)
>>>>>>>>  {
>>>>>>>> +	if (data && num_psci_reset_params)
>>>>>>>
>>>>>>> So, reboot_mode here is basically ignored; if there is a vendor defined
>>>>>>> reset, we fire it off.
>>>>>>>
>>>>>>> I think Mark mentioned his concerns earlier related to REBOOT_* mode and
>>>>>>> reset type (granted, the context was different):
>>>>>>>
>>>>>>> https://lore.kernel.org/all/20200320120105.GA36658@C02TD0UTHF1T.local/
>>>>>>>
>>>>>>> I would like to understand if this is the right thing to do before
>>>>>>> accepting this patchset.
>>>>>>>
>>>>>>
>>>>>> I don't have any concerns to move this part below checking reboot_mode.
>>>>>> Or, I could add reboot_mode == REBOOT_COLD check.
>>>>>
>>>>> The question is how can we map vendor specific reboot magic to Linux
>>>>> reboot modes sensibly in generic PSCI code - that's by definition
>>>>> vendor specific.
>>>>>
>>>>
>>>> I don't think it's a reasonable thing to do. "reboot bootloader" or
>>>> "reboot edl" don't make sense to the Linux reboot modes.
>>>>
>>>> I believe the Linux reboot modes enum is oriented to perspective of
>>>> Linux itself and the vendor resets are oriented towards behavior of the
>>>> SoC.
>>>>
>>>> Thanks,
>>>> Elliot
>>>>
>>>
>>> Agree.
>>>
>>> from perspective of linux reboot modes, kernel's current
>>> implementation in reset path is like:
>>>
>>> __
>>> #1 If reboot_mode is WARM/SOFT and PSCI_SYSRESET2 is supported 
>>>     Call PSCI - SYSTEM_RESET2 - ARCH RESET
>>> #2 ELSE
>>>     Call PSCI - SYSTEM_RESET COLD RESET
>>> ___
>>>
>>> ARM SPECS for PSCI SYSTEM_RESET2
>>> This function extends SYSTEM_RESET. It provides:
>>> • ARCH RESET: set Bit[31] to 0               = > This is already in place in condition #1.
>>> • vendor-specific resets: set Bit[31] to 1.  = > current patchset adds this part before kernel's reboot_mode reset at #0.
>>>
>>>
>>> In current patchset, we see a condition added at
>>> #0-psci_vendor_reset2 being called before kernel’s current
>>> reboot_mode condition and it can take any action only if all below
>>> conditions are satisfied.
>>> - PSCI SYSTEM_RESET2 is supported.
>>> - psci dt node defines an entry "bootloader" as a reboot-modes.
>>> - User issues reboot with a command say - (reboot bootloader).
>>> - If vendor reset fails, default reboot mode will execute as is.
>>>
>>> Don't see if we will skip or break the kernel reboot_mode flow with
>>> this patch.  Also if user issues reboot <cmd> and <cmd> is supported
>>> on SOC vendor reset psci node, should cmd take precedence over
>>> kernel reboot mode enum? may be yes? 
>>>
>>
>> Please wrap lines when replying.
sure. will try to take care.
>>
>> I don't think it is a matter of precedence. reboot_mode and the reboot
>> command passed to the reboot() syscall are there for different (?)
>> reasons.
>>
>> What I am asking is whether it is always safe to execute a PSCI vendor
>> reset irrispective of the reboot_mode value.
Valid point, but it depends on how we configure reboot mode and vendor reset.
If the configuration is conflicting in DT, then reboot_mode and vendor reset
may conflict and show non-predictable results.
For instance, on qcs6490, we have have nvmem-reboot-mode driver
which supports "reboot mode bootloader" function via its current DT as the PMIC
registers are accessible for write on this soc. If we enable nvmem-reboot-mode
and then configure vendor_reset2(mode-bootloader) to perform a different
function on reboot, they will conflict and may result in a non-predictable
behavior. The developer or soc vendor has to take care of this in any
case so this may be a invalid scenario?

May be vendor_reset2 gives more flexibility here on how a soc vendor may 
implement reboot modes and other vendor reset types. In case soc vendor
wants to keep some reboot mode register as open access, they can still
use reboot_mode driver and then others reboot/reset modes can be configured
via vendor_reset2.

For instance, on qcs6490, we can use nvmem-reboot-mode driver for 
"reboot mode bootloader" and use the current patch-vendor_reset2 for
"reboot mode edl". This can be configured via DT. Now even if we
enable both current-patch-vendor_reset2(reboot mode bootloader) 
and nvmem-reboot-mode (mode-bootloader) at same time on this soc,
they are harmless to each other and work as desired as both(DT entries)
align with each other and the PMIC registers are accessible to kernel. The
same thing can conflict, if we enable both drivers at same time and configure
them with conflicting parameters in DT for (reboot mode bootloader).

> 
> The only way I see it to be unsafe is we need some other driver using
> the reboot_mode to configure something and then the PSCI vendor reset
> being incompatible with whatever that other driver did. I don't see that
> happens today, so it is up to us to decide what the policy ought to be.
> The PSCI spec doesn't help us here because the reboot_mode enum is
> totally a Linux construct. In my opinion, firmware should be able to
> deal with whatever the driver did or (less ideal) the driver need to be
> aware of the PSCI vendor resets. Thus, it would be always safe to
> execute a PSCI vendor reset regardless of the reboot_mode value.
> 
> Thanks,
> Elliot
> 

