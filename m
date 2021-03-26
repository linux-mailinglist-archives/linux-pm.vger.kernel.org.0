Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0075634AEBE
	for <lists+linux-pm@lfdr.de>; Fri, 26 Mar 2021 19:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhCZSsj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Mar 2021 14:48:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229957AbhCZSsY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Mar 2021 14:48:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4310461A24;
        Fri, 26 Mar 2021 18:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616784504;
        bh=9Rjs9BIZ1c34Pxur4Rh0i4SU5rK9709/+KBf6qkBEbo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bDDLa0fYADbgaNZojokVFAf6AyN+EMMgxpHjBjB3CNShtvzdGOiDhTuHQxcbJ3ASC
         pJWmiiFYQExUqkD7j+hcQAvGNPGdNHByLJELQmZua3Gm0bP7HBCJHaYv3M84HXDaMN
         pUN2KlB+jkKcAVdMOoF/Y2Z6S56SvqwFnypls7DtFeDylkP1L6MBk83+YqyQW+48en
         Fv6a16OTdiaRf3VaY/Cs9We3iWYqet95ndt1MtdhTcJthe08jf8Mj54l/VMG5nlwXF
         nrLYcbZKnb22CTRYMPlk3iFBUzJD65h6CyaYWMFTh13WjoALQyLMc+DQH5NrncsbC9
         omve7knrY0Eww==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1639060952;
        Fri, 26 Mar 2021 18:48:24 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v5.12-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j0Xx7_bYwCn3TL53j8ANKKFerhw_mT91=vYsGcDjS=_Q@mail.gmail.com>
References: <CAJZ5v0j0Xx7_bYwCn3TL53j8ANKKFerhw_mT91=vYsGcDjS=_Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j0Xx7_bYwCn3TL53j8ANKKFerhw_mT91=vYsGcDjS=_Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.12-rc5
X-PR-Tracked-Commit-Id: 6f3a283c2f6bbbb5a9a6801a0befa61cb60195f1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a3cbdda181024f9ee7200504e748d2e91adad1a
Message-Id: <161678450403.8437.18215071901440570536.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Mar 2021 18:48:24 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 26 Mar 2021 17:30:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.12-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a3cbdda181024f9ee7200504e748d2e91adad1a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
