Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9F233994C
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 22:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbhCLVwg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 16:52:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:48216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235357AbhCLVwd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 12 Mar 2021 16:52:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 3444864F4C;
        Fri, 12 Mar 2021 21:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615585953;
        bh=Z95UERGTRC6EFJo/x/dyX8g2BVVA9c599UJcbt4g4yQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rMI/9iHuEsGUAo2r2WDHN2BnXNt/Ef9hFr8kFD2kL8Xteva+mRrxfE4Xfz/ScVXhH
         z20syaFthRNXIA+nzodaYbo5hvnsdL6XnuxXJQkStxE1y4PmOi3mjQiQ5Mbr47Rn5a
         YSwh/igT4kyWgPZf5ExtcylzYEPhtMqP/+8I5ZHuRb/EJ4nTn21wzmznH8Q8vAJMrp
         EhNhRAvyHyPyZX2De+UrjryUM50bKyU8y2MI12UbysH2hkaa5UjxM/olzEDMAFBmnA
         fJeOLNF58SCpr1t3oBfwFQ/l9EnouRYJwTNYdpaDG5Sl9h/7PPolJZITz3RizEUaDC
         FRWue06qXRkLg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2D160609CC;
        Fri, 12 Mar 2021 21:52:33 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v5.12-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jzkMkavZVnwQzjRmu9gg-ReicViPG4QU+Lh4Yp0sVohg@mail.gmail.com>
References: <CAJZ5v0jzkMkavZVnwQzjRmu9gg-ReicViPG4QU+Lh4Yp0sVohg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jzkMkavZVnwQzjRmu9gg-ReicViPG4QU+Lh4Yp0sVohg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.12-rc3
X-PR-Tracked-Commit-Id: 7180323227702b46677e51d0da71f452615efd8c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3077f0279effe1422410dafdf3c14d5756f1239a
Message-Id: <161558595317.23578.2101843489991148688.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Mar 2021 21:52:33 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 12 Mar 2021 19:20:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.12-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3077f0279effe1422410dafdf3c14d5756f1239a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
