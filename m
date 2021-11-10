Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4AB44CA3B
	for <lists+linux-pm@lfdr.de>; Wed, 10 Nov 2021 21:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhKJUNE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Nov 2021 15:13:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:51048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232774AbhKJUM6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Nov 2021 15:12:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id BFB9B61211;
        Wed, 10 Nov 2021 20:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636575010;
        bh=SXyg7VyIO4mAt281eKVyqcXDH1m5GeZjzBa8FrGIl24=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ppB3yNKpHdmH8RPSAgtB8IV+QT0IyugSkv9wUOFXvfF3D41hw9TFde9yUr0/wCBT5
         yUEnF6TWqXbsp/w3YZFJOUE9+bBXcbq1+pJ78gay07HRpi5aKKVZ3PFVA+jHc7jExf
         kQW2/yjZWEzEHIjuCTa1UYaYn5181oz6sZqUH9H6Y0rT7sW8WcJtO1l9sr+HTIZkvN
         deNb2xny23cAKfbGgKN/SeCEzRnGVno/EvMRGGI7nwXYYXWiOuMYsu94SyWObxD4RN
         7z8z06Z7nfxmo6YG1Ig8PSZ9dP74zjTDZrPJmo+oAt1Id7PsqmPQ3pEOJT4m4CBJ5H
         ZkzMnownj5iTQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B9B2B6008E;
        Wed, 10 Nov 2021 20:10:10 +0000 (UTC)
Subject: Re: [GIT PULL] More power management updates for v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jfXr+6YaQpeAeEN11R47BdvjiM1_JsWfrCSLNpVpt1pw@mail.gmail.com>
References: <CAJZ5v0jfXr+6YaQpeAeEN11R47BdvjiM1_JsWfrCSLNpVpt1pw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jfXr+6YaQpeAeEN11R47BdvjiM1_JsWfrCSLNpVpt1pw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.16-rc1-2
X-PR-Tracked-Commit-Id: dcc0b6f2e63ac3bdcea5c9686de4cb1684f2eb33
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d422555f323c0069dc1cd29dc7b7a1547b6b0f60
Message-Id: <163657501075.19350.8144820458357181191.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Nov 2021 20:10:10 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Wed, 10 Nov 2021 15:31:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.16-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d422555f323c0069dc1cd29dc7b7a1547b6b0f60

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
