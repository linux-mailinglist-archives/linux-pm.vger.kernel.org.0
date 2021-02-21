Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEA73208E4
	for <lists+linux-pm@lfdr.de>; Sun, 21 Feb 2021 07:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbhBUGAN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Feb 2021 01:00:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:47430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231654AbhBUGAK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 21 Feb 2021 01:00:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 92BD764E5F;
        Sun, 21 Feb 2021 05:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613887169;
        bh=htMb8wmbO3Q3NoqFPY1nONA6ueRd1YRqkC5ZUn2Lfh0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IGGyh/NZ1tHjkdP3/A+11GwzoZ2LpwTDVDsHVXm3RNJfXVev/Vf18Shg0Rk8rewWy
         088b/Wbr5h3LYna2BERQN4Ofq0hWno8xd6vo9hYRVcNkSdOFpKbrM8PiE/n0rynM6/
         yR/hYsL1ifREA0uUCtR0NLs68tdDGogR3mtUDoitMYH37lmEtINEh90cRv4wR3b9HE
         oonawFWy5HJIQ+Or39jxGEwKCMcFk3tKKubBg0wo/tm6Dyp6DhHAO2O0TbsRtGmzxc
         U6ir4spwCmt4iD7WS+pMwv6uHMYpxcMMWmENv/tbuL2PbPi4ihjSfOCckPngnN68Zh
         sDcS6FCSu8Obg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7AD8060A3D;
        Sun, 21 Feb 2021 05:59:29 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jG3apd6f6zsyd4JeGJ5cK14DMQJAmNx5jrnMtMiXhQDw@mail.gmail.com>
References: <CAJZ5v0jG3apd6f6zsyd4JeGJ5cK14DMQJAmNx5jrnMtMiXhQDw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jG3apd6f6zsyd4JeGJ5cK14DMQJAmNx5jrnMtMiXhQDw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.12-rc1
X-PR-Tracked-Commit-Id: a9a939cb34dfffb9f43b988a681d2566ca157b74
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 02f9fc286e039d0bef7284fb1200ee755b525bde
Message-Id: <161388716943.9286.17035780542568212233.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 05:59:29 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 19:43:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/02f9fc286e039d0bef7284fb1200ee755b525bde

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
