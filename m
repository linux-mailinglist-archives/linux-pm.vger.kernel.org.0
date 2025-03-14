Return-Path: <linux-pm+bounces-24064-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B234A6135E
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 15:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A73119C14CD
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 14:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67311200B99;
	Fri, 14 Mar 2025 14:10:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D6E1EB3E
	for <linux-pm@vger.kernel.org>; Fri, 14 Mar 2025 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741961443; cv=none; b=F7b3Z3azOPIkkfCK2h4obcTK+9vzNTLXPVtaarehixAAT7qwNF+QTTK8JVBXQf/iqldvOBo8CVvFrMsN+cOVotBjpQsHzzop2CkSgkB+HmgvlbpXTgTNzaF+XCcTbvWocC8SVjDZ/PJrYcrNlEVyI8wf3wt3eGFDKWlQfrjE9wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741961443; c=relaxed/simple;
	bh=C5toxvwiwwhMhsd9e2XE4L4Jrk1EIjC5qUAeyoJngFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptF3kr44bA3u1GdUopsfp6faAoyTu+W0ptW2JwNhmr9q7UoWEH0chDH0bqPIRS4jpwspgP0ff3B6wl5aH7nJ42SuT7XCve8bMmQ6KhwDQTJQA+2EfJVg1nG4H6If8AwhsbFBYce5hG6sEI4S2R8OV2z2dKHFgG9k6F99zsyhSr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tt5k1-0000lP-74; Fri, 14 Mar 2025 15:10:25 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tt5jz-005iXB-2e;
	Fri, 14 Mar 2025 15:10:23 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tt5jz-00DBIm-2G;
	Fri, 14 Mar 2025 15:10:23 +0100
Date: Fri, 14 Mar 2025 15:10:23 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel@pengutronix.de,
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
Subject: Re: [PATCH v6 7/7] Documentation: Add sysfs documentation for PSCRR
 reboot reason tracking
Message-ID: <Z9Q4z2dPdpqVcu6u@pengutronix.de>
References: <20250314113604.1776201-1-o.rempel@pengutronix.de>
 <20250314113604.1776201-8-o.rempel@pengutronix.de>
 <a8f76dd0-56be-46a5-9cc1-2d17d013127d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a8f76dd0-56be-46a5-9cc1-2d17d013127d@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

On Fri, Mar 14, 2025 at 03:38:55PM +0200, Matti Vaittinen wrote:
> On 14/03/2025 13:36, Oleksij Rempel wrote:
> > Add documentation for the Power State Change Reason Recorder (PSCRR)
> > sysfs interface, which allows tracking of system shutdown and reboot
> > reasons. The documentation provides details on available sysfs entries
> > under `/sys/kernel/pscrr/`, explaining their functionality, example usage,
> > and how they interact with different backend storage options (e.g., NVMEM).
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >   .../ABI/testing/sysfs-kernel-reboot-pscrr     | 46 +++++++++++++++++++
> >   1 file changed, 46 insertions(+)
> >   create mode 100644 Documentation/ABI/testing/sysfs-kernel-reboot-pscrr
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-kernel-reboot-pscrr b/Documentation/ABI/testing/sysfs-kernel-reboot-pscrr
> > new file mode 100644
> > index 000000000000..7cc643f89675
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-kernel-reboot-pscrr
> > @@ -0,0 +1,46 @@
> > +What:		/sys/kernel/pscrr/reason
> > +Date:		April 2025
> > +KernelVersion:  6.15
> > +Contact:	Oleksij Rempel <o.rempel@pengutronix.de>
> > +Description:
> > +		This file provides access to the last recorded power state
> > +		change reason. The storage backend is configurable and, if
> > +		supported, the reason may be stored persistently in an
> > +		NVMEM cell or another backend.
> > +
> > +		Reading this file returns an integer representing the last
> > +		recorded shutdown or reboot cause.
> > +
> > +		Writing an integer value to this file sets the reason to be
> > +		stored and recorded for system analysis.
> > +
> > +		Example usage (values are for illustration and may not reflect
> > +		actual reasons used in a given system):
> > +		  Read:
> > +			$ cat /sys/kernel/pscrr/reason
> > +			3   # (Example: Power loss event, may differ per system)
> > +
> > +		  Write:
> > +			$ echo 5 > /sys/kernel/pscrr/reason
> > +			# Sets the reason to 5 (Example: User-triggered reboot,
> > +			# this may not be a real value in your system)
> > +
> > +		Values are defined in:
> > +		  - `include/linux/reboot.h` (enum psc_reason)
> 
> Is it possible to provide the reason (also) as string?
> 
> I believe we should fix the meaning of the numbers so the ABI is not
> changing for the users. Hence we could as well document the meaning of the
> values(?) If I read the suggestion right, we will in any case have
> predefined set of reasons in the kernel side.
> 
> Or, am I missing something?

Yes, it is correct, the values should be fixed for user space. Should
they be documented in this documentation too?
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

