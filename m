Return-Path: <linux-pm+bounces-22894-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C999AA44388
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 15:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A981819C33BB
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 14:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE3921ABB6;
	Tue, 25 Feb 2025 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBngrPUB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFACA21ABAE;
	Tue, 25 Feb 2025 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494785; cv=none; b=O5bG7fr9fKImlCwZ3SbY39EC9rplffrBKE1Ew2tm0TDmZOZHH5Qof+a8OfFVvik1DIzc+mECNei6ahDCQ7TUIOgz2K9mjURBkuBzc0aupoHH9uESwTQ6FjsWNJLSeE7ffayazh+TPY6zps73wxCz8EDJlhVdmYdL5PjndQHShqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494785; c=relaxed/simple;
	bh=6ZThMx3yk5s32UwJseFaT+0LfZxbEk9CwJs9at/sz4o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IMuiCl4nDQaRjOTlfK8axG0w8mJg6fTZjOO8eeqUQpdP/I5G5gl4BQhIinRDvMF7sIgQ1tqylBFzy7XUvGw8B5kcXjcEKXK5Vmm/5uIa6KdXwJbrSIS5D/hVdCEYu5A05OBizU3CsnBDIPvLtVGFRKJonB0PhEA+q/ZyP2M8c2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBngrPUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A07C4CEDD;
	Tue, 25 Feb 2025 14:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740494785;
	bh=6ZThMx3yk5s32UwJseFaT+0LfZxbEk9CwJs9at/sz4o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JBngrPUB7/i1+yjFpBp9I9OvqFFITb4P6hFYqyz+5W3iuG/l83/RgnZFIQroM4OrC
	 YaKdAQ8NMAL01KLJKlB93BVlGXMIFs8RiE8uxS2iJ01lILFP3WCMwnnqRRf+MGqxWt
	 0U8nRcEY0hNM5MIuxYghPIraxG6uFjF0jL/2VkW7PDXgCwsFxE7JbqEGL+FqUfQvMT
	 o7z0blAKwjG+kEN08spkJTBd6roI64NzBumphKDGBkvIHn1Gjl2vVFE6svS3q915xH
	 HPftpzYJtBQoSTGGYNnGKtq8R8lwuM3m/VH7vyxidZOLNRhW8/r9UfTjBOwNdjeRFu
	 pg6bRqLdMN6+A==
From: Mark Brown <broonie@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 =?utf-8?q?Adri=C3=A1n_Mart=C3=ADnez_Larumbe?= <adrian.larumbe@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Peter Geis <pgwipeout@gmail.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
 Vignesh Raman <vignesh.raman@collabora.com>, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org
In-Reply-To: <20250220-rk3588-gpu-pwr-domain-regulator-v6-0-a4f9c24e5b81@kernel.org>
References: <20250220-rk3588-gpu-pwr-domain-regulator-v6-0-a4f9c24e5b81@kernel.org>
Subject: Re: (subset) [PATCH v6 0/8] Fix RK3588 power domain problems
Message-Id: <174049478169.62098.16182863254035343977.b4-ty@kernel.org>
Date: Tue, 25 Feb 2025 14:46:21 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Thu, 20 Feb 2025 19:58:03 +0100, Sebastian Reichel wrote:
> I got a report, that the Linux kernel crashes on Rock 5B when the panthor
> driver is loaded late after booting. The crash starts with the following
> shortened error print:
> 
> rockchip-pm-domain fd8d8000.power-management:power-controller: failed to set domain 'gpu', val=0
> rockchip-pm-domain fd8d8000.power-management:power-controller: failed to get ack on domain 'gpu', val=0xa9fff
> SError Interrupt on CPU4, code 0x00000000be000411 -- SError
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/8] regulator: Add (devm_)of_regulator_get()
      commit: 0dffacbbf8d044456d50c893adb9499775c489f4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


