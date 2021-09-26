Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374A9418AC8
	for <lists+linux-pm@lfdr.de>; Sun, 26 Sep 2021 21:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhIZTcj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Sep 2021 15:32:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229950AbhIZTcj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 26 Sep 2021 15:32:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C4DDF610A8;
        Sun, 26 Sep 2021 19:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632684662;
        bh=QTpaiB6A/SEkS42z0gjtKV3OSdUc8Oy72FBUHvB3cnc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OsR2PG5ixkIdSWYXIyTYLXTRcCkza9sJX2495sprc3YzUUIzspZF8Spo7/qNgx+5+
         SClvPYNr4CLlPK5AYu762YJqRyJZlWhUyfuQvNUiNaSGYMXWQZlpreM+qhuzOJOFi1
         sQcUrFuCs+Erru5MiizYq3vXo8jC54SaO5lnJozwrWqujW6C6lTPNmZRwFDuYnENCL
         YsyB3nZAULpg3GSzb3lEjsBJlKkJMXrJNrDYXhmgVuI1yeQSoXvTBX4y8D8yXOMvVk
         GNZ58b6b0ZdBSCBkSnSdPOZlCpu2/G7I0z5kR+gfZfdQfldAIbkVf+Oh2eCxd/1YyU
         7mJGzyLG/OP5Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BDF7A60A12;
        Sun, 26 Sep 2021 19:31:02 +0000 (UTC)
Subject: Re: [GIT PULL] thermal for v5.15-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <15f013d8-d746-6034-bbe7-dc86cd8fbdf1@linaro.org>
References: <15f013d8-d746-6034-bbe7-dc86cd8fbdf1@linaro.org>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <15f013d8-d746-6034-bbe7-dc86cd8fbdf1@linaro.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git tags/thermal-v5.15-rc3
X-PR-Tracked-Commit-Id: cf96921876dcee4d6ac07b9de470368a075ba9ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 299d6e47e8f8665904b9c8c321edb3876c92f68b
Message-Id: <163268466277.21680.15607448515937446683.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Sep 2021 19:31:02 +0000
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Sun, 26 Sep 2021 19:57:19 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git tags/thermal-v5.15-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/299d6e47e8f8665904b9c8c321edb3876c92f68b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
