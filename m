Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18EAA2DF1BC
	for <lists+linux-pm@lfdr.de>; Sat, 19 Dec 2020 22:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgLSVHY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 19 Dec 2020 16:07:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:49560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727794AbgLSVHV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 19 Dec 2020 16:07:21 -0500
Subject: Re: [GIT PULL] power-supply changes for 5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608412001;
        bh=KvShiu93UVVXSjn6zg1RGi8gcBZBLIXK4RW96Y5SjNs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=adD0R6VokWWyuUJBv8e/oLGST58+gG1CqDnwrHtukFuX+385zMl+qPz+w2egL23K2
         KS5gPe9AKJj9F7OexG1rS950TaxNy1rZVQsKjIzVTM4IbxkKlwoDnipkZfDQzHEPLD
         /pu+Rk/mFSE9u5YFJ4FsNSqdVVlVg9B8VZwUoOwFldQM+lc3flrGhfpuFnTrIMH9gC
         K6Y8olkeAuTSHw5r+DeuXDaU5YX7bJfV28jN6Bq4PUiSSWqqqSERIVNJL2w+E0fbWh
         GdwF6ONF+uM8eaIPm3VtLK3LZOOdBLdlP1MN3VS035/Vr238ypeKWUor+AAV9zXlj0
         MFX7ZOMbpwR5g==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201218235914.cfmeap7y67hkbt4t@earth.universe>
References: <20201218235914.cfmeap7y67hkbt4t@earth.universe>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201218235914.cfmeap7y67hkbt4t@earth.universe>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.11
X-PR-Tracked-Commit-Id: c2362519a04a7307e386e43bc567780d0d7631c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 11c336526e2504d34c70fcf11a3642ae333a5085
Message-Id: <160841200114.20285.16552723380342070658.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Dec 2020 21:06:41 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Sat, 19 Dec 2020 00:59:14 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/11c336526e2504d34c70fcf11a3642ae333a5085

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
