Return-Path: <linux-pm+bounces-8466-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60958D6128
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 14:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48DC2B21B2C
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 12:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3839B156C7C;
	Fri, 31 May 2024 12:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eg7YTzhI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB7729A0;
	Fri, 31 May 2024 12:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717156889; cv=none; b=ZEGMt1fNLYVqYfWC8fGf3RpOBJW5tLFf491MlsLhzghj3kWXmUxWS+zGyPcyJZYggxKjI5Y3cq6xo853f/TYCaGOS62Wqbz9TDXPjeWYOgP9k9ghVQGLOHkajQ3IrOyYChbNNT5aoi96A0+8WZpzyHxywa5uDlKzftw9jPLbeH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717156889; c=relaxed/simple;
	bh=OGmPL9Uk8asTqJ72NesPKkQ57yKobdJU/tqU+fjRcRM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NCVayJR9WrFlfCciphujgExC1gfwX2e3eV/MaI2Lty3RNI+YJVlFstEuSFfHub6KoJRrxMgaFfLmzIUmpJgueSw/3ULA0T6tys9F6D/239liuNN1WmUpEmUwBRG73fG4w4/DosZuHk9x5xFjlT95mJuHJo1JiX54+DNkNY81qC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eg7YTzhI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21AC6C116B1;
	Fri, 31 May 2024 12:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717156888;
	bh=OGmPL9Uk8asTqJ72NesPKkQ57yKobdJU/tqU+fjRcRM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eg7YTzhId11xZyK/W2P0yYxGl8YlwIAAczvoFLlJ05GNplUXVfz2Tn15e1oV/HmzD
	 rCj8PaI2heftTmPuXGpRx9LMZ+mGbgaCt/oqq/zCa4Kxk0pQFgwktMDNujgseBYBTx
	 RP8POsERAe4NSZ2ml05pviLvVFmF5wWs0NPB1s0Nd7kxWYiPEltrmY5I4zSObzm1pm
	 t3SbD+ILRU/552t8VYUu9uBsqD+3m2hb1QFrQbB0x32vKehh7Xz6K6q9annAN8bZD4
	 UgbtrO3mptE3eE4D/dwHtkXFp6n0Kmi1GGgFwDgFkS2Yf6BRagKKESxRKERFtIIHP+
	 x1FZrgkK6WkCQ==
From: Lee Jones <lee@kernel.org>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andy@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 Lee Jones <lee@kernel.org>, Kate Hsuan <hpa@redhat.com>, 
 Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: platform-driver-x86@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
 linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
In-Reply-To: <20240504164105.114017-1-hdegoede@redhat.com>
References: <20240504164105.114017-1-hdegoede@redhat.com>
Subject: Re: [PATCH v9 0/7] KTD2026 indicator LED for X86 Xiaomi Pad2
Message-Id: <171715688533.1048514.4925726430430747423.b4-ty@kernel.org>
Date: Fri, 31 May 2024 13:01:25 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Sat, 04 May 2024 18:40:58 +0200, Hans de Goede wrote:
> Here is v9 of Kate's series to add support for Xiaomi Pad2 indicator LED.
> 
> I believe this is ready for merging now. Patch 6/7 has an Acked-by from
> Sebastien for merging this patch through the leds tree since it depends
> on the earlier patches. LEDs tree maintainers please merge patches 1-6,
> then patch 7 can be merged through the pdx86 tree independently.
> 
> [...]

Applied, thanks!

[1/7] leds: rgb: leds-ktd202x: Get device properties through fwnode to support ACPI
      commit: f14aa5ea415b8add245e976bfab96a12986c6843
[2/7] leds: rgb: leds-ktd202x: I2C ID tables for KTD2026 and 2027
      commit: 75bd07aef47e1a984229e6ec702e8b9aee0226e4
[3/7] leds: rgb: leds-ktd202x: Initialize mutex earlier
      commit: e1b08c6f5b92d408a9fcc1030a340caeb9852250
[4/7] leds: core: Add led_mc_set_brightness() function
      commit: 5607ca92e6274dfb85d0ff7c4e91e6c4ddb6d25c
[5/7] leds: trigger: Add led_mc_trigger_event() function
      commit: 0921a57c91648b08857b47a2f26fa7942f06120f
[6/7] power: supply: power-supply-leds: Add charging_orange_full_green trigger for RGB LED
      (no commit info)
[7/7] platform: x86-android-tablets: Xiaomi pad2 RGB LED fwnode updates
      (no commit info)

--
Lee Jones [李琼斯]


