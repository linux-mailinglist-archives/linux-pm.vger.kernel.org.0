Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A00861381A2
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2020 15:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbgAKOph (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 Jan 2020 09:45:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:36024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729855AbgAKOpF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 11 Jan 2020 09:45:05 -0500
Subject: Re: [GIT PULL] Power management fixes for v5.5-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578753905;
        bh=9ScKvS8kQxXGTEoGGcCyHr0nk8zo26T+uw4ZzvyRijE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GSk1g4jmGhQXRHYIhORDZIwNLZfc5D03EJ8VTrqsoCjTRKDpXQSOeY+hhRbc1EHiz
         Xy8WimbwZZaACFimp9rhttbO5A3LM1SLuO8yt2J2L1xRcq6j7MaGgEvDKX4t4vfnYI
         IiJFrcIEoPoOZgEnsJO5VKs6TRgIIzjJkox0Eyjs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0g27E7+wsrMXw1KhUQV6PZJhWcSQ5VG_HTZ5JgYejh15w@mail.gmail.com>
References: <CAJZ5v0g27E7+wsrMXw1KhUQV6PZJhWcSQ5VG_HTZ5JgYejh15w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0g27E7+wsrMXw1KhUQV6PZJhWcSQ5VG_HTZ5JgYejh15w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.5-rc6
X-PR-Tracked-Commit-Id: 10674d97c4e266e8c50ce794d1c470c26228d52b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c23e744b59efcf546b2b16834c68b85248d6bf3b
Message-Id: <157875390529.30634.2723351899925028830.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Jan 2020 14:45:05 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 10 Jan 2020 11:23:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.5-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c23e744b59efcf546b2b16834c68b85248d6bf3b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
