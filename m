Return-Path: <linux-pm+bounces-26543-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C96F0AA6A1C
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 07:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A1557A47AE
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 05:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639F51C863B;
	Fri,  2 May 2025 05:23:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FC61C5F18
	for <linux-pm@vger.kernel.org>; Fri,  2 May 2025 05:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746163411; cv=none; b=Drkq8OUtbab3HxURKVC5/zQ6K1PMuU696myGiaP2F8tQfcrmTsRyLkPzKqONIUNtXPDiSgJe/tlYoJqAymGqkarcdeNax48HIqm8WeR8R26WxZ8KiaouglRxStPuaYswisNeH9k2xoGBs7oMoQ2BHFC8H+xbpN6Hs5WttzF3qGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746163411; c=relaxed/simple;
	bh=D99X97H0h0egYlqmZ2qyx2bGB/WuCPs4SWCP3Auk0hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTJt1EItI7CYnZQ7hcTvOuExe96Rl/gwZh7vXCNCc/uAaoxME2alP3lo9Ll9/5t+WqpWAW/UkrX9VrvLtVSy3Z/fVNgJy1RGBHoU8AKMvhQwR+X1cmE/QxZ1jhVPpAZxGUrsEurzuUKB/sa/lWYISXIqm6OBEwcezdM/349FwsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uAirS-0004Qb-Gu; Fri, 02 May 2025 07:22:58 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uAirP-000he0-35;
	Fri, 02 May 2025 07:22:55 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uAirP-00GTlC-2X;
	Fri, 02 May 2025 07:22:55 +0200
Date: Fri, 2 May 2025 07:22:55 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>,
	Guenter Roeck <groeck@chromium.org>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v9 3/7] power: reset: Introduce PSCR Recording Framework
 for Non-Volatile Storage
Message-ID: <aBRWrwY6YN0526SN@pengutronix.de>
References: <20250422085717.2605520-1-o.rempel@pengutronix.de>
 <20250422085717.2605520-4-o.rempel@pengutronix.de>
 <bumx6ma3kjanapwaf3oc3mdjnekatvc2cmavt6secfkaapgjpz@kouqjidbl47k>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bumx6ma3kjanapwaf3oc3mdjnekatvc2cmavt6secfkaapgjpz@kouqjidbl47k>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

Hi Sebastian,

Thanks for the feedback.

On Fri, May 02, 2025 at 01:20:50AM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Apr 22, 2025 at 10:57:13AM +0200, Oleksij Rempel wrote:
> > This commit introduces the Power State Change Reasons Recording (PSCRR)
> > framework. It provides a generic mechanism to store shutdown or reboot
> > reasons, such as under-voltage, thermal events, or software-triggered
> > actions, into non-volatile storage.
> > 
> > PSCRR is primarily intended for systems where software is able to detect
> > a power event in time and store the reason—typically when backup power
> > (e.g., capacitors) allows a short window before shutdown. This enables
> > reliable postmortem diagnostics, even on devices where traditional storage
> > like eMMC or NAND may not survive abrupt power loss.
> > 
> > In its current form, PSCRR focuses on software-reported reasons. However,
> > the framework is also designed with future extensibility in mind and could
> > serve as a central frontend for exposing hardware-reported reset reasons
> > from sources such as PMICs, watchdogs, or SoC-specific registers.
> > 
> > This version does not yet integrate such hardware-based reporting.
> 
> This adds quite some complex code for a very specific problem while
> mostly ignoring the common case of hardware reported reasons. I think
> having at least one hardware-reported reasons (e.g. WDOG) is mandatory
> to make sure the framework can really handle it.

The initial purpose of the PSCRR framework is to record power state
change reasons such as *undervoltage* or *regulator failures*, which can
be detected and stored by software just before shutdown. Supporting
hardware-reported reset reasons (like watchdog, PMIC, or SoC registers)
is possible by design — the interface allows it — but it’s not something
I consider mandatory for the initial version.

I’d prefer to focus on solving one concrete problem at a time, and the
current use case is already well-supported with software-side logic.

> I also see you extended power_on_reason.h and included it here

You're right — the `#include <linux/power/power_on_reason.h>` is no
longer used directly in `pscrr.c` and will be removed in the next
revision.

> but
> don't actually use the defined strings at all. Also you create the
> new enum, but don't handle the existing reasons and just add the new
> codes you need instead of making sure things are properly in-sync :(

Could you please clarify what exactly you mean here? The strings defined
in `power_on_reason.h` are still used indirectly via
`psc_reason_to_str()`, which is called in the reboot core and used by
PSCRR for logging (e.g., in `pscrr_reboot_notifier()` and
`pscrr_core_init()`). If your concern is about the enum values
themselves or something else, I'd appreciate a bit more detail.

> > [...]
> 
> > +struct pscrr_core {
> > +	struct mutex lock;
> > +	struct pscrr_backend *backend;
> > +	/* Kobject for sysfs */
> > +	struct kobject *kobj;
> > +	struct notifier_block reboot_nb;
> > +} g_pscrr = {
> > +	.lock = __MUTEX_INITIALIZER(g_pscrr.lock),
> > +};
> 
> Apart from the highlevel problems I have with this:
> 
> g_pscrr can be static
> 
> -- Sebastian

Best regards,  
Oleksij

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

