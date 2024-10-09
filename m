Return-Path: <linux-pm+bounces-15393-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2316A99693D
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 13:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADCFA288185
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 11:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF30192B99;
	Wed,  9 Oct 2024 11:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNcGUxTn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A81192B89;
	Wed,  9 Oct 2024 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728474629; cv=none; b=pf/kJ5pWx70+jvpcg1o1+usBNmfdoj8Xubj0sD0Nh6ti1A6jZIVUCMee1r0cPHwrB1MWaYVBAm/dKsnwA7p9i4/eIWBpYCmdrD4nHrSInrwqZdnOY4r0XgGOnO36NIEXW4S1axr+2OHR/gYebXcO+lDNRqpzEalKECGdZA3YKac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728474629; c=relaxed/simple;
	bh=dGswqfuoU6DO4cYJ0FthosnuJrBUDxI3B2K+sH8atgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VHcsslyROgrUVRsdmb9e/5yLnjdyMWNnfWB/zAP61KSiOqg6m3zyp8yQtisrRXLezyBmXdtZDAv/qHvjg2AMlziqNvIxynq53cJu1zynBNUrZpfkcQc0VtK0j/q2x8itWng2dQ52PteAKw3FM6JwXQA5vFS+j9JKmfDyohhMZik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNcGUxTn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393FEC4CECD;
	Wed,  9 Oct 2024 11:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728474628;
	bh=dGswqfuoU6DO4cYJ0FthosnuJrBUDxI3B2K+sH8atgU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NNcGUxTnIb8XVByvRuL/z1me0iaECCZ1AuAjulMjZi5tIH7ke7OTJcBcW9gq8nHNY
	 kniriD0uu+01d8c7uXWWutmOZnNqKwJFZerW7epQuseaVHibz2w4W9l41ZhrTExYSz
	 AxFPVD7cv3KmZp/0j11lKyOPTaklnt1Z121qzcdOOlwMWCvnVd4UX22rpbAc7gT5fL
	 1XGFt8UTQ9FP2jkX91BVvXuKmpM+xujG7FnJlcErHLce0NwrBQa+O8ALon4wTPB9OE
	 tgCl8DWWfRsQOSucL1aK0sFFKdADv6BghCwWRCqxBNm6tZBJd0m0sBH+qSq6SNX7mL
	 jTtrb4lJKmzMQ==
Message-ID: <ebe0b4dd-0603-4ef5-8007-d0a768561e95@kernel.org>
Date: Wed, 9 Oct 2024 14:50:22 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: core: Fix system suspend on TI AM62 platforms
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>,
 Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 Dhruva Gole <d-gole@ti.com>, Vishal Mahaveer <vishalm@ti.com>,
 "msp@baylibre.com" <msp@baylibre.com>, "srk@ti.com" <srk@ti.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20241001-am62-lpm-usb-v1-1-9916b71165f7@kernel.org>
 <20241005010355.zyb54bbqjmpdjnce@synopsys.com>
 <85f1805b-e4c8-48c4-8e99-c36d20182a13@kernel.org>
 <20241008205315.64cxff22uckoich5@synopsys.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241008205315.64cxff22uckoich5@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 08/10/2024 23:53, Thinh Nguyen wrote:
> Hi Roger,
> 
> On Tue, Oct 08, 2024, Roger Quadros wrote:
>> Hi Thinh,
>>
>> On 05/10/2024 04:04, Thinh Nguyen wrote:
>>> Hi,
>>>
>>> On Tue, Oct 01, 2024, Roger Quadros wrote:
>>>> Since commit 6d735722063a ("usb: dwc3: core: Prevent phy suspend during init"),
>>>> system suspend is broken on AM62 TI platforms.
>>>>
>>>> Before that commit, both DWC3_GUSB3PIPECTL_SUSPHY and DWC3_GUSB2PHYCFG_SUSPHY
>>>> bits (hence forth called 2 SUSPHY bits) were being set during core
>>>> initialization and even during core re-initialization after a system
>>>> suspend/resume.
>>>>
>>>> These bits are required to be set for system suspend/resume to work correctly
>>>> on AM62 platforms.
>>>>
>>>> Since that commit, the 2 SUSPHY bits are not set for DEVICE/OTG mode if gadget
>>>> driver is not loaded and started.
>>>> For Host mode, the 2 SUSPHY bits are set before the first system suspend but
>>>> get cleared at system resume during core re-init and are never set again.
>>>>
>>>> This patch resovles these two issues by ensuring the 2 SUSPHY bits are set
>>>> before system suspend and restored to the original state during system resume.
>>>>
>>>> Cc: stable@vger.kernel.org # v6.9+
>>>> Fixes: 6d735722063a ("usb: dwc3: core: Prevent phy suspend during init")
>>>> Link: https://urldefense.com/v3/__https://lore.kernel.org/all/1519dbe7-73b6-4afc-bfe3-23f4f75d772f@kernel.org/__;!!A4F2R9G_pg!ahChm4MaKd6VGYqbnM4X1_pY_jqavYDv5HvPFbmicKuhvFsBwlEFi1xO5itGuHmfjbRuUSzReJISf5-1gXpr$ 
>>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>>>> ---
>>>>  drivers/usb/dwc3/core.c | 16 ++++++++++++++++
>>>>  drivers/usb/dwc3/core.h |  2 ++
>>>>  2 files changed, 18 insertions(+)
>>>>
>>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>>> index 9eb085f359ce..1233922d4d54 100644
>>>> --- a/drivers/usb/dwc3/core.c
>>>> +++ b/drivers/usb/dwc3/core.c
>>>> @@ -2336,6 +2336,9 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>>>>  	u32 reg;
>>>>  	int i;
>>>>  
>>>> +	dwc->susphy_state = !!(dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0)) &
>>>> +			    DWC3_GUSB2PHYCFG_SUSPHY);
>>>> +
>>>>  	switch (dwc->current_dr_role) {
>>>>  	case DWC3_GCTL_PRTCAP_DEVICE:
>>>>  		if (pm_runtime_suspended(dwc->dev))
>>>> @@ -2387,6 +2390,11 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>>>>  		break;
>>>>  	}
>>>>  
>>>> +	if (!PMSG_IS_AUTO(msg)) {
>>>> +		if (!dwc->susphy_state)
>>>> +			dwc3_enable_susphy(dwc, true);
>>>> +	}
>>>> +
>>>>  	return 0;
>>>>  }
>>>>  
>>>> @@ -2454,6 +2462,14 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
>>>>  		break;
>>>>  	}
>>>>  
>>>> +	if (!PMSG_IS_AUTO(msg)) {
>>>> +		/* dwc3_core_init_for_resume() disables SUSPHY so just handle
>>>> +		 * the enable case
>>>> +		 */
>>>
>>> Can we note that this is a particular behavior needed for AM62 here?
>>> And can we use this comment style:
>>
>> Looking at this again, this fix is not specific to AM62 but for all platforms.
>> e.g. if Host Role was already started when going to system suspend, SUSPHY bits
>> were enabled, then after system resume SUSPHY bits are cleared at dwc3_core_init_for_resume().
>>
>> Host stop/start was not called so SUSPHY bits remain cleared. So here
>> we deal with enabling SUSPHY.
>>
> 
> It's true that we have a bug where the SUSPHY bits remain disabled after
> suspend. However, the SUSPHY bits needing to be set during suspend is
> unique to AM62. Let's add this note in the dwc3_suspend_common() check.

Yes I will do that. Thanks!

-- 
cheers,
-roger

