Return-Path: <linux-pm+bounces-24063-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6CDA61338
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 14:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F523B0B20
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 13:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A163420013A;
	Fri, 14 Mar 2025 13:58:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB01200130
	for <linux-pm@vger.kernel.org>; Fri, 14 Mar 2025 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741960711; cv=none; b=MMCJzo4kIlPq7sk6iKaRrKuZuj5t9qe/YaQXubP/9vjfk/QkjSckzSR2M28sWh8EUF/K7PucB9xtgQQIE/s4lxhPMFqlvZqJX8BpUu41vce6I/kO3FfS1jqbNyuC2FmcVB6PADZnCZ5BuDIxbu+outyipgQRo/3Ln7OM7thcayA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741960711; c=relaxed/simple;
	bh=KbSfhs000aWL/fVzPlgvuOymFrW/+1ewrl9D2gJNWaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+AZ3s5AGdySOU1p3LRYjyN1bwH4QaRiNLb1UEYU+6QNpHcbeXNOsqUHfquwTxUbqKdF0gshgwfCI7H4SQlH6Sv3pk3RZsbqcu18J4uWK2RDvaj5aF6sqcwRvErFWzGrJMQUpjCKWkfGQ6MLaAo4KtGnY8pGK0r2L+LqelQNJA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tt5YB-0007Oz-W5; Fri, 14 Mar 2025 14:58:12 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tt5YB-005iFQ-0G;
	Fri, 14 Mar 2025 14:58:11 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tt5YA-00DAzU-35;
	Fri, 14 Mar 2025 14:58:10 +0100
Date: Fri, 14 Mar 2025 14:58:10 +0100
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
Subject: Re: [PATCH v6 3/7] power: reset: Introduce PSCR Recording Framework
 for Non-Volatile Storage
Message-ID: <Z9Q18k_wu1JQxrtJ@pengutronix.de>
References: <20250314113604.1776201-1-o.rempel@pengutronix.de>
 <20250314113604.1776201-4-o.rempel@pengutronix.de>
 <58e19481-530c-4465-aec5-1f44462eaf5f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58e19481-530c-4465-aec5-1f44462eaf5f@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

Hi Matti,

Thanks for your feedback and for taking the time to review this patch series! 

On Fri, Mar 14, 2025 at 02:22:40PM +0200, Matti Vaittinen wrote:
> Hi deee Ho Oleksij,
> 
> On 14/03/2025 13:36, Oleksij Rempel wrote:
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
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> I see you're already at v6, so I am probably slightly late... I think I
> hadn't noticed this before. Thus, feel free to treat my comments as mere
> suggestions.
> 
> All in all, I do like this series. Looks mostly very good to me :) Just
> wondering if we could utilize this same for standardizing reading the reset
> reason registers which are included in many PMICs?
> 
> > ---
> 
> ...
> 
> > +int pscrr_core_init(const struct pscrr_backend_ops *ops)
> > +{
> > +	enum psc_reason stored_val = PSCR_UNKNOWN;
> > +	int ret;
> > +
> > +	mutex_lock(&pscrr_lock);
> > +
> > +	if (g_pscrr) {
> > +		pr_err("PSCRR: Core is already initialized!\n");
> > +		ret = -EBUSY;
> > +		goto err_unlock;
> > +	}
> > +
> > +	if (!ops->read_reason || !ops->write_reason) {
> > +		pr_err("PSCRR: Backend must provide read and write callbacks\n");
> 
> Why both are required?
> 
> I can easily envision integrating the some PMIC's 'boot reason' register
> reading to the PSCRR. Benefit would be that user-space could use this same
> interface when reading the reset reason on a system where reason is stored
> using mechanisms provided by this series - and when reset reason is
> automatically stored by the HW (for example to a PMIC).
> 
> In a PMIC case the write_reason might not be needed, right?
 
I agree that PMICs could be valuable sources of reset reasons, and integrating 
them into PSCRR makes sense. However, this introduces new challenges when 
multiple providers exist on the same system, each reporting different power 
state change reasons.

Handling Multiple Read-Only Providers (PMIC, Firmware, etc.):
- If we have multiple sources (e.g., PMIC, firmware logs, NVMEM-based storage), 
  we need to define how to handle conflicting or differing reset reasons.
- Using priorities may work in simple cases but is unlikely to scale well
  across different platforms.
- A more flexible solution would be to expose all read-only providers
  separately, rather than forcing one to override others.

Potential UAPI and Sysfs Structure
- The current sysfs API exposes:
  - `/sys/kernel/pscrr/reason` → Default recorder
  - `/sys/kernel/pscrr/reason_boot` → Last stored reason on default recorder
     from before boot
- If we introduce read-only providers (like PMICs), we may need a dedicated 
  subdirectory to keep them separate.
- A possible structure:
  ```
  /sys/kernel/pscrr/
  ├── reason         # Default recorder
  ├── reason_boot    # Default recorder (before boot)
  ├── providers/
  │   ├── pmic0      # Read-only reset reason from PMIC
  │   ├── firmware   # Reset reason from firmware logs
  │   ├── another_provider
  ```
- This would allow user-space tools to query all available sources while keeping 
  the default recorder behavior intact.

Next Steps
- I propose keeping this patch series focused on the default PSCRR recorder.
- Support for multiple read-only providers should be designed as a future 
  extension, possibly with an expanded sysfs API.

Would you agree that this approach keeps things maintainable while allowing 
for future extensibility? Also, do you have a preference for naming the 
subdirectory (`providers/`, `sources/`, etc.)?

Thanks again for your feedback!

Best regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

