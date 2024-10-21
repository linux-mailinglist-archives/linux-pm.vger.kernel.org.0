Return-Path: <linux-pm+bounces-16073-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8D29A653E
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 12:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC881C2232F
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 10:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2911F76C1;
	Mon, 21 Oct 2024 10:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="V38btIJa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m1286.netease.com (mail-m1286.netease.com [103.209.128.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A76D1E571E;
	Mon, 21 Oct 2024 10:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.209.128.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507771; cv=none; b=X5RZKQEboBCZnILtAfotQj0rK3UlhtTzIbXcJJrhoSErZkEPg4pPw74O6VMOpFQ7VasvGIaC8Atoj7n6L11g0qfVX8ueQr5OEsmboXhcLFHihtcz6qZ0zy2jhep3tPpjHnG3MVQNBD8hb1/fYxcyhEnbFicGhDbx6M/6xP4+TBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507771; c=relaxed/simple;
	bh=2E+rcCfCM4mlFpCuCzzP1ezoQuwzWfKc7+SZIOWUlPQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DOq/2aBqjVy/IWEklBFsrq2wiqDOAywMNgWAPPRjEIWqdl0nVFVoMvithGTVnXAPIcOffGPDuQs2/GVPkNoD2mh6hjXQuiZ5mf/tKUMCjALT/dziGi5+cGbYy3w2aiaVGLfX4TZeb6IPjf/p3LjVCcfsBrKGq1PSJfmOFqhAhxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=V38btIJa; arc=none smtp.client-ip=103.209.128.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=V38btIJakVMMe4dDZ7E9LyioghrUde8fStgdte4jHGxwc+2EhgCGN0sjjP27GgFTzEIKpv44PwwmVP00KwPN+kvnp8fM2cX187Apk2Rw9geRwTmVRErIA1f54NhKN/GR8ZCTcyH3FRTM65pLwwDiDSCTEVHcZdLbPmIwyC1vK9Q=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=KtWr2riFT/2Ittypx/eroyOm6tXa4t9/AcYin97fqlY=;
	h=date:mime-version:subject:message-id:from;
Received: from lintao?rock-chips.com (gy-adaptive-ssl-proxy-3-entmail-virt135.gy.ntes [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with SMTP id DA0B62A0123;
	Mon, 21 Oct 2024 08:43:26 +0800 (CST)
Message-ID: <90ff835d-f3b2-4b7c-aa1a-575e231a57e6@rock-chips.com>
Date: Mon, 21 Oct 2024 08:43:26 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Rob Herring <robh+dt@kernel.org>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>, YiFeng Zhao <zyf@rock-chips.com>,
 Liang Chen <cl@rock-chips.com>, linux-scsi@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 5/5] scsi: ufs: rockchip: initial support for UFS
To: Ulf Hansson <ulf.hansson@linaro.org>
References: <1728368130-37213-1-git-send-email-shawn.lin@rock-chips.com>
 <1728368130-37213-6-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKForpLcmkqruuTfD6kkJhp_4CKFABWRxFVYNskGL1tjO=w@mail.gmail.com>
 <3969bae0-eeb8-447a-86a5-dfdac0b136cd@rock-chips.com>
 <CAPDyKFo=GcHG2sGQBrXJ7VWyp59QOmbLCAvHQ3krUympEkid_A@mail.gmail.com>
 <98e0062c-aeb1-4bea-aa2b-4a99115c9da4@rock-chips.com>
 <CAPDyKFogrPEEe1A3Kghjj3-SSJT2xEoKfo_hU7KZk+d9bZxEYQ@mail.gmail.com>
Content-Language: en-GB
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <CAPDyKFogrPEEe1A3Kghjj3-SSJT2xEoKfo_hU7KZk+d9bZxEYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU8aQ1YaTh1LTxkaH0odH0pWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a92ac87724003aakunmda0b62a0123
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nxw6FDo6MDIsTCkCQz4vHy0K
	MDoKCkhVSlVKTElCT0xKT0pKTk5DVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUNISEg3Bg++

在 2024/10/18 18:03, Ulf Hansson 写道:
> On Fri, 18 Oct 2024 at 11:20, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>
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
>> Yes. Each time entering sleep, we teach FW if it need to turn off or
>> keep power-domain, for instance "hba->spm_lvl < 5 ? 1 : 0" , 0 means
>> off and 1 means on.
> 
> I see. So you need to make the call each time when entering the system suspend?
> 
> Or would it be okay to just make it once, when the spm_lvl is changed?

Thers is no nofity when changing spm_lvl.

> 
> Another way to deal with it, would be to make the smc call each time
> the power-domain is turned-on, based on spm_lvl too of course.
> 
> Would that work?

Yes, that works. Another option is to cache power-domain states and
check spm_lvl locally. If it doesn't change, we skip smc call.

> 
> [...]
> 
> Kind regards
> Uffe
> 


