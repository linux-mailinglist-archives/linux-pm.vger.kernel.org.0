Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E92A2B9B63
	for <lists+linux-pm@lfdr.de>; Thu, 19 Nov 2020 20:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgKSTR4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Nov 2020 14:17:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:36614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728214AbgKSTRz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Nov 2020 14:17:55 -0500
Subject: Re: [GIT PULL] Power management fixes for v5.10-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605813472;
        bh=ejxItLtjAUsfwaXAd8x+kBdH3zC/gENtYyELlUJYpZQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mGW8g3vhUqdsF6k6JzBV7Ywe3PdVgebarvnSpKZLCE7AZxLbc7ppQKesKBDzXpnXr
         UdNwpsNKECkCEx7sB8ERveSiu73GJmhr8TMhWI5cFG4a8cZKUhHemKxBJx92Qaa7E/
         19HYvey0csIIJ5h8oNbaG6cD1+yfU1EKZNht5xE8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jBUToP9sxeuhw_AVwoPNc8RwJD_31WoCLSOiXH6Dcy8A@mail.gmail.com>
References: <CAJZ5v0jBUToP9sxeuhw_AVwoPNc8RwJD_31WoCLSOiXH6Dcy8A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jBUToP9sxeuhw_AVwoPNc8RwJD_31WoCLSOiXH6Dcy8A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.10-rc5
X-PR-Tracked-Commit-Id: 3a8ac4d39651c71d6d2f3376b13d0bad1484249a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ca35b4f45092634df21dada47746571a34cc09c
Message-Id: <160581347268.16071.9742795392696011236.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Nov 2020 19:17:52 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Thu, 19 Nov 2020 19:27:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.10-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ca35b4f45092634df21dada47746571a34cc09c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
