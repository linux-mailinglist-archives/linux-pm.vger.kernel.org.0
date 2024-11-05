Return-Path: <linux-pm+bounces-17014-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9719BC56C
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2024 07:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08C531C21225
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2024 06:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A343F1C2324;
	Tue,  5 Nov 2024 06:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="G5vQ+5aY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m1973173.qiye.163.com (mail-m1973173.qiye.163.com [220.197.31.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738462A1A4;
	Tue,  5 Nov 2024 06:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730788225; cv=none; b=L14Kf5PxYcDTNpF+tuK6bQxU173jmebzT0MlkBsEfdVgFR3/znNPi3hIxKbfsoRC+sBIhu6VTXowv6d9LVP9sy+8sTORBQXwlMEa3YzDKSX3iVL/mL/5OyilMsgtJyNXTwt7d8x+1XhIGO0dvVnKYvfoCet0gnSCj4zyK3oXGOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730788225; c=relaxed/simple;
	bh=oNpifOua4/EUNgEbXqNcIgxFeoUKjzgG/ceBaAyFxwk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Xuk5mfynNIk/m7FW7RFsjJdkk1wuhCVWVxjuxS8e8LAe2Z51DDsfK94AQLh2p9n/YD97QUbfcv1G8i7v998qDtPqVkOLzUOBcnHXYwaZu3fe7Tg/+KPLyz0BhGJBljaNA4kRHVJo/97rb4DkATbehv+LAMH41/tAgYoNFcw/hC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=G5vQ+5aY; arc=none smtp.client-ip=220.197.31.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.45] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1ca84001;
	Tue, 5 Nov 2024 09:54:16 +0800 (GMT+08:00)
Message-ID: <7dc6d164-ced4-4c9b-888f-7345e8e52298@rock-chips.com>
Date: Tue, 5 Nov 2024 09:54:16 +0800
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
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>, YiFeng Zhao <zyf@rock-chips.com>,
 Liang Chen <cl@rock-chips.com>, linux-scsi@vger.kernel.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 7/7] scsi: ufs: rockchip: initial support for UFS
To: Ulf Hansson <ulf.hansson@linaro.org>
References: <1730705521-23081-1-git-send-email-shawn.lin@rock-chips.com>
 <1730705521-23081-8-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFrig236e5xTSeOHfNR5Z3840o6u_h7LnoAG2P8Ck348WQ@mail.gmail.com>
Content-Language: en-GB
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <CAPDyKFrig236e5xTSeOHfNR5Z3840o6u_h7LnoAG2P8Ck348WQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ05CTlYaQk4fSkMeTR9NHx9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a92fa07a0ad09cckunm1ca84001
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PzI6NAw6MjIiOD9WLUM3MUMU
	TzAKCStVSlVKTEhLTExKTU5DTU5OVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUhISkk3Bg++
DKIM-Signature:a=rsa-sha256;
	b=G5vQ+5aYDCJavHWVQd2/JQy8pH4pXhGK7lfwRJCut5f7KgZIWvD9qns7F09wkJBKJ617KofBK4ie0DhT4tnet+0w6x1LKYxnXeGUE5jGpSvJXuPiR/Bu0ssR67I9WlqPXdQQCrV/ywqF/X2K5dDgkcTtfhhv6b8qbjSYLJNKsGk=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=Fo3iov3n5PotHG4cT/K2Z9fmQxOkM6kWWia+7CBTW+w=;
	h=date:mime-version:subject:message-id:from;


在 2024/11/4 18:57, Ulf Hansson 写道:
> On Mon, 4 Nov 2024 at 08:34, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>
>> RK3576 SoC contains a UFS controller, add initial support for it.
>> The features are:
>> (1) support UFS 2.0 features
>> (2) High speed up to HS-G3
>> (3) 2RX-2TX lanes
>> (4) auto H8 entry and exit
>>
>> Software limitation:
>> (1) HCE procedure: enable controller->enable intr->dme_reset->dme_enable
>> (2) disable unipro timeout values before power mode change
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>> Changes in v4:
>> - deal with power domain of rpm and spm suggested by Ulf
>> - Fix typo and disable clks in ufs_rockchip_remove
>> - remove clk_disable_unprepare(host->ref_out_clk) from
>>    ufs_rockchip_remove
>>
> 
> [...]
> 
>> +#ifdef CONFIG_PM
>> +static int ufs_rockchip_runtime_suspend(struct device *dev)
>> +{
>> +       struct ufs_hba *hba = dev_get_drvdata(dev);
>> +       struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
>> +
>> +       clk_disable_unprepare(host->ref_out_clk);
>> +
>> +       /* Shouldn't power down if rpm_lvl is less than level 5. */
>> +       dev_pm_genpd_rpm_always_on(dev, hba->rpm_lvl < UFS_PM_LVL_5 ? true : false);
>> +
>> +       return ufshcd_runtime_suspend(dev);
>> +}
>> +
>> +static int ufs_rockchip_runtime_resume(struct device *dev)
>> +{
>> +       struct ufs_hba *hba = dev_get_drvdata(dev);
>> +       struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
>> +       int err;
>> +
>> +       err = clk_prepare_enable(host->ref_out_clk);
>> +       if (err) {
>> +               dev_err(hba->dev, "failed to enable ref out clock %d\n", err);
>> +               return err;
>> +       }
>> +
>> +       reset_control_assert(host->rst);
>> +       usleep_range(1, 2);
>> +       reset_control_deassert(host->rst);
>> +
>> +       return ufshcd_runtime_resume(dev);
>> +}
>> +#endif
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +static int ufs_rockchip_system_suspend(struct device *dev)
>> +{
>> +       struct ufs_hba *hba = dev_get_drvdata(dev);
>> +
>> +       if (hba->spm_lvl < 5)
>> +               device_set_wakeup_path(dev);
> 
> Please use device_set_awake_path() instead.
> 
> Ideally all users of device_set_wakeup_path() should convert into
> device_set_awake_path(), it's just that we haven't been able to
> complete the conversion yet.

Will use device_set_awake_path().

> 
>> +       else
>> +               device_clr_wakeup_path(dev);
> 
> This isn't needed. The flag is getting cleared in device_prepare().
> 
>> +
>> +       return ufshcd_system_suspend(dev);
> 
> Don't you want to disable the clock during system suspend too? If the
> device is runtime resumed at this point, the clock will be left
> enabled, no?

Good point. Will fix it.

> 
>> +}
>> +#endif
>> +
>> +static const struct dev_pm_ops ufs_rockchip_pm_ops = {
>> +       SET_SYSTEM_SLEEP_PM_OPS(ufs_rockchip_system_suspend, ufshcd_system_resume)
>> +       SET_RUNTIME_PM_OPS(ufs_rockchip_runtime_suspend, ufs_rockchip_runtime_resume, NULL)
>> +       .prepare         = ufshcd_suspend_prepare,
>> +       .complete        = ufshcd_resume_complete,
>> +};
>> +
> 
> [...]
> 
> Kind regards
> Uffe
> 


