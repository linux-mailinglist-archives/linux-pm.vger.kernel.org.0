Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A339425917D
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 16:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgIAOvM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 10:51:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbgIAOvI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 1 Sep 2020 10:51:08 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70B8A206EB;
        Tue,  1 Sep 2020 14:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598971867;
        bh=hfukjQ/MUILfw8yDC7cf0oDeEgXFfD/okOKu4FWtQjo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=KdZkKrPbJPR6PVQp86UaHDX+HsDJrrw5I5U4tYBdv8Pl0BBqfci5MRo14nfvRMDZw
         MRR1yz/s4kYCrYRB1Vw2MjvW/WsWHTc8nezzIGOQVoqvC8/QlhSntVTYcCUTBlmyrB
         LsYvyQzhb74p2tAKSwJ1WvFh4/h2Dk3Uz7uVy3/o=
Date:   Tue, 01 Sep 2020 15:50:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sebastian Reichel <sre@kernel.org>,
        Dan Murphy <dmurphy@ti.com>, Lee Jones <lee.jones@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200830185356.5365-1-digetx@gmail.com>
References: <20200830185356.5365-1-digetx@gmail.com>
Subject: Re: [PATCH v2 0/6] Introduce Embedded Controller driver for Acer A500
Message-Id: <159897181721.47861.7031289432829890619.b4-ty@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 30 Aug 2020 21:53:50 +0300, Dmitry Osipenko wrote:
> This series adds support for the Embedded Controller which is found on
> Acer Iconia Tab A500 (Android tablet device).
> 
> The Embedded Controller is ENE KB930 and it's running firmware customized
> for the A500. The firmware interface may be reused by some other sibling
> Acer tablets, although none of those tablets are supported in upstream yet.
> Please review and apply, thanks in advance!
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: Use flexible sleep
      commit: 2b32d2f7ce0a54ce74a75f0d939b5ee063a05ec5

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
