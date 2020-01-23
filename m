Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEAF1471C4
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2020 20:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgAWTaK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jan 2020 14:30:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:39542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728731AbgAWTaE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Jan 2020 14:30:04 -0500
Subject: Re: [GIT PULL] Power management fix for v5.5-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579807804;
        bh=xu83yQGo2Fgf0V06kPl1ib0ub6ap7wozrd+fmj0dwnQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mOaJ9Oj8wMsD4ztLcp4tCLe5AIfoQO8pY9w2lEkV23B7FasfByAf1YGnKB/r0oPxp
         q/r8GLL2OwYqWvhG40gMaELabUCymv/nMV2JDdz0Bbi+BeHdcfyPtBP8kjUyAIzr3o
         0MCCI8w8icndJZawK1lvNu9wwAdds85yXbDLSvTY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0g1n2ncCOe-y5dOHS3pGDLQ9e92Z761S86XV8GPKkG4iA@mail.gmail.com>
References: <CAJZ5v0g1n2ncCOe-y5dOHS3pGDLQ9e92Z761S86XV8GPKkG4iA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0g1n2ncCOe-y5dOHS3pGDLQ9e92Z761S86XV8GPKkG4iA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.5-rc8
X-PR-Tracked-Commit-Id: 18451f9f9e5810b8bd1245c5ae166f257e0e2b9d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a83c8c81c91fe10e7002c2c0e74b23e80f41f28
Message-Id: <157980780423.24133.7675563886623809686.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Jan 2020 19:30:04 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Thu, 23 Jan 2020 15:55:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.5-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a83c8c81c91fe10e7002c2c0e74b23e80f41f28

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
