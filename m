Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9402EFBD5
	for <lists+linux-pm@lfdr.de>; Sat,  9 Jan 2021 00:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbhAHXtm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Jan 2021 18:49:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:52630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbhAHXtm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 Jan 2021 18:49:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id CB07223A5A;
        Fri,  8 Jan 2021 23:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610149741;
        bh=lUF0snJfFbdzBHnkECYZ3+pMGgF1UnqnDB2UkbN8Pps=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=t7jxW0qEfGYPkeyNL6btiWqN6p0bGc0IYep5G1x34lZfrhzvnfH7R2x2LwchajYgD
         qPDnrX2X0BAQmV9c0GXP514clhnEnEXtlb6QHOFJTXyiu2gMdqB5OLX1P7pcqo5dNa
         j2Bo24xXFwtnITyLq7LNEWRbzPnX6kuJjS12Opylx39FLDLDEfmIT4fOR3EwK4ZV3V
         Fb1YInTUWvYTQ8Tx27t6htLc0wmay7egoHIsziE4Ygq9yo+wDHn8vlKO6phG+EfFu6
         6gcBx33lWnNoupQc4O8GztUzmQKuwEbP9ZRms6zr0esNPZP9LVK5UR590LqaXsmO9p
         plYUWmemzzKug==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id BB87460597;
        Fri,  8 Jan 2021 23:49:01 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v5.11-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iPXqB1zkrbORP+N-ZgLA_fSym7o1xbkBCt0=TTdu_hxg@mail.gmail.com>
References: <CAJZ5v0iPXqB1zkrbORP+N-ZgLA_fSym7o1xbkBCt0=TTdu_hxg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iPXqB1zkrbORP+N-ZgLA_fSym7o1xbkBCt0=TTdu_hxg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.11-rc3
X-PR-Tracked-Commit-Id: c4151604f0603d5700072183a05828ff87d764e4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: be31d940b3b62c57a5d9506090e66e177b7eba90
Message-Id: <161014974169.3246.17422230849464921252.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Jan 2021 23:49:01 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 8 Jan 2021 18:52:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.11-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/be31d940b3b62c57a5d9506090e66e177b7eba90

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
