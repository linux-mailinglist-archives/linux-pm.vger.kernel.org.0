Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35BE3445B77
	for <lists+linux-pm@lfdr.de>; Thu,  4 Nov 2021 22:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbhKDVFn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Nov 2021 17:05:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232310AbhKDVFm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 Nov 2021 17:05:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 53C7661106;
        Thu,  4 Nov 2021 21:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636059784;
        bh=Omr6diHzMQRwB9Wk20h/U0FXQ5PJgcUSGlECIuUsaYg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nE69weyCc3Fcmgb20c+gHLdVB5qxYWataMW6HCOuOarSKJl9H9YPs4gZZfAwf4IWi
         Mr8maVorMG8Sc+mogcxHbW9Ra4paFabY1e1kHoPX+oCnYrRqF8I4Ub99TpVUvOuWpD
         ppcjBe9u1WPDrZPmj73uJUar8XSowRjeYFzUFkmAmxxzVD940hDeL/+pBzjCJMBZAs
         A3XYplaDnu9nWx+zRrCr1JWIbdHcs2XIMOSweit/Qjc5IGdBNFYX4e9fGJ2C4JQGW7
         C8zcDVKNK1WJLUNfmbtCbucliwdP1nx6JmK2sCQBgaaDRGNJsugFhuOwM5mJ8/88ms
         vsGq1Msc+iaLw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3EFCE60173;
        Thu,  4 Nov 2021 21:03:04 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211104182918.nqvaukg6y6qq6mbp@earth.universe>
References: <20211104182918.nqvaukg6y6qq6mbp@earth.universe>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211104182918.nqvaukg6y6qq6mbp@earth.universe>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.16
X-PR-Tracked-Commit-Id: 22ad4f99f63fc892412cde5a45d43b2288a60b88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 72e65f7e525fe1ed399c0c5f4adda562602d025a
Message-Id: <163605978419.14865.13002408388854976718.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Nov 2021 21:03:04 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Thu, 4 Nov 2021 19:29:18 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/72e65f7e525fe1ed399c0c5f4adda562602d025a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
