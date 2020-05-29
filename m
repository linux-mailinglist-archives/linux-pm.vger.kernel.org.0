Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1525F1E8416
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 18:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgE2QwQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 May 2020 12:52:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbgE2QwP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 May 2020 12:52:15 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AA8D207BC;
        Fri, 29 May 2020 16:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590771135;
        bh=ty93gwPtPYx0e0WzBVbqMLEGQwQX5iIquHmLbxDNrU8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Jo1HfsPho6m9fUgNaAI7sh6ej0LRhDQHBWNGCfxpylrA3LjEzpwn63fVGjvYsBXCp
         ymXScRVggk0ra1WnvzeYGtRCGieaS6E7MhdoKkXW5BNCp4meSUPlhwfTYBETTwFlyd
         GfQxS91oS3ehWzJvKNHWOfjMBf3KWr+lsX01I6WE=
Date:   Fri, 29 May 2020 17:52:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-pm@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>, peron.clem@gmail.com,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>
In-Reply-To: <20200529124940.10675-1-m.szyprowski@samsung.com>
References: <CGME20200529124948eucas1p175379ead8afd1932f7b7ae61e35cf632@eucas1p1.samsung.com> <20200529124940.10675-1-m.szyprowski@samsung.com>
Subject: Re: [PATCH 0/2] Fix regulators coupling for Exynos5800
Message-Id: <159077112408.28818.15178843458792850223.b4-ty@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 29 May 2020 14:49:38 +0200, Marek Szyprowski wrote:
> This patchset is another attempt to fix the regulator coupling on
> Exynos5800/5422 SoCs. Here are links to the previous attempts:
> 
> https://lore.kernel.org/linux-samsung-soc/20191008101709.qVNy8eijBi0LynOteWFMnTg4GUwKG599n6OyYoX1Abs@z/
> https://lore.kernel.org/lkml/20191017102758.8104-1-m.szyprowski@samsung.com/
> https://lore.kernel.org/linux-pm/cover.1589528491.git.viresh.kumar@linaro.org/
> https://lore.kernel.org/linux-pm/20200528131130.17984-1-m.szyprowski@samsung.com/
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: extract voltage balancing code to the separate function
      commit: 752db83a5dfd4fd3a0624b9ab440ed947fa003ca

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
