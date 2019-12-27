Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7592312BACA
	for <lists+linux-pm@lfdr.de>; Fri, 27 Dec 2019 20:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfL0TpJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Dec 2019 14:45:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:47624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726927AbfL0TpJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 27 Dec 2019 14:45:09 -0500
Subject: Re: [GIT PULL] Power management fixes for v5.5-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577475908;
        bh=a5nNUZyjTg2XqJzc/piVF19fCap2VesQ+XY7ubonnn4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xJJ7cOjw1rSZXz4A8ujG3pVR2LrsHuVSvZA2MHJOU15Z2O8eoidTfD7BvwwZ4AXaP
         DoIXG4OptKgZ1Bzj9FkvsS/OELAQgNz5M93FNLtpgzWEveTCMp7B4i67hlFFjD0dAl
         KN+3aJgvwuF+XVZduU70BTS3Um/RhAMXBpfvR6Cw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i02hjtkXqxo=38XByY=G7LEDxdMbagAAvf207tSHXA2w@mail.gmail.com>
References: <CAJZ5v0i02hjtkXqxo=38XByY=G7LEDxdMbagAAvf207tSHXA2w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i02hjtkXqxo=38XByY=G7LEDxdMbagAAvf207tSHXA2w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.5-rc4
X-PR-Tracked-Commit-Id: 2cb7bfc1ca9a34ca148ed77f5f6f07373312bb0a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1413c361328c3ecd2cfe1e331f7b7d222d0712bc
Message-Id: <157747590843.1730.14734719713637284767.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Dec 2019 19:45:08 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 27 Dec 2019 11:21:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.5-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1413c361328c3ecd2cfe1e331f7b7d222d0712bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
