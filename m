Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6169D2A87FC
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 21:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732136AbgKEUWa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 15:22:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:34552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgKEUVV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Nov 2020 15:21:21 -0500
Subject: Re: [GIT PULL] Power management fixes for v5.10-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604607680;
        bh=hyUUykc7EpmKI4gE/dd2hKfUvqo6+V38JIdpZuBFG7A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=B0kyrkFA4qzuGAJbPi0Fj47vvwdqdjg2XB3QqmQCH0cqDXCJG1VQ8/tZE4aPr+f6t
         3ArZLvwK66TQxfMcipgh0No5hNolrUGrjRjfeCctM8fUCEJ7Ekb7TFjbAz7MbPtT4u
         a3fIrI3FFuKYU0LavJ+7eegD+dJd8Wi265jSk23Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jgoa3kLeVsZz8Ac8bkzsFdiMerwvRtCxqk9y4ABoK_6A@mail.gmail.com>
References: <CAJZ5v0jgoa3kLeVsZz8Ac8bkzsFdiMerwvRtCxqk9y4ABoK_6A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jgoa3kLeVsZz8Ac8bkzsFdiMerwvRtCxqk9y4ABoK_6A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.10-rc3
X-PR-Tracked-Commit-Id: 8c14577df4cd5c6d8b799bdfb3a0e94923f17d50
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f786dfa3745b92f2fa91e0a0b9f3509907111d96
Message-Id: <160460768062.18865.409966236744321405.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Nov 2020 20:21:20 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Thu, 5 Nov 2020 15:20:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.10-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f786dfa3745b92f2fa91e0a0b9f3509907111d96

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
