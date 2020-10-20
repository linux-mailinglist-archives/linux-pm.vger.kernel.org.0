Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2AE294203
	for <lists+linux-pm@lfdr.de>; Tue, 20 Oct 2020 20:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437346AbgJTSPG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Oct 2020 14:15:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437306AbgJTSPF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Oct 2020 14:15:05 -0400
Subject: Re: [GIT PULL] power-supply changes for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603217704;
        bh=Hjt8t16b8XoOB4dP4P/nLbfwDswRseOgupjcqGWJwYg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kX7rbt0WYYc6xsQRQB00CjUkYEviCIYUKo9B2qZKYBkHAFaf9FNRdMOH4NhUzCqKf
         ytdl/9KS0ZRelEQ4UwRER12OQqcwmb7SJ2QiRYFXhsq1MbltptWSO2XDuMrn/3d0rO
         KHZaPK9OIFnVigaNwDLNXTE2ioUPbw7j2pEZcuko=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201019210833.ll5l2g3ok5kyi6r6@earth.universe>
References: <20201019210833.ll5l2g3ok5kyi6r6@earth.universe>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201019210833.ll5l2g3ok5kyi6r6@earth.universe>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.10
X-PR-Tracked-Commit-Id: 7007fab4ae82c092cb52691c338f1b776005e32b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 38525c6919e2f6b27c1855905f342a0def3cbdcf
Message-Id: <160321770471.23516.2813426893065111537.pr-tracker-bot@kernel.org>
Date:   Tue, 20 Oct 2020 18:15:04 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Mon, 19 Oct 2020 23:08:33 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/38525c6919e2f6b27c1855905f342a0def3cbdcf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
