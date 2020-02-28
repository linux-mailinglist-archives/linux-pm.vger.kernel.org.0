Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAFD9173E1C
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2020 18:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgB1RPI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Feb 2020 12:15:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:41410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgB1RPI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Feb 2020 12:15:08 -0500
Subject: Re: [GIT PULL] Power management fixes for v5.6-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582910108;
        bh=RrP5Dgl4j+L6ERWz1pb6emH0HVao2TuEMWwSAeayu5k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iQDT7T2ZoW1E72ZnZV5n/rAMT/LTVZOEjS/iIsa9cw+0ilEvNo5L3yybRz3r2IzRb
         jcz9dHMCYq5YI60ea0opcUNJ0AH7/Z5X3TVnQKL60+QGxHWUjIF9sUxJQd5xpIUHyf
         V+1b/AQA0z1xaQO5s0Kj2yYmlvZqXPTfD0zWZaa4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gWVkz7Denfz59r6xXbUjvXWOifEVO4T2tr7EZpWL3oJw@mail.gmail.com>
References: <CAJZ5v0gWVkz7Denfz59r6xXbUjvXWOifEVO4T2tr7EZpWL3oJw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gWVkz7Denfz59r6xXbUjvXWOifEVO4T2tr7EZpWL3oJw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.6-rc4
X-PR-Tracked-Commit-Id: 189c6967fe61729fa7e9cdc32690b08fc7eebe41
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 36428598126ec20329537825ecd855ac77334301
Message-Id: <158291010823.6279.4848920210421010088.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Feb 2020 17:15:08 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 28 Feb 2020 11:26:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.6-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/36428598126ec20329537825ecd855ac77334301

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
