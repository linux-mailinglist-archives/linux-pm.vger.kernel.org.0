Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4479719EE20
	for <lists+linux-pm@lfdr.de>; Sun,  5 Apr 2020 22:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgDEUuX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Apr 2020 16:50:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:32818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbgDEUuX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 5 Apr 2020 16:50:23 -0400
Subject: Re: [GIT PULL] power-supply changes for 5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586119822;
        bh=2ZzpHbWz8cqTRnrGS/98b/OKW5nFDEswVhBZyu24Gxg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pmf6vtExYaGDy1QExFIVU6fUW9jZiiPRnhp+mqb1oLCwaFjNTMtofgkgoIzihb/BQ
         y3/wdTRm7r03RvbpUtUs9ONrAfbWekK4MdAKv0sj/eyC04H92UxV279fZRwbKdku+6
         dcvdjZ8yucwMhgZ4L0DIuE6uKufnfsqIHBTJaSVA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200405161209.4e3z23eyvp2wsrus@earth.universe>
References: <20200405161209.4e3z23eyvp2wsrus@earth.universe>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200405161209.4e3z23eyvp2wsrus@earth.universe>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
 tags/for-v5.7
X-PR-Tracked-Commit-Id: f78c55e3b4806974f7d590b2aab8683232b7bd25
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a10c9c710f9ecea87b9f4bbb837467893b4bef01
Message-Id: <158611982258.18205.6037152354580543046.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Apr 2020 20:50:22 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Sun, 5 Apr 2020 18:12:09 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a10c9c710f9ecea87b9f4bbb837467893b4bef01

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
