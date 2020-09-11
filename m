Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAF42669B6
	for <lists+linux-pm@lfdr.de>; Fri, 11 Sep 2020 22:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgIKUpQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Sep 2020 16:45:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgIKUpM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 11 Sep 2020 16:45:12 -0400
Subject: Re: [GIT PULL] Power management updates for v5.9-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599857110;
        bh=sV1g0/kheXpgNgXoYVm6YvBKiGhQ3kqSQy6mGYnCjxw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=m752AGpDNgSdWWc4txVUGbRlCPTT58S/mZGNrr1TgTCAAi7q/KauYgsrAhcZ/sKdq
         s9Wws3O0hQAW3nAXh3HimKEHoE70kiFVAiudR55WUQRixBudgMsQVLCjvB73IYohr9
         upwA2IhibEjNODvMjv+IpfSiGK5wbkO9kmwkZO4w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jYBQ792GmDYMYOzxbmJC7HYzZFfQ4JR8LxDR=0goQ1_Q@mail.gmail.com>
References: <CAJZ5v0jYBQ792GmDYMYOzxbmJC7HYzZFfQ4JR8LxDR=0goQ1_Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jYBQ792GmDYMYOzxbmJC7HYzZFfQ4JR8LxDR=0goQ1_Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.9-rc5
X-PR-Tracked-Commit-Id: d64e6906d188f0ba6a4f82b3f42e0bd0598183fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 566e24eeb498a5352cd79dc03788401bac9212c6
Message-Id: <159985711035.5364.8507497417420272187.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Sep 2020 20:45:10 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 11 Sep 2020 17:13:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.9-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/566e24eeb498a5352cd79dc03788401bac9212c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
