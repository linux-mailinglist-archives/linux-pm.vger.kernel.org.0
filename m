Return-Path: <linux-pm+bounces-21312-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8353A26382
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2025 20:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DFD63A2DDB
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2025 19:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67993211280;
	Mon,  3 Feb 2025 19:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYhm3W1Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31553211269;
	Mon,  3 Feb 2025 19:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738610126; cv=none; b=gIvraDttNwcjHVBwEcMmk+f9KvTx5IxC+KUB0GYsCtj09UKp9ahAjpGxzj8kK+4R+cglSX3Hh8w1e+9k7nYus91M4ArqFL0ZBn9Plvh1jzkOcXiGlXsfUT9ksoJxj6t+P0oEjx4QvAzrQCAoJ3c9fA1ff1q9q2KbExnvVdgljSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738610126; c=relaxed/simple;
	bh=BDPM7u1CRvEI1Kn3lZuF8kskwCiEX3Kitywmg+8MwZU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JVgbqGGoX14QL+VPu//ujlbZ6H7T+5koFGirLhEhbbXIfxbHqwzW+fzLSELMn8aVedZOL1rameY7EOIlhfnYPsDAmB6GraFI1PPAA8SDffXlE9iaHaZamwR8BfExug6OoE8PXZowK6XiNE1E/pBQs1vApbCdj/0FUNPriP4TPqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYhm3W1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC92C4CED2;
	Mon,  3 Feb 2025 19:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738610125;
	bh=BDPM7u1CRvEI1Kn3lZuF8kskwCiEX3Kitywmg+8MwZU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hYhm3W1QYCkDsN1crFMcC5vC3MonK+qkCAOz+WwdhOVUHZ0HLjZTQAsg3tl7o9s8H
	 BU+bqi9jyOYbxwC9ei76Mq8ptcXqsd5SOh/+8og70lDYJL3RqtnPerGIZTHCANkamQ
	 Yckq82B8xZnfo+4rNvq7hQkLnKU+EQGYkdYhQiJAOqj4uCdhBQcjpFfp1P/bTDp3Yi
	 HOV2GGByqpfdPESu++AwzdFyQr0pmhKP6IC3N45Oo9VeJUx9wz3qUds6G2jzdwYpTR
	 CH+85Ld4snwX3gUvih7vhRHBGwI6rZla+uTR8mjJBtjlPBw44r3zYQ1Yg3dnH2nSQb
	 8qk8l0+zUOkqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB437380AA67;
	Mon,  3 Feb 2025 19:15:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 00/12] pm: Introduce devm_pm_set_wake_irq
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173861015275.3409359.13632354633861115390.git-patchwork-notify@kernel.org>
Date: Mon, 03 Feb 2025 19:15:52 +0000
References: <20250103-wake_irq-v2-0-e3aeff5e9966@nxp.com>
In-Reply-To: <20250103-wake_irq-v2-0-e3aeff5e9966@nxp.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: linux-riscv@lists.infradead.org, rafael@kernel.org, len.brown@intel.com,
 pavel@ucw.cz, gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com,
 alexandre.belloni@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, linus.walleij@linaro.org,
 conor.dooley@microchip.com, daire.mcnamara@microchip.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 peng.fan@nxp.com

Hello:

This series was applied to riscv/linux.git (fixes)
by Rafael J. Wysocki <rafael.j.wysocki@intel.com>:

On Fri, 03 Jan 2025 16:41:12 +0800 you wrote:
> This was a retry to address [1][2], to let common code handle
> dev_pm_clear_wake_irq. Then no need to call dev_pm_clear_wake_irq
> in each driver.remove() hook and error handling path.
> 
> In this patchset, I include input and rtc patches to show the usage
> to avoid introducing an API without users. There are still
> other places using dev_pm_clear_wake_irq. If this patchset is
> good for you, I could start to clean up other drivers such as mmc and
> etc.
> 
> [...]

Here is the summary with links:
  - [v2,01/12] PM: sleep: wakeirq: Introduce device-managed variant of dev_pm_set_wake_irq
    https://git.kernel.org/riscv/c/fd8318a32573
  - [v2,02/12] input: keyboard: ep93xx_keypad: Use devm_pm_set_wake_irq
    (no matching commit)
  - [v2,03/12] input: keyboard: omap4_keypad: Use devm_pm_set_wake_irq
    (no matching commit)
  - [v2,04/12] input: misc: nxp-bbnsm-pwrkey: Use resource managed API to simplify code
    (no matching commit)
  - [v2,05/12] input: touchscreen: ti_am335x_tsc: Use resource managed API to simplify code
    (no matching commit)
  - [v2,06/12] rtc: stm32: Use resource managed API to simplify code
    (no matching commit)
  - [v2,07/12] rtc: nxp-bbnsm: Use resource managed API to simplify code
    (no matching commit)
  - [v2,08/12] rtc: ds1343: Use devm_pm_set_wake_irq
    (no matching commit)
  - [v2,09/12] rtc: pm8xxx: Use devm_pm_set_wake_irq
    (no matching commit)
  - [v2,10/12] rtc: ab8500: Use resource managed API to simplify code
    (no matching commit)
  - [v2,11/12] rtc: mpfs: Use devm_pm_set_wake_irq
    (no matching commit)
  - [v2,12/12] rtc: pl031: Use resource managed API to simplify code
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



