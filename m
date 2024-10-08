Return-Path: <linux-pm+bounces-15354-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 145FE995335
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 17:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419371C256C2
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 15:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1391E009C;
	Tue,  8 Oct 2024 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a24QI64u"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CFD1DEFF4;
	Tue,  8 Oct 2024 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400772; cv=none; b=PS79HI3x8NKig7CEDumbS2UUmKrBJq5Zg5pBAxlYoIZx3hjVuK7Fd4gJJu1E0cFQBd+lT1y++0do8o+9HxSQH6OtkVlDZyrpriII+7XOQ1nGv9HFjmD7zuZ0HhSlCBDkjgCqbceq0tZucYBB9Rcb2LzEr+LLeV5w+lZuiRi939I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400772; c=relaxed/simple;
	bh=AC3J8zJg8qAC6TuirHuU2JewxyEkJScRJmlwgbFmEPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RkKUVI5V2xvPCv/JOzpDg1ZInDD3N2cjrk8ym/0ZagPMmjnEi0wyfWc88Dk1X2N+EuHFW4/xfLha0TVyR/VRXI1wHXOG/2nEPvmN2sZkvQoTpAPQ5uaJ0O1cATfJ3UX12iY8ghi8wujsBWE3FHpa9QF2AOkDabqtGblkx8GfMww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a24QI64u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64805C4CEC7;
	Tue,  8 Oct 2024 15:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728400772;
	bh=AC3J8zJg8qAC6TuirHuU2JewxyEkJScRJmlwgbFmEPc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a24QI64uPZ6z5hRJvZlr31MpYyZXMzUhdAVtKWaDEi7vPtkC5KqRV+wBYbhSwXu0W
	 o45UMpVVWdRB68nn8fGfTP8se9s6plpyJt6P09LpRTWdm3RmInyVF94QGnUxPezvw9
	 FjW65nDoXcO7eaNOfksf4EwXO4RaYYl1i+15n/j6xd5YHDN/NaHBHRDn+UGcUSDwQO
	 LD0lPUjSPehFtrnJZiK7Kcain6/8tYDvqrEX7uS7lvYgWm4iWUzMcIVkGqSjXZFy2/
	 5PcvHshWGHD5o7zWlicOAa48fcERyglXIpbUTVt15qC/ioSheg9jdsubki2jsQyo+6
	 mqHDcE/tyjzJA==
Message-ID: <85f1805b-e4c8-48c4-8e99-c36d20182a13@kernel.org>
Date: Tue, 8 Oct 2024 18:19:26 +0300
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

Hi Thinh,

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

Looking at this again, this fix is not specific to AM62 but for all platforms.
e.g. if Host Role was already started when going to system suspend, SUSPHY bits
were enabled, then after system resume SUSPHY bits are cleared at dwc3_core_init_for_resume().

Host stop/start was not called so SUSPHY bits remain cleared. So here
we deal with enabling SUSPHY.

> 
> /*
>  * xxxxx
>  * xxxxx
>  */
> 
> 
>> +		if (dwc->susphy_state)
> 
> Shouldn't we check for if (!dwc->susphy_state) and clear the susphy
> bits?
> 
>> +			dwc3_enable_susphy(dwc, true);
> 
> The dwc3_enable_susphy() set and clear both GUSB3PIPECTL_SUSPHY and
> GUSB2PHYCFG_SUSPHY, perhaps we should split that function out so we can
> only need to set for GUSB2PHYCFG_SUSPHY since you only track for that.
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
> 
> Thanks for the patch!
> 
> BR,
> Thinh

-- 
cheers,
-roger

