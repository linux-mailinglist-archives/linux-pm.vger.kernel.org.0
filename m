Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383D73BF0D5
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 22:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbhGGUmu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jul 2021 16:42:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:44348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232623AbhGGUmt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Jul 2021 16:42:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7418F61CBB;
        Wed,  7 Jul 2021 20:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625690408;
        bh=KLPZC0jEKST/yKn/E1tZxGDF0f5yT9/YvUfQoowUaTk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QgJpK85EP8PByUV0pOye3w8+e8Bwjuqi1Yy9QqVVT56GKXtehow5JmdHKLlgpLKGe
         foO3xhXBFqDocOKfTdtUgDSPgWk7YYw8g86QkjzTLG91EI11BYGxHcHhQc2WUAIBWN
         A9TixIbqvtERNWWEUo+BdBlCNAi/QER2pE+sYxIh883Ap71VNtn450kSbgEJG+kAT3
         J5RvLZL6yHNYtfgxNemTgkqEcRFaIBaiR8sKG1877ssxMSjpl30sZg8A+CO7TWvD9P
         UMOXlkgSbDa5sJJQ1F9u7rOAvjwqb45USEEe/kXPMUrwffCkrSqu0+Dztzq1AcaE8U
         KQBvy22wh8k+A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6D398609BA;
        Wed,  7 Jul 2021 20:40:08 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210707164732.4vcivdobkykccrha@earth.universe>
References: <20210707164732.4vcivdobkykccrha@earth.universe>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210707164732.4vcivdobkykccrha@earth.universe>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.14
X-PR-Tracked-Commit-Id: f1c74a6c07e76fcb31a4bcc1f437c4361a2674ce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c6e8c51f6978c7aa44641ea4e9071b42d921eb97
Message-Id: <162569040843.28701.7513514506526436955.pr-tracker-bot@kernel.org>
Date:   Wed, 07 Jul 2021 20:40:08 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Wed, 7 Jul 2021 18:47:32 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c6e8c51f6978c7aa44641ea4e9071b42d921eb97

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
