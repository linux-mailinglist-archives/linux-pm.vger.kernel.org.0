Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69D9284296
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 00:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgJEWgu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Oct 2020 18:36:50 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:34024 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgJEWgr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2020 18:36:47 -0400
Received: from relay10.mail.gandi.net (unknown [217.70.178.230])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 40F323A8667;
        Mon,  5 Oct 2020 22:30:17 +0000 (UTC)
Received: from localhost (lfbn-lyo-1-1908-165.w90-65.abo.wanadoo.fr [90.65.88.165])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 0AA07240002;
        Mon,  5 Oct 2020 22:29:53 +0000 (UTC)
Date:   Tue, 6 Oct 2020 00:29:53 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     a.zummo@towertech.it, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        len.brown@intel.com, pavel@ucw.cz,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [Question] rtc wake behavior and sysfs
Message-ID: <20201005222953.GD2804081@piout.net>
References: <CAMdYzYrYdDYF_Y_TwQ65u=Ymu2_8Rs9KWm_TfXcaPGTwucT=jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMdYzYrYdDYF_Y_TwQ65u=Ymu2_8Rs9KWm_TfXcaPGTwucT=jg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05/10/2020 09:13:08-0400, Peter Geis wrote:
> Good Morning,
> 
> While testing suspend to ram on the Ouya, I encountered an interesting
> issue with the rtc-tps65910 driver.
> Attempting to use rtc-wake on the default configuration returned:
> rtcwake: /dev/rtc0 not enabled for wakeup events
> This is due to:
> eb5eba4ef722 drivers/rtc/rtc-tps65910.c: enable/disable wake in suspend/resume
> This commit changed this driver's behavior to not enable wakeup by
> default, but enables it when entering sleep mode.
> This seems to be odd behavior to me.
> Looking at a few other rtc drivers show they simply enable themselves
> as wakeup sources by default.
> 
> I also found the sysfs entries are at /sys/devices/ ..
> /tps65910-rtc/power but are missing at /sys/class/rtc/rtc0/power/
> 
> I have two questions.
>  - Should the sysfs wakeup entries be missing at /sys/class/rtc/rtc0/power/ ?

I would be in /sys/class/rtc/rtc0/device/power

>  - Shouldn't a rtc be enabled as a wakeup source by default?
> 

The short answer is no, the reason being that not all RTCs are connected
to an IRQ or a pin that can wakeup or start the platform. What should be
done is enabling wakeup only when interrupts are available or the
wakeup-source property is in the rtc device tree node.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
