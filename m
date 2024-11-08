Return-Path: <linux-pm+bounces-17165-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1359C13BB
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 02:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36C53B211CD
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 01:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E3612E7E;
	Fri,  8 Nov 2024 01:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="caDQOPOq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m607.netease.com (mail-m607.netease.com [210.79.60.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773E7DDC3;
	Fri,  8 Nov 2024 01:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.79.60.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731030001; cv=none; b=IAi8c0q42iZICWN2j5tTT1jVo0VL26ZFWsSBVspJ0fbpDQuWxNuZzfocoFvv97WpGJjG0OgYdr2ow9dyCGT0Dfzsulg6/YIpQladUhGRLcAFd5Uwe9lwDOspOJhpaVOwJB3PBttaJY+3rJr6NaEPP50zQqpnE7qQKO7dFgmH6eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731030001; c=relaxed/simple;
	bh=5EONU/ePBboZ737bsck6tYVlh4j/04wwwwK+5lNFwlE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d/897TqVFMq23bcqLrJbfzP3ckMth8B3TdS6Wt5eQ8PogxWW5oHMghCavSVpOxCBD1gM7rsGzv8r/pa3JpZc4f4MomlW9Py2fs0RqQZavXHSW+AkbbJNm/3H9pt/fXrBsezB+8jifQM0ROTE8o4IdR2T+rrdAQBi2EQYJkJV0hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=caDQOPOq; arc=none smtp.client-ip=210.79.60.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.45] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 222b801f;
	Fri, 8 Nov 2024 09:04:18 +0800 (GMT+08:00)
Message-ID: <a65a8ec4-9b75-493a-961c-7b570dd834b5@rock-chips.com>
Date: Fri, 8 Nov 2024 09:04:19 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Rob Herring <robh+dt@kernel.org>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Heiko Stuebner <heiko@sntech.de>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>, YiFeng Zhao <zyf@rock-chips.com>,
 Liang Chen <cl@rock-chips.com>, linux-scsi@vger.kernel.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 1/7] scsi: ufs: core: Add
 UFSHCI_QUIRK_DME_RESET_ENABLE_AFTER_HCE
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <1730705521-23081-1-git-send-email-shawn.lin@rock-chips.com>
 <1730705521-23081-2-git-send-email-shawn.lin@rock-chips.com>
 <20241107155128.paqyo7een2ggzejs@thinkpad>
Content-Language: en-GB
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20241107155128.paqyo7een2ggzejs@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ05CSVZDQ0hOS00dSx1KGEhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a93094cf63309cckunm222b801f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NRA6DSo*KjIiKDQfCgENPCoI
	TggaFAhVSlVKTEhKS0lMQ01LTU9NVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUhLS0I3Bg++
DKIM-Signature:a=rsa-sha256;
	b=caDQOPOqYhwi2ZXxVysG81TPPpMKkpTk3KK6/IvlXq2IRkjMK6XSEEWzC9O7NJeY0qeV8EejJ0RnOa0FT3ycYpYPNbFQ2zzs+L+n/Qy49QWCJINP9ijli4ZtIVb4PgesulGI73aUSP8xyjPuSb8hkbwXyZn6T5vfKkBMEOxE7V4=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=Kza4I0HzRT2xsTR4YzkXyNx0h5y2MmaFHxdi3ivQ7So=;
	h=date:mime-version:subject:message-id:from;

Hi Mani,

在 2024/11/7 23:51, Manivannan Sadhasivam 写道:
> On Mon, Nov 04, 2024 at 03:31:55PM +0800, Shawn Lin wrote:
>> HCE on Rockchip SoC is different from both of ufshcd_hba_execute_hce()
>> and UFSHCI_QUIRK_BROKEN_HCE case. It need to do dme_reset and dme_enable
>> after enabling HCE. So in order not to abuse UFSHCI_QUIRK_BROKEN_HCE, add
>> a new quirk UFSHCI_QUIRK_DME_RESET_ENABLE_AFTER_HCE, to deal with that
>> limitation.
>>
>> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>> Changes in v4:
>> - fix typo
>>
>> Changes in v3: None
>> Changes in v2: None
>>
>>   drivers/ufs/core/ufshcd.c | 17 +++++++++++++++++
>>   include/ufs/ufshcd.h      |  6 ++++++
>>   2 files changed, 23 insertions(+)
>>
>> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
>> index 7cab1031..4084bf9 100644
>> --- a/drivers/ufs/core/ufshcd.c
>> +++ b/drivers/ufs/core/ufshcd.c
>> @@ -4819,6 +4819,7 @@ static int ufshcd_hba_execute_hce(struct ufs_hba *hba)
>>   {
>>   	int retry_outer = 3;
>>   	int retry_inner;
>> +	int ret;
>>   
>>   start:
>>   	if (ufshcd_is_hba_active(hba))
>> @@ -4865,6 +4866,22 @@ static int ufshcd_hba_execute_hce(struct ufs_hba *hba)
>>   	/* enable UIC related interrupts */
>>   	ufshcd_enable_intr(hba, UFSHCD_UIC_MASK);
>>   
>> +	/*
>> +	 * Do dme_reset and dme_enable if a UFS host controller needs
>> +	 * this procedure to actually finish HCE.
>> +	 */
>> +	if (hba->quirks & UFSHCI_QUIRK_DME_RESET_ENABLE_AFTER_HCE) {
>> +		ret = ufshcd_dme_reset(hba);
>> +		if (!ret) {
>> +			ret = ufshcd_dme_enable(hba);
>> +			if (ret)
>> +				dev_err(hba->dev,
>> +					"Failed to do dme_enable after HCE.\n");
> 
> Don't you need to return failure for this and below error paths? Probably you
> need to skip post change notification as well in the case of failure.

Oops, my bad.

> 
>> +		} else {
>> +			dev_err(hba->dev, "Failed to do dme_reset after HCE.\n");
>> +		}
>> +	}
>> +
>>   	ufshcd_vops_hce_enable_notify(hba, POST_CHANGE);
> 
> Is it possible for you to carry out dme_reset() and dme_enable() in the post
> change notifier of the rockchip glue driver? I'm trying to see if we can avoid
> having the quirk which is only specific to Rockchip.
> 

I will check and test this approach. Thanks.

> - Mani
> 
>>   
>>   	return 0;
>> diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
>> index a95282b..e939af8 100644
>> --- a/include/ufs/ufshcd.h
>> +++ b/include/ufs/ufshcd.h
>> @@ -685,6 +685,12 @@ enum ufshcd_quirks {
>>   	 * single doorbell mode.
>>   	 */
>>   	UFSHCD_QUIRK_BROKEN_LSDBS_CAP			= 1 << 25,
>> +
>> +	/*
>> +	 * This quirk needs to be enabled if host controller need to
>> +	 * do dme_reset and dme_enable after hce.
>> +	 */
>> +	UFSHCI_QUIRK_DME_RESET_ENABLE_AFTER_HCE		= 1 << 26,
>>   };
>>   
>>   enum ufshcd_caps {
>> -- 
>> 2.7.4
>>
> 


