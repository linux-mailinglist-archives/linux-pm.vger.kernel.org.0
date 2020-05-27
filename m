Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E071E40FD
	for <lists+linux-pm@lfdr.de>; Wed, 27 May 2020 13:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgE0LyP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 May 2020 07:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728717AbgE0LyM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2020 07:54:12 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCCAC08C5C1;
        Wed, 27 May 2020 04:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1BtgjbAHH+SQbPjyLwaeHytSSYLwREhV7BhkbEcaUa8=; b=xFub5XI7K0HyRPLsyCYQ2iZQr
        V/ztTR54UukKwyzOYVEZOHh1rQy5o9j8jYMyeDDmapRpXWgrmDmOZ+yCPyk+MMpMMQbsbIJcqcYZT
        FY+Xqg/wbKUdi5cE8nd5PzmI5VgUYgSCrVwtkhDzPlCq2Sy0LroTteWckME3z8m9iJd890Vt1PyA5
        QSDYwvmxbkd042FNb1gFgp3KDv+ikC1ns3POIWS8UhG8aBxSv9iZJknigzW6h7trn1BjDynIvegED
        c3vVBh4mzl6l1DsRVmxYGs8YWDTC/csU8GbLCnC1IpGnljVIPJUhd6gIe/0weL1eUTBHrkvU0LmgF
        TLqHyrB7A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37646)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jdud6-0002By-0W; Wed, 27 May 2020 12:53:52 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jdud2-0006Oo-1w; Wed, 27 May 2020 12:53:48 +0100
Date:   Wed, 27 May 2020 12:53:48 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: High interrupt latency with low power idle mode on i.MX6
Message-ID: <20200527115347.GL1551@shell.armlinux.org.uk>
References: <bc91129c-121c-a070-53b2-1f0bb6d4500a@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc91129c-121c-a070-53b2-1f0bb6d4500a@kontron.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 27, 2020 at 10:39:12AM +0000, Schrempf Frieder wrote:
> Hi,
> 
> on our i.MX6UL/ULL boards running mainline kernels, we see an issue with 
> RS485 collisions on the bus. These are caused by the resetting of the 
> RTS signal being delayed after each transmission. The TXDC interrupt 
> takes several milliseconds to trigger and the slave on the bus already 
> starts to send a reply in the meantime.
> 
> We found out that these delays only happen when the CPU is in "low power 
> idle" mode (ARM power off). When we disable cpuidle state 2 or put some 
> background load on the CPU everything works fine and the delays are gone.
> 
> echo 1 > /sys/devices/system/cpu/cpu0/cpuidle/state2/disable
> 
> It seems like also other interfaces (I2C, etc.) might be affected by 
> these increased latencies, we haven't investigated this more closely, 
> though.
> 
> We currently apply a patch to our kernel, that disables low power idle 
> mode by default, but I'm wondering if there's a way to fix this 
> properly? Any ideas?

Let's examine a basic fact about power management:

The deeper PM modes that the system enters, the higher the latency to
resume operation.

So, I'm not surprised that you have higher latency when you allow the
system to enter lower power modes.  Does that mean that the kernel
should not permit entering lower power modes - no, it's policy and
application dependent.

If the hardware is designed to use software to manage the RTS signal
to control the RS485 receiver, then I'm afraid that your report really
does not surprise me - throwing that at software to manage is a really
stupid idea, but it seems lots of people do this.  I've held this view
since I worked on a safety critical system that used RS485 back in the
1990s (London Underground Jubilee Line Extension public address system.)

So, what we have here is several things that come together to create a
problem:

1) higher power savings produce higher latency to resume from
2) lack of hardware support for RS485 half duplex communication needing
   software support
3) an application that makes use of RS485 half duplex communication
   without disabling the higher latency power saving modes

The question is, who should disable those higher latency power saving
modes - the kernel, or userspace?

The kernel knows whether it needs to provide software control of the
RTS signal or not, but the kernel does not know the maximum permissible
latency (which is application specific.)  So, the kernel doesn't have
all the information it needs.  However, there is a QoS subsystem which
may help you.

There's also tweaks available via
/sys/devices/system/cpu/cpu*/power/pm_qos_resume_latency_us

which can be poked to configure the latency that is required, and will
prevent the deeper PM states being entered.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC for 0.8m (est. 1762m) line in suburbia: sync at 13.1Mbps down 424kbps up
