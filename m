Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D273C3646
	for <lists+linux-pm@lfdr.de>; Sat, 10 Jul 2021 21:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhGJTLb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Jul 2021 15:11:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229599AbhGJTLa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 10 Jul 2021 15:11:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0AA9561356;
        Sat, 10 Jul 2021 19:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625944125;
        bh=b6DzQXZFI2jA9bLWkmCKhlPpRMpg1hht2O+OL+cH024=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ERLkhv4509tUThPm47nw9gU1QY3/EvXrMxjglpCE19crnCuqZzeivb9zOevVK4Adu
         cWBhsOqN0zMsZen+EbIWzbGLreY/I/ovMiY9tKDlO4+70sTENWYFubcA4T0D2DKfun
         n0ch477dd6dVvcd67SJaa8ymk/HYi26/XVQtSwcKiL4s8GvaAKJe2Si7mkJoUY3fqH
         NQAbvSaekrKlTsFqbERBoY8VIq/Tq83KV7W9a/1GgJA5PJjil5ZRDNPN1DLVJvWn9P
         K6zuUJkTRnFbcW07n7qrRFGEc9W8+RBAng1JeEQGdyMpBCLLi2mRZu6dlc4sRGsVbY
         S3LPRntQDS9iQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E9DC560986;
        Sat, 10 Jul 2021 19:08:44 +0000 (UTC)
Subject: Re: [GIT PULL] thermal for v5.14-rc1 #2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <8b2470a5-3090-87c3-0fad-d8eefdf54f4f@linaro.org>
References: <8b2470a5-3090-87c3-0fad-d8eefdf54f4f@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <8b2470a5-3090-87c3-0fad-d8eefdf54f4f@linaro.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git tags/thermal-v5.14-rc1
X-PR-Tracked-Commit-Id: fe6a6de6692e7f7159c1ff42b07ecd737df712b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f7ea4be434fe7ea38699d14c1192481899e6ac94
Message-Id: <162594412489.8052.12475027127622760227.pr-tracker-bot@kernel.org>
Date:   Sat, 10 Jul 2021 19:08:44 +0000
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Rajeshwari Ravindra Kamble <rkambl@codeaurora.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Finley Xiao <finley.xiao@rock-chips.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Thu, 8 Jul 2021 17:40:37 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git tags/thermal-v5.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f7ea4be434fe7ea38699d14c1192481899e6ac94

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
