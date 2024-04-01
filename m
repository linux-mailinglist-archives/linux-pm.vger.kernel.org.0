Return-Path: <linux-pm+bounces-5738-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A578936F4
	for <lists+linux-pm@lfdr.de>; Mon,  1 Apr 2024 04:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536FD1F21337
	for <lists+linux-pm@lfdr.de>; Mon,  1 Apr 2024 02:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B2164D;
	Mon,  1 Apr 2024 02:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1G8vljM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597737F;
	Mon,  1 Apr 2024 02:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711938628; cv=none; b=KG1XIpLs3l7VRHyX4RTvPY502rGeVaCYzAmOLO1im7q5gMcB+9ePLaJrujk9393EK+y47Bhv/GGo/eI/mp9lqKVhPZ3wUy/7gB5XIPXH823ZZsRQxVbIK6egvxTc/JpYw2y0/NiHnOMc0CXk4ieq9wqDnHHx+LsPBMmTLZycphg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711938628; c=relaxed/simple;
	bh=NsrbsQxeuGANg7ZCOH7zwX7e8H4x+BKV2I4IrrkCfm8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oa94kHmBNm1iSqj9GsaVmQ4AB8kyu2HKxQfktgBumxVyQZ+DaqDcK+9GqbR64A0nXtCyNM6VTwT9fvBi6I4FXbWTeGK2/E1mnlSZssk0/sSRRUXN8ve9zpRpDCI0qQuVJQuQT2M1asTY3JqisWCTYxtxp/ybOdtVVvR25NnidXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1G8vljM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E114BC43390;
	Mon,  1 Apr 2024 02:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711938628;
	bh=NsrbsQxeuGANg7ZCOH7zwX7e8H4x+BKV2I4IrrkCfm8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a1G8vljMogY/BupvursTPI3HFqhDNGuiDLAHvlt1esJGJ1yASLg0LiLUSXssL5f24
	 jjLe6Miip2IDyy6qBHljx0gRd2ZhnWVZWa6TZ2J9NE9qtfKvWueysnbPq/sx6+xmGG
	 gbLrwKhvDtcOmBW+6kKt/8A7YJQhqEFWzzWrMB7Evcioz/cE7DLgO9/ZxlsRL6q3C+
	 icXRt2gmnVhrcuPqN7BMr1PeS+Ygwzhl9+p0zt27NeUb+xuLVYBQSdaPj4oTIDoyyo
	 4AnblGxv2hZgPPZehCa8TWrhY/E8CtffSTUVqQsEcHf1yogJ7C2ksM8JJWydN8Zi4H
	 l7jBe5vPu9oXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D203BD9A14F;
	Mon,  1 Apr 2024 02:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/18] platform/chrome: provide ID table for avoiding fallback
 match
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171193862785.2149.7081277196721429329.git-patchwork-notify@kernel.org>
Date: Mon, 01 Apr 2024 02:30:27 +0000
References: <20240329075630.2069474-1-tzungbi@kernel.org>
In-Reply-To: <20240329075630.2069474-1-tzungbi@kernel.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: bleung@chromium.org, groeck@chromium.org, linus.walleij@linaro.org,
 brgl@bgdev.pl, hverkuil-cisco@xs4all.nl, mchehab@kernel.org, sre@kernel.org,
 alexandre.belloni@bootlin.com, chrome-platform@lists.linux.dev,
 pmalani@chromium.org, linux-gpio@vger.kernel.org,
 linux-media@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-rtc@vger.kernel.org, krzk@kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Fri, 29 Mar 2024 15:56:12 +0800 you wrote:
> Inspired by [1].  Turn all MODULE_ALIAS() in ChromeOS EC platform drivers into
> proper platform_device_id table and MODULE_DEVICE_TABLE().
> 
> The series is basically looking for drivers from:
> - `struct mfd_cell` in drivers/mfd/cros_ec_dev.c.
> - grep -R MODULE_ALIAS drivers/platform/chrome/.
> 
> [...]

Here is the summary with links:
  - [01/18] media: platform: cros-ec: provide ID table for avoiding fallback match
    (no matching commit)
  - [02/18] gpio: cros-ec: provide ID table for avoiding fallback match
    (no matching commit)
  - [03/18] rtc: cros-ec: provide ID table for avoiding fallback match
    (no matching commit)
  - [04/18] platform/chrome: cros_ec_sensorhub: provide ID table for avoiding fallback match
    https://git.kernel.org/chrome-platform/c/12e981d4d643
  - [05/18] power: supply: cros_usbpd: provide ID table for avoiding fallback match
    (no matching commit)
  - [06/18] platform/chrome: cros_usbpd_logger: provide ID table for avoiding fallback match
    https://git.kernel.org/chrome-platform/c/2b895835bd56
  - [07/18] platform/chrome: cros_usbpd_notify: provide ID table for avoiding fallback match
    https://git.kernel.org/chrome-platform/c/522b9910fa25
  - [08/18] platform/chrome: cros_ec_chardev: provide ID table for avoiding fallback match
    https://git.kernel.org/chrome-platform/c/e4d063f262df
  - [09/18] platform/chrome: cros_ec_debugfs: provide ID table for avoiding fallback match
    https://git.kernel.org/chrome-platform/c/e26205b5728f
  - [10/18] platform/chrome: cros_ec_sysfs: provide ID table for avoiding fallback match
    https://git.kernel.org/chrome-platform/c/6e92e7f792eb
  - [11/18] power: supply: cros_pchg: provide ID table for avoiding fallback match
    (no matching commit)
  - [12/18] platform/chrome: cros_ec_lightbar: provide ID table for avoiding fallback match
    https://git.kernel.org/chrome-platform/c/4f6b823b5caa
  - [13/18] platform/chrome: cros_ec_vbc: provide ID table for avoiding fallback match
    https://git.kernel.org/chrome-platform/c/883030dae2d2
  - [14/18] platform/chrome: cros_kbd_led_backlight: provide ID table for avoiding fallback match
    (no matching commit)
  - [15/18] platform/chrome: wilco_ec: telemetry: provide ID table for avoiding fallback match
    https://git.kernel.org/chrome-platform/c/b17dd111645b
  - [16/18] platform/chrome: wilco_ec: debugfs: provide ID table for avoiding fallback match
    https://git.kernel.org/chrome-platform/c/c0649ca22fe8
  - [17/18] platform/chrome: wilco_ec: event: remove redundant MODULE_ALIAS
    https://git.kernel.org/chrome-platform/c/fc87ba8e4525
  - [18/18] platform/chrome/wilco_ec: core: provide ID table for avoiding fallback match
    https://git.kernel.org/chrome-platform/c/d8db2c6d7b0e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



