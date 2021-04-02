Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D73353150
	for <lists+linux-pm@lfdr.de>; Sat,  3 Apr 2021 00:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbhDBWom (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Apr 2021 18:44:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235421AbhDBWom (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 2 Apr 2021 18:44:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7F07E61154;
        Fri,  2 Apr 2021 22:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617403480;
        bh=DN09CYtUUG9gAx7FZezb5jSqTy1W9pcFOrySOmILA1w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aSnTfIqYLZzegyQJBzLEwLkhXA9t6sIpraGuehZoUqro9nMvCoDlVTAuhCHaHffe0
         CdZRsLZ5TCCB7V3wSVpWEDa3pHvgCj7AvKs4GVeQvGwiWmzSHxYKnX2cdyuUIHj6ew
         TdSVOmHx8mg7EbZvJ2nPnmlLXHau2WjeWYCHpAcEtUlXRZgFcGzuBj3U+K+twFAg9h
         Cf0tj2SLQ6QcZTBT2f55L0d9saN/X8Gd77qv3IA7yPymbN4zWUtfwnzTvONnbutzo1
         PVza61llz3ePiSQVOhPACq7dFrh5+5iCTWGS6xKmMFovDtx1BWwf/ygLbwzwzr6nEk
         aUxxrT5NOWwQw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 73DA1609D2;
        Fri,  2 Apr 2021 22:44:40 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v5.12-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h=RmqSfW-F0YHsbDeg191ut4ZS7SN9dcCAFg_+EoQqcQ@mail.gmail.com>
References: <CAJZ5v0h=RmqSfW-F0YHsbDeg191ut4ZS7SN9dcCAFg_+EoQqcQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h=RmqSfW-F0YHsbDeg191ut4ZS7SN9dcCAFg_+EoQqcQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.12-rc6
X-PR-Tracked-Commit-Id: ac1790ad78f8f0cf9a588ffb530c700ad758e8b6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9314a0e9c711b0c092158ee9e0ed24d5ea25c90a
Message-Id: <161740348046.31502.1201731710233633815.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Apr 2021 22:44:40 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 2 Apr 2021 18:01:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.12-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9314a0e9c711b0c092158ee9e0ed24d5ea25c90a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
