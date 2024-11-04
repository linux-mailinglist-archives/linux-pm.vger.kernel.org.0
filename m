Return-Path: <linux-pm+bounces-16971-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2619BB931
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 16:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D718B224AA
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 15:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C8F1C07E3;
	Mon,  4 Nov 2024 15:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="DU3SuEdP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m1973173.qiye.163.com (mail-m1973173.qiye.163.com [220.197.31.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7731C07DE
	for <linux-pm@vger.kernel.org>; Mon,  4 Nov 2024 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730734898; cv=none; b=sNMM0mGzgCY7BLq4/PVp2eekH4d+N9vzQ96DalUaRlnGZoTsacT2zPIP8tGSr2cOOhiB854KJF93BlmPrqF62D1Z4Gffwn33yvlC45S3obkOJKBFcORPk0hWvc9liyIstcDtLrpHa4XBMaxPKqbGM9BhlJwp8NrCm/0Y/rIWngs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730734898; c=relaxed/simple;
	bh=Vbw/eBJ9fZbuakGdvyE6kcwGjTyBm8s5NtjMjx4wHIQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eZ5iyoBPbe4+mb0DStV0oNX6EZI4XxCKaDWkNZYZRCIHWkEepohfAVBX83l1Ch32M0/Su9xoQ0cMJ0SPJSOcOfOGP2PxPcsv32k4cTj1OG1zwdi+gGMCfIvQtcHX3iGvcxBJeEquQ+YoNOfi3yQ20h/Ke1A7PvFoLb8h1jvxigQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=DU3SuEdP; arc=none smtp.client-ip=220.197.31.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.45] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1b3e7143;
	Mon, 4 Nov 2024 14:38:16 +0800 (GMT+08:00)
Message-ID: <6f3f2d17-4ca2-44ad-b8df-72986d4b3174@rock-chips.com>
Date: Mon, 4 Nov 2024 14:38:16 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>, YiFeng Zhao <zyf@rock-chips.com>,
 Liang Chen <cl@rock-chips.com>, linux-scsi@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 5/5] scsi: ufs: rockchip: initial support for UFS
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <1728368130-37213-1-git-send-email-shawn.lin@rock-chips.com>
 <1728368130-37213-6-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKForpLcmkqruuTfD6kkJhp_4CKFABWRxFVYNskGL1tjO=w@mail.gmail.com>
 <3969bae0-eeb8-447a-86a5-dfdac0b136cd@rock-chips.com>
 <CAPDyKFo=GcHG2sGQBrXJ7VWyp59QOmbLCAvHQ3krUympEkid_A@mail.gmail.com>
 <98e0062c-aeb1-4bea-aa2b-4a99115c9da4@rock-chips.com>
 <20241103120223.abkwgej4svas4epr@thinkpad>
Content-Language: en-GB
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20241103120223.abkwgej4svas4epr@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhpCSlZMTR4dSkhKSx9PHh9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a92f5e546e209cckunm1b3e7143
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBw6Sww4FTIuPDpLSBktPSI9
	MggwCRFVSlVKTEhLTEtJSUJDTktIVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQU5JTkg3Bg++
DKIM-Signature:a=rsa-sha256;
	b=DU3SuEdPcEpa+HXaAmtYzoHn1y+J+KZBKzvBxCyom7GSkWUk50hQMl+d4ECHq69Tsvw8Tw05iTs3jWFbioFxLIB83lYsghYWbulcmBPsfGMTdvyqfWaVycjbMornt1Ol5qaIUYlBAMETiWUExJp/Ye+9gkZKuMd6wfhjUqNQiJw=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=coXjwW8ahmTl1/WoUAvxkkWEwwxJZx/4YBJoZyucdyI=;
	h=date:mime-version:subject:message-id:from;

在 2024/11/3 20:02, Manivannan Sadhasivam 写道:
> On Fri, Oct 18, 2024 at 05:20:08PM +0800, Shawn Lin wrote:
>> Hi Ulf,
>>
>> 在 2024/10/18 17:07, Ulf Hansson 写道:
>>> On Thu, 10 Oct 2024 at 03:21, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>>>
>>>> Hi Ulf
>>>>
>>>> 在 2024/10/9 21:15, Ulf Hansson 写道:
>>>>> [...]
>>>>>
>>>>>> +
>>>>>> +static int ufs_rockchip_runtime_suspend(struct device *dev)
>>>>>> +{
>>>>>> +       struct ufs_hba *hba = dev_get_drvdata(dev);
>>>>>> +       struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
>>>>>> +       struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
>>>>>
>>>>> pd_to_genpd() isn't safe to use like this. It's solely to be used by
>>>>> genpd provider drivers.
>>>>>
>>>>>> +
>>>>>> +       clk_disable_unprepare(host->ref_out_clk);
>>>>>> +
>>>>>> +       /*
>>>>>> +        * Shouldn't power down if rpm_lvl is less than level 5.
>>>>>
>>>>> Can you elaborate on why we must not power-off the power-domain when
>>>>> level is less than 5?
>>>>>
>>>>
>>>> Because ufshcd driver assume the controller is active and the link is on
>>>> if level is less than 5. So the default resume policy will not try to
>>>> recover the registers until the first error happened. Otherwise if the
>>>> level is >=5, it assumes the controller is off and the link is down,
>>>> then it will restore the registers and link.
>>>>
>>>> And the level is changeable via sysfs.
>>>
>>> Okay, thanks for clarifying.
>>>
>>>>
>>>>> What happens if we power-off anyway when the level is less than 5?
>>>>>
>>>>>> +        * This flag will be passed down to platform power-domain driver
>>>>>> +        * which has the final decision.
>>>>>> +        */
>>>>>> +       if (hba->rpm_lvl < UFS_PM_LVL_5)
>>>>>> +               genpd->flags |= GENPD_FLAG_RPM_ALWAYS_ON;
>>>>>> +       else
>>>>>> +               genpd->flags &= ~GENPD_FLAG_RPM_ALWAYS_ON;
>>>>>
>>>>> The genpd->flags is not supposed to be changed like this - and
>>>>> especially not from a genpd consumer driver.
>>>>>
>>>>> I am trying to understand a bit more of the use case here. Let's see
>>>>> if that helps me to potentially suggest an alternative approach.
>>>>>
>>>>
>>>> I was not familiar with the genpd part, so I haven't come up with
>>>> another solution. It would be great if you can guide me to the right
>>>> way.
>>>
>>> I have been playing with the existing infrastructure we have at hand
>>> to support this, but I need a few more days to be able to propose
>>> something for you.
>>>
>>
>> Much appreciate.
>>
>>>>
>>>>>> +
>>>>>> +       return ufshcd_runtime_suspend(dev);
>>>>>> +}
>>>>>> +
>>>>>> +static int ufs_rockchip_runtime_resume(struct device *dev)
>>>>>> +{
>>>>>> +       struct ufs_hba *hba = dev_get_drvdata(dev);
>>>>>> +       struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
>>>>>> +       int err;
>>>>>> +
>>>>>> +       err = clk_prepare_enable(host->ref_out_clk);
>>>>>> +       if (err) {
>>>>>> +               dev_err(hba->dev, "failed to enable ref out clock %d\n", err);
>>>>>> +               return err;
>>>>>> +       }
>>>>>> +
>>>>>> +       reset_control_assert(host->rst);
>>>>>> +       usleep_range(1, 2);
>>>>>> +       reset_control_deassert(host->rst);
>>>>>> +
>>>>>> +       return ufshcd_runtime_resume(dev);
>>>>>> +}
>>>>>> +
>>>>>> +static int ufs_rockchip_system_suspend(struct device *dev)
>>>>>> +{
>>>>>> +       struct ufs_hba *hba = dev_get_drvdata(dev);
>>>>>> +       struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
>>>>>> +
>>>>>> +       /* Pass down desired spm_lvl to Firmware */
>>>>>> +       arm_smccc_smc(ROCKCHIP_SIP_SUSPEND_MODE, ROCKCHIP_SLEEP_PD_CONFIG,
>>>>>> +                       host->pd_id, hba->spm_lvl < 5 ? 1 : 0, 0, 0, 0, 0, NULL);
>>>>>
>>>>> Can you please elaborate on what goes on here? Is this turning off the
>>>>> power-domain that the dev is attached to - or what is actually
>>>>> happening?
>>>>>
>>>>
>>>> This smc call is trying to ask firmware not to turn off the power-domian
>>>> that the UFS is attached to and also not to turn off the power of UFS
>>>> conntroller.
>>>
>>> Okay, thanks for clarifying!
>>>
>>> A follow up question, don't you need to make a corresponding smc call
>>> to inform the FW that it's okay to turn off the power-domain at some
>>> point?
>>>
>>
>> Yes. Each time entering sleep, we teach FW if it need to turn off or keep
>> power-domain, for instance "hba->spm_lvl < 5 ? 1 : 0" , 0 means
>> off and 1 means on.
>>
> 
> We had a requirement to notify the genpd provider from consumer to not turn off
> the power domain during system suspend. So Ulf came up with an API for
> consumers, device_set_wakeup_path() setting the 'dev->power.wakeup_path' which
> will be honored by the genpd core. Will that work for you?

Yes, that works. And we may need a symmetrical call, for instance,
device_clr_wakeup_path() to allow genpd provider to turn off the power
domain as well.

> 
> PS: The API naming suggests that the device will be used in wakeup path, which
> may not be true here but the end result will be the same.
> 
> - Mani
> 


