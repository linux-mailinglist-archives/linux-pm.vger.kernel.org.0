Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91BA040FFDB
	for <lists+linux-pm@lfdr.de>; Fri, 17 Sep 2021 21:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343675AbhIQTa7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Sep 2021 15:30:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245689AbhIQTa7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 17 Sep 2021 15:30:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0120D6124B;
        Fri, 17 Sep 2021 19:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631906977;
        bh=GwFE+9qjCGi1CmQvLuy5DovLcixs7oVFVYehwO8OZpc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uOdP8yFD6tFlGSs7ppn85JnJg+GnZLij+TW68rwxuoPDu2OQZnft5iQsLT69y5JYc
         TicPm6oDx88RJiHvMfF1/+JhlEjwkKDOY/aHIb88hUXnt1MGU4Tzs2MmADxcOl97i4
         T9Rq6bnuR9FpaGu4Ld3dLu53eI59NKLhwBb5d8RN4qrzp6F9FAPXf3WtqNTlTF1idp
         huY2fgI/7cmZzpr8u9c8kUE8UKwb6IZdYmh7jlFIn1h/IC66n8MzX9py7jUJEV4rrn
         NOFNAG2y80tSd1JgCRWStq+MFaQ8p+vvQATDW3nzw8kWJRHpCPSzolAKibUrB4JItB
         glxlg1yElZ3kw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id EAAC760965;
        Fri, 17 Sep 2021 19:29:36 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v5.15-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jjPkRrtS0qG7vx=Od6MiOixC1UyxjcLeQzfpegGtu9fQ@mail.gmail.com>
References: <CAJZ5v0jjPkRrtS0qG7vx=Od6MiOixC1UyxjcLeQzfpegGtu9fQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jjPkRrtS0qG7vx=Od6MiOixC1UyxjcLeQzfpegGtu9fQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.15-rc2
X-PR-Tracked-Commit-Id: cdef1196608892b9a46caa5f2b64095a7f0be60c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4357f03d6611753936e4d52fc251b54a6afb1b54
Message-Id: <163190697695.17353.9027332896190045131.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Sep 2021 19:29:36 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 17 Sep 2021 20:21:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.15-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4357f03d6611753936e4d52fc251b54a6afb1b54

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
