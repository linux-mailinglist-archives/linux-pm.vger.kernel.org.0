Return-Path: <linux-pm+bounces-24251-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E1EA674D7
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 14:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495C2188DF5A
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 13:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EF920C46A;
	Tue, 18 Mar 2025 13:19:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AFC206F22
	for <linux-pm@vger.kernel.org>; Tue, 18 Mar 2025 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742303968; cv=none; b=j3V0ZKuh/ejTxYhSKRfCc6n2SnguVCUgzeJUMh9auFbC+eDA1RDpaPM0XFf66P3Inr3ZDgBT9OnW1olvHw0QRqklIf7Eh2kRAzXLFOkrYR0fNPD3VJjMj7mWe47HmWxh2KwAdF8Zj9p6zqKDtHpWpzxfAcpYQE82DAl/7Y1tX9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742303968; c=relaxed/simple;
	bh=pMKTPI3CtphXn0aZ69uxiZeoXzDanrh/Zv+eCgGWMGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYEePEeHR4mJqxJBX/8bLF/a7XAVcFKxYTsRCzF/wRDc/IuEgbaj9RVJeQfAlZe87H3IOKQsC0QsOedDYy1VuqWF+t10j4woBLdl9I0wOS0rFNrCiTG7HvNRBaWGP3YSTy6OkAAT4jS1ORqg7S387pxjZy7PnSCEtEXhoEI/0q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tuWqo-0004E2-2F; Tue, 18 Mar 2025 14:19:22 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tuWqm-000Qyj-2W;
	Tue, 18 Mar 2025 14:19:21 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tuWqn-00333k-0E;
	Tue, 18 Mar 2025 14:19:21 +0100
Date: Tue, 18 Mar 2025 14:19:21 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	chrome-platform@lists.linux.dev,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>,
	Guenter Roeck <groeck@chromium.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH v7 3/7] power: reset: Introduce PSCR Recording Framework
 for Non-Volatile Storage
Message-ID: <Z9ly2eC0_r3gyToy@pengutronix.de>
References: <20250318094716.3053546-1-o.rempel@pengutronix.de>
 <20250318094716.3053546-4-o.rempel@pengutronix.de>
 <ea681b76-db1c-4529-bd53-09e4bf384977@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ea681b76-db1c-4529-bd53-09e4bf384977@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

On Tue, Mar 18, 2025 at 01:01:30PM +0200, Matti Vaittinen wrote:
> On 18/03/2025 11:47, Oleksij Rempel wrote:
> > This commit introduces the Power State Change Reasons Recording (PSCRR)
> > framework into the kernel. The framework is vital for systems where
> > PMICs or watchdogs cannot provide information on power state changes. It
> > stores reasons for system shutdowns and reboots, like under-voltage or
> > software-triggered events, in non-volatile hardware storage. This
> > approach is essential for postmortem analysis in scenarios where
> > traditional storage methods (block devices, RAM) are not feasible. The
> > framework aids bootloaders and early-stage system components in recovery
> > decision-making, although it does not cover resets caused by hardware
> > issues like system freezes or watchdog timeouts.
> 
> We might want to rephrase this if we envision that boot reason could be read
> from PMICs (or other devices able to store the boot reason) using PSCRR
> interface. (Because a few PMICs can store the boot reason even for the
> hardware initiated shutdowns like Watchdog or voltage/current protection).

ack.

> > It is primarily intended for controlled power
> > +	  state transitions.
> > +
> > +	  If unsure, say N.
> > diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> > index 10782d32e1da..dbd6ae6b26a4 100644
> > --- a/drivers/power/reset/Makefile
> > +++ b/drivers/power/reset/Makefile
> > @@ -32,6 +32,7 @@ obj-$(CONFIG_POWER_RESET_KEYSTONE) += keystone-reset.o
> >   obj-$(CONFIG_POWER_RESET_SYSCON) += syscon-reboot.o
> >   obj-$(CONFIG_POWER_RESET_SYSCON_POWEROFF) += syscon-poweroff.o
> >   obj-$(CONFIG_POWER_RESET_RMOBILE) += rmobile-reset.o
> > +obj-$(CONFIG_PSCRR) += pscrr.o
> >   obj-$(CONFIG_REBOOT_MODE) += reboot-mode.o
> >   obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
> >   obj-$(CONFIG_POWER_RESET_SC27XX) += sc27xx-poweroff.o
> > diff --git a/drivers/power/reset/pscrr.c b/drivers/power/reset/pscrr.c
> > new file mode 100644
> > index 000000000000..466eca0e4f7f
> > --- /dev/null
> > +++ b/drivers/power/reset/pscrr.c
> > @@ -0,0 +1,417 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * pscrr_core.c - Core Power State Change Reason Recording
> > + *
> > + * This framework provides a method for recording the cause of the last system
> > + * reboot, particularly in scenarios where **hardware protection events** (e.g.,
> > + * undervoltage, overcurrent, thermal shutdown) force an immediate reset.
> 
> Is this contradicting the Kconfig / commit message?

There is so many redundant text, i already lost track of it.  What do
you mean?

> 
> > Unlike
> > + * traditional logging mechanisms that rely on block storage (e.g., NAND, eMMC),
> > + * PSCRR ensures shutdown reasons are preserved in a way that survives power
> > + * loss for later analysis.
> 
> Here, the 'level of power-loss' plays a role, right? I assume some level of
> power must be retained for the 'storage' to stay alive.

Yes, on the system I'm working on, there is designed capacity and
voltage drop detector to do $THINGS before the system will go off. To
get the full picture you may take a look to following patches:

https://lore.kernel.org/all/20231026144824.4065145-1-o.rempel@pengutronix.de
https://lore.kernel.org/all/20250310102229.381887-1-o.rempel@pengutronix.de

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

