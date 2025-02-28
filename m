Return-Path: <linux-pm+bounces-23205-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4E9A4A4F6
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 22:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB53E16C4BB
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 21:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099061DC996;
	Fri, 28 Feb 2025 21:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZfGsz4a"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADEE1D63FD;
	Fri, 28 Feb 2025 21:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740777767; cv=none; b=ROalhsp0za0donSNri+N0FTiIv9OgfTe9XpwH36cWFK45SuN+3Q9enzME0U8WSbnGpd7J61QwyqaIQJ/uv7gnKeHtaQXBn3nBUggX87RWgbkqXkMizUwyEMiiw0w5tDx2NLKOGqTcuHvizRo/a6QzxALU/W/afqJphZQthOgnVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740777767; c=relaxed/simple;
	bh=JBzeKdwhC3moTlOZODJUQj1pAUwMAaCEBCLwB//XK6k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UiWvG9xSXlw3R5sADk8ic7VKgmBHDGgVpXX5uxCUcJiJu7Al/vVBqE6PLqsGJ542FsYSZrENvUr0h1WTKdY9IY3Msf6IaQ9MzXTeY9MYEqCZKxmJeFblwpCO8UMLlwu2Z+ESqJErECvhAbAKBxnNQXltE0yvUwvhZQTvsQiuc6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZfGsz4a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BE6C4CEE2;
	Fri, 28 Feb 2025 21:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740777767;
	bh=JBzeKdwhC3moTlOZODJUQj1pAUwMAaCEBCLwB//XK6k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HZfGsz4a/Wb5K190mpN0hUEjxtlng3IksnID5Wqmy//b3riT8NlHGzftLdTW4732C
	 A3p/X+JU6g2AfKE+5gkGxi9bch0utFZvBMR3iURHDPgc/gSjeKW/9+7Eh8cHh8jtcs
	 zCl96QPfdnZKij5aMeAZSyjVYMDu/mcIy0JsRE8/tjDiuo85z4Voyr6Lp/vEFt/g6b
	 xxagA/4BYOfJrJ0RwB1bzwQRXjrOESSMtjivw9MltIyDdFYGzb/ndaU0IkRR1oWA/e
	 sCe3zg6XH/ElnzZkSNbxGJiodB6gvt4DwmBWPW0Pk0oHfs0vn1M/T3FDCwcD4p+9UD
	 Dp8OXQLTITh5A==
From: Mark Brown <broonie@kernel.org>
To: perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com, deller@gmx.de, 
 andriy.shevchenko@linux.intel.com, sre@kernel.org, 
 sakari.ailus@linux.intel.com, mchehab@kernel.org, jdmason@kudzu.us, 
 fancer.lancer@gmail.com, Hans Verkuil <hverkuil@xs4all.nl>, 
 Raag Jadav <raag.jadav@intel.com>
Cc: linux-sound@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-media@vger.kernel.org, ntb@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250221165333.2780888-1-raag.jadav@intel.com>
References: <20250221165333.2780888-1-raag.jadav@intel.com>
Subject: Re: (subset) [PATCH v1 00/13] Convert to use devm_kmemdup_array()
Message-Id: <174077776364.602863.4317015681907674937.b4-ty@kernel.org>
Date: Fri, 28 Feb 2025 21:22:43 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Fri, 21 Feb 2025 22:23:20 +0530, Raag Jadav wrote:
> This series is the second wave of patches to add users of newly introduced
> devm_kmemdup_array() helper. Original series on [1].
> 
> This depends on changes available on immutable tag[2]. Feel free to pick
> your subsystem patches with it, or share your preferred way to route them.
> 
> [1] https://lore.kernel.org/r/20250212062513.2254767-1-raag.jadav@intel.com
> [2] https://lore.kernel.org/r/Z7cqCaME4LxTTBn6@black.fi.intel.com
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[09/13] regulator: devres: use devm_kmemdup_array()
        commit: 6ddd1159825c516b8f64fda83177c161434141f5
[10/13] regulator: cros-ec: use devm_kmemdup_array()
        commit: c5c4ce6612bb25ce6d6936d8ade96fcba635da54

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


