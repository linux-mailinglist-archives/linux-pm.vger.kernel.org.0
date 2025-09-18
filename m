Return-Path: <linux-pm+bounces-34952-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DA3B83F18
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 12:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050A23AE63B
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 10:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883892566E9;
	Thu, 18 Sep 2025 10:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tsgj5sal"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC4B2EF660;
	Thu, 18 Sep 2025 10:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758189615; cv=none; b=jpzBV1D6b17VAtF2yBAng0nt2SBhViBOBVQg/9edFZrW+5AJAeGxY05rj67e9r8y662qtNP+BOMtHuxzTnMPPBErlAWXwhXO071tQHh6R3LAX9OHmLxsypZuDk1xP8aMRT11ZjFA4uXVHUTrbeQnznESjfK1amTB46UaGUXpjrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758189615; c=relaxed/simple;
	bh=Bse43jyzR8nZcEl4pAQd2Sdp31p7Bh/3Ilo+I2o2rJA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkhUp/KuaVn+3qS1IelpY1V0rYksfrD8xieJof0GF2xju9Jr6sa+bju8SxLPIeGvuAWQHpXZMPURE/AF52J1JlS//q7Ka7wWxH2TqDJXe9rmbxuZJ6fzQZYwr8rioxfiMXGbWcs+oYUJqyVHjxfYmLQiVP1/RjLZIYSkjkbCx34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tsgj5sal; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58I9xqX71721643;
	Thu, 18 Sep 2025 04:59:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758189592;
	bh=38CN86+v/N3yFeHrI8mpeV2lMrT0UcLaFt3ugTYePww=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=tsgj5salexCwGPpZCXDQDFIU1+Hr0BUPeO100cAx0k7uv3bkMyqjLbtZfon1aGGY3
	 vZxWPSG+FkIFsunHQRfvFwJ3gDfKIN/qIduzHHRcPi8limvOKOu3QZa5mzYqTx9MhC
	 15bPn/eNvj+Gj96Smuc0Ig7TRDH7LE1COliYUPp4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58I9xqTX1465831
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 18 Sep 2025 04:59:52 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 18
 Sep 2025 04:59:52 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 18 Sep 2025 04:59:52 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58I9xoAl683748;
	Thu, 18 Sep 2025 04:59:51 -0500
Date: Thu, 18 Sep 2025 15:29:50 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Peng Fan <peng.fan@nxp.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>,
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
Message-ID: <20250918095950.h7wmz2qj5e6khtwr@lcpd911>
References: <20250902-pm-v3-0-ffadbb454cdc@nxp.com>
 <20250902-pm-v3-1-ffadbb454cdc@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250902-pm-v3-1-ffadbb454cdc@nxp.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sep 02, 2025 at 11:33:00 +0800, Peng Fan wrote:
> For some cases, a device could still wakeup the system even if its power
> domain is in off state, because the device's wakeup hardware logic is
> in an always-on domain.
> 
> To support this case, introduce device_set/get_out_band_wakeup() to
> allow device drivers to control the behaviour in genpd for a device
> that is attached to it.
> 

Thinking more into it, to me it seems like if the intent here is to only
allow the device drivers to figure out whether they should be or not be
executing the suspend/resume_noirqs then that can still be checked by
wisely using the device set_wakeup APIs in the driver itself.

Not sure why this patch should be necessary for a
driver to execute the suspend_noirq or not. That decision can very well
be taken inside the driver's suspend resume_noirq hooks based on wakeup
capability and wake_enabled statuses.

Just a pseudo code:
```
driver_suspend_noirq () {
	if (device_may_wakeup()) {
		// do the sequence where the power domain might get turned off
		// but like you say device can do some out band wakeup
		return XXX;
	}
	// regular suspend sequence here... maybe inband wakeup config / clk
	// disable etc...
}
 ```

And something similar in resume_noirq?

Just need to make sure that the probe func does the
device_set_wakeup_enable or capable stuff correctly as per your H/w and
wakeup requirements...


-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

