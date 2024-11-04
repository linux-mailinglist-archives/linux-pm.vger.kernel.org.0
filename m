Return-Path: <linux-pm+bounces-16954-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D52BF9BB57E
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 14:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B0341F21B51
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 13:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868471BD027;
	Mon,  4 Nov 2024 13:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="LNwmbqLq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m1973175.qiye.163.com (mail-m1973175.qiye.163.com [220.197.31.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38C21B81C1;
	Mon,  4 Nov 2024 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730725900; cv=none; b=GeIy6vzU1L7KisKmCsbABqzzaoh77mHKjXoECPdYw+szv5QrvJ7JsMxxbxrB8MWGxY/ZvU7Qf+DcMjXndcbIIUyp+kq4jp8teFbvB2cl6tRQFfdKNV1oyMIWhZTH7LQZfHSzKGSziKy1yeaCHjEt9OwN5ZPPpGJb/2NJv19pRXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730725900; c=relaxed/simple;
	bh=pymx5FbEA3OfOrxn/cViQ3L3clatLTb162PCEKy7YWw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rE3QGFks04cEHN+1ECHfofG9VNQxo/Si1O6m6rzHr2oBlqlQmY0lDaaYbYgI3dEtAK2lzskGNROp7d4svvXbpmeoavvuP3mxaAcVI7bP6FJ4yEJF7i/VhaRdXlH8IFyIwp6MbxkOsU/Rrz26zjGNFgZghMampfSVBMAj07k+pIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=LNwmbqLq; arc=none smtp.client-ip=220.197.31.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.45] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1b345651;
	Mon, 4 Nov 2024 14:21:45 +0800 (GMT+08:00)
Message-ID: <161ad092-4e7c-4ca1-ade7-d512a0b39799@rock-chips.com>
Date: Mon, 4 Nov 2024 14:21:45 +0800
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
 <90ff835d-f3b2-4b7c-aa1a-575e231a57e6@rock-chips.com>
 <CAPDyKFouCV3hCcJ9VuS0App34YyBd6vVNSJr6JZbYGGpffwaWA@mail.gmail.com>
Content-Language: en-GB
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <CAPDyKFouCV3hCcJ9VuS0App34YyBd6vVNSJr6JZbYGGpffwaWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk1JHlZDQ00aHh0eTEpMSE1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a92f5d6271e09cckunm1b345651
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KxA6KRw6TTIZHjo8I0lDCBE1
	Ix5PFBdVSlVKTEhLTEtKSEtMT05DVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUpLTUhPNwY+
DKIM-Signature:a=rsa-sha256;
	b=LNwmbqLqy9e8OFiCIIw0xVOxN4oaruWyYfzIszHydWvOWsI3y6E2fWq2N/8R61Y+Z+EhNH7T5vu4Cn+nXJ+kfCIl5z65hxHY6eWGILGhT46afkViIqj1xy+VQuE/fkHeUhukWNFVTO8fl47EvrynMv0xIr1l9Bbmzd1j0x9i1AI=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=L4J/3IWG/HYqO2bLvK7VYapIuJWoSsnKEAmsrCf4H6Y=;
	h=date:mime-version:subject:message-id:from;

在 2024/11/1 23:12, Ulf Hansson 写道:
> On Mon, 21 Oct 2024 at 02:43, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>
>> 在 2024/10/18 18:03, Ulf Hansson 写道:
>>> On Fri, 18 Oct 2024 at 11:20, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>>>
>>>> Hi Ulf,
>>>>
>>>> 在 2024/10/18 17:07, Ulf Hansson 写道:
>>>>> On Thu, 10 Oct 2024 at 03:21, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>>>>>
>>>>>> Hi Ulf
>>>>>>
>>>>>> 在 2024/10/9 21:15, Ulf Hansson 写道:
>>>>>>> [...]
>>>>>>>
>>>>>>>> +
>>>>>>>> +static int ufs_rockchip_runtime_suspend(struct device *dev)
>>>>>>>> +{
>>>>>>>> +       struct ufs_hba *hba = dev_get_drvdata(dev);
>>>>>>>> +       struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
>>>>>>>> +       struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
>>>>>>>
>>>>>>> pd_to_genpd() isn't safe to use like this. It's solely to be used by
>>>>>>> genpd provider drivers.
>>>>>>>
>>>>>>>> +
>>>>>>>> +       clk_disable_unprepare(host->ref_out_clk);
>>>>>>>> +
>>>>>>>> +       /*
>>>>>>>> +        * Shouldn't power down if rpm_lvl is less than level 5.
>>>>>>>
>>>>>>> Can you elaborate on why we must not power-off the power-domain when
>>>>>>> level is less than 5?
>>>>>>>
>>>>>>
>>>>>> Because ufshcd driver assume the controller is active and the link is on
>>>>>> if level is less than 5. So the default resume policy will not try to
>>>>>> recover the registers until the first error happened. Otherwise if the
>>>>>> level is >=5, it assumes the controller is off and the link is down,
>>>>>> then it will restore the registers and link.
>>>>>>
>>>>>> And the level is changeable via sysfs.
>>>>>
>>>>> Okay, thanks for clarifying.
>>>>>
>>>>>>
>>>>>>> What happens if we power-off anyway when the level is less than 5?
>>>>>>>
>>>>>>>> +        * This flag will be passed down to platform power-domain driver
>>>>>>>> +        * which has the final decision.
>>>>>>>> +        */
>>>>>>>> +       if (hba->rpm_lvl < UFS_PM_LVL_5)
>>>>>>>> +               genpd->flags |= GENPD_FLAG_RPM_ALWAYS_ON;
>>>>>>>> +       else
>>>>>>>> +               genpd->flags &= ~GENPD_FLAG_RPM_ALWAYS_ON;
>>>>>>>
>>>>>>> The genpd->flags is not supposed to be changed like this - and
>>>>>>> especially not from a genpd consumer driver.
>>>>>>>
>>>>>>> I am trying to understand a bit more of the use case here. Let's see
>>>>>>> if that helps me to potentially suggest an alternative approach.
>>>>>>>
>>>>>>
>>>>>> I was not familiar with the genpd part, so I haven't come up with
>>>>>> another solution. It would be great if you can guide me to the right
>>>>>> way.
>>>>>
>>>>> I have been playing with the existing infrastructure we have at hand
>>>>> to support this, but I need a few more days to be able to propose
>>>>> something for you.
>>>>>
>>>>
>>>> Much appreciate.
>>>>
>>>>>>
>>>>>>>> +
>>>>>>>> +       return ufshcd_runtime_suspend(dev);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static int ufs_rockchip_runtime_resume(struct device *dev)
>>>>>>>> +{
>>>>>>>> +       struct ufs_hba *hba = dev_get_drvdata(dev);
>>>>>>>> +       struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
>>>>>>>> +       int err;
>>>>>>>> +
>>>>>>>> +       err = clk_prepare_enable(host->ref_out_clk);
>>>>>>>> +       if (err) {
>>>>>>>> +               dev_err(hba->dev, "failed to enable ref out clock %d\n", err);
>>>>>>>> +               return err;
>>>>>>>> +       }
>>>>>>>> +
>>>>>>>> +       reset_control_assert(host->rst);
>>>>>>>> +       usleep_range(1, 2);
>>>>>>>> +       reset_control_deassert(host->rst);
>>>>>>>> +
>>>>>>>> +       return ufshcd_runtime_resume(dev);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static int ufs_rockchip_system_suspend(struct device *dev)
>>>>>>>> +{
>>>>>>>> +       struct ufs_hba *hba = dev_get_drvdata(dev);
>>>>>>>> +       struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
>>>>>>>> +
>>>>>>>> +       /* Pass down desired spm_lvl to Firmware */
>>>>>>>> +       arm_smccc_smc(ROCKCHIP_SIP_SUSPEND_MODE, ROCKCHIP_SLEEP_PD_CONFIG,
>>>>>>>> +                       host->pd_id, hba->spm_lvl < 5 ? 1 : 0, 0, 0, 0, 0, NULL);
>>>>>>>
>>>>>>> Can you please elaborate on what goes on here? Is this turning off the
>>>>>>> power-domain that the dev is attached to - or what is actually
>>>>>>> happening?
>>>>>>>
>>>>>>
>>>>>> This smc call is trying to ask firmware not to turn off the power-domian
>>>>>> that the UFS is attached to and also not to turn off the power of UFS
>>>>>> conntroller.
>>>>>
>>>>> Okay, thanks for clarifying!
>>>>>
>>>>> A follow up question, don't you need to make a corresponding smc call
>>>>> to inform the FW that it's okay to turn off the power-domain at some
>>>>> point?
>>>>>
>>>>
>>>> Yes. Each time entering sleep, we teach FW if it need to turn off or
>>>> keep power-domain, for instance "hba->spm_lvl < 5 ? 1 : 0" , 0 means
>>>> off and 1 means on.
>>>
>>> I see. So you need to make the call each time when entering the system suspend?
>>>
>>> Or would it be okay to just make it once, when the spm_lvl is changed?
>>
>> Thers is no nofity when changing spm_lvl.
>>
>>>
>>> Another way to deal with it, would be to make the smc call each time
>>> the power-domain is turned-on, based on spm_lvl too of course.
>>>
>>> Would that work?
>>
>> Yes, that works. Another option is to cache power-domain states and
>> check spm_lvl locally. If it doesn't change, we skip smc call.
> 
> Apologize for the delay! I needed to think a bit more carefully about
> how to suggest moving this forward.
> 
> My conclusion is that we need to extend the PM domain infrastructure
> (genpd in particular), to allow drivers to dynamically inform whether
> it's okay to turn on/off the PM domain in runtime.
> 
> There is a similar thing already available, which is to use dev PM qos
> along with the genpd governor, but that would not work in this case
> because it may prevent runtime suspend for the device in question too.
> I have therefore cooked a patch for genpd, see below. I think you can
> fold it into your next version of the series. See also additional
> suggestions below the patch.

Thanks, Ulf.  I'll fold it into my v4 series and fix the code in UFS 
driver and genpd provider according to your suggestions.

> 
> From: Ulf Hansson <ulf.hansson@linaro.org>
> Date: Fri, 1 Nov 2024 15:55:56 +0100
> Subject: [PATCH] pmdomain: core: Introduce dev_pm_genpd_rpm_always_on()
> 
> For some usecases a consumer driver requires its device to remain power-on
> from the PM domain perspective during runtime. Using dev PM qos along with
> the genpd governors, doesn't work for this case as would potentially
> prevent the device from being runtime suspended too.
> 
> To support these usecases, let's introduce dev_pm_genpd_rpm_always_on() to
> allow consumers drivers to dynamically control the behaviour in genpd for a
> device that is attached to it.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>   drivers/pmdomain/core.c   | 34 ++++++++++++++++++++++++++++++++++
>   include/linux/pm_domain.h |  7 +++++++
>   2 files changed, 41 insertions(+)
> 
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index a6c8b85dd024..e86e270b7eb9 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -697,6 +697,36 @@ bool dev_pm_genpd_get_hwmode(struct device *dev)
>   }
>   EXPORT_SYMBOL_GPL(dev_pm_genpd_get_hwmode);
> 
> +/**
> + * dev_pm_genpd_rpm_always_on() - Control if the PM domain can be powered off.
> + *
> + * @dev: Device for which the PM domain may need to stay on for.
> + * @on: Value to set or unset for the condition.
> + *
> + * For some usecases a consumer driver requires its device to remain power-on
> + * from the PM domain perspective during runtime. This function allows the
> + * behaviour to be dynamically controlled for a device attached to a genpd.
> + *
> + * It is assumed that the users guarantee that the genpd wouldn't be detached
> + * while this routine is getting called.
> + *
> + * Return: Returns 0 on success and negative error values on failures.
> + */
> +int dev_pm_genpd_rpm_always_on(struct device *dev, bool on)
> +{
> +       struct generic_pm_domain *genpd;
> +
> +       genpd = dev_to_genpd_safe(dev);
> +       if (!genpd)
> +               return -ENODEV;
> +
> +       genpd_lock(genpd);
> +       dev_gpd_data(dev)->rpm_always_on = on;
> +       genpd_unlock(genpd);
> +
> +       return 0;
> +}
> +
>   static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
>   {
>          unsigned int state_idx = genpd->state_idx;
> @@ -868,6 +898,10 @@ static int genpd_power_off(struct
> generic_pm_domain *genpd, bool one_dev_on,
>                  if (!pm_runtime_suspended(pdd->dev) ||
>                          irq_safe_dev_in_sleep_domain(pdd->dev, genpd))
>                          not_suspended++;
> +
> +               /* The device may need its PM domain to stay powered on. */
> +               if (to_gpd_data(pdd)->rpm_always_on)
> +                       return -EBUSY;
>          }
> 
>          if (not_suspended > 1 || (not_suspended == 1 && !one_dev_on))
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 45646bfcaf1a..d4c4a7cf34bd 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -260,6 +260,7 @@ struct generic_pm_domain_data {
>          unsigned int rpm_pstate;
>          unsigned int opp_token;
>          bool hw_mode;
> +       bool rpm_always_on;
>          void *data;
>   };
> 
> @@ -292,6 +293,7 @@ ktime_t dev_pm_genpd_get_next_hrtimer(struct device *dev);
>   void dev_pm_genpd_synced_poweroff(struct device *dev);
>   int dev_pm_genpd_set_hwmode(struct device *dev, bool enable);
>   bool dev_pm_genpd_get_hwmode(struct device *dev);
> +int dev_pm_genpd_rpm_always_on(struct device *dev, bool on);
> 
>   extern struct dev_power_governor simple_qos_governor;
>   extern struct dev_power_governor pm_domain_always_on_gov;
> @@ -375,6 +377,11 @@ static inline bool dev_pm_genpd_get_hwmode(struct
> device *dev)
>          return false;
>   }
> 
> +static inline int dev_pm_genpd_rpm_always_on(struct device *dev, bool on)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
>   #define simple_qos_governor            (*(struct dev_power_governor *)(NULL))
>   #define pm_domain_always_on_gov                (*(struct
> dev_power_governor *)(NULL))
>   #endif


