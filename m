Return-Path: <linux-pm+bounces-35680-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B34BB3D52
	for <lists+linux-pm@lfdr.de>; Thu, 02 Oct 2025 14:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED7C19C32FA
	for <lists+linux-pm@lfdr.de>; Thu,  2 Oct 2025 12:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FEB3101BD;
	Thu,  2 Oct 2025 12:00:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212D03101B0
	for <linux-pm@vger.kernel.org>; Thu,  2 Oct 2025 12:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759406446; cv=none; b=rOETIkTUF5dsLASUXhOsWUij9z93GkDsqRpCNB+IF8vb8Sck6thXTntNDoKVdzrwaeAuPpPT19iJ9Fn0EQ7BUk4lf0R7EgjBtWafgye4NQ4yO53RAVKsZK6KUAM9PZI8AtbnUcNJFt9izw/UXH3icrrkvwWXFacfbYcBfmR5x14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759406446; c=relaxed/simple;
	bh=zlFrpOe0HrWRYD2Vb3aRVlnCqzPgkaXM7sG+IHktRWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prtsC1+lgDysezEvfTJNwDkQBVtkTRK5JR4wtjeSBvOYobXEdXLdLlpGzd/7fUBDrNrZSatvvrNIZVYT2tT7X6eZ5GF2ESYtsQIpiFim+p/exAzvX1WxC8xeMF8jzylEBzuDJ/bPDnUMYUNeKZO4gdTAxlE/7hFz2PCyuu+1AgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1v4Hyl-00083q-Gr; Thu, 02 Oct 2025 14:00:11 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1v4Hyj-001ZsI-0p;
	Thu, 02 Oct 2025 14:00:09 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1v4Hyj-008S1y-0P;
	Thu, 02 Oct 2025 14:00:09 +0200
Date: Thu, 2 Oct 2025 14:00:09 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>,
	Guenter Roeck <groeck@chromium.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: RFC: Selecting an NVMEM cell for Power State Change Reason (PSCR)
 recording
Message-ID: <aN5pSWBFRZlNRv3U@pengutronix.de>
References: <20250618120255.3141862-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250618120255.3141862-1-o.rempel@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

Hi all,

I'm seeking consensus on a minimal, upstream-acceptable way to identify the
single NVMEM cell used to persist a Power State Change Reason (PSCR). Typical
targets are battery-backed RTC scratchpads or small EEPROM. The aim is to have
a tiny breadcrumb available before userspace, across full power cuts, and
shared by bootloader/kernel/userspace.

DT vs Userspace vs ACPI

* DeviceTree (preferred): Describing where the storage lives under a real
  NVMEM provider (RTC/EEPROM) is early, robust, and OS-agnostic.

* Userspace (fallback): Possible via module/cmdline/sysfs, but leaves an
  early-boot window unconfigured and reduces usefulness for embedded devices.

* ACPI: No existing shared mechanism for this use case at present (not
  proposing an ACPI path right now).

What implementations were tried

* A PSCR consumer node in DT -> NACKed as not a HW node.

* Kernel/module parameters or sysfs selection -> tried earlier, but rejected
  for new designs and cannot guarantee early availability.

* Name-based lookups in NVMEM -> considered fragile and not scalable.

Other options which came in question (seeking guidance)

* cell-level `compatible` on a fixed-cell child (analogous to `mac-base`) to
  nominate the PSCR cell under the existing NVMEM provider. DT remains purely
  descriptive (location/size); encoding is documented outside DT and shared
  across components.

* `/chosen` phandle pointing to the nominated fixed-cell (simple to discover;
  unsure about policy concerns).

* pstore integration (not tried): a backend that uses a nominated NVMEM cell if
  such a nomination is acceptable.

* nvmem-layout usage (not tried): provider-side markup of the region to
  indicate it carries PSCR, if that pattern is acceptable for this purpose.

* Open to any established precedent for nominating a specific NVMEM cell for a
  system role without introducing software/virtual DT nodes.

Ask

* Is a cell-level `compatible` on a `fixed-cell` child an acceptable way to
  nominate the PSCR cell?

* If not, is a `/chosen` phandle acceptable here, or is there a preferred
  alternative?

Thanks for guidance - once the selection mechanism is agreed, I can respin the
PSCR series accordingly.

Latest patch version: https://lore.kernel.org/all/aHTZTFxfS6Bn4yhz@pengutronix.de/

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

