Return-Path: <linux-pm+bounces-22223-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFBAA38A5E
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 18:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9A71894BF7
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 17:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AB42288DA;
	Mon, 17 Feb 2025 17:10:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7E321A421;
	Mon, 17 Feb 2025 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739812241; cv=none; b=esmCWSnU4syrhf5bpNCFNgTFtZG0fi4v4UMcX5ZauC1nIjepV2iJGUGyxqpi/PD+M9NtlPFR1x48YPaHcrlIFUfZCeUSaBZ32hvo9lYiP7G00F8puOO8thP40BP19hqUfdie2el1TFDftteBf3x5vl8qoFmzM24DsWjgt/WxEgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739812241; c=relaxed/simple;
	bh=0+01KA7K2Nk/glEH3Wbcih7aJcSpkuWTCeB52iqLzPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f+h3oBOyNVD+PounkwIdqqRiKBRdidcgrAv1DQjL3/9LbadGGNHGs+TkiYONrNlQi4IaOwQuvMArniczoOoeKg+xTqlxxOovonzecRvOYt5UlbzhhnhRnykBwwjn3Sc0joMrWAWSD64Do5y2Aw97cVX2Qxq8cF6ntdCnrt5sP8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 820E0152B;
	Mon, 17 Feb 2025 09:10:57 -0800 (PST)
Received: from [10.1.27.38] (e122027.cambridge.arm.com [10.1.27.38])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A530C3F5A1;
	Mon, 17 Feb 2025 09:10:34 -0800 (PST)
Message-ID: <321804ef-f852-47cf-afd7-723666ec8f62@arm.com>
Date: Mon, 17 Feb 2025 17:10:32 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/7] pmdomain: rockchip: Add smc call to inform
 firmware
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Shawn Lin <shawn.lin@rock-chips.com>, Rob Herring <robh+dt@kernel.org>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>, YiFeng Zhao <zyf@rock-chips.com>,
 Liang Chen <cl@rock-chips.com>, linux-scsi@vger.kernel.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <1738736156-119203-1-git-send-email-shawn.lin@rock-chips.com>
 <1738736156-119203-5-git-send-email-shawn.lin@rock-chips.com>
 <d543a0a7-8e14-483a-bc2b-783dc3aa33e2@arm.com> <2579724.BzM5BlMlMQ@diego>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <2579724.BzM5BlMlMQ@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/02/2025 15:16, Heiko Stübner wrote:
> Hi Steven,
> 
> Am Montag, 17. Februar 2025, 15:47:21 MEZ schrieb Steven Price:
>> On 05/02/2025 06:15, Shawn Lin wrote:
>>> Inform firmware to keep the power domain on or off.
>>>
>>> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>> ---
>>
>> This patch is causing my Firefly RK3288 to fail to boot, it hangs 
>> shortly after reaching user space, but the bootup messages include the 
>> suspicious line "Bad mode in prefetch abort handler detected".
>> I suspect the firmware on this board doesn't support this new SMC 
>> correctly. Reverting this patch on top of linux-next gets everything 
>> working again.
> 
> Is your board actually running some trusted firmware?

Not as far as I know.

> Stock rk3288 never had tf-a / psci [0], I did work on that for a while,
> but don't think that ever took off.
> 
> I'm wondering who the smcc call is calling, but don't know about
> about smcc stuff.

Good question - it's quite possible things are blowing up just because
there's nothing there to handle the SMC. My DTB is as upstream:

        cpus {
                #address-cells = <0x01>;
                #size-cells = <0x00>;
                enable-method = "rockchip,rk3066-smp";
                rockchip,pmu = <0x06>;

I haven't investigated why this code is attempting to call an SMC on
this board.

Steve

> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/rockchip/rk3288.dtsi#n63
> 
> 

