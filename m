Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4583FA051
	for <lists+linux-pm@lfdr.de>; Fri, 27 Aug 2021 22:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbhH0UL4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Aug 2021 16:11:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231391AbhH0UL4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 27 Aug 2021 16:11:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 02C6E608FB;
        Fri, 27 Aug 2021 20:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630095067;
        bh=MCNCRWO8Iyar+jWlhrg/7lCu19XJQtakFIJroKILm64=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kcqGe3+sMNxjcOa26F/RsXa6e5LGAaWMrWK/WDrIUInzy49b5Dnufc4gtfoXWZwqA
         ixu9kDNzjZiLOvvyQk/Q4xPDhlVr/eZZtKafFoXoTZ56bCn+unVT2xsC13hx9GoLOn
         FG8bZ1vfZb2evXItjrqnS6ekP13qyPd24ljUzqbnvamjNyIr0M4PaIUWXUUKkc2dwh
         JivfvINKwV8RF48drs2CFrFCejPAQH4HK1gh55qBTQnpg+/jg3qLMIMYrhodnltfu9
         PAjR+si78bTk2vvYWrFC2s69BL68sm86HsAuHrtoQ5IIU668PaqqIbHvN+MMYETjlB
         nEpZz4cjenbLg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id EFF8C609D2;
        Fri, 27 Aug 2021 20:11:06 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v5.14-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i0a-mYqok8qQfQjpG-zPti=smyZR9HKxFAcQQY6VNrJw@mail.gmail.com>
References: <CAJZ5v0i0a-mYqok8qQfQjpG-zPti=smyZR9HKxFAcQQY6VNrJw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i0a-mYqok8qQfQjpG-zPti=smyZR9HKxFAcQQY6VNrJw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.14-rc8
X-PR-Tracked-Commit-Id: 7ee5fd12e8cac91bdec6de8417b030ed05d5d7ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0006dc6957ef0b5d3e785556f30f928af05ab0c
Message-Id: <163009506697.27622.4711267495705264241.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Aug 2021 20:11:06 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 27 Aug 2021 20:54:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.14-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0006dc6957ef0b5d3e785556f30f928af05ab0c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
