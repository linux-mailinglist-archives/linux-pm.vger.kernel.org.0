Return-Path: <linux-pm+bounces-24340-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51847A6ABF2
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 18:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94AB8188E4D1
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 17:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A98A224AFE;
	Thu, 20 Mar 2025 17:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cJ87csw/"
X-Original-To: linux-pm@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEDA2236FC
	for <linux-pm@vger.kernel.org>; Thu, 20 Mar 2025 17:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742491650; cv=none; b=ftfloDfqi5AYNB2HONRCgbWWI8nUGGQwZKjneOHo0owofrqAIwMpwXuZjlDDJqFb5SmWcS8kDSa1eAcXzZFIDvmbGenaRKtKVC3IM9HbBQlATuYn4jmaDmXV1+JIoMhLEykzRbL9Um65s55DNDeTKuQjfsqn6XWVZmwFVejyElk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742491650; c=relaxed/simple;
	bh=jThHM/pg0LyoeVqhQEYBrQzPaPICqI1IDeDrIcLHjNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ATIlWUlxbKp17GieeHsr6CDfHCcBZ6EsaSDljuPYQTnOgCqI+4DL9uVCdxhZSLVHVwluWzZPiROv9rvuFkO+17VkcLOBYvnJfe+PZHxklPUEEQi+v/K2innoJpSzdfSIMkQ7AedBkin/n3qadGoerE6yIA+q4I3BRPeJlBrQAKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=cJ87csw/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tCTXY8au+71bsz+0fNc/CkvP9+Xt+EQdyzRpclZudew=; b=cJ87csw/S2ZuA7VfWqTPQaoGwR
	PH6KJOpZnuZz9rgSTwN2KX+U25vjRxxqRo5zDNbnX+aifNt3/DNzUEwYOgudTZnPMN3H+glYtBtZ3
	RQxVoKgNZsLmsvuwp2Obtu84bo8ydg5GKg5IDum27w1K2Qx4nxpkvei0CACt6dOgz1QaJK34h0DnB
	YimCeCltUfxC9sDt4R2FGLjNu5iP9ZPFqia8NL1bw9HwnCysEosfDHJycLXs/rCcWS4GNeIA3U+vr
	l5PVvGrZmWU0281SacVYhQ9s5hqMrG0w70NC1tX97qjpegDgLdSHkzcd9N2xRkpwfw1ai4m0kGFx5
	XZ9cZXnQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54996)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tvJfq-0007zD-0P;
	Thu, 20 Mar 2025 17:27:18 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tvJfo-0006mk-0x;
	Thu, 20 Mar 2025 17:27:16 +0000
Date: Thu, 20 Mar 2025 17:27:16 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>
Cc: Jon Hunter <jonathanh@nvidia.com>, Thierry Reding <treding@nvidia.com>,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: suspend-to-ram resume fails on Tegra Jetson Xavier NX
Message-ID: <Z9xP9IpLD04O5KPY@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

I'm struggling with a deadlock in the _noirq paths when resuming from
suspend-to-ram. with 6.14-rc6 (specifically net-next).

Having thrown lots of debug into kernel/power/suspend.c and
drivers/base/power/main.c, what I observe is:

1. /sys/power/pm_async is 1. If this is set to 0, then the problem does
   not manifest.

2. it seems the sync/async resume doesn't order correctly. With my own
   debugging in place, I see:

CPU5 is up
resume: suspend_enter:471
resume: dpm_resume_noirq:794
resume: dpm_noirq_resume_devices:742
 faux: PM: trying async resume (async=0)
 faux: PM:   -- will resume sync
 platform: PM: trying async resume (async=0)
 platform: PM:   -- will resume sync
 cpu: PM: trying async resume (async=0)
 cpu: PM:   -- will resume sync
cpu cpu0: PM: trying async resume (async=0)
cpu cpu0: PM:   -- will resume sync
...
tegra-bpmp bpmp: PM: trying async resume (async=0)
tegra-bpmp bpmp: PM:   -- will resume sync
platform 17000000.gpu: PM: trying async resume (async=0)
platform 17000000.gpu: PM:   -- will resume sync
platform 13e00000.host1x: PM: trying async resume (async=0)
platform 13e00000.host1x: PM:   -- will resume sync
...
tegra-bpmp-i2c bpmp:i2c: PM: trying async resume (async=0)
tegra-bpmp-i2c bpmp:i2c: PM:   -- will resume sync

*** Note - bpmp:i2c is on the dpm_noirq_list after 13e00000.host1x
and is being resumed synchronously.

i2c i2c-0: PM: trying async resume (async=1)
i2c-dev i2c-0: PM: trying async resume (async=0)
i2c i2c-0: PM: device_resume_noirq:650
i2c-dev i2c-0: PM:   -- will resume sync
max77620 0-003c: PM: trying async resume (async=1)
max77620-pinctrl max20024-pinctrl: PM: trying async resume (async=0)
max77620 0-003c: PM: device_resume_noirq:650
...
i2c i2c-0: PM: waiting for parent (bpmp:i2c)
max77620 0-003c: PM: waiting for parent (i2c-0)
...
tegra-bpmp bpmp: PM: device_resume_noirq:650
tegra-bpmp bpmp: PM: waiting for parent (platform)
tegra-bpmp bpmp: PM: parent wait finished, waiting for suppliers
tegra-bpmp bpmp: PM: waiting for supplier 2c00000.memory-controller
tegra-bpmp bpmp: PM: supplier finished
tegra-bpmp bpmp: PM: waiting for supplier 3c00000.hsp
tegra-bpmp bpmp: PM: supplier finished
tegra-bpmp bpmp: PM: suppliers finished
tegra-bpmp bpmp: PM: -- resume_noirq: tegra_bpmp_resume (sync)
tegra-bpmp bpmp: PM: -- complete
...
platform 13e00000.host1x: PM: device_resume_noirq:650
platform 13e00000.host1x: PM: waiting for parent (bus@0)
platform 13e00000.host1x: PM: parent wait finished, waiting for suppliers
platform 13e00000.host1x: PM: waiting for supplier 2c60000.external-memory-controller
platform 13e00000.host1x: PM: supplier finished
platform 13e00000.host1x: PM: waiting for supplier 2c00000.memory-controller
platform 13e00000.host1x: PM: supplier finished
platform 13e00000.host1x: PM: waiting for supplier 2200000.gpio
platform 13e00000.host1x: PM: supplier finished
platform 13e00000.host1x: PM: waiting for supplier bpmp
platform 13e00000.host1x: PM: supplier finished
platform 13e00000.host1x: PM: waiting for supplier regulator-vdd-hdmi
platform 13e00000.host1x: PM: supplier finished
platform 13e00000.host1x: PM: waiting for supplier bus@0
platform 13e00000.host1x: PM: supplier finished
platform 13e00000.host1x: PM: waiting for supplier 0-003c

Here we die - with interrupts off, so none of the kernel lockup
detectors are functional, so without debug the console is completely
silent.

13e00000.host1x is not bound to a driver (it failed its probe), but
is being synchronously resumed. It is waiting for 0-003c to be resumed.

0-003c is being resumed asynchronously, and is waiting for i2c-0 to
be resumed.

i2c-0 is being resumed asynchronously, and is waiting for bpmp:i2c to
be resumed.

bpmp:i2c is not *yet* being resumed, because it is to be resumed
synchronously, and is on the dpm_noirq_list after 13e00000.host1x.
This results in a silently dead system on resume.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

