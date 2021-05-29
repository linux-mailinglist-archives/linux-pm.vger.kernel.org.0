Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A702F394D4D
	for <lists+linux-pm@lfdr.de>; Sat, 29 May 2021 19:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhE2RDi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 29 May 2021 13:03:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229704AbhE2RDh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 29 May 2021 13:03:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 38AC060C3F;
        Sat, 29 May 2021 17:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622307721;
        bh=mFe1ePHLNGmUK4AlS7ZL5ywO1HVn3KePmIlpwVSHyRI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CM34DONsrCESFihPhvn7SPy4TNJ5MQ1/0TZc2Y5e5fZq9iYFA4wRhRJQujdZgRmzK
         OpVp/nUJOn1dgHWuU33yyPmXlG16OPrMIom6iGUma11J/0TTadIqDBlhsSU3QIu4En
         Wdj4TXr/7zjSOifrAeQXHZmtFXpZp9c5RIAPOmeVPlAypWUVnh5pahZ5h7MVgZ9tSB
         dfFluLN/24LRcXY/ymgYhUQJoGSffw5+bvtuwfy3pR/I+gaFWirQgw4dcinCVZiGfY
         zejqbl7xsG7IDU2/OdmheCudLh2sPG0aWdet+wFDxP3LqD5ElDPYyTosMlS05m3KO7
         +RRtOzTFx7pYA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2124C60987;
        Sat, 29 May 2021 17:02:01 +0000 (UTC)
Subject: Re: [GIT PULL] thermal fixes for v5.13-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <3afbc05e-437b-91e5-fdeb-9682d33adcb9@linaro.org>
References: <3afbc05e-437b-91e5-fdeb-9682d33adcb9@linaro.org>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <3afbc05e-437b-91e5-fdeb-9682d33adcb9@linaro.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git tags/thermal-v5.13-rc4
X-PR-Tracked-Commit-Id: 5d8db38ad7660e4d78f4e2a63f14336f31f07a63
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df8c66c4cfb91f2372d138b9b714f6df6f506966
Message-Id: <162230772107.10327.2273688364058454267.pr-tracker-bot@kernel.org>
Date:   Sat, 29 May 2021 17:02:01 +0000
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Zhang Rui <rui.zhang@intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Sat, 29 May 2021 18:12:48 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git tags/thermal-v5.13-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df8c66c4cfb91f2372d138b9b714f6df6f506966

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
