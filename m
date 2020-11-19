Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26AA92B9B5E
	for <lists+linux-pm@lfdr.de>; Thu, 19 Nov 2020 20:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgKSTRw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Nov 2020 14:17:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:36554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727687AbgKSTRw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Nov 2020 14:17:52 -0500
Subject: Re: [GIT PULL] thermal fixes for v5.10-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605813471;
        bh=x2Ro2aifnVMAkjvIfVfwOvSLKlMRwHBJ77oomaGMbvk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=B5ks8KkBnEJf65g5+w7XGR1jWT55CNTfZegcC5LKZDoVGC2zRo1cpfUPbaoWOwiOe
         bJ7jQlgzdZW8h8w7SN1HuyItDdjSOWc9qWy4y/knXHHGBVohxhTrbNyMq6R1YpjtQH
         qVjN7uOUug9p/gMfetY1x/+qVH03IEQr9jt7HyKM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <e1bcd711-a3bf-58aa-7efd-053fa0fe5514@linaro.org>
References: <e1bcd711-a3bf-58aa-7efd-053fa0fe5514@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <e1bcd711-a3bf-58aa-7efd-053fa0fe5514@linaro.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git tags/thermal-v5.10-rc5
X-PR-Tracked-Commit-Id: b98467fe96d2415836d154ecfe1cd389bf4147b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 841d6e9ec9e345054dd4a28ef5feceb73e9702be
Message-Id: <160581347193.16071.2364006405758432404.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Nov 2020 19:17:51 +0000
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Thu, 19 Nov 2020 12:00:32 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git tags/thermal-v5.10-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/841d6e9ec9e345054dd4a28ef5feceb73e9702be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
