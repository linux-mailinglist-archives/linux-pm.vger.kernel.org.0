Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBFDF3FCEAB
	for <lists+linux-pm@lfdr.de>; Tue, 31 Aug 2021 22:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241114AbhHaUkc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 16:40:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230236AbhHaUkc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 31 Aug 2021 16:40:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 927D161053;
        Tue, 31 Aug 2021 20:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630442376;
        bh=xLZ/1mY5QG/9clU9pe5zl9zFjjsBuBAHBOEoGfZkLp4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fzQQ/3yu6wJqF9CWM/B52gT315bH/reJFpagFetwbHSeVWVql0C5HD0vm3jAqR4su
         6GYxB3i1de3bGTq/VbgKOLMOGw2BuIgmVezCS9unROSbo1OmeOc8JZJH2r7p1mMd//
         ewUxMvd4AMaCyhIUlAm9V9mxeNt2QIoUDr2kbflXLGSmxfdMnDKxd+ZBQEdUCKZ7TH
         tYNNEQkc8Z5hWSxvRKe5+6DUPKEpVBlpMibINIVHYRRDB0F+WFfhjItvsvVMTBgHKt
         cA2Jnm3ACw8qVyRuO4MFKz0V2LwBvmymxa4e+Vb0vpafruuU1KTNe1cXQAjfJstUPi
         4o2w/mxtAISqA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 80B3D60A6F;
        Tue, 31 Aug 2021 20:39:36 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hqMbLjTO71URfxCiKv6+Ha9BMA0ive1tEcjP7VqA1XZg@mail.gmail.com>
References: <CAJZ5v0hqMbLjTO71URfxCiKv6+Ha9BMA0ive1tEcjP7VqA1XZg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hqMbLjTO71URfxCiKv6+Ha9BMA0ive1tEcjP7VqA1XZg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.15-rc1
X-PR-Tracked-Commit-Id: fe583359ddf0d509275b87b635fa8b2e3794321e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5cbba60596b1f32f637190ca9ed5b1acdadb852c
Message-Id: <163044237646.32655.1260891965854378909.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Aug 2021 20:39:36 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 20:41:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5cbba60596b1f32f637190ca9ed5b1acdadb852c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
