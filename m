Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBFB9321EDE
	for <lists+linux-pm@lfdr.de>; Mon, 22 Feb 2021 19:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhBVSMq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Feb 2021 13:12:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:37400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230492AbhBVSMh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Feb 2021 13:12:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4570C64E32;
        Mon, 22 Feb 2021 18:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614017517;
        bh=ecaAtDgT0Pq9QF1AZduzhrxyDXeqnS5UHmvDX+et+kQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SXSQMtCXnuEkXYuQFwnc3MRwVbxf94EvVQJBthWDIdFOwH43ftThTRUzxljMmmJKk
         MbxViMOMlaU05rOggXI0A3yAw9UaIsMcGJ+D2TO+YLPUWYmhPKizFoheQVFvpEsuW1
         JaRh6sGikyc5dk786tl8i+OgCUJHwsUaKN3bY+9ea/lPSYvOOLKsY0oLj/Zg94fc9y
         DTx4Rk/EjdVM1IjNKyi4SYw4LApnudMrD92I6VhviFqyWiiVFEX7UfxLDJppsZr2Vn
         0SsrrGyt7v2k0WjTZZPqFDhPXEiHsvx5JPd9gtBVVNl9/+hktfSXGxd8Q+l9BbLC4z
         09JHIDC/8kkew==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3E17160982;
        Mon, 22 Feb 2021 18:11:57 +0000 (UTC)
Subject: Re: [GIT PULL] thermal for v5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ace202cb-b9bc-c43a-8023-9c45946af3bf@linaro.org>
References: <ace202cb-b9bc-c43a-8023-9c45946af3bf@linaro.org>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <ace202cb-b9bc-c43a-8023-9c45946af3bf@linaro.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git tags/thermal-v5.12-rc1
X-PR-Tracked-Commit-Id: a51afb13311cd85b2f638c691b2734622277d8f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d26c176d58bc3f9380b18ba2f51a1d863c6a5a0
Message-Id: <161401751724.943.8084454317778200832.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 18:11:57 +0000
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Lukasz Luba <Lukasz.Luba@arm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Colin King <colin.king@canonical.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 19 Feb 2021 12:54:53 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git tags/thermal-v5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d26c176d58bc3f9380b18ba2f51a1d863c6a5a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
