Return-Path: <linux-pm+bounces-5837-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4910896611
	for <lists+linux-pm@lfdr.de>; Wed,  3 Apr 2024 09:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127361C2279E
	for <lists+linux-pm@lfdr.de>; Wed,  3 Apr 2024 07:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523D25A7BB;
	Wed,  3 Apr 2024 07:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URMZ2Fms"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A4758AA9;
	Wed,  3 Apr 2024 07:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712128827; cv=none; b=i1buI3EVkyYnragyEEacsHKQEEJTGyubn3PNhAcr4DnZdvC2M8cmc+0sAIUCUGbK4SwoCCT31x2YU4I8Dc2bUpXyVD5IEc6gq+sdQx4fy6fE9NLypZhXs3HJn1eg/2mzfn0JmeQ3k178poL0TJgCacsDE6b8h2W46gWTKTYNkBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712128827; c=relaxed/simple;
	bh=81ffTdP21cS4rhwsQEZ+8+anWHy2S8vDbzNSF7oAnCI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c7gMfHdf7wBHpcC4PLx65FuqxmJZl2MQ4A2EiTET/ArKbRCq2PlP5LXRvCa+W+dXPOimab1naqilR1WJ07T1uDsJl6ouVil8FDyt4ipwvLNEt1cHa6C0VgaKO3Wcge3Wne/uKo3EvSASVAWl6AeTyLfXN6FiOS8BlhQpU8qcWJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URMZ2Fms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95150C43330;
	Wed,  3 Apr 2024 07:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712128826;
	bh=81ffTdP21cS4rhwsQEZ+8+anWHy2S8vDbzNSF7oAnCI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=URMZ2Fmss2hynDj8Vcluta/QuNOuktD2WVELRxxBbch3LyhzX6EE9g7nTi8C72zOM
	 rXqlVlTw/hgB3FDNpP0U9t8OHxjHEadcwQvy9JlF0uE/6MR9wjWgkd+WCUE6yBwEAK
	 t9So4pNszVKG4kw3eA04xw9AGvPrTkobwnHaZOEAy2wf9W8MZyWBJe1QE+lWC7OkHT
	 Ql6TxMh6KPIouPD7p6xNWg0fx8CzSdTpGiEgqjwz16n3l9Xe+hbhTio5gX4p1iLcuk
	 ekaueKfaNczFvnJmLYnwWDG2L7h2s6WDlto8m+FqgN8T95Ix0RTSxN+oFzfZZQA9QL
	 Vb5hodw+czQSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8ABA2D9A158;
	Wed,  3 Apr 2024 07:20:26 +0000 (UTC)
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
 <171212882656.6261.8246903894715211334.git-patchwork-notify@kernel.org>
Date: Wed, 03 Apr 2024 07:20:26 +0000
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

This series was applied to chrome-platform/linux.git (for-next)
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
    (no matching commit)
  - [05/18] power: supply: cros_usbpd: provide ID table for avoiding fallback match
    (no matching commit)
  - [06/18] platform/chrome: cros_usbpd_logger: provide ID table for avoiding fallback match
    (no matching commit)
  - [07/18] platform/chrome: cros_usbpd_notify: provide ID table for avoiding fallback match
    (no matching commit)
  - [08/18] platform/chrome: cros_ec_chardev: provide ID table for avoiding fallback match
    (no matching commit)
  - [09/18] platform/chrome: cros_ec_debugfs: provide ID table for avoiding fallback match
    (no matching commit)
  - [10/18] platform/chrome: cros_ec_sysfs: provide ID table for avoiding fallback match
    (no matching commit)
  - [11/18] power: supply: cros_pchg: provide ID table for avoiding fallback match
    (no matching commit)
  - [12/18] platform/chrome: cros_ec_lightbar: provide ID table for avoiding fallback match
    (no matching commit)
  - [13/18] platform/chrome: cros_ec_vbc: provide ID table for avoiding fallback match
    (no matching commit)
  - [14/18] platform/chrome: cros_kbd_led_backlight: provide ID table for avoiding fallback match
    https://git.kernel.org/chrome-platform/c/d91ca83599cd
  - [15/18] platform/chrome: wilco_ec: telemetry: provide ID table for avoiding fallback match
    (no matching commit)
  - [16/18] platform/chrome: wilco_ec: debugfs: provide ID table for avoiding fallback match
    (no matching commit)
  - [17/18] platform/chrome: wilco_ec: event: remove redundant MODULE_ALIAS
    (no matching commit)
  - [18/18] platform/chrome/wilco_ec: core: provide ID table for avoiding fallback match
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



