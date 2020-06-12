Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96B41F7EDF
	for <lists+linux-pm@lfdr.de>; Sat, 13 Jun 2020 00:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgFLWZ3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Jun 2020 18:25:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbgFLWZ3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 12 Jun 2020 18:25:29 -0400
Subject: Re: [GIT PULL] thermal for v5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592000728;
        bh=4zaKzEi4EnemdsIVs/6rTPqYCSaE7Iwiap3pvezFVT4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cc889wEOMCyjmvcrdQHsA6WxbStne9wNsxN5bsEvvlkzT6Dd6IksjGRDhthG7Dpki
         o/secEvdd3LtBByZero2t/tSxkdVqdmFu3XdF5M1Ehl379w4W8D3F0E07LN7wMRbOX
         C8Qpe0KUJNfvdnTVn5IHFeRyD4ta1WGsoiRvJfMI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <065248c0-668a-c84c-ae89-dcd29f0d09ac@linaro.org>
References: <065248c0-668a-c84c-ae89-dcd29f0d09ac@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <065248c0-668a-c84c-ae89-dcd29f0d09ac@linaro.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
 tags/thermal-v5.8-rc1
X-PR-Tracked-Commit-Id: 8d485da0ddee79d0e6713405694253d401e41b93
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df2fbf5bfa0e7fff8b4784507e4d68f200454318
Message-Id: <159200072891.21329.1537750738587588961.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Jun 2020 22:25:28 +0000
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 12 Jun 2020 21:32:44 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git tags/thermal-v5.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df2fbf5bfa0e7fff8b4784507e4d68f200454318

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
