Return-Path: <linux-pm+bounces-23893-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8ECA5D07D
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 21:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60623A9252
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 20:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F600264625;
	Tue, 11 Mar 2025 20:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjZifLhP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCA1217719;
	Tue, 11 Mar 2025 20:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741723941; cv=none; b=D74qqKGSPeV+zc5ZG6v3S2Z7k/5XAIjLPHpwepn1GLPqvVTTJHWa4gZqUnUtWjwNs7RJWyr7jeGlcq4QucG6LCnv4Sn9iMTSVSY4GN6XHwfnYwF8C5w9rDpQyDskluXU2i0yGs3ZJRtGhEAIYdEXnVD2dE85fSaFIGuNtHhzhDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741723941; c=relaxed/simple;
	bh=3+OnOIdluvq4El08WnHUY5Y/kcwnOu3x4aGLqAkuCrs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mJi6Ph36P4CRqkih9JaByc5rcMhPy+ZXiNQJTNA1bO0aRcMPj6Pqn/Tm96p5pq0eqj9js6ovGDw+p7HYRoHeOtK7IrtcDn9ic2+UCCXs0omxwKNCd3gIDRMJjPLguQg2wr2nz0amzxq0s9G+7lSCVEaIYpObqB+o/dmZGT0tBAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjZifLhP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47A7C4CEE9;
	Tue, 11 Mar 2025 20:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741723941;
	bh=3+OnOIdluvq4El08WnHUY5Y/kcwnOu3x4aGLqAkuCrs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gjZifLhPPGXcer1ZAWIyK1S2tH/lt04SIftXSYzZKGfP4lXtZMsmn0Eayh4HpB96b
	 9/WqmOe6ugZVmY0LQ5SSZW9kBXMR2lxu5SNeNjoFIMide30s/REq6ZNBAcdJlrVORp
	 he21oJCRdGMpi/X6dYz0x6Og1QgILShA9Vtz4Zfqdtms9SIwKr6HEFsbEAuMctd6Sf
	 BS0G/1eyAkCusG9Gt/HbcO5zM24U61hX4ZUeBvWsFP2u4HRO5jy6CgLN+tuJGbunvQ
	 dvSLNH9QnttCUnXihzQwUAmxtSH/2kN0drCOaMIev3rf7vlKgSyJqUbc/XYZSod+Vo
	 HijI7bZDk9tuQ==
From: Mark Brown <broonie@kernel.org>
To: arnd@arndb.de, lee@kernel.org, dmitry.torokhov@gmail.com, 
 sre@kernel.org, lgirdwood@gmail.com, alexandre.belloni@bootlin.com, 
 danielt@kernel.org, jingoohan1@gmail.com, deller@gmx.de, 
 linus.walleij@linaro.org, brgl@bgdev.pl, tsbogend@alpha.franken.de, 
 linux@treblig.org
Cc: linux-mips@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250309193612.251929-1-linux@treblig.org>
References: <20250309193612.251929-1-linux@treblig.org>
Subject: Re: (subset) [PATCH 0/9] Remove pcf50633
Message-Id: <174172393659.371198.1480937233663952854.b4-ty@kernel.org>
Date: Tue, 11 Mar 2025 20:12:16 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Sun, 09 Mar 2025 19:36:03 +0000, linux@treblig.org wrote:
> The pcf50633 was used as part of the OpenMoko devices but
> the support for its main chip was recently removed in:
> commit 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support")
> 
> See https://lore.kernel.org/all/Z8z236h4B5A6Ki3D@gallifrey/
> 
> Remove it.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[6/9] regulator: pcf50633-regulator: Remove
      commit: 248bc01138b11ff3af38c3b4a39cb8db7aae6eb6

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


