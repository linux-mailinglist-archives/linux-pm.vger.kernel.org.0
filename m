Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1773F3587
	for <lists+linux-pm@lfdr.de>; Fri, 20 Aug 2021 22:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239103AbhHTUsu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Aug 2021 16:48:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240455AbhHTUst (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 20 Aug 2021 16:48:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3DBFE61042;
        Fri, 20 Aug 2021 20:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629492491;
        bh=ake4mSneljk4QfLbd6tt28+4ImksICl9mydvqplJURQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QLRR2qn3YUyzob1V02f9c83cSWxSz/FSrslb3p3hprkuFOGMLuUfuHiZ4jSu63PPc
         iaOs2N6pGQvmr9Cmtxc1HRLzudSHItNGLPpVSm0HHYJvTuxEWlXYPIgLMjSMtHLwp1
         CMXq+YlSfy+pWYL93E3XO/KXXoBzuBv4LgsZ5HEioR9u9roI6aDHnfGPWr3eYOzGD+
         oBwm1LSTXl0pX8PwMX5V3n/Y05ibVxJ1RLgL+3fxbfAQOLBQsA6dkQ6F93a/BqvIaX
         7/U6Ld9R6zoqGuA718fYpPmNGd63SzQlj8mdNQJwsveeVcksFjbF5jDPdYsWeTY/Of
         3nZnSJwOYghfw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 249B460A6B;
        Fri, 20 Aug 2021 20:48:11 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v5.14-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j7hmSZObB5Aptr=9z4LbbazwzWy7UK6KCjSp_1C8QCOQ@mail.gmail.com>
References: <CAJZ5v0j7hmSZObB5Aptr=9z4LbbazwzWy7UK6KCjSp_1C8QCOQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j7hmSZObB5Aptr=9z4LbbazwzWy7UK6KCjSp_1C8QCOQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.14-rc7
X-PR-Tracked-Commit-Id: f2963c7ec7cc337ca286271f3111b1ed3ad5f023
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cae68764583bab180c1ded681dea8c16dda87670
Message-Id: <162949249108.8168.17417012848542602704.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Aug 2021 20:48:11 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 20 Aug 2021 21:34:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.14-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cae68764583bab180c1ded681dea8c16dda87670

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
