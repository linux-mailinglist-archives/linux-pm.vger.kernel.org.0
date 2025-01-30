Return-Path: <linux-pm+bounces-21153-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 203E0A23410
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 19:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CE6A16629A
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 18:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9911F03F4;
	Thu, 30 Jan 2025 18:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="KVdAgxz3"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419BF143888;
	Thu, 30 Jan 2025 18:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738262941; cv=none; b=i0/11UWkgHtW9vRAjOjs6AkhvK0pXE/O9eEo1yxR221OabbjVDJb+ghptcEysor1gOTA0eYkSpdBcyyMTd8P3vg9NRM8ah39V2DxbP00EwUD7rPQQFD461iiO/qYvyMNn1RBJQddgImX1iRZQ12HCdGQSFF/1nlHNpqu0VcfOyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738262941; c=relaxed/simple;
	bh=uEEp21nuR71FWwVLVbRo6IDc8exQyAbnNKbKPl3rNGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1Wa+kxgjE12jsysdtyC+9hPkPi1hNVxeBfZhIs1p7SbSxRe9a8SSXuIWGVR1DRRa5sEYzdh23cHBfx3Ne2VzEUjaDgtkqzQIcJ9x8ZXeylWA1GZXgMfmdmxJFIuGyZix8Pv7eEO5HMgENwg12N0sL/7mO1sc23yQtwWDke751Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=KVdAgxz3; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1738262327;
	bh=uEEp21nuR71FWwVLVbRo6IDc8exQyAbnNKbKPl3rNGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KVdAgxz3BotLorHMdxsHDSmOVBJ7PoPZ0zkj54ZPte5v+g5RyPQDqb5jL8AGfe5ke
	 deacUAb9bwOrbjRhX2LDeYOacO26IaqZviE4SjK1GXTkQt7YlZ4wQsYiUxpGaQokue
	 u3xRTthLptPOM0KR5xgrmGl+V8KfREAquBfIaeY4=
Date: Thu, 30 Jan 2025 19:38:46 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org, Armin Wolf <W_Armin@gmx.de>
Subject: Re: [PATCH] power: supply: core: Fix extension related lockdep
 warning
Message-ID: <da321bd8-452d-42b1-8b69-aa88ac6e08bc@t-8ch.de>
References: <20250130140035.20636-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250130140035.20636-1-hdegoede@redhat.com>

On 2025-01-30 15:00:35+0100, Hans de Goede wrote:
> Since commit 6037802bbae8 ("power: supply: core: implement extension API")
> there is the following ABBA deadlock (simplified) between the LED trigger
> code and the power-supply code:
> 
> 1) When registering a power-supply class device, power_supply_register()
> calls led_trigger_register() from power_supply_create_triggers() in
> a scoped_guard(rwsem_read, &psy->extensions_sem) context.
> led_trigger_register() then in turn takes a LED subsystem lock.
> So here we have the following locking order:
> 
> * Read-lock extensions_sem
> * Lock LED subsystem lock(s)
> 
> 2) When registering a LED class device, with its default trigger set
> to a power-supply LED trigger (which has already been registered)
> The LED class code calls power_supply_led_trigger_activate() when
> setting up the default trigger. power_supply_led_trigger_activate()
> calls power_supply_get_property() to determine the initial value of
> to assign to the LED and that read-locks extensions_sem. So now we
> have the following locking order:
> 
> * Lock LED subsystem lock(s)
> * Read-lock extensions_sem
> 
> Fixing this is easy, there is no need to hold the extensions_sem when
> calling power_supply_create_triggers() since all triggers are always
> created rather then checking for the presence of certain attributes as
> power_supply_add_hwmon_sysfs() does. Move power_supply_create_triggers()
> out of the guard block to fix this.

<snip>

> Fixes: 6037802bbae8 ("power: supply: core: implement extension API")
> Cc: Thomas Weißschuh <linux@weissschuh.net>
> Cc: Armin Wolf <W_Armin@gmx.de>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Thanks!
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>

