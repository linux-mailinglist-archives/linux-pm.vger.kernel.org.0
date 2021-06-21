Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C08F3AF55F
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 20:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhFUSsy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 14:48:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:40024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231230AbhFUSsw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 21 Jun 2021 14:48:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94090611BD;
        Mon, 21 Jun 2021 18:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624301198;
        bh=qj744D706TyLzYHbyimIMkHWpg6Flb4R+WG1Q1smICE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rsacp2LTXROn4UiKGve4taCoslKwvxYeVJeQChkJIG056ju5JiHEPBuz83rriyFE7
         vk9nG7gwkTXQq83E00xPoPZs/7p6w3kMv9fFTQMsmbHoSyN8g7M3NJFEiCuEbfvTo7
         5g6DgDtwNinRqBvHBypWIbLS1xIpnzx9qf6lA+JJRMDpp7lupnTLI7Qvlu28UxBs9Y
         TUdxHyXfRbW8cAkK2LLK9Ak5Hd5RAyEEJ+2gu7xWAAEpt/4gOgwLWnCQrBlweXGDIQ
         zbZvXaztVh/rr9krZD6BJe44kgtQOTupv2iyT7EQt6qSkAW/FRVn+u6jwn6YFUa0B7
         VktG0niuxYQJQ==
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Matteo Croce <mcroce@microsoft.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        bjorn.andersson@linaro.org, Kees Cook <keescook@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Josef Bacik <josef@toxicpanda.com>, linux-pm@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Amit Kucheria <amitk@kernel.org>, devicetree@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        lgirdwood@gmail.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-renesas-soc@vger.kernel.org, agross@kernel.org,
        linux-power <linux-power@fi.rohmeurope.com>
Subject: Re: [PATCH RESEND v10 00/11] Extend regulator notification support
Date:   Mon, 21 Jun 2021 19:45:52 +0100
Message-Id: <162430087046.9551.16763333166755641433.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1622628333.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1622628333.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 3 Jun 2021 08:40:07 +0300, Matti Vaittinen wrote:
> Extend regulator notification support
> 
> This series extends the regulator notification and error flag support.
> Initial discussion on the topic can be found here:
> https://lore.kernel.org/lkml/6046836e22b8252983f08d5621c35ececb97820d.camel@fi.rohmeurope.com/
> 
> In a nutshell - the series adds:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[01/11] dt_bindings: Add protection limit properties
        commit: 673e851b7da81256e73fb738c550ec39bac1c9ff
[02/11] reboot: Add hardware protection power-off
        commit: dfa19b11385d4cf8f0242fd93e2073e25183c331
[03/11] thermal: Use generic HW-protection shutdown API
        commit: db0aeb4f074f7023da26fb65078197c39590346b
[04/11] regulator: add warning flags
        commit: e6c3092d43faf0aa095160cc552f8c05490d0962
[05/11] regulator: move rdev_print helpers to internal.h
        commit: 157d2230193ae683fcffcc1cd0a2c3aa4479955f
[06/11] regulator: IRQ based event/error notification helpers
        commit: 7111c6d1b31b42c8c758f6681e895a5116e3bad6
[07/11] regulator: add property parsing and callbacks to set protection limits
        commit: 89a6a5e56c8248a077d12424a1383a6b18ea840b
[08/11] dt-bindings: regulator: bd9576 add FET ON-resistance for OCW
        commit: 627793e4ca4f511837de893545baf0e1b8174dc2
[09/11] regulator: bd9576: Support error reporting
        commit: e7bf1fa58c46db9f72220c4472272d6da0a54c91
[10/11] regulator: bd9576: Fix the driver name in id table
        commit: e71e7d3df7eb712fc29b609bd712a63d60b81b5f
[11/11] MAINTAINERS: Add reviewer for regulator irq_helpers
        commit: d55444adedaee5a3024c61637032057fcf38491b

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
