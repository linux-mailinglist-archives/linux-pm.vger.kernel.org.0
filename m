Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62AB22B862D
	for <lists+linux-pm@lfdr.de>; Wed, 18 Nov 2020 22:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbgKRVAG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Nov 2020 16:00:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:55830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbgKRVAG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Nov 2020 16:00:06 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01DB9246CA;
        Wed, 18 Nov 2020 21:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605733205;
        bh=OiRq5n6pYwtlRHg6S3gu6kn/EVUSMv2UVgnqO2UpdH4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=RMLhtTmGmk2wGvmHCsPi7tJxbedfqVn0u5moSprReTbj/UoMPWB/GpAV7XRROGkbm
         YSPOexo3xa90oHw8CD+xjv7U2UVnoV2HOuSRj9w9G2zYDa7c1u0tH4LSSXncAS0fuN
         GSggAxDgvvmOjAnlnOsDYWukxh9FJ7rD5DjCCHgA=
Date:   Wed, 18 Nov 2020 20:59:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Nishanth Menon <nm@ti.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lkft-triage@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20201118145009.10492-1-nm@ti.com>
References: <20201118145009.10492-1-nm@ti.com>
Subject: Re: [PATCH] regulator: ti-abb: Fix array out of bound read access on the first transition
Message-Id: <160573318504.46660.3881026259686236737.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 18 Nov 2020 08:50:09 -0600, Nishanth Menon wrote:
> At the start of driver initialization, we do not know what bias
> setting the bootloader has configured the system for and we only know
> for certain the very first time we do a transition.
> 
> However, since the initial value of the comparison index is -EINVAL,
> this negative value results in an array out of bound access on the
> very first transition.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: ti-abb: Fix array out of bound read access on the first transition
      commit: 2ba546ebe0ce2af47833d8912ced9b4a579f13cb

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
