Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95B2711774D
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 21:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfLIUU0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 15:20:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:36020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbfLIUU0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Dec 2019 15:20:26 -0500
Subject: Re: [GIT PULL] Thermal management updates for v5.5-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575922825;
        bh=R+HJtlDi28oVqztaFS/7tgnt/ODcDIx25ZAkKNGiTJM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ApBd5r2k40UczLle4G9MGxiT+lCgrY2Z2+2KpmlHlReUDaY/nH24cmwWWI4/9zM9w
         AyUKqiteJN8JDTKAOh3yNO5MxMQIMWj91NKVrirQ5aLQw44szD8sL0hBmq3D7BH235
         EztQ9YoolJxjDAUF/5PqQ2V00jATphLmcMhtfHjI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <38cbdb4739a56d25f13ef5afa7c6686d2baf74c4.camel@intel.com>
References: <38cbdb4739a56d25f13ef5afa7c6686d2baf74c4.camel@intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <38cbdb4739a56d25f13ef5afa7c6686d2baf74c4.camel@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
 tags/thermal-5.5-rc2
X-PR-Tracked-Commit-Id: 6e456dca47c5e3b8d8c6bbc4edd1377985d793b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 316eaf170252f3b50e0d7d5d17ac1f0ee8ae70ef
Message-Id: <157592282581.794.1452620589164632828.pr-tracker-bot@kernel.org>
Date:   Mon, 09 Dec 2019 20:20:25 +0000
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Mon, 09 Dec 2019 14:18:21 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git tags/thermal-5.5-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/316eaf170252f3b50e0d7d5d17ac1f0ee8ae70ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
