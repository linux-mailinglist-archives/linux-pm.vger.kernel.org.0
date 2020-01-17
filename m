Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C45CC1400AB
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 01:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729970AbgAQAPD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 19:15:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:46186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729035AbgAQAPD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Jan 2020 19:15:03 -0500
Subject: Re: [GIT PULL] Power management fix for v5.5-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579220103;
        bh=/Nf7aJXa3GwThCWZyVTp2VBTKK/8b6VaWQ7kc+Qm7/0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BqHo9My/u6Ti1Y2cD56B/LtHmsmQLaT9ptu8/HPxIADVXICgneNoqcDHeRHSkt9J7
         +nhObp+59pclVP30D2yUH/AxQ3kZgreFlT7pGDkmNWBwMejweHkscUNj7k70tVvc2k
         zhkGty5/URlyUtCdl7VvvIybKkqacplB0fIM1pKQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gx+Om02PH6t74R0d2F_sPZwncOSMWrhA0Yx77=xdpCyA@mail.gmail.com>
References: <CAJZ5v0gx+Om02PH6t74R0d2F_sPZwncOSMWrhA0Yx77=xdpCyA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gx+Om02PH6t74R0d2F_sPZwncOSMWrhA0Yx77=xdpCyA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.5-rc7
X-PR-Tracked-Commit-Id: 57388a2ccb6c2f554fee39772886c69b796dde53
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f4353c3e2aaf7f7d3c5a18271b368bf5292854c3
Message-Id: <157922010307.2781.12024388427354699409.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jan 2020 00:15:03 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 17 Jan 2020 00:18:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.5-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f4353c3e2aaf7f7d3c5a18271b368bf5292854c3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
