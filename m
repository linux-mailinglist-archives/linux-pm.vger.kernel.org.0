Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B513E3023
	for <lists+linux-pm@lfdr.de>; Fri,  6 Aug 2021 22:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237293AbhHFUL3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Aug 2021 16:11:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244659AbhHFUL0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Aug 2021 16:11:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C61BE61154;
        Fri,  6 Aug 2021 20:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628280670;
        bh=XvhoFCbRmXWYvxYsvjjMDqGR/RdmuT2QxjFds4AGd5M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PzbL3DUxLa/DB5L12sGAFUkphivZj1Orjxk0gWVVFJIQR1/cMycp00fnOUQ4A4/wx
         /iS7CPUpJI43paXWldc3lqwVTRySm4mPrf8FTYIoevHRzOAAyWoTsE4+LkfpDwLZfX
         ld87D30ewbFN9FOaGc3tz1ExFghaB/iIDHNEl671cRFbZRNVqw4j74knh9Xh/ZGn0n
         Q9D0Y1BkzWDQ5Ia8cjE49/pBC1iQaEEvoW/Rl8XFYJ1817UpyKXIO9UuOu0JiSL44j
         6qsDIm4elOEisWbxDEk11xNqKXGXgsSMza5cHgaL7rkMDYxlKhsCuL+Ys5/j6vIqzu
         FyRKnhj+0cpmQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BABEC60A7C;
        Fri,  6 Aug 2021 20:11:10 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v5.14-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jUHUByXOpDKgKeEJzwDq7eE36sP9sVdRJn7jMBSneTMw@mail.gmail.com>
References: <CAJZ5v0jUHUByXOpDKgKeEJzwDq7eE36sP9sVdRJn7jMBSneTMw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jUHUByXOpDKgKeEJzwDq7eE36sP9sVdRJn7jMBSneTMw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.14-rc5
X-PR-Tracked-Commit-Id: 4adae7dd10db10f20f51833dc11b3cf7a342ad38
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9917de73b499d160e76b6cc0aad2b3869dd057a3
Message-Id: <162828067075.25549.12530540429653377601.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Aug 2021 20:11:10 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 6 Aug 2021 19:56:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.14-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9917de73b499d160e76b6cc0aad2b3869dd057a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
