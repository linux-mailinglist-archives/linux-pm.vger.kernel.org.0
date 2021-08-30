Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A387D3FBD1F
	for <lists+linux-pm@lfdr.de>; Mon, 30 Aug 2021 21:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbhH3TrK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Aug 2021 15:47:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234067AbhH3TrJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Aug 2021 15:47:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0462C60F5B;
        Mon, 30 Aug 2021 19:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630352775;
        bh=cMjJxUaXv2i5f8X+Tyzv99TCeIXyXaopYNdOKYJc3Lw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Tx3IFoLMFxMk4PlKvyf6oQuTwn6B5ADypiIkBdVTdVuJhTXHd/T8S2TD2FUfXMe0p
         uVG1f3k002UjPxGQOzl5D0Vu8RMjdTp9lMyL8Zba7dX8kPH1qfqTmxSst/XiBqIKCa
         dPtcEt4m4mdjlifBCmaUVwfpN1tokDaVDtpGwTAG3fE2b7ycoYFjZP0WyXa8DWu3Kd
         A3p5m8yxbSHAWJN1jROuB5VYW66XVRKQ3ad1srZwu+fR9QW/YqCf/VhHKCvJBOed64
         1p48NuS97GBsNsSTJkxOqfa5ruTlOOH5zdRBKU47VLnlF6rHucfmEt/gqEEwSNdJge
         RCC+u3h+Rvftw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id F100E60A3C;
        Mon, 30 Aug 2021 19:46:14 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210827085220.yryb2prsgeaz7s6o@earth.universe>
References: <20210827085220.yryb2prsgeaz7s6o@earth.universe>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210827085220.yryb2prsgeaz7s6o@earth.universe>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.15
X-PR-Tracked-Commit-Id: c9398455b046fc7a44b6dd53d9d6fe4b11c21700
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4520dcbe0df41385288f24e61f322ee97063fa03
Message-Id: <163035277498.30336.15091820360246843774.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Aug 2021 19:46:14 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 27 Aug 2021 10:52:20 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4520dcbe0df41385288f24e61f322ee97063fa03

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
