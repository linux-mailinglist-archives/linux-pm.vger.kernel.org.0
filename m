Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEAB3972B
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 23:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730722AbfFGVAM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jun 2019 17:00:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730647AbfFGVAM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Jun 2019 17:00:12 -0400
Subject: Re: [GIT PULL] Power management fixes for v5.2-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559941211;
        bh=MmzMvR5g/IwrMNES/JCm0OVQNxH5nDQYz/rzpl94pNc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=atWdKSjqvGKxsj1gRF/+L8exOpa900Ss4PBKBBBE5kOkm+SPj5LZeIYax4NqTf5+A
         tACRBG5sP0YoE/ja05fheGbbeZrRpXholtzbh1K7ikHR/oUDNP+6HW8yOAFdXgAaKq
         9TPJmeGpxgxSSZP9WCviHbdWvxcoOQ7NAhMa5tZE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gsNdzUMQuWmaTi8fFub0=AL3-7iPq93AVMyFB1yzkmcA@mail.gmail.com>
References: <CAJZ5v0gsNdzUMQuWmaTi8fFub0=AL3-7iPq93AVMyFB1yzkmcA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gsNdzUMQuWmaTi8fFub0=AL3-7iPq93AVMyFB1yzkmcA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.2-rc4
X-PR-Tracked-Commit-Id: a964d23c94e8177c501fc9a37dcf1f0dd2750527
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a373ec23ab527c3202eb05e4f9d0eba2d83a7b27
Message-Id: <155994121166.4194.14197677759941713332.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Jun 2019 21:00:11 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 7 Jun 2019 11:15:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.2-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a373ec23ab527c3202eb05e4f9d0eba2d83a7b27

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
