Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46ADF2891BB
	for <lists+linux-pm@lfdr.de>; Fri,  9 Oct 2020 21:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390671AbgJITbs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Oct 2020 15:31:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390623AbgJITbs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Oct 2020 15:31:48 -0400
Subject: Re: [GIT PULL] power-supply changes for 5.9-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602271907;
        bh=Dd5vczaDIVbkcDLRT8QiNV6TfYFxZ8ZxSIXugpOIyVQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Y1ZW2UAjBloovq6LwghibdCfXdsjopXiiYOHjehvBc+pGSL8EWcyzwxio7lWhb27W
         MmA0FAxEU6u0ZDeTdW7FAtdO/aJvMbI722y6/v8RpIj5nCjxenYRTG6UpF4/JJx5Zb
         BBv8F6iHkhQzGl8zkGEsMMG1vw8CbMw5sUOS6PyI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201009175505.2wbc5tzsr4q2bx3t@earth.universe>
References: <20201009175505.2wbc5tzsr4q2bx3t@earth.universe>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201009175505.2wbc5tzsr4q2bx3t@earth.universe>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.9-rc
X-PR-Tracked-Commit-Id: e3f2396b7570751a7ddba996812fb608134fd63c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 277e570ae193ddd39a7d16f08e3647f2f110c6a3
Message-Id: <160227190773.24155.1793786571133496938.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Oct 2020 19:31:47 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 9 Oct 2020 19:55:05 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.9-rc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/277e570ae193ddd39a7d16f08e3647f2f110c6a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
