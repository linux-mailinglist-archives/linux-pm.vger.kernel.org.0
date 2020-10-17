Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2A82913A0
	for <lists+linux-pm@lfdr.de>; Sat, 17 Oct 2020 20:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438858AbgJQSWn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Oct 2020 14:22:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438829AbgJQSWm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 17 Oct 2020 14:22:42 -0400
Subject: Re: [GIT PULL] thermal for v5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602958962;
        bh=eXo88rAbTjvaW4172sjXLBLN6eD4E7Ih2esVj6xi8/8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tqgjmq2EqP8dw68xDBYzTmnOncu3zmt3Iy3ka7QYfM+rmZ8jkQl1rX6jKnJZC4pCN
         uDiIskYpykurwjlw5NpgufBozFZbxhPz76y7J5yDqQFarqsDbLl8SIM/akuOsBsGdk
         d/NwPI7JCePfloFwAOd8sN41kBoFPrd7q0vy2hc8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ff1ca9b4-51fa-209a-b047-17dcc2e74720@linaro.org>
References: <ff1ca9b4-51fa-209a-b047-17dcc2e74720@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ff1ca9b4-51fa-209a-b047-17dcc2e74720@linaro.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git tags/thermal-v5.10-rc1
X-PR-Tracked-Commit-Id: 48b458591749d35c927351b4960b49e35af30fe6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a77b6a0131f7197e1a037f65fc7cbabcb4fe680
Message-Id: <160295896227.15185.3432103274876109620.pr-tracker-bot@kernel.org>
Date:   Sat, 17 Oct 2020 18:22:42 +0000
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Colin King <colin.king@canonical.com>,
        Anson Huang <anson.huang@nxp.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Qinglang Miao <miaoqinglang@huawei.com>,
        zhuguangqing@xiaomi.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Adam Ford <aford173@gmail.com>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 16 Oct 2020 10:47:01 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git tags/thermal-v5.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a77b6a0131f7197e1a037f65fc7cbabcb4fe680

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
