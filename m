Return-Path: <linux-pm+bounces-29172-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D9FAE21FA
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 20:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 004E57B0E67
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 18:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9215A284662;
	Fri, 20 Jun 2025 18:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="n4GjbPnC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="Ai0PM/MS"
X-Original-To: linux-pm@vger.kernel.org
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51EF21516E;
	Fri, 20 Jun 2025 18:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750443366; cv=pass; b=dBvqu8kcHuWjzuQ9CjXfdVl4xVcKAzNwdeLVBUwANKNzBXgECydcC24arPLXtpOAduZpoRubbUUkA9+sfFjEO4bAtTGZu9dm2Mi2qaDssyEPR7q2/XFEtco1l5mSspRoccNU7H9D2Q9NuqNfrTk35absP5gK85ufutk6tqQT3bQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750443366; c=relaxed/simple;
	bh=5xnwn57hToUPm8QF6wQM7Wxtz/nSB0bNz8XLEqhjj0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CcgMDchsYXBTd2L8fxSDXDggm9eVtlJFr9bFR/QVt2mlplpcj6w4w3UYTK9RY1l8W2P4KXkTabkf40QeUzinBP+2l/0ikr3GE5icY/sAm7wCyI8hyFOWs8W85HnAU9IAupff+trzKLW6i5AlOeR//Co13eii2z+VloDIv+Z6g4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=n4GjbPnC; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=Ai0PM/MS; arc=pass smtp.client-ip=185.56.87.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=instance-europe-west4-srw8.prod.antispam.mailspamprotection.com; s=arckey; t=1750443363;
	 b=KeT/n9feh9wPIC40j49ZpdG6Nnp3UH0voYtAFPOeWprKWu3SYhgprSzz+XFA4bk/4iq+NJ0Qli
	  q0HDf843vvKwTYa4SCag90guUGetZ1lQchQ8V3nDVf2mlJbVUCPh4vArYPQUJ/80H/CHjXcgsl
	  +Yq/237vc292pC2/8dKUFqD45TTkopYeKgllpx4KzYNoeYU4YgPbfE0dZW5vnh7D3llAIw2Kf9
	  khdGRvA3VaK5IEVEeZXH3eYwJxovRoGoAz3IpnQQ1awtVYvgHcMKWgia7uwcLxv52R5xelhLai
	  VKv67uIXbGx+Y11pMoFCWl5TDgmX9GHMZm8bAF4hmm9vVQ==;
ARC-Authentication-Results: i=1; instance-europe-west4-srw8.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=instance-europe-west4-srw8.prod.antispam.mailspamprotection.com; s=arckey; t=1750443363;
	bh=5xnwn57hToUPm8QF6wQM7Wxtz/nSB0bNz8XLEqhjj0o=;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	  Message-ID:Date:Subject:Cc:To:From:DKIM-Signature:DKIM-Signature;
	b=Z0qoFNAr1t1IdGLay//CKw5YKYNwmF4Hd2CvJTOO/ne0Ni0XQV6YnZJ5b8umt+mKx3nEDTY+ul
	  2gh1Rpb8k2BUxOviCvyf76ZvKmcVi2VkrtW49MOrs8dX/BL/ybbTWk+tLKoGU6d0N7z+F2XtbA
	  N55FQ1N5EhK6iHoLtsiIXaIlUFXEEuWjXeH4XFMESnjRYGqFUp2/k2XErPqPrVGkF/eo6MJmS5
	  e1na/WvFtrVc+dXOvaQXs5qzPiRROWPHhP0FSR6fB6ARY2NDZfsgtDkDRg4/8VwvTF57BNDWp8
	  1S/V7Nxz8ky3yid1jCOmkg+9KbT/Bvth5BX4aSImRYWwsQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Reply-To:List-Unsubscribe;
	bh=3LVEzoRSold9GVypbu5ltp+xX0GVkhV3+mynLXoiQZA=; b=n4GjbPnCloUpXz4rNw7cWhCIP7
	Gv5+coj9Veu7Ymm4XagwPo/SBLCu/KUBjHBQk5AkkHunVKdpI3HSTBg/jBvMdL27O9apzm/wiSbI1
	gvCAB+mi03u14W6XBeh9ZAme+Z6l9rmivf8Ex0M/h/qRCnBHSmOb0mRBQUq+K3CrDktI=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-s8d9.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1uSe6B-00000008F2G-1mcI;
	Fri, 20 Jun 2025 15:56:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Date:Subject:Cc:To:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=3LVEzoRSold9GVypbu5ltp+xX0GVkhV3+mynLXoiQZA=; b=Ai0PM/MSA3RrtHq/pVxozvFBb1
	eYVoaJKyULwWR+OuPDhBoQCzgNUu84c0SH9K0+RYSSZOUheO9JMqU/Ajm6YFQeJGKiVD7OFwd+sSb
	ImY9RfmBPzb730BHd6NwTaOM6tWfPejdC2ZQfMLBmdJhiPvYQs6j0qO+q2GmeZE/q8Kk=;
Received: from [82.60.196.243] (port=62607 helo=fedora-2.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1uSe5y-00000000DoG-1ZGg;
	Fri, 20 Jun 2025 15:56:02 +0000
From: Francesco Valla <francesco@valla.it>
To: Sebastian Reichel <sre@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-pm@vger.kernel.org, =?UTF-8?B?U8O4cmVu?= Andersen <san@skov.dk>,
 Guenter Roeck <groeck@chromium.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, chrome-platform@lists.linux.dev
Subject:
 Re: [PATCH v11 6/7] power: reset: add PSCR NVMEM Driver for Recording Power
 State Change Reasons
Date: Fri, 20 Jun 2025 17:56:01 +0200
Message-ID: <3135893.lGaqSPkdTl@fedora-2.fritz.box>
In-Reply-To: <20250618120255.3141862-7-o.rempel@pengutronix.de>
References:
 <20250618120255.3141862-1-o.rempel@pengutronix.de>
 <20250618120255.3141862-7-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 2ae7087a56985d2acc2a7b87f96cc4c3
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1uSe6B-00000008F2G-1mcI-feedback@antispam.mailspamprotection.com
Authentication-Results: instance-europe-west4-srw8.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hi Oleksij,

On Wednesday, 18 June 2025 at 14:02:54 Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> This driver utilizes the Power State Change Reasons Recording (PSCRR)
> framework to store specific power state change information, such as
> shutdown or reboot reasons, into a designated non-volatile memory
> (NVMEM) cell.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> changes v6:
> - rename pscr_reason to psc_reason
> changes v5:
> - avoid a build against NVMEM=m
> changes v4:
> - remove devicetree dependencies
> ---
>  drivers/power/reset/Kconfig       |  22 +++
>  drivers/power/reset/Makefile      |   1 +
>  drivers/power/reset/pscrr-nvmem.c | 254 ++++++++++++++++++++++++++++++
>  3 files changed, 277 insertions(+)
>  create mode 100644 drivers/power/reset/pscrr-nvmem.c
> 

Tested-by: Francesco Valla <francesco@valla.it>

I tested this on a i.MX93 FRDM using the on-board EEPROM as storage and
a single-byte cell. Unfortunately, the on-board RTC does not have a
scratchpad.

PSCR was set in two different ways during subsequent tests:

 - manually from userspace
 - simulating a over-temperature condition through the emul_temp sysfs

In both cases, it was re-read correctly after reboot.

This will be very useful to detect and debug anomalous shutdowns or
reboots on the field.

Thank you!

Regards,
Francesco



