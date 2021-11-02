Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334684439AB
	for <lists+linux-pm@lfdr.de>; Wed,  3 Nov 2021 00:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhKBXaC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Nov 2021 19:30:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230054AbhKBXaB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 2 Nov 2021 19:30:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 503D4610C8;
        Tue,  2 Nov 2021 23:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635895646;
        bh=AZzvbICg6oX/qle33P5Mj8FEVwJ7uNj/Ar0srUdXO5M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WfxFTn2DstR0Rr6ZipgEU/hs7n9DdsX5R5Lzi7Z0K/W2kRhH1aitGp6Kbs9mhHq4p
         O7ktjAV0mEOo9Ib5yfxQWl+d6Sx5RoD6PzlGR9NMYrJkhk9G9g7itGWWDRBnqZrRT0
         wfbHond+qCioOkdgZkpO8Byo0uQAwRw+L+AZhkRdWAdU6a1FSO/925+F39zjTsXgSV
         VSbEQO3JFhgolUwOr8z5YPmBJTZVMpSiUgyLc13MZlFnxLDNDV3rQqRWbvlNbMvb6h
         gKPpm0sGOe7GnJMtAJZt05eZf+Y1PDcxIUv3V1xGFDbPwLdf9/Q1vOin+0TXchLVxa
         aT5pA2xMVv4hw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 48CF9609B9;
        Tue,  2 Nov 2021 23:27:26 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control updates for v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hnj0zCXsZy0=Ukud3U_cn054GULmHmpz7Qrpg_TkLLqA@mail.gmail.com>
References: <CAJZ5v0hnj0zCXsZy0=Ukud3U_cn054GULmHmpz7Qrpg_TkLLqA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hnj0zCXsZy0=Ukud3U_cn054GULmHmpz7Qrpg_TkLLqA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-5.16-rc1
X-PR-Tracked-Commit-Id: 46e9f92f31e67385fab8b49c030635415f36b362
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f73cd9c951a9dc23f0ee1260fef5cc61d2825fb3
Message-Id: <163589564629.24792.5376351556602801863.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Nov 2021 23:27:26 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Tue, 2 Nov 2021 20:54:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-5.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f73cd9c951a9dc23f0ee1260fef5cc61d2825fb3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
