Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368A933FABA
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 23:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhCQWBl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 18:01:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229720AbhCQWBM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Mar 2021 18:01:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id ADDAA64F17;
        Wed, 17 Mar 2021 22:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616018471;
        bh=KF1sgC+8zwymmGXKWZ/hLFtpL5NKhWBV4XXrxRghpaM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TQS9jrY9KpXR1QlaXtqcEPKs1Pz7fkdKvVG2ugB8JEP9yOskNadRYd+KUfbw3Plut
         NrjZS9eqsKHMNLs0VnnplQN6UsGPVB0aKnBV4FD8TcLH4HpWqr/kCkHwTEtQFIMThV
         s4y1gsSqPVSWkHDePXbmQYL16e4HuBxPwII2YqCz20CUrBTL7uj1RIn0bOJ3Pagkyx
         LaRPrdoZjqG+xu6KT7bhTACTuYXGwH413OQxV/uxGYZ2bw/gVNUV9fvHjhVWoFBm0m
         iqPdwwcGWoToUdm205H5IrgVsliuZp2QJMxwR2IqCtvjlY7YugEmaKarAX8Rrg7slI
         5vuojaCzhFaCg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id AA45260A45;
        Wed, 17 Mar 2021 22:01:11 +0000 (UTC)
Subject: Re: [GIT PULL] thermal fixes for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <64ffeeef-45de-6e0d-0ce9-767024d8dd22@linaro.org>
References: <64ffeeef-45de-6e0d-0ce9-767024d8dd22@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <64ffeeef-45de-6e0d-0ce9-767024d8dd22@linaro.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git tags/thermal-v5.12-rc4
X-PR-Tracked-Commit-Id: 2046a24ae121cd107929655a6aaf3b8c5beea01f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35d8c39d0e52f5230716f61910881b309e4b1a04
Message-Id: <161601847169.14556.1392745064561858202.pr-tracker-bot@kernel.org>
Date:   Wed, 17 Mar 2021 22:01:11 +0000
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Wed, 17 Mar 2021 10:02:51 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git tags/thermal-v5.12-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35d8c39d0e52f5230716f61910881b309e4b1a04

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
