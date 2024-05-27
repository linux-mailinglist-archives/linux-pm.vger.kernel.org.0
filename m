Return-Path: <linux-pm+bounces-8129-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B91C18CF7EA
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 05:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3B181C20F5A
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 03:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CC44C85;
	Mon, 27 May 2024 03:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpvSIamX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5948679F6;
	Mon, 27 May 2024 03:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716779226; cv=none; b=sXSismyvpKqS+xx6k/OaGhdkYWSAY2IKPKQQXVPBpPdXQYUS3EC1Vcu1mvn+BfPHJPm33zhbdqthvunSW3XzKJaWY8wnZfQrjcaHOODeti8NSTATic2kGQIDjxDkyuBqWU20a8DH1FrkRhK0Hi+NuAsDiAi20oTiU27cl8hP6B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716779226; c=relaxed/simple;
	bh=3rVpb3BXXNkOipWnRw3qrSJpClaL41p1KwTUy2ndhEM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CVIpKpwleu54EqgmQqZWBTqXyWAd0PzUQj1rsqa4Lq27JzDGxIUZkch7Cc7lxzgTk8YOZfXrKaNeNIsTWcJAC5FUNS17Z/lehJrNlktQ13xfhA3WHcZRijr2yEX8tNekIHjstCfNhG4CpQDjv69exfW1B9wn8BtfvnHllIpz39Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpvSIamX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC67CC32782;
	Mon, 27 May 2024 03:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716779226;
	bh=3rVpb3BXXNkOipWnRw3qrSJpClaL41p1KwTUy2ndhEM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jpvSIamXTiGCJUyljpbsvFdJp63C1hBsbS0A+dVYueNW+U4EO+Rgj6NPg0Tv8yHRG
	 Mh++Dil+YouKeEw/d3JPDeKzRwXYGsbRj+8iaIMtuPj588s0a02/Mc72WmAa4RCr2I
	 OO/g6gewalxxyypUE9b3dFxsK7vsqSVuEJEZm+AeGLeECK8MTtG/QWfWT2Bf5IwwUu
	 /3KzNooo4gaBmrBP7NiFV6Un3FesTGnxnbBiUkKAfbXgiNUgVajqEzyHwz8IdkSUVL
	 P0xhJAwjjzs7h7/T576/jf0tzqlf/fRR6XEKJjg945qPtTDvHvNFfUecoHzW4uzbgL
	 UTg+JvSCS0h5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB4CBCF21F7;
	Mon, 27 May 2024 03:07:05 +0000 (UTC)
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
 <171677922589.1901.13930428876573381422.git-patchwork-notify@kernel.org>
Date: Mon, 27 May 2024 03:07:05 +0000
References: <20240401030052.2887845-1-tzungbi@kernel.org>
In-Reply-To: <20240401030052.2887845-1-tzungbi@kernel.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: bleung@chromium.org, groeck@chromium.org, linus.walleij@linaro.org,
 brgl@bgdev.pl, hverkuil-cisco@xs4all.nl, mchehab@kernel.org, sre@kernel.org,
 chrome-platform@lists.linux.dev, pmalani@chromium.org,
 linux-gpio@vger.kernel.org, linux-media@vger.kernel.org,
 linux-pm@vger.kernel.org, krzk@kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-next)
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



