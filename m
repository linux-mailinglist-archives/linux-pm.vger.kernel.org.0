Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90864436F18
	for <lists+linux-pm@lfdr.de>; Fri, 22 Oct 2021 02:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbhJVAzH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 20:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhJVAzH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 21 Oct 2021 20:55:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05DFC6135F;
        Fri, 22 Oct 2021 00:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634863970;
        bh=3gGl+p/p7nrAAcGQCrBlZ0+ewM4YLxTwf4TWidy+7po=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BovWNkfe3c08rlup31Cfgo839P5smFnYqAl19DbqRa7QJrqenf5HrSUb7igGdLEvu
         6JmqIUTp48zkUi8ETtaxGb6rR+30U0bBKQlKdNAZ6hyJpG5BtBnzoLmIUdUyQBNinr
         al6E1G0wUl7SM3m5+rewC/eDk4fCD1RX7BdJ+wNXiuSmUKlUa6cLL3GhWd3zNDlEU7
         4wjMZwguMzRyL8GSwXQOZ5ZoRHPBlBhe4PygNbtnKzWMy0fFlwhpnsqsZV6U/WoEZB
         hpvyAWxLlGjBvZtntNVmaC1PWlUwq6KyU3sS0vaz0zDay/J0JGhSNP1qz1hvkZCDvs
         QSQn3uq62hbQw==
From:   Mark Brown <broonie@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>, robh+dt@kernel.org,
        lgirdwood@gmail.com, kernel@pengutronix.de, lee.jones@linaro.org
Cc:     Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org,
        alistair23@gmail.com, linux-imx@nxp.com,
        linux-hwmon@vger.kernel.org, rui.zhang@intel.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        s.hauer@pengutronix.de, amitk@kernel.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org
Subject: Re: (subset) [PATCH v13 0/9] Add support for the silergy,sy7636a
Date:   Fri, 22 Oct 2021 01:52:44 +0100
Message-Id: <163486395940.2610269.12381320818786809684.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211015122551.38951-1-alistair@alistair23.me>
References: <20211015122551.38951-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 15 Oct 2021 22:25:42 +1000, Alistair Francis wrote:
> v13:
>  - Address comments on thermal driver
>  - Rebase on master (without other patches)
> v12:
>  - Rebase
> v11:
>  - Address comments on hwmon
>  - Improve "mfd: simple-mfd-i2c: Add a Kconfig name" commit message
> v10:
>  - Use dev_get_regmap() instead of dev_get_drvdata()
> v9:
>  - Convert to use the simple-mfd-i2c instead
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[4/9] regulator: sy7636a: Remove requirement on sy7636a mfd
      commit: cb17820ef71ed70f70ee1eed2b378664746b6fde

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
