Return-Path: <linux-pm+bounces-12110-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE8C94F68E
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 20:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9531A286748
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 18:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06C618E04C;
	Mon, 12 Aug 2024 18:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M80I8SF8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0CE18787B;
	Mon, 12 Aug 2024 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486841; cv=none; b=RWxwSBmV0Qa+Jt9HWhkN8GxfzID7Kpzd9WtWPb8sK5h0Lh70xPEbIkzTHIoKc/qkPNH/3vAFIMhOVeg5e7Y0iLKvqsaMlk7JH9Pt4AlfukImi/POWo59dAaF2OsZfXMFBGIGA4z5hi1ufvAJDo41ArOYXvj8Xk0W7RrsbtznepY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486841; c=relaxed/simple;
	bh=ruBxSpaL1zzjfeZ+3uWG5MP0BpemDpvtz6RSGDEOrPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CdbfyC4UOLnHPdXGJ2JSdlJ91I7QE/LcAckQ5TjqT8ATluK42CDVfUaPqM5bT7hOLvkx+d9IF20/juSF3Ud+OwbV9vlgS8ImacFk56kJXPvWhvTeC/53Whb17rrr3Zkb3FDRHutEPAp4xZ/IglqJsdISzddvKQR4L8/I4BA5dNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M80I8SF8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47CDSbqR017504;
	Mon, 12 Aug 2024 18:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9Nfz751ACTLyecrv87bbUTwqsi6Lp/AjbSXzAYjq7/o=; b=M80I8SF8/nOImR79
	IPyyEQcbiyhDOvMSishoFSeblQ/6NRZJVMuhir8x4oOKuTSAn2MIxE1z+mFepJRj
	NiIFSBivBSIvAmFagHS1zl/BXjDacbVC03NlSwBm/J1bOc0x24pnQ9habYAvyf4q
	ND8MXOAPIdYTXLYHTBOgM1YqSBtAOmMsXMj0xb7j3vKG35EqYbbrsbMq5Ggslzky
	NEzJ7tydbstkAzqgVWMvviQbCrbze5leUCr16xm8y9H/RFycaoCdnRVYIGMEkihg
	RmQ5Cek9IeztYxNTRw7CmBk60zZeVeQWIR6MbP+/AZ1adVNw2FU6SxsPZDKolRa/
	Mc2M6w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40x1d4d1t1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 18:16:20 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47CIGJ8n005714
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 18:16:19 GMT
Received: from [10.216.3.204] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 12 Aug
 2024 11:16:12 -0700
Message-ID: <28c8bc92-4a55-8a07-1ece-333316d78410@quicinc.com>
Date: Mon, 12 Aug 2024 23:46:08 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 3/4] firmware: psci: Read and use vendor reset types
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
Content-Language: en-US
From: Shivendra Pratap <quic_spratap@quicinc.com>
In-Reply-To: <20240809090339647-0700.eberman@hu-eberman-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ollusWuQeFA-k-mEjm9dK-3rv8W2pqPr
X-Proofpoint-GUID: ollusWuQeFA-k-mEjm9dK-3rv8W2pqPr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_12,2024-08-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408120135



On 8/9/2024 10:28 PM, Elliot Berman wrote:
> On Fri, Aug 09, 2024 at 03:30:38PM +0200, Lorenzo Pieralisi wrote:
>> On Wed, Aug 07, 2024 at 11:10:50AM -0700, Elliot Berman wrote:
>>
>> [...]
>>
>>>>> +static void psci_vendor_sys_reset2(unsigned long action, void *data)
>>>>
>>>> 'action' is unused and therefore it is not really needed.
>>>>
>>>>> +{
>>>>> +	const char *cmd = data;
>>>>> +	unsigned long ret;
>>>>> +	size_t i;
>>>>> +
>>>>> +	for (i = 0; i < num_psci_reset_params; i++) {
>>>>> +		if (!strcmp(psci_reset_params[i].mode, cmd)) {
>>>>> +			ret = invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2),
>>>>> +					     psci_reset_params[i].reset_type,
>>>>> +					     psci_reset_params[i].cookie, 0);
>>>>> +			pr_err("failed to perform reset \"%s\": %ld\n",
>>>>> +				cmd, (long)ret);
>>>>> +		}
>>>>> +	}
>>>>> +}
>>>>> +
>>>>>  static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
>>>>>  			  void *data)
>>>>>  {
>>>>> +	if (data && num_psci_reset_params)
>>>>
>>>> So, reboot_mode here is basically ignored; if there is a vendor defined
>>>> reset, we fire it off.
>>>>
>>>> I think Mark mentioned his concerns earlier related to REBOOT_* mode and
>>>> reset type (granted, the context was different):
>>>>
>>>> https://lore.kernel.org/all/20200320120105.GA36658@C02TD0UTHF1T.local/
>>>>
>>>> I would like to understand if this is the right thing to do before
>>>> accepting this patchset.
>>>>
>>>
>>> I don't have any concerns to move this part below checking reboot_mode.
>>> Or, I could add reboot_mode == REBOOT_COLD check.
>>
>> The question is how can we map vendor specific reboot magic to Linux
>> reboot modes sensibly in generic PSCI code - that's by definition
>> vendor specific.
>>
> 
> I don't think it's a reasonable thing to do. "reboot bootloader" or
> "reboot edl" don't make sense to the Linux reboot modes.
> 
> I believe the Linux reboot modes enum is oriented to perspective of
> Linux itself and the vendor resets are oriented towards behavior of the
> SoC.
> 
> Thanks,
> Elliot
> 

Agree.

from perspective of linux reboot modes, kernel's current implementation in reset path is like:
__
#1 If reboot_mode is WARM/SOFT and PSCI_SYSRESET2 is supported 
    Call PSCI - SYSTEM_RESET2 - ARCH RESET
#2 ELSE
    Call PSCI - SYSTEM_RESET COLD RESET
___

ARM SPECS for PSCI SYSTEM_RESET2
This function extends SYSTEM_RESET. It provides:
• ARCH RESET: set Bit[31] to 0               = > This is already in place in condition #1.
• vendor-specific resets: set Bit[31] to 1.  = > current patchset adds this part before kernel's reboot_mode reset at #0.


In current patchset, we see a condition added at #0-psci_vendor_reset2 being called before kernel’s current reboot_mode condition and it can take any action only if all below conditions are satisfied.
- PSCI SYSTEM_RESET2 is supported.
- psci dt node defines an entry "bootloader" as a reboot-modes.
- User issues reboot with a command say - (reboot bootloader).
- If vendor reset fails, default reboot mode will execute as is.

Don't see if we will skip or break the kernel reboot_mode flow with this patch. 
Also if user issues reboot <cmd> and <cmd> is supported on SOC vendor reset psci node, should cmd take precedence over kernel reboot mode enum? may be yes? 


