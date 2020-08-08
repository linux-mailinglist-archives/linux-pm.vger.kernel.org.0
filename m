Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C5023F673
	for <lists+linux-pm@lfdr.de>; Sat,  8 Aug 2020 06:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725764AbgHHEfL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 8 Aug 2020 00:35:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgHHEfL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 8 Aug 2020 00:35:11 -0400
Subject: Re: [GIT PULL] power-supply changes for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596861311;
        bh=IMrjuCpsdyP5oCZ+1y62VktlR/0wPxRAWfr/HJGU2DQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KKNL+Y3krARnCXSOLJuTMYlyR+2nJugpBah1azc3qc2aTaFE0b5jrVxtg2Gluz6cP
         XruIncFPw1isUFh1J3MypwJGUY0IM5gBWITdXbu5ftSZa955qWdn9qTHWQIr3vTydn
         AJzsMhbt4uaHIO2Zt6I4G3rX3+e4tCN8D6jZIPZs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200807225943.cdfvw5m6h7ywgrmc@earth.universe>
References: <20200807225943.cdfvw5m6h7ywgrmc@earth.universe>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200807225943.cdfvw5m6h7ywgrmc@earth.universe>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.9
X-PR-Tracked-Commit-Id: 46cbd0b05799e8234b719d18f3a4b27679c4c92e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 449dc8c97089a6e09fb2dac4d92b1b7ac0eb7c1e
Message-Id: <159686131097.18048.11007151384031526188.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Aug 2020 04:35:10 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Sat, 8 Aug 2020 00:59:43 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/449dc8c97089a6e09fb2dac4d92b1b7ac0eb7c1e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
