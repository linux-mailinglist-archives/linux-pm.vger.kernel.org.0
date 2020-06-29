Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F7B20E1DB
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jun 2020 23:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390086AbgF2VAO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 17:00:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731225AbgF2VAN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Jun 2020 17:00:13 -0400
Subject: Re: [GIT PULL] thermal fixes for v5.8-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593464413;
        bh=OPQI9bTtFwn3NAYXqCtC8OZYAmmTN/PSS9eYiGGqp/4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FEvcKNpbTd3C8/18x8GaKDs05fxi3AFOvywjbEZi0hGPiQeaJ+KORnOMLr/gF7CQC
         LtTbg6/R85URmqHvqKODZZUkxW5jP9Jz7WqfBhqKJbNBFacqW2Bd4kc2JmP7IfsfFc
         RgOJtfkS8P/aXx2dClYCg9NRIiCKtMqctW8tB3zA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <55cb7814-8305-23bd-873c-5a82104b1248@linaro.org>
References: <55cb7814-8305-23bd-873c-5a82104b1248@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <55cb7814-8305-23bd-873c-5a82104b1248@linaro.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
 tags/thermal-v5.8-rc4
X-PR-Tracked-Commit-Id: 5f8f06425a0dcdad7bedbb77e67f5c65ab4dacfc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: be88fef34f784a8d612366e7ebb149785de7f928
Message-Id: <159346441299.11856.7816524140098619658.pr-tracker-bot@kernel.org>
Date:   Mon, 29 Jun 2020 21:00:12 +0000
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Anson Huang <anson.huang@nxp.com>, dien.pham.ry@renesas.com,
        Finley Xiao <finley.xiao@rock-chips.com>,
        "michael.kao" <Michael.Kao@mediatek.com>, yangtiezhu@loongson.cn,
        Zhang Rui <rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Mon, 29 Jun 2020 12:31:32 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git tags/thermal-v5.8-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/be88fef34f784a8d612366e7ebb149785de7f928

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
