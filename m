Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4FE424E2F7
	for <lists+linux-pm@lfdr.de>; Sat, 22 Aug 2020 00:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgHUWF4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Aug 2020 18:05:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbgHUWF4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 21 Aug 2020 18:05:56 -0400
Subject: Re: [GIT PULL] Power management fixes for v5.9-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598047555;
        bh=Lqma919Md26IrNr6f7LG6sMH3gMSsaaWA9Z/R390lSg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MW9+0sed0vuZrYqXHwrUei6aeP1k64POqOYTKH8zPvb7Jx2EP/z3gA8VmDyXDFrbJ
         TvJUh4lLSIRfFUiDogtZVzWUlePhccy3NG1Z/fqj9s3yRmpZe/D6vCkbWwZnJJDlVZ
         lTXGaUFyJMQV95kPVsJXV2ByqJ2xVemfvrYGEgFk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hVw_1b_hf7UWv06ipusZ=xs-0Lhi-a0npqU8Uua26FPQ@mail.gmail.com>
References: <CAJZ5v0hVw_1b_hf7UWv06ipusZ=xs-0Lhi-a0npqU8Uua26FPQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hVw_1b_hf7UWv06ipusZ=xs-0Lhi-a0npqU8Uua26FPQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.9-rc2
X-PR-Tracked-Commit-Id: cc15fd9892e28689b6e17dbd6e28d00c55d62928
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 985c788b6da44dc21b401ce8ce3c2db023ef79e4
Message-Id: <159804755587.4316.7754222427566232989.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Aug 2020 22:05:55 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 21 Aug 2020 20:12:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.9-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/985c788b6da44dc21b401ce8ce3c2db023ef79e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
