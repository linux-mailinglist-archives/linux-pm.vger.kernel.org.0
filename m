Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91DAF1A48F5
	for <lists+linux-pm@lfdr.de>; Fri, 10 Apr 2020 19:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgDJRa2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Apr 2020 13:30:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726816AbgDJRa2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Apr 2020 13:30:28 -0400
Subject: Re: [GIT PULL] More power management updates for v5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586539828;
        bh=Doo0J0I0r8vmA+xBCBK4VzSd26D81j+LMv9WROysvl0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WrDNZA079jsUYMDmy27QdRFWrmiRmKFG5ztH9467IMPyjcRdT3cJNHz08qF9I13sN
         Iv/CZyguMYH6zQU+5T1qUU+4by0Cywm9XmNrehfbEufkeUT1BlzOD0xOozMapDIwx/
         A0mvtltvb4TLJ7SAasNuQCjCet6hvOrn7EI9OARc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jUWsonPL3NDdVhwQcpVpsPuA9EpOdPpDqF=5XEaPBOVw@mail.gmail.com>
References: <CAJZ5v0jUWsonPL3NDdVhwQcpVpsPuA9EpOdPpDqF=5XEaPBOVw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jUWsonPL3NDdVhwQcpVpsPuA9EpOdPpDqF=5XEaPBOVw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 pm-5.7-rc1-3
X-PR-Tracked-Commit-Id: a31434bcd4cb73b13cd8136c3cbba966dd01f058
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bbec2a2dc338a19185549c318356e25c65552d15
Message-Id: <158653982823.6431.6953161213468667754.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Apr 2020 17:30:28 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 10 Apr 2020 11:49:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.7-rc1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bbec2a2dc338a19185549c318356e25c65552d15

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
