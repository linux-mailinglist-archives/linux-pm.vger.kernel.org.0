Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122213749B0
	for <lists+linux-pm@lfdr.de>; Wed,  5 May 2021 22:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhEEUuj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 May 2021 16:50:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230087AbhEEUu1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 May 2021 16:50:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id F0A43613E3;
        Wed,  5 May 2021 20:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620247771;
        bh=tYO4fRB9G1wcKS4uhifFOsp/m8Sn9BrdXFG5rs0FEPA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qXN44gHFv0Y2h/LqVK5mSZgJN6R++H662olEyl9QYpaq1Dh5XucN3MOMYUU15EIvR
         B4YibdS5B8l3NGH3pwjvBYQ6M71Q0gYxxBIYzaVq7+uYpvD6mPyayjjLouftwKhodR
         XKyhjEs5jOe40SYvEvAdemmtbxjxZkn49rX7dagmywrrvhZWIXMi/oGqQxoL8QVbIj
         M8a7xwse9B8OZbfmWLpVDTwoSW8zxErAiAV5zjjyolsASwI6L9C4/S2wYDQPBl7afI
         WXzV4RsCUui9/KVQ2GIIZRJkYlm0AqhOB2SBY49ONsRe+ZYD9awbcmnXTgDpwhG/ct
         aKlHzV2sD2EEA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E8878609AD;
        Wed,  5 May 2021 20:49:30 +0000 (UTC)
Subject: Re: [GIT PULL] turbostat update
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJvTdKk9rNJhy1Ddpq-mbMzG0bJ8N8TumPfWpv6DUBP4N9tUyQ@mail.gmail.com>
References: <CAJvTdKk9rNJhy1Ddpq-mbMzG0bJ8N8TumPfWpv6DUBP4N9tUyQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJvTdKk9rNJhy1Ddpq-mbMzG0bJ8N8TumPfWpv6DUBP4N9tUyQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat
X-PR-Tracked-Commit-Id: 3c070b2abf85b92455c2721d0a9edc68893ab6c1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8cb379cda885ac172454d7e680da65ebd6676b1
Message-Id: <162024777094.12235.8153240043332342464.pr-tracker-bot@kernel.org>
Date:   Wed, 05 May 2021 20:49:30 +0000
To:     Len Brown <lenb@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Tue, 4 May 2021 20:10:13 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8cb379cda885ac172454d7e680da65ebd6676b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
