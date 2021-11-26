Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C02345F60A
	for <lists+linux-pm@lfdr.de>; Fri, 26 Nov 2021 21:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240061AbhKZUr0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Nov 2021 15:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240258AbhKZUp0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Nov 2021 15:45:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DEAC0613E1;
        Fri, 26 Nov 2021 12:40:13 -0800 (PST)
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3640462332;
        Fri, 26 Nov 2021 20:40:13 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 9DA03601FA;
        Fri, 26 Nov 2021 20:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637959212;
        bh=Y3l7rhzbvzIbYv53e/vGdtKXQo96iSNzbA/uoFdp+ig=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tnm1w2GSE0TgvJBeRtq3qFXSoxc0E6iheAvZ9g/KhtXDFjo6sLOP9n+Vy9IsMc9+0
         xNPqTXAlX+XMxr5THN/QKyNcS4soJIky7iNHc41f61zsuRiMyD88rvDb1vrU98KZRZ
         nJQ4wKgcchUVYgy8FQ2Jdt+iAshXQP7Ca5tkvDEpVv6oW0GiIYWBgSAjUfr4hQ0y/y
         n+hUeMUOIh+OR+mBkGr9LuElcL5ixi0pLy/qea9o41HKQ8DjYO71ZY5n0peMEJ+Cnb
         gEVZ5VonMHieQkojxkTYRy5daMXs2/TwtPNs7+h2yBoUyO7z94UbNbellr7GYBwWB9
         tKFOm4p3Xvwlg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 76285609D5;
        Fri, 26 Nov 2021 20:40:12 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v5.16-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jNK=LfKcXDR+ibnczM3+D+GHH_-UCMi=sj47aaLxXoJA@mail.gmail.com>
References: <CAJZ5v0jNK=LfKcXDR+ibnczM3+D+GHH_-UCMi=sj47aaLxXoJA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jNK=LfKcXDR+ibnczM3+D+GHH_-UCMi=sj47aaLxXoJA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.16-rc3
X-PR-Tracked-Commit-Id: 7803516dbe26518115408d53a500ccb4d6a7d1c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0ce629b15d3c44b2faf6d0cf5122d7fae5ba89bb
Message-Id: <163795921247.10726.17104000819762329880.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Nov 2021 20:40:12 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 26 Nov 2021 20:36:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.16-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0ce629b15d3c44b2faf6d0cf5122d7fae5ba89bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
