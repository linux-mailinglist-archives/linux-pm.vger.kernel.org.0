Return-Path: <linux-pm+bounces-34961-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA2AB84E22
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 15:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1410A1C839CE
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 13:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F71F30C0E8;
	Thu, 18 Sep 2025 13:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MFbMU4sh"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4DD220F29;
	Thu, 18 Sep 2025 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202881; cv=none; b=rr0ZH1Q0hPW/8FxGjnSkpTR5mLjfYiNCX+hxCRNG4ReIMpK495mlDveu8+CHGPHo9ejECTNcNiZxtlSBCviBU41Q7Bpl0KVuDrgD2hz3ONLqjk+101OF4mwAFzwEHFwyg7CuvarpGA8f5+ug8NR7pKcQsUMs7S9zBePQpJR49Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202881; c=relaxed/simple;
	bh=GS1lHfbXJUZu4M/K47vm1xoi0khW3qkbtkY3iQh5qDQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z37EfUs4ULfn9ARmqPir9eQH2Tyxqtx8BvtzcOdbqQeGYGhcqf82SSxv/wtdE0R4WORMnrDJoOQaUJwXQ8nf9HWEVoVT++HdVBAOZ5XGdHMsfiYqjcZGz/kypPQFS4tjt3fS0cfFW4SYh2bxVD9uF3gS/QIG+/cLM+9sLAlFn6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MFbMU4sh; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58IDegeo493090;
	Thu, 18 Sep 2025 08:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758202842;
	bh=nilE7uTgSMT2YbWFrd5UVjg90TJPQVzV3fTHvrJ5g9Q=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=MFbMU4shPzOOyyPffN2117PkiSfS5+6xV4iCKozf8h/zi023q/OaB8HgpicPY3/OA
	 MMqoO9v9QqYMEeseYLjZ/rzwu6PpbAwO0f7VGVFXwap1ryREJUzyEnIW5jJu4WxzQ2
	 4dXH+0N0u1mUURA3voN8NbHY2f36H3tu5/DW+P68=
Received: from DLEE207.ent.ti.com (dlee207.ent.ti.com [157.170.170.95])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58IDef4E2388304
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Sep 2025 08:40:42 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Sep
 2025 08:40:41 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 18 Sep 2025 08:40:41 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58IDeeNc667154;
	Thu, 18 Sep 2025 08:40:41 -0500
Date: Thu, 18 Sep 2025 19:10:40 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Peng Fan <peng.fan@oss.nxp.com>
CC: Peng Fan <peng.fan@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael
 J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek
	<pavel@kernel.org>, Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer
	<s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Xu Yang <xu.yang_2@nxp.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <imx@lists.linux.dev>, <arm-scmi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 1/4] pmdomain: core: Introduce
 device_set/get_out_band_wakeup()
Message-ID: <20250918134039.zkpeqsbf6m2ymxvt@lcpd911>
References: <20250902-pm-v3-0-ffadbb454cdc@nxp.com>
 <20250902-pm-v3-1-ffadbb454cdc@nxp.com>
 <20250918095950.h7wmz2qj5e6khtwr@lcpd911>
 <20250918131230.GD9196@nxa18884-linux.ap.freescale.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250918131230.GD9196@nxa18884-linux.ap.freescale.net>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Peng,

On Sep 18, 2025 at 21:12:30 +0800, Peng Fan wrote:
> Hi Dhruva,
> 
> On Thu, Sep 18, 2025 at 03:29:50PM +0530, Dhruva Gole wrote:
> >On Sep 02, 2025 at 11:33:00 +0800, Peng Fan wrote:
> >> For some cases, a device could still wakeup the system even if its power
> >> domain is in off state, because the device's wakeup hardware logic is
> >> in an always-on domain.
> >> 
> >> To support this case, introduce device_set/get_out_band_wakeup() to
> >> allow device drivers to control the behaviour in genpd for a device
> >> that is attached to it.
> >> 
> >
> >Thinking more into it, to me it seems like if the intent here is to only
> >allow the device drivers to figure out whether they should be or not be
> >executing the suspend/resume_noirqs then that can still be checked by
> >wisely using the device set_wakeup APIs in the driver itself.
> >
> >Not sure why this patch should be necessary for a
> >driver to execute the suspend_noirq or not. That decision can very well
> >be taken inside the driver's suspend resume_noirq hooks based on wakeup
> >capability and wake_enabled statuses.
> 
> I should join today's SCMI meeting, but something else caught me (:

It's alright, maybe see you in the next one ;)

> 
> Thanks for looking into this. 
> 
> In genpd_suspend_finish, genpd_sync_power_off will be called if
> "(device_awake_path(dev) && genpd_is_active_wakeup(genpd))" is false.
> So if the device is enabled wakeup, the genpd will not be turned off because
> the check return true.

Umm I think this device_awake_path stuff is only going to be true when
someone calls device_set_wakeup_path, I don't think it is going to
return true for a wakeup_capable device. I know all these "wakeup"
terminology and APIs have become all too confusing :( , so maybe Ulf can
correct me.
I maybe misremembering, but I have seen in some cases where a driver may
have marked itself wakeup_capable but the suspend hooks still do get
called... So your concern about genpd_sync_power_off not being called
due to wakeup capable device driver may not be valid... Again please
feel to correct me if I am wrong.

Did you also look at the wake IRQ stuff I mentioned?
In the path you're talking about it just checks
device_awake_path(dev) && genpd_is_active_wakeup(genpd)
However if the device irq is just marked as a wake IRQ, I don't think
that is checked anywhere in this path. So definitely if the IRQ of your
device is set as a wake IRQ, it will still get suspended and resumed as
usual and that's what you want right?


> 
> But to i.MX, if the device is configured as wakeup source, we still need to
> power off the power domain, because the device has out-of-band wakeup logic.
> 
> This patch is to make sure the power domain could be powered off in
> suspend flow and powered up in resume flow.
> 
> Thanks,
> Peng
> 
> >
> >Just a pseudo code:
> >```
> >driver_suspend_noirq () {
> >	if (device_may_wakeup()) {
> >		// do the sequence where the power domain might get turned off
> >		// but like you say device can do some out band wakeup
> >		return XXX;
> >	}
> >	// regular suspend sequence here... maybe inband wakeup config / clk
> >	// disable etc...
> >}
> > ```
> >
> >And something similar in resume_noirq?
> >
> >Just need to make sure that the probe func does the
> >device_set_wakeup_enable or capable stuff correctly as per your H/w and
> >wakeup requirements...
> >
> >
> >-- 
> >Best regards,
> >Dhruva Gole
> >Texas Instruments Incorporated

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

