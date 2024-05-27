Return-Path: <linux-pm+bounces-8127-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2248CF779
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 04:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35EC61C20EB1
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 02:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE30F46B5;
	Mon, 27 May 2024 02:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hz7nbNA6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868F820E6;
	Mon, 27 May 2024 02:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716778511; cv=none; b=qwCzf0wVhu3MYDOeTED1mnEkNnnP/09iN6EvHnBGgMWPOmCzu0ZPA+pBwikBZViRl3uF3V2fKHYi1A1RDHgaou1CcV6YROmEjZ/l4hAAtCegjZAMHO5I2aFUMxhLSzqVIR9QJUbI67+MHw6bgipiePUd2gwmeaxoCESRjpcID4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716778511; c=relaxed/simple;
	bh=IVnqRn382nSyzKHmBGD+vnMqxsrVjaWy+z+fc70OVCQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sMjCwD5bqz5g9BnUkdzK8pgajs/RBLfudd0DOQ5TjHxNWgLLfGDIELEtiVy4Tn/qnGVdVMfoc0AzJADMBlYptyUIAuht0ZsI9g2uyCJxjiSHNotd2IzTkc9jd9M/iAFvI/rDOvRPIGlJxVyFF0qWvFDvbPz3P8ZszZh2qQk2OlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hz7nbNA6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1BA85C4AF09;
	Mon, 27 May 2024 02:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716778511;
	bh=IVnqRn382nSyzKHmBGD+vnMqxsrVjaWy+z+fc70OVCQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hz7nbNA6xcRLqNb84tLKLDU+OIUJY/ckZOHXviqjRx0neEDOR4tQZ+wNt4PhoDd4W
	 6iWJPsVizMXGwuN782ZpDTMVPgA6itKdNeEPfeAlhnV4xiCCm1clLWBCWJ4WrUebIt
	 VwbeENY7KWZqJ92/MHyshIz6EVnOLceIBgLUcYsfBBr8wdx5h7+fRiILKIttW7Begk
	 bn7AY7GcNpm2w+Hqj+52mB+wYabtFHaVeOFTkO8256gO+qYfb0xJP7455DccR/ufxT
	 PirGvqOGnpxo/7ktYz01b5VepgqbeaNkg1spFtnn85RjvMUYmHEz7nWPrGyvR1hbi2
	 DbvAvCVjC4sYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0BBCFD4F15D;
	Mon, 27 May 2024 02:55:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/6] provide ID table for avoiding fallback match
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171677851104.1901.10099915202413513803.git-patchwork-notify@kernel.org>
Date: Mon, 27 May 2024 02:55:11 +0000
References: <20240401030052.2887845-1-tzungbi@kernel.org>
In-Reply-To: <20240401030052.2887845-1-tzungbi@kernel.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: bleung@chromium.org, groeck@chromium.org, linus.walleij@linaro.org,
 brgl@bgdev.pl, hverkuil-cisco@xs4all.nl, mchehab@kernel.org, sre@kernel.org,
 chrome-platform@lists.linux.dev, pmalani@chromium.org,
 linux-gpio@vger.kernel.org, linux-media@vger.kernel.org,
 linux-pm@vger.kernel.org, krzk@kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-kernelci)
by Sebastian Reichel <sebastian.reichel@collabora.com>:

On Mon,  1 Apr 2024 11:00:46 +0800 you wrote:
> Inspired by [1].  Turn all MODULE_ALIAS() in ChromeOS EC platform drivers into
> proper platform_device_id table and MODULE_DEVICE_TABLE().
> 
> The series is basically looking for drivers from:
> - `struct mfd_cell` in drivers/mfd/cros_ec_dev.c.
> - grep -R MODULE_ALIAS drivers/platform/chrome/.
> 
> [...]

Here is the summary with links:
  - [v2,1/6] media: platform: cros-ec: provide ID table for avoiding fallback match
    (no matching commit)
  - [v2,2/6] gpio: cros-ec: provide ID table for avoiding fallback match
    (no matching commit)
  - [v2,3/6] power: supply: cros_usbpd: provide ID table for avoiding fallback match
    https://git.kernel.org/chrome-platform/c/0f8678c34cbf
  - [v2,4/6] power: supply: cros_pchg: provide ID table for avoiding fallback match
    https://git.kernel.org/chrome-platform/c/d6486a13665e
  - [v2,5/6] platform/chrome: cros_kbd_led_backlight: shrink the driver name
    (no matching commit)
  - [v2,6/6] platform/chrome: cros_kbd_led_backlight: provide ID table for avoiding fallback match
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



