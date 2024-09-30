Return-Path: <linux-pm+bounces-14978-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BACF98AFD5
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 00:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D9D1F241E5
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 22:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9AF18892B;
	Mon, 30 Sep 2024 22:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5nCh1Zi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49B818891C;
	Mon, 30 Sep 2024 22:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727735354; cv=none; b=nmQlSeuqUjjax31Pg5V4xN1dnYQ1M6gWApSYqHCTYEcFAssx78Au7wnt/brwykMTgtuSCYRE0R9FuNCOZmd60d8b8GATlXt7eCzc7K03M/o6N7z3jWkPkb6484uUKLu0EW3rQhvyGmXZpkgSR9NU9NHiL/kr8+ukUExhEAMkVzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727735354; c=relaxed/simple;
	bh=nmH9qaJNjqw7Qc6T/lqnT06KkF7d1uYIKI94EUB9NQo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IGxfE56WH/doCVM/kd+d4hLsupahi9sZ3FbrRc0U8ShkW5rPzN8nSEzd6oXLQx3hQ7i4xECfvUbmH1p8Vqv4PcO8MC++nE0BnAYnRUIpiErqaXPakkwBLY4j41YCoEeELVg6h+/1iof+q5rdJVjX9A7r76NUIc3VdiFsFo1BCoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5nCh1Zi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFA9C4CEC7;
	Mon, 30 Sep 2024 22:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727735353;
	bh=nmH9qaJNjqw7Qc6T/lqnT06KkF7d1uYIKI94EUB9NQo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=G5nCh1ZiP3M2UW5GbdgHysar+gLAEjEEkOJytKfAdtloFD65yi5i3gG4tLErO+JzU
	 hAJR8PT3AVA1pnSLgwap4qkue4K0uMlq3QoI+tbFtc6UQwLmDpdZs7YYHMAXUc/8R8
	 WBJNflBns8NYeysbjveMVRGvKUMTaOT42kacTBj9ZpHjeA25nNEctIpGi8BM0lGf3x
	 PBUhCeJZuWGIlYNek6dLxAEdjsEMDsi9bP2AD3WmQ7k5CnzZb6vKd3Oah4wjscvcEO
	 NTefxofKdZUbjv1p4bdXDfDbS3PBSJmHH2H83nFLJ4LPONS78kw4bSd3FS5zt0vkrA
	 IPUdekfh1iGIQ==
From: Mark Brown <broonie@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, 
 Johan Hovold <johan@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
In-Reply-To: <20240925093807.1026949-1-wenst@chromium.org>
References: <20240925093807.1026949-1-wenst@chromium.org>
Subject: Re: (subset) [PATCH v8 0/3] Add of_regulator_get_optional() and
 Fix MTK Power Domain Driver
Message-Id: <172773535067.2224406.9733965694288102381.b4-ty@kernel.org>
Date: Mon, 30 Sep 2024 23:29:10 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Wed, 25 Sep 2024 17:38:03 +0800, Chen-Yu Tsai wrote:
> This series is split off from my "DT hardware prober" series [1].
> 
> Changes since v7:
> - Added stub versions for of_regulator_get_optional() for !CONFIG_OF
>   and !CONFIG_REGULATOR
> - Added new patches for devres version and converting MTK pmdomain
>   driver
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] regulator: Add of_regulator_get_optional() for pure DT regulator lookup
      commit: 5441b6975adc26aeaca316b9075e04a98238b1b3
[2/3] regulator: Add devres version of of_regulator_get_optional()
      commit: 36ec3f437227470568e5f460997f367f5446a34d

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


