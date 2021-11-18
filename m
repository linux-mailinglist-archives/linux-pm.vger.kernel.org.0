Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DED04565ED
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 23:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbhKRW7R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Nov 2021 17:59:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:42526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231526AbhKRW7R (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 18 Nov 2021 17:59:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 7573061A79;
        Thu, 18 Nov 2021 22:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637276176;
        bh=mbFWc2bahPfk1gApTJ9Jw4y7Aym/1FPAUvv2WnmpCtY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mt524ZUzd1S5Sl9tsrTr2/6u51tHGyNNQsoV4JQJPPS14/vUlnIGTnhqtm96zPibr
         SmPrdpZUuAXgrrAokGH2ibj6cbTwPmWOOtbzzgJ9+tDvjTvVSiIOA2Se2Jkh/8/Kfh
         NhyHAq2MY75HT0hNP1KoLhYO/o4khtOUHvGy408oKjWOle66XbpQbkictjxPXvo/Vr
         SzBqQ9jsebFnZ/HR+ZHL1zY5zZLL1qUcTY3hLv3Oe0B2xXWrmE9UdY7PORVWpltlWy
         yl74NA8ijjug02p1BiMszdC4nhHVuO8FCmsfWVb4ATx0Q+uRLCewujyt3WVSJHVBu9
         qHj1eMU/lsQ6A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6FB44609CD;
        Thu, 18 Nov 2021 22:56:16 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v5.16-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hWGX0txDBHfUMX=hgynrsyhp0T8NX-rY8YXdPbdZPKtA@mail.gmail.com>
References: <CAJZ5v0hWGX0txDBHfUMX=hgynrsyhp0T8NX-rY8YXdPbdZPKtA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hWGX0txDBHfUMX=hgynrsyhp0T8NX-rY8YXdPbdZPKtA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.16-rc2
X-PR-Tracked-Commit-Id: 47b577ae6fba635de1e5e042d425ebd0f9313111
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 18e2befaf6c2a2b877a8842f8caa7bce54d9b59b
Message-Id: <163727617645.9679.17852914733510650360.pr-tracker-bot@kernel.org>
Date:   Thu, 18 Nov 2021 22:56:16 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Thu, 18 Nov 2021 21:14:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.16-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/18e2befaf6c2a2b877a8842f8caa7bce54d9b59b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
