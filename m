Return-Path: <linux-pm+bounces-35203-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1FEB95499
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 11:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553FD190619D
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 09:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578863203AF;
	Tue, 23 Sep 2025 09:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gyx6BDuj"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8434F258CF9;
	Tue, 23 Sep 2025 09:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620445; cv=none; b=uqQXJ8G4SKKvYo+2jSo9AqsBb0B7vhj0hneFeavfM5OJ9boh8SNdROudj7wQgNg2Xkb9PzUQfGw23uPnRX09wxK5A2232NgC3jJ1gZ6iUEJ9QKLq9MPPSvy7kM6Cd6PA6Xyb0RLICS8Z8oVFxZj2vIZ+pnm9jUvZ7fnS+UTD+PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620445; c=relaxed/simple;
	bh=q81kQ5xhqohdzpN6BRTaCRJ3bo8nUWkgVBAYZFL2f7M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxGr6BEE96iHtw1nuGef0fPX2CNUrE/8rcgY8sBbrXJ0WtIy6MM9dvSRE1cYfPQlPZk121Qe9o31kVVXc4QW8h0rTQVNzimB5Pc9581OY37vzIxAw8nQrbCQRm/0yB6TuJkLHA0O6NuAFQJrolaiJxTOyadxh6w4cE9JB0wIhVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gyx6BDuj; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58N9eMLE1427212;
	Tue, 23 Sep 2025 04:40:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758620422;
	bh=8bg8Oys3ldqONp1rkDm9KHUE8Nsow8X5TQBNQvmAkmM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=gyx6BDujLPlhRSIYt1R2kGpS4iOH9Y3YRjwHY/C0QD8H6fmioS4w69VaCpOB71bsx
	 /0tshFMmA7o5ZscQu5RjfNcJEDv4SObCuipjI1YnIz4lnrDlalxaIaQwTR02DdX3gD
	 W1GsRLHs0bPL0l+QWJjZUco4UENx+pJHvJ5WKfV0=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58N9eMnJ986154
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 23 Sep 2025 04:40:22 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 23
 Sep 2025 04:40:21 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 04:40:21 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58N9eKtg101593;
	Tue, 23 Sep 2025 04:40:21 -0500
Date: Tue, 23 Sep 2025 15:10:20 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Peng Fan <peng.fan@nxp.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Chen <peter.chen@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha
 Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team
	<kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 1/5] PM: wakeup: Add out-of-band system wakeup support
 for devices
Message-ID: <20250923094020.ogc2nr5nxryxoavq@lcpd911>
References: <20250922-pm-v4-v4-0-ef48428e8fe0@nxp.com>
 <20250922-pm-v4-v4-1-ef48428e8fe0@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250922-pm-v4-v4-1-ef48428e8fe0@nxp.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sep 22, 2025 at 10:21:06 +0800, Peng Fan wrote:
> Some devices can wake up the system from suspend even when their power
> domains are turned off. This is possible because their system-wakeup logic
> resides in an always-on power domain - indicating that they support
> out-of-band system wakeup.
> 
> Currently, PM domain core doesn't power off such devices if they are marked
> as system wakeup sources. To better represent devices with out-of-band

This commit message makes things much clearer now. Thanks!

> wakeup capability, this patch introduces a new flag out_band_wakeup in
> 'struct dev_pm_info'.
> 
> Two helper APIs are added:
>  - device_set_out_band_wakeup() - to mark a device as having out-of-band
>    wakeup capability.
>  - device_out_band_wakeup() - to query the flag.
> 
> Allow the PM core and drivers to distinguish between regular and
> out-of-band wakeup sources, enable more accurate power management decision.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

