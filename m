Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5688312674B
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 17:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfLSQkL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 11:40:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:46922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbfLSQkL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Dec 2019 11:40:11 -0500
Subject: Re: [GIT PULL] Power management fix for v5.5-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576773610;
        bh=kVZO1y7O7/FeMWl1i0VTlzIBrjOvi3NOrNm0YAIByyk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kprPBqkGFsL/3lQQGPTSf25JKXQ8jud2aVvzaTdAJUDNIN4gvnupJAhCXVxxIs7aB
         /GW+DIpi5U/j9c+BLztfbZeP1ZSyMcTyWxkOS8EJ0RAoQ0p0qo6SMPPux5AiIBHCz1
         xMIhz2yYgcSR7LkUK6TFFq1EP5wZvqwSrODwTN4o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hm1D5CJq81Ew9YjGc_ik8nw9Q_-w0a+7iMdarwPmsH7A@mail.gmail.com>
References: <CAJZ5v0hm1D5CJq81Ew9YjGc_ik8nw9Q_-w0a+7iMdarwPmsH7A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hm1D5CJq81Ew9YjGc_ik8nw9Q_-w0a+7iMdarwPmsH7A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.5-rc3
X-PR-Tracked-Commit-Id: 505b308b6944a91fa8437a3fd9f2dab29b5c3c88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5f096c0ecd53263a94124bdfa516a29f154e44ed
Message-Id: <157677361077.29970.17745239851738773392.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Dec 2019 16:40:10 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Thu, 19 Dec 2019 16:35:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.5-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5f096c0ecd53263a94124bdfa516a29f154e44ed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
