Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66AA34079E4
	for <lists+linux-pm@lfdr.de>; Sat, 11 Sep 2021 19:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbhIKRb3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 Sep 2021 13:31:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233533AbhIKRb2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 11 Sep 2021 13:31:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C5F6B60FED;
        Sat, 11 Sep 2021 17:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631381415;
        bh=zkagVS1fIb3TcsvE3jD4VrQNP2cCo/HDPjRFDFr4hUA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jT1WCmtqlqttFAOf3xauTdDgi/MWTLy0nxTAMpUG5rmsy4vLNoMtFNZrU11D3gemY
         +m+iQ1lHp0mIj+lIdhZFy188lHh5K0QitB6B7FUFgbL4xsQlnDnyC+BikBzIAi0s29
         copPHn0yau12z9YwwbualiuZdWM7gK0556lWko/qKW4Qi174B1FdJ1B1kH5eiwRodU
         J9IMfmg6luqvHU9N1pJuz5Jrp891XbeGZH4m3s+I2WnSqyQmEph+Sa9wXKKs5A06nM
         oaUlUDbBxIfmYhS4a9ol3e5/VeL6pz/f5lOayueuF0P7TS0LfZp6o/0waH1SAQiWp/
         9/TcuqYVm1bMw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BE9C5600E8;
        Sat, 11 Sep 2021 17:30:15 +0000 (UTC)
Subject: Re: [GIT PULL] thermal for v5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1fc67de6-86b4-3ed5-cab0-cb8412c8e22a@linaro.org>
References: <1fc67de6-86b4-3ed5-cab0-cb8412c8e22a@linaro.org>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <1fc67de6-86b4-3ed5-cab0-cb8412c8e22a@linaro.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git tags/thermal-v5.15-rc1
X-PR-Tracked-Commit-Id: 70ee251ded6ba24c15537f4abb8a318e233d0d1a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd4703876ea83b5fb5f4f0a1ec58f786143f5064
Message-Id: <163138141577.31565.16436849628627440728.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Sep 2021 17:30:15 +0000
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Sat, 11 Sep 2021 13:32:43 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git tags/thermal-v5.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd4703876ea83b5fb5f4f0a1ec58f786143f5064

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
