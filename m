Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5BE1381A0
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2020 15:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbgAKOpG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 Jan 2020 09:45:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:36036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729824AbgAKOpG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 11 Jan 2020 09:45:06 -0500
Subject: Re: [GIT PULL] thermal fixes for v5.5-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578753905;
        bh=/qK54LK2kczwRX0gyZHJOnOCp5kozbzusUO7ViGSjQg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NiDSGvY8ub5N1z2KbSZT+TsIQ8YGnEO64Owqmcga1f9qQ7tiA50qjEOYukF8C9poy
         QWcL4hFFNCsuDRnES3emIfcjKug+uQpn4ixLCob+tAynwpgDHhSTnNXJ3oykgaGlgI
         oUttrVWPQEXBkD07wr6gceFYW6dCziz0FnDk3Djc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <dae56d94-114b-18b3-92dd-0c390b0cbe86@linaro.org>
References: <dae56d94-114b-18b3-92dd-0c390b0cbe86@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <dae56d94-114b-18b3-92dd-0c390b0cbe86@linaro.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
 tags/thermal-v5.5-rc5
X-PR-Tracked-Commit-Id: 344fa0bad6932204146d305607790340f2324a90
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 658e1af5eec6d51f95fa81e61f67d2fe1c6376aa
Message-Id: <157875390552.30634.4580926022712227530.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Jan 2020 14:45:05 +0000
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 10 Jan 2020 11:31:20 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git tags/thermal-v5.5-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/658e1af5eec6d51f95fa81e61f67d2fe1c6376aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
