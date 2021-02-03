Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4198F30E4AC
	for <lists+linux-pm@lfdr.de>; Wed,  3 Feb 2021 22:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhBCVJ1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Feb 2021 16:09:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:35882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231921AbhBCVJY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Feb 2021 16:09:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53E2D64F43;
        Wed,  3 Feb 2021 21:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612386523;
        bh=OWUM42k3R9oUeyVrDRlJgBtJLkDRDpWuISrG00E4kDw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=g5jNmtUPxn6a5xxZL6XHEhkNtXM7X9FQCKyQPTWnLFPz8nxTqz9BKzwFCbbMeqXND
         XsVC84+4dHnKJ7SkkTcXsxVgSaqWjb0Qu+JlSfMp/eSBUDcp24n3bniNlon/6qjxJb
         IeqVvyu/SicDQaRiREYQlQuChi+0eclx589ZIncHrsHUBUITaUxr2gWZpTC5U9k+TZ
         KjoGBOh4CvtHqtizJBpOaqbElv6xOmPc1Xkm4UoCvzQwyrqwY/wZmnjjn4KYL7qD2M
         uR4XkxX4gEO3e+VUEOOV7JK8/Cyg/udFt/2zY03KqfEhIpAqVorJgExsqWWRpMgcNq
         RZCutVxpVKQJg==
From:   Mark Brown <broonie@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Timon Baetz <timon.baetz@protonmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
In-Reply-To: <20210130172747.2022977-1-timon.baetz@protonmail.com>
References: <20210130172747.2022977-1-timon.baetz@protonmail.com>
Subject: Re: (subset) [PATCH 0/3] charger-supply for max8997_charger
Message-Id: <161238647515.34533.13734452545880023914.b4-ty@kernel.org>
Date:   Wed, 03 Feb 2021 21:07:55 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 30 Jan 2021 17:28:49 +0000, Timon Baetz wrote:
> Based on the discussion from [0] add an optional DT property to retrieve
> the regulator used for charging control in the max8997_charger driver.
> 
> [0] https://lore.kernel.org/lkml/20210118124505.GG4455@sirena.org.uk/
> 
> 
> Timon Baetz (3):
>   regulator: dt-bindings: Document charger-supply for max8997
>   ARM: dts: exynos: Add charger supply for I9100
>   power: supply: max8997_charger: Switch to new binding
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] regulator: dt-bindings: Document charger-supply for max8997
      commit: 41a8a027f4d3f81d83b8942ef29f84223ca35ffc

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
