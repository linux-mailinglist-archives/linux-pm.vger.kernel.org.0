Return-Path: <linux-pm+bounces-15260-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B001A992A8D
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 13:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB7B1F215DD
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 11:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9691D1E96;
	Mon,  7 Oct 2024 11:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4lTXEaF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF915199235;
	Mon,  7 Oct 2024 11:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728301483; cv=none; b=QzwtzfPyIZ+LTt/6Pg1Xde8erCnLkYFmekTiupyAGN/SQ9ur0pZSCHx3/u1S2iwNf3r5ysLstl2y+JbjnNT7pzSgzpNwhfs17fRskRXjrdaaWUly0JHsRVSzoYHVzpm6FSvHkjuzNtAX99Cozn54sg8axf/L7uGa9OZFycOHKIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728301483; c=relaxed/simple;
	bh=BdagRc9kDm8QW5L4yx71h6tv7jwW8Ojd8Q3cbF5c6CU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gs31NWBukt6brdmIguYCBhObZgSQpMofGflXlt4J0TBYIPRjcfpAUjsf0GbJklWZmp75kvSVWcq4f7rbSCg7LVnXJTNrrTTfS3vytIWu88iSritNedfZXnqbSUqYSGv515+meTE/WVvIIOJf+CvTnvQ40J6QAiaFm0EuoYlHdEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4lTXEaF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27D7C4CEC6;
	Mon,  7 Oct 2024 11:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728301482;
	bh=BdagRc9kDm8QW5L4yx71h6tv7jwW8Ojd8Q3cbF5c6CU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p4lTXEaFcv2P0OnXd5GZOTtWQLLF+wfcvWE0on94SJrz+Sn2Yzoc05REKGvvsLA+2
	 U6jk9UL9xpE0OTLvMPvpOmMgOAHGGAwwo6GL4GqK8UlMOiSbZ1lxYomsaXLqiJCic0
	 rRUKVHX+ua1Fz1HIn7rryFLRP/+jnCJ7YfKrEMrl7OJQjJo/eLdG5pr5xjb4XFygur
	 gk3o0GNq8o4aukr0tIt+k/nSrBF+dUOVtc/GHSwelRzSplndQgqnUyklBsH65EQSmm
	 jIb1QJ0yg4HpclchjPUmDrXyD6rbf1vVIHX3Tnyh/fSvRGIufkvDHRLI4FhaBHGuM4
	 uWWLQVAcrZAxA==
Message-ID: <5e6bb315-7896-4e63-86aa-1a219b7a7fb3@kernel.org>
Date: Mon, 7 Oct 2024 14:44:35 +0300
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
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241005010355.zyb54bbqjmpdjnce@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 05/10/2024 04:04, Thinh Nguyen wrote:
> Hi,
> 
> On Tue, Oct 01, 2024, Roger Quadros wrote:
>> Since commit 6d735722063a ("usb: dwc3: core: Prevent phy suspend during init"),
>> system suspend is broken on AM62 TI platforms.
>>
>> Before that commit, both DWC3_GUSB3PIPECTL_SUSPHY and DWC3_GUSB2PHYCFG_SUSPHY
>> bits (hence forth called 2 SUSPHY bits) were being set during core
>> initialization and even during core re-initialization after a system
>> suspend/resume.
>>
>> These bits are required to be set for system suspend/resume to work correctly
>> on AM62 platforms.
>>
>> Since that commit, the 2 SUSPHY bits are not set for DEVICE/OTG mode if gadget
>> driver is not loaded and started.
>> For Host mode, the 2 SUSPHY bits are set before the first system suspend but
>> get cleared at system resume during core re-init and are never set again.
>>
>> This patch resovles these two issues by ensuring the 2 SUSPHY bits are set
>> before system suspend and restored to the original state during system resume.
>>
>> Cc: stable@vger.kernel.org # v6.9+
>> Fixes: 6d735722063a ("usb: dwc3: core: Prevent phy suspend during init")
>> Link: https://urldefense.com/v3/__https://lore.kernel.org/all/1519dbe7-73b6-4afc-bfe3-23f4f75d772f@kernel.org/__;!!A4F2R9G_pg!ahChm4MaKd6VGYqbnM4X1_pY_jqavYDv5HvPFbmicKuhvFsBwlEFi1xO5itGuHmfjbRuUSzReJISf5-1gXpr$ 
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  drivers/usb/dwc3/core.c | 16 ++++++++++++++++
>>  drivers/usb/dwc3/core.h |  2 ++
>>  2 files changed, 18 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 9eb085f359ce..1233922d4d54 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -2336,6 +2336,9 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>>  	u32 reg;
>>  	int i;
>>  
>> +	dwc->susphy_state = !!(dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0)) &
>> +			    DWC3_GUSB2PHYCFG_SUSPHY);
>> +
>>  	switch (dwc->current_dr_role) {
>>  	case DWC3_GCTL_PRTCAP_DEVICE:
>>  		if (pm_runtime_suspended(dwc->dev))
>> @@ -2387,6 +2390,11 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>>  		break;
>>  	}
>>  
>> +	if (!PMSG_IS_AUTO(msg)) {
>> +		if (!dwc->susphy_state)
>> +			dwc3_enable_susphy(dwc, true);
>> +	}
>> +
>>  	return 0;
>>  }
>>  
>> @@ -2454,6 +2462,14 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
>>  		break;
>>  	}
>>  
>> +	if (!PMSG_IS_AUTO(msg)) {
>> +		/* dwc3_core_init_for_resume() disables SUSPHY so just handle
>> +		 * the enable case
>> +		 */
> 
> Can we note that this is a particular behavior needed for AM62 here?
> And can we use this comment style:
> 
> /*
>  * xxxxx
>  * xxxxx
>  */

OK.

> 
> 
>> +		if (dwc->susphy_state)
> 
> Shouldn't we check for if (!dwc->susphy_state) and clear the susphy
> bits?

In that case it would have already been cleared so no need to check
and clear again.

> 
>> +			dwc3_enable_susphy(dwc, true);
> 
> The dwc3_enable_susphy() set and clear both GUSB3PIPECTL_SUSPHY and
> GUSB2PHYCFG_SUSPHY, perhaps we should split that function out so we can
> only need to set for GUSB2PHYCFG_SUSPHY since you only track for that.

As  dwc3_enable_susphy() sets and clears both GUSB3PIPECTL_SUSPHY and
GUSB2PHYCFG_SUSPHY together it doesn't really help to track both
separately, but just complicates things.

> 
>> +	}
>> +
>>  	return 0;
>>  }
>>  
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>> index c71240e8f7c7..b2ed5aba4c72 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -1150,6 +1150,7 @@ struct dwc3_scratchpad_array {
>>   * @sys_wakeup: set if the device may do system wakeup.
>>   * @wakeup_configured: set if the device is configured for remote wakeup.
>>   * @suspended: set to track suspend event due to U3/L2.
>> + * @susphy_state: state of DWC3_GUSB2PHYCFG_SUSPHY before PM suspend.
>>   * @imod_interval: set the interrupt moderation interval in 250ns
>>   *			increments or 0 to disable.
>>   * @max_cfg_eps: current max number of IN eps used across all USB configs.
>> @@ -1382,6 +1383,7 @@ struct dwc3 {
>>  	unsigned		sys_wakeup:1;
>>  	unsigned		wakeup_configured:1;
>>  	unsigned		suspended:1;
>> +	unsigned		susphy_state:1;
>>  
>>  	u16			imod_interval;
>>  
>>
>> ---
>> base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
>> change-id: 20240923-am62-lpm-usb-f420917bd707
>>
>> Best regards,
>> -- 
>> Roger Quadros <rogerq@kernel.org>
>>
> 
> <rant/>
> While reviewing your change, I see that we misuse the
> dis_u2_susphy_quirk to make this property a conditional thing during
> suspend and resume for certain platform. That bugs me because we can't
> easily change it without the reported hardware to test.
> </rant>

No it is not conditional. if dis_u2_susphy_quirk or dis_u3_susphy_quirk
is set then we never enable the respective U2/U3 SUSPHY bit.

> 
> Thanks for the patch!
> 
> BR,
> Thinh

-- 
cheers,
-roger

