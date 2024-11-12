Return-Path: <linux-pm+bounces-17380-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8259C4F6D
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 08:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9063D2844B7
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 07:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD8B1BF58;
	Tue, 12 Nov 2024 07:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Jm6+WYQi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m25494.xmail.ntesmail.com (mail-m25494.xmail.ntesmail.com [103.129.254.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4D920A5D9;
	Tue, 12 Nov 2024 07:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.129.254.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731396415; cv=none; b=bkO6auaZ0atNxcfBhmlVgF96gAGN/kplbdqGNh1YoVmUFvxGLX/c3oO960kFwBvdAEoe8VVe8wVUXxL2b8meQiqr72cchNwfCrquBqP14n6sGt3UJ4xqfB2af3pBmt6nLfR5fPmVGfwT0fFeDd6irX/zOFPly5uX4B+wWuN0gDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731396415; c=relaxed/simple;
	bh=VDMekBFW5N4cn9EpGIxb79p4WX0+rU7nRloo1tKyqkk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Vh0ubi3fdRNGdigDJCI7a5+/fbg/ZkZ7+LQ8xS9yLUiHpYLDLoLRWJecBPMckQvcJlSma56in9TwXn2H/VAuDGYn9f87hzG063OZz/Nz1Pgsklm1ovJd+uyHArppP+CSX7udio2IfhgFuaTG4y9XKXKDCh1u3+6DPib/OHT+pP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Jm6+WYQi; arc=none smtp.client-ip=103.129.254.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.45] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 27ec4bcb;
	Tue, 12 Nov 2024 14:51:22 +0800 (GMT+08:00)
Message-ID: <67dc87c0-d963-4827-8da8-9b4f4b579a0d@rock-chips.com>
Date: Tue, 12 Nov 2024 14:51:22 +0800
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
Subject: Re: [PATCH v4 7/7] scsi: ufs: rockchip: initial support for UFS
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <1730705521-23081-1-git-send-email-shawn.lin@rock-chips.com>
 <1730705521-23081-8-git-send-email-shawn.lin@rock-chips.com>
 <20241109121249.vncqbacvpnpf6d34@thinkpad>
 <13ad21bb-9f5a-4a4b-8b65-55243f6fe817@rock-chips.com>
 <20241112064354.g634ca5w2gagfyko@thinkpad>
Content-Language: en-GB
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20241112064354.g634ca5w2gagfyko@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR4dSVZJSxkYT05ITk8fGE9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a931f2423e109cckunm27ec4bcb
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OTI6Pww5OTIeMBkDMx4QAREU
	H0swFEtVSlVKTEhKSEJPSUNPSk5MVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUJJQzcG
DKIM-Signature:a=rsa-sha256;
	b=Jm6+WYQihaExmuzwzQSBDbD2+vhMxKDsyzJ53n1wyopYRaO8YqDi6PohavebXpmDDpyMuKAe6kh4oFl0yTQC5IOwCe1LJ4TjcmP+Y/IpyKPNpu7Eht5mMDyaLEftv3uXDwCBhPr2P+P1Ar2/4sTozkDGFB1ieibUrOqSYNBxkj4=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=7DvZ0EaaGDr971+oClLMaAcgcjY9xXaBYV/7GJSzEYg=;
	h=date:mime-version:subject:message-id:from;

在 2024/11/12 14:43, Manivannan Sadhasivam 写道:
> On Mon, Nov 11, 2024 at 09:10:39AM +0800, Shawn Lin wrote:
> 
> [...]
> 
>>>> +static void ufs_rockchip_remove(struct platform_device *pdev)
>>>> +{
>>>> +	struct ufs_hba *hba = platform_get_drvdata(pdev);
>>>> +	struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
>>>> +
>>>> +	pm_runtime_forbid(&pdev->dev);
>>>> +	pm_runtime_get_noresume(&pdev->dev);
>>>
>>> Why do you need these? You are not incrementing the refcount in probe() and
>>> there is no auto PM involved.
>>
>> Oh, it was a leftover from former version I haven't noticed. Will
>> remove.
>>
> 
> I've sent a series [1] that addresses the runtime PM issues. Could you please
> give it a try and give your tested-by maybe?

Sure, I will give it a try, thanks.

> 
> - Mani
> 
> [1] https://lore.kernel.org/linux-scsi/20241111-ufs_bug_fix-v1-0-45ad8b62f02e@linaro.org/
> 


