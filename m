Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C3F1CB576
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 19:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgEHRNt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 13:13:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727824AbgEHRNt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 May 2020 13:13:49 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3956D24955;
        Fri,  8 May 2020 17:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588958028;
        bh=PwDwGLPB/vmEn/XMf+w4VRIZtv0DET4wLqOPmH36V0A=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=gJDKMMtlo0CromuNqAnnO5/Ncs4qU6x0TCenBYGK2Wo7slhCjc+LIdShUbbl3llQk
         3+QkPPgWbgXDtpgtE7ZjiuLyP4cogtwKla6zHy+zQMdvxf2cOlW+wpPsNjKCmM7hTZ
         FNy7N9JvgJWoLcGz7mRP1I1Lg9rCSEZzpsUOn1/o=
Date:   Fri, 08 May 2020 18:13:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mazziesaccount@gmail.com
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com
In-Reply-To: <cover.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v12 00/11] Support ROHM BD99954 charger IC
Message-Id: <158895800278.30774.18266282191247434212.b4-ty@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 8 May 2020 18:38:17 +0300, Matti Vaittinen wrote:
> Please note that this series should be applied to two trees. Patches
> 1-4 (or 1-5 as suggested by Sebastian) should go to regulator tree.
> Perhaps Mark can provide an immutable branch to Sebastian? Rest of the
> patches can then go to power-supply tree.
> 
> Support ROHM BD99954 Battery Management IC
> 
> [...]

Applied to

   local tree regulator/for-5.7

Thanks!

[1/4] lib: add linear ranges helpers
      (no commit info)
[2/4] lib/test_linear_ranges: add a test for the 'linear_ranges'
      (no commit info)
[3/4] power: supply: bd70528: rename linear_range to avoid collision
      (no commit info)
[4/4] regulator: use linear_ranges helper
      (no commit info)

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
