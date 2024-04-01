Return-Path: <linux-pm+bounces-5739-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4400A8936F9
	for <lists+linux-pm@lfdr.de>; Mon,  1 Apr 2024 04:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75C0F1C209FF
	for <lists+linux-pm@lfdr.de>; Mon,  1 Apr 2024 02:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244483D75;
	Mon,  1 Apr 2024 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYZqSz11"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29C07F;
	Mon,  1 Apr 2024 02:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711938630; cv=none; b=TCCiN7mQ3I0y0sSkhv1rLUrPo8GS1h6aNoObgQWK9pgVzWJ/JylHkoMSdGqOdmEhj656G/DusTQgAhtd48mvS7QFuNDL9CxgRySmFFLRv0mlxp02FDvHVFhH5yL1PW2CJSFsGl0pcy6jdVevojC/gqzEt5J1OzcVd07WQ8JwaR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711938630; c=relaxed/simple;
	bh=gSDh6j0mPdh6Tj2aafDUWkyS+e7+NO1FN3memgDF1Yg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C4zh9K7uuGEV3ZOj2Boc6Ze/HLdt6oR60hph93u0qg00d4F+8tQqzP1Gu0uBct4EKwT8ybZtjVb42D64jcqqqdjtLrqVDoSm2a1zE0LEEm47NPuQWm/q38sjl/o6WnN6yExBp0dUIIU0HOjzM7UQT9JHTq380kVCYdblj7Zos3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYZqSz11; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73C1DC433B1;
	Mon,  1 Apr 2024 02:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711938629;
	bh=gSDh6j0mPdh6Tj2aafDUWkyS+e7+NO1FN3memgDF1Yg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XYZqSz11iTPXQBvEkCvp8h+uug23RL3NSbcZdlgUYGsKPiCQyFu0a5597q0WdXGsZ
	 jqWwJSK5n15aKwUff7MT4AASjCXT5/blsp3mpcxW1ozUsw6tLEUrHOlm6Zfow/VMxq
	 AZsIwdiESqCOa1PIkQSNAZds2qTaukPw/UaUWB23/LUnrP7Vhh8tDkYOvPMeF65U9Q
	 p+J/mZ4tMvh6ZBMwVqH0B9Oo1CfmvChPc3+gW35T3k2GVE48Ofaoj2ybOEeLHi0Ck7
	 AX1Pi998T6SBls9ExRcq3nYhMtqDthuX1WWO9pmch9/U5bbNMUG2spA1Cra970vzmW
	 QqDE4DdXieiyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6BBA8D9A152;
	Mon,  1 Apr 2024 02:30:29 +0000 (UTC)
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
 <171193862943.2149.8328845003202233556.git-patchwork-notify@kernel.org>
Date: Mon, 01 Apr 2024 02:30:29 +0000
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



