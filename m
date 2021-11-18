Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA7A4565EE
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 23:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbhKRW7V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Nov 2021 17:59:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:42540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232704AbhKRW7R (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 18 Nov 2021 17:59:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 9E3FE61A81;
        Thu, 18 Nov 2021 22:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637276176;
        bh=3ZWbJsCfqg9Q4k+O3XRw0qJ0HqzjY/eAiFBZVYhCuiM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZsWrDjJ1h6vbeROxAR+OT3LEXFgJYen6zF/s5TvA2V5sne2687UgBXvr/SYumvszS
         bj9SWZyEU6WxbeMzupuW7VTO9PhVd7osvhn0/HJu+EjBTA3wW/w5VD2AEiFoAuIwAo
         l0CQyoWqWOeJcOastqiySu8umZZRhHOuWeEXnGKFDewwbb5RuZNajnRdw57IayPhiK
         2xkfKfh6hEWZBxL1nq9i+UAm3UdC+EbSoqgccIHe24u5wMndj/qSjVulFpdetjDdy0
         /lg7nBVguy3qjAdd8w/kwxr2pU9dxO5YdkshwwTyWQvFaNnGQXBXDb1QXItUdxPdB/
         Xvc/KVnNxAOxg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 98DC760A3A;
        Thu, 18 Nov 2021 22:56:16 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fixes for v5.16-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j98u1yWQuOxds6Vz_BiuE=QAqaZ=rUrK7_a33ftCpTMw@mail.gmail.com>
References: <CAJZ5v0j98u1yWQuOxds6Vz_BiuE=QAqaZ=rUrK7_a33ftCpTMw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j98u1yWQuOxds6Vz_BiuE=QAqaZ=rUrK7_a33ftCpTMw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-5.16-rc2
X-PR-Tracked-Commit-Id: b49e0015c1bd8ab6c228981ca2eb4ad217ed8223
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e26dd976580a6a427c69e6116508dd3d412742e5
Message-Id: <163727617662.9679.15990283015838951649.pr-tracker-bot@kernel.org>
Date:   Thu, 18 Nov 2021 22:56:16 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Thu, 18 Nov 2021 21:15:51 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-5.16-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e26dd976580a6a427c69e6116508dd3d412742e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
