Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF46321EE5
	for <lists+linux-pm@lfdr.de>; Mon, 22 Feb 2021 19:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhBVSMp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Feb 2021 13:12:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:37416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230502AbhBVSMh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Feb 2021 13:12:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 6CA9864EEC;
        Mon, 22 Feb 2021 18:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614017517;
        bh=Mas6wMY0Ix2EDGM/mvpQD8X1VjAfJWuosZfjHzlDmtM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=r7nVAUJMMeWnbyNXluEVtkQpT9tsb9PQ0M8UH6lT7Uxg9hbrKVOmlW5PwnRqZj1V5
         MVirSQcRD8fTBUVJGknvvrL4AkaaGOuRldga3eGlqVtz9FnVYhukf8YCVwXDmUTDWK
         1LdO2LdTdlf9/DKP/OZKpaBPD0V/Y8SOnM2MiTsUBsaOfBcmEr81w268pX0grtDMMl
         g4V7Yubd5yUrMuQxFWPnD/8NlcDql3L35wTetr8n8TEGWVE6X023Gn3MFjZz+BxFvY
         KQj8kGzkmRVXuuZVR35UxLEGce8k1YMyU21o/kzm8T4wuycREbn/Ld4FSXPaI+/h+S
         jMCZiXZOA3f1A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6819260982;
        Mon, 22 Feb 2021 18:11:57 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210221235002.yjqkcbuugnusveg6@earth.universe>
References: <20210221235002.yjqkcbuugnusveg6@earth.universe>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210221235002.yjqkcbuugnusveg6@earth.universe>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.12
X-PR-Tracked-Commit-Id: a72acc56f3e939b9e10f2dd460ac1e4519de621f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a7dcf5f2356506677c03be5760b5b2111a24a1ec
Message-Id: <161401751741.943.9344531827123466350.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 18:11:57 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Mon, 22 Feb 2021 00:50:02 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a7dcf5f2356506677c03be5760b5b2111a24a1ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
