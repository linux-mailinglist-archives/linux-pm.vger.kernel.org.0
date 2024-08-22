Return-Path: <linux-pm+bounces-12714-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2451C95B2F2
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 12:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BDFD1F240E1
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 10:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD22D17C216;
	Thu, 22 Aug 2024 10:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="NP5j2MMj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304EF17A584;
	Thu, 22 Aug 2024 10:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724322727; cv=none; b=neNh4ZCcPbS4qeAvNy3xfe94iJVKU/n4ZZOrfzSsLCMcLY2Gxzwi0CFJVFJM2j1Y+V+Cd2grurB3veNPv75M4Rhuo78qhNERBCds5zR7ZbnWFnX4IjphzS57EQb74SQ9r4q56+n4qhQehUh2AF2K+wfnX1tqvcJmGE3eHHTOWNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724322727; c=relaxed/simple;
	bh=tJJYyQk+oSUBsqfm8YrY+zeZ9ssQax21lFme7HgnFb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tPRisHKF9BhPbuz/zUbcdGTq5sSMFoBl4ib/W3H6xd41nlNAmyz0LEJWndY1fEuLxNvZ8QWAXwoFnuIPjATlypMOXIEKxIVkeimCUxAnYUDAKid+A3sPvyqbdCM+lM2xbXcfx3W0DnUW2hoBYdNrw1mZ8Kb7fus9Pnl8KOIuNkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=NP5j2MMj; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1724322654; x=1724927454; i=wahrenst@gmx.net;
	bh=bmWJ655L4SO7j85UwgXiqt8bDkgUrBoaH+y+sFg/zuI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NP5j2MMjy9pkE0lOsGAISKZ660r2xan/B5F1GlARPNyM7/CK9btIrLRX62/4c5Sf
	 9c/AyiMHgpHBWl3aKsccVyc4UjbqfvPnFeIPCMZHK3JIP1kYdp7PZQOG0uu5C2Gvr
	 eBTVLnxYRuCof+Gpdpeq1v7l0NwIvVTV/d0+vulTeoXmhChFKr38plqGEFYp+opiV
	 SK7hdRIaiB2ICEw04L4Eb0+MourOGoVUQGzuvkGYEUXbO4oEIBhJpFR5cAflLO3Gg
	 a6v73bu5eqJjzN6jVTZNPtOs90PcnrsDsoQ9xhtaaiMM3aBuMgGqrNQKHq6F6SURo
	 oeUl6rcRoA/OAk/vPw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mz9Un-1ru2s10FEp-00tpe2; Thu, 22
 Aug 2024 12:30:54 +0200
Message-ID: <c7d39199-5ed2-4642-9740-f9aa60a19eec@gmx.net>
Date: Thu, 22 Aug 2024 12:30:49 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 7/9] usb: dwc2: Refactor backup/restore of registers
To: Russell King <linux@armlinux.org.uk>,
 Doug Anderson <dianders@chromium.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Maxime Ripard <mripard@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Minas Harutyunyan <hminas@synopsys.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>,
 Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, dri-devel@lists.freedesktop.org,
 bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel-list@raspberrypi.com
References: <20240821214052.6800-1-wahrenst@gmx.net>
 <20240821214052.6800-8-wahrenst@gmx.net>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240821214052.6800-8-wahrenst@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ipHGBrBY87TrA6OEnWRiCoV4daQpl0UeDW4c8PFkDNkQmmQeksl
 g+JC/f6SffB+BaHcc+jZQUua3wzxUXQY3ne8PAKmdS1H764Hz04G9AJy4sdmjnwh5LWu933
 fhf80Zr4cEmG1+Tj7pniq19fx9xkix76+Y2B3yFyi50dMDzjE/+KQkAoFSox9hiFVHuFQfG
 ORVvUWAYwn6pQPLAC40dA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TArIr41CR30=;6vuj+cQfovOR8oue9/F/AfsAYww
 RxeYPOmIehuSOMH96q5IQlET3+2SoT8Q3N5XskcPBiPJuUFEsVGiQ/gOMMVUaPzmNTKthBsrC
 2uxFcRSJDB+m1fHM7JOa9UG/96HuFyxgPN8fxBqzvP6J5ZmLHlG9iWyKPPDk5nTT/ZRkYoWzy
 kHILrF9C3GJhSP8QVEackrePOz2sI+k9yj9I22ApcQMoBBryeZg/ewSg760ncSFh3v6JxnSrp
 KqdeI3OlBbzTfA+bcS4nY1C/USDzd1OxUH/nG1qlrSNWZNO5FfH8aynOIlnE5NQdaO7Wzog/p
 i2qXg4DNnv4UaoUkQBR1CeDHVF3bVY/E6yrIFY8JCGs/T3bphO8sUEhST1vOT232fmDXrwdBc
 o1CqyQUoZg2zPAEuNcPeBD2FGP3s2c2V5mXA1P9HEnnygO59uaWOaxiE0h9ZSmTHGcRak53r4
 ly1Col6uhmjW8OlTd8gqfk7GrlNHBE+A92dBozvR2DYH75Z3yrIjzXUwEaN6I/fGNVFvpxWWS
 co8i5JRvfJu0fE4vHN62PTGS8UkY9HOpPL1KILaUe7NqQwFlxxLZJTRkAbIloBVXzif6LpZAA
 EYN3yKQ5h4dJcOy6WwUxdFHrMCWOCsCxnEpCfscgVrQ5xBzCCqPuGzzw/N2dPTP9k04HJWy2O
 kW2Qu8RkVuSPcUYyzEKPVAv2pIzhO5ONy7MOXvF6MrOoq+IMlpz4So58noprONz9ttZp0+kIC
 Vcr/NDGRs3bJlneUfFL1oGXBtNJaVsr5tqMmYoA3ilPtSd8RzX0aRWdfc8yfodzQxE0uFQNiL
 Ms0bNvh17YhMzTgD5ZpQYY3w==

Am 21.08.24 um 23:40 schrieb Stefan Wahren:
> The DWC2 runtime PM code reuses similar patterns to backup and
> restore the registers. So consolidate them in USB mode specific
> variants. This also has the advantage it is usable for further
> PM improvements.
>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>   drivers/usb/dwc2/core.h   |  12 +++++
>   drivers/usb/dwc2/gadget.c | 101 +++++++++++++++++++-------------------
>   drivers/usb/dwc2/hcd.c    |  99 +++++++++++++++++++------------------
>   3 files changed, 114 insertions(+), 98 deletions(-)
>
> diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
> index 2bd74f3033ed..81e8632f29ed 100644
> --- a/drivers/usb/dwc2/core.h
> +++ b/drivers/usb/dwc2/core.h
> @@ -1435,6 +1435,8 @@ int dwc2_hsotg_tx_fifo_total_depth(struct dwc2_hsotg *hsotg);
>   int dwc2_hsotg_tx_fifo_average_depth(struct dwc2_hsotg *hsotg);
>   void dwc2_gadget_init_lpm(struct dwc2_hsotg *hsotg);
>   void dwc2_gadget_program_ref_clk(struct dwc2_hsotg *hsotg);
> +int dwc2_gadget_backup_critical_registers(struct dwc2_hsotg *hsotg);
> +int dwc2_gadget_restore_critical_registers(struct dwc2_hsotg *hsotg);
>   static inline void dwc2_clear_fifo_map(struct dwc2_hsotg *hsotg)
>   { hsotg->fifo_map = 0; }
>   #else
> @@ -1482,6 +1484,10 @@ static inline int dwc2_hsotg_tx_fifo_average_depth(struct dwc2_hsotg *hsotg)
>   { return 0; }
>   static inline void dwc2_gadget_init_lpm(struct dwc2_hsotg *hsotg) {}
>   static inline void dwc2_gadget_program_ref_clk(struct dwc2_hsotg *hsotg) {}
> +static inline int dwc2_gadget_backup_critical_registers(struct dwc2_hsotg *hsotg)
> +{ return 0; }
> +static inline int dwc2_gadget_restore_critical_registers(struct dwc2_hsotg *hsotg)
> +{ return 0; }
>   static inline void dwc2_clear_fifo_map(struct dwc2_hsotg *hsotg) {}
>   #endif
>
> @@ -1505,6 +1511,8 @@ int dwc2_host_exit_partial_power_down(struct dwc2_hsotg *hsotg,
>   void dwc2_host_enter_clock_gating(struct dwc2_hsotg *hsotg);
>   void dwc2_host_exit_clock_gating(struct dwc2_hsotg *hsotg, int rem_wakeup);
>   bool dwc2_host_can_poweroff_phy(struct dwc2_hsotg *dwc2);
> +int dwc2_host_backup_critical_registers(struct dwc2_hsotg *hsotg);
> +int dwc2_host_restore_critical_registers(struct dwc2_hsotg *hsotg);
>   static inline void dwc2_host_schedule_phy_reset(struct dwc2_hsotg *hsotg)
>   { schedule_work(&hsotg->phy_reset_work); }
>   #else
> @@ -1544,6 +1552,10 @@ static inline void dwc2_host_exit_clock_gating(struct dwc2_hsotg *hsotg,
>   					       int rem_wakeup) {}
>   static inline bool dwc2_host_can_poweroff_phy(struct dwc2_hsotg *dwc2)
>   { return false; }
> +static inline int dwc2_host_backup_critical_registers(struct dwc2_hsotg *hsotg)
> +{ return 0; }
> +static inline int dwc2_host_restore_critical_registers(struct dwc2_hsotg *hsotg)
> +{ return 0; }
>   static inline void dwc2_host_schedule_phy_reset(struct dwc2_hsotg *hsotg) {}
>
>   #endif
> diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
> index e7bf9cc635be..0bff748bcf74 100644
> --- a/drivers/usb/dwc2/gadget.c
> +++ b/drivers/usb/dwc2/gadget.c
> @@ -5309,6 +5309,49 @@ void dwc2_gadget_program_ref_clk(struct dwc2_hsotg *hsotg)
>   	dev_dbg(hsotg->dev, "GREFCLK=0x%08x\n", dwc2_readl(hsotg, GREFCLK));
>   }
>
> +int dwc2_gadget_backup_critical_registers(struct dwc2_hsotg *hsotg)
> +{
> +	int ret;
> +
> +	/* Backup all registers */
> +	ret = dwc2_backup_global_registers(hsotg);
> +	if (ret) {
> +		dev_err(hsotg->dev, "%s: failed to backup global registers\n",
> +			__func__);
> +		return ret;
> +	}
> +
> +	ret = dwc2_backup_device_registers(hsotg);
> +	if (ret) {
> +		dev_err(hsotg->dev, "%s: failed to backup device registers\n",
> +			__func__);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +int dwc2_gadget_restore_critical_registers(struct dwc2_hsotg *hsotg)
> +{
> +	int ret;
> +
> +	ret = dwc2_restore_global_registers(hsotg);
> +	if (ret) {
> +		dev_err(hsotg->dev, "%s: failed to restore registers\n",
> +			__func__);
> +		return ret;
> +	}
> +
> +	ret = dwc2_restore_device_registers(hsotg, 0);
> +	if (ret) {
> +		dev_err(hsotg->dev, "%s: failed to restore device registers\n",
> +			__func__);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>   /**
>    * dwc2_gadget_enter_hibernation() - Put controller in Hibernation.
>    *
> @@ -5326,18 +5369,9 @@ int dwc2_gadget_enter_hibernation(struct dwc2_hsotg *hsotg)
>   	/* Change to L2(suspend) state */
>   	hsotg->lx_state = DWC2_L2;
>   	dev_dbg(hsotg->dev, "Start of hibernation completed\n");
> -	ret = dwc2_backup_global_registers(hsotg);
> -	if (ret) {
> -		dev_err(hsotg->dev, "%s: failed to backup global registers\n",
> -			__func__);
> -		return ret;
> -	}
> -	ret = dwc2_backup_device_registers(hsotg);
> -	if (ret) {
> -		dev_err(hsotg->dev, "%s: failed to backup device registers\n",
> -			__func__);
> +	ret = dwc2_gadget_backup_critical_registers(hsotg);
> +	if (ret)
>   		return ret;
> -	}
>
>   	gpwrdn = GPWRDN_PWRDNRSTN;
>   	udelay(10);
> @@ -5483,20 +5517,9 @@ int dwc2_gadget_exit_hibernation(struct dwc2_hsotg *hsotg,
>   	dwc2_writel(hsotg, 0xffffffff, GINTSTS);
>
>   	/* Restore global registers */
> -	ret = dwc2_restore_global_registers(hsotg);
> -	if (ret) {
> -		dev_err(hsotg->dev, "%s: failed to restore registers\n",
> -			__func__);
> -		return ret;
> -	}
> -
> -	/* Restore device registers */
> -	ret = dwc2_restore_device_registers(hsotg, rem_wakeup);
> -	if (ret) {
> -		dev_err(hsotg->dev, "%s: failed to restore device registers\n",
> -			__func__);
> +	ret = dwc2_gadget_restore_critical_registers(hsotg);
> +	if (ret)
>   		return ret;
> -	}
>
>   	if (rem_wakeup) {
>   		mdelay(10);
> @@ -5530,19 +5553,9 @@ int dwc2_gadget_enter_partial_power_down(struct dwc2_hsotg *hsotg)
>   	dev_dbg(hsotg->dev, "Entering device partial power down started.\n");
>
>   	/* Backup all registers */
> -	ret = dwc2_backup_global_registers(hsotg);
> -	if (ret) {
> -		dev_err(hsotg->dev, "%s: failed to backup global registers\n",
> -			__func__);
> -		return ret;
> -	}
> -
> -	ret = dwc2_backup_device_registers(hsotg);
> -	if (ret) {
> -		dev_err(hsotg->dev, "%s: failed to backup device registers\n",
> -			__func__);
> +	ret = dwc2_gadget_backup_critical_registers(hsotg);
> +	if (ret)
>   		return ret;
> -	}
>
>   	/*
>   	 * Clear any pending interrupts since dwc2 will not be able to
> @@ -5610,21 +5623,9 @@ int dwc2_gadget_exit_partial_power_down(struct dwc2_hsotg *hsotg,
>
>   	udelay(100);
>   	if (restore) {
> -		ret = dwc2_restore_global_registers(hsotg);
> -		if (ret) {
> -			dev_err(hsotg->dev, "%s: failed to restore registers\n",
> -				__func__);
> -			return ret;
> -		}
> -		/* Restore DCFG */
> -		dwc2_writel(hsotg, dr->dcfg, DCFG);
Oh dear, i accidentally dropped that. I will fix this.

Thanks goes to kernel test robot

