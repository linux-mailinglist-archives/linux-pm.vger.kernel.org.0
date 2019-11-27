Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9729F10B5F2
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 19:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfK0SpM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 13:45:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:57698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbfK0SpL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 Nov 2019 13:45:11 -0500
Subject: Re: [GIT PULL] power-supply changes for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574880311;
        bh=9Y6urMfo/WtH37ZXWaJG/+YOOHf7aheCluy0mcR+tss=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2rk+pg5KhVLxjKo8IhLk6tEwJQGdNAJC8D7AQs995hcNypWbgaTk5EQsVQxdsxqj5
         jy4MADYr2fWgIwq9ckPCrj18Uqbt16dulBsIHctjZqrR3Uq9R40ZwJrRif1Z+1TSX1
         Tn61QDFG4c03K2fRNHcfnmSPIXItYYNnlOYdrt6Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191126120940.sjiiqdngnbez2a7x@earth.universe>
References: <20191126120940.sjiiqdngnbez2a7x@earth.universe>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191126120940.sjiiqdngnbez2a7x@earth.universe>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
 tags/for-v5.5
X-PR-Tracked-Commit-Id: 9480029fe5c24d482efad38dc631bd555fc7afe2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 00074a7007c24f947a9f9baf66bf5db2fe651ee9
Message-Id: <157488031131.21185.10311186896979421766.pr-tracker-bot@kernel.org>
Date:   Wed, 27 Nov 2019 18:45:11 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Tue, 26 Nov 2019 13:09:40 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/00074a7007c24f947a9f9baf66bf5db2fe651ee9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
