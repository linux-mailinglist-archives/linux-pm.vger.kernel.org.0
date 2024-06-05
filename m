Return-Path: <linux-pm+bounces-8668-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E936F8FD935
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 23:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9AF81C23A6F
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 21:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB11D15FCFB;
	Wed,  5 Jun 2024 21:38:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCAC15FA9F;
	Wed,  5 Jun 2024 21:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717623492; cv=none; b=f8CaPxXEzcom2ZH6qucwPjyh3Ka0sXxyt8FKxhBR0f2cF9uAAOMODKTHUCgStmEugHguUHWpp5Ydis14Q0BNCq1/M+jwYl2ESrAlSXoRL6GD/eE/aYcP/OlelAa2jUbPNEE7n+ZfmadVOnmDURmZM6ry2pqup36PmkSnTTjMUt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717623492; c=relaxed/simple;
	bh=H9YKIzKCyjmiBNNds+3kSke/ux9vGLZhkZhtB9WXAyo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gwDyo7WmKMNf6pZ5w4VDsNOOuS6HT2k+y3xbYyGAViACExMJKJVDaMNbmwG/DNjn7CabfklsiM6g3P+BBxwQ0KA9EPLsTLXIi4SbwOrs0cv4O/Dqr3QrsRK5l+X4EyymvHfr9phMVRiVXcMKuESf7amZ5fmD2LJ7+mG59U0ojl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3423FC32786;
	Wed,  5 Jun 2024 21:38:12 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id EB1861060501; Wed, 05 Jun 2024 23:38:07 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andy@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 Lee Jones <lee@kernel.org>, Kate Hsuan <hpa@redhat.com>, 
 Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: platform-driver-x86@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
 Heiner Kallweit <hkallweit1@gmail.com>, linux-leds@vger.kernel.org, 
 linux-pm@vger.kernel.org
In-Reply-To: <20240531134702.166145-1-hdegoede@redhat.com>
References: <20240531134702.166145-1-hdegoede@redhat.com>
Subject: Re: [PATCH v2 0/3] power: supply: power-supply-leds: Add
 activate() callback to triggers
Message-Id: <171762348792.363491.16499283764662908340.b4-ty@collabora.com>
Date: Wed, 05 Jun 2024 23:38:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 31 May 2024 15:46:59 +0200, Hans de Goede wrote:
> This series adds an activate callback to the power-supply LED triggers to
> ensure that power-supply LEDs get the correct initial value when the LED
> gets registered after the power_supply has been registered.
> 
> Note that in 6.10-rc1 commit 822c91e72eac ("leds: trigger: Store brightness
> set by led_trigger_event()") already solves this for the case were
> the trigger only changes only the brightness. Since the power-supply
> triggers can also set blinking and colors of mc LEDs that is not enough.
> 
> [...]

Applied, thanks!

[1/3] power: supply: power-supply-leds: Add power_supply_[un]register_led_trigger()
      commit: 964a504b1261b641797d93cdbf79b68ff7d85720
[2/3] power: supply: power-supply-leds: Share trig pointer for online and charging_full
      commit: 6c951a84dab9c0e051aec54d7497f25e910a4953
[3/3] power: supply: power-supply-leds: Add activate() callback to triggers
      commit: 8179b068d5cb182a2c61f2f8365837a37f140feb

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


