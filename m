Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F1C308FE2
	for <lists+linux-pm@lfdr.de>; Fri, 29 Jan 2021 23:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbhA2WNI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Jan 2021 17:13:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:57218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233543AbhA2WM7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 Jan 2021 17:12:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4245864DE9;
        Fri, 29 Jan 2021 22:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611958338;
        bh=PbDZBnoISy8/0Is+Exrh6bUScaPJeGfAdG42sjtUgxQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EfUMU7kl9BAl97Rqwrt5oilgy6oOAnhvGx+h4b1t/1VRRLD8sAy+OUoN0AsURmgfx
         EznyS0vGMFuNtusameeHcJUqPLlMQJQPEnA9By23ntxcQU26zUVhBjISbIf/9EaB02
         nTMdUbmj9gA9W4otahAEMuNoJ3KsoCSeNJr52ZQkcJsXzsm0zuzk31I6ILCYdf8BBP
         B78iL1b/j4j7gOWXddQiRHEZUt9/Hz89nm0Wa5LXFLmdEw0AW4breEeOo4Wfjdvp7z
         KaFCk5c35XypzcI5M5sm7JacoDdOP0V6xR7US9Q0gIxWAoP+rJ8KiAEVQGUMGumHmt
         f0+7ZO0Ks9ATg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4F31360953;
        Fri, 29 Jan 2021 22:12:18 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v5.11-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0ip25AwMxWuwQMTbqQ3BSKoqLazh-Eso5SqNrHyjP3bHw@mail.gmail.com>
References: <CAJZ5v0ip25AwMxWuwQMTbqQ3BSKoqLazh-Eso5SqNrHyjP3bHw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0ip25AwMxWuwQMTbqQ3BSKoqLazh-Eso5SqNrHyjP3bHw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.11-rc6
X-PR-Tracked-Commit-Id: fef9c8d28e28a808274a18fbd8cc2685817fd62a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 32b0c410cda19df9f0e88edcae126d0a660cf8b9
Message-Id: <161195833831.1476.8059677816127282521.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Jan 2021 22:12:18 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 29 Jan 2021 17:26:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.11-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/32b0c410cda19df9f0e88edcae126d0a660cf8b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
