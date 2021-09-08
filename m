Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7444041EE
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 01:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347272AbhIHXwF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 19:52:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347552AbhIHXwD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 19:52:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4C0BD61157;
        Wed,  8 Sep 2021 23:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631145053;
        bh=qD+iM4QHkdeHQWaQsxtHe8wyI6CgksNmEqEjdYBrXoY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=crsmI0Fgl4iiEscJiLoydUStIw2rZWLSvDiMzuo2ODNxLum3WkQMRybvn31WLQr6w
         3sEnRshPqSNrvwNg3FGDzec8RBLmb3U+c7t1IzfkFJsKVaEJHR/MR2eS66YA9vL/K7
         WWTNFVk5vsCPqhyxwZEfH1g+KkOHOXRt0hcQ0svx4SvgYh1jvAtu+useTq8rH5SwsE
         RaeGx2t6tNst4hKesKtYVjrNeMfwGoYs353Sfm7e3z0o62N/Q0UkY+V32bDMSMMvS9
         ULZFAGAAzsv3YLxApm5A795k9ZdDP8zwMpW7UpCSReRQGTwwMUL7mMxlVP/UgZGR4b
         fQv5BcpI/N4yQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4443B60A38;
        Wed,  8 Sep 2021 23:50:53 +0000 (UTC)
Subject: Re: [GIT PULL] More power management updates for v5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iscRcftKWp-mUo6ennD0iPP=dQsZ1uTueycuT5fxAF=w@mail.gmail.com>
References: <CAJZ5v0iscRcftKWp-mUo6ennD0iPP=dQsZ1uTueycuT5fxAF=w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iscRcftKWp-mUo6ennD0iPP=dQsZ1uTueycuT5fxAF=w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.15-rc1-2
X-PR-Tracked-Commit-Id: f76c87e8c33766cc6a7bf7461dfac9cebb05b5df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 30f349097897c115345beabeecc5e710b479ff1e
Message-Id: <163114505327.23960.1201572917997475010.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Sep 2021 23:50:53 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Wed, 8 Sep 2021 17:34:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.15-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/30f349097897c115345beabeecc5e710b479ff1e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
