Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A35714C40D
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2020 01:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgA2AfI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Jan 2020 19:35:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:56916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728363AbgA2AfF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 28 Jan 2020 19:35:05 -0500
Subject: Re: [GIT PULL] Thermal for v5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580258105;
        bh=DzmX5EuthMgnn/vw++nrliqEikrreBcsDg6sQ2pof0U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ob0s0l8iVfyMa2LJL1JpgRtF8XSYvuBBCMCGSzZuYA+s9+ZrDINmyvfv1EtBkFeoQ
         +GFhWfJgy7R7PAyPa33DinnaFSZlZerKBdtUsz/5LdmRkkdbRpu6nvqQWRzE+92ZMH
         /BEpa/c+x+JBZA3lTjzNpFfU/LsIf6FIQU+A3hLY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <288933ba-a1fd-5954-df09-edaa4ea24abc@linaro.org>
References: <288933ba-a1fd-5954-df09-edaa4ea24abc@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <288933ba-a1fd-5954-df09-edaa4ea24abc@linaro.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
 tags/thermal-v5.6-rc1
X-PR-Tracked-Commit-Id: 2f23e319b133c7392493e77f515a237c8e1e6dd6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: abb22e44cff3f11d9e087bdd46c04bb32ff57678
Message-Id: <158025810536.31502.2409530854539231665.pr-tracker-bot@kernel.org>
Date:   Wed, 29 Jan 2020 00:35:05 +0000
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Tue, 28 Jan 2020 11:13:51 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git tags/thermal-v5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/abb22e44cff3f11d9e087bdd46c04bb32ff57678

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
