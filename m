Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A6344CA3A
	for <lists+linux-pm@lfdr.de>; Wed, 10 Nov 2021 21:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbhKJUNE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Nov 2021 15:13:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:51062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232782AbhKJUM6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Nov 2021 15:12:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id E8B3961241;
        Wed, 10 Nov 2021 20:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636575010;
        bh=JBsVdWu67szCI+PPwUl6v9Mda9quGEr+llaesg/Aa7M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PZ5NFjNjVp+h8T0jbJX1H3Xpks4V0APGnr2kW0jZEompcY5n7oxk16mjTI28Z2d8a
         dFp8Fn9/czeRgsJVUcOWYdBzfSjPK3k6S1BxX/iM6isoH4/Ns26OTqUlcXygrq1EX2
         3DcnJh1ux2O560cTL/wifnzRJZSQ1njGHYjNu6qhssWW+RsjX7LmO/gtLhLiGNpXyi
         QhVYitOvrP6Nimh1VHjtQB4iYQH72Vxj7Lxb6U1V6VHYXwKlPCtG6sXHdEyzE42CUh
         A+x92o/hJhbiJ5/wbV5zjXjOzI3QRe4n6rfi+3y5qlQtJuFIHq76eDNtCH8dvyxDzh
         JSQj2WcTAr2sA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E22096008E;
        Wed, 10 Nov 2021 20:10:10 +0000 (UTC)
Subject: Re: [GIT PULL] More thermal control updates for v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0is9Prsk4OyqZAZaUvg0WJJfLxiU+GG9vckOdCD7Mfsvg@mail.gmail.com>
References: <CAJZ5v0is9Prsk4OyqZAZaUvg0WJJfLxiU+GG9vckOdCD7Mfsvg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0is9Prsk4OyqZAZaUvg0WJJfLxiU+GG9vckOdCD7Mfsvg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-5.16-rc1-2
X-PR-Tracked-Commit-Id: 61988e0a624400fe79f124914ecc4b19a8803f7f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 881007522c8fcc3785c75432dbb149ca1b78e106
Message-Id: <163657501092.19350.16888556658242355257.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Nov 2021 20:10:10 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Wed, 10 Nov 2021 15:33:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-5.16-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/881007522c8fcc3785c75432dbb149ca1b78e106

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
