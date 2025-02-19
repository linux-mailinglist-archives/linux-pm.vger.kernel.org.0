Return-Path: <linux-pm+bounces-22373-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F15FA3AE8B
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 02:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BBEF18862E2
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 01:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB85AD21;
	Wed, 19 Feb 2025 01:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="OBVW2tm2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m3279.qiye.163.com (mail-m3279.qiye.163.com [220.197.32.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC1D33E1;
	Wed, 19 Feb 2025 01:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739927133; cv=none; b=udm06ttRtWhRg36Sg+4zKy5yjQdlMJWHlcnM0DW2MeP6Du8MIerPn84NeofG0DGvTYkfW8sFCar9dgJ2C7GXk88F4XK67rOngb2QBg80waaCJTPoL7290lIMHiZUcX/l62cbMKDYGLYv4PJ0XNWWycpOF2IsUepmjxhM3X3oZD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739927133; c=relaxed/simple;
	bh=h3IzD/EHTG/NJHMkaP8YtEwiHh5YJphg8SLZRWk/1mI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=o5hGLvk7fLnd1K1xO/4ywxbOrSCr5Jk3+EieVTis4ND7hbLTUF3DGNaAo35baJFQf9Qz+lAzaS+8QMwoSqiBgsgKcr2KKbfViHzTFuWZypxfw7Y19DVSLOjWgU/edAc7IZ7VklxpEoSSDCFfKtgoJ8CBFdBsPOSAc4FVr24UgEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=OBVW2tm2; arc=none smtp.client-ip=220.197.32.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.45] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id b77902a0;
	Wed, 19 Feb 2025 09:00:17 +0800 (GMT+08:00)
Message-ID: <08a7b3ab-3e2d-4d69-8f8d-4dbd5a26fd3e@rock-chips.com>
Date: Wed, 19 Feb 2025 09:00:17 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Steven Price <steven.price@arm.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>, YiFeng Zhao <zyf@rock-chips.com>,
 Liang Chen <cl@rock-chips.com>, linux-scsi@vger.kernel.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, "Martin K . Petersen" <martin.petersen@oracle.com>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v7 4/7] pmdomain: rockchip: Add smc call to inform
 firmware
To: Ulf Hansson <ulf.hansson@linaro.org>
References: <1738736156-119203-1-git-send-email-shawn.lin@rock-chips.com>
 <2579724.BzM5BlMlMQ@diego> <321804ef-f852-47cf-afd7-723666ec8f62@arm.com>
 <5649637.F8r316W7xa@diego>
 <fa184920-e1f5-4eee-894a-f617e6d8e817@rock-chips.com>
 <CAPDyKFqPZcQOqEbyfy8uC-SO8vx1f=Ck-fPSqvXqiS1H-JJsrA@mail.gmail.com>
Content-Language: en-GB
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <CAPDyKFqPZcQOqEbyfy8uC-SO8vx1f=Ck-fPSqvXqiS1H-JJsrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk5JQlZOHkgfQkhITk5CSRpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a951bb84ac409cckunmb77902a0
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NTI6DBw4OTIQESoINR9KLz1R
	LTQwFExVSlVKTEhCQklNQ0pCT0tLVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUhKSE83Bg++
DKIM-Signature:a=rsa-sha256;
	b=OBVW2tm2D14VPgSiPRBJ/M2WRg/7HyhOBYNUlzM54xUxZ0kavmmKUKojM8uWWCsCC2smCjEROfQSp+zvSwGJLRg9jNoVoN5FewFncUgkz1LMzBIa09sBRbUzL5AXQOD9EwwPWfoBEW7hLSvuGJW/R+nBMI4ydsZOpALPlbud8RE=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=/2XJbqtRuXbaGBHrU7SLlVzjvIwfrBq5BanTrFmG6AU=;
	h=date:mime-version:subject:message-id:from;

在 2025/2/18 19:05, Ulf Hansson 写道:
> On Tue, 18 Feb 2025 at 01:53, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>
>> Hi Heiko, Steven
>>
>> 在 2025/2/18 4:50, Heiko Stübner 写道:
>>> Am Montag, 17. Februar 2025, 18:10:32 MEZ schrieb Steven Price:
>>>> On 17/02/2025 15:16, Heiko Stübner wrote:
>>>>> Hi Steven,
>>>>>
>>>>> Am Montag, 17. Februar 2025, 15:47:21 MEZ schrieb Steven Price:
>>>>>> On 05/02/2025 06:15, Shawn Lin wrote:
>>>>>>> Inform firmware to keep the power domain on or off.
>>>>>>>
>>>>>>> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>>>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>>>>>> ---
>>>>>>
>>>>>> This patch is causing my Firefly RK3288 to fail to boot, it hangs
>>>>>> shortly after reaching user space, but the bootup messages include the
>>>>>> suspicious line "Bad mode in prefetch abort handler detected".
>>>>>> I suspect the firmware on this board doesn't support this new SMC
>>>>>> correctly. Reverting this patch on top of linux-next gets everything
>>>>>> working again.
>>>>>
>>>>> Is your board actually running some trusted firmware?
>>>>
>>>> Not as far as I know.
>>>>
>>>>> Stock rk3288 never had tf-a / psci [0], I did work on that for a while,
>>>>> but don't think that ever took off.
>>>>>
>>>>> I'm wondering who the smcc call is calling, but don't know about
>>>>> about smcc stuff.
>>>>
>>>> Good question - it's quite possible things are blowing up just because
>>>> there's nothing there to handle the SMC. My DTB is as upstream:
>>>>
>>>>           cpus {
>>>>                   #address-cells = <0x01>;
>>>>                   #size-cells = <0x00>;
>>>>                   enable-method = "rockchip,rk3066-smp";
>>>>                   rockchip,pmu = <0x06>;
>>>>
>>>> I haven't investigated why this code is attempting to call an SMC on
>>>> this board.
>>>
>>> I guess the why is easy, something to do with suspend :-) .
>>>
>>> I did go testing a bit, booting a rk3288-veyron produces the same issue
>>> you saw, likely due to the non-existent trusted-firmware.
>>>
>>> On the arm64-side, I tried a plethora of socs + tfa-versions,
>>>
>>>     rk3328: v2.5 upstream(?)-tf-a
>>>     rk3399: v2.9 upstream-tf-a
>>>     px30: v2.4+v2.9 upstream-tf-a
>>>     rk3568: v2.3 vendor-tf-a
>>>     rk3588: v2.3 vendor-tf-a
>>>
>>> and all ran just fine.
>>> So it really looks like the smcc call going to some unset location is
>>> the culprit.
>>>
>>> Looking at other users of arm_smcc_smc, most of them seem to be handled
>>> unguarded, but some older(?) arm32 boards actually check their DTs for an
>>> optee node before trying their smc-call.
>>>
>>> I guess in the pm-domain case, we could just wrap the call with:
>>>        if(arm_smccc_1_1_get_conduit() != SMCCC_CONDUIT_NONE)
>>>
>>
>> Thanks for the report and helping find out the cause!
>>
>> @Ulf, if the solution above seems reasonable to you, I can cook a fix-up
>> patch.
> 
> Seems reasonable to me, thanks!

Thanks Ulf, I have sent a individual fix-up patch.

> 
> [...]
> 
> Kind regards
> Uffe
> 


