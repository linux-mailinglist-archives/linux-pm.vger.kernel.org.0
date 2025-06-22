Return-Path: <linux-pm+bounces-29220-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B55D7AE2DDB
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 03:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A36EF7A52E8
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 01:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC31627462;
	Sun, 22 Jun 2025 01:33:58 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D843163;
	Sun, 22 Jun 2025 01:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750556038; cv=none; b=VOm08R85VkQkMCvxQUev6MPCuJ4ZH5gT0vUC4VGGqCwDZ3l0akMR/m9kRAFVEtYdclpYATDZZu/Z+Tm6vdRAQlKukM3sNtQCX99jokT1hWNreF99lVDj9Abi+Yr07lWGX7ieIUd0UNIsFDxzf72G4mviwH24fG7Gad6+LhkXn80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750556038; c=relaxed/simple;
	bh=4U09RFkseOmG5N+Yf6ixO+TKVqmB28Xh9yxIneOh8Cw=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ob6530flrY2stnyIXDSSk70gcLY5gKooHPc3y+XSwrv6Zq4OCPRHzGmZo9E8qGVeAvQOljMXWxBgibZS+ZujNfWhXPJs829Sg+Bw4ZHcuGeOdNYjTNHWcI4y7i6SxIHwjhRGa+mXKmLOOiIGz5Pa1PqCLhPcqEgxyZLenWkjMoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF2EC4CEE7;
	Sun, 22 Jun 2025 01:33:57 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id CB21A1806CD; Sun, 22 Jun 2025 03:33:55 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: claudiu.beznea@tuxon.dev, sre@kernel.org, nicolas.ferre@microchip.com, 
 alexandre.belloni@bootlin.com, linux-pm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mihai Sain <mihai.sain@microchip.com>
In-Reply-To: <20250610124545.175492-3-mihai.sain@microchip.com>
References: <20250610124545.175492-3-mihai.sain@microchip.com>
Subject: Re: [PATCH] power: reset: at91-sama5d2_shdwc: Refactor wake-up
 source logging to use dev_info
Message-Id: <175055603580.241833.5864244509904076181.b4-ty@collabora.com>
Date: Sun, 22 Jun 2025 03:33:55 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 10 Jun 2025 15:45:47 +0300, Mihai Sain wrote:
> Use dev_info() instead of pr_info() for more consistent
> logging in the driver.
> 
> [root@sam9x75eb ~]$ dmesg | grep power
> [    1.678542] at91-shdwc fffffe10.poweroff: Wake-Up source: WKUP pin
> 
> 
> [...]

Applied, thanks!

[1/1] power: reset: at91-sama5d2_shdwc: Refactor wake-up source logging to use dev_info
      commit: 6af8ffab2db3199f22298641880dd111f3a630e2

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


