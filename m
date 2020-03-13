Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 384B7185043
	for <lists+linux-pm@lfdr.de>; Fri, 13 Mar 2020 21:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbgCMUZK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Mar 2020 16:25:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbgCMUZI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 13 Mar 2020 16:25:08 -0400
Subject: Re: [GIT PULL] Power management fix for v5.6-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584131107;
        bh=25YpGDthvkqDKq8fdchPfoJFDDmdYXlIqN3Oz3tiHMU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EQ70V2Q6/n+byeA+Z8bTNpJopyqMiSyBLJrCbgAUXN5XRzyZB9B3uClt+mlEqKu5n
         ARm7md59LVYdcpYV2T0lUcXvv+YN1Dr1UiMnmFKKKdB8+Q9gplWbUAHR9cSdSqk6Ek
         1Pa6F+a1wzgWE6pTxitfvGaUedEw7CpSKQi83yyE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jcZsixVWpfb=OkWNPD8Q=DC-Q-gvEzLh7vkCksT3a0HA@mail.gmail.com>
References: <CAJZ5v0jcZsixVWpfb=OkWNPD8Q=DC-Q-gvEzLh7vkCksT3a0HA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jcZsixVWpfb=OkWNPD8Q=DC-Q-gvEzLh7vkCksT3a0HA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.6-rc6
X-PR-Tracked-Commit-Id: bce74b1feb01accc6654a1f3e37958478d3a4fbc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 78511edc2dd4c7b9f74f3b544093c854b7bd7744
Message-Id: <158413110780.9951.6005924479376345266.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Mar 2020 20:25:07 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 13 Mar 2020 18:57:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.6-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/78511edc2dd4c7b9f74f3b544093c854b7bd7744

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
