Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74A737FE50
	for <lists+linux-pm@lfdr.de>; Thu, 13 May 2021 21:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhEMTiy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 May 2021 15:38:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231703AbhEMTix (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 May 2021 15:38:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7530761358;
        Thu, 13 May 2021 19:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620934663;
        bh=pqcUo8aQbYNJQ+VEYFI/0Y5/h/slKbqRIA9K9FquecQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=s4s2LhLONbFNJyxWTkbk/DaJ/BQ0hUZ+VH/c36KUSZceRlpt6MOxtAIrPL3GKI2w5
         1unpvqc4sQJAIkx11c8HsxZB3b0jfLs8QEYhIdJhE5Ou9ARWbMo8HzfX068MotClui
         bD1GdLgFz5MEGWEMlWe3xjUICcyJRG8HWmleFy26D5YLKvSum10oqGPUCoBSsd3xl+
         STvM8kqrHo5dL7CBUizlJmVrb4wpjV4FSf0IN4GIdo9pophKl6RxE2gr+HoBycp/CL
         Ol4G7CVgCPhu9LYA5+4ty1qAo0jcrWgafj9BzsBHOzzsP1cGn7FkGd8BUM9qQLB/Wh
         QSP67Lose8UmA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6DA6D60076;
        Thu, 13 May 2021 19:37:43 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v5.13-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i+NXd-toRCSsv89zTNq3+T7v6CCy2D8Y2qE=5wMMP4dA@mail.gmail.com>
References: <CAJZ5v0i+NXd-toRCSsv89zTNq3+T7v6CCy2D8Y2qE=5wMMP4dA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i+NXd-toRCSsv89zTNq3+T7v6CCy2D8Y2qE=5wMMP4dA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.13-rc2
X-PR-Tracked-Commit-Id: 78a6948bbadd0da46d318f3b7a954a71e02c39f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 315d99318179b9cd5077ccc9f7f26a164c9fa998
Message-Id: <162093466344.18883.10008596129431832890.pr-tracker-bot@kernel.org>
Date:   Thu, 13 May 2021 19:37:43 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Thu, 13 May 2021 21:08:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.13-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/315d99318179b9cd5077ccc9f7f26a164c9fa998

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
