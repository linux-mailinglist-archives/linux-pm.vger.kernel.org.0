Return-Path: <linux-pm+bounces-15937-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D63F9A3A31
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 11:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E622831F3
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 09:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555281FF7AA;
	Fri, 18 Oct 2024 09:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="N8Pg9fH2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m10162.netease.com (mail-m10162.netease.com [154.81.10.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DF5187858;
	Fri, 18 Oct 2024 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=154.81.10.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729244369; cv=none; b=GMuVNxBl8UkXexWFFt/To9/zOkazVblP6WII9kUsvmW99tHnNEJJ6wo4b2Z6d7zm2apBJFKscH5dAfuByJFfPM9KgGNaU0mTgFgDb7AAz3C9yMh2kehisfKo1NnE+fkmkde5e8Mgd/BJu7m3JfOIa6A9zjG//J1VuHmbKwqoig8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729244369; c=relaxed/simple;
	bh=Of/korwJH8MA1QMUqd3VMrVziKJ3fx5U+jFmiSPX3Sc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PyKuavutWca9N8I7Y29bKTSDe669mht5FMG05kl8cCEghoQM88WA5f8tfyYpjp7byrtTLe521SlPfmZ/dS51tCDCjZff2KybsHa2TqRSBuog+entix9cWlpPyK6/IrkI3yK5FATzdbTLKJkC64fgpH6XK/95wiyG73O/BLv0nfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=N8Pg9fH2; arc=none smtp.client-ip=154.81.10.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=N8Pg9fH2I7RyKLns4/qH+WJpXzhQMmW5Xb3E6dlH2BIsP6f0zxX4b/Yi1r+0ITp8ZW7+omPvAZIzNa7+4jHdQMgPGDF3ikOyBAfZwlZ6BZbEEPtO8GqEoshCs/0gcF8ValDl0qHAwG27Q8fvg8O6oeowN49NdEro8kENYXEvBuc=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=deE5f9Ret2wP45i7Ib72XRZhiMvsjcDFrcSbhhoZVEk=;
	h=date:mime-version:subject:message-id:from;
Received: from lintao?rock-chips.com (gy-adaptive-ssl-proxy-2-entmail-virt205.gy.ntes [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with SMTP id 9901D2A06A9;
	Fri, 18 Oct 2024 17:20:08 +0800 (CST)
Message-ID: <98e0062c-aeb1-4bea-aa2b-4a99115c9da4@rock-chips.com>
Date: Fri, 18 Oct 2024 17:20:08 +0800
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
Content-Language: en-GB
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <CAPDyKFo=GcHG2sGQBrXJ7VWyp59QOmbLCAvHQ3krUympEkid_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkseSFZCH0xCSEhDHUMYTkJWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a929eed6a9403aakunm9901d2a06a9
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6P0k6ERw4AjItKTUwDRwKSA4P
	ODhPC0JVSlVKTElCSU9ISUpISUtMVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUNJS0I3Bg++

Hi Ulf,

在 2024/10/18 17:07, Ulf Hansson 写道:
> On Thu, 10 Oct 2024 at 03:21, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>
>> Hi Ulf
>>
>> 在 2024/10/9 21:15, Ulf Hansson 写道:
>>> [...]
>>>
>>>> +
>>>> +static int ufs_rockchip_runtime_suspend(struct device *dev)
>>>> +{
>>>> +       struct ufs_hba *hba = dev_get_drvdata(dev);
>>>> +       struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
>>>> +       struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
>>>
>>> pd_to_genpd() isn't safe to use like this. It's solely to be used by
>>> genpd provider drivers.
>>>
>>>> +
>>>> +       clk_disable_unprepare(host->ref_out_clk);
>>>> +
>>>> +       /*
>>>> +        * Shouldn't power down if rpm_lvl is less than level 5.
>>>
>>> Can you elaborate on why we must not power-off the power-domain when
>>> level is less than 5?
>>>
>>
>> Because ufshcd driver assume the controller is active and the link is on
>> if level is less than 5. So the default resume policy will not try to
>> recover the registers until the first error happened. Otherwise if the
>> level is >=5, it assumes the controller is off and the link is down,
>> then it will restore the registers and link.
>>
>> And the level is changeable via sysfs.
> 
> Okay, thanks for clarifying.
> 
>>
>>> What happens if we power-off anyway when the level is less than 5?
>>>
>>>> +        * This flag will be passed down to platform power-domain driver
>>>> +        * which has the final decision.
>>>> +        */
>>>> +       if (hba->rpm_lvl < UFS_PM_LVL_5)
>>>> +               genpd->flags |= GENPD_FLAG_RPM_ALWAYS_ON;
>>>> +       else
>>>> +               genpd->flags &= ~GENPD_FLAG_RPM_ALWAYS_ON;
>>>
>>> The genpd->flags is not supposed to be changed like this - and
>>> especially not from a genpd consumer driver.
>>>
>>> I am trying to understand a bit more of the use case here. Let's see
>>> if that helps me to potentially suggest an alternative approach.
>>>
>>
>> I was not familiar with the genpd part, so I haven't come up with
>> another solution. It would be great if you can guide me to the right
>> way.
> 
> I have been playing with the existing infrastructure we have at hand
> to support this, but I need a few more days to be able to propose
> something for you.
> 

Much appreciate.

>>
>>>> +
>>>> +       return ufshcd_runtime_suspend(dev);
>>>> +}
>>>> +
>>>> +static int ufs_rockchip_runtime_resume(struct device *dev)
>>>> +{
>>>> +       struct ufs_hba *hba = dev_get_drvdata(dev);
>>>> +       struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
>>>> +       int err;
>>>> +
>>>> +       err = clk_prepare_enable(host->ref_out_clk);
>>>> +       if (err) {
>>>> +               dev_err(hba->dev, "failed to enable ref out clock %d\n", err);
>>>> +               return err;
>>>> +       }
>>>> +
>>>> +       reset_control_assert(host->rst);
>>>> +       usleep_range(1, 2);
>>>> +       reset_control_deassert(host->rst);
>>>> +
>>>> +       return ufshcd_runtime_resume(dev);
>>>> +}
>>>> +
>>>> +static int ufs_rockchip_system_suspend(struct device *dev)
>>>> +{
>>>> +       struct ufs_hba *hba = dev_get_drvdata(dev);
>>>> +       struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
>>>> +
>>>> +       /* Pass down desired spm_lvl to Firmware */
>>>> +       arm_smccc_smc(ROCKCHIP_SIP_SUSPEND_MODE, ROCKCHIP_SLEEP_PD_CONFIG,
>>>> +                       host->pd_id, hba->spm_lvl < 5 ? 1 : 0, 0, 0, 0, 0, NULL);
>>>
>>> Can you please elaborate on what goes on here? Is this turning off the
>>> power-domain that the dev is attached to - or what is actually
>>> happening?
>>>
>>
>> This smc call is trying to ask firmware not to turn off the power-domian
>> that the UFS is attached to and also not to turn off the power of UFS
>> conntroller.
> 
> Okay, thanks for clarifying!
> 
> A follow up question, don't you need to make a corresponding smc call
> to inform the FW that it's okay to turn off the power-domain at some
> point?
> 

Yes. Each time entering sleep, we teach FW if it need to turn off or 
keep power-domain, for instance "hba->spm_lvl < 5 ? 1 : 0" , 0 means
off and 1 means on.

>>
>> Per your comment at patch 4, should I use GENPD_FLAG_ALWAYS_ON +
>> arm_smccc_smc here in system suspend?
>>
>>>> +
>>>> +       return ufshcd_system_suspend(dev);
>>>> +}
>>>> +
>>>> +static const struct dev_pm_ops ufs_rockchip_pm_ops = {
>>>> +       SET_SYSTEM_SLEEP_PM_OPS(ufs_rockchip_system_suspend, ufshcd_system_resume)
>>>> +       SET_RUNTIME_PM_OPS(ufs_rockchip_runtime_suspend, ufs_rockchip_runtime_resume, NULL)
>>>> +       .prepare         = ufshcd_suspend_prepare,
>>>> +       .complete        = ufshcd_resume_complete,
>>>> +};
>>>> +
>>>> +static struct platform_driver ufs_rockchip_pltform = {
>>>> +       .probe = ufs_rockchip_probe,
>>>> +       .remove = ufs_rockchip_remove,
>>>> +       .driver = {
>>>> +               .name = "ufshcd-rockchip",
>>>> +               .pm = &ufs_rockchip_pm_ops,
>>>> +               .of_match_table = ufs_rockchip_of_match,
>>>> +       },
>>>> +};
>>>> +module_platform_driver(ufs_rockchip_pltform);
>>>> +
>>>
>>> [...]
> 
> Kind regards
> Uffe
> 


