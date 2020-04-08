Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8981A1A45
	for <lists+linux-pm@lfdr.de>; Wed,  8 Apr 2020 05:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgDHDUc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Apr 2020 23:20:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbgDHDUb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 Apr 2020 23:20:31 -0400
Subject: Re: [GIT PULL] thermal for v5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586316031;
        bh=7WBOgM1cgI5p/tgy/id+awwci1g6rSosB+R4u2ohnNo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iYXZoABMaanvifE7J7E/Ge3IA/lLXIRzYTUmZsy80LQ2n8wPrFvfjeur6ABdSQrbF
         JLLUeyD2sUkbno2f3GFEJPFwWUKDtEoCHDrDSMnK79iDDd762pk11qBnJaglXOnjpa
         H0GUdTwzLTqBbcqbZffk1BElJ+92PBFgbvZh5CKo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <49c5b834-362d-0569-32c5-76d366cb0a44@linaro.org>
References: <49c5b834-362d-0569-32c5-76d366cb0a44@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <49c5b834-362d-0569-32c5-76d366cb0a44@linaro.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
 tags/thermal-v5.7-rc1
X-PR-Tracked-Commit-Id: 11700fcb90b40a38fbfba55b2bedfc9909be8ec8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 34183ddd13dbfa859c4b68d16a30aad2cce72b11
Message-Id: <158631603120.18814.5786027121847312532.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Apr 2020 03:20:31 +0000
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Tue, 7 Apr 2020 13:26:48 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git tags/thermal-v5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/34183ddd13dbfa859c4b68d16a30aad2cce72b11

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
