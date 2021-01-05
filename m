Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7FB2EAFA9
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jan 2021 17:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbhAEQIs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jan 2021 11:08:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:37682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726749AbhAEQIs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 5 Jan 2021 11:08:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66B0D2226A;
        Tue,  5 Jan 2021 16:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609862887;
        bh=Ds7Ux3fJB9sk2PXSEPGwymkvlgIP6rNtPGxUUwGxUIM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=AFf8NLyHept3vbYB1LddoUXr4lqxxjVYXbLVU5DW8tGVcMihq5l+IjE0Qvs1FPLKk
         sl+EljIfLj69mBD2KqpQuEr5uTsEWHEeyVkNCS41vA3uQIXTUOT8HWJbH02aKJTnAx
         yMjmoAhAcywlc7qAG06s8Dp0ow+w9bOCR+lwEIviij5YB2fYHQKJNM/itvF23GszZs
         NVKZNCdVHun88PlknuY83o1uKGoEOdTcvzB87+SQYxYgF4y6Ou9TiVM7GWPk20hVen
         tGw28VoLWKrxI4dPxZWzYBezQqwXyH4j8BM7bTKQ8/U4Ma5YxEtwugA3tjEGpn9bhS
         FbvAVLpCWBZJA==
From:   Mark Brown <broonie@kernel.org>
To:     Ryan Case <ryandcase@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Henry Chen <henryc.chen@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-pm@vger.kernel.org, Fan Chen <fan.chen@mediatek.com>,
        Nicolas Boichat <drinkcat@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <1608790134-27425-1-git-send-email-henryc.chen@mediatek.com>
References: <1608790134-27425-1-git-send-email-henryc.chen@mediatek.com>
Subject: Re: (subset) [PATCH V6 00/13] Add driver for dvfsrc, support for active state of scpsys
Message-Id: <160986286072.50149.16225204986666610767.b4-ty@kernel.org>
Date:   Tue, 05 Jan 2021 16:07:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 24 Dec 2020 14:08:41 +0800, Henry Chen wrote:
> This series is based on v5.10-rc1.
> 
> The patchsets add support for MediaTek hardware module named DVFSRC
> (dynamic voltage and frequency scaling resource collector). The DVFSRC is
> a HW module which is used to collect all the requests from both software
> and hardware and turn into the decision of minimum operating voltage and
> minimum DRAM frequency to fulfill those requests.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[11/13] regulator: Regulator driver for the Mediatek DVFSRC
        commit: a0db6b0aa670ba040f959a000ef24dd4238e016b

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
